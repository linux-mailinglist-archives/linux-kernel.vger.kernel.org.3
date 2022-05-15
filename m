Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB2F52766F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiEOIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiEOIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 04:25:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B926AC8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 01:25:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652603102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7+fQUOWze0pVYEZjRj8XUJiwefr28uSeO0nHn9mEnk=;
        b=aRwDaoRbR+SPdSvik1cT6s6vifX3rEPxcWFnSOPLh0W8926OxH+rJLPuJih3psnpg8cnZz
        +xfhx/GqABAeZXFmCmiz3jFTI81IeDqd3qUnz9MtuWIHy9l3Y9MOc5zjlD9IeAgQ2PZFya
        J8fSDmyMx6P9J+QO3XteWNq9c9xrRwtLgyn4YVR5+UsamoTLXgHxCTEFx8ijw27rQOJa8x
        QWfSwNz19mAaltQ7r8ND6uK2+ZykrZbwVCjnVxN44AuD1MxziDI0vbCzbvdyJBmkh8UiGt
        x7Jm6k5Xy3xsAEbQDp9hSzol1nqG/Yqco0zinx2smk6CFxEdnhp3U2Tr4HtTKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652603102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7+fQUOWze0pVYEZjRj8XUJiwefr28uSeO0nHn9mEnk=;
        b=YDDZMVFSe1imrgYE5F1wj5Rmj1mwPpT5Cy1lhHBS+CoZrW7mSiyld6W5+dw1B2/s34BRTJ
        xC1mUx6DEaGsOCAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [x86/uaccess] 9c5743dff4:
 WARNING:at_arch/x86/mm/extable.c:#ex_handler_fprestore
In-Reply-To: <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
References: <20220513085455.GB21013@xsang-OptiPlex-9020>
 <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
Date:   Sun, 15 May 2022 10:25:01 +0200
Message-ID: <8735hbryn6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13 2022 at 09:52, Linus Torvalds wrote:
> On Fri, May 13, 2022 at 1:55 AM kernel test robot <oliver.sang@intel.com> wrote:
> But considering that the fail:runs thing is 41:52, I suspect it's
> something very timing-dependent and who knows how reliable the
> bisection has been.

This smells very much like the issue which got fixed with

     59f5ede3bc0f ("x86/fpu: Prevent FPU state corruption")

which resulted in the very same stack trace pattern because the restore
detects the fpstate corruption. The sigframe setup does:

     if (TIF_NEED_FPU_LOAD)
           restore();
     save_to_sigframe();

But yes, in theory it might be caused by ptrace as well. See below.

>>   24:   89 c2                   mov    %eax,%edx
>>   26:   48 0f ae 2f             xrstor64 (%rdi)
>>   2a:*  48 c7 c7 58 47 2b 8c    mov    $0xffffffff8c2b4758,%rdi         <-- trapping instruction
>
> Seems to be just the exception stack chain (ie notice how it's
> pointing to the instruction after the xrstor64, it's not that the
> immediate register move really trapped).

which is caused by ex_handler_fprestore() itself because it stupidly
fixes up regs->ip _before_ the warning. This should obviously be done
afterwards. Without that fixup it would point at xrstor64.

>>   28:   0f 05                   syscall
>>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
>
> and again, it's just pointing back to after the 'syscall' instruction
> that caused this whole chain of events.
>
> Anyway, I *think* that what may be going on is some ptrace thing, but
> let's bring in other people. Because I don't think that "x86/uaccess:
> fix code generation in put_user()" commit is what triggered this, but
> who knows.. The x86 FP code can be very grotty.

Courtesy to the corresponding hardware...

The code which copies the ptrace supplied state has a pile of sanity
checks to catch invalid state, but I wouldn't bet my hat on it that it's
100% complete. We can be more defensive here, but I would be surprised.

Something like the untested below. I'll expose it to some testing to see
what explodes.

Thanks,

        tglx
---

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 39e1c8626ab9..c1228d6391c8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1248,7 +1248,48 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
  */
 int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
 {
-	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
+	struct fpstate *tmpfps;
+	unsigned int fpsize;
+	int ret;
+
+	/* This cannot operate on current's fpstate */
+	if (WARN_ON_ONCE(fpstate == current->thread.fpu.fpstate))
+		return -EPERM;
+
+	/* Use a temporary fpstate for the xrstor validation below */
+	fpsize = fpstate->size + ALIGN(offsetof(struct fpstate, regs), 64);
+	tmpfps = vmalloc(fpsize);
+	if (!tmpfps)
+		return -ENOMEM;
+	memcpy(tmpfps, fpstate, fpstate->size);
+
+	ret = copy_uabi_to_xstate(tmpfps, kbuf, NULL);
+	if (ret)
+		goto out;
+	/*
+	 * Ensure right here that the user space provided xstate content is
+	 * correct. Save current's fpstate and invalidate the per-CPU FPU
+	 * state.
+	 */
+	kernel_fpu_begin_mask(0);
+	/*
+	 * Limit the restore attempt to the user features as fpstate
+	 * is not current's fpstate. So current's supervisor state
+	 * has to be preserved and the target's supervisor state was
+	 * not touched in copy_uabi_to_xstate().
+	 */
+	ret = os_xrstor_safe(tmpfps, tmpfps->user_xfeatures);
+	kernel_fpu_end();
+	/*
+	 * If the restore succeeded, copy the state. Otherwise
+	 * keep the previous content.
+	 */
+	if (!ret)
+		memcpy(fpstate, tmpfps, fpstate->size);
+
+out:
+	vfree(tmpfps);
+	return ret;
 }
 
 /*
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index dba2197c05c3..c0d852998d18 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -68,11 +68,10 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
+	regs->ip = ex_fixup_addr(fixup);
 	fpu_reset_from_exception_fixup();
 	return true;
 }





