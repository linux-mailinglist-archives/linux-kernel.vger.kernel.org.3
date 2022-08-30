Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689E5A65AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiH3NyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiH3NyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:54:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA43109E;
        Tue, 30 Aug 2022 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867617; x=1693403617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CfUW4WBXt1HwDAtQIzZ6c8S6TWUb2CY9IO/h++eGxkk=;
  b=ml5Vc1Q9uxnQcO6yzYNVYm2949+5cIOG8gIYbYshlinI80kA+mJ0MbYs
   AmOC3JS207IET6YSW4NS0NSAaiCJj00HFWhamnmw8iTIOw5aTri+Tl9vV
   ZhVhM7d6UfRuT1uoyF9z2gKaS2Q3n8HUCAYSoLQK+DpAU1BIoczMTm5Cx
   yMQbq1/3OjihQXDM1XGSJyFYZWFP3ps5qFDS7YrMVWTPao/nHSVWIvxMw
   Ttqz9ZaEOI82J5Uw7D8/Vk6/BMeg2JWnl9E7kW0Lz50s2LjjqVliiKu0b
   v1kBxZFkSH/KAhOup422NvfGtqQej+CDxb71n12sAyGJgA0qw2nAUlHJa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275577693"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="275577693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="715304954"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 06:53:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 31E41174; Tue, 30 Aug 2022 16:53:47 +0300 (EEST)
Date:   Tue, 30 Aug 2022 16:53:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v7 3/3] thunderbolt: To extend ASMedia NVM formats.
Message-ID: <Yw4Wa1s/zg4XtTxi@black.fi.intel.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
 <20220829111059.665305-4-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829111059.665305-4-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 07:10:59PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add ASMedia NVM formats. And add tb_switch_nvm_upgradeable()
> to enable firmware upgrade.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> Add ASMedia NVM formats. And fix asmedia_nvm_version() part of code so
> that easier to read.
> 
>  drivers/thunderbolt/nvm.c    | 68 ++++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  3 ++
>  drivers/thunderbolt/tb.h     |  1 +
>  3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index 91c8848b4d2e..c69db5b65f7d 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -15,16 +15,25 @@
>  /* Switch NVM support */
>  #define NVM_CSS		0x10
> 
> +/* Vendor ID of the Router. It's assigned by the USB-IF */

Pretty useless comment.

> +#define ROUTER_VENDOR_ID_ASMEDIA 0x174c
> +
> +/* ASMedia specific NVM offsets */
> +#define ASMEDIA_NVM_DATE	0x1c
> +#define ASMEDIA_NVM_VERSION	0x28
> +
>  static DEFINE_IDA(nvm_ida);
> 
>  /**
>   * struct tb_nvm_vendor_ops - Vendor NVM specific operations
>   * @read_version: Used NVM read get Firmware version.
>   * @validate: Vendors have their validate method before NVM write.
> + * @nvm_upgrade: Enable NVM upgrade.
>   */
>  struct tb_nvm_vendor_ops {
>  	int (*read_version)(struct tb_switch *sw);
>  	int (*validate)(struct tb_switch *sw);
> +	void (*nvm_upgrade)(struct tb_switch *sw);
>  };
> 
>  static inline int nvm_read(struct tb_switch *sw, unsigned int address,
> @@ -128,11 +137,49 @@ static int intel_nvm_validate(struct tb_switch *sw)
>  	return 0;
>  }
> 
> +static int asmedia_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u32 val;
> +	int ret;
> +
> +	/* ASMedia get version and date format is xxxxxx.xxxxxx */
> +	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +
> +	ret = nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> +
> +	/*
> +	 * Asmedia NVM size fixed on 512K. We currently have no plan
> +	 * to increase size in the future.
> +	 */
> +	nvm->nvm_size = SZ_512K;
> +
> +	return 0;
> +}
> +
> +static void tb_switch_set_nvm_upgrade(struct tb_switch *sw)
> +{
> +	sw->no_nvm_upgrade = false;
> +}
> +
>  static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
>  	.read_version = intel_nvm_version,
>  	.validate = intel_nvm_validate,
>  };
> 
> +static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
> +	.nvm_upgrade = tb_switch_set_nvm_upgrade,

This is bad name IMHO. It does not really upragade the NVM so perhaps
something like .nvm_upgradeable?

Hower, I don't think this is needed at all because instead of the hack
in tb_start():

	tb->root_switch->no_nvm_upgrade = true;

we should make this:

	tb->root_switch->no_nvm_upgrade = !tb_switch_is_usb4(sw);

and then it only depends on the fact whether the router implements the
necessary NVM operations (please double check if this actually works).

> +	.read_version = asmedia_nvm_version,
> +};
> +
>  struct switch_nvm_vendor {
>  	u16 vendor;
>  	const struct tb_nvm_vendor_ops *vops;
> @@ -143,6 +190,27 @@ static const struct switch_nvm_vendor switch_nvm_vendors[] = {
>  	{ 0x8087, &intel_switch_nvm_ops },
>  };
> 
> +/**
> + * tb_switch_nvm_upgradeable() - Enable NVM upgrade of a switch
> + * @sw: Switch whose NVM upgrade to enable
> + *
> + * This function must be called before creating the switch devices, it will
> + * make the no_active NVM device visible.

non_active

> + */
> +void tb_switch_nvm_upgradeable(struct tb_switch *sw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
> +		const struct switch_nvm_vendor *v = &switch_nvm_vendors[i];
> +
> +		if (v->vendor == sw->config.vendor_id) {
> +			if (v->vops->nvm_upgrade)
> +				v->vops->nvm_upgrade(sw);
> +		}
> +	}
> +}
> +
>  /**
>   * tb_switch_nvm_validate() - Validate NVM image
>   * @switch: Switch to NVM write
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 2dbfd75202bf..f8dc18f6c5c8 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -2822,6 +2822,9 @@ int tb_switch_add(struct tb_switch *sw)
>  			return ret;
>  	}
> 
> +	/* Enable the NVM firmware upgrade */
> +	tb_switch_nvm_upgradeable(sw);
> +
>  	ret = device_add(&sw->dev);
>  	if (ret) {
>  		dev_err(&sw->dev, "failed to add device: %d\n", ret);
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 9cf62d5f25d2..642af7473851 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -773,6 +773,7 @@ int tb_switch_reset(struct tb_switch *sw);
>  int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>  			   u32 value, int timeout_msec);
>  int tb_switch_nvm_validate(struct tb_switch *sw);
> +void tb_switch_nvm_upgradeable(struct tb_switch *sw);
>  void tb_sw_set_unplugged(struct tb_switch *sw);
>  struct tb_port *tb_switch_find_port(struct tb_switch *sw,
> 				    enum tb_port_type type);
> --
> 2.34.1
