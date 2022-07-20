Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14057B6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiGTMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiGTMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:47:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE83E20F7B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658321259; x=1689857259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YfJNf2xYuj2xjx3ZO/qD+opLPrqxhG9thyqGVqUoNA0=;
  b=QPJrz6wzY5mHnp8Rx4PNx8p/50d+na9oX+k+4mMo4uOQxH4Km4HN5YMC
   vb4HkQMEyAfpN2dgfws9/Sc9jJzCuf7Mo4fbqtSEgntKvTNhRF5tyvF16
   ssRoXtKk2TDhTR8lLu8YI62d1vlJKc3PZvzpytoadLBM8Zd4i99c2RDi3
   n0kcGPK6J0JYgDNm5Q8XxC+ANDOjFhrEpzKYMjK2xaUyN+ltJ2Rej/yYD
   dHX5ZLE8tjq6N7foAv6WdixOAKWtfXDcn1dLvHjVVtAUkrBrOfG4Cvp7k
   MKcmsOMEeSpm37rzNtmFJld7xXTW/7w+DkDAQEGlzvKy/7Dfqx1IiLer4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="267167182"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="267167182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 05:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="700862742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2022 05:47:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EA207199; Wed, 20 Jul 2022 15:47:44 +0300 (EEST)
Date:   Wed, 20 Jul 2022 15:47:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 06/13] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220720124744.rpvns3nda7jfljgn@black.fi.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <20220712231328.5294-7-kirill.shutemov@linux.intel.com>
 <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
 <20220720005724.mwodxwm5r5gayqrm@black.fi.intel.com>
 <CAG_fn=X=yQrWOX43PbLR=VGRVvMgj0_e2x5Mwf0bSZ0DhTQDAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X=yQrWOX43PbLR=VGRVvMgj0_e2x5Mwf0bSZ0DhTQDAQ@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:19:36AM +0200, Alexander Potapenko wrote:
> > > >  long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> > > >  {
> > > >         int ret = 0;
> > > > @@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> > > >         case ARCH_MAP_VDSO_64:
> > > >                 return prctl_map_vdso(&vdso_image_64, arg2);
> > > >  #endif
> > > > -
> > > > +       case ARCH_GET_UNTAG_MASK:
> > > > +               return put_user(task->mm->context.untag_mask,
> > > > +                               (unsigned long __user *)arg2);
> > >
> > > Can we have ARCH_GET_UNTAG_MASK return the same error value (ENODEV or
> > > EINVAL) as ARCH_ENABLE_TAGGED_ADDR in the case the host doesn't
> > > support LAM?
> > > After all, the mask does not make much sense in this case.
> >
> > I'm not sure about this.
> >
> > As it is ARCH_GET_UNTAG_MASK returns -1UL mask if LAM is not present or
> > not enabled. Applying this mask will give correct result for both.
> 
> Is anyone going to use this mask if tagging is unsupported?
> Tools like HWASan won't even try to proceed in that case.

I can imagine the code that tries to be indifferent to whether a pointer
has tags. It gets mask from ARCH_GET_UNTAG_MASK and applies it to the
pointer without any conditions.

> > Why is -ENODEV better here? Looks like just more work for userspace.
> 
> This boils down to the question of detecting LAM support I raised previously.
> It's nice to have a syscall without side effects to check whether LAM
> can be enabled at all (e.g. one can do the check in the parent process
> and conditionally enable LAM in certain, but not all, child processes)
> CPUID won't help here, because the presence of the LAM bit in CPUID
> doesn't guarantee its support in the kernel, and every other solution
> is more complicated than just issuing a system call.
> 
> Note that TBI has PR_GET_TAGGED_ADDR_CTRL, which can be used to detect
> the presence of memory tagging support.

I would rather make enumeration explicit:

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 38164a05c23c..a31e27b95b19 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -22,5 +22,6 @@

 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
+#define ARCH_GET_MAX_TAG_BITS		0x4003

 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cfa2e42a135a..2e4df63b775f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -911,6 +911,13 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_GET_MAX_TAG_BITS:
+		if (!cpu_feature_enabled(X86_FEATURE_LAM))
+			return put_user(0, (unsigned long __user *)arg2);
+		else if (lam_u48_allowed())
+			return put_user(15, (unsigned long __user *)arg2);
+		else
+			return put_user(6, (unsigned long __user *)arg2);
 	default:
 		ret = -EINVAL;
 		break;
-- 
 Kirill A. Shutemov
