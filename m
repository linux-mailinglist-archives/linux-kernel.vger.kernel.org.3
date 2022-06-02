Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68353B763
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiFBKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiFBKhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:37:04 -0400
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A5425D5E5;
        Thu,  2 Jun 2022 03:37:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08130035|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0585089-0.000138415-0.941353;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.NxvzAQ0_1654166207;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.NxvzAQ0_1654166207)
          by smtp.aliyun-inc.com(33.38.168.99);
          Thu, 02 Jun 2022 18:36:57 +0800
Message-ID: <f2e4f523-9d56-9b5d-cc8e-c9d2c3660996@allwinnertech.com>
Date:   Thu, 2 Jun 2022 18:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] usb: f_fs: Fix crash during gadget function switching
Content-Language: en-US
To:     John Keeping <john@metanate.com>
Cc:     quic_linyyuan@quicinc.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, axboe@kernel.dk,
        quic_pkondeti@quicinc.com, wcheng@codeaurora.org,
        quic_ugoswami@quicinc.com, andrew_gabbasov@mentor.com,
        plr.vincent@gmail.com, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
References: <20220510080105.126146-1-michael@allwinnertech.com>
 <YpUJkxWBNuZiW7Xk@donbot>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <YpUJkxWBNuZiW7Xk@donbot>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2022 2:14 AM, John Keeping wrote:
> On Tue, May 10, 2022 at 04:01:05PM +0800, Michael Wu wrote:
>> On arm64 android12 and possibly other platforms, during the usb gadget
>> function switching procedure (e.g. from mtp to midi), a synchronization
>> issue could occur, which causes an use-after-free panic as shown below:
> 
> I assume this is the path through ffs_epfile_io() with !io_data->aio.
> It looks like there is no check there for epfile->ep == ep which the
> other paths do check.
> 
> Does the patch below fix the problem without needing to add a new
> completion?
> 

Hi John,
Thanks for your suggestion. I've tested your patch and it did work -- 
When my issue occurs, (epfile->ep != ep) is satisfied, and the error is 
handled.

> -- >8 --
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1084,16 +1084,22 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>                           */
>                          usb_ep_dequeue(ep->ep, req);
>                          wait_for_completion(&done);
> -                       interrupted = ep->status < 0;
> +                       interrupted = true;
>                  }
>   
> -               if (interrupted)
> +               spin_lock_irq(&epfile->ffs->eps_lock);
> +               if (epfile->ep != ep)
> +                       ret = -ESHUTDOWN;
> +               else if (interrupted && ep->status < 0)
>                          ret = -EINTR;
> -               else if (io_data->read && ep->status > 0)
> -                       ret = __ffs_epfile_read_data(epfile, data, ep->status,
> -                                                    &io_data->data);
>                  else
>                          ret = ep->status;
> +               spin_unlock_irq(&epfile->ffs->eps_lock);
> +
> +               if (io_data->read && ret > 0)
> +                       ret = __ffs_epfile_read_data(epfile, data, ret,
> +                                                    &io_data->data);
> +
>                  goto error_mutex;
>          } else if (!(req = usb_ep_alloc_request(ep->ep, GFP_ATOMIC))) {
>                  ret = -ENOMEM;
Tested-by: Michael Wu <michael@allwinnertech.com>


I also tested Linyu's patch [1][2]. It also works.
Is there a preference on these solutions?


[1] 
https://lore.kernel.org/linux-usb/1654056916-2062-2-git-send-email-quic_linyyuan@quicinc.com/
[2] 
https://lore.kernel.org/linux-usb/1654056916-2062-3-git-send-email-quic_linyyuan@quicinc.com/


-- 
Regards,
Michael Wu
