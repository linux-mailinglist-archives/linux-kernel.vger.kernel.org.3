Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70445A7B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiHaK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHaK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:28:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D81BCCD6;
        Wed, 31 Aug 2022 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661941679; x=1693477679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNYVpN/NsMsBfAGs/hbgZ3dMWqsJF2rw5nX56s7ZTL0=;
  b=nESgRqcWuW1SMq7Uk4UKA5SE3QW3BEEy2paVt/qjpz6TD0dd7WhtWhQ3
   CNKSoCaeMWPO4GslKd0XOnAVJhhWDm2O+fomBsv0dRTgP+iqh0+LQ1iXj
   xRtAhjRlYMKRYKnY6/hkR4KxnxFAPRuT9ImvzJyE60/6QYgmXiIRQWCZU
   adGavMD+NajWMkSXlf+EkU98A+EXTof5D51Az9QHqGyF8hE0zbFLVIGKD
   wkhz+t+F/qhGMkiDNaklUGGDtktOsronDRANLPeQ6O0yYsDcAAGR4Mm73
   tH1jpeTmbyYg0ErAMFlzH5KEC4xiS6/vTaigky3lPvPlfi4w4+f4lErZA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275166261"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="275166261"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 03:27:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="680381338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 03:27:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTKwr-006KhY-2N;
        Wed, 31 Aug 2022 13:27:53 +0300
Date:   Wed, 31 Aug 2022 13:27:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Mika Westerberg' <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 2/3] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw83qaJVhoUdUgap@smile.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-2-andriy.shevchenko@linux.intel.com>
 <Yw71GqF5x7u16yom@black.fi.intel.com>
 <Yw8rPW39Vif4yVAf@smile.fi.intel.com>
 <8989df1c-8fa7-be27-c2f0-e528604e474a@redhat.com>
 <Yw8uiAv95LbBh2FD@black.fi.intel.com>
 <bce5d03cd5ea4aa78ed679399dde0759@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce5d03cd5ea4aa78ed679399dde0759@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:06:09AM +0000, David Laight wrote:
> From: Mika Westerberg
> > Sent: 31 August 2022 10:49
> > On Wed, Aug 31, 2022 at 11:37:21AM +0200, Hans de Goede wrote:
> > > On 8/31/22 11:34, Andy Shevchenko wrote:
> > > > On Wed, Aug 31, 2022 at 08:43:54AM +0300, Mika Westerberg wrote:
> > > >> On Tue, Aug 30, 2022 at 08:11:54PM +0300, Andy Shevchenko wrote:
> > > >>> -#define VR_MODE_DISABLED        0
> > > >>> -#define VR_MODE_AUTO            BIT(0)
> > > >>> -#define VR_MODE_NORMAL          BIT(1)
> > > >>> -#define VR_MODE_SWITCH          BIT(2)
> > > >>> -#define VR_MODE_ECO             (BIT(0)|BIT(1))
> > > >>> +#define PMIC_REG_MASK		GENMASK(11, 0)
> > > >>> +
> > > >>> +#define VR_MODE_DISABLED        (0 << 0)
> > > >>> +#define VR_MODE_AUTO            (1 << 0)
> > > >>> +#define VR_MODE_NORMAL          (2 << 0)
> > > >>> +#define VR_MODE_ECO             (3 << 0)
> > > >>> +#define VR_MODE_SWITCH          (4 << 0)
> > > >>
> > > >> IMHO this one is worse than what it was.
> > > >
> > > > I'm not sure why. Here is obvious wrong use of BIT() macro against
> > > > plain numbers. I can split it into a separate change with an explanation
> > > > of why it's better. But I think it doesn't worth the churn.
> > >
> > > FWIW I'm with Andy here, the VR_MODE_ECO clearly is trying
> > > to just say 3, so this is just a plain enum for values 0-4 and
> > > as such should not use the BIT macros.
> > 
> > Yeah, enum would look better but the << 0 just makes me confused ;-)
> 
> No idea what that code is doing.
> The values are all used to initialise a .bit structure member.
> So maybe BIT() is right.
> The _ECO value isn't used at all.
> 
> Deeper analysis may be needed.

So, can you do that since you already started?

-- 
With Best Regards,
Andy Shevchenko


