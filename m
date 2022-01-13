Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96148D237
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiAMGGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:06:04 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45874 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbiAMGGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:06:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jkchen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1ihKZj_1642053960;
Received: from 30.225.24.127(mailfrom:jkchen@linux.alibaba.com fp:SMTPD_---0V1ihKZj_1642053960)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 14:06:01 +0800
Message-ID: <b021efc9-736d-7180-ccdf-c6ce7d745a83@linux.alibaba.com>
Date:   Thu, 13 Jan 2022 14:06:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RESEND PATCH] coresight: change tmc from misc device to cdev
 device
From:   Jiankang Chen <jkchen@linux.alibaba.com>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20220105023832.4729-1-jkchen@linux.alibaba.com>
In-Reply-To: <20220105023832.4729-1-jkchen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

在 2022/1/5 10:38, Jay Chen 写道:
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
>
> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> ---
>   .../hwtracing/coresight/coresight-tmc-core.c  | 91 +++++++++++++++----
>   drivers/hwtracing/coresight/coresight-tmc.h   | 11 ++-
>   2 files changed, 82 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index d0276af82494..55a131c059fe 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -12,7 +12,6 @@
>   #include <linux/io.h>
>   #include <linux/err.h>
>   #include <linux/fs.h>
> -#include <linux/miscdevice.h>
>   #include <linux/mutex.h>
>   #include <linux/property.h>
>   #include <linux/uaccess.h>
> @@ -31,6 +30,12 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>   DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>   DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>   
> +static DEFINE_IDA(tmc_ida);
> +static dev_t tmc_major;
> +static struct class *tmc_class;
> +
> +#define TMC_DEV_MAX	(MINORMASK + 1)
> +
>   void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>   {
>   	struct coresight_device *csdev = drvdata->csdev;
> @@ -147,7 +152,7 @@ static int tmc_open(struct inode *inode, struct file *file)
>   {
>   	int ret;
>   	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +		

I found a mistake in this place. I'll revise it again;

sorry

> 				   struct tmc_drvdata, cdev);
>   
>   	ret = tmc_read_prepare(drvdata);
>   	if (ret)
> @@ -179,7 +184,7 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>   	char *bufp;
>   	ssize_t actual;
>   	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +						   struct tmc_drvdata, cdev);
>   	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
>   	if (actual <= 0)
>   		return 0;
> @@ -200,7 +205,7 @@ static int tmc_release(struct inode *inode, struct file *file)
>   {
>   	int ret;
>   	struct tmc_drvdata *drvdata = container_of(file->private_data,
> -						   struct tmc_drvdata, miscdev);
> +						   struct tmc_drvdata, cdev);
>   
>   	ret = tmc_read_unprepare(drvdata);
>   	if (ret)
> @@ -451,6 +456,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>   {
>   	int ret = 0;
>   	u32 devid;
> +	dev_t devt;
>   	void __iomem *base;
>   	struct device *dev = &adev->dev;
>   	struct coresight_platform_data *pdata = NULL;
> @@ -546,14 +552,32 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>   		goto out;
>   	}
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
>   	if (ret)
> -		coresight_unregister(drvdata->csdev);
> -	else
> +		goto err_free_tmc_ida;
> +
> +	drvdata->cdev.dev = device_create(tmc_class, NULL, devt, &drvdata->cdev, desc.name);
> +	if (IS_ERR(drvdata->cdev.dev)) {
> +		ret = PTR_ERR(drvdata->cdev.dev);
> +		goto err_delete_cdev;
> +	} else
>   		pm_runtime_put(&adev->dev);
> +
> +	return 0;
> +
> +err_delete_cdev:
> +	cdev_del(&drvdata->cdev.cdev);
> +err_free_tmc_ida:
> +	ida_simple_remove(&tmc_ida, MINOR(devt));
> +err_coresight_unregister:
> +	coresight_unregister(drvdata->csdev);
>   out:
>   	return ret;
>   }
> @@ -583,13 +607,11 @@ static void tmc_shutdown(struct amba_device *adev)
>   static void tmc_remove(struct amba_device *adev)
>   {
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +	struct device *dev = drvdata->cdev.dev;
>   
> -	/*
> -	 * Since misc_open() holds a refcount on the f_ops, which is
> -	 * etb fops in this case, device is there until last file
> -	 * handler to this device is closed.
> -	 */
> -	misc_deregister(&drvdata->miscdev);
> +	ida_simple_remove(&tmc_ida, MINOR(dev->devt));
> +	device_destroy(tmc_class, dev->devt);
> +	cdev_del(&drvdata->cdev.cdev);
>   	coresight_unregister(drvdata->csdev);
>   }
>   
> @@ -618,7 +640,42 @@ static struct amba_driver tmc_driver = {
>   	.id_table	= tmc_ids,
>   };
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
> +		unregister_chrdev_region(tmc_major, TMC_DEV_MAX);
> +		return PTR_ERR(tmc_class);
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
>   MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>   MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6bec20a392b3..11441c6b9c26 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -7,9 +7,9 @@
>   #ifndef _CORESIGHT_TMC_H
>   #define _CORESIGHT_TMC_H
>   
> +#include <linux/cdev.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/idr.h>
> -#include <linux/miscdevice.h>
>   #include <linux/mutex.h>
>   #include <linux/refcount.h>
>   
> @@ -163,11 +163,16 @@ struct etr_buf {
>   	void				*private;
>   };
>   
> +struct tmc_cdev {
> +	struct cdev cdev;
> +	struct device *dev;
> +};
> +
>   /**
>    * struct tmc_drvdata - specifics associated to an TMC component
>    * @base:	memory mapped base address for this component.
>    * @csdev:	component vitals needed by the framework.
> - * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
> + * @tmc_cdev:	specifics to handle "/dev/xyz.tmc" entry.
>    * @spinlock:	only one at a time pls.
>    * @pid:	Process ID of the process being monitored by the session
>    *		that is using this component.
> @@ -191,7 +196,7 @@ struct etr_buf {
>   struct tmc_drvdata {
>   	void __iomem		*base;
>   	struct coresight_device	*csdev;
> -	struct miscdevice	miscdev;
> +	struct tmc_cdev		cdev;
>   	spinlock_t		spinlock;
>   	pid_t			pid;
>   	bool			reading;
