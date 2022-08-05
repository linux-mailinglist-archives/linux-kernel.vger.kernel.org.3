Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78E58AC6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbiHEOkS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Aug 2022 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHEOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:40:16 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC46FE7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:40:15 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJyUi-0002uJ-EW;
        Fri, 05 Aug 2022 10:40:08 -0400
Date:   Fri, 5 Aug 2022 10:40:07 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <20220805104007.115359b5@imladris.surriel.com>
In-Reply-To: <Yu0o3J2T5QwKtoan@zn.tnic>
References: <20220805101644.2e674553@imladris.surriel.com>
        <Yu0o3J2T5QwKtoan@zn.tnic>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 16:27:40 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Aug 05, 2022 at 10:16:44AM -0400, Rik van Riel wrote:
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index fad8faa29d04..c7a5bbf40367 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
> >  		unsigned long address, struct task_struct *tsk)
> >  {
> >  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> > +	/* This is a racy snapshot, but it's better than nothing. */
> > +	int cpu = raw_smp_processor_id();  
> 
> Please read this in exc_page_fault() and hand it down to helpers.

Below is the change that implements your suggestion.

If there is consensus among the x86 maintainers that this is
desirable, I am more than happy to merge that change into my
patch and resubmit v4.

I don't have a strong opinion either way.

---8<---

From 444f8588f0edfd8586a86e85191ad8fa8b7c6a6c Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Fri, 5 Aug 2022 10:32:11 -0400
Subject: [PATCH 2/2] x86,mm: get CPU number for segfault printk before
 enabling preemption

Get the CPU number for the segfault printk earlier in the page fault
handler, before preemption is enabled.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/fault.c | 58 +++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c7a5bbf40367..bd06b22826b2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -766,11 +766,9 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
  */
 static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
-		unsigned long address, struct task_struct *tsk)
+		unsigned long address, struct task_struct *tsk, int cpu)
 {
 	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
-	/* This is a racy snapshot, but it's better than nothing. */
-	int cpu = raw_smp_processor_id();
 
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
@@ -808,7 +806,7 @@ static bool is_vsyscall_vaddr(unsigned long vaddr)
 
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		       unsigned long address, u32 pkey, int si_code)
+		       unsigned long address, u32 pkey, int si_code, int cpu)
 {
 	struct task_struct *tsk = current;
 
@@ -846,7 +844,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	if (likely(show_unhandled_signals))
-		show_signal_msg(regs, error_code, address, tsk);
+		show_signal_msg(regs, error_code, address, tsk, cpu);
 
 	set_signal_archinfo(address, error_code);
 
@@ -860,14 +858,14 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 static noinline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		     unsigned long address)
+		     unsigned long address, int cpu)
 {
-	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR);
+	__bad_area_nosemaphore(regs, error_code, address, 0, SEGV_MAPERR, cpu);
 }
 
 static void
 __bad_area(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, u32 pkey, int si_code)
+	   unsigned long address, u32 pkey, int si_code, int cpu)
 {
 	struct mm_struct *mm = current->mm;
 	/*
@@ -876,13 +874,14 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	 */
 	mmap_read_unlock(mm);
 
-	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
+	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code, cpu);
 }
 
 static noinline void
-bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
+bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address,
+	 int cpu)
 {
-	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
+	__bad_area(regs, error_code, address, 0, SEGV_MAPERR, cpu);
 }
 
 static inline bool bad_area_access_from_pkeys(unsigned long error_code,
@@ -904,7 +903,8 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 
 static noinline void
 bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
-		      unsigned long address, struct vm_area_struct *vma)
+		      unsigned long address, struct vm_area_struct *vma,
+		      int cpu)
 {
 	/*
 	 * This OSPKE check is not strictly necessary at runtime.
@@ -934,9 +934,9 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 		 */
 		u32 pkey = vma_pkey(vma);
 
-		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR);
+		__bad_area(regs, error_code, address, pkey, SEGV_PKUERR, cpu);
 	} else {
-		__bad_area(regs, error_code, address, 0, SEGV_ACCERR);
+		__bad_area(regs, error_code, address, 0, SEGV_ACCERR, cpu);
 	}
 }
 
@@ -1155,7 +1155,7 @@ bool fault_in_kernel_space(unsigned long address)
  */
 static void
 do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
-		   unsigned long address)
+		   unsigned long address, int cpu)
 {
 	/*
 	 * Protection keys exceptions only happen on user pages.  We
@@ -1214,7 +1214,7 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 * Don't take the mm semaphore here. If we fixup a prefetch
 	 * fault we could otherwise deadlock:
 	 */
-	bad_area_nosemaphore(regs, hw_error_code, address);
+	bad_area_nosemaphore(regs, hw_error_code, address, cpu);
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
@@ -1229,7 +1229,8 @@ NOKPROBE_SYMBOL(do_kern_addr_fault);
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long error_code,
-			unsigned long address)
+			unsigned long address,
+			int cpu)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -1289,7 +1290,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, error_code, address);
+		bad_area_nosemaphore(regs, error_code, address, cpu);
 		return;
 	}
 
@@ -1351,7 +1352,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, error_code, address);
+			bad_area_nosemaphore(regs, error_code, address, cpu);
 			return;
 		}
 retry:
@@ -1367,17 +1368,17 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, error_code, address, cpu);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, error_code, address, cpu);
 		return;
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, error_code, address);
+		bad_area(regs, error_code, address, cpu);
 		return;
 	}
 
@@ -1387,7 +1388,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 good_area:
 	if (unlikely(access_error(error_code, vma))) {
-		bad_area_access_error(regs, error_code, address, vma);
+		bad_area_access_error(regs, error_code, address, vma, cpu);
 		return;
 	}
 
@@ -1458,7 +1459,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, fault);
 		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address);
+			bad_area_nosemaphore(regs, error_code, address, cpu);
 		else
 			BUG();
 	}
@@ -1480,7 +1481,7 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 
 static __always_inline void
 handle_page_fault(struct pt_regs *regs, unsigned long error_code,
-			      unsigned long address)
+			      unsigned long address, int cpu)
 {
 	trace_page_fault_entries(regs, error_code, address);
 
@@ -1489,9 +1490,9 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
-		do_kern_addr_fault(regs, error_code, address);
+		do_kern_addr_fault(regs, error_code, address, cpu);
 	} else {
-		do_user_addr_fault(regs, error_code, address);
+		do_user_addr_fault(regs, error_code, address, cpu);
 		/*
 		 * User address page fault handling might have reenabled
 		 * interrupts. Fixing up all potential exit points of
@@ -1506,6 +1507,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
+	int cpu = raw_smp_processor_id();
 	irqentry_state_t state;
 
 	prefetchw(&current->mm->mmap_lock);
@@ -1547,7 +1549,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	state = irqentry_enter(regs);
 
 	instrumentation_begin();
-	handle_page_fault(regs, error_code, address);
+	handle_page_fault(regs, error_code, address, cpu);
 	instrumentation_end();
 
 	irqentry_exit(regs, state);
-- 
2.37.1

