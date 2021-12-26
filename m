Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4761847F677
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 11:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLZKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 05:48:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59060 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhLZKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 05:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2DE8B80D90;
        Sun, 26 Dec 2021 10:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0D8C36AE8;
        Sun, 26 Dec 2021 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640515701;
        bh=oT5Ws33u+uEvkJirlO3cCP7788EMo7C6Sjn89G3yZxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCrymsSROHG//3ahbn2Fr7spa4n7j6sDBaFQ5X04atm8xV99RN9sVYhxSOaKkhKL7
         ItL08jszk2ALUaurden1T212VAdPGxdL/o4nf3TzF46VqWqDkh4QHHN7NFcDub2SBO
         zLb7rBSfHxtxPePIySjK94N2DPzwkca+gY+SySus=
Date:   Sun, 26 Dec 2021 11:48:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: add debugfs register access
Message-ID: <YchIco5UPJs1HiMM@kroah.com>
References: <20211221124221.2684214-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221124221.2684214-1-demonsingur@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:42:21PM +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Similar to IIO, create a device directory inside debugfs
> mount point, and create a direct_reg_access file inside
> that directory, if debugfs_reg_access callback is defined
> inside hwmon_ops.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  drivers/hwmon/hwmon.c | 122 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hwmon.h |  12 +++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 3501a3ead4ba..a3dc785cd885 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitops.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/gfp.h>
> @@ -35,6 +36,12 @@ struct hwmon_device {
>  	struct list_head tzdata;
>  	struct attribute_group group;
>  	const struct attribute_group **groups;
> +#if defined(CONFIG_DEBUG_FS)
> +	struct dentry *debugfs_dentry;

No need to keep this, just look it up when you want to remove it.

> +	unsigned int cached_reg_addr;
> +	char read_buf[20];
> +	unsigned int read_buf_len;
> +#endif
>  };
>  
>  #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
> @@ -64,6 +71,113 @@ struct hwmon_thermal_data {
>  	struct thermal_zone_device *tzd;/* thermal zone device */
>  };
>  
> +static struct dentry *hwmon_debugfs_dentry;
> +
> +#if defined(CONFIG_DEBUG_FS)
> +static ssize_t hwmon_debugfs_read_reg(struct file *file, char __user *userbuf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct hwmon_device *hwdev = file->private_data;
> +	struct device *hdev = &hwdev->dev;
> +	unsigned int val = 0;
> +	int ret;
> +
> +	if (*ppos > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       hwdev->read_buf,
> +					       hwdev->read_buf_len);
> +
> +	ret = hwdev->chip->ops->debugfs_reg_access(hdev, hwdev->cached_reg_addr,
> +						   0, &val);
> +	if (ret) {
> +		dev_err(hdev->parent, "%s: read failed\n", __func__);
> +		return ret;
> +	}
> +
> +	hwdev->read_buf_len = snprintf(hwdev->read_buf, sizeof(hwdev->read_buf),
> +				       "0x%X\n", val);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, hwdev->read_buf,
> +				       hwdev->read_buf_len);
> +}
> +
> +static ssize_t hwmon_debugfs_write_reg(struct file *file,
> +				       const char __user *userbuf,
> +				       size_t count, loff_t *ppos)
> +{
> +	struct hwmon_device *hwdev = file->private_data;
> +	struct device *hdev = &hwdev->dev;
> +	unsigned int reg, val;
> +	char buf[80];
> +	int ret;
> +
> +	count = min_t(size_t, count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, userbuf, count))
> +		return -EFAULT;
> +
> +	buf[count] = 0;
> +
> +	ret = sscanf(buf, "%i %i", &reg, &val);
> +
> +	switch (ret) {
> +	case 1:
> +		hwdev->cached_reg_addr = reg;
> +		break;
> +	case 2:
> +		hwdev->cached_reg_addr = reg;
> +		ret = hwdev->chip->ops->debugfs_reg_access(hdev, reg, val,
> +							   NULL);
> +		if (ret) {
> +			dev_err(hdev->parent, "%s: write failed\n", __func__);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations hwmon_debugfs_reg_fops = {
> +	.open = simple_open,
> +	.read = hwmon_debugfs_read_reg,
> +	.write = hwmon_debugfs_write_reg,
> +};
> +
> +static void hwmon_device_register_debugfs(struct hwmon_device *hwdev)
> +{
> +	if (IS_ERR(hwmon_debugfs_dentry))
> +		return;

Why check this?

> +
> +	if (!hwdev->chip || !hwdev->chip->ops ||
> +		!hwdev->chip->ops->debugfs_reg_access)
> +		return;
> +
> +	hwdev->debugfs_dentry = debugfs_create_dir(dev_name(&hwdev->dev),
> +						   hwmon_debugfs_dentry);
> +
> +	if (IS_ERR(hwdev->debugfs_dentry))
> +		return;

No need to check for this at all, just create the directory and move on.

thanks,

greg k-h
