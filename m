Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33B51E908
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446745AbiEGSAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385126AbiEGSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:00:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB727E73
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:56:58 -0700 (PDT)
Received: (qmail 76931 invoked by uid 1000); 7 May 2022 13:56:57 -0400
Date:   Sat, 7 May 2022 13:56:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Schspa Shi <schspa@gmail.com>
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] usb: gadget: fix race when gadget driver register via
 ioctl
Message-ID: <Ynay6XK+ZUWtvfbH@rowland.harvard.edu>
References: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
 <20220507160243.35304-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507160243.35304-1-schspa@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 12:02:43AM +0800, Schspa Shi wrote:
> The usb_gadget_register_driver can be called multi time by to
> threads via USB_RAW_IOCTL_RUN ioctl syscall, which will lead
> to multiple registrations.
> 
> Call trace:
>   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>   usb_gadget_register_driver_owner+0xfb/0x1e0
>     drivers/usb/gadget/udc/core.c:1546
>   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>   ioctl USB_RAW_IOCTL_RUN
> 
> This routine allows two processes to register the same driver instance
> via ioctl syscall. which lead to a race condition.
> 
> We can fix it by adding a new STATE_DEV_REGISTERING device state to
> avoid double register.

Are you sure that this patch will fix the problem found by syzbot?  That 
is, are you sure that the problem really was caused by two threads 
registering the same driver concurrently?

The fact that the error was "use after free" suggests that the problem 
might be something else.  It looks like one of the threads was trying to 
access the driver structure after the other thread had done something 
that caused it to be deallocated, which suggests an error in reference 
counting.

Yes, this could be caused by two threads both registering the same 
driver.  But the evidence doesn't prove that this is what happened, as 
far as I can see.

Alan Stern

> Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index b3be8db1ff63..b75f8f7b7b46 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -146,6 +146,7 @@ enum dev_state {
>  	STATE_DEV_OPENED,
>  	STATE_DEV_INITIALIZED,
>  	STATE_DEV_RUNNING,
> +	STATE_DEV_REGISTERING,
>  	STATE_DEV_CLOSED,
>  	STATE_DEV_FAILED
>  };
> @@ -508,6 +509,7 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}
> +	dev->state = STATE_DEV_REGISTERING;
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  
>  	ret = usb_gadget_register_driver(&dev->driver);
> -- 
> 2.24.3 (Apple Git-128)
> 
