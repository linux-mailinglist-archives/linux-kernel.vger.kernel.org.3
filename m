Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB24C9AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiCBCBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiCBCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:01:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65773A4183
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646186421; x=1677722421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XeFotN3ltBVSAOu5RFOoSqzzbdwE51cXZ4ZE4Trwrew=;
  b=b/BxorFxNFiiAztYj+nwETd5DDQOpotNH7ng/mOXQMMjJbEi/egP6OLo
   0h4DPhNr4A22a8Jjd0fF/xikEFDsRcinLtSWEJmU8yfTW2RgBpww627Bo
   oaUcGSNyNhbK1set4zdqtnUcaJr03AhdW7SQ4dj9gKU8hJfrpigejm4gv
   PRi/81ebcg/00kKUbc/s2gsEzGvvJbVA9vtY0GD1N+WjHywT/pEQQBCwI
   Tf6RDGBrbJiJEEg7GeVhMFahzcD32wlzxPnrtRAwwbhptPmsocqdPJSwE
   AvfmmaJVsRBqrq8hubzfB91t0OX9/D/2Rpxqh90p7HNr/V/34HedS4MrX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253212696"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253212696"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:00:20 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575943803"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:00:20 -0800
Date:   Tue, 1 Mar 2022 18:00:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
Message-ID: <Yh7Ps55XKGlgbusn@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-40-ira.weiny@intel.com>
 <CAPcyv4gama4a-90R486kFiztYJ5sPRYeg49TNYMyd=v3syAziw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gama4a-90R486kFiztYJ5sPRYeg49TNYMyd=v3syAziw@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:01:55AM -0800, Dan Williams wrote:
> On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Some systems may be using pmem in unanticipated ways.  As such, it is
> > possible an foreseen code path to violate the restrictions of the PMEM
> > PKS protections.
> 
> These sentences do not parse for me. How about:
> 
> "When PKS protections for PMEM are enabled the kernel may capture
> stray writes, or it may capture false positive access violations. An
> example of a false positive access violation is a code path that
> neglects to call kmap_{atomic,local_page}, but is otherwise a valid
> access. In the false positive scenario there is no actual risk to data
> integrity, but the kernel still needs to make a decision as to whether
> to report the access violation and continue, or treat the violation as
> fatal. That policy decision is captured in a new pks_fault_mode kernel
> parameter."

That sounds good, added thanks.

> 
> >
> > In order to provide a more seamless integration of the PMEM PKS feature
> 
> Not sure what "seamless integration" means in this context?

Integration of the stray writes into production kernels.  This will help make
that seamless by easing the restrictions on any potential valid users.

I've removed this paragraph though.

> 
> > provide a pks_fault_mode that allows for a relaxed mode should a
> > previously working feature fault on the PKS protected PMEM.
> >
> > 2 modes are available:
> >
> >         'relaxed' (default) -- WARN_ONCE, removed the protections, and
> >         continuing to operate.
> >
> >         'strict' -- BUG_ON/or fault indicating the error.  This is the
> >         most protective of the PMEM memory but may be undesirable in
> >         some configurations.
> >
> > NOTE: The typedef of pks_fault_modes is required to allow
> > param_check_pks_fault() to work automatically for us.  So the typedef
> > checkpatch warning is ignored.
> 
> This doesn't parse for me, why is a typedef needed for a simple
> toggle? Who is "us"?

Missed that 'us'...  ;-)

How about this:

NOTE: The __param_check macro requires a type to correctly verify the
values passed as the module parameter.  Therefore a typedef is made of
the pks_fault_modes and the checkpatch warning regarding new typedefs is
ignored.


