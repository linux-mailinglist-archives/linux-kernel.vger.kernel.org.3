Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B31523FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348541AbiEKWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348457AbiEKWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC97D16C5F1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso6155996pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FP6UKHUF4oCiVC9XYo1Z44wrICQn4u7X9HH8NyRpBEQ=;
        b=f8EidvJKos1L8k3XBAXUx80xrR/e6VmGGHAIDrkHEmyy6Q1hxP8Y/jjWGf/7MjY9K4
         XqY9BGY0RZzKSJdLtyZ34TSwyBc4LsRpl0b6LNf+VCsdL5i5ZBmd0OOmX6ByeZRfwMCQ
         poCi2pkOtMsfvofOOwF2tNixCmZckY3z1vWkgmmJWFVLDOYjzaScTJxgjib3lqacpPSP
         I715kByKlYtbt66Qvxnh64HuLb6dFMxruSea1qBjWpCt+JYQgAxg9Rlr3KfEL7q2GgTs
         5BZJz8xXPNSAuVnFTupeEZlgSSa7NextLcJek4+UbeQ63j0SP691W8P9PxcKb8h2rRz6
         ygFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FP6UKHUF4oCiVC9XYo1Z44wrICQn4u7X9HH8NyRpBEQ=;
        b=3XggOYwF1aow3q6KkalXLw+excAZuDChpDD53gjYiuNrQofhCagnGIByfPOoAUe5Tt
         BR2U/dwK5CetTMJxSIvvshUA+o6481IBKqacLCHjfKKmgXr8G85Bhs734ehcaYf9hIZL
         PA5Xw/eJUtmv21mkPWyhXUt2wphjXcrGv2v8//U4nRBvpbyGGgBKrvuFbNPCDJA8zY5G
         cFWwbHlo94bUfHGODEWKy9sAAPn42KaFWzAAXwAu70ffA6KzOrYr6b0czCS2JOjF7ETQ
         lKv90g4Xf71ON3ftY1LRlhxXAlI/jkxZyIXei2wBUlLgn9JkmTatNUkoftHXK7f1FC9r
         Ksvg==
X-Gm-Message-State: AOAM530VMWaINp5lwmSwlaCMdFZ+c5hW+t1/f0u6Y3mi7oUbniHkO/yT
        b3DLk/s9o2r9GGZlUJJs2GBDvYGls6gaXg==
X-Google-Smtp-Source: ABdhPJyq2fUlWz0ZVhyozWDAM9ZkO9pz2+1Jn0RkIAVKQh8FnUOAvnm34ALXCXt3qjGOy9FpjApliw==
X-Received: by 2002:a17:90a:fd83:b0:1de:d6fd:d552 with SMTP id cx3-20020a17090afd8300b001ded6fdd552mr1429444pjb.32.1652306421140;
        Wed, 11 May 2022 15:00:21 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:20 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 09/12] target/riscv: Simplify counter predicate function
Date:   Wed, 11 May 2022 14:59:53 -0700
Message-Id: <20220511215956.2351243-10-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511215956.2351243-1-atishp@rivosinc.com>
References: <20220511215956.2351243-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the hpmcounters and the fixed counters (CY, IR, TM) can be represented
as a unified counter. Thus, the predicate function doesn't need handle each
case separately.

Simplify the predicate function so that we just handle things differently
between RV32/RV64 and S/HS mode.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 111 ++++-----------------------------------------
 1 file changed, 10 insertions(+), 101 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0a679828ac44..368e72ae4f25 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -74,6 +74,7 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
     CPUState *cs = env_cpu(env);
     RISCVCPU *cpu = RISCV_CPU(cs);
     int ctr_index;
+    target_ulong ctr_mask;
     int base_csrno = CSR_CYCLE;
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
 
@@ -82,122 +83,30 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
         base_csrno += 0x80;
     }
     ctr_index = csrno - base_csrno;
+    ctr_mask = BIT(ctr_index);
 
     if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
         (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
         goto skip_ext_pmu_check;
     }
 
