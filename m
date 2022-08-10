Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EE58EAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHJK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHJK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:57:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174761B7AC;
        Wed, 10 Aug 2022 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660129024; x=1691665024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ose/0mu4nC9uvmueKDnMIz2XMSo2SbomWrU6zESosw=;
  b=mY6z4e0kL0L4Sk0LWkltvnkCfqMfqQydFF2BpZgA1uZtFRhu8oEsBTNU
   F3QdjIgzGgVDMW5f5NkTvVBKjnB+TSUILcCZ9aeOc77szLoW4uixkz5at
   gsJRwlNwiWvZUFIjuCrxuyxt+mXTJkc06fIb2XTy6s+buj+VPB46nWSAV
   flEr6dtngfyfjYJeB3Mf2a/SRWIxUARGNYh5MPSLITz9zJmn58A2wvQHK
   jfmr6K0Q/HRP+QcuhtyeHsYX9rFEldw164R79V5ZJVMUE6KI87oDSlcv1
   a+HypL8Q5XAMjirTR/D3HIzLNQxaZa/kpt+fclK5BLFbaoIb6kAUztyKt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291054799"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="291054799"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 03:57:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="731458495"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 03:56:59 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 10 Aug 2022 13:56:57 +0300
Date:   Wed, 10 Aug 2022 13:56:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YvOO+W4gcs8v1lD+@lahna>
References: <20220810101743.11214-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810101743.11214-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 10, 2022 at 06:17:43PM +0800, Szuying Chen wrote:
> The patch add tb_nvm_quirks() contain an array that has functions
> pointers to tb_nvm_vendor_apply().
> And tb_nvm_vendor_apply() that recognize supported vendor works in one
> of the following cases:
> Case NvmUpgradeSuppport: enable nvm's attribute by setting
> no_nvm_upgrade flag to create nvm_authenticate file node.
> Case NvmAdd:add active/non-active NVM devices.
> Case NvmWrite:update firmware to non-ative NVM device.

Again, on top of what Greg already commented. Please run your patches
through checkpatch.pl and make sure they follow the coding style used in
the kernel (these are well documented under Documentation/*).

> Signed-off-by: Szuying Chen <chensiying21@gmail.com>
> ---
>  drivers/thunderbolt/nvm.c    | 59 ++++++++++++++----------------------
>  drivers/thunderbolt/switch.c | 19 +++++++-----
>  drivers/thunderbolt/tb.h     | 18 +++++++----
>  3 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index d5f283889da8..2aae8b3fa5dc 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -14,6 +14,7 @@
>  #include "tb.h"
> 
>  static DEFINE_IDA(nvm_ida);
> +
>  static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
>  			      size_t bytes)
>  {
> @@ -22,7 +23,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
>  	int ret;
> 
>  	pm_runtime_get_sync(&sw->dev);
> -
>  	if (!mutex_trylock(&sw->tb->lock)) {
>  		ret = restart_syscall();
>  		goto out;
> @@ -60,22 +60,23 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
>  	return ret;
>  }
> 
>  Refer to thunderbolt source: switch.c.

No idea why this is there.

> -static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
> +static int asm_nvm_apply(struct tb_switch *sw, unsigned int handle)
>  {
> +	struct tb_nvm *nvm;
> +	u32 val;
> +	u32 nvm_size;
>  	int ret = 0;
> +	unsigned int image_size;
> +	const u8 *buf = sw->nvm->buf;
> 
>  	switch (handle) {
> -	case 0:
> +	case NvmUpgradeSuppport:

These are not followign the coding style.

>  		if (sw->no_nvm_upgrade)
>  			sw->no_nvm_upgrade = false;
> 
>  		break;
> 
> -	case 1:
> -		struct tb_nvm *nvm;
> -		u32 val;
> -		u32 nvm_size;
> -
> +	case NvmAdd:
>  		nvm = tb_nvm_alloc(&sw->dev);
>  		if (IS_ERR(nvm)) {
>  			ret = PTR_ERR(nvm);
> @@ -86,13 +87,13 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
>  		if (ret)
>  			break;
> 
> -		nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +		nvm->nvm_asm.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
>  		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
>  		if (ret)
>  			break;
> 
> -		nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
> -		nvm->vendor.version = (u8)(val >> 0x10);
> +		nvm->nvm_asm.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
> +		nvm->nvm_asm.version = (u8)(val >> 0x10);
>  		nvm_size = SZ_512K;
>  		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
>  		if (ret)
> @@ -105,10 +106,7 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
>  		sw->nvm = nvm;
>  		break;
> 
> -	case 2:
> -		unsigned int image_size;
> -		const u8 *buf = sw->nvm->buf;
> -
> +	case NvmWrite:
>  		if (!buf) {
>  			ret = -EINVAL;
>  			break;
> @@ -128,7 +126,7 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
>  		break;
>  	}
> 
> -	if ((handle == 1) && (ret != 0))
> +	if ((handle == NvmAdd) && (ret != 0))
>  		tb_nvm_free(sw->nvm);
> 
>  	return ret;
> @@ -136,45 +134,32 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
> 
>  struct tb_nvm_id {
>  	u16 hw_vendor_id;
> -	u16 hw_device_id;
> -	u16 vendor;
> -	u16 device;
>  	int (*hook)(struct tb_switch *sw, unsigned int handle);

hook does not mean anything. Please call it ->validate or similar that
makes sense and document it too.

>  };
> 
>  static const struct tb_nvm_id tb_nvm_vendors[] = {
>  	/* ASMedia software CM firmware upgrade */
> -	{ 0x174c, 0x2428, 0x174c, 0x0009, tb_nvm_vendor_apply },
> +	{ 0x174c, asm_nvm_apply },

_apply is bad name too. This should be called asmedia_nvm_validate or
similar.

>  };
> 
>  /**
> - * tb_nvm_quirks() - support vendor's NVM format
> + * tb_nvm_vendor_handle() - support vendor's NVM format
>   * @sw: Thunderbolt switch
> + * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
>   */
> -int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle)
> +int tb_nvm_vendor_handle(struct tb_switch *sw, unsigned int handle)

