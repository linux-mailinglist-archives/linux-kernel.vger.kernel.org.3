Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7511D4EC8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbiC3P5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348471AbiC3P5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:57:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3341E032
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648655728; x=1680191728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=imgBikfhZr82zU3PBkryKfey7V06+8mpRuA1SfZVnbs=;
  b=KoNoPzdZP8OeR08rNH4Q95uSgvH3Xaa4xjLp3qVhFXQqV3Xm0p/07/0j
   EnO0hbhx5wlGqiwOdSrwZaq+pn0iVil0+X3KQ+YaXT8/I6IOiG4ISc+FA
   wElR5I6gDCaAELFsSXfm1Y6fVNUeAoATjNfrmOtQkGDvPd9IHjjq4GhKL
   b0apBGJ/+WhFznAyQlfok5ixqAWc3fA63QoLA9vrvpU4mkoIKojbbE2rG
   jMi8hmtGQG8YtC94SXhADRD+ff+1vTPTg4la+VRDQV7xrwkTaHfx8cUSh
   MW2JWQ7gq/6ygpbg//l29TuCD2u8e1Dgg06YE/lkjhsfq3t6mWaLkOGRn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247077479"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="247077479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:55:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565603486"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:55:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZaeq-009UHk-By;
        Wed, 30 Mar 2022 18:54:52 +0300
Date:   Wed, 30 Mar 2022 18:54:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: undef REG_IN/REG_OUT to avoid define collisions
Message-ID: <YkR9TD4+9LzH1N6b@smile.fi.intel.com>
References: <20220330152808.1461758-1-narmstrong@baylibre.com>
 <c54c8c77-d35f-49b0-ff2f-21eb597f41f0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54c8c77-d35f-49b0-ff2f-21eb597f41f0@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:33:26AM -0700, Dave Hansen wrote:
> On 3/30/22 08:28, Neil Armstrong wrote:
> > These defines are only used in the inline functions declared
> > in the arch_hweight.h file, and collides with internal defines
> > of the Amlogic Mes pinctrl driver when COMPILE_TEST is enabled:
> > 
> > arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
> > 9 | #define REG_OUT "a"
> >   |                 ^~~
> > drivers/pinctrl/meson/pinctrl-meson.h:69:9: note: in expansion of macro ‘REG_OUT’
> > 69 |         REG_OUT,

Thanks for the patch!

> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  arch/x86/include/asm/arch_hweight.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
> > index ba88edd0d58b..139a4b0a2a14 100644
> > --- a/arch/x86/include/asm/arch_hweight.h
> > +++ b/arch/x86/include/asm/arch_hweight.h
> > @@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
> >  }
> >  #endif /* CONFIG_X86_32 */
> >  
> > +#undef REG_IN
> > +#undef REG_OUT
> 
> Wouldn't it be a bit less hackish to give these a more qualified name
> like HWEIGHT_REG_IN?

Either way, would it be good to undef them here anyway?

-- 
With Best Regards,
Andy Shevchenko