-    if ((!cpu->cfg.pmu_num || !(cpu->pmu_avail_ctrs & BIT(ctr_index)))) {
+    if ((!cpu->cfg.pmu_num || !(cpu->pmu_avail_ctrs & ctr_mask))) {
         /* No counter is enabled in PMU or the counter is out of range */
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
 skip_ext_pmu_check:
 
-    if (env->priv == PRV_S) {
-        switch (csrno) {
-        case CSR_CYCLE:
-            if (!get_field(env->mcounteren, COUNTEREN_CY)) {
-                return RISCV_EXCP_ILLEGAL_INST;
-            }
-            break;
-        case CSR_TIME:
-            if (!get_field(env->mcounteren, COUNTEREN_TM)) {
-                return RISCV_EXCP_ILLEGAL_INST;
-            }
-            break;
-        case CSR_INSTRET:
-            if (!get_field(env->mcounteren, COUNTEREN_IR)) {
-                return RISCV_EXCP_ILLEGAL_INST;
-            }
-            break;
-        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
-            if (!get_field(env->mcounteren, 1 << ctr_index)) {
-                return RISCV_EXCP_ILLEGAL_INST;
-            }
-            break;
-        }
-        if (rv32) {
-            switch (csrno) {
-            case CSR_CYCLEH:
-                if (!get_field(env->mcounteren, COUNTEREN_CY)) {
-                    return RISCV_EXCP_ILLEGAL_INST;
-                }
-                break;
-            case CSR_TIMEH:
-                if (!get_field(env->mcounteren, COUNTEREN_TM)) {
-                    return RISCV_EXCP_ILLEGAL_INST;
-                }
-                break;
-            case CSR_INSTRETH:
-                if (!get_field(env->mcounteren, COUNTEREN_IR)) {
-                    return RISCV_EXCP_ILLEGAL_INST;
-                }
-                break;
-            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
-                if (!get_field(env->mcounteren, 1 << ctr_index)) {
-                    return RISCV_EXCP_ILLEGAL_INST;
-                }
-                break;
-            }
-        }
+    if ((env->priv == PRV_S) && (!get_field(env->mcounteren, ctr_mask))) {
+        return RISCV_EXCP_ILLEGAL_INST;
     }
 
     if (riscv_cpu_virt_enabled(env)) {
-        switch (csrno) {
-        case CSR_CYCLE:
-            if (!get_field(env->hcounteren, COUNTEREN_CY) &&
-                get_field(env->mcounteren, COUNTEREN_CY)) {
-                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-            }
-            break;
-        case CSR_TIME:
-            if (!get_field(env->hcounteren, COUNTEREN_TM) &&
-                get_field(env->mcounteren, COUNTEREN_TM)) {
-                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-            }
-            break;
-        case CSR_INSTRET:
-            if (!get_field(env->hcounteren, COUNTEREN_IR) &&
-                get_field(env->mcounteren, COUNTEREN_IR)) {
-                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-            }
-            break;
-        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
-            if (!get_field(env->hcounteren, 1 << ctr_index) &&
-                 get_field(env->mcounteren, 1 << ctr_index)) {
-                return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-            }
-            break;
-        }
-        if (rv32) {
-            switch (csrno) {
-            case CSR_CYCLEH:
-                if (!get_field(env->hcounteren, COUNTEREN_CY) &&
-                    get_field(env->mcounteren, COUNTEREN_CY)) {
-                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-                }
-                break;
-            case CSR_TIMEH:
-                if (!get_field(env->hcounteren, COUNTEREN_TM) &&
-                    get_field(env->mcounteren, COUNTEREN_TM)) {
-                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-                }
-                break;
-            case CSR_INSTRETH:
-                if (!get_field(env->hcounteren, COUNTEREN_IR) &&
-                    get_field(env->mcounteren, COUNTEREN_IR)) {
-                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-                }
-                break;
-            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
-                if (!get_field(env->hcounteren, 1 << ctr_index) &&
-                     get_field(env->mcounteren, 1 << ctr_index)) {
-                    return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
-                }
-                break;
-            }
+        if (!get_field(env->mcounteren, ctr_mask)) {
+            /* The bit must be set in mcountern for HS mode access */
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        } else if (!get_field(env->hcounteren, ctr_mask)) {
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
     }
 #endif
-- 
2.25.1

