Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC555A656C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiH3Ns3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiH3NsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:48:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A42915C365;
        Tue, 30 Aug 2022 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867147; x=1693403147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YgoTg1VgtIwM92xPEd8ShwW4NWossGMVjWFSvQrUIDY=;
  b=MgplcZCzRWEdR9sbbCmKw13d38Dljl+D2Oi3D9njgmEp6y4ZKtN01RMU
   0fSWkJDxRH0hbjJtiH3NTNcPWTcYmXcknhJYFQIHHayR5qbGj4RKpdBOQ
   EW3ALA+dfAtTbC8CYnrshC+d0mWzYwbopRShIOXjmW1Esgl2aqlNMdtkC
   8yREbiH26UNOg4ddDdf030Lcaw4s0iHz5DLutdAWYk0ib+iyL5mKQg/6a
   Fd0HNgHNXZ7faOJbLNKAwMyLBTMmNh9WxYLUDriCzOlj3zf3Wu3fGZfnp
   VBPi7vdbJogpmAII8c8v+PU6uW031gVb9C1t2FdUGAZDgVe4dbUFwasVy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296453715"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296453715"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="614615325"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2022 06:45:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 06DD2174; Tue, 30 Aug 2022 16:45:36 +0300 (EEST)
Date:   Tue, 30 Aug 2022 16:45:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v7 1/3] thunderbolt: Add vendor's specific operations of
 NVM
Message-ID: <Yw4UgEu5ecNd9qh4@black.fi.intel.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
 <20220829111059.665305-2-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829111059.665305-2-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 07:10:57PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_switch_nvm_alloc() contain an array that has functions
> pointers to vendor_ops that vendor to define.
> And moved vendor:intel part of the code to make all the vendors
> (includes Intel) support it in nvm.c.

This should really answer the question: why this patch is needed. Not
what it does as we can see that from the code itself.

> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> Fix $subject and add part of kernel-doc.
> 
>  drivers/thunderbolt/nvm.c    | 206 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c | 102 +++--------------
>  drivers/thunderbolt/tb.h     |   6 +
>  3 files changed, 229 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index b3f310389378..91c8848b4d2e 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -12,8 +12,214 @@
> 
>  #include "tb.h"
> 
> +/* Switch NVM support */
> +#define NVM_CSS		0x10
> +
>  static DEFINE_IDA(nvm_ida);
> 
> +/**
> + * struct tb_nvm_vendor_ops - Vendor NVM specific operations
> + * @read_version: Used NVM read get Firmware version.
> + * @validate: Vendors have their validate method before NVM write.
> + */
> +struct tb_nvm_vendor_ops {
> +	int (*read_version)(struct tb_switch *sw);
> +	int (*validate)(struct tb_switch *sw);
> +};
> +
> +static inline int nvm_read(struct tb_switch *sw, unsigned int address,
> +			   void *buf, size_t size)
> +{
> +	if (tb_switch_is_usb4(sw))
> +		return usb4_switch_nvm_read(sw, address, buf, size);
> +	return dma_port_flash_read(sw->dma_port, address, buf, size);
> +}

There is already a version of this in switch.c so can't we move this
into tb.h and use it in both places?

