Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BE4AEB47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiBIHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiBIHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:40:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A8C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RONH3LdqiA5rh6tHpfYqqdeEDgKxGpKDEYVT3NN7P0=; b=uy0PujsPaGobeE/V9c5+LeSnAr
        A0wY/KEEosshS9nP5n3lsRCPXvGxJN07Hu7v54LOCtEYbL6Jhu5pP/PbBNrY4WlcP/1cLEgysqHWG
        1xr5GNsOkZ7nh8/FchXJTT2ftaUzovTN1/eZUUlUXolOqsqS3fDohQVwSwLnxZmlNpKL10FflFpen
        7InDgEWt/MdZiFK43ViZf+Zo/N0qscvk8BDe8WZxD4jGiR5o+jWodVJmzJckG/5EDCB7A8uYULVxr
        1FwJ66li1W4SG7FW8eJfEfmF5HLRAJwea7Q8PaiUqrHRin4ckbC35Boih0WnHG+MZxFyhvHf+hoj0
        3KDSvGwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHhaf-00GW8R-Bc; Wed, 09 Feb 2022 07:40:37 +0000
Date:   Tue, 8 Feb 2022 23:40:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref to improve
 performance
Message-ID: <YgNv9folAsgtGl5Z@infradead.org>
References: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644304760-11862-1-git-send-email-kanie@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:19:20PM +0800, Guixin Liu wrote:
> This patch includes a modification to repace mutex info_lock with
> percpu_ref, in order to improve uio performance.

What performance critical use case do you have for uio?  Everyone really
should be using vfio these days due to the large amount of shortcomings
in the uio interface.

