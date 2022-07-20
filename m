Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1B57AB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiGTA5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGTA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:57:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB3422D1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658278641; x=1689814641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F7g3ynXWOMTKVN0gg82mLeRiQZLN1+/2VVU531tlYIM=;
  b=jVOlBdqXDOeQmtA9NZf1wtq7FLyRvZmDpmd1IhohXQH6K1TVUE1Q+VoK
   Rue6Kfaae0FZlqjssg32JgXq5XAEaZbpg5PcQ2L4csSJnBJgtOd71gnUE
   9YQdjJJGoohVa+Z98FN9BU6Ho9g2MbG7IAlqjyXR0Ba70zq3kiEcMlirE
   NeEk+9z5yqQ0ECttHNumJSBIrr4UIrzCLbByKj/Ax7/JDZpw/i4lPZoaA
   0fUNyTdbKCo5Ys0lpLRLtKEIT/f/+WJJRiCWObdsKP3xfArqt31i6BtEh
   zfx2BHGt5/mbEEmGxEHoiRoTpQFl3b6gSfQEIqNVXPwvOVRa9PkkcxIxr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372948301"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372948301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 17:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="724466919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 17:57:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 16292136; Wed, 20 Jul 2022 03:57:24 +0300 (EEST)
Date:   Wed, 20 Jul 2022 03:57:24 +0300
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
Message-ID: <20220720005724.mwodxwm5r5gayqrm@black.fi.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <20220712231328.5294-7-kirill.shutemov@linux.intel.com>
 <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 07:47:44PM +0200, Alexander Potapenko wrote:
> On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Add a couple of arch_prctl() handles:
> >
> >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
> >    of tag bits. It is rounded up to the nearest LAM mode that can
> >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> >
> >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> >    bits located in the address.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/uapi/asm/prctl.h |  3 ++
> >  arch/x86/kernel/process_64.c      | 60 ++++++++++++++++++++++++++++++-
> >  2 files changed, 62 insertions(+), 1 deletion(-)
> 
> 
> > +
> > +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> > +               return -ENODEV;
> 
> Hm, I used to think ENODEV is specific to devices, and -EINVAL is more
> appropriate here.
> On the other hand, e.g. prctl(PR_SET_SPECULATION_CTRL) can also return ENODEV...

I'm fine either way. Although there are way too many -EINVALs around, so
it does not communicate much to user.

> >  long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> >  {
> >         int ret = 0;
> > @@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> >         case ARCH_MAP_VDSO_64:
> >                 return prctl_map_vdso(&vdso_image_64, arg2);
> >  #endif
> > -
> > +       case ARCH_GET_UNTAG_MASK:
> > +               return put_user(task->mm->context.untag_mask,
> > +                               (unsigned long __user *)arg2);
> 
> Can we have ARCH_GET_UNTAG_MASK return the same error value (ENODEV or
> EINVAL) as ARCH_ENABLE_TAGGED_ADDR in the case the host doesn't
> support LAM?
> After all, the mask does not make much sense in this case.

I'm not sure about this.

As it is ARCH_GET_UNTAG_MASK returns -1UL mask if LAM is not present or
not enabled. Applying this mask will give correct result for both.

Why is -ENODEV better here? Looks like just more work for userspace.

> 
> > +       case ARCH_ENABLE_TAGGED_ADDR:
> > +               return prctl_enable_tagged_addr(task->mm, arg2);
> >         default:
> >                 ret = -EINVAL;
> >                 break;
> > --
> > 2.35.1
> >
> 
> 
> -- 
> Alexander Potapenko
> Software Engineer
> 
> Google Germany GmbH
> Erika-Mann-Straße, 33
> 80636 München
> 
> Geschäftsführer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg

-- 
 Kirill A. Shutemov
