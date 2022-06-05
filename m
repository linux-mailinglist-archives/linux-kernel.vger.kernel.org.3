Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F853DB63
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiFEMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:33:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB360E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654432380; x=1685968380;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IckfVGVO7Hb5OLHEwMcHe7yP/DG2W6pd5rQ6ihMI/R0=;
  b=CdaZFKEOo3xYQDJP53jJOdIQKGQWIKdCjqsqD46F7XqoiPRfRWapq0KD
   ++ieRt0l8zVNB+ebPjAswrZjGLUFRZqGzdB2Zat4ZWsaw4P+g4KPGZfhW
   dpN1+NNUwXuhZ/3m1xS+JU+KeFa9+G1QxINoNQzReiVfaexiACZD7Kvjw
   8shF0cQ0v2gdxh5P+rhELKA7ANQNgEJ5IAUFKx1u5CVbWRZwS3VmqU42p
   aLrHGPcWRhE2t7rCl9NH0QuFYozbJmU1e4hK6rWTbTeEzOH4Tm6K8kac9
   tTHISUiApM/PXe6HEYd1DpEiZLWH2d4v5mGL3eZfRA86BGoGn7ZrqkgvH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="258649566"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="258649566"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 05:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="553996454"
Received: from jhuan46-mobl1.ccr.corp.intel.com ([10.255.30.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 05:32:53 -0700
Message-ID: <a1cf42aeb221a857661abc7ac6833bfcedfd7873.camel@intel.com>
Subject: Re: [PATCH v4 1/3] x86: Handle idle=nomwait cmdline properly for
 x86_idle
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Sun, 05 Jun 2022 20:32:51 +0800
In-Reply-To: <f0e481c0-809b-a78a-6cbb-187e27bb9197@amd.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
         <7e5a66c4d383652c89a0b5ec0f57e0a95902f810.1653324016.git-series.wyes.karny@amd.com>
         <9dde86ab8773ddf3f9d88a85ed9ee010cdcf50a8.camel@intel.com>
         <f0e481c0-809b-a78a-6cbb-187e27bb9197@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 21:11 +0530, Wyes Karny wrote:
> > 
> 
> Hi Rui,
> 
> On 5/25/2022 1:36 PM, Zhang Rui wrote:
> > On Mon, 2022-05-23 at 22:25 +0530, Wyes Karny wrote:
> > > When kernel is booted with idle=nomwait do not use MWAIT as the
> > > default idle state.
> > > 
> > > If the user boots the kernel with idle=nomwait, it is a clear
> > > direction to not use mwait as the default idle state.
> > > However, the current code does not take this into consideration
> > > while selecting the default idle state on x86.
> > > 
> > > This patch fixes it by checking for the idle=nomwait boot option
> > > in
> > > prefer_mwait_c1_over_halt().
> > > 
> > > Also update the documentation around idle=nomwait appropriately.
> > > 
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > ---
> > > Changes in v4:
> > > - Update documentation around idle=nomwait
> > > - Rename patch subject
> > > 
> > >  Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
> > >  arch/x86/kernel/process.c                |  6 +++++-
> > >  2 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/pm/cpuidle.rst
> > > b/Documentation/admin-guide/pm/cpuidle.rst
> > > index aec2cd2aaea7..19754beb5a4e 100644
> > > --- a/Documentation/admin-guide/pm/cpuidle.rst
> > > +++ b/Documentation/admin-guide/pm/cpuidle.rst
> > > @@ -612,8 +612,8 @@ the ``menu`` governor to be used on the
> > > systems
> > > that use the ``ladder`` governor
> > >  by default this way, for example.
> > >  
> > >  The other kernel command line parameters controlling CPU idle
> > > time
> > > management
> > > -described below are only relevant for the *x86* architecture and
> > > some of
> > > -them affect Intel processors only.
> > > +described below are only relevant for the *x86* architecture and
> > > references
> > > +to ``intel_idle`` affect Intel processors only.
> > >  
> > >  The *x86* architecture support code recognizes three kernel
> > > command
> > > line
> > >  options related to CPU idle time management: ``idle=poll``,
> > > ``idle=halt``,
> > > @@ -635,10 +635,13 @@ idle, so it very well may hurt single-
> > > thread
> > > computations performance as well as
> > >  energy-efficiency.  Thus using it for performance reasons may
> > > not be
> > > a good idea
> > >  at all.]
> > >  
> > > -The ``idle=nomwait`` option disables the ``intel_idle`` driver
> > > and
> > > causes
> > > -``acpi_idle`` to be used (as long as all of the information
> > > needed
> > > by it is
> > > -there in the system's ACPI tables), but it is not allowed to use
> > > the
> > > -``MWAIT`` instruction of the CPUs to ask the hardware to enter
> > > idle
> > > states.
> > > +The ``idle=nomwait`` option prevents the use of ``MWAIT``
> > > instruction of
> > > +the CPU to enter idle states. When this option is used, the
> > > ``acpi_idle``
> > > +driver will use the ``HLT`` instruction instead of ``MWAIT``. On
> > > systems
> > > +running Intel processors, this option disables the
> > > ``intel_idle``
> > > driver
> > > +and forces the use of the ``acpi_idle`` driver instead. Note
> > > that in
> > > either
> > > +case, ``acpi_idle`` driver will function only if all the
> > > information
> > > needed
> > > +by it is in the system's ACPI tables.
> > >  
> > >  In addition to the architecture-level kernel command line
> > > options
> > > affecting CPU
> > >  idle time management, there are parameters affecting individual
> > > ``CPUIdle``
> > > diff --git a/arch/x86/kernel/process.c
> > > b/arch/x86/kernel/process.c
> > > index b370767f5b19..4e0178b066c5 100644
> > > --- a/arch/x86/kernel/process.c
> > > +++ b/arch/x86/kernel/process.c
> > > @@ -824,6 +824,10 @@ static void amd_e400_idle(void)
> > >   */
> > >  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86
> > > *c)
> > >  {
> > > +	/* User has disallowed the use of MWAIT. Fallback to HALT */
> > > +	if (boot_option_idle_override == IDLE_NOMWAIT)
> > > +		return 0;
> > > +
> > >  	if (c->x86_vendor != X86_VENDOR_INTEL)
> > >  		return 0;
> > >  
> > > @@ -932,7 +936,7 @@ static int __init idle_setup(char *str)
> > >  	} else if (!strcmp(str, "nomwait")) {
> > >  		/*
> > >  		 * If the boot option of "idle=nomwait" is added,
> > > -		 * it means that mwait will be disabled for CPU C2/C3
> > > +		 * it means that mwait will be disabled for CPU
> > > C1/C2/C3
> > >  		 * states. In such case it won't touch the variable
> > >  		 * of boot_option_idle_override.
> > 
> > the code didn't change boot_option_idle_override when it was
> > introduced, but this has changed since commit d18960494f65 ("ACPI,
> > intel_idle: Cleanup idle= internal variables")
> 
> Could you please clarify bit more why the commit you mentioned is
> related to this patch?
> 

The comment "In such case it won't touch the variable of
boot_option_idle_override." has been broken for some time, it is not
related with this patch. But given that this patch "Also update the
documentation around idle=nomwait appropriately", so my suggestion is
to update it altogether, by deleting the last sentence.

thanks,
rui

