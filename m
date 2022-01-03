Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67DA4836D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiACS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiACS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:28:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436BBC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:28:53 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v13so30130533pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ebUaWKkiUoUBpOUI2L6s3xw5pYEkhNTdy0Gt4DsKEo=;
        b=EInzPpPMQczA8K5YyRs9JObL5wozNuo9BGJRzrYd0qETrUpCQwpaEhlE246CPK98P8
         SrQv5AdyrLt28oua6YnaFEUxUGne6Mn4nlOnSm5zSFnVJRsKiNVSL1vj8UELkyJuLmoG
         DvwNKbZdTnNOTpWRWRNfsjbf23YynBvHfKSDfA12HkNaPTkPY4iK5a0VCGrTadUWGJWR
         VRvjXN+snsEDGcCqmVT3SDHpf1IX54N0INiekVhbK/eZrfvFt2FpHoShttg8zkFYADxO
         ki8riqVdwl/yDJzMXqgTyqgT1+wyTbj4OFhwyJ/aNWd0IAxPw16O+Ok3uNa0zNDttTjD
         fSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ebUaWKkiUoUBpOUI2L6s3xw5pYEkhNTdy0Gt4DsKEo=;
        b=UUUcwP4ZvrzCWWuYNQKFq5lIlBdhJ+iuJZo0+jGIstSa78k51DBj3LxPabSDf+hqFH
         Cu4EfQMl1YbTChFvejiJ/S0cVMLoVW1VNwHHjnp4cNmHlgxYRJgKFuaGlcAU2Vi14APr
         JNUr/EkXcD9zgRbX0OfWq5yYFASjFoGxWMQw6P/tVn33FHWC2FhUlUXhIa16bsgTEud4
         qWQ86srZd1gQMIYjwOs6ej49uPTkNJ15C9iCm+WCUi/HHtmPSpjcykBM9cRbGAB/cXGC
         A3h07rHXmW8sVGLagmmurbBrSr/kaj/lJU5omLhqfzpW87XJlAGcW1MLSOBL9YeZkTQp
         qMcQ==
X-Gm-Message-State: AOAM532hPbwqatK7Gc2ouFcWlNv1M90tE0sJqtpbskUyyfliIhkdzP3V
        b+gtZFkKOa2Mws9K5XQUW+7tzw==
X-Google-Smtp-Source: ABdhPJyPtZSDzrhpI8isOgO6HrnDmlWAuacj4d8nFCwmawdbgLzhrf0bxOFT+tqq0YuoUcZdQuSFSQ==
X-Received: by 2002:a63:804a:: with SMTP id j71mr41222039pgd.72.1641234532544;
        Mon, 03 Jan 2022 10:28:52 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id on2sm42543914pjb.19.2022.01.03.10.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 10:28:50 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:28:48 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jay Chen <jkchen@linux.alibaba.com>
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, zhangliguang@linux.alibaba.com
Subject: Re: [RFC V3 PATCH] coresight: change tmc from misc device to cdev
 device
Message-ID: <20220103182848.GA398730@p14s>
References: <20211221120437.4781-1-jkchen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221120437.4781-1-jkchen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Jay,

For your next iteration, please remove the "RFC" from the patch title, we are
well pass that now.

On Tue, Dec 21, 2021 at 08:04:37PM +0800, Jay Chen wrote:
> Currently, there are 130 etr and etf on our machine,
> but the current coresight tmc driver uses misc_register
> to register the device, which leads to the error that
> the device number is not enough.
> 
> coresight-tmc: probe of xxxxx failed with error -16
> 
> This patch changes the device registration method
> to cdev's dynamic registration method to solve the
> problem of insufficient device numbers.

This is much better.

