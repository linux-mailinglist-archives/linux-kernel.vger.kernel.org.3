Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931BA4728DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhLMKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbhLMKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E3C08E843;
        Mon, 13 Dec 2021 01:50:16 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iok2ewJeLTvR7ckOV2i20DOBEfU+Rr/WRqLsWaK3hQ0=;
        b=yyb0I5q9IAYWr1WGtqq4MNp0EbZXdiEX5paNP4h/nzPVMhLE0NYIDFRvYVJ4kEwRg2lBzu
        eEOKBKgjfmpWJFDQbTcElmfrlyNd7DwkXttzSx7ciXcWCE7M4lep8+UG8bYijSmgB/PJ1e
        6dFgx+elGe3P6L276O/v0iktHt7BM1HeaVtm3t7cYGhwvmYXMExz2tPPE2+cWh9x8QPZtv
        ogogzDtYJC2FLILOUiTvYA8ogfEeMD90bCsnPyVoD20wgVPr88WtTxB1jQ/LW7dIS61ESb
        07hF+/eMYELDk4Thm2gTqgA8VqgoD9RUy31L+2cnJ9Xsa9jD2zQOV0+NUgcvTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iok2ewJeLTvR7ckOV2i20DOBEfU+Rr/WRqLsWaK3hQ0=;
        b=QGX6sFRo9kJZPF62y5FUnr++wbGlZxbazF1kBJ6fNE0Q6jnGy4v8NZr8rcDtr/NbXt22NO
        dgA8rhvjwAsG9fBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/vmx: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.781308550@infradead.org>
References: <20211110101325.781308550@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901404.23020.12254789866849907296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3e8ea7803a1dedf19120a2fef12c590e90e4b469
Gitweb:        https://git.kernel.org/tip/3e8ea7803a1dedf19120a2fef12c590e90e4b469
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:49 +01:00

x86/vmx: Remove .fixup usage

In the vmread exceptin path, use the, thus far, unused output register
to push the @fault argument onto the stack. This, in turn, enables the
exception handler to not do pushes and only modify that register when
an exception does occur.

As noted by Sean the input constraint needs to be changed to "=&r" to
avoid the value and field occupying the same register.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.781308550@infradead.org
---
 arch/x86/kvm/vmx/vmx_ops.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9e9ef47..35d9324 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -80,9 +80,11 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		      * @field, and bounce through the trampoline to preserve
 		      * volatile registers.
 		      */
-		     "push $0\n\t"
+		     "xorl %k1, %k1\n\t"
+		     "2:\n\t"
+		     "push %1\n\t"
 		     "push %2\n\t"
-		     "2:call vmread_error_trampoline\n\t"
+		     "call vmread_error_trampoline\n\t"
 
 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
@@ -93,13 +95,9 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		     "3:\n\t"
 
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     ".pushsection .fixup, \"ax\"\n\t"
-		     "4: push $1\n\t"
-		     "push %2\n\t"
-		     "jmp 2b\n\t"
-		     ".popsection\n\t"
-		     _ASM_EXTABLE(1b, 4b)
-		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
+
+		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
 	return value;
 }
 