> +
> +static int intel_nvm_version(struct tb_switch *sw)
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
> +	}
> +
> +	return 0;
> +}
> +
> +static int intel_nvm_validate(struct tb_switch *sw)
> +{
> +	unsigned int image_size, hdr_size;
> +	u8 *buf = sw->nvm->buf;
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
> +		sw->nvm->buf = buf + hdr_size;
> +		sw->nvm->buf_data_size = image_size - hdr_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
> +	.read_version = intel_nvm_version,
> +	.validate = intel_nvm_validate,
> +};
> +
> +struct switch_nvm_vendor {
> +	u16 vendor;
> +	const struct tb_nvm_vendor_ops *vops;
> +};
> +
> +static const struct switch_nvm_vendor switch_nvm_vendors[] = {
> +	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
> +	{ 0x8087, &intel_switch_nvm_ops },
> +};
> +
> +/**
> + * tb_switch_nvm_validate() - Validate NVM image
> + * @switch: Switch to NVM write
> + *
> + * The function include vendor's validate before writes data to actual NVM
> + * flash device. Return %0 in success and error otherwise.
> + */
> +int tb_switch_nvm_validate(struct tb_switch *sw)
> +{
> +	const struct tb_nvm_vendor_ops *vops = sw->nvm->vops;
> +	const u8 *buf = sw->nvm->buf;
> +	unsigned int image_size;
> +	int ret = 0;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	image_size = sw->nvm->buf_data_size;
> +	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
> +		return -EINVAL;
> +
> +	if (!vops)
> +		return 0;
> +
> +	if (vops->validate)
> +		ret = vops->validate(sw);
> +
> +	return ret;

return vops->validate ? vops->validate(sw) ? 0;

> +}
> +
> +/**
> + * tb_switch_nvm_alloc() - Allocate new NVM structure.
> + * @sw: Switch to allocate NVM
> + *
> + * Allocates new NVM structure and returns it. In case of error returns
> + * ERR_PTR().
> + */
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw)
> +{
> +	const struct tb_nvm_vendor_ops *vops = NULL;
> +	struct tb_nvm *nvm;
> +	int ret;
> +	int i;
> +
> +	/*
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
> +	ret = vops->read_version(sw);
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
> index 244f8cd38b25..2dbfd75202bf 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -102,62 +102,17 @@ static void nvm_clear_auth_status(const struct tb_switch *sw)
> 
>  static int nvm_validate_and_write(struct tb_switch *sw)
>  {
> -	unsigned int image_size, hdr_size;
> -	const u8 *buf = sw->nvm->buf;
> -	u16 ds_size;
> +	unsigned int image_size;
> +	const u8 *buf;
>  	int ret;
> 
> -	if (!buf)
> -		return -EINVAL;
> +	/* validate NVM image before NVM write */
> +	ret = tb_switch_nvm_validate(sw);
> +	if (ret)
> +		return ret;
> 
> +	buf = sw->nvm->buf;
>  	image_size = sw->nvm->buf_data_size;
> -	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
> -		return -EINVAL;
> -
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
> -
> -		/* Skip headers in the image */
> -		buf += hdr_size;
> -		image_size -= hdr_size;
> -	}
> 
>  	if (tb_switch_is_usb4(sw))
>  		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
> @@ -384,28 +339,22 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
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
> +	nvm = tb_switch_nvm_alloc(sw);
> +	if (IS_ERR(nvm)) {
> +		if (PTR_ERR(nvm) == -EOPNOTSUPP) {
> +			dev_info(&sw->dev,
> +				"NVM format of vendor %#x is not known, disabling NVM upgrade\n",
> +				sw->config.vendor_id);
> +			return 0;
> +		}
> 
> -	nvm = tb_nvm_alloc(&sw->dev);
> -	if (IS_ERR(nvm))
>  		return PTR_ERR(nvm);
> +	}
> 
>  	/*
>  	 * If the switch is in safe-mode the only accessible portion of
> @@ -413,24 +362,7 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
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
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..fc32737fcde4 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -42,6 +42,8 @@
>   *		   image
>   * @authenticating: The device is authenticating the new NVM
>   * @flushed: The image has been flushed to the storage area
> + * @nvm_size: Number of bytes to activate NVM

@nvm_size: Size in bytes of the active NVM

> + * @vops: Vendor NVM specific operations
>   *
>   * The user of this structure needs to handle serialization of possible
>   * concurrent access.
> @@ -57,6 +59,8 @@ struct tb_nvm {
>  	size_t buf_data_size;
>  	bool authenticating;
>  	bool flushed;
> +	u32 nvm_size;
> +	const struct tb_nvm_vendor_ops *vops;
>  };
> 
>  enum tb_nvm_write_ops {
> @@ -759,6 +763,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
>  				  u64 route);
>  struct tb_switch *tb_switch_alloc_safe_mode(struct tb *tb,
>  			struct device *parent, u64 route);
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
>  int tb_switch_configure(struct tb_switch *sw);
>  int tb_switch_add(struct tb_switch *sw);
>  void tb_switch_remove(struct tb_switch *sw);
> @@ -767,6 +772,7 @@ int tb_switch_resume(struct tb_switch *sw);
>  int tb_switch_reset(struct tb_switch *sw);
>  int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>  			   u32 value, int timeout_msec);
> +int tb_switch_nvm_validate(struct tb_switch *sw);
>  void tb_sw_set_unplugged(struct tb_switch *sw);
>  struct tb_port *tb_switch_find_port(struct tb_switch *sw,
> 				    enum tb_port_type type);
> --
> 2.34.1
