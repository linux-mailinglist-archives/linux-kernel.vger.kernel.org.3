Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2424B18B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiBJWot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:44:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiBJWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2182704
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:44:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s73-20020a25aa4f000000b0061d764d3c13so15208501ybi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=2dZOYBOmJua4dYugoiMtuQUhFU9vmd43xxG8qEJDkFQ=;
        b=ep6/TNGFOJe8CMFzZYZTp3879NvaY6+muWoz075exQAtJ+Dtv/XxFOgo1TvFvY76YC
         XOB/EOtVDQ935brIbXoSTuX/PaYdWJC8dHLpt6DXVeYIdx05KvPgXyX9s2r4wBITC+yr
         AiLe4qiBik1TW8/yYKyz/i9tgLFNDvabJBTvtv17doe7xkkBUVgcvImDEydYuurvMduH
         wbTib7UbkW1wLjMaJazhGbz3ZRn3P6dDOBYxBoKnsfjlvq1oDKICPU7DpepOHn7PWInc
         6NuG3/TMjtT91dnM2QUaLSFBNYRxG6DVDul48ADGrixxtXdibO2kEXGlX1gPRU0hafh+
         ZcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=2dZOYBOmJua4dYugoiMtuQUhFU9vmd43xxG8qEJDkFQ=;
        b=N/338bp1zxkvCNbZOoFnYdoYS3+/5AMySHQhcLbQTdNwUs10550mcV9tBw4fOGxbOh
         6Wdjg3mwGHmnU+2/yNVSfD9ozawd83ajtkFx3A2S1H/Ri34D6ESTRBZC85W/cK08jwbY
         dfRw3MzbvxzRZ8umep/eLQdfgptpTA0imuWrxVGw6JZm+lpHdJCrnAsLFgWqE5PCOz5z
         NJHeYFUZkPJ6tjruz1+JI3Slfq+zsvJwSBF6Km6B7z9LM8sXR5eEUUSoJXBDYdj35MG/
         Y3MaWQzesY58e9GzKMOMAqBHHk2csx3N/dJNFSvUMu8o3iCl2Y7wI0JsTr9KXV0MAIl/
         N1SA==
X-Gm-Message-State: AOAM530kRH4Jmao5wTXQqN5E66uxn7vcdhHO9PJmmfFQFFeROOTDK7gU
        VZs7JjgyBrH1656R8vQpA2Wb+4an5UwSzAIHfw==
X-Google-Smtp-Source: ABdhPJzhHuVVpX5/8wSgs7kQYW10C9SFtD8VH8eIEn4uDIMdbuJGadpvTqkiYBtfns2EGA0KUtz+LKt9roCBW8sc/A==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:548:: with SMTP id
 r8mr9416027ybp.717.1644533085249; Thu, 10 Feb 2022 14:44:45 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:41:44 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 3/7] arm64: asm: Introduce test_sp_overflow macro
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
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
 arch/arm64/kernel/entry.S          |  9 ++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

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
index 772ec2ecf488..2632bc47b348 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -53,16 +53,11 @@ alternative_else_nop_endif
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
-	b	el\el\ht\()_\regsize\()_\label
+	test_sp_overflow THREAD_SHIFT, 0f
+	b       el\el\ht\()_\regsize\()_\label
 
 0:
 	/*
-- 
2.35.1.265.g69c8d7142f-goog

