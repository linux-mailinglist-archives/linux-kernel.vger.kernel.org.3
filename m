Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCF535A93
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbiE0HiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347965AbiE0HiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:38:04 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 00:38:01 PDT
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA2832EF2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:38:01 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id uUWnnv5ojPF2euUWonSDZm; Fri, 27 May 2022 09:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1653637019; bh=9m8PWiplWqc8fhBbjEa1jbrDQ3eBFjsCCd+tIXGM9jU=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=lhtLDKW/CIB+x6eXzVWgsrjsqbXuEpXe0a/GGwYxQDfMIhetOxiNFuT4rFRiQmotu
         BnQ2NyaYTyW9NzsBcGnKq5oLzmnp8xCYwQ3PPRE72uuShQTSZ6PK9H9aw93jrpGpM4
         3tybIt/aMw1lrRNOV/u+5vQehk+wzpnaFKe8sU7+jeU/g+YHPYZLXixHNK4p2ReC8z
         z8eG0YGvG1u9DRafMU9kIKE/51lFdPYctFQwezyCZ60e9DnKcLY4wCmg/jEK6lOFGa
         tgW8atnOnIYtrmYj8qMl3N032rP3zRLXCxbz985cQ2LLvGrVWV0TPyMiF7KKYUITXc
         K9HCdTnbZ+UAw==
Message-ID: <98e236c5-fe7e-51bf-3817-2aa721fe79bc@enneenne.com>
Date:   Fri, 27 May 2022 09:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] pps: clients: Directly use ida_alloc()/free()
Content-Language: en-US
To:     keliu <liuke94@huawei.com>, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
References: <20220527072520.2374615-1-liuke94@huawei.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20220527072520.2374615-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMhSGK3GclRvkLVKhOgOOUjAZHnB2831GNoZMz5vI0bLr4xLHXYjWH+qMG2167U7CMPlnBN+754UAP1IjThi84qdJjx0MXuh56mspf+r9LwXLPbuG+bd
 nsiWhhLSExSDFbif44nt0sHRVJ5lZSpoT2wjP57P2qX6Iy14mcNB63txv7jEbpDVmsyN7YXuy/PU7EMp85n6Sd1rFZiPtkgNsgoU9aX0/OSveRThWJRioKsY
 UZqhthlt/a3Rv2cf/h2lm75KglSwJlP66SPHHp48VJkU91B90Vfd58eXVRFMoNCEETZlfIJ/NtiHg3h6T4E+Iw==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/22 09:25, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/clients/pps_parport.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> index 42f93d4c6ee3..af972cdc04b5 100644
> --- a/drivers/pps/clients/pps_parport.c
> +++ b/drivers/pps/clients/pps_parport.c
> @@ -148,7 +148,7 @@ static void parport_attach(struct parport *port)
>   		return;
>   	}
>   
> -	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
> +	index = ida_alloc(&pps_client_index, GFP_KERNEL);
>   	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
>   	pps_client_cb.private = device;
>   	pps_client_cb.irq_func = parport_irq;
> @@ -188,7 +188,7 @@ static void parport_attach(struct parport *port)
>   err_unregister_dev:
>   	parport_unregister_device(device->pardev);
>   err_free:
> -	ida_simple_remove(&pps_client_index, index);
> +	ida_free(&pps_client_index, index);
>   	kfree(device);
>   }
>   
> @@ -208,7 +208,7 @@ static void parport_detach(struct parport *port)
>   	pps_unregister_source(device->pps);
>   	parport_release(pardev);
>   	parport_unregister_device(pardev);
> -	ida_simple_remove(&pps_client_index, device->index);
> +	ida_free(&pps_client_index, device->index);
>   	kfree(device);
>   }
>   

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
