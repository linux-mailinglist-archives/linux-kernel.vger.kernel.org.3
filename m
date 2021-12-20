Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFE47A597
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhLTIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLTIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E75C061574;
        Mon, 20 Dec 2021 00:00:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D573960C68;
        Mon, 20 Dec 2021 08:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DE2C36AE8;
        Mon, 20 Dec 2021 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639987205;
        bh=fcz+BuUD2epOEdHOXLoW8PHlERf4bmPodfJclgh0BvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MypVno4jJhz3hJeIrN9FP27HIGgbzPDeDQO8Oj44ml51Y35UJ1K7r0Yqr92XYczLG
         fKbVwrV6MTl40KBB7iRGpJXQXFAmEG8szH5QjyJj5Pl54CHBfNVUCXM2w/5lsRhmNc
         5UzsX0uxWmQiRvUKUN4wOHbn4+O6clra7NZjAbHQ=
Date:   Mon, 20 Dec 2021 09:00:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Message-ID: <YcA4ArALDTjUedrb@kroah.com>
References: <20211220064730.28806-1-zajec5@gmail.com>
 <20211220064730.28806-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220064730.28806-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This allows reading NVMEM cells using /sys/bus/nvmem/devices/*/cells/*
> which may be helpful for userspace & debugging purposes.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/driver-api/nvmem.rst | 11 ++++++
>  drivers/nvmem/core.c               | 60 ++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
> index 287e86819640..20f7d68143be 100644
> --- a/Documentation/driver-api/nvmem.rst
> +++ b/Documentation/driver-api/nvmem.rst
> @@ -185,6 +185,17 @@ ex::
>    *
>    0001000
>  
> +Single cells can be read using files located at::
> +
> +	/sys/bus/nvmem/devices/*/cells/*
> +
> +ex::
> +
> +  hexdump -C /sys/bus/nvmem/devices/mtd0/cells/mac
> +
> +  00000000  10 7b 44 c4 8a b0                                 |.{D...|
> +  00000006
> +
>  7. DeviceTree Binding
>  =====================
>  

sysfs apis are documented in Documenatation/ABI/ not in other random
files.  Please fix this.

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 23a38dcf0fc4..785a56e33f69 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -55,6 +55,7 @@ struct nvmem_cell_entry {
>  	struct device_node	*np;
>  	struct nvmem_device	*nvmem;
>  	struct list_head	node;
> +	struct bin_attribute	battr;
>  };
>  
>  struct nvmem_cell {
> @@ -73,6 +74,10 @@ static LIST_HEAD(nvmem_lookup_list);
>  
>  static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>  
> +static int __nvmem_cell_read(struct nvmem_device *nvmem,
> +		      struct nvmem_cell_entry *cell,
> +		      void *buf, size_t *len, const char *id);
> +
>  static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
>  			    void *val, size_t bytes)
>  {
> @@ -338,8 +343,18 @@ static const struct attribute_group nvmem_bin_group = {
>  	.is_bin_visible = nvmem_bin_attr_is_visible,
>  };
>  
> +static struct bin_attribute *nvmem_cells_bin_attrs[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +	.bin_attrs	= nvmem_cells_bin_attrs,
> +};
> +
>  static const struct attribute_group *nvmem_dev_groups[] = {
>  	&nvmem_bin_group,
> +	&nvmem_cells_group,
>  	NULL,
>  };
>  
> @@ -431,7 +446,13 @@ static struct bus_type nvmem_bus_type = {
>  
>  static void nvmem_cell_entry_drop(struct nvmem_cell_entry *cell)
>  {
> +	struct device *dev = &cell->nvmem->dev;
> +
>  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &cell->battr.attr,
> +				     nvmem_cells_group.name);
> +
>  	mutex_lock(&nvmem_mutex);
>  	list_del(&cell->node);
>  	mutex_unlock(&nvmem_mutex);
> @@ -448,11 +469,50 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
>  		nvmem_cell_entry_drop(cell);
>  }
>  
> +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *battr, char *buf,
> +				    loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *cell = container_of(battr, struct nvmem_cell_entry, battr);
> +	struct nvmem_device *nvmem = cell->nvmem;
> +	size_t bytes;
> +	u8 *data;
> +	int err;
> +
> +	if (pos >= cell->bytes)
> +		return 0;
> +
> +	data = kzalloc(cell->bytes, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	err = __nvmem_cell_read(nvmem, cell, data, &bytes, NULL);
> +	if (!err)
> +		memcpy(buf, data + pos, count - pos);
> +
> +	kfree(data);
> +
> +	return err ? err : bytes;
> +}
> +
>  static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
>  {
> +	struct device *dev = &cell->nvmem->dev;
> +	int err;
> +
>  	mutex_lock(&nvmem_mutex);
>  	list_add_tail(&cell->node, &cell->nvmem->cells);
>  	mutex_unlock(&nvmem_mutex);
> +
> +	sysfs_attr_init(&cell->battr.attr);
> +	cell->battr.attr.name = cell->name;
> +	cell->battr.attr.mode = 0400;
> +	cell->battr.read = nvmem_cell_attr_read;
> +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
> +					  nvmem_cells_group.name);

Why not just use the is_bin_visible attribute instead to determine if
the attribute should be shown or not instead of having to add it
after-the-fact which will race with userspace and loose?

thanks,

greg k-h
