Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58984474385
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhLNNcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhLNNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:32:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8DC061574;
        Tue, 14 Dec 2021 05:32:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CC36149A;
        Tue, 14 Dec 2021 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D13C34605;
        Tue, 14 Dec 2021 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488727;
        bh=vdlbmIXyP1SasGJYMT5H8cJXlEULAHAgUb/P9+UuUCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXW+4xDUJUW7TI4n4vXd+/6q+2MtPEvszbv+0r4lJ4ggJD2BxY5399gVFomxXDU7O
         VBMLn06/uVUc3K8tO1fK3gFpECIeU/Cz3Dh5Duk7lYM0GeMbu2pKdCovEiXKt+Bgmj
         7QTAPJtI2sBesxZ1/PY9tLu0DPtTEvNB++Cqmo2fuIEjVsqn4mdDMpdYwIWWxA5tMp
         d8k4gT696rP9M+raadr9F9IDMZq24kjPMNOOYHsTNC+psSIgiSWQG62zRSbFtz43K6
         ua8jssOe66TJLwkz+VHrdrdUsoKE9+pRuEQenhXDuPVT2nQMVmWCZo9y2knnIgy9Dp
         AUfMlvcIseilA==
Date:   Tue, 14 Dec 2021 14:32:04 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: msi2500: fix UAF in the msi2500_disconnect
Message-ID: <20211214143204.4b574351@coco.lan>
In-Reply-To: <20211116163208.75879-1-mudongliangabcd@gmail.com>
References: <20211116163208.75879-1-mudongliangabcd@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 17 Nov 2021 00:32:07 +0800
Dongliang Mu <mudongliangabcd@gmail.com> escreveu:

> In msi2500_probe, it invokes spi_alloc_master to allocate master
> controller and spi_register_master to register master controller.
> Then in msi2500_disconnect, it calls spi_unregister_master to unregister
> the master controller. And in spi_unregister_master, it calls put_device
> to decrease the refcount and the device object will be freed then. As a
> result, the dereference of dev->lock will cause a use-after-free bug.
> 
> Fix it by changing spi_alloc_master to devm_spi_alloc_master, and
> removing spi_master_put in the error handling code.
> 
> Note that this patch can prevent UAF occurring any more
> 
> Fixes: fd8b5f502929 ("msi2500: move msi3101 out of staging and rename")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/media/usb/msi2500/msi2500.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
> index 71de6b4c4e4c..64c3ec9f1d0c 100644
> --- a/drivers/media/usb/msi2500/msi2500.c
> +++ b/drivers/media/usb/msi2500/msi2500.c
> @@ -1220,7 +1220,7 @@ static int msi2500_probe(struct usb_interface *intf,
>  	}
>  
>  	/* SPI master adapter */
> -	master = spi_alloc_master(dev->dev, 0);
> +	master = devm_spi_alloc_master(dev->dev, 0);

We had some bad past experiences on using devm_* on USB media devices,
as there are almost always multiple drivers loaded and multiple
interfaces.

Could you please fix the free logic instead of using devm_*?

Regards,
Mauro

>  	if (master == NULL) {
>  		ret = -ENOMEM;
>  		goto err_unregister_v4l2_dev;
> @@ -1233,7 +1233,6 @@ static int msi2500_probe(struct usb_interface *intf,
>  	spi_master_set_devdata(master, dev);
>  	ret = spi_register_master(master);
>  	if (ret) {
> -		spi_master_put(master);
>  		goto err_unregister_v4l2_dev;
>  	}
>  



Thanks,
Mauro