handle is bad name choice.

If this is supposed to validate vendor specific NVM, then call it
tb_nvm_validate() or tb_nvm_validate_vendor().

>  {
>  	int res, i;
> -	bool NoVendor = true;
> 
>  	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
> -		const struct tb_nvm_id *q = &tb_nvm_vendors[i];
> +		const struct tb_nvm_id *id = &tb_nvm_vendors[i];
> 
> -		if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
> -			continue;
> -		if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
> -			continue;
> -		if (q->vendor && q->vendor != sw->vendor)
> -			continue;
> -		if (q->device && q->device != sw->device)
> +		if (id->hw_vendor_id && id->hw_vendor_id != sw->config.vendor_id)
>  			continue;
> 
> -		 res = q->hook(sw, handle);
> -		 NoVendor = false;
> +		 res = id->hook(sw, handle);
>  	}
> -	if (NoVendor)
> -		return -ENODEV;
> -	else
> -		return res;
> +	return res;
>  }
> 
>  /**
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index a654b6951bef..8fa9efa8a900 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -114,8 +114,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
>  	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
>  		return -EINVAL;
> 
> -	ret = tb_nvm_quirks(sw, 2);
> -	if (ret != -ENODEV)
> +	/*
> +	 * Vendor's nvm write. If the image has been flushed to the
> +	 * storage are, nvm write is complete.
> +	 */
> +	ret = tb_nvm_vendor_handle(sw, NvmWrite);
> +	if (sw->nvm->flushed)
>  		return ret;
> 
>  	/*
> @@ -394,9 +398,9 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
>  	if (!nvm_readable(sw))
>  		return 0;
> 
> -	/* Vendor's NVM formats definition */
> -	ret = tb_nvm_quirks(sw, 1);
> -	if (ret != -ENODEV)
> +	/* Vendor's NVM formats add */
> +	ret = tb_nvm_vendor_handle(sw, NvmAdd);
> +	if (ret)
>  		return ret;
> 
>  	/*
> @@ -1962,8 +1966,9 @@ static ssize_t nvm_version_show(struct device *dev,
>  		ret = -ENODATA;
>  	else if (!sw->nvm)
>  		ret = -EAGAIN;
> +	/*ASMedia NVM version show format xxxxxx_xxxx_xx */
>  	else if (sw->config.vendor_id == 0x174C)
> -		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->vendor.date, sw->nvm->vendor.customerID, sw->nvm->vendor.version);
> +		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->nvm_asm.date, sw->nvm->nvm_asm.customerID, sw->nvm->nvm_asm.version);
>  	else
>  		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
> 
> @@ -2871,7 +2876,7 @@ int tb_switch_add(struct tb_switch *sw)
>  		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
> 
>  		tb_check_quirks(sw);
> -		tb_nvm_quirks(sw, 0);
> +		tb_nvm_vendor_handle(sw, NvmUpgradeSuppport);
> 
>  		ret = tb_switch_set_uuid(sw);
>  		if (ret) {
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 9dd1ba7b07b6..a8dd0ae04741 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -31,10 +31,16 @@
>  #define NVM_Date	0x1C

Lower case for hex digit, 0x1c.

>  #define NVM_CUSTOMER_ID	0x28

> 
> -struct tb_nvm_vendor {
> -	int	date;
> -	u16	customerID;
> -	u8	version;
> +/* ASMedia specific NVM handle */
> +#define NvmUpgradeSuppport 0
> +#define NvmAdd 1
> +#define NvmWrite 2

And don't use "handle" here either. 

> +
> +struct nvm_asmedia {
> +	u32 date;
> +	u32 customerID:16;
> +	u32 version:8;
> +	u32 reserved:8;
>  };
> 
>  /**
> @@ -66,7 +72,7 @@ struct tb_nvm {
>  	size_t buf_data_size;
>  	bool authenticating;
>  	bool flushed;
> -	struct tb_nvm_vendor vendor;
> +	struct nvm_asmedia nvm_asm;
>  };
> 
>  enum tb_nvm_write_ops {
> @@ -746,7 +752,7 @@ static inline void tb_domain_put(struct tb *tb)
>  	put_device(&tb->dev);
>  }
> 
> -int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle);
> +int tb_nvm_vendor_handle(struct tb_switch *sw, unsigned int handle);
>  struct tb_nvm *tb_nvm_alloc(struct device *dev);
>  int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
>  int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
> --
> 2.34.1
