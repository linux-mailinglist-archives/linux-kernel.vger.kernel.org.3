Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0678C59E3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiHWMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbiHWMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:34:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB3010265A;
        Tue, 23 Aug 2022 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661248010; x=1692784010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7RC1ww3NWssyXEpINs/20SD/Nvi+2dHUNA4YOGB/+c=;
  b=j+PXadLNYBNe2bpIv07NeH4oWfC+qqG4qOQ/MNow3ZsgqkISOP1bBhmG
   241wBspo7ozp9GyNDhimPoLQ+3Dnps5V5TeQZFxPIg3+lFKdV78cnWhFm
   8Wivnw2SvFYVfTnHOVndSIa+50xKTVPzv1cYRDNOCMQ55dX1hfKzlPbR9
   DkYhfbKHg47WEvFFeHb+8gWIjASf3rHHz4a/Y8bHu4bT/WtZmsleNAIfu
   2xjijoO0pLg/Mrxd1BYijq7AkNfsXAVLZUq/VGKewfD2FljH9V4e2DNWY
   u2dsNEoHGc2Oa62RjSooCN04SgTyDfeMHmjiYOK8RabHN+3B9K9iTCjRS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276670958"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276670958"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 02:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="677556630"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 02:46:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F2282AD; Tue, 23 Aug 2022 12:46:59 +0300 (EEST)
Date:   Tue, 23 Aug 2022 12:46:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH 2/2] thunderbolt: thunderbolt: add nvm specific
 operations for
Message-ID: <YwSiEx87AuVL/QK4@black.fi.intel.com>
References: <20220823090423.5249-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823090423.5249-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 05:04:23PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch depends on patch 1/2. Add nvm specific operations for ASMedia.
> And add tb_switch_nvm_upgradable() of enable firmware upgrade.

Again the $subject and please call it NVM (capital letters) everywhere.

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/thunderbolt/nvm.c    | 46 ++++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c |  3 +++
>  drivers/thunderbolt/tb.h     |  2 ++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> index 5c7c2a284497..d2ef22f8b19b 100644
> --- a/drivers/thunderbolt/nvm.c
> +++ b/drivers/thunderbolt/nvm.c
> @@ -15,6 +15,9 @@
>  /* Switch NVM support */
>  #define NVM_CSS		0x10
> 
> +/* ASMedia specific NVM offsets */
> +#define ASMEDIA_NVM_VERSION	0x1c
> +
>  static DEFINE_IDA(nvm_ida);
> 
>  static inline int nvm_read(struct tb_switch *sw, unsigned int address,
> @@ -116,11 +119,39 @@ static int intel_nvm_validate(struct tb_switch *sw)
>  	return image_size;
>  }
> 
> +static int asmedia_nvm_version(struct tb_switch *sw)
> +{
> +	struct tb_nvm *nvm = sw->nvm;
> +	u64 val;
> +	int ret;
> +
> +	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	/* ASMedia NVM version show format include Firmware version and date xxxxxx.xxxxxx */
> +	nvm->major = (((u8)val >> 0x18) << 0x10 | ((u8)(val >> 0x20)) << 0x8 | (u8)(val >> 0x28));
> +	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));

Can you use some helperes to make this look nicer?

> +	nvm->nvm_size = SZ_512K;

Some explanation perhaps why 512K? Is it always the case even for the
future NVMs? Can it be read somewhere?

> +
> +	return 0;
> +}
> +
> +static void tb_switch_set_nvm_upgrade(struct tb_switch *sw)
> +{
> +	sw->no_nvm_upgrade = false;
> +}
> +
>  struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
>  	.version = intel_nvm_version,
>  	.validate = intel_nvm_validate,
>  };
> 
> +struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {

const

> +	.nvm_upgrade = tb_switch_set_nvm_upgrade,
> +	.version = asmedia_nvm_version,
> +};
> +
>  struct switch_nvm_vendor {
>  	u16 vendor;
>  	const struct tb_nvm_vendor_ops *vops;
> @@ -129,8 +160,23 @@ struct switch_nvm_vendor {
>  static const struct switch_nvm_vendor switch_nvm_vendors[] = {
>  	{ 0x8086, &intel_switch_nvm_ops },
>  	{ 0x8087, &intel_switch_nvm_ops },
> +	{ 0x174c, &asmedia_switch_nvm_ops },

Ordering, I commented this already last time :(

>  };
> 

If you export it outside of this file, please write kernel-doc.

> +void tb_switch_nvm_upgradable(struct tb_switch *sw)
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
>   * tb_switch_nvm_alloc() - alloc nvm and set nvm->vops to point
>   * the vendor specific operations.
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index d257219cb66e..23df70290ca2 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -2829,6 +2829,9 @@ int tb_switch_add(struct tb_switch *sw)
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
> index 73ae2e093a92..8e2887e9c669 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -75,6 +75,7 @@ enum tb_nvm_write_ops {
>  struct tb_nvm_vendor_ops {
>  	int (*version)(struct tb_switch *sw);
>  	int (*validate)(struct tb_switch *sw);
> +	void (*nvm_upgrade)(struct tb_switch *sw);

Kernel-doc for this too, well and the rest.

>  };
> 
>  #define TB_SWITCH_KEY_SIZE		32
> @@ -748,6 +749,7 @@ static inline void tb_domain_put(struct tb *tb)
>  	put_device(&tb->dev);
>  }
> 
> +void tb_switch_nvm_upgradable(struct tb_switch *sw);

Same comment about the location. Also is it "upgradeable"? 

>  struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
>  struct tb_nvm *tb_nvm_alloc(struct device *dev);
>  int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
> --
> 2.34.1
