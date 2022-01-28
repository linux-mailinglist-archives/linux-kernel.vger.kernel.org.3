Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40454A046B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbiA1XlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:41:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:42619 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbiA1XlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643413264; x=1674949264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nf2qFgTJ6fU4pbmhpPpUz4DEKZhXCEzLYp+lk4cBfBw=;
  b=ghpDxoVk8dWi1gn0nqeUFD6khzIp3E3x5JmZ4WwOPh0hmYvbsukHp4ly
   p5BPA57DKpfY+e6ckeWA39UjU+rU/7b410s2FnlmiXodHw/Qc+buK9pxd
   tHlcn8U6ngtyV/mnNNfBUr5zLNPZLX62GbQim0+6iKiPEaEChxhxhiTEG
   mPvpT61xbApC45/4Lkk4L3djl5meSyBfVnvuek7LekEjiRTxVSZXnKuvG
   bq1EdR5AKlF/rNpiqmeAdnoEd8C2tBo6TK04L/6IihmyNwNi6sMhnCQcG
   uqXWbs/fItEnY06mb5MNW/SxeDMw9hQ/i+GFeJKQByy+pZ5juUQSUaYRl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307947244"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="307947244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:41:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="536332950"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:41:03 -0800
Date:   Fri, 28 Jan 2022 15:41:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 09/44] x86/pkeys: Enable PKS on cpus which support it
Message-ID: <20220128234103.GL785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-10-ira.weiny@intel.com>
 <f9db9626-de92-65a4-57f1-cf94511dd137@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9db9626-de92-65a4-57f1-cf94511dd137@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:18:29PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
> > specific, manipulation of permission restrictions on supervisor page
> > mappings.  It uses the same mechanism of Protection Keys as those on
> > User mappings but applies that mechanism to supervisor mappings using a
> > supervisor specific MSR.
> > 
> > Bit 24 of CR4 is used to enable the feature by software.  Define
> > pks_setup() to be called when PKS is configured.
> 
> Again, no need to specify the bit numbers.  We have it in the code. :)
> At most, just say something like:
> 
> 	PKS is enabled by a new bit in a control register.
> or
> 	PKS is enabled by a new bit in CR4.
> 
> > Initially, pks_setup() initializes the per-cpu MSR with 0 to enable all
> > access on all pkeys.
> 
> Why not just make it restrictive to start out?  That's what we do for PKU.

This maintains compatibility with the code prior to this patch.  Ie no
restrictions on kernel mappings.

I'll place the default value patch before this one and use it in this patch.

> 
> > asm/pks.h is added as a new file to store new
> > internal functions and structures such as pks_setup().
> 
> One writing nit: try to speak in active voice.
> 
> Passive: "Foo is added"
> Active: "Add foo"
> 
> It actually makes thing shorter and easier to read:
> 
> 	Add asm/pks.h to store new internal functions and structures
> 	such as pks_setup().

Ok.  I'll update the commit message.

> 
> > diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> > index bcba3c643e63..191c574b2390 100644
> > --- a/arch/x86/include/uapi/asm/processor-flags.h
> > +++ b/arch/x86/include/uapi/asm/processor-flags.h
> > @@ -130,6 +130,8 @@
> >  #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
> >  #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
> >  #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
> > +#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
> > +#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
> >  
> >  /*
> >   * x86-64 Task Priority Register, CR8
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 7b8382c11788..83c1abce7d93 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -59,6 +59,7 @@
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/uv/uv.h>
> >  #include <asm/sigframe.h>
> > +#include <asm/pks.h>
> >  
> >  #include "cpu.h"
> >  
> > @@ -1632,6 +1633,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> >  
> >  	x86_init_rdrand(c);
> >  	setup_pku(c);
> > +	pks_setup();
> >  
> >  	/*
> >  	 * Clear/Set all flags overridden by options, need do it
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index cf12d8bf122b..02629219e683 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -206,3 +206,19 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
> >  	pkval &= ~(PKEY_ACCESS_MASK << shift);
> >  	return pkval | accessbits << shift;
> >  }
> > +
> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +
> > +/*
> > + * PKS is independent of PKU and either or both may be supported on a CPU.
> > + */
> > +void pks_setup(void)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	wrmsrl(MSR_IA32_PKRS, 0);
> 
> This probably needs a one-line comment about what it's doing.  As a
> general rule, I'd much rather have a one-sentence note in a code comment
> than in the changelog.

Fair enough,
Ira

> 
> > +	cr4_set_bits(X86_CR4_PKS);
> > +}
> > +
> > +#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
> 
