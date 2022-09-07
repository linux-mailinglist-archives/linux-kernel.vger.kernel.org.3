Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4615B068A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiIGO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIGO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:28:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62713EB2;
        Wed,  7 Sep 2022 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662560874; x=1694096874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yPHRVWO3U0npV4VOBqkt491C2RssIupsalxDqSwaFLY=;
  b=eG1ONWzR/PO9VGuZaXLxIW1OcAU3ADU9+Du/iRdixBa4472VJl4walP3
   9LMEc5swLw0J9N81PlXKinlvnNI9kA15Xk2UU5hgfIjrb/2w47m0pBjQO
   4K2yLU2tcQEv1Try/HQ8pLSHCT2+Z5CNeO9vT877vwTKCwFqOWD1djYYb
   yl9/VI6IeVvd2A43gFr32ZSDzXFcE1FeEZPvc/QDB+aiOGH3jf09f0bkT
   CzrYx6d6D93GA/l25Teom26vE2fzE44LrBHub1j+UN+QogSPaYw7MA5FT
   TKaJK00y3zkTvA4WU+VxQ9pIrTU9w75r7WgaJAU/GliTpIXGteWz/PtYJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279897897"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="279897897"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:27:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="756792434"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:27:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVw1S-009gLv-1d;
        Wed, 07 Sep 2022 17:27:22 +0300
Date:   Wed, 7 Sep 2022 17:27:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/9] pwm: lpss: Deduplicate board info data structures
Message-ID: <YxiqSiP4dTa2bhUh@smile.fi.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220907090412.kqvbmgfgeb4toz5n@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907090412.kqvbmgfgeb4toz5n@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:04:12AM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 06, 2022 at 10:57:27PM +0300, Andy Shevchenko wrote:
> > With help of __maybe_unused, that allows to avoid compilation warnings,
> > move the board info structures from the C files to the common header
> > and hence deduplicate configuration data.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-lpss-pci.c      | 29 -----------------------------
> >  drivers/pwm/pwm-lpss-platform.c | 23 -----------------------
> >  drivers/pwm/pwm-lpss.h          | 30 ++++++++++++++++++++++++++++++
> 
> Given that both the pci driver and the platform driver alread depend on
> pwm-lpss.o, I'd prefer something like the patch below to really
> deduplicate the data.

Why not? I can use yours in v2. Can I get your SoB tag?

> One thing to note is that the two pwm_lpss_bsw_info are not identical. I
> didn't check how that is relevant. Did you check that?

Yes, ACPI version should be used. Because switch to ACPI/PCI is done in BIOS
while quite likely the rest of AML code is the same, meaning similar issue
might be observed. The no bug report is due to no PCI enabled device in the
wild, I think, and only reference boards can be tested, so nobody really cares
about PCI Braswell case.

-- 
With Best Regards,
Andy Shevchenko


