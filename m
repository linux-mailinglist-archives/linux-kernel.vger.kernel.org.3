Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AF4F9BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiDHRnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbiDHRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:43:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3793984
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34F18B82C79
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D71C385A3;
        Fri,  8 Apr 2022 17:41:29 +0000 (UTC)
Date:   Fri, 8 Apr 2022 18:41:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Bharata B Rao <bharata@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Message-ID: <YlBzxJIuql9jWuSv@arm.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:29:34PM -0700, Andy Lutomirski wrote:
> On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
> > This patchset makes use of Upper Address Ignore (UAI) feature available
> > on upcoming AMD processors to provide user address tagging support for x86/AMD.
> >
> > UAI allows software to store a tag in the upper 7 bits of a logical
> > address [63:57]. When enabled, the processor will suppress the
> > traditional canonical address checks on the addresses. More information
> > about UAI can be found in section 5.10 of 'AMD64 Architecture
> > Programmer's Manual, Vol 2: System Programming' which is available from
> >
> > https://bugzilla.kernel.org/attachment.cgi?id=300549
> 
> I hate to be a pain, but I'm really not convinced that this feature is
> suitable for Linux.  There are a few reasons:
> 
> Right now, the concept that the high bit of an address determines
> whether it's a user or a kernel address is fairly fundamental to the
> x86_64 (and x86_32!) code.  It may not be strictly necessary to
> preserve this, but violating it would require substantial thought.
> With UAI enabled, kernel and user addresses are, functionally,
> interleaved.  This makes things like access_ok checks, and more
> generally anything that operates on a range of addresses, behave
> potentially quite differently.  A lot of auditing of existing code
> would be needed to make it safe.

Just catching up with this thread. I'm not entirely familiar with the
x86 codebase but some points from the arm64 TBI (top-byte ignore)
feature that may be useful:

In the 52-bit VA configuration (maximum) the kernel addresses on arm64
start at 0xfff00000_00000000 and the user ones go up to
0x000fffff_ffffffff. Anything in between these addresses would trigger a
fault on access. So a non-zero top-byte, even with bit 63 set, would not
access any kernel address unless bits 52 to 63 are all 1 (and this would
fail the access_ok() check, see below).

On arm64 we had TBI from day 0 but the syscall ABI did not allow user
tagged pointers into the kernel. An access_ok() checking addr < TASK_SIZE
was sufficient. With the tagged address ABI, we wanted to allow user
addresses with a non-zero top byte into the kernel. The access_ok() was
changed to sign-extend from bit 55 before comparing with TASK_SIZE. The
hardware also uses bit 55 to select the user or the kernel page tables
(TTBR0/TTBR1_EL1 regs or current->mm->pgd vs swapper_pg_dir in Linux
terms).

I haven't looked at the AMD UAI feature but if it still selects the user
vs kernel page tables based on bit 63, there may be a potential problem.
However, if access_ok() ensures that bit 56 is 0 for valid user
addresses, such access would fault as it's below the kernel's
0xff000000_00000000 limit (if I got it correctly for x86).

Since the UAI goes from bit 57 and up, I have a suspicion that it keeps
bit 56 for user vs kernel address selection. An access_ok()
sign-extending from this bit should be sufficient. As I said above,
there's no risk if such addresses get past access_ok(). With bit 56
cleared they'd not be able to access any kernel data.

(that's unless I missed something in the x86 kernel address layout)

> UAI looks like it wasn't intended to be context switched and, indeed,
> your series doesn't context switch it.  As far as I'm concerned, this
> is an error, and if we support UAI at all, we should context switch
> it.  Yes, this will be slow, perhaps painfully slow.  AMD knows how to
> fix it by, for example, reading the Intel SDM.  By *not* context
> switching UAI, we force it on for all user code, including
> unsuspecting user code, as well as for kernel code.  Do we actually
> want it on for kernel code?  With LAM, in contrast, the semantics for
> kernel pointers vs user pointers actually make sense and can be set
> per mm, which will make things like io_uring (in theory) do the right
> thing.

Arm64 does not context switch the hardware TBI feature either (and it
was always on from the start). A reason is that it requires expensive
TLB maintenance. What we do context switch is the opt-in to the tagged
address ABI which allows tagged pointers into the kernel. That's purely
a software choice (TIF flag) and it only affects the access_ok() check.

With KASAN enabled, we enable the TBI feature for the kernel as well,
it is independently controlled from the user one.

> UAI and LAM are incompatible from a userspace perspective.  Since LAM
> is pretty clearly superior [0], it seems like a better long term
> outcome would be for programs that want tag bits to target LAM and for
> AMD to support LAM if there is demand.  For that matter, do we
> actually expect any userspace to want to support UAI?  (Are there
> existing too-clever sandboxes that would be broken by enabling UAI?)

From the arm64 experience, there were some thoughts in the early days
that JIT compilers may use the top byte in the generated code to store
pointer type etc. IIRC, this was never deployed. But subsequently we got
MTE (memory tagging extensions) that uses bits 56 to 59 as a tag checked
against the memory colour during access. This seems to be more useful.

There is ASan as well that can make use of the top bits but it requires
recompilation (in principle, for MTE you just need the libc to return
tagged pointers on malloc()).

Of course, there can be ABI surprises and we came across some, see
commit dcde237319e6 ("mm: Avoid creating virtual address aliases in
brk()/mmap()/mremap()").

> Given that UAI is not efficiently context switched, the implementation
> of uaccess is rather bizarre.  With the implementation in this series
> in particular, if the access_ok checks ever get out of sync with
> actual user access, a user access could be emitted with the high bits
> not masked despite the range check succeeding due to masking, which
> would, unless great care is taken, result in a "user" access hitting
> the kernel range.  That's no good.

Per my (mis)understanding of the x86 address space, I don't think it's
that bad if you are careful with bit 56 always being 0 for user
addresses. The user can't generate a valid kernel address that goes past
access_ok().

-- 
Catalin
