Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4B459BC48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiHVJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiHVJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:07:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109262ED6D;
        Mon, 22 Aug 2022 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661159242; x=1692695242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxlODoncKZxTLvFzNkqQ48E06CMT6kFUQtjWExFrLa8=;
  b=W3oh6T4xBRHyIjRjpIFnNQ4cne3oucYoTHLOu3pWTM6jez5BxJ+m1VJc
   y6y3HXDEZCDlbh739T8201CkbJv16j93k0qqiE0Q+OqTWL54jm9Pek3lo
   ItVedgsG8GjtIQ2zvYPhsUZiv45LhNVZdpVcQWNZi8tZHY2p5fNspEy38
   A9r1KlGmQq4cVbKpmSOu1wThI8jX7hCvUuYNAt+gdBFvZP64E0+MmkAOU
   x9VNH4nRr7MG46Lt2KXELfVTbE3tJ6ivG1TM36EOrcvmOreHGOXJ2bBZX
   mVFTGplhbKXNnlnxO4TtKInaA6ivLw4bEGb0RYQhnrLkRjafImERqgAWB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290919292"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="290919292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 02:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="712104362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2022 02:07:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D3059174; Mon, 22 Aug 2022 12:07:32 +0300 (EEST)
Date:   Mon, 22 Aug 2022 12:07:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v5] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YwNHVKdEG9deGCcd@black.fi.intel.com>
References: <20220822073105.10509-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822073105.10509-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 03:31:05PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_switch_nvm_alloc() contain an array that has functions
> pointers to vendor_ops that vendor to define.
> And add tb_switch_nvm_upgradable() to enable nvm upgrade for vendors
> that in switch_nvm_upgrade_vendors[].
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> v4 -> v5 : Take Mika's suggestion and use nvm->vops to point the vendor
> specific operations. Moved vendor:intel part of the code to make all
> the vendors (includes Intel) support it in nvm.c. And add nvm specific
> operations for ASMedia.

In addition to what Greg said, please split this into series. First
patch moves the existing Intel stuff and second patch adds the ASMedia
stuff on top and please run all them through checkpatch.pl and make
sure you fix every single warning.

Also please fix the $subject, it now has "thunderbolt: thunderbolt: ..".

