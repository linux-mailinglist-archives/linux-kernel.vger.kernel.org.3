Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13654B1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiFNNBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiFNNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:01:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4233EA7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655211701; x=1686747701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zRFuyf2koCxcTUK6tBYygRK9GVKRlUR6Qa4BeN0XSs4=;
  b=e+EOtpLBnPc37Edinii7SgFrt6w72u9f3dfArh/oCeTqaEH4iEqQotAl
   ijBIz5RP9hfp7CuQe8MdWjICLY6uGbgZxH3LkK9YaYcFl9fTbmoXRjBfI
   6QkeFXqF+IvCGyTW29DcK27ZMovKg0jnUqmOBKj34PBB5Wl/KBXwAi/qR
   eazC217lvEM+0Zp8/QI1K6mvv8OjiIWMfrul8stj+bcvAnuHJlbGGu8NK
   KNQmHU5HdbTV7ANBieqGPYqm5bnEXEQaQoKlnAWvKntkpwb61ds8uwY5O
   Vg8yTWytvICui95fEnvDrYBrywFPRqHJDkVWleADrrIW4/k4BQ3nQ67vF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261638286"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261638286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:01:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652024736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:01:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o16Ab-000cND-S6;
        Tue, 14 Jun 2022 16:01:21 +0300
Date:   Tue, 14 Jun 2022 16:01:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Message-ID: <YqiGocQ+vr9KjUHK@smile.fi.intel.com>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
 <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:23:21PM +0200, Hans de Goede wrote:
> On 6/13/22 18:08, Andy Shevchenko wrote:
> > On some platforms, like Intel Merrifield, the writing values during power on
> > may timeout:
> > 
> >    tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
> >    phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
> >    dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
> >    dwc3: probe of dwc3.0.auto failed with error -110
> > 
> > which effectively fails the probe of the USB controller.
> > Drop the check as it was before the culprit commit (see Fixes tag).
> > 
> > Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() error checking")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Copy and pasting my reply about this in another thread to keep everyone up2date:

Thanks! My replies below.

> """
> In my experience with using the phy for charger-type detection on some
> x86 android tablets which don't have any other way to do charger detection,
> these errors indicate a real communication issue for reading/writing
> phy registers. At the same time this usually does not seem to be a big
> problem since the phy seems to work fine with its power-on defaults.
> 
> In case of Bay Trail these errors were related to 2 things:
> 
> 1. Autosuspend of the phy-interface block in the dwc3, fixed by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7c93a903f33ff35aa0e6b5a8032eb9755b00826
> 
> But dwc3_pci_mrfld_properties[] already sets "snps,dis_u2_susphy_quirk",
> so I guess it is not this.
> 
> 2. There being no delay in tusb1210_power_on() between toggling the
> reset IO and then trying to communicate with the phy, fixed in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df37c99815d9e0775e67276d70c93cbc25f31c70
> 
> Maybe the:
> 
> #define TUSB1210_RESET_TIME_MS				30

Actually it's 50.

> Added by that commit needs to be a bit bigger for the possibly
> older phy revision used on the merifield boards?
> 
> (note it is fine to just increase it a bit everywhere).
> """
> 
> IMHO it would be good to try and increase TUSB1210_RESET_TIME_MS (start with say 100
> and then see if e.g. 50 also works). If increasing that does not work

No help

[   35.126397] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer reset
[   35.126418] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
[   35.126455] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
[   35.126465] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer reset found
[   35.126476] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer cs
[   35.126485] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
[   35.126538] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
[   35.126548] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer cs found
[   40.534107] tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80

(I put 5000 ms there to be sure)

> I'm fine with going with this workaround patch to fix things.

-- 
With Best Regards,
Andy Shevchenko


