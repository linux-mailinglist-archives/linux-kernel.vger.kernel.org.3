Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF594B9FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiBQMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:06:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBQMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:06:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B796577;
        Thu, 17 Feb 2022 04:05:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84EADB8216E;
        Thu, 17 Feb 2022 12:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CD2C340E8;
        Thu, 17 Feb 2022 12:05:43 +0000 (UTC)
Message-ID: <b452f7a7-99fa-e023-9120-639b4110de73@xs4all.nl>
Date:   Thu, 17 Feb 2022 13:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] media: hdpvr: call flush_work only if initialized
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217043950.749343-1-dzm91@hust.edu.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220217043950.749343-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 05:39, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> flush_work will throw one WARN if worker->func is NULL. So we should always
> initialize one worker before calling flush_work. When hdpvr_probe does not
> initialize its worker, the hdpvr_disconnect will encounter one WARN. The
> stack trace is in the following:
> 
>  hdpvr_disconnect+0xb8/0xf2 drivers/media/usb/hdpvr/hdpvr-core.c:425
>  usb_unbind_interface+0xbf/0x3a0 drivers/usb/core/driver.c:458
>  __device_release_driver drivers/base/dd.c:1206 [inline]
>  device_release_driver_internal+0x22a/0x230 drivers/base/dd.c:1237
>  bus_remove_device+0x108/0x160 drivers/base/bus.c:529
>  device_del+0x1fe/0x510 drivers/base/core.c:3592
>  usb_disable_device+0xd1/0x1d0 drivers/usb/core/message.c:1419
>  usb_disconnect+0x109/0x330 drivers/usb/core/hub.c:2228
> 
> Fix this by adding a sanity check of the worker before flush_work.
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/media/usb/hdpvr/hdpvr-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
> index 52e05a69c46e..d102b459d45d 100644
> --- a/drivers/media/usb/hdpvr/hdpvr-core.c
> +++ b/drivers/media/usb/hdpvr/hdpvr-core.c
> @@ -422,7 +422,8 @@ static void hdpvr_disconnect(struct usb_interface *interface)
>  	mutex_unlock(&dev->io_mutex);
>  	v4l2_device_disconnect(&dev->v4l2_dev);
>  	msleep(100);
> -	flush_work(&dev->worker);
> +	if (dev->worker.func)
> +		flush_work(&dev->worker);

I don't think this is the right fix. Instead, move the INIT_WORK line from
hdpvr_start_streaming() to hdpvr_register_videodev(). That should initialize
the worker struct from the start instead of only when you start streaming,
as is the case today.

Can you try that?

Regards,

	Hans

>  	mutex_lock(&dev->io_mutex);
>  	hdpvr_cancel_queue(dev);
>  	mutex_unlock(&dev->io_mutex);

