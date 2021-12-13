Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE34726F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhLMJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:56:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33680 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhLMJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:17 -0500
Date:   Mon, 13 Dec 2021 09:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWvpnamyCeB+fNsiGQyVEOCDKPJ2Xim8Ghf+Zd6GtKo=;
        b=XJvjfai+ojJBHKR+PNfUMZYmsj6rHlHnnifzW2lwuMGk3vcpj7NRActz7uUxJIJwRGclHr
        z6ACTlTWK3crxNwnrFlcl3Gw9jx0RtrEM+Sqp79lLna2MNAEWIImCFLQsnTaiHU9mk/hv2
        VzzAEWeeJ1wUKWYmZFy2bdsVyhQ0U2rxC2AD5uVURGcuEIVp/a8IVx5ZI2TrZEYU3OwU0z
        xjCGG3k947MYkEjXIg7y2CEx2OMbqN72YgQX9x8m+oU+LrBV2dXU9vhN8Xjafm62PDs/CN
        J+LcCRs8lqwZog/m39G4e9BNN4uSUutJV6klWnNZRARIVKfXxfyUY+ikpNZDbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWvpnamyCeB+fNsiGQyVEOCDKPJ2Xim8Ghf+Zd6GtKo=;
        b=tDdw0fG8YTX2vBLmcHoWtzZSxtXABYzkOsTNqwxPozraBKpypunNXsC5Kl9Fkgz4pxhOb/
        oq+ECiFNo9sff8BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kvm: Remove .fixup usage
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.722157053@infradead.org>
References: <20211110101325.722157053@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901500.23020.11464189763219027161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c9a34c3f4ece192f6d804039fe6aac9618f0d236
Gitweb:        https://git.kernel.org/tip/c9a34c3f4ece192f6d804039fe6aac9618f0d236
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:48 +01:00

x86/kvm: Remove .fixup usage

KVM instruction emulation has a gnarly hack where the .fixup does a
return, however there's already a ret right after the 10b label, so
mark that as 11 and have the exception clear %esi to remove the
.fixup.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.722157053@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h |  1 +
 arch/x86/kvm/emulate.c                     | 16 ++++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index a43b8c1..31ad42f 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -46,5 +46,6 @@
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
+#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(1))
 
 #endif
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b026350..1e19a4d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -315,7 +315,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_FUNC(#name)
 
 #define __FOP_RET(name) \
-	ASM_RET \
+	"11: " ASM_RET \
 	".size " name ", .-" name "\n\t"
 
 #define FOP_RET(name) \
@@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
+	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %%esi)
 
 #define FASTOP1(op) \
 	FOP_START(op) \
@@ -434,10 +434,6 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	#op " %al \n\t" \
 	__FOP_RET(#op)
 
-asm(".pushsection .fixup, \"ax\"\n"
-    "kvm_fastop_exception: xor %esi, %esi; " ASM_RET
-    ".popsection");
-
 FOP_START(setcc)
 FOP_SETCC(seto)
 FOP_SETCC(setno)
@@ -473,12 +469,8 @@ FOP_END;
  \
 	asm volatile("1:" insn "\n" \
 	             "2:\n" \
-	             ".pushsection .fixup, \"ax\"\n" \
-	             "3: movl $1, %[_fault]\n" \
-	             "   jmp  2b\n" \
-	             ".popsection\n" \
-	             _ASM_EXTABLE(1b, 3b) \
-	             : [_fault] "+qm"(_fault) inoutclob ); \
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[_fault]) \
+	             : [_fault] "+r"(_fault) inoutclob ); \
  \
 	_fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
 })
