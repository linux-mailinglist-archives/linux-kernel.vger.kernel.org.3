Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08B4B1E35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiBKGLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiBKGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:11:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06C318
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644559859; x=1676095859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njvurMrwL1Bv5tFfoFBQL7gBFyKcylkvil0xA66ogBM=;
  b=I+RGZYYysmcyNRh+YaKwaPll3l4+bFtDPfWtvejjH71bKmzn2m4oAAdj
   RYX8PkellOqqZOQtGpDce1KTPOnQ0470OhrmVj3jIVDtcFXFBukWO84vV
   PbEHo0L/bcPGQZet1atBrftyo3eYbA3300SR9P9eHEmqrnGOs39Sx1pjI
   umjHYcStZ+CGXjj8PEDrZr7XWkNP8rRE7Gm5HcDPjEOo3Nauiz5JH6G6L
   3oZenZvOq6jwetqKl8ZQGFceiKZW2hK1dptPVEEJ6RL+CemDInfLsK1Fh
   LnGQqIt0hOnX6r8JAPgbbON9Jz2ilp0z0IllTaTK8ETFWofo6pawi+B7b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312952650"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="312952650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:10:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="541959412"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 22:10:58 -0800
Date:   Thu, 10 Feb 2022 22:10:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 15/44] x86/pkeys: Preserve the PKS MSR on context
 switch
Message-ID: <20220211061058.GQ785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-16-ira.weiny@intel.com>
 <3b1ba2fe-5f69-ee2f-ea08-f0b5d145696d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1ba2fe-5f69-ee2f-ea08-f0b5d145696d@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:22:42PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The PKS MSR (PKRS) is defined as a per-logical-processor register.  This
> 
> s/defined as//

Done.

> 
> > isolates memory access by logical CPU.  
> 
> This second sentence is a bit confusing to me.  I *think* you're trying
> to say that PKRS only affects accesses from one logical CPU.

Yes.

> But, it
> just comes out strangely.  I think I'd just axe the sentence.

Yea done.

> 
> > Unfortunately, the MSR is not
> > managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
> > context switch.
> > 
> > Define pks_saved_pkrs in struct thread_struct.  Initialize all tasks,
> > including the init_task, with the PKS_INIT_VALUE when created.  Restore
> > the CPU's MSR to the saved task value on schedule in.
> > 
> > pks_write_current() is added to ensures non-supervisor pkey
> 
> 				  ^ ensure

Done.

> 
> ...
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 2c5f12ae7d04..3530a0e50b4f 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _ASM_X86_PROCESSOR_H
> >  #define _ASM_X86_PROCESSOR_H
> >  
> > +#include <linux/pks-keys.h>
> > +
> >  #include <asm/processor-flags.h>
> >  
> >  /* Forward declaration, a strange C thing */
> > @@ -502,6 +504,12 @@ struct thread_struct {
> >  	unsigned long		cr2;
> >  	unsigned long		trap_nr;
> >  	unsigned long		error_code;
> > +
> > +#ifdef	CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +	/* Saved Protection key register for supervisor mappings */
> > +	u32			pks_saved_pkrs;
> > +#endif
> 
> There are a bunch of other "saved" registers in thread_struct.  They all
> just have their register name, including pkru.
> 
> Can you just stick this next to 'pkru' and call it plain old 'pkrs'?

Sure.  I was trying to use the same 'pks_*' prefix everywhere.  But pkrs makes
sense too.

> That will probably even take up less space than this since the two
> 32-bit values can be packed together.

Yes done.

[]

> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 3402edec236c..81fc0b638308 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -59,6 +59,7 @@
> >  /* Not included via unistd.h */
> >  #include <asm/unistd_32_ia32.h>
> >  #endif
> > +#include <asm/pks.h>
> >  
> >  #include "process.h"
> >  
> > @@ -657,6 +658,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> >  	/* Load the Intel cache allocation PQR MSR. */
> >  	resctrl_sched_in();
> >  
> > +	pks_write_current();
> > +
> >  	return prev_p;
> >  }
> 
> At least for pkru and fsgsbase, these have the form:
> 
> 	x86_<register>_load();
> 
> Should this be
> 
> 	x86_pkrs_load();

Ok done.

> 
> and be located next to:
> 
> 	x86_pkru_load()?

This presents a problem.  As defined this can't happen until current is loaded.
For now I've passed in the next thread_struct but I fear that is going to cause
some bad header dependencies.  I'll see what 0day has to say about it and
adjust as needed.

Ira
