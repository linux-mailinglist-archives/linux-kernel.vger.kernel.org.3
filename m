Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F9525E36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378914AbiEMJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiEMJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F31882BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F3CD621AF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CD1C34113;
        Fri, 13 May 2022 09:14:13 +0000 (UTC)
Date:   Fri, 13 May 2022 10:14:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <Yn4hYSVSHvWGZCOo@arm.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
 <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
 <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com>
 <878rr6te6b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rr6te6b.ffs@tglx>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:27:24AM +0200, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 17:46, Dave Hansen wrote:
> > On 5/12/22 17:08, H.J. Lu wrote:
> > If I had to take a shot at this today, I think I'd opt for:
> >
> > 	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);
> >
> > although I'm not super confident about the "fuzzy" flag.  I also don't
> > think I'd totally hate the "blind" interface where the kernel just gets
> > to pick unilaterally and takes zero input from userspace.
> 
> That's the only sane choice and you can make it simple for userspace:
> 
>        ret = prctl(GET_XXX_MASK, &mask);
> 
> and then let it decide based on @ret and @mask whether to use it or not.

Getting the mask would work for arm64 as well (it's always 0xffUL << 56,
top-byte-ignore). Setting the mask from user space won't be of any use
to us, it's baked in hardware.

> But of course nobody thought about this as a generic feature and so we
> have the ARM64 TBI muck as a precedence.
> 
> So much for coordination and portability...

Well, we had TBI in the architecture and enabled for user-space since
the first arm64 kernel port (2012), no ABI controls needed. It had some
specific uses like JITs to avoid masking out type bits encoded in
pointers.

In 2019 sanitisers appeared and we relaxed the TBI at the syscall level
but, to avoid potentially confusing some programs, we added a control
which only changes the behaviour of access_ok(). More of a safety thing,
we might have as well skipped it. There is no hardware configuration
toggled by this control, nor is the user address space layout (max
52-bit on arm64). Since sanitisers require compiler instrumentation (or,
with MTE, arm64-specific libc changes), it's pretty much all within the
arm64-specific user codebase. MTE came along and we added some more bits
on top which, again, are hardware specific and contained within the
arm64 libc startup code (tag checking modes etc).

Dave indeed mentioned passing a mask to allow a more flexible control
but, as already mentioned in the old thread, for arm64 the feature was
already on, so it didn't make much sense, it seemed more like
over-engineering. Had we known that Intel is pursing something similar,
maybe we'd have designed the interface differently (we didn't get the
hint).

Intel's LAM has more flexibility but I don't see the arm64 TBI getting
in the way. Just don't use it as an example because they evolved in
different ways. I'm happy for arm64 to adopt a more flexible interface
while keeping the current one around for backwards compatibility). But
on arm64 we can't control the masking, not even disable it per process
since it has always been on.

> I'm so tired of this short sighted 'cram my feature in' approach of
> _all_ involved parties.

Unfortunately it happens occasionally, especially when developers can't
disclose that their companies work on similar features (resctrl is a
good example where arm64 would have benefited from a more generic
approach but at the time MPAM was not public).

-- 
Catalin
