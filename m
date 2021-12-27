Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1D47FBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhL0Kwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhL0Kws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:52:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1001C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:52:48 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FF541EC02AD;
        Mon, 27 Dec 2021 11:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640602363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P966dCeL08Y35QZgSUkpuR6ek63qN6eQPKa9gIdz0FY=;
        b=J4DbpGPe+Mw7J4vrxspdFxVh0BnxiqwWrI6LscaZANpOy7i+Qn4DrFMOpJysbQiHKKG48g
        O5AvBU6j1Vaxd1uQrr687e2HGfv+Rq89zd9mQi19ZhRPJs0wUV8RsFDlVSRayNkeeInYUA
        SZ2qYjDv3i3H2jcPICCse9hn/StkHwQ=
Date:   Mon, 27 Dec 2021 11:52:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH v2] x86/mce: Reduce number of machine checks taken during
 recovery
Message-ID: <Ycma/pwpb0prSM2N@zn.tnic>
References: <20211215222016.1390235-1-tony.luck@intel.com>
 <20211218005322.GM16608@worktop.programming.kicks-ass.net>
 <YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com>
 <YcWz6aEfsOZlHHXp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcWz6aEfsOZlHHXp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:50:01PM +0100, Peter Zijlstra wrote:
> That's inaccurate, fixup_exception() (event if it's spelled correctly)
> does not unconditionally set the trap number in RAX, that's only done by
> ex_handler_fault() (or ex_handler_sgx()), which means all flows into
> this function must pass through: EX_TYPE_FAULT, EX_TYPE_FAULT_MCE or
> EX_TYPE_COPY.

Yeah, they all flow through the copy thing, see _ASM_EXTABLE_CPY()
everywhere in that file.

> Boris might fix up your comment if he applies I suppose..

I did with the following changes so that tip branches merging can work
relatively easily and so that I don't pull in the whole x86/core pile
into ras/core.

The automerge conflict resolve with tip/master is after the patch below
and it looks ok to me too.

Thoughts?

---
From 0db3d12d3f1e8ee87a2f1cc6049a3a7c0e1f5e6c Mon Sep 17 00:00:00 2001
From: Youquan Song <youquan.song@intel.com>
Date: Thu, 23 Dec 2021 12:07:01 -0800
Subject: [PATCH] x86/mce: Reduce number of machine checks taken during
 recovery

When any of the copy functions in arch/x86/lib/copy_user_64.S take a
fault, the fixup code copies the remaining byte count from %ecx to %edx
and unconditionally jumps to .Lcopy_user_handle_tail to continue the
copy in case any more bytes can be copied.

If the fault was #PF this may copy more bytes (because the page fault
handler might have fixed the fault). But when the fault is a machine
check the original copy code will have copied all the way to the poisoned
cache line. So .Lcopy_user_handle_tail will just take another machine
check for no good reason.

Every code path to .Lcopy_user_handle_tail comes from an exception fixup
path, so add a check there to check the trap type (in %eax) and simply
return the count of remaining bytes if the trap was a machine check.

Doing this reduces the number of machine checks taken during synthetic
tests from four to three.

As well as reducing the number of machine checks, this also allows
Skylake generation Xeons to recover some cases that currently fail. The
is because REP; MOVSB is only recoverable when source and destination
are well aligned and the byte count is large. That useless call to
.Lcopy_user_handle_tail may violate one or more of these conditions and
generate a fatal machine check.

  [ Tony: Add more details to commit message. ]
  [ bp: Fixup comment.
    Also, another tip patchset which is adding straight-line speculation
    mitigation changes the "ret" instruction to an all-caps macro "RET".
    But, since gas is case-insensitive, use "RET" in the newly added asm block
    already in order to simplify tip branch merging on its way upstream.
  ]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/YcTW5dh8yTGucDd+@agluck-desk2.amr.corp.intel.com
---
 arch/x86/lib/copy_user_64.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 2797e630b9b1..e73b76e5bc09 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -225,6 +225,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Don't try to copy the tail if machine check happened
  *
  * Input:
+ * eax trap number written by ex_handler_copy()
  * rdi destination
  * rsi source
  * rdx count
@@ -233,12 +234,20 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * eax uncopied bytes or 0 if successful.
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
+	cmp $X86_TRAP_MC,%eax
+	je 3f
+
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
+3:
+	movl %edx,%eax
+	ASM_CLAC
+	RET
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
-- 
2.29.2

automerge resolve with tip/master:

commit a236a52e9c4b2869211aa1bb515856e625c30ac4 (HEAD -> refs/heads/test)
Merge: be59580168ba 0db3d12d3f1e
Author: Borislav Petkov <bp@suse.de>
Date:   Mon Dec 27 11:46:58 2021 +0100

    Merge branch 'tip-ras-core' into test

diff --cc arch/x86/lib/copy_user_64.S
index e6ac38587b40,e73b76e5bc09..d4a0494e618b
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@@ -224,14 -241,14 +228,19 @@@ SYM_CODE_START_LOCAL(.Lcopy_user_handle
  1:	rep movsb
  2:	mov %ecx,%eax
  	ASM_CLAC
 -	ret
 +	RET
  
+ 3:
+ 	movl %edx,%eax
+ 	ASM_CLAC
+ 	RET
+ 
  	_ASM_EXTABLE_CPY(1b, 2b)
 +
 +.Lcopy_user_handle_align:
 +	addl %ecx,%edx			/* ecx is zerorest also */
 +	jmp .Lcopy_user_handle_tail
 +
  SYM_CODE_END(.Lcopy_user_handle_tail)
  
  /*


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
