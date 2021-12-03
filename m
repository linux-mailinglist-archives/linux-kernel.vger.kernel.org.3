Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E290F466FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhLCC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhLCC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:28:48 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480EC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:25:25 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so2167644oto.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 18:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wk6sBqf4veTr0aCNaX77VD1RE59FNpZDowLejgif8qI=;
        b=S7AJ3XcfPHZkkOr8+PeptoEGXWMWzq4tdCtytBHda9yrH8e5oTvAfcAY69k0KVs3C4
         88i+mfHGkwgKhTNCMam2qB6YXTRpm6kbrhGPpZUdTcwOmjvUCo5c0r1r/RzL3Ec5PxKU
         1aBopvpJXVb0BaLcHELs3w3MnY5YSRmmLqFII2iXzHpC2U2RPtwEEDbbzKPhRv4TIubP
         126HGLLHhvouUnFT9R7K/1rOH1XglG9ZGQglz6wQSFiv5cn1XvqZWwcOQ6rqzXf1Vo5/
         TC7zzVuT4g0P5XCdPmdaJ6zcrJYps5HqECfv+pKD+UL171cTKnsyeJhcmpyCeOni/D++
         lqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wk6sBqf4veTr0aCNaX77VD1RE59FNpZDowLejgif8qI=;
        b=Qje1WRwEBrtQ0qUimq6l0aEsMbj18/10TF35R5+wFS/163/xFwQsXU1wF7cNMHYawY
         bdjGT56UQNDtOLHGA6MCPsOAyHWV2wmTQAKDuS/hBygwZqbGorgLXqmlpkJrEsk1f+wx
         XklcwpjUxtKoZ6Jki1HoXm7L7j2PWy6dnEbNTWyiHEBjjMxS7jpkNpb2TZR8kMIXJERK
         M0WaBir8+7OLE/E9zO+G6H+Wl6hzNMvGB1Be5esnh5VrfKKyxHPxPXk9qc4/h/725YC5
         a0uWdR2JJvD9auADzV2Jtoy6YLfUQLiGUklHDukMEpA0AjE0YKjjFYxf76VsSdlVM+Cu
         /HyQ==
X-Gm-Message-State: AOAM533iXyCKagDjLIrM2AcnIzW9OTP1rcQyqqQin33hAlY2UQGtJnmQ
        zoWo0SffYfl3gE/6lVG22rZvDA==
X-Google-Smtp-Source: ABdhPJxFGd1APJh95Fqq4Ks0VmjxljytjF4mqSrBVVfhyhbxJc2oh/Lv8kOmUNmuYYg5uDe6FL18HQ==
X-Received: by 2002:a9d:68d5:: with SMTP id i21mr13808630oto.107.1638498324258;
        Thu, 02 Dec 2021 18:25:24 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x8sm356390otg.31.2021.12.02.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 18:25:23 -0800 (PST)
Date:   Thu, 2 Dec 2021 20:25:18 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v7 03/12] rpmsg: Move the rpmsg control device from
 rpmsg_char to rpmsg_ctrl
Message-ID: <YamADnLb9MZd6SUU@builder.lan>
References: <20211108141937.13016-1-arnaud.pouliquen@foss.st.com>
 <20211108141937.13016-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108141937.13016-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Nov 08:19 CST 2021, Arnaud Pouliquen wrote:

> Create the rpmsg_ctrl.c module and move the code related to the
> rpmsg_ctrldev device in this new module.
> 
> Add the dependency between rpmsg_char and rpmsg_ctrl in the
> kconfig file:
> 
> 1) RPMSG_CTRL can set as module or built-in if
>   RPMSG=y || RPMSG_CHAR=y || RPMSG_CHAR=n
> 
> 2) RPMSG_CTRL can not be set as built-in if
>    RPMSG=m || RPMSG_CHAR=m
> 
> Note that RPMGH_CHAR and RPMSG_CTRL can be activated separately.
> Therefore, the RPMSG_CTRL configuration must be set for backwards compatibility.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> update vs previous version
>  - suppress the "select RPMSG_CTRL" for RPMSG_CHAR config
>  - add dependency on RPMSG_CHAR in RPMSG_CTRL to handle the use case
>    where RPMSG_CHAR is built as a module.
> ---
>  drivers/rpmsg/Kconfig      |   8 ++
>  drivers/rpmsg/Makefile     |   1 +
>  drivers/rpmsg/rpmsg_char.c | 167 +---------------------------
>  drivers/rpmsg/rpmsg_ctrl.c | 219 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 230 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/rpmsg/rpmsg_ctrl.c
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 0b4407abdf13..d3795860f5c0 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -15,6 +15,14 @@ config RPMSG_CHAR
>  	  in /dev. They make it possible for user-space programs to send and
>  	  receive rpmsg packets.
>  
> +config RPMSG_CTRL

