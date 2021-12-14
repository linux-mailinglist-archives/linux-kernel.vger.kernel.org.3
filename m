Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB94745EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhLNPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:05:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33628 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhLNPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C46DFB81A34;
        Tue, 14 Dec 2021 15:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78956C34606;
        Tue, 14 Dec 2021 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494218;
        bh=oCBk+mGt99XcZ4/jJejvVk9Y6BqK9SVRacIVgVA9myI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fmAFbSv7CwFHhyvSbVLYwb0Wd/P7Q0b8ZchksPtb6z9Txpct617A61yF7uCJRwdXY
         yL9MQptvcB127vasL2aSmbnmQHyWAotZbT7+1+vC2f4SLqRtPMXjBZBS65VoltUMV1
         enJNVzIRu5a6c0LXWrjMWTkkHDLJIwlY0iHGN7BTX5gMdoDPkMCZ4FiwwEwvFkDH57
         ewV8oNkBvcEuH2aFVxSfmQQOwErre7uBkgoJr5JmePWqMjLaBJC90vQJXO6ktvBww1
         UzV6zchW3bgH2IZAPvWodZ8ynxCBZw4PH+niNvTwSMzubbIVDJkejSvNblAUeRPDR8
         UvMI38PPJRv9g==
Date:   Tue, 14 Dec 2021 16:03:34 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     crope@iki.fi, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: usb: dvb-usb-v2: check the return value of
 kstrdup()
Message-ID: <20211214160334.6e493a32@coco.lan>
In-Reply-To: <tencent_07FF16C8253370EE140700057438B052FD06@qq.com>
References: <tencent_07FF16C8253370EE140700057438B052FD06@qq.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 13 Dec 2021 15:48:33 +0800
Xiaoke Wang <xkernel.wang@foxmail.com> escreveu:

> Note: Compare with the last email, this one is using my full name.
> kstrdup() returns NULL if some internal memory errors happen, it is
> better to check the return value of it. Since the return type of
> dvb_usbv2_disconnect() is void, so only raise the error info.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
> index f1c79f3..a43a310 100644
> --- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
> +++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
> @@ -1009,6 +1009,9 @@ void dvb_usbv2_disconnect(struct usb_interface *intf)
>  	const char *devname = kstrdup(dev_name(&d->udev->dev), GFP_KERNEL);
>  	const char *drvname = d->name;
>  
> +	if (!devname)
> +		dev_err(&d->udev->dev, "%s: kstrdup() failed\n", KBUILD_MODNAME);
> +

Don't use KBUILD_MODNAME, as dev_err will already add the driver/device's
name.

>  	dev_dbg(&d->udev->dev, "%s: bInterfaceNumber=%d\n", __func__,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  
> @@ -1023,9 +1026,14 @@ void dvb_usbv2_disconnect(struct usb_interface *intf)
>  	kfree(d->priv);
>  	kfree(d);
>  
> -	pr_info("%s: '%s:%s' successfully deinitialized and disconnected\n",
> -		KBUILD_MODNAME, drvname, devname);

Better to use:
	dev_dbg(&d->udev->dev, "successfully deinitialized and disconnected\n");

> -	kfree(devname);

No need to place kfree() inside an if, as kfree(NULL) is safe.

> +	if (devname) {
> +		pr_info("%s: '%s:%s' successfully deinitialized and disconnected\n",
> +			KBUILD_MODNAME, drvname, devname);
> +		kfree(devname);
> +	} else {
> +		pr_info("%s: '%s:UNKNOWN' successfully deinitialized and disconnected\n",
> +			KBUILD_MODNAME, drvname);
> +	}
>  }
>  EXPORT_SYMBOL(dvb_usbv2_disconnect);
> 

Thanks,
Mauro
