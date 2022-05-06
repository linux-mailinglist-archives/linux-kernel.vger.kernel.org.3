Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD79A51E020
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443012AbiEFU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390768AbiEFU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:29:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25640908;
        Fri,  6 May 2022 13:26:04 -0700 (PDT)
Date:   Fri, 06 May 2022 20:26:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651868762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zhEGxu9Qe8Vn+eFv5mNxMHu1foq3HFRkw2NwvHHB3I=;
        b=WyR9g8LFjuKkSFY1KlQcs14YgHOpRMEcO5Ol+28d6NTnbikKFbypdbaanucblBbjCdK7A6
        kdv+WkxJmUZeF9QFPYGKcDkYGSVjxa1hOz2jEzoP4RJAmKq3XI0zbbng4Sdmei3Ms3bUV5
        MSV44YKPu+hgZiKoj9EVAXdv7fVOOruKSUC01ZkIopS6qFXfKb8QrLn5tUzUCZAnxEGkpj
        uvgiEygRY5rCWUFhJo0k2yMNaLvTEnD9oezAlABSBn53RSNh+w1W6iN/DF7RGywxn+gQwU
        0++IWNZalhNEgrURFqZlxuxgb3wdQmKNWbHAMOnYklGuJKv13hvg1D3k5uJn+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651868762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zhEGxu9Qe8Vn+eFv5mNxMHu1foq3HFRkw2NwvHHB3I=;
        b=HYxtCz95LztbcrH8rPsSonhk99qHJL4UAoneDCrDEl5qHbMbsBIr+v5q7dwHy2BB5gGbNa
        BBOm/0cnANiQ2mAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.508692613@infradead.org>
References: <20220506121631.508692613@infradead.org>
MIME-Version: 1.0
Message-ID: <165186876093.4207.5445867612554580816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e2ef115813c34ea5380ac5b4879f515070150210
Gitweb:        https://git.kernel.org/tip/e2ef115813c34ea5380ac5b4879f515070150210
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 May 2022 14:14:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 May 2022 22:20:43 +02:00

objtool: Fix STACK_FRAME_NON_STANDARD reloc type

STACK_FRAME_NON_STANDARD results in inconsistent relocation types
depending on .c or .S usage:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
  Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
  0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
  0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
  0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
  0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.508692613@infradead.org
---
 include/linux/objtool.h       | 4 +++-
 tools/include/linux/objtool.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 586d357..b9c1474 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -40,6 +40,8 @@ struct unwind_hint {
 
 #ifdef CONFIG_STACK_VALIDATION
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 586d357..b9c1474 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -40,6 +40,8 @@ struct unwind_hint {
 
 #ifdef CONFIG_STACK_VALIDATION
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
