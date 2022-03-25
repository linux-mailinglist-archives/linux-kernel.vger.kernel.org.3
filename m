Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C234E7845
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357664AbiCYPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377712AbiCYPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:50 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD2AD134
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:07 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de48295467so8494508fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNOdsxxU9VQEpWfEggP1ZhALtdgjnTVO+NADBLmHtas=;
        b=bThMPoSEee2tz4sivswwvLkojOd3knugVgV3hrG173CV9B7qFnlMJtUePNiW/Wf5m8
         +fvG98mKa0yy/1WNbfgYJtJaEUgaOVqJQkfPvFMYjy4dVHDFF7wcYoWjUJ8Q471wW8+d
         clpK9R1fcmxg1tucGOpQQLvp58lvMgHY1XKW8ztNojOzGB/0CZqDWOEF3nQYtwIQJUiS
         +iB1YYXgCV1fdZof/WjgMK+nCbL6BWgZZqg23adaHoOZvPozx1ZyCkKWGed1FIHWVZeL
         MQ4K6RSwVYLV3PXG3IB9qZNIz6XawbdblEUXaDkwOD4lfGsMsPczp7uNjVIK3C7GCpX4
         2Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNOdsxxU9VQEpWfEggP1ZhALtdgjnTVO+NADBLmHtas=;
        b=zjI72pEE0AXXma7ZEi06qGwQ4E+8ylUW2M164wTwv2y1HXYCk62NNwccTnDdMYMJxc
         CmHWCSn49zfz6nE4g7q2oJtfPUSvFYWG23SUWeQQ1bw6UPh1+qSoMhaUR9gBTSo7MomS
         eE/lIzG9B8i4qrB0WvgTcZ+pdGRJiwN5S87QsXYChTAPa6JHeD+dLIV1KlrRjlK+4xTt
         ehTZ+AhxTU2oyfK42JzjbEleaVTZoBJGsImE7Ea0ZE+RwSkx5h9fWhyzRhrCAghAihXu
         GL+etDyV/8LPXHgLtoUMr8gDwYO1zvUbt8iZ3396bJKooX19dxd20sHPBFHTzZFZLmsq
         cESg==
X-Gm-Message-State: AOAM533aQTtx/MGYDA7c8S2417wZijHXdYJG4Q2eT7FbtlU+dcw5o6Z/
        5ii6tkMkdW0YGVSufIIrMbha42WyuQ==
X-Google-Smtp-Source: ABdhPJwwXQSQic8G58wRxkzZA+Wpi26GPfRWMvpITJBYiNSzRwavCJvCY0r/VIUv9BJ8etyAqsPkLQ==
X-Received: by 2002:a05:6870:5702:b0:dd:e87b:f82a with SMTP id k2-20020a056870570200b000dde87bf82amr5150513oap.125.1648222806648;
        Fri, 25 Mar 2022 08:40:06 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm1709566oab.52.2022.03.25.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:40:06 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/4] ELF: Remove elf_core_copy_kernel_regs()
Date:   Fri, 25 Mar 2022 11:39:51 -0400
Message-Id: <20220325153953.162643-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
References: <20220325153953.162643-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-32 was the last architecture that implemented separate user and
kernel registers.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/powerpc/kernel/fadump.c               | 2 +-
 arch/powerpc/platforms/powernv/opal-core.c | 2 +-
 include/linux/elfcore.h                    | 9 ---------
 kernel/kexec_core.c                        | 2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4fdb7c77fda1..c0cf17196d6c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -752,7 +752,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	 * FIXME: How do i get PID? Do I really need it?
 	 * prstatus.pr_pid = ????
 	 */
-	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	return buf;
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 0331f1973f0e..dd6e99edff76 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -112,7 +112,7 @@ static void __init fill_prstatus(struct elf_prstatus *prstatus, int pir,
 			  struct pt_regs *regs)
 {
 	memset(prstatus, 0, sizeof(struct elf_prstatus));
-	elf_core_copy_kernel_regs(&(prstatus->pr_reg), regs);
+	elf_core_copy_regs(&(prstatus->pr_reg), regs);
 
 	/*
 	 * Overload PID with PIR value.
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index f8e206e82476..346a8b56cdc8 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -84,15 +84,6 @@ static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *re
 #endif
 }
 
-static inline void elf_core_copy_kernel_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
-{
-#ifdef ELF_CORE_COPY_KERNEL_REGS
-	ELF_CORE_COPY_KERNEL_REGS((*elfregs), regs);
-#else
-	elf_core_copy_regs(elfregs, regs);
-#endif
-}
-
 static inline int elf_core_copy_task_regs(struct task_struct *t, elf_gregset_t* elfregs)
 {
 #if defined (ELF_CORE_COPY_TASK_REGS)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..be4b54c2c615 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1078,7 +1078,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 		return;
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.common.pr_pid = current->pid;
-	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	elf_core_copy_regs(&prstatus.pr_reg, regs);
 	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	final_note(buf);
-- 
2.35.1

