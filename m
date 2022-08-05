Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270958A969
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiHEKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiHEKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:20:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5231B7AC;
        Fri,  5 Aug 2022 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659694846; x=1691230846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIOOG/MJeEB7Mx8DFAdJCx6B23KkAapg6M5PD8F/2a0=;
  b=nWXZBEz53HD+08zBLYsWa+s8lCnjHkSOFM+dDMn6MtJZVVjeSrhEVMqQ
   ZjHUxuw8tXgWsBcOM2R3Qr3eMwJ3N0ALkjEpJZ7QS1I7kdo7wgAQiyybk
   BGn8VUvViNXu/rCOYYVl0VjLvUceBZ5tOODvj0tyUmeOeudkb7QeTng6b
   W1yWZRvYFE1fh/d1ceXR5MYe5eo2rO5kG//7V6HOmrhqSDlPMwo8F+GRs
   23F8o8nPxha/J5jrYsX4WZDh2zAQ+W2KSf5Alwm/P6M3EiR9vpFKwikCP
   Jvt5eW5DZyPLOZhMoviGMWj9o3oramW0XfIp/ezQRZi6AJb/dgcVWxJR5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="273216840"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="273216840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 03:20:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="745817226"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 03:20:42 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Aug 2022 13:20:39 +0300
Date:   Fri, 5 Aug 2022 13:20:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <Yuzu90AlAu4R8Sv0@lahna>
References: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 05, 2022 at 05:22:24PM +0800, Szuying Chen wrote:
> The patch add tb_nvm_quirks() contain an array that has functions
> pointers to tb_nvm_vendor_apply().  And tb_nvm_vendor_apply() that
> recognize supported vendor works in one of the following cases:

In addition to what Greg already commented. These are not quirks so
don't call them that. They are vendor specific means to identify and
verify the NVM firmware.

