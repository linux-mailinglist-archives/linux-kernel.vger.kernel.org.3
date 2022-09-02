Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCB5AAC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiIBKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiIBKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:10:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B221EACF;
        Fri,  2 Sep 2022 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662112806; x=1693648806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5yiK5rUDQoz1xNFejou9U29PuuXFBd9NflB5rlSdd8=;
  b=GCnh3tCbGSvSqMiU1SKpoaqBYDJsF94lE3HChB4rVxBhnQHXBPZ6P4BQ
   ia3FgIozybfB6QN633F5AtiyxbyLfd+4988U3TUjIWbyxFR95T7IlzIHp
   iwfd/3Q+EQPMw14vQeIH64KzNeEbGvpPdXdIr0gsKWEP/TfTpajLuTHq2
   8F4O3ITy0kRuVF8cLhWNglYYpwi/PuPwbvNcx/PMzh8uvadoyJfJkELGe
   t99O7Yre7O7QAejvXLkeILHXb5PfOPuNfVks9iV0z88zbwjrotjP2tD+q
   Aoz8Hcitgu7VrNN8ZES4CNqSUF0f1x340GaYh21iJNhzk5RqiCRqD2y89
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296729181"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296729181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:00:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="590017514"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:00:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oU3Sz-007Jv5-0b;
        Fri, 02 Sep 2022 13:00:01 +0300
Date:   Fri, 2 Sep 2022 13:00:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <YxHUIBaEwG3pxGnT@smile.fi.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
 <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
 <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
 <Yw+0jGdk2pIQSoOT@smile.fi.intel.com>
 <073c2dce-bd03-9dfe-539f-203b6fb7eeaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073c2dce-bd03-9dfe-539f-203b6fb7eeaf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 11:02:11AM +0200, Hans de Goede wrote:
> On 8/31/22 21:20, Andy Shevchenko wrote:
> > On Wed, Aug 31, 2022 at 08:19:24PM +0200, Hans de Goede wrote:
> >> On 8/31/22 15:57, Andy Shevchenko wrote:

...

> >>> -	if (regmap_read(regmap, (reg - 1), &val))
> >>> -		return -EIO;
> >>> -	temp_h = (u8) val;
> >>
> >> Hmm, you are changing the order of the register
> >> reads here. The old code is doing:
> >>
> >> 	read(reg);
> >> 	read(reg -1);
> >>
> >> Where as the new code is doing:
> >>
> >> 	read(reg -1);
> >> 	read(reg);
> >>
> >> The order matters since typically upon reading the
> >> low byte, the high bits will get latched so that
> >> the next read of the high bytes uses the bits
> >> from the same x-bits value as the low 8 bits.
> >>
> >> This avoids things like:
> >>
> >> 1. Entire register value (all bits) 0x0ff
> >> 2. Read reg with low 8 bits, read 0x0ff
> >> 3. Entire register value becomes 0x100
> >> 4. Read reg with high bits
> >> 5. Combined value now reads as 0x1ff
> >>
> >> I have no idea if the bxtwc PMIC latches
> >> the bits, but giving the lack of documentation
> >> it would IMHO be better to not change the reading order.
> > 
> > Interestingly documentation suggests otherwise, e.g.:
> > 
> > THRMZN0H_REG
> > Battery Thermal Zone 0 Limit Register High
> > Offset 044H
> > 
> > Description
> > 
> > Z0HYS	  Temperature hysteresis value for TCOLD threshold
> > 
> > Z0CURHYS  Battery ChargerTemperature Zone Current hysteresis for TCOLD (MSBs)
> > 	  3 bits of the battery charger temperature zone current hysteresis for zones 0/1.
> > 
> > TCOLD_H	  Battery ChargerTemperature Zone Threshold for TCOLD (MSBs)
> > 	  Upper 1 bit of the battery charger temperature zone threshold for zones 0/1.
> > 	  Writes to THRMZN0H (and all thermal zone registers) are not committed until
> > 	  THRMZN0L (lower byte) is written to.
> > 	  Write Before: THRMZN0L_REG.TCOLD_L
> > 
> > (Note the last description)
> 
> I see, but that is about writes and the write path was already
> first doing a read + write of reg - 1, followed by writing
> reg 1. So for the write path this patch does not introduce
> any functional changes. But what about the read path, is read
> latching the same or does it need the inverse order of writes?
> 
> Note I think it is likely the read order for proper latching
> is likely also first high then low, but it would be good to check.
> If that is indeed the case then this would actually be a bugfix,
> not just a cleanup.
> 
> Also you have only checked for 1 of the 4 PMICs you are making
> changes to in this patch?
> 
> The commit message suggests this code change does not cause any
> functional changes, but as discussed it actually does make changes,
> so this should be in the commit message.
> 
> Talking about making changes to 4 PMICs unlike patch 1 and 3 the changes
> in this one are not trivial so IMHO this should be split into 1 patch
> per PMIC. This has 3 advantages:
> 
> 1. It makes reviewing easier, during my initial review I stopped
> at the intel_bxtwc_pmic changes not even realizing more was coming...
> 
> 2. This makes properly describing the actual functional changes
> in the commit message a lot easier, otherwise the commit msg
> is going to become somewhat messy.
> 
> 3. This will also make reverting things easier if something does
> break (even if it is just for testing if these changes are the cause
> of the breakage).
> 
> ###
> 
> So I've been taking a closer look at these changes and here are some
> more remarks:
> 
> intel_crc_pmic_get_raw_temp() you are again changing the order
> in which the 2 (low/high) registers are read. This needs to be
> checked and mentioned in the commit message.
> 
> intel_crc_pmic_update_aux() unlike the intel_pmic_bxtwc.c
> equivalent in this case your changes do switch the write-order,
> assuming the same write order as in bxtwc should be used
> this would actually be another bugfix.
> 
> For intel_pmic_chtdc_ti.c this does seems to be purely a refactor.
> 
> For intel_pmic_xpower.c the original code actually seems
> to be wrong, the datasheet says:
> 
> REG 5AH: GPADC pin input ADC data, highest 8bit
> Bit 7-0 GPADC pin input ADC data, highest 8bit
> 
> REG 5BH: GPADC pin input ADC data, lowest 4bit
> Bit 7-4 Reserved
> Bit 3-0 GPADC pin input ADC data, lowest 4bit

> So it looks like instead of your patch we actually need

Not instead, but probably as a prerequisite fix.

> the following fix:
> 
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -257,7 +257,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  
>  	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
>  	if (ret == 0)
> -		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
> +		ret = (buf[0] << 4) | (buf[1] & 0x0f);
>  
>  	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>  		regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
> 
> I will try to make some time to check this on actual hw to see if
> the code or the doc is right soon-ish

Thanks for your review and explanations. I will split pure cleanups and resend
with Mika's tag, and will see what I can do about the rest (considering
availability of the documentation and it's fullness).

-- 
With Best Regards,
Andy Shevchenko