> 
>  drivers/thunderbolt/nvm.c    | 204 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c | 100 ++++-------------
>  drivers/thunderbolt/tb.h     |  19 +++-
>  3 files changed, 242 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..6ee048565616 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -12,8 +12,212 @@
> 
>  #include "tb.h"
> 
> +/* Switch NVM support */
> +#define NVM_CSS
> +
>  static DEFINE_IDA(nvm_ida);
> 
> +/* Vendor provides NVM firmware upgrade function */
> +static const u32 switch_nvm_upgrade_vendors[] = {
> +	0x174c,
> +};
> +
> +void tb_switch_nvm_upgradable(struct tb_switch *sw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(switch_nvm_upgrade_vendors); i++) {
> +		if (switch_nvm_upgrade_vendors[i] == sw->config.vendor_id)
> +			sw->no_nvm_upgrade = false;
> +	}
> +}
> +
> +static inline int nvm_read(struct tb_switch *sw, unsigned int address,
> +			   void *buf, size_t size)
> +{
> +	if (tb_switch_is_usb4(sw))
> +		return usb4_switch_nvm_read(sw, address, buf, size);
> +	return dma_port_flash_read(sw->dma_port, address, buf, size);
> +}
> +
> +static int  asmedia_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u64 val;
> +	int ret;
> +
> +	ret = nvm_read(sw, 0x1c, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->major = (((u8)val >> 0x18) << 0x10 | ((u8)(val >> 0x20)) << 0x8 | (u8)(val >> 0x28));
> +	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +	nvm->nvm_size = SZ_512K;
> +
> +	return 0;
> +}
> +
> +static int  intel_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * If the switch is in safe-mode the only accessible portion of
> +	 * the NVM is the non-active one where userspace is expected to
> +	 * write new functional NVM.
> +	 */
> +	if (!sw->safe_mode) {
> +		u32 nvm_size, hdr_size;
> +
> +		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
> +		if (ret)
> +			return ret;
> +
> +		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
> +		nvm_size = (SZ_1M << (val & 7)) / 8;
> +		nvm_size = (nvm_size - hdr_size) / 2;
> +
> +		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
> +		if (ret)
> +			return ret;
> +
> +		nvm->major = val >> 16;
> +		nvm->minor = val >> 8;
> +		nvm->nvm_size = nvm_size;
> +
> +	}
> +
> +	return 0;
> +}
> +
> +static int  intel_nvm_validate(struct tb_switch *sw)
> +{
> +	unsigned int image_size, hdr_size;
> +	const u8 *buf = sw->nvm->buf;
> +	u16 ds_size;
> +	int ret;
> +
> +	image_size = sw->nvm->buf_data_size;
> +	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * FARB pointer must point inside the image and must at least
> +	 * contain parts of the digital section we will be reading here.
> +	 */
> +	hdr_size = (*(u32 *)buf) & 0xffffff;
> +	if (hdr_size + NVM_DEVID + 2 >= image_size)
> +		return -EINVAL;
> +
> +	/* Digital section start should be aligned to 4k page */
> +	if (!IS_ALIGNED(hdr_size, SZ_4K))
> +		return -EINVAL;
> +
> +	/*
> +	 * Read digital section size and check that it also fits inside
> +	 * the image.
> +	 */
> +	ds_size = *(u16 *)(buf + hdr_size);
> +	if (ds_size >= image_size)
> +		return -EINVAL;
> +
> +	if (!sw->safe_mode) {
> +		u16 device_id;
> +
> +		/*
> +		 * Make sure the device ID in the image matches the one
> +		 * we read from the switch config space.
> +		 */
> +		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
> +		if (device_id != sw->config.device_id)
> +			return -EINVAL;
> +
> +		if (sw->generation < 3) {
> +			/* Write CSS headers first */
> +			ret = dma_port_flash_write(sw->dma_port,
> +				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
> +				DMA_PORT_CSS_MAX_SIZE);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* Skip headers in the image */
> +		buf += hdr_size;
> +		image_size -= hdr_size;
> +	}
> +
> +	return image_size;
> +}
> +
> +struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
> +	.version = asmedia_nvm_version,
> +};
> +
> +struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
> +	.version = intel_nvm_version,
> +	.validate = intel_nvm_validate,
> +};
> +
> +struct switch_nvm_vendor {
> +	u16 vendor;
> +	const struct tb_nvm_vendor_ops *vops;
> +};
> +
> +static const struct switch_nvm_vendor switch_nvm_vendors[] = {
> +	{ 0x8086, &intel_switch_nvm_ops },
> +	{ 0x8087, &intel_switch_nvm_ops },
> +	{ 0x174c, &asmedia_switch_nvm_ops },

Only single table is needed, please get rid of
switch_nvm_upgrade_vendors[] so this one is easy to extend with another
vendor. Also order these numerically and you can use the PCI_VENDOR_ if
possible and available.

> +
> +};
> +
> +/**
> + * tb_switch_nvm_alloc() - alloc nvm and set nvm->vops to point
> + * the vendor specific operations.
> + * @sw: thunderbolt switch
> + *

Extra emtpy line, please get rid of all these before submitting another
version.

> + */
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw)
> +{
> +	const struct tb_nvm_vendor_ops *vops = NULL;
> +	struct tb_nvm *nvm;
> +	int i;
> +	int ret;
> +
> +	/**
> +	 * If the vendor matches on the array then set nvm->vops to
> +	 * point the vendor specific operations.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
> +		const struct switch_nvm_vendor *v = &switch_nvm_vendors[i];
> +
> +		if (v->vendor == sw->config.vendor_id) {
> +			vops = v->vops;
> +			break;
> +		}
> +	}
> +
> +	if (!vops)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	nvm = tb_nvm_alloc(&sw->dev);
> +	if (IS_ERR(nvm))
> +		return nvm;
> +
> +	nvm->vops = vops;
> +	sw->nvm = nvm;
> +	ret = vops->version(sw);
> +	if (ret)
> +		goto err_nvm;
> +
> +	return nvm;
> +
> +err_nvm:
> +	tb_nvm_free(nvm);
> +	return ERR_PTR(ret);
> +}
> +
>  /**
>   * tb_nvm_alloc() - Allocate new NVM structure
>   * @dev: Device owning the NVM
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 244f8cd38b25..392586641828 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -102,10 +102,10 @@ static void nvm_clear_auth_status(const struct tb_switch *sw)
> 
>  static int nvm_validate_and_write(struct tb_switch *sw)
>  {
> -	unsigned int image_size, hdr_size;
> +	unsigned int image_size;
>  	const u8 *buf = sw->nvm->buf;
> -	u16 ds_size;
>  	int ret;
> +	const struct tb_nvm_vendor_ops *vops = sw->nvm->vops;
> 
>  	if (!buf)
>  		return -EINVAL;
> @@ -114,49 +114,13 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>  		return -EINVAL;
> 
> -	/*
> -	 * FARB pointer must point inside the image and must at least
> -	 * contain parts of the digital section we will be reading here.
> -	 */
> -	hdr_size = (*(u32 *)buf) & 0xffffff;
> -	if (hdr_size + NVM_DEVID + 2 >= image_size)
> -		return -EINVAL;
> -
> -	/* Digital section start should be aligned to 4k page */
> -	if (!IS_ALIGNED(hdr_size, SZ_4K))
> -		return -EINVAL;
> -
> -	/*
> -	 * Read digital section size and check that it also fits inside
> -	 * the image.
> -	 */
> -	ds_size = *(u16 *)(buf + hdr_size);
> -	if (ds_size >= image_size)
> -		return -EINVAL;
> -
> -	if (!sw->safe_mode) {
> -		u16 device_id;
> -
> -		/*
> -		 * Make sure the device ID in the image matches the one
> -		 * we read from the switch config space.
> -		 */
> -		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
> -		if (device_id != sw->config.device_id)
> -			return -EINVAL;
> -
> -		if (sw->generation < 3) {
> -			/* Write CSS headers first */
> -			ret = dma_port_flash_write(sw->dma_port,
> -				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
> -				DMA_PORT_CSS_MAX_SIZE);
> -			if (ret)
> -				return ret;
> -		}
> +	/*Vendors to validate before write to router NVM*/

And fix this one too, again checkpatch.pl helps use it.

> +	if (vops->validate) {
> +		ret = vops->validate(sw);
> +		if (ret < 0)
> +			return ret;
> 
> -		/* Skip headers in the image */
> -		buf += hdr_size;
> -		image_size -= hdr_size;
> +		image_size = ret;
>  	}
> 
>  	if (tb_switch_is_usb4(sw))
> @@ -384,28 +348,21 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
>  static int tb_switch_nvm_add(struct tb_switch *sw)
>  {
>  	struct tb_nvm *nvm;
> -	u32 val;
>  	int ret;
> 
>  	if (!nvm_readable(sw))
>  		return 0;
> 
> -	/*
> -	 * The NVM format of non-Intel hardware is not known so
> -	 * currently restrict NVM upgrade for Intel hardware. We may
> -	 * relax this in the future when we learn other NVM formats.
> -	 */
> -	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL &&
> -	    sw->config.vendor_id != 0x8087) {
> -		dev_info(&sw->dev,
> -			 "NVM format of vendor %#x is not known, disabling NVM upgrade\n",
> -			 sw->config.vendor_id);
> -		return 0;
> -	}
> -
> -	nvm = tb_nvm_alloc(&sw->dev);
> -	if (IS_ERR(nvm))
> +	nvm = tb_switch_nvm_alloc(sw);
> +	if (IS_ERR(nvm)) {
> +		if (PTR_ERR(nvm) == -EOPNOTSUPP) {
> +			dev_info(&sw->dev,
> +				"NVM format of vendor %#x is not known, disabling NVM upgrade\n",
> +				sw->config.vendor_id);
> +			return 0;
> +		}
>  		return PTR_ERR(nvm);
> +	}
> 
>  	/*
>  	 * If the switch is in safe-mode the only accessible portion of
> @@ -413,24 +370,7 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	 * write new functional NVM.
>  	 */
>  	if (!sw->safe_mode) {
> -		u32 nvm_size, hdr_size;
> -
> -		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
> -		if (ret)
> -			goto err_nvm;
> -
> -		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
> -		nvm_size = (SZ_1M << (val & 7)) / 8;
> -		nvm_size = (nvm_size - hdr_size) / 2;
> -
> -		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
> -		if (ret)
> -			goto err_nvm;
> -
> -		nvm->major = val >> 16;
> -		nvm->minor = val >> 8;
> -
> -		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
> +		ret = tb_nvm_add_active(nvm, nvm->nvm_size, tb_switch_nvm_read);
>  		if (ret)
>  			goto err_nvm;
>  	}
> @@ -442,7 +382,6 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  			goto err_nvm;
>  	}
> 
> -	sw->nvm = nvm;
>  	return 0;
> 
>  err_nvm:
> @@ -2890,6 +2829,9 @@ int tb_switch_add(struct tb_switch *sw)
>  			return ret;
>  	}
> 
> +	/* Enable the NVM firmware upgrade for specific vendors */
> +	tb_switch_nvm_upgradable(sw);
> +
>  	ret = device_add(&sw->dev);
>  	if (ret) {
>  		dev_err(&sw->dev, "failed to add device: %d\n", ret);
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..24b3db35bd9b 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -48,8 +48,8 @@
>   */
>  struct tb_nvm {
>  	struct device *dev;
> -	u8 major;
> -	u8 minor;
> +	u32 major;
> +	u32 minor;
>  	int id;
>  	struct nvmem_device *active;
>  	struct nvmem_device *non_active;
> @@ -57,6 +57,8 @@ struct tb_nvm {
>  	size_t buf_data_size;
>  	bool authenticating;
>  	bool flushed;
> +	u32 nvm_size;
> +	const struct tb_nvm_vendor_ops *vops;
>  };
> 
>  enum tb_nvm_write_ops {
> @@ -65,6 +67,17 @@ enum tb_nvm_write_ops {
>  	AUTHENTICATE_ONLY = 3,
>  };
> 
> +/**
> + * struct tb_nvm_vendor_ops - vendor NVM specific operations
> + * @version: Used NVM read get Firmware version.
> + * @validate: Vendors have their validate method before NVM write.
> + *
> + */
> +struct tb_nvm_vendor_ops {
> +	int (*version)(struct tb_switch *sw);
> +	int (*validate)(struct tb_switch *sw);
> +};
> +
>  #define TB_SWITCH_KEY_SIZE		32
>  #define TB_SWITCH_MAX_DEPTH		6
>  #define USB4_SWITCH_MAX_DEPTH		5
> @@ -736,6 +749,8 @@ static inline void tb_domain_put(struct tb *tb)
>  	put_device(&tb->dev);
>  }
> 
> +void tb_switch_nvm_upgradable(struct tb_switch *sw);
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
>  struct tb_nvm *tb_nvm_alloc(struct device *dev);
>  int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
>  int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
> --
> 2.34.1
