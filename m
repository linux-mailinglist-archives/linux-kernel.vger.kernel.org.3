Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E253F466F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349989AbhLCB4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245595AbhLCBz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:55:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D276C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 17:52:35 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so2078798oto.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 17:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mMlMJcjWFiI2W1C5SLC/CCOWk/rtwKkTXW1CQZM02M=;
        b=vdZDqYWqqFPSHHnrXxQ/QouLOJQrts2O2q7uKSoiGjwDgCArLHicGCh4baJKAgFDAd
         8wsz01sIKQbZuABTqg6PwTDo4zXMT76ApuSQJ87S69wlEc+1jgZ/WdZdf2snuHo0GQ0E
         wdF49QMck7QD/ww8ZCyUomdYFYiKCsFATXgNOriFbUVNbdMg9KwBzPHQrvOdJOYxhsFl
         5AM4SWdSL0z+I+DJhx6AAWk/ZfaLSpXbv37fsdA9DpiOGt5KEyi2qBh8zKBY4TyrsitM
         H2x3h9jdn3G4uq9pmnpYZRGmfv8biU6jLg/+jJafHF5cQUtYCm63ll5SjVToOg7ewrxE
         Ksmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mMlMJcjWFiI2W1C5SLC/CCOWk/rtwKkTXW1CQZM02M=;
        b=kH90gjzKE5pNtLqOc36PLPUew+nq55F6jPCx7hNC8SK8n3qKa9nODVESVFVDOVwnG3
         s9cqx26x1+M7I6sipwkjoI789TKOB0BzeP4y3lVhfEqMQYmBYnSvwVsTol4K8IvmfAPV
         NJ3u+747gcWq5JWIyHj1iim9XABNoVGkjEEUmmMr8qil22dVuspkEuDfblpAHRDduEbS
         bn3h3nKbUgVvkGCxqFfJafCj0q364VChZy5Lx0C93UWqXtvP5aNZodB/MdDiDDrKedj2
         +KwCyph+XUwy2aEf2DvSMrenuP3rukNIuTBNy0t4HjQw78Y5OYPNczqqSiHcHSvZqV0Y
         Adiw==
X-Gm-Message-State: AOAM531yS6R2qZZQU1ikPffy6i1JjlwM6s4MQmHPv/y6M6zAApyYf5dc
        2Va1uLLENgYm3PHBg0flqN+lBA==
X-Google-Smtp-Source: ABdhPJxDEprfD0kGWyUVTAE4w3xRpccrCwQvCjeV/FWVKojpFKNxDvfWyALAionnLaK9K+JYbRGrow==
X-Received: by 2002:a9d:2605:: with SMTP id a5mr14557262otb.217.1638496354819;
        Thu, 02 Dec 2021 17:52:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12sm380940otk.35.2021.12.02.17.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 17:52:34 -0800 (PST)
Date:   Thu, 2 Dec 2021 19:52:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v7 10/12] rpmsg: char: Introduce the "rpmsg-raw" channel
Message-ID: <Yal4XcCVa6GAQYkG@builder.lan>
References: <20211108141937.13016-1-arnaud.pouliquen@foss.st.com>
 <20211108141937.13016-11-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108141937.13016-11-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Nov 08:19 CST 2021, Arnaud Pouliquen wrote:

> Allows to probe the endpoint device on a remote name service announcement,
> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
> 
> With this patch the /dev/rpmsgX interface can be instantiated by the remote
> firmware.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 64 ++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_ctrl.c |  7 +++--
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 6a01e8e1c111..dd754c870ba1 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -432,6 +432,58 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
> +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo;
> +	struct rpmsg_eptdev *eptdev;
> +	struct device *dev = &rpdev->dev;
> +
> +	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +	chinfo.src = rpdev->src;
> +	chinfo.dst = rpdev->dst;
> +
> +	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, dev);
> +	if (IS_ERR(eptdev))
> +		return PTR_ERR(eptdev);
> +
> +	/*
> +	 * Create the default endpoint associated to the rpmsg device and provide rpmsg_eptdev
> +	 * structure as callback private data.
> +	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
> +	 * reuse the default endpoint instead
> +	 */
> +	eptdev->default_ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, chinfo);
> +	if (!eptdev->default_ept) {
> +		dev_err(&rpdev->dev, "failed to create %s\n", chinfo.name);
> +		put_device(dev);

Which get_device() does this correlate to?

> +		kfree(eptdev);

After the device_initialize() in rpmsg_chrdev_eptdev_alloc() you're
supposed to put_device() &eptdev->dev, which would kfree(eptdev)...


Note though that rpmsg_eptdev_release_device() calls cdev_del(), which
you can't do. It was however recently reported that this cdev_del()
should be done in conjunction with the device_del() as the current
implementation enables a race between release and fops->open.

Regards,
Bjorn

> +		return -EINVAL;
> +	}
> +
> +	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
> +}
> +
> +static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> +{
> +	int ret;
> +
> +	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
> +	if (ret)
> +		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
> +}
> +
> +static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
> +	{ .name	= "rpmsg-raw" },
> +	{ },
> +};
> +
> +static struct rpmsg_driver rpmsg_chrdev_driver = {
> +	.probe = rpmsg_chrdev_probe,
> +	.remove = rpmsg_chrdev_remove,
> +	.id_table = rpmsg_chrdev_id_table,
> +	.drv.name = "rpmsg_chrdev",
> +};
> +
>  static int rpmsg_chrdev_init(void)
>  {
>  	int ret;
> @@ -442,12 +494,24 @@ static int rpmsg_chrdev_init(void)
>  		return ret;
>  	}
>  
> +	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
> +	if (ret < 0) {
> +		pr_err("rpmsg: failed to register rpmsg raw driver\n");
> +		goto free_region;
> +	}
> +
>  	return 0;
> +
> +free_region:
> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> +
> +	return ret;
>  }
>  postcore_initcall(rpmsg_chrdev_init);
>  
>  static void rpmsg_chrdev_exit(void)
>  {
> +	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>  	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  }
>  module_exit(rpmsg_chrdev_exit);
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 59d2bd264fdb..298e75dc7774 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -10,6 +10,9 @@
>   * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>   * was based on TI & Google OMX rpmsg driver.
>   */
> +
> +#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
> +
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
> @@ -193,13 +196,13 @@ static int rpmsg_ctrldev_init(void)
>  
>  	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
>  	if (ret < 0) {
> -		pr_err("rpmsg: failed to allocate char dev region\n");
> +		pr_err("failed to allocate char dev region\n");
>  		return ret;
>  	}
>  
>  	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
>  	if (ret < 0) {
> -		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
> +		pr_err("failed to register rpmsg driver\n");
>  		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  	}
>  
> -- 
> 2.17.1
> 
