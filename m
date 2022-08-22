Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797559BA73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiHVHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiHVHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB36557;
        Mon, 22 Aug 2022 00:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD86A60FE8;
        Mon, 22 Aug 2022 07:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD8AC433D6;
        Mon, 22 Aug 2022 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661154214;
        bh=NAqES7EIpLS3x+1LddXyZJxh5OvdRXevxcrSdTFOsKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz9nZLufgR42eu/eeWYFpOh5oRVx46f5G48QNCk5eUUIGkBvuGukcINIjFBRb115c
         wPDJUBTt6xZR8/gaL36Re43dy0yeMk+R14KZI4g35vZJLg2z73IBV4GraU3/cFqSpd
         GIAZiUOu15/11xj0htYxRLf5+5Lu90+sAioiiISk=
Date:   Mon, 22 Aug 2022 09:43:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v5] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YwMzo2IhL+ZqQMs3@kroah.com>
References: <20220822073105.10509-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822073105.10509-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Odd extra space :(

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

That's tough to read, want to add a comment explaining what you are
doing here?  Like "the major number is in bits X-Y..." and such?

> +	nvm->nvm_size = SZ_512K;
> +
> +	return 0;
> +}
> +
> +static int  intel_nvm_version(struct tb_switch *sw)

extra space.

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

extra blank line.  Did you run this patch through checkpatch.pl first?

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
> +
> +};
> +
> +/**
> + * tb_switch_nvm_alloc() - alloc nvm and set nvm->vops to point
> + * the vendor specific operations.
> + * @sw: thunderbolt switch
> + *
> + */
> +struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw)
> +{
> +	const struct tb_nvm_vendor_ops *vops = NULL;
> +	struct tb_nvm *nvm;
> +	int i;
> +	int ret;
> +
> +	/**

No need for kernel-doc format here.

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

Extra ' ' character please.

thanks,

greg k-h