> 
> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-core.c  | 91 +++++++++++++++----
>  drivers/hwtracing/coresight/coresight-tmc.h   | 10 +-
>  2 files changed, 83 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index d0276af82494..0d51071e9f88 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -31,6 +31,12 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>  DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>  DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>  
> +static DEFINE_IDA(tmc_ida);
> +static dev_t tmc_major;
> +static struct class *tmc_class;
> +
> +#define TMC_DEV_MAX	(MINORMASK + 1)
> +
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>  	struct coresight_device *csdev = drvdata->csdev;
> @@ -147,7 +153,7 @@ static int tmc_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +						   struct tmc_drvdata, cdev);
>  
>  	ret = tmc_read_prepare(drvdata);
>  	if (ret)
> @@ -179,7 +185,7 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>  	char *bufp;
>  	ssize_t actual;
>  	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +						   struct tmc_drvdata, cdev);
>  	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
>  	if (actual <= 0)
>  		return 0;
> @@ -200,7 +206,7 @@ static int tmc_release(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +						   struct tmc_drvdata, cdev);
>  
>  	ret = tmc_read_unprepare(drvdata);
>  	if (ret)
> @@ -451,6 +457,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>  	int ret = 0;
>  	u32 devid;
> +	dev_t devt;
>  	void __iomem *base;
>  	struct device *dev = &adev->dev;
>  	struct coresight_platform_data *pdata = NULL;
> @@ -546,14 +553,32 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> -	drvdata->miscdev.name = desc.name;
> -	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
> -	drvdata->miscdev.fops = &tmc_fops;
> -	ret = misc_register(&drvdata->miscdev);
> +	ret = ida_simple_get(&tmc_ida, 0, TMC_DEV_MAX, GFP_KERNEL);
> +	if (ret < 0)
> +		goto err_coresight_unregister;
> +
> +	cdev_init(&drvdata->cdev.cdev, &tmc_fops);
> +	drvdata->cdev.cdev.owner = THIS_MODULE;
> +	devt = MKDEV(MAJOR(tmc_major), ret);
> +	ret = cdev_add(&drvdata->cdev.cdev, devt, 1);
>  	if (ret)
> -		coresight_unregister(drvdata->csdev);
> -	else
> +		goto err_free_tmc_ida;
> +
> +	drvdata->cdev.dev = device_create(tmc_class, NULL, devt, &drvdata->cdev, desc.name);
> +	if (IS_ERR(drvdata->cdev.dev)) {
> +		ret = PTR_ERR(drvdata->cdev.dev);
> +		goto err_delete_cdev;
> +	} else
>  		pm_runtime_put(&adev->dev);
> +
> +	return 0;
> +
> +err_delete_cdev:
> +	cdev_del(&drvdata->cdev.cdev);
> +err_free_tmc_ida:
> +	ida_simple_remove(&tmc_ida, MINOR(devt));
> +err_coresight_unregister:
> +	coresight_unregister(drvdata->csdev);
>  out:
>  	return ret;
>  }
> @@ -583,13 +608,11 @@ static void tmc_shutdown(struct amba_device *adev)
>  static void tmc_remove(struct amba_device *adev)
>  {
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +	struct device *dev = drvdata->cdev.dev;
>  
> -	/*
> -	 * Since misc_open() holds a refcount on the f_ops, which is
> -	 * etb fops in this case, device is there until last file
> -	 * handler to this device is closed.
> -	 */
> -	misc_deregister(&drvdata->miscdev);
> +	ida_simple_remove(&tmc_ida, dev->devt);

	ida_simple_remove(&tmc_ida, MINOR(dev->devt));

> +	device_destroy(tmc_class, dev->devt);
> +	cdev_del(&drvdata->cdev.cdev);
>  	coresight_unregister(drvdata->csdev);
>  }
>  
> @@ -618,7 +641,43 @@ static struct amba_driver tmc_driver = {
>  	.id_table	= tmc_ids,
>  };
>  
> -module_amba_driver(tmc_driver);
> +static int __init tmc_init(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&tmc_major, 0, TMC_DEV_MAX, "tmc");
> +	if (ret < 0) {
> +		pr_err("tmc: failed to allocate char dev region\n");
> +		return ret;
> +	}
> +
> +	tmc_class = class_create(THIS_MODULE, "tmc");
> +	if (IS_ERR(tmc_class)) {
> +		pr_err("tmc: failed to create class\n");
> +		ret = PTR_ERR(tmc_class);
> +		unregister_chrdev_region(tmc_major, TMC_DEV_MAX);
> +		return ret;

You can simply return PTR_ERR(tmc_class)...

> +	}
> +
> +	ret = amba_driver_register(&tmc_driver);
> +	if (ret) {
> +		pr_err("tmc: error registering amba driver\n");
> +		class_destroy(tmc_class);
> +		unregister_chrdev_region(tmc_major, TMC_DEV_MAX);
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit tmc_exit(void)
> +{
> +	amba_driver_unregister(&tmc_driver);
> +	class_destroy(tmc_class);
> +	unregister_chrdev_region(tmc_major, TMC_DEV_MAX);
> +}
> +
> +module_init(tmc_init);
> +module_exit(tmc_exit);
>  
>  MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>  MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6bec20a392b3..b65ac363f9e4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -7,6 +7,7 @@
>  #ifndef _CORESIGHT_TMC_H
>  #define _CORESIGHT_TMC_H
>  
> +#include <linux/cdev.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/idr.h>
>  #include <linux/miscdevice.h>

miscdevice.h can likely be removed in both .c and .h files.

Thanks,
Mathieu

> @@ -163,11 +164,16 @@ struct etr_buf {
>  	void				*private;
>  };
>  
> +struct tmc_cdev {
> +	struct cdev cdev;
> +	struct device *dev;
> +};
> +
>  /**
>   * struct tmc_drvdata - specifics associated to an TMC component
>   * @base:	memory mapped base address for this component.
>   * @csdev:	component vitals needed by the framework.
> - * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
> + * @tmc_cdev:	specifics to handle "/dev/xyz.tmc" entry.
>   * @spinlock:	only one at a time pls.
>   * @pid:	Process ID of the process being monitored by the session
>   *		that is using this component.
> @@ -191,7 +197,7 @@ struct etr_buf {
>  struct tmc_drvdata {
>  	void __iomem		*base;
>  	struct coresight_device	*csdev;
> -	struct miscdevice	miscdev;
> +	struct tmc_cdev		cdev;
>  	spinlock_t		spinlock;
>  	pid_t			pid;
>  	bool			reading;
> -- 
> 2.27.0
> 