> 
> >
> > NOTE: There was some debate about if a 3rd mode called 'silent' should
> > be available.  'silent' would be the same as 'relaxed' but not print any
> > output.  While 'silent' is nice for admins to reduce console/log output
> > it would result in less motivation to fix invalid access to the
> > protected pmem pages.  Therefore, 'silent' is left out.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes for V8
> >         Use pks_update_exception() instead of abandoning the pkey.
> >         Split out pgmap_protection_flag_invalid() into a separate patch
> >                 for clarity.
> >         From Rick Edgecombe
> >                 Fix sysfs_streq() checks
> >         From Randy Dunlap
> >                 Fix Documentation closing parans
> >
> > Changes for V7
> >         Leverage Rick Edgecombe's fault callback infrastructure to relax invalid
> >                 uses and prevent crashes
> >         From Dan Williams
> >                 Use sysfs_* calls for parameter
> >                 Make pgmap_disable_protection inline
> >                 Remove pfn from warn output
> >         Remove silent parameter option
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 14 ++++
> >  arch/x86/mm/pkeys.c                           |  4 ++
> >  include/linux/mm.h                            |  3 +
> >  mm/memremap.c                                 | 67 +++++++++++++++++++
> >  4 files changed, 88 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f5a27f067db9..3e70a6194831 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4158,6 +4158,20 @@
> >         pirq=           [SMP,APIC] Manual mp-table setup
> >                         See Documentation/x86/i386/IO-APIC.rst.
> >
> > +       memremap.pks_fault_mode=        [X86] Control the behavior of page map
> > +                       protection violations.  Violations may not be an actual
> > +                       use of the memory but simply an attempt to map it in an
> > +                       incompatible way.
> > +                       (depends on CONFIG_DEVMAP_ACCESS_PROTECTION)
> > +
> > +                       Format: { relaxed | strict }
> > +
> > +                       relaxed - Print a warning, disable the protection and
> > +                                 continue execution.
> > +                       strict - Stop kernel execution via BUG_ON or fault
> > +
> > +                       default: relaxed
> > +
> >         plip=           [PPT,NET] Parallel port network link
> >                         Format: { parport<nr> | timid | 0 }
> >                         See also Documentation/admin-guide/parport.rst.
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index fa71037c1dd0..e864a9b7828a 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/debugfs.h>             /* debugfs_create_u32()         */
> >  #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
> >  #include <linux/pkeys.h>                /* PKEY_*                       */
> > +#include <linux/mm.h>                   /* fault callback               */
> >  #include <uapi/asm-generic/mman-common.h>
> >
> >  #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
> > @@ -243,6 +244,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_NR_CONSUMERS] = {
> >  #ifdef CONFIG_PKS_TEST
> >         [PKS_KEY_TEST]          = pks_test_fault_callback,
> >  #endif
> > +#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
> > +       [PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
> > +#endif
> >  };
> >
> >  static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 60044de77c54..e900df563437 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1193,6 +1193,9 @@ static inline void pgmap_mk_noaccess(struct page *page)
> >
> >  bool pgmap_protection_available(void);
> >
> > +bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
> > +                             bool write);
> > +
> >  #else
> >
> >  static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
> > diff --git a/mm/memremap.c b/mm/memremap.c
> > index b75c4f778c59..783b1cd4bb42 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -96,6 +96,73 @@ static void devmap_protection_disable(void)
> >         static_branch_dec(&dev_pgmap_protection_static_key);
> >  }
> >
> > +/*
> > + * Ignore the checkpatch warning because the typedef allows
> 
> Why document forever in perpetuity to ignore a checkpatch warning for
> something that is no longer a patch once it is upstream?

Checkpatch can be run on files.  I can remove the comment and people can just
look at the commit message.  I was just trying to make it clear why the typedef
is required despite an apparent desire to not grow typedefs in the kernel.

> 
> > + * param_check_pks_fault_modes to automatically check the passed value.
> > + */
> > +typedef enum {
> > +       PKS_MODE_STRICT  = 0,
> > +       PKS_MODE_RELAXED = 1,
> > +} pks_fault_modes;
> > +
> > +pks_fault_modes pks_fault_mode = PKS_MODE_RELAXED;
> > +
> > +static int param_set_pks_fault_mode(const char *val, const struct kernel_param *kp)
> > +{
> > +       int ret = -EINVAL;
> > +
> > +       if (sysfs_streq(val, "relaxed")) {
> > +               pks_fault_mode = PKS_MODE_RELAXED;
> > +               ret = 0;
> > +       } else if (sysfs_streq(val, "strict")) {
> > +               pks_fault_mode = PKS_MODE_STRICT;
> > +               ret = 0;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int param_get_pks_fault_mode(char *buffer, const struct kernel_param *kp)
> > +{
> > +       int ret = 0;
> > +
> > +       switch (pks_fault_mode) {
> > +       case PKS_MODE_STRICT:
> > +               ret = sysfs_emit(buffer, "strict\n");
> > +               break;
> > +       case PKS_MODE_RELAXED:
> > +               ret = sysfs_emit(buffer, "relaxed\n");
> > +               break;
> > +       default:
> > +               ret = sysfs_emit(buffer, "<unknown>\n");
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct kernel_param_ops param_ops_pks_fault_modes = {
> > +       .set = param_set_pks_fault_mode,
> > +       .get = param_get_pks_fault_mode,
> > +};
> > +
> > +#define param_check_pks_fault_modes(name, p) \
> > +       __param_check(name, p, pks_fault_modes)
> > +module_param(pks_fault_mode, pks_fault_modes, 0644);
> 
> Is the complexity to change this at runtime necessary? It seems
> sufficient to make this read-only via sysfs and only rely on command
> line toggles to override the default policy.

I don't understand the complexity?

Ira

> 
> > +
> > +bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
> > +                             bool write)
> > +{
> > +       /* In strict mode just let the fault handler oops */
> > +       if (pks_fault_mode == PKS_MODE_STRICT)
> > +               return false;
> > +
> > +       WARN_ONCE(1, "Page map protection being disabled");
> > +       pks_update_exception(regs, PKS_KEY_PGMAP_PROTECTION, 0);
> > +       return true;
> > +}
> > +EXPORT_SYMBOL_GPL(pgmap_pks_fault_callback);
> > +
> >  void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
> >  {
> >         if (!current->pgmap_prot_count++)
> > --
> > 2.31.1
> >
