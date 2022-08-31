Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45C5A86A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiHaTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:20:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019EADD77B;
        Wed, 31 Aug 2022 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661973654; x=1693509654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahvQcX8fFW0ZaNfhzR+hOhVpeAqhSHt6rGRNvA6Oc/w=;
  b=Oo90mWw8PXDVrwqIlfYaGCiPqPg6m65OAQceBr2XYwj9lza975FLkNLZ
   48xOsSIvrIno/DhMutA+Bni+3VKCecNRafYWWnb+Qt2PGXevZKkrHr7U3
   86B+obniS+lnnujmvtPRpwQPobKh2TJW7bD34vBO7sK3eKyl7z3CFFR59
   0UHirNtvU3u8t5SZFuLPOUrwz32JJkNlygfgO9/SmuDFBxrN9YRMGWJHA
   8qVd2MIfNeH3Oy7Am2PQRs0boRV2fUkWhstT9bLjHE30mUa89Px7WCbVE
   0LcTk7oi7MByLXZDcq2l468J2Puh/Q9249VOn8NR7cmOIY6ZXfn4V3l/j
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="359484948"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="359484948"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:20:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563146999"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 12:20:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTTGW-006VmD-1j;
        Wed, 31 Aug 2022 22:20:44 +0300
Date:   Wed, 31 Aug 2022 22:20:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw+0jGdk2pIQSoOT@smile.fi.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
 <20220831135749.78743-2-andriy.shevchenko@linux.intel.com>
 <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f388bda-b991-0ab6-4098-4f5dbabe57fb@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:19:24PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/31/22 15:57, Andy Shevchenko wrote:
> > It's easier to understand the nature of a data type when
> > it's written explicitly. With that, replace open coded
> > endianess conversion.
> > 
> > As a side effect it fixes the returned value of
> > intel_crc_pmic_update_aux() since ACPI PMIC core code
> > expects negative or zero and never uses positive one.
> > 
> > While at it, use macros from bits.h to reduce a room for mistake.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > v3: added tag (Mika)
> >  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 50 +++++++++++--------------
> >  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 20 +++++++---
> >  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 ++++---
> >  drivers/acpi/pmic/intel_pmic_xpower.c   | 10 +++--
> >  4 files changed, 51 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> > index e247615189fa..90a2e62a37e4 100644
> > --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
> > +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> > @@ -7,19 +7,20 @@
> >  
> >  #include <linux/init.h>
> >  #include <linux/acpi.h>
> > +#include <linux/bits.h>
> > +#include <linux/byteorder/generic.h>
> >  #include <linux/mfd/intel_soc_pmic.h>
> >  #include <linux/regmap.h>
> >  #include <linux/platform_device.h>
> >  #include "intel_pmic.h"
> >  
> > -#define WHISKEY_COVE_ALRT_HIGH_BIT_MASK 0x0F
> > -#define WHISKEY_COVE_ADC_HIGH_BIT(x)	(((x & 0x0F) << 8))
> > -#define WHISKEY_COVE_ADC_CURSRC(x)	(((x & 0xF0) >> 4))
> > -#define VR_MODE_DISABLED        0
> > -#define VR_MODE_AUTO            BIT(0)
> > -#define VR_MODE_NORMAL          BIT(1)
> > -#define VR_MODE_SWITCH          BIT(2)
> > -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> > +#define PMIC_REG_MASK		GENMASK(11, 0)
> > +
> > +#define VR_MODE_DISABLED        (0 << 0)
> > +#define VR_MODE_AUTO            (1 << 0)
> > +#define VR_MODE_NORMAL          (2 << 0)
> > +#define VR_MODE_ECO             (3 << 0)
> > +#define VR_MODE_SWITCH          (4 << 0)
> >  #define VSWITCH2_OUTPUT         BIT(5)
> >  #define VSWITCH1_OUTPUT         BIT(4)
> >  #define VUSBPHY_CHARGE          BIT(1)
> > @@ -297,25 +298,20 @@ static int intel_bxtwc_pmic_update_power(struct regmap *regmap, int reg,
> >  
> >  static int intel_bxtwc_pmic_get_raw_temp(struct regmap *regmap, int reg)
> >  {
> > -	unsigned int val, adc_val, reg_val;
> > -	u8 temp_l, temp_h, cursrc;
> >  	unsigned long rlsb;
> >  	static const unsigned long rlsb_array[] = {
> >  		0, 260420, 130210, 65100, 32550, 16280,
> >  		8140, 4070, 2030, 0, 260420, 130210 };
> > +	unsigned int adc_val, reg_val;
> > +	__be16 buf;
> >  
> > -	if (regmap_read(regmap, reg, &val))
> > +	if (regmap_bulk_read(regmap, reg - 1, &buf, sizeof(buf)))
> >  		return -EIO;
> > -	temp_l = (u8) val;
> >  
> > -	if (regmap_read(regmap, (reg - 1), &val))
> > -		return -EIO;
> > -	temp_h = (u8) val;
> 
> Hmm, you are changing the order of the register
> reads here. The old code is doing:
> 
> 	read(reg);
> 	read(reg -1);
> 
> Where as the new code is doing:
> 
> 	read(reg -1);
> 	read(reg);
> 
> The order matters since typically upon reading the
> low byte, the high bits will get latched so that
> the next read of the high bytes uses the bits
> from the same x-bits value as the low 8 bits.
> 
> This avoids things like:
> 
> 1. Entire register value (all bits) 0x0ff
> 2. Read reg with low 8 bits, read 0x0ff
> 3. Entire register value becomes 0x100
> 4. Read reg with high bits
> 5. Combined value now reads as 0x1ff
> 
> I have no idea if the bxtwc PMIC latches
> the bits, but giving the lack of documentation
> it would IMHO be better to not change the reading order.

Interestingly documentation suggests otherwise, e.g.:

THRMZN0H_REG
Battery Thermal Zone 0 Limit Register High
Offset 044H

Description

Z0HYS	  Temperature hysteresis value for TCOLD threshold

Z0CURHYS  Battery ChargerTemperature Zone Current hysteresis for TCOLD (MSBs)
	  3 bits of the battery charger temperature zone current hysteresis for zones 0/1.

TCOLD_H	  Battery ChargerTemperature Zone Threshold for TCOLD (MSBs)
	  Upper 1 bit of the battery charger temperature zone threshold for zones 0/1.
	  Writes to THRMZN0H (and all thermal zone registers) are not committed until
	  THRMZN0L (lower byte) is written to.
	  Write Before: THRMZN0L_REG.TCOLD_L

(Note the last description)

-- 
With Best Regards,
Andy Shevchenko


