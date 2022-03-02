Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD34CAB2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiCBRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCBRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:10:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7E6342;
        Wed,  2 Mar 2022 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646240981; x=1677776981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARu95SNjYvUW6s+dQ5hSBTaIXLn2LgPc0xfUHeJLPZ8=;
  b=Kcnwq8R/yC952bKJDjGmx4d8EwmscA4Ac5uEyQ0MaKD4CW7TZOtsVBXh
   7u0iB61y0FvWqXn3Onu7RSiRWof4mPOucmAqP7j2bEnA71q4QZPER2UOb
   cDhlV1CPYWAGXN06fYLCFruln7j2y61Au1JfDF+B9V/WYRG4eggm3aV8c
   +aVRORwTVqAm7hk/HigDBFK9hitQaVgBIPXJJsjcLCNPWnXk6ZtciWKqn
   bGklHoGHpPSGZcBNfmHvcW0jkFvMW2LVVsC3DVkl9u8zRuSycefSka/H7
   3ZeK7HCQTZpZ2inApn2OqZAG0Fa6P06bM9n+kzPk1KYR1IWroNUbLZCIr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251027450"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="251027450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:09:15 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="511078765"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:09:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPSSf-00APUi-LB;
        Wed, 02 Mar 2022 19:08:25 +0200
Date:   Wed, 2 Mar 2022 19:08:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nvdimm@lists.linux.dev, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: Switch to use list_entry_is_head() helper
Message-ID: <Yh+kiSMZPleBcOXh@smile.fi.intel.com>
References: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com>
 <Yh+SHs4CEWkiLxAe@smile.fi.intel.com>
 <CAJZ5v0g_3a7A5aFab6ZsM8nPDmivoTeNgdSG17Lt71mFKmNxmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_3a7A5aFab6ZsM8nPDmivoTeNgdSG17Lt71mFKmNxmg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:36:20PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 2, 2022 at 4:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 11, 2022 at 01:04:23PM +0200, Andy Shevchenko wrote:
> > > Since we got list_entry_is_head() helper in the generic header,
> > > we may switch the ACPI modules to use it. This eliminates the
> > > need in additional variable. In some cases it reduces critical
> > > sections as well.
> >
> > Besides the work required in a couple of cases (LKP) there is an
> > ongoing discussion about list loops (and this particular API).
> >
> > Rafael, what do you think is the best course of action here?
> 
> I think the current approach is to do the opposite of what this patch
> is attempting to do: avoid using the list iterator outside of the
> loop.

OK, let's drop this change.

-- 
With Best Regards,
Andy Shevchenko


