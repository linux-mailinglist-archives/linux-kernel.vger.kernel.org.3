Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F318F514975
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359209AbiD2Mht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiD2Mhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:37:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB0C90FB;
        Fri, 29 Apr 2022 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651235669; x=1682771669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+xWYa8I50q7FRALTpyXM0YXJgGA7IXSjZNqvAviJjnY=;
  b=A0m2nJteuHp4JQd3msz6oNWNUVyLTawqhtlK3LG/MNGA8BXjxDxKcTqK
   5gahTICbNIKK2s6BGvUPLBtiys6psfID+SCDkcsSIi1qoeenpGnbKWbjP
   MomfEGHomQDY1TVlfRYfYGBcniuCkhRKf/Dt/FjuuJW9NAOc1LUTnyZQM
   TOXTrQKYKY4mZIDCJj6PUMk+Ld49HHLhxFIjtR59Kyrju76wBb150KrZx
   16QoKSFZYjqEUXOP6Rdgn6aDlemhlAnEmOKVvFwqVJgI34BpZjTF280YQ
   MOkcXPviIaT0Hlbc3QjLNOvyLu84RpRvJnGxVE6Jg8xML+GvZcr3a8I9y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266449631"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266449631"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:34:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="662328794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:34:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nkPpH-009hyp-Hb;
        Fri, 29 Apr 2022 15:34:23 +0300
Date:   Fri, 29 Apr 2022 15:34:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Message-ID: <YmvbT9D6v67S+svB@smile.fi.intel.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <YmpoeJtFNSyCq1QL@smile.fi.intel.com>
 <20220428181131.GG12977@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428181131.GG12977@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:11:31PM -0400, Paul Gortmaker wrote:
> [Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional] On 28/04/2022 (Thu 13:12) Andy Shevchenko wrote:
> > On Thu, Apr 28, 2022 at 02:24:26AM -0400, Paul Gortmaker wrote:
> > > A few months back I was doing a test build for "defconfig-like" COTS
> > > hardware and happened to notice some pmc-atom stuff being built.  Fine,
> > > I thought - the defconfig isn't minimal - we all know that - what Kconfig
> > > do I use to turn that off?  Well, imagine my surprise when I found out
> > > you couldn't turn it [Atom Power Management Controller] code off!
> > 
> > Turning it off on BayTrail and CherryTrail devices will be devastating
> > to the users' experience. And plenty of cheap tablets are exactly made
> > on that SoCs.
> 
> Sure, but I could say the same thing for DRM_I915 and millions of
> desktop PC users - yet we still give all the other non i915 users the
> option to be able to turn it off.  Pick any other Kconfig value you like
> and the same thing holds true.
> 
> Just so we are on the same page - I want to give the option to let
> people opt out, and at the same time not break existing users. If you
> think the defconfig default of being off is too risky, then I am OK with
> that and we can just start by exposing the option with "default y".
> 
> So, to that end - are you OK with exposing the Kconfig so people can
> opt out, or are you 100% against exposing the Kconfig at all?  That
> obviously has the most impact on what I do or don't do next.
> 
> > > Normally we all agree to not use "default y" unless unavoidable, but
> > > somehow this was added as "def_bool y" which is even worse ; you can
> > > see the Kconfig setting but there is *no* way you can turn it off.
> > > 
> > > After investigating, I found no reason why the atom code couldn't be
> > > opt-out with just minor changes that the original addition overlooked.
> > > 
> > > And so this series addreses that.  I tried to be sensitive to not
> > > break any existing configs in the process, but the defconfig will
> > > now intentionally be different and exclude this atom specific code.
> > > 
> > > Using a defconfig on today's linux-next, here is the delta summary:
> > > 
> > > $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep add/remove
> > > add/remove: 0/410 grow/shrink: 0/7 up/down: 0/-47659 (-47659)
> > > add/remove: 0/105 grow/shrink: 0/1 up/down: 0/-6848 (-6848)
> > > add/remove: 0/56 grow/shrink: 0/1 up/down: 0/-10155 (-10155)
> > > 
> > > $ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep Total
> > > Total: Before=13626994, After=13579335, chg -0.35%
> > > Total: Before=3572137, After=3565289, chg -0.19%
> > > Total: Before=1235335, After=1225180, chg -0.82%
> > > 
> > > It is hard to reclaim anything against the inevitable growth in
> > > footprint, so I'd say we should be glad to take whatever we can.
> > > 
> > > Boot tested defconfig on today's linux-next on older non-atom COTS.
> > 
> > I believe this needs an extensive test done by Hans who possesses a lot of
> > problematic devices that require that module to be present.
> 
> Input from Hans is 100% welcome - but maybe again if we just consider
> using "default y" even though it isn't typical - then your concerns are
> not as extensive?
> 
> > Note to all your patches, please, use --cc option instead of putting noisy
> > lines in the each of the commit messages. For myself I created a "smart"
> > script [1] to avoid bothering with that. Feel free to use, modify, send PRs
> > back to improve.
> 
> Thanks - I'm used to explicitly capturing who was looped into the
> discussion.  But I hadn't considered how things have evolved so that in
> certain circumstances that might be considered just noise with the wider
> audience we see in the typical patch sets of today.
> 
> Assuming you are OK with exposing the option as a choice, I'll make
> things "default y" in v2 to ensure we've minimized risk to existing
> users who rely on it, but wait a while for others like Hans to put in
> their input.  I'll probably follow up in the individual patches to ask
> for clarification if I'm not clear on what you had in mind.

My main concern is the existing users' experience. Opting-out the option is a
good to have, I'm not against it.

-- 
With Best Regards,
Andy Shevchenko


