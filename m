Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32614831AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiACOGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:06:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiACOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:06:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B750FB80EEA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0FBC36AEB;
        Mon,  3 Jan 2022 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641218774;
        bh=sFpmXQ4D7WUWJn7Neb6X08knhaaOMyrWV937piA6e7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TadLBHXMTPUflQ7tAyW8B1LYOMcjMSVO5VXRTFAqo7P/9pkrcuW+B21fbF86I/MfJ
         mSr4lL6S2fr4scGw7y62JI7Yk95lcJ/qBIjy5LwazD9GaNWDcoj7xc2Ffjjz39y/mQ
         wu70vjxNDgny+inQQMLd+L70VGRoDXNhNLTCvb1U=
Date:   Mon, 3 Jan 2022 15:06:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     arnd@arndb.de, giometti@enneenne.com, linux-kernel@vger.kernel.org,
        thesven73@gmail.com, ojeda@kernel.org
Subject: Re: [RFC char-misc-next 2/2] pps: Fix use-after-free cdev bug on
 module unload
Message-ID: <YdMC07NTx7sTRKtI@kroah.com>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
 <bd7cb7db45c11f50495697ad23804a30a2e3b2d4.1641185192.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7cb7db45c11f50495697ad23804a30a2e3b2d4.1641185192.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 09:01:40PM -0800, Daniel Xu wrote:
> Previously, a use-after-free KASAN splat could be reliably triggered
> with:
> 
>     # insmod ./pps-ktimer.ko
>     # rmmod pps-ktimer.ko
>     <boom>
> 
> and CONFIG_DEBUG_KOBJECT_RELEASE=y.
> 
> This commit moves the driver to use cdev_alloc() instead of cdev_init()
> to decouple the lifetime of struct cdev from struct pps_device.
> 
> We also make use of the previous commit's new cdev->private field to
> store a pointer to the containing struct. We have to do this because
> container_of() does not work when we store a pointer to struct cdev.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  drivers/pps/pps.c          | 20 +++++++++++---------
>  include/linux/pps_kernel.h |  2 +-
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 22a65ad4e46e..97ce26f67806 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -298,8 +298,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
>  
>  static int pps_cdev_open(struct inode *inode, struct file *file)
>  {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = inode->i_cdev->private;

Why is this pointer now valid while the original structure that the cdev
lived in, not valid?  I do not think this really solves your problem,
only papers over the delay in removing the kobject that the config
option you enabled is trying to tell you is a problem.

>  	file->private_data = pps;
>  	kobject_get(&pps->dev->kobj);
>  	return 0;
> @@ -307,8 +306,7 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
>  
>  static int pps_cdev_release(struct inode *inode, struct file *file)
>  {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> +	struct pps_device *pps = inode->i_cdev->private;
>  	kobject_put(&pps->dev->kobj);
>  	return 0;
>  }
> @@ -332,7 +330,7 @@ static void pps_device_destruct(struct device *dev)
>  {
>  	struct pps_device *pps = dev_get_drvdata(dev);
>  
> -	cdev_del(&pps->cdev);
> +	cdev_del(pps->cdev);
>  
>  	/* Now we can release the ID for re-use */
>  	pr_debug("deallocating pps%d\n", pps->id);
> @@ -368,10 +366,14 @@ int pps_register_cdev(struct pps_device *pps)
>  
>  	devt = MKDEV(MAJOR(pps_devt), pps->id);
>  
> -	cdev_init(&pps->cdev, &pps_cdev_fops);
> -	pps->cdev.owner = pps->info.owner;
> +	pps->cdev = cdev_alloc();
> +	if (!pps->cdev)
> +		goto free_idr;
> +	pps->cdev->owner = pps->info.owner;
> +	pps->cdev->ops = &pps_cdev_fops;
> +	pps->cdev->private = pps;
>  
> -	err = cdev_add(&pps->cdev, devt, 1);
> +	err = cdev_add(pps->cdev, devt, 1);
>  	if (err) {
>  		pr_err("%s: failed to add char device %d:%d\n",
>  				pps->info.name, MAJOR(pps_devt), pps->id);
> @@ -393,7 +395,7 @@ int pps_register_cdev(struct pps_device *pps)
>  	return 0;
>  
>  del_cdev:
> -	cdev_del(&pps->cdev);
> +	cdev_del(pps->cdev);
>  
>  free_idr:
>  	mutex_lock(&pps_idr_lock);
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index 78c8ac4951b5..4e401793880f 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -56,7 +56,7 @@ struct pps_device {
>  
>  	unsigned int id;			/* PPS source unique ID */
>  	void const *lookup_cookie;		/* For pps_lookup_dev() only */
> -	struct cdev cdev;
> +	struct cdev *cdev;

So now who owns the lifecycle for the ppc_device structure?  You just
took it away from the cdev kobject, and replaced it with what?

thanks,

greg k-h
