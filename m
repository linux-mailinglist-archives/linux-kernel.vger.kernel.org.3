Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60D4B05D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiBJFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:51:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiBJFuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:50:32 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9BB10EC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:50:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y8so5621470pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6DnRCcGid35hmRCVAHPT4/JHmCQ1pX6LaO+zPetyxw=;
        b=mSBtH4Ca3FDB67dCd9NJOO5/JXrDvLAO3zTmf+dcTUfKJYtyIBbQVcQmfc+TqTl7O7
         xZUysJohgWhF1eU0KpHG1mIuaQozOmy7kcfTjI6Vk6c7pnGAPt7Qexkgl4m1au+q80Ds
         6IPqOLJ/JAMR8MRuKn3Md7bRY9JFCSTY+fKt7YBZrnVdf0bOPO9Nxzl4Kh5KDIJP11I+
         +DfQDh5FJxLD7W4+LDs3w14PivdoAcBpuuc8NApLyqbWA9JvpDHf/uXzsaDi+G8RFPfc
         gJd337B7Zpc7vKgbDUSm9CddVhEyD86YvhhkzDHPdAgBfy1/smNKGgImbnM8dAwsuKcc
         YCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6DnRCcGid35hmRCVAHPT4/JHmCQ1pX6LaO+zPetyxw=;
        b=Zo9j+eN0wePKjnio0BrwrEb+W7eSep/Odqr/bvYTkziZ/IC1iUrC04M8i+dTzP6kJn
         HI4fSB7Z76KnPRE5YL33xmGnN7SfZ8pW/1i1movNyBgRAEDyQme/BgFoNSzPGV99VrLG
         DR0AJLIzLoJ2Xvc3FrPsyROp8Oz7V6vXwCXPahOHgxiEu/wz3j2mP87KcDWWF4/TUZqc
         7TGMUxjpBJpUQ1ndMy506LmEAk/IhPZl8WnzLP9IoUevgFabTdHHzcFVRxHP1sCIuDUg
         IJj7NOMsrrnKoT0M3C6/f7h81U6zTEo2ViS3BPGNx8ndXzQF4HmEZM/5EUdzP+KpqR81
         Jw0g==
X-Gm-Message-State: AOAM530HbP5BhOMdKKDU+xCWZMPlLQIFYH4CnmzXP+1gh0WtM7CB38ES
        SyWMiFVK0umHUP0D++G+nMZfIQ==
X-Google-Smtp-Source: ABdhPJzzvcYAQEszqDrWPIi2o/8I39cAGJzw5p5FlegiJjt/V5sGZEn9o5ZpjEdFVmLscqWyK8zTMg==
X-Received: by 2002:a63:4b17:: with SMTP id y23mr4834549pga.489.1644472234077;
        Wed, 09 Feb 2022 21:50:34 -0800 (PST)
Received: from localhost.localdomain ([122.179.114.46])
        by smtp.gmail.com with ESMTPSA id s32sm15192270pfw.80.2022.02.09.21.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:50:33 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v11 2/8] RISC-V: Rename relocate() and make it global
Date:   Thu, 10 Feb 2022 11:19:41 +0530
Message-Id: <20220210054947.170134-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210054947.170134-1-apatel@ventanamicro.com>
References: <20220210054947.170134-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The low-level relocate() function enables mmu and relocates
execution to link-time addresses. We rename relocate() function
to relocate_enable_mmu() function which is more informative.

Also, the relocate_enable_mmu() function will be used in the
resume path when a CPU wakes-up from a non-retentive suspend
so we make it global symbol.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/head.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 2363b43312fc..5f4c6b6c4974 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -90,7 +90,8 @@ pe_head_start:
 
 .align 2
 #ifdef CONFIG_MMU
-relocate:
+	.global relocate_enable_mmu
+relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_map
 	XIP_FIXUP_OFFSET a1
@@ -185,7 +186,7 @@ secondary_start_sbi:
 	/* Enable virtual memory and relocate to virtual address */
 	la a0, swapper_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif
 	call setup_trap_vector
 	tail smp_callin
@@ -329,7 +330,7 @@ clear_bss_done:
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
 	XIP_FIXUP_OFFSET a0
-	call relocate
+	call relocate_enable_mmu
 #endif /* CONFIG_MMU */
 
 	call setup_trap_vector
-- 
2.25.1