> 
> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/uio/uio.c          | 95 ++++++++++++++++++++++++++++++++++------------
>  include/linux/uio_driver.h |  5 ++-
>  2 files changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 43afbb7..0cc0655 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -24,6 +24,8 @@
>  #include <linux/kobject.h>
>  #include <linux/cdev.h>
>  #include <linux/uio_driver.h>
> +#include <linux/completion.h>
> +#include <linux/percpu-refcount.h>
>  
>  #define UIO_MAX_DEVICES		(1U << MINORBITS)
>  
> @@ -218,7 +220,9 @@ static ssize_t name_show(struct device *dev,
>  	struct uio_device *idev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info) {
>  		ret = -EINVAL;
>  		dev_err(dev, "the device has been unregistered\n");
> @@ -228,7 +232,7 @@ static ssize_t name_show(struct device *dev,
>  	ret = sprintf(buf, "%s\n", idev->info->name);
>  
>  out:
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  	return ret;
>  }
>  static DEVICE_ATTR_RO(name);
> @@ -239,7 +243,9 @@ static ssize_t version_show(struct device *dev,
>  	struct uio_device *idev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info) {
>  		ret = -EINVAL;
>  		dev_err(dev, "the device has been unregistered\n");
> @@ -249,7 +255,7 @@ static ssize_t version_show(struct device *dev,
>  	ret = sprintf(buf, "%s\n", idev->info->version);
>  
>  out:
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  	return ret;
>  }
>  static DEVICE_ATTR_RO(version);
> @@ -489,16 +495,20 @@ static int uio_open(struct inode *inode, struct file *filep)
>  	listener->event_count = atomic_read(&idev->event);
>  	filep->private_data = listener;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref)) {
> +		ret = -EINVAL;
> +		goto err_infoopen;
> +	}
> +
>  	if (!idev->info) {
> -		mutex_unlock(&idev->info_lock);
> +		percpu_ref_put(&idev->info_ref);
>  		ret = -EINVAL;
>  		goto err_infoopen;
>  	}
>  
>  	if (idev->info->open)
>  		ret = idev->info->open(idev->info, inode);
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  	if (ret)
>  		goto err_infoopen;
>  
> @@ -531,10 +541,12 @@ static int uio_release(struct inode *inode, struct file *filep)
>  	struct uio_listener *listener = filep->private_data;
>  	struct uio_device *idev = listener->dev;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (idev->info && idev->info->release)
>  		ret = idev->info->release(idev->info, inode);
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  
>  	module_put(idev->owner);
>  	kfree(listener);
> @@ -548,10 +560,12 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
>  	struct uio_device *idev = listener->dev;
>  	__poll_t ret = 0;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info || !idev->info->irq)
>  		ret = -EIO;
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  
>  	if (ret)
>  		return ret;
> @@ -577,13 +591,17 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
>  	add_wait_queue(&idev->wait, &wait);
>  
>  	do {
> -		mutex_lock(&idev->info_lock);
> +		if (!percpu_ref_tryget_live(&idev->info_ref)) {
> +			retval = -EINVAL;
> +			break;
> +		}
> +
>  		if (!idev->info || !idev->info->irq) {
>  			retval = -EIO;
> -			mutex_unlock(&idev->info_lock);
> +			percpu_ref_put(&idev->info_ref);
>  			break;
>  		}
> -		mutex_unlock(&idev->info_lock);
> +		percpu_ref_put(&idev->info_ref);
>  
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> @@ -631,7 +649,9 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
>  	if (copy_from_user(&irq_on, buf, count))
>  		return -EFAULT;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info) {
>  		retval = -EINVAL;
>  		goto out;
> @@ -650,7 +670,7 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
>  	retval = idev->info->irqcontrol(idev->info, irq_on);
>  
>  out:
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  	return retval ? retval : sizeof(s32);
>  }
>  
> @@ -675,7 +695,9 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
>  	vm_fault_t ret = 0;
>  	int mi;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info) {
>  		ret = VM_FAULT_SIGBUS;
>  		goto out;
> @@ -702,8 +724,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
>  	vmf->page = page;
>  
>  out:
> -	mutex_unlock(&idev->info_lock);
> -
> +	percpu_ref_put(&idev->info_ref);
>  	return ret;
>  }
>  
> @@ -772,7 +793,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>  
>  	vma->vm_private_data = idev;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +
>  	if (!idev->info) {
>  		ret = -EINVAL;
>  		goto out;
> @@ -811,7 +834,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>  	}
>  
>   out:
> -	mutex_unlock(&idev->info_lock);
> +	percpu_ref_put(&idev->info_ref);
>  	return ret;
>  }
>  
> @@ -907,6 +930,13 @@ static void uio_device_release(struct device *dev)
>  	kfree(idev);
>  }
>  
> +static void uio_info_free(struct percpu_ref *ref)
> +{
> +	struct uio_device *idev = container_of(ref, struct uio_device, info_ref);
> +
> +	complete(&idev->free_done);
> +}
> +
>  /**
>   * __uio_register_device - register a new userspace IO device
>   * @owner:	module that creates the new device
> @@ -937,10 +967,17 @@ int __uio_register_device(struct module *owner,
>  
>  	idev->owner = owner;
>  	idev->info = info;
> -	mutex_init(&idev->info_lock);
>  	init_waitqueue_head(&idev->wait);
>  	atomic_set(&idev->event, 0);
>  
> +	ret = percpu_ref_init(&idev->info_ref, uio_info_free, 0, GFP_KERNEL);
> +	if (ret) {
> +		 pr_err("percpu_ref init failed!\n");
> +		 return ret;
> +	}
> +	init_completion(&idev->confirm_done);
> +	init_completion(&idev->free_done);
> +
>  	ret = uio_get_minor(idev);
>  	if (ret) {
>  		kfree(idev);
> @@ -1036,6 +1073,13 @@ int __devm_uio_register_device(struct module *owner,
>  }
>  EXPORT_SYMBOL_GPL(__devm_uio_register_device);
>  
> +static void uio_confirm_info(struct percpu_ref *ref)
> +{
> +	struct uio_device *idev = container_of(ref, struct uio_device, info_ref);
> +
> +	complete(&idev->confirm_done);
> +}
> +
>  /**
>   * uio_unregister_device - unregister a industrial IO device
>   * @info:	UIO device capabilities
> @@ -1052,14 +1096,17 @@ void uio_unregister_device(struct uio_info *info)
>  	idev = info->uio_dev;
>  	minor = idev->minor;
>  
> -	mutex_lock(&idev->info_lock);
> +	percpu_ref_kill_and_confirm(&idev->info_ref, uio_confirm_info);
> +	wait_for_completion(&idev->confirm_done);
> +	wait_for_completion(&idev->free_done);
> +
> +	/* now, we can set info to NULL */
>  	uio_dev_del_attributes(idev);
>  
>  	if (info->irq && info->irq != UIO_IRQ_CUSTOM)
>  		free_irq(info->irq, idev);
>  
>  	idev->info = NULL;
> -	mutex_unlock(&idev->info_lock);
>  
>  	wake_up_interruptible(&idev->wait);
>  	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
> diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
> index 47c5962..6d3d87f 100644
> --- a/include/linux/uio_driver.h
> +++ b/include/linux/uio_driver.h
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/interrupt.h>
> +#include <linux/percpu-refcount.h>
>  
>  struct module;
>  struct uio_map;
> @@ -74,9 +75,11 @@ struct uio_device {
>  	struct fasync_struct    *async_queue;
>  	wait_queue_head_t       wait;
>  	struct uio_info         *info;
> -	struct mutex		info_lock;
>  	struct kobject          *map_dir;
>  	struct kobject          *portio_dir;
> +	struct percpu_ref       info_ref;
> +	struct completion       confirm_done;
> +	struct completion       free_done;
>  };
>  
>  /**
> -- 
> 1.8.3.1
> 
---end quoted text---
