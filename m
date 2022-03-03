Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C94CB82B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiCCHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCCHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:54:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC416F960;
        Wed,  2 Mar 2022 23:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646294053; x=1677830053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/d2xM5QHwo48QlJhIIi1Xm1eu2owKNVfYPj+uvB7DE=;
  b=E5XWVMiFXWfa50RdckcLz4v0p17w4Kw015LpUCgZ0VH7fFFCuDoHQkDw
   OnMzMeBEy1CsdXdSwsjwLua1dU+FlzCu4FWvr8Iu/hIkQapkhZuuYtQQ3
   O5GKdW6IilfR/hKdRKyIBKuW2JDYjfLsDTObpHhnfagbXjgs2KCL4Sk0J
   sLR5G3s2M7SaupOSKCzYHwmq2DPG0tg3ZaVb/0jsAv1e5ZrUjcJ2jcWn3
   9KA2nnctT/MCESSdHkRvktnf5LjtYnbDLvlMK/3s4cPHS178s5HbSBA+y
   YCQ9RTM2vk/pERE0TbRZfw3+VCH6KpkBHsW754Ydydr0WaUs3uc4HLiuY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="241023334"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="241023334"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:54:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="508496453"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 23:54:10 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Mar 2022 09:54:08 +0200
Date:   Thu, 3 Mar 2022 09:54:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
Subject: Re: [PATCH 4/5] drivers/thunderbolt: Clarify/correct register
 offsets for tb_cap_plug_events
Message-ID: <YiB0IFe96XIORdUz@lahna>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
 <20220302220709.3138846-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220709.3138846-4-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:07:08PM -0600, Mario Limonciello wrote:
> The USB4 1.0 specification outlines the `cap_plug_events` structure in
> table 13-14 located on page 507.  This shows that there was a mistake
> in VSC_CS_1 where plug events disable should be 4 bits and
> "TBT3-Compatible" should be 3 bits.
> 
> While correcting the mistake, update the names and comments to more
> closely match the specification.  This should not change anything
> functionally.
> 
> Link: https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/tb_regs.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 70795a2aa9bb..8c42f8bc679e 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -146,14 +146,14 @@ struct tb_eeprom_ctl {
>  
>  struct tb_cap_plug_events {
>  	struct tb_cap_extended_short cap_header;
> -	u32 __unknown1:2;
> -	u32 plug_events:5;
> -	u32 __unknown2:25;
> -	u32 __unknown3;
> -	u32 __unknown4;
> +	u32 __unknown1:3; /* VSC_CS_1 */
> +	u32 plug_events:4; /* VSC_CS_1 */
> +	u32 __unknown2:25; /* VSC_CS_1 */
> +	u32 vsc_cs_2;
> +	u32 vsc_cs_3;
>  	struct tb_eeprom_ctl eeprom_ctl;
> -	u32 __unknown5[7];
> -	u32 drom_offset; /* 32 bit register, but eeprom addresses are 16 bit */
> +	u32 __unknown5[7]; /* VSC_CS_5 -> VSC_CS_11 */
> +	u32 drom_offset; /* VSC_CS_12: 32 bit register, but eeprom addresses are 16 bit */
>  } __packed;
>  
>  /* device headers */
> @@ -464,6 +464,10 @@ struct tb_regs_hop {
>  
>  /* Plug Events registers */
>  #define TB_PLUG_EVENTS_USB_DISABLE		BIT(2)
> +#define USB4_PLUG_EVENTS_LANE_DISABLE		BIT(3)
> +#define USB4_PLUG_EVENTS_DPOUT_DISABLE		BIT(4)
> +#define USB4_PLUG_EVENTS_LOW_DPIN_DISABLE	BIT(5)
> +#define USB4_PLUG_EVENTS_HIGH_DPIN_DISABLE	BIT(6)

Since this is TBT3 "compatible" we should use TB_ prefix. What about:

TB_PLUG_EVENTS_CS_1_ ?

or 

TB_VSEC_3_CS_1_ ?

something that is easy to match with the register name in the USB4 spec.