> Case 0:enable nvm's attribute by setting no_nvm_upgrade flag to create nvm_authenticate file node.
> Case 1:add active/non-active NVM devices.
> Case 2:update firmware to non-ative NVM device.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/thunderbolt/nvm.c    | 163 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  12 +++
>  drivers/thunderbolt/tb.h     |  12 +++
>  3 files changed, 187 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..d5f283889da8 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -9,10 +9,173 @@
>  #include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pm_runtime.h>
> 
>  #include "tb.h"
> 
>  static DEFINE_IDA(nvm_ida);
> +static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	pm_runtime_get_sync(&sw->dev);
> +
> +	if (!mutex_trylock(&sw->tb->lock)) {
> +		ret = restart_syscall();
> +		goto out;
> +	}
> +
> +	ret = usb4_switch_nvm_read(sw, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +out:
> +	pm_runtime_mark_last_busy(&sw->dev);
> +	pm_runtime_put_autosuspend(&sw->dev);
> +
> +	return ret;
> +}
> +
> +static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
> +			       size_t bytes)
> +{
> +	struct tb_nvm *nvm = priv;
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	int ret;
> +
> +	if (!mutex_trylock(&sw->tb->lock))
> +		return restart_syscall();
> +
> +	/*
> +	 * Since writing the NVM image might require some special steps,
> +	 * for example when CSS headers are written, we cache the image
> +	 * locally here and handle the special cases when the user asks
> +	 * us to authenticate the image.
> +	 */
> +	ret = tb_nvm_write_buf(nvm, offset, val, bytes);
> +	mutex_unlock(&sw->tb->lock);
> +
> +	return ret;
> +}
> +
> +static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
> +{
> +	int ret = 0;
> +
> +	switch (handle) {
> +	case 0:
> +		if (sw->no_nvm_upgrade)
> +			sw->no_nvm_upgrade = false;
> +
> +		break;
> +
> +	case 1:
> +		struct tb_nvm *nvm;
> +		u32 val;
> +		u32 nvm_size;
> +
> +		nvm = tb_nvm_alloc(&sw->dev);
> +		if (IS_ERR(nvm)) {
> +			ret = PTR_ERR(nvm);
> +			break;
> +		}
> +
> +		ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
> +		if (ret)
> +			break;
> +
> +		nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
> +		nvm->vendor.version = (u8)(val >> 0x10);
> +		nvm_size = SZ_512K;
> +		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
> +		if (ret)
> +			break;
> +
> +		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
> +		if (ret)
> +			break;
> +
> +		sw->nvm = nvm;
> +		break;
> +
> +	case 2:
> +		unsigned int image_size;
> +		const u8 *buf = sw->nvm->buf;
> +
> +		if (!buf) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		image_size = sw->nvm->buf_data_size;
> +		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
> +		if (!ret)
> +			sw->nvm->flushed = true;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	if ((handle == 1) && (ret != 0))
> +		tb_nvm_free(sw->nvm);
> +
> +	return ret;
> +}
> +
> +struct tb_nvm_id {
> +	u16 hw_vendor_id;
> +	u16 hw_device_id;
> +	u16 vendor;
> +	u16 device;
> +	int (*hook)(struct tb_switch *sw, unsigned int handle);
> +};
> +
> +static const struct tb_nvm_id tb_nvm_vendors[] = {
> +	/* ASMedia software CM firmware upgrade */
> +	{ 0x174c, 0x2428, 0x174c, 0x0009, tb_nvm_vendor_apply },
> +};
> +
> +/**
> + * tb_nvm_quirks() - support vendor's NVM format
> + * @sw: Thunderbolt switch
> + */
> +int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle)
> +{
> +	int res, i;
> +	bool NoVendor = true;
> +
> +	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
> +		const struct tb_nvm_id *q = &tb_nvm_vendors[i];
> +
> +		if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
> +			continue;
> +		if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
> +			continue;
> +		if (q->vendor && q->vendor != sw->vendor)
> +			continue;
> +		if (q->device && q->device != sw->device)
> +			continue;
> +
> +		 res = q->hook(sw, handle);
> +		 NoVendor = false;
> +	}
> +	if (NoVendor)
> +		return -ENODEV;
> +	else
> +		return res;
> +}
> 
>  /**
>   * tb_nvm_alloc() - Allocate new NVM structure
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 561e1d77240e..a654b6951bef 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -114,6 +114,10 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>  		return -EINVAL;
> 
> +	ret = tb_nvm_quirks(sw, 2);
> +	if (ret != -ENODEV)
> +		return ret;
> +
>  	/*
>  	 * FARB pointer must point inside the image and must at least
>  	 * contain parts of the digital section we will be reading here.
> @@ -390,6 +394,11 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	if (!nvm_readable(sw))
>  		return 0;
> 
> +	/* Vendor's NVM formats definition */
> +	ret = tb_nvm_quirks(sw, 1);
> +	if (ret != -ENODEV)
> +		return ret;
> +
>  	/*
>  	 * The NVM format of non-Intel hardware is not known so
>  	 * currently restrict NVM upgrade for Intel hardware. We may
> @@ -1953,6 +1962,8 @@ static ssize_t nvm_version_show(struct device *dev,
>  		ret = -ENODATA;
>  	else if (!sw->nvm)
>  		ret = -EAGAIN;
> +	else if (sw->config.vendor_id == 0x174C)

Things like these should not be needed once we have the table for
supported vendor NVM formats.

> +		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->vendor.date, sw->nvm->vendor.customerID, sw->nvm->vendor.version);
>  	else
>  		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
> 
> @@ -2860,6 +2871,7 @@ int tb_switch_add(struct tb_switch *sw)
>  		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
> 
>  		tb_check_quirks(sw);
> +		tb_nvm_quirks(sw, 0);
> 
>  		ret = tb_switch_set_uuid(sw);
>  		if (ret) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index a831faa50f65..9dd1ba7b07b6 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -27,6 +27,16 @@
>  #define NVM_VERSION		0x08
>  #define NVM_FLASH_SIZE		0x45
> 
> +/* ASMedia specific NVM offsets */
> +#define NVM_Date	0x1C
> +#define NVM_CUSTOMER_ID	0x28

These should not be in tb.h at all. They should be in nvm.c.

> +
> +struct tb_nvm_vendor {
> +	int	date;
> +	u16	customerID;
> +	u8	version;
> +};
> +
>  /**
>   * struct tb_nvm - Structure holding NVM information
>   * @dev: Owner of the NVM
> @@ -56,6 +66,7 @@ struct tb_nvm {
>  	size_t buf_data_size;
>  	bool authenticating;
>  	bool flushed;
> +	struct tb_nvm_vendor vendor;
>  };
> 
>  enum tb_nvm_write_ops {
> @@ -735,6 +746,7 @@ static inline void tb_domain_put(struct tb *tb)
>  	put_device(&tb->dev);
>  }
> 
> +int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle);
>  struct tb_nvm *tb_nvm_alloc(struct device *dev);
>  int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
>  int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
> --
> 2.34.1
