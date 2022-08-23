Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807259E77F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiHWQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244852AbiHWQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:35:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98575F9BC;
        Tue, 23 Aug 2022 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661266188; x=1692802188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nVvnzp2ylVv0Zwij6Km7MPEjpSV2LnhJfonpoK0PZHE=;
  b=CKJRpDESGlujIXKgkcvlKAY4YbxGaoDb7q/Ne/Ku9oElrH2HYfft9rjT
   GinAz2BjMOjQdpbThJx+uXT7MeuJP0SvFAh3W5jpwxJcThHKUfVl0Ql3y
   untXqmvSNmmfoIRWEyQvYoJCANe159OM5K9U79PFLgNPYjQmSSyfVTVJ/
   iVLtA9DAo6nbBsvPp+gANPVGtM/ul/vJvt695mUQPC2pN/lrUq+q0NDUb
   ICmBj4vgrmcBWlOFe2WYLZBeqJDLRqPY2rGJODOmUoOdDzuMKx8pgJ0+c
   MeUMpS/scGGNL1pYQd+Wu+fFbODtLpTODNtY6FuR+62uDhJT++D+xcj+/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="293705486"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="293705486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:49:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638682397"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:49:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQVDp-002Tzk-1e;
        Tue, 23 Aug 2022 17:49:41 +0300
Date:   Tue, 23 Aug 2022 17:49:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v4 0/5] add support for another simatic board
Message-ID: <YwTpBRHaihXsd2n4@smile.fi.intel.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:23:39PM +0200, Henning Schild wrote:
> changes since v3:
>   - update Kconfig as well
>   - drop chip names from comment in driver header
>   - add manufacturer check for Fintek again, Nuvoton not possible
>   - drop revision printing for Nuvoton
>   - restructure defines again
>   - add new model 427G
> 
> changes since v2: (p1 only)
>   - rename macros that change behavior
>   - use chip type not device id in the macros
>   - reorder defines a bit
> 
> changes since v1:
>   - remove unused define
>   - fix bug where (base + 2) was used as second data bit
>   - add macros for "inverted" and "single data bit"

For the non-commented patches:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> This series first enables a SuperIO GPIO driver to support a chip from
> the vendor Nuvoton, the driver is for Fintek devices but those just are
> very similar. And in watchdog and hwmon subsystems these SuperIO drivers
> also share code and are sometimes called a family.
> 
> In another step the individual banks receive a label to tell them apart,
> a step which potentially changes an interface to legacy users that might
> rely on all banks having the same label, or an exact label. But since a
> later patch wants to use GPIO_LOOKUP unique labels are needed and i
> decided to assign them for all supported chips.
> 
> In a following patch the Simatic GPIO LED driver is extended to provide
> LEDs in case that SuperIO GPIO driver can be loaded.
> 
> Last but not least the watchdog module of that same SuperIO gets loaded
> on a best effort basis.
> 
> Note similar patches have appreared before as
>   "[PATCH v3 0/1] add device driver for Nuvoton SIO gpio function"
> The main difference here is that i added chip support to an existing
> driver instead of creating a new one. And that i actually propose all
> patches and do not just have the LED patch for Simatic as an example.

> Also note that the patches are based on
>   "[PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper"

No need, it's upstream (v6.0-rc1 onwards).

> Henning Schild (5):
>   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
>   gpio-f7188x: use unique labels for banks/chips
>   leds: simatic-ipc-leds-gpio: add new model 227G
>   platform/x86: simatic-ipc: enable watchdog for 227G
>   platform/x86: simatic-ipc: add new model 427G
> 
>  drivers/gpio/Kconfig                          |   3 +-
>  drivers/gpio/gpio-f7188x.c                    | 229 +++++++++++-------
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
>  drivers/platform/x86/simatic-ipc.c            |  10 +-
>  .../platform_data/x86/simatic-ipc-base.h      |   1 +
>  include/linux/platform_data/x86/simatic-ipc.h |   2 +
>  6 files changed, 194 insertions(+), 93 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


