Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30FE4BFF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiBVQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBVQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:58:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E116C4C4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:58:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i205-20020a2522d6000000b00622c778ac7cso24923379ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=LdOkseL/SVBmCmTgjcnNq9QzVzqqoPlVFVsUav/JFK0=;
        b=FNoLI1ytq66gPDfA9ohgBGXwe3ZXAMfQPU+vmETuazTxn1eRt4sfndjKQl5vNg1s6N
         aKsNQ+NyKz9hsu+jiKv0znYXLeJd3n/+di/bVx097otwKJ+Pm8qhNs67V2lcMqwTVhI1
         wW9Xhb5tkIIU2yAp/NzXxghYQ+kMzgy+o2wG8PnfZAZIib9of+6+4qFBo+n7HfiKcBUT
         zgEVEI8Bx5lOplWa+VY0r+2kHSy9Bk1YC2Ipw+jivWuz7/saxNwcRLetDoqydMzCZ/+o
         DlsgOQQ986VSJnpFZSHCEQu861DTK2XF2rz2ttpajHfiMXQ90DWFxCmT05fG0qHlS8Nr
         E9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=LdOkseL/SVBmCmTgjcnNq9QzVzqqoPlVFVsUav/JFK0=;
        b=P5iEr0f8TTnbCkU9p3fC0NrZsPOvuP/tcgxLu7dXMMuTm7e+6s1fNbVfxs82gU/B8H
         sk0168bIWP1Jzg4/yxaKC5xkmFXQgrPJV11eTD/cVB11GXi0g4Gvvso9zkLf2u57ge43
         utTntKwW4WHkVj6lr260XMvOyesN7H2fzpAVnKM53F8PyC+WdnKkeYQyxE2OiDfeClqv
         fUsFdZQCudLYvXSLdsbPKMFeaHL5HtMn32hr8LFQHgQRUXJ5xrJeF85oo6rNzfsCJjQO
         0p0KXkOdTkau6A2e0/pD2QNWblUDacsODfhdfndHbThK11KrF3vws2pAuuH3r9Xov7iM
         /oBg==
X-Gm-Message-State: AOAM530wnHpdhOsOq718ZP46ZPdULo83PRerX5xXTcwVuiaW8wSchdN+
        ixTapr5qIwMop7UlI5rld3S/1whvFD2T82nPSw==
X-Google-Smtp-Source: ABdhPJxTMt4EP42XEzXDEACbHfSQnsjw9YnBj/jsWJgMJWkojIR6N0I/bKfbgjEHFp9OFaaN7ZlREpz8dxBvYs+xsg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a81:b11:0:b0:2d7:3775:1eb9 with SMTP
 id 17-20020a810b11000000b002d737751eb9mr10900452ywl.99.1645549106468; Tue, 22
 Feb 2022 08:58:26 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:06 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 5/9] arm64: asm: Introduce test_sp_overflow macro
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <qperret@google.com>

The asm entry code in the kernel uses a trick to check if VMAP'd stacks
have overflowed by aligning them at THREAD_SHIFT * 2 granularity and
checking the SP's THREAD_SHIFT bit.

Protected KVM will soon make use of a similar trick to detect stack
overflows, so factor out the asm code in a re-usable macro.

Signed-off-by: Quentin Perret <qperret@google.com>
[Kalesh - Resolve minor conflicts]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/assembler.h | 11 +++++++++++
 arch/arm64/kernel/entry.S          |  7 +------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e8bd0af0141c..ad40eb0eee83 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -850,4 +850,15 @@ alternative_endif
 
 #endif /* GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT */
 
+/*
+ * Test whether the SP has overflowed, without corrupting a GPR.
+ */
+.macro test_sp_overflow shift, label
+	add	sp, sp, x0			// sp' = sp + x0
+	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
+	tbnz	x0, #\shift, \label
+	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
+	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
+.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 772ec2ecf488..ce99ee30c77e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -53,15 +53,10 @@ alternative_else_nop_endif
 	sub	sp, sp, #PT_REGS_SIZE
 #ifdef CONFIG_VMAP_STACK
 	/*
-	 * Test whether the SP has overflowed, without corrupting a GPR.
 	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
 	 * should always be zero.
 	 */
-	add	sp, sp, x0			// sp' = sp + x0
-	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
-	tbnz	x0, #THREAD_SHIFT, 0f
-	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
-	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
+	test_sp_overflow THREAD_SHIFT, 0f
 	b	el\el\ht\()_\regsize\()_\label
 
 0:
-- 
2.35.1.473.g83b2b277ed-goog

