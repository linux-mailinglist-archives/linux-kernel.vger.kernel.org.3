Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D834726DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhLMJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhLMJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:19 -0500
Date:   Mon, 13 Dec 2021 09:50:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Plt2XwYM1ogm2xpFfVNWYYIYbbdqj6lfKzFYKFT1pCo=;
        b=ZUpqNORHauK56GnmynRdR/GfVM1YnNDdGTtNYQB92q+vFZiym60HL5CVNfWIOFb1HpxMyY
        jDDR/ScvlZB0vGifL6+Z+3n6Hv2Y245eZZ62ss9PaoRAMFMTS3mbZmdgEiLa7f3aLZHghU
        9RcpkTyfU5vvpjRq+ECg2Lz8u1TcqgVeadc5weCKtteoFFf/X8wkF/dv5dYDO07eJ9YxQz
        FE1HwQdu/bh6a5Rqocu+xmUwRx8nzNuJeNg/ZKnOlsnyNj8K3xRYwe09d8HaKpqRkFnXna
        tYIOFKtMJARu8BBcPU6hyy2r7igCpNfvVcFu1mu0Hr2HY4cD1e1pwQE4lAwikA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Plt2XwYM1ogm2xpFfVNWYYIYbbdqj6lfKzFYKFT1pCo=;
        b=0YpTOyafgI1ge09wEMVSX/+Pb4nkLR8tbsq/v0JkhCfyTb7u0fha6GGci6IOYOt3S7v1pa
        YyJAL7D9HaKM3XBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/segment: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.663529463@infradead.org>
References: <20211110101325.663529463@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901585.23020.7772910436430495353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5fc77b916cb82fe476ae2344e0ec37445227a4f8
Gitweb:        https://git.kernel.org/tip/5fc77b916cb82fe476ae2344e0ec37445227a4f8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:48 +01:00

x86/segment: Remove .fixup usage

Create and use EX_TYPE_ZERO_REG to clear the register and retry the
segment load on exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.663529463@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h |  1 +
 arch/x86/include/asm/segment.h             |  9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 7469038..a43b8c1 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -45,5 +45,6 @@
 
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
+#define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
 
 #endif
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 8dd8e8e..b228c9d 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -307,14 +307,7 @@ do {									\
 									\
 	asm volatile("						\n"	\
 		     "1:	movl %k0,%%" #seg "		\n"	\
-									\
-		     ".section .fixup,\"ax\"			\n"	\
-		     "2:	xorl %k0,%k0			\n"	\
-		     "		jmp 1b				\n"	\
-		     ".previous					\n"	\
-									\
-		     _ASM_EXTABLE(1b, 2b)				\
-									\
+		     _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k0)\
 		     : "+r" (__val) : : "memory");			\
 } while (0)
 