Just for the record, I still am of the opinion that yet another Kconfig
option only adds unnecessary complexity.

Regards,
Bjorn

> +	tristate "RPMSG control interface"
> +	depends on RPMSG && ( RPMSG_CHAR || RPMSG_CHAR=n )
> +	help
> +	  Say Y here to enable the support of the /dev/rpmsg_ctrlX API. This API
> +	  allows user-space programs to create endpoints with specific service name,
> +	  source and destination addresses.
> +
>  config RPMSG_NS
>  	tristate "RPMSG name service announcement"
>  	depends on RPMSG
> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> index 8d452656f0ee..58e3b382e316 100644
> --- a/drivers/rpmsg/Makefile
> +++ b/drivers/rpmsg/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
>  obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
> +obj-$(CONFIG_RPMSG_CTRL)	+= rpmsg_ctrl.o
>  obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
>  obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
>  qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 8ab5ac23850c..29c4d2c3aea9 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -30,28 +30,12 @@
>  
>  static dev_t rpmsg_major;
>  
> -static DEFINE_IDA(rpmsg_ctrl_ida);
>  static DEFINE_IDA(rpmsg_ept_ida);
>  static DEFINE_IDA(rpmsg_minor_ida);
>  
>  #define dev_to_eptdev(dev) container_of(dev, struct rpmsg_eptdev, dev)
>  #define cdev_to_eptdev(i_cdev) container_of(i_cdev, struct rpmsg_eptdev, cdev)
>  
> -#define dev_to_ctrldev(dev) container_of(dev, struct rpmsg_ctrldev, dev)
> -#define cdev_to_ctrldev(i_cdev) container_of(i_cdev, struct rpmsg_ctrldev, cdev)
> -
> -/**
> - * struct rpmsg_ctrldev - control device for instantiating endpoint devices
> - * @rpdev:	underlaying rpmsg device
> - * @cdev:	cdev for the ctrl device
> - * @dev:	device for the ctrl device
> - */
> -struct rpmsg_ctrldev {
> -	struct rpmsg_device *rpdev;
> -	struct cdev cdev;
> -	struct device dev;
> -};
> -
>  /**
>   * struct rpmsg_eptdev - endpoint device context
>   * @dev:	endpoint device
> @@ -408,169 +392,22 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
> -static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
> -{
> -	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
> -
> -	get_device(&ctrldev->dev);
> -	filp->private_data = ctrldev;
> -
> -	return 0;
> -}
> -
> -static int rpmsg_ctrldev_release(struct inode *inode, struct file *filp)
> -{
> -	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
> -
> -	put_device(&ctrldev->dev);
> -
> -	return 0;
> -}
> -
> -static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
> -				unsigned long arg)
> -{
> -	struct rpmsg_ctrldev *ctrldev = fp->private_data;
> -	void __user *argp = (void __user *)arg;
> -	struct rpmsg_endpoint_info eptinfo;
> -	struct rpmsg_channel_info chinfo;
> -
> -	if (cmd != RPMSG_CREATE_EPT_IOCTL)
> -		return -EINVAL;
> -
> -	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
> -		return -EFAULT;
> -
> -	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
> -	chinfo.name[RPMSG_NAME_SIZE-1] = '\0';
> -	chinfo.src = eptinfo.src;
> -	chinfo.dst = eptinfo.dst;
> -
> -	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
> -};
> -
> -static const struct file_operations rpmsg_ctrldev_fops = {
> -	.owner = THIS_MODULE,
> -	.open = rpmsg_ctrldev_open,
> -	.release = rpmsg_ctrldev_release,
> -	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
> -	.compat_ioctl = compat_ptr_ioctl,
> -};
> -
> -static void rpmsg_ctrldev_release_device(struct device *dev)
> -{
> -	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
> -
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> -	cdev_del(&ctrldev->cdev);
> -	kfree(ctrldev);
> -}
> -
> -static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> -{
> -	struct rpmsg_ctrldev *ctrldev;
> -	struct device *dev;
> -	int ret;
> -
> -	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
> -	if (!ctrldev)
> -		return -ENOMEM;
> -
> -	ctrldev->rpdev = rpdev;
> -
> -	dev = &ctrldev->dev;
> -	device_initialize(dev);
> -	dev->parent = &rpdev->dev;
> -	dev->class = rpmsg_class;
> -
> -	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
> -	ctrldev->cdev.owner = THIS_MODULE;
> -
> -	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free_ctrldev;
> -	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
> -
> -	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free_minor_ida;
> -	dev->id = ret;
> -	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
> -
> -	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
> -	if (ret)
> -		goto free_ctrl_ida;
> -
> -	/* We can now rely on the release function for cleanup */
> -	dev->release = rpmsg_ctrldev_release_device;
> -
> -	ret = device_add(dev);
> -	if (ret) {
> -		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
> -		put_device(dev);
> -	}
> -
> -	dev_set_drvdata(&rpdev->dev, ctrldev);
> -
> -	return ret;
> -
> -free_ctrl_ida:
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> -free_minor_ida:
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> -free_ctrldev:
> -	put_device(dev);
> -	kfree(ctrldev);
> -
> -	return ret;
> -}
> -
> -static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> -{
> -	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
> -	int ret;
> -
> -	/* Destroy all endpoints */
> -	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
> -	if (ret)
> -		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
> -
> -	device_del(&ctrldev->dev);
> -	put_device(&ctrldev->dev);
> -}
> -
> -static struct rpmsg_driver rpmsg_chrdev_driver = {
> -	.probe = rpmsg_chrdev_probe,
> -	.remove = rpmsg_chrdev_remove,
> -	.drv = {
> -		.name = "rpmsg_chrdev",
> -	},
> -};
> -
>  static int rpmsg_chrdev_init(void)
>  {
>  	int ret;
>  
> -	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg");
> +	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_char");
>  	if (ret < 0) {
>  		pr_err("rpmsg: failed to allocate char dev region\n");
>  		return ret;
>  	}
>  
> -	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
> -	if (ret < 0) {
> -		pr_err("rpmsgchr: failed to register rpmsg driver\n");
> -		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> -	}
> -
> -	return ret;
> +	return 0;
>  }
>  postcore_initcall(rpmsg_chrdev_init);
>  
>  static void rpmsg_chrdev_exit(void)
>  {
> -	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>  	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  }
>  module_exit(rpmsg_chrdev_exit);
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> new file mode 100644
> index 000000000000..33c38cbf2b83
> --- /dev/null
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021, STMicroelectronics
> + * Copyright (c) 2016, Linaro Ltd.
> + * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2012, PetaLogix
> + * Copyright (c) 2011, Texas Instruments, Inc.
> + * Copyright (c) 2011, Google, Inc.
> + *
> + * Based on rpmsg performance statistics driver by Michal Simek, which in turn
> + * was based on TI & Google OMX rpmsg driver.
> + */
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/idr.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/rpmsg.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/rpmsg.h>
> +
> +#include "rpmsg_char.h"
> +#include "rpmsg_internal.h"
> +
> +#define RPMSG_DEV_MAX	(MINORMASK + 1)
> +
> +static dev_t rpmsg_major;
> +
> +static DEFINE_IDA(rpmsg_ctrl_ida);
> +static DEFINE_IDA(rpmsg_minor_ida);
> +
> +#define dev_to_ctrldev(dev) container_of(dev, struct rpmsg_ctrldev, dev)
> +#define cdev_to_ctrldev(i_cdev) container_of(i_cdev, struct rpmsg_ctrldev, cdev)
> +
> +/**
> + * struct rpmsg_ctrldev - control device for instantiating endpoint devices
> + * @rpdev:	underlaying rpmsg device
> + * @cdev:	cdev for the ctrl device
> + * @dev:	device for the ctrl device
> + */
> +struct rpmsg_ctrldev {
> +	struct rpmsg_device *rpdev;
> +	struct cdev cdev;
> +	struct device dev;
> +};
> +
> +static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
> +{
> +	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
> +
> +	get_device(&ctrldev->dev);
> +	filp->private_data = ctrldev;
> +
> +	return 0;
> +}
> +
> +static int rpmsg_ctrldev_release(struct inode *inode, struct file *filp)
> +{
> +	struct rpmsg_ctrldev *ctrldev = cdev_to_ctrldev(inode->i_cdev);
> +
> +	put_device(&ctrldev->dev);
> +
> +	return 0;
> +}
> +
> +static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
> +				unsigned long arg)
> +{
> +	struct rpmsg_ctrldev *ctrldev = fp->private_data;
> +	void __user *argp = (void __user *)arg;
> +	struct rpmsg_endpoint_info eptinfo;
> +	struct rpmsg_channel_info chinfo;
> +
> +	if (cmd != RPMSG_CREATE_EPT_IOCTL)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
> +		return -EFAULT;
> +
> +	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
> +	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
> +	chinfo.src = eptinfo.src;
> +	chinfo.dst = eptinfo.dst;
> +
> +	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
> +};
> +
> +static const struct file_operations rpmsg_ctrldev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = rpmsg_ctrldev_open,
> +	.release = rpmsg_ctrldev_release,
> +	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +};
> +
> +static void rpmsg_ctrldev_release_device(struct device *dev)
> +{
> +	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
> +
> +	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> +	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	cdev_del(&ctrldev->cdev);
> +	kfree(ctrldev);
> +}
> +
> +static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_ctrldev *ctrldev;
> +	struct device *dev;
> +	int ret;
> +
> +	ctrldev = kzalloc(sizeof(*ctrldev), GFP_KERNEL);
> +	if (!ctrldev)
> +		return -ENOMEM;
> +
> +	ctrldev->rpdev = rpdev;
> +
> +	dev = &ctrldev->dev;
> +	device_initialize(dev);
> +	dev->parent = &rpdev->dev;
> +	dev->class = rpmsg_class;
> +
> +	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
> +	ctrldev->cdev.owner = THIS_MODULE;
> +
> +	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
> +	if (ret < 0)
> +		goto free_ctrldev;
> +	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
> +
> +	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto free_minor_ida;
> +	dev->id = ret;
> +	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
> +
> +	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
> +	if (ret)
> +		goto free_ctrl_ida;
> +
> +	/* We can now rely on the release function for cleanup */
> +	dev->release = rpmsg_ctrldev_release_device;
> +
> +	ret = device_add(dev);
> +	if (ret) {
> +		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
> +		put_device(dev);
> +	}
> +
> +	dev_set_drvdata(&rpdev->dev, ctrldev);
> +
> +	return ret;
> +
> +free_ctrl_ida:
> +	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> +free_minor_ida:
> +	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +free_ctrldev:
> +	put_device(dev);
> +	kfree(ctrldev);
> +
> +	return ret;
> +}
> +
> +static void rpmsg_ctrldev_remove(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
> +	int ret;
> +
> +	/* Destroy all endpoints */
> +	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
> +	if (ret)
> +		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
> +
> +	device_del(&ctrldev->dev);
> +	put_device(&ctrldev->dev);
> +}
> +
> +static struct rpmsg_driver rpmsg_ctrldev_driver = {
> +	.probe = rpmsg_ctrldev_probe,
> +	.remove = rpmsg_ctrldev_remove,
> +	.drv = {
> +		.name = "rpmsg_chrdev",
> +	},
> +};
> +
> +static int rpmsg_ctrldev_init(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg_ctrl");
> +	if (ret < 0) {
> +		pr_err("rpmsg: failed to allocate char dev region\n");
> +		return ret;
> +	}
> +
> +	ret = register_rpmsg_driver(&rpmsg_ctrldev_driver);
> +	if (ret < 0) {
> +		pr_err("rpmsg ctrl: failed to register rpmsg driver\n");
> +		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> +	}
> +
> +	return ret;
> +}
> +postcore_initcall(rpmsg_ctrldev_init);
> +
> +static void rpmsg_ctrldev_exit(void)
> +{
> +	unregister_rpmsg_driver(&rpmsg_ctrldev_driver);
> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> +}
> +module_exit(rpmsg_ctrldev_exit);
> +
> +MODULE_DESCRIPTION("rpmsg control interface");
> +MODULE_ALIAS("rpmsg:" KBUILD_MODNAME);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
