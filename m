Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1759ABDE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbiHTG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiHTG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:56:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAEAC0E5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:56:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w197so6984693oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=paOW2t9hSvLN0qsX4domrqdnSMll+/S/rhUQM1pkWRg=;
        b=NtxPW9Wr4McSKA91GxGeGJjkDktm/3QZ21ZNmP6uUQWklp9s9rzEpNYYZdruz79fDb
         am2bA0uDb2zVe4SXlgweKT3NlDH2dL4zgQV3KJtOdZRtoTnjusouB4y1TJTmrPqyfr/n
         y8VI4e5/HkOQHzrH0xqC8bvIyX12XlWJTXxPjVAAtEuLZTeLTfrpPfT1qGgl1Wi+J/FN
         k2vTJPJ4Va4f6PJAQKY4afDh0uJX7WEz0TG50Vfc/OiT0+owjwFKzCJKSPMacJ36UVIf
         RQ4t85x9+WBAI7mKoakonnRudaR41Mn/TplPY1y5Oo/h9v4MMowWruWTam/0zgKiHZeg
         JPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=paOW2t9hSvLN0qsX4domrqdnSMll+/S/rhUQM1pkWRg=;
        b=oR2/fWHbH3LEwuYC0A7NcfJ9xgdA4wxiBr8boPeiYkpZdQTLmxSRTi7oTlPXS0SfI9
         pZrlQ2kmU85y7OJY4U5t5d2yBV/LVd7XWGt2C2xIb5Dq4Y88RR35diPDuTp9aLCJvPl1
         4h217gPBwFkKEtO2xjQpvP7dFFGK2bWRr7DaZ3fHM5+tI4nFbeq3rpoWm8yIfqIs+TF2
         eORGbEKNOo+ZxbPRTAruXIqSncTh1HuefmSB1P5cMgJch31zgZa/+rl355Pg8Myzz3SR
         Q8GCCsUwshr9vdINxdIqf3Fhv+O4zByYu9/lYelFfbKNMKObcBb30JpBCmM3CH7TMP44
         I6mA==
X-Gm-Message-State: ACgBeo3UdCO8Oc/2QrB4qPT/ZwDrig6BlVnEWgCISN53Z7gLmwQYMOXo
        5s4U+JR5nn+mGWK2PxQvPvVobw==
X-Google-Smtp-Source: AA6agR6BCjsRj4KUVIIQs529gebqU/BqYdrbuHNDhsVIu5M8bp3JavBtD3Oq1UpccIIPAljlUqI1kA==
X-Received: by 2002:a05:6808:10d5:b0:342:f7d9:e8a8 with SMTP id s21-20020a05680810d500b00342f7d9e8a8mr7337081ois.164.1660978579661;
        Fri, 19 Aug 2022 23:56:19 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.68])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b00636faf5e2d9sm1661098otl.39.2022.08.19.23.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:56:18 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 7/7] RISC-V: Use IPIs for remote icache flush when possible
Date:   Sat, 20 Aug 2022 12:24:46 +0530
Message-Id: <20220820065446.389788-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820065446.389788-1-apatel@ventanamicro.com>
References: <20220820065446.389788-1-apatel@ventanamicro.com>
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

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..7c7e44aaf791 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -18,7 +18,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -66,7 +66,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.34.1

