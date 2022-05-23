Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F92531F69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiEWXwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiEWXvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B345067
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 202so8012242pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl/bIy4sIdeQ+LppbeDLoegjUd00vZYCBef7PVEx7x8=;
        b=sMMBV9W/fa0y64jfk+4WtDUmnTcJzT/EgZcubni9z4GWmWQYH+lA3OuLkM/2JZbFIm
         f/XV11wGVlk5JM+JCIWr4fzNZfYP57OYuU/WQPKSnY2Yj1NzLUf91v7QD7eoukzDtfF1
         3QbGQEHHRokIuILsIjIGrm6+mIns+OER21XvpMcl9662uEkP68WxM43J2L+cdL77BXL7
         Bjm0of4Dpr4b6mspH8iHJ45C+Dt1EUr+iUAJ3JXnxpQmB8RUs9GrRMDNKOcm+CAdeHa1
         I033D6n7x1GedNxqMiA13ELA5krU8NCAZzZgRQrkUY1JEbd6TuymYZrC7aN2MxXG/srt
         F+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl/bIy4sIdeQ+LppbeDLoegjUd00vZYCBef7PVEx7x8=;
        b=Arj//EQKAAx5Qjpr5b3MQ2Q6znhi0TAv+KepgS1Z+ZKE9FNplp62HNuhrdLX5kcdaK
         LG+gUT9ZXOUajTKQ6iTPLWdrIXN5ugd/rzTFF6wYsKvNAjrcUB+sRX2IGdJgSE1jcK5G
         IB/XcRZWZb7fq7fy7w1FjVeZmc9fABFvt3/kA6ADQkV+eYk81UVjn6iRxYc71L5Y3Crz
         YF1vsNLdRY395eJPv2b4LMkRhKiLBheONGCeBfl1J5J7DKXID7Y7MCQJwVTGiWV6niK+
         LViBvQRyBqDbufTU66e/4BaAgaivIZSUejQV2VuvVuUXMprx4/gjwEHIGwN2YPEtTomq
         DXJw==
X-Gm-Message-State: AOAM532On0HTQNJCL7dBh5Cw0Z1LVFQ9styCwJCbV7i1r7TNqzjohl/o
        eEmmdHJFL1NVF5WQLzB7hQ9EXtBlyKbytw==
X-Google-Smtp-Source: ABdhPJye6cnpZrbyV6ZTK5yoXxhp37OeSpLvnn+M4BhP7JS+U61bhMRsDiz0iLb9bRCF7pNcmnaNgw==
X-Received: by 2002:a63:1d12:0:b0:3f6:3a64:7594 with SMTP id d18-20020a631d12000000b003f63a647594mr21014301pgd.294.1653349899436;
        Mon, 23 May 2022 16:51:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:38 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 10/12] target/riscv: Add few cache related PMU events
Date:   Mon, 23 May 2022 16:50:55 -0700
Message-Id: <20220523235057.123882-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
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

From: Atish Patra <atish.patra@wdc.com>

Qemu can monitor the following cache related PMU events through
tlb_fill functions.

1. DTLB load/store miss
3. ITLB prefetch miss

Increment the PMU counter in tlb_fill function.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu_helper.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1aa4f2097c1..004cef0febad 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -21,10 +21,12 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "pmu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
+#include "cpu_bits.h"
 
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -1178,6 +1180,28 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+
+static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
+{
+    enum riscv_pmu_event_idx pmu_event_type;
+
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        pmu_event_type = RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
+        break;
+    case MMU_DATA_LOAD:
+        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS;
+        break;
+    case MMU_DATA_STORE:
+        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
+        break;
+    default:
+        return;
+    }
+
+    riscv_pmu_incr_ctr(cpu, pmu_event_type);
+}
+
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
@@ -1274,6 +1298,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             }
         }
     } else {
+        pmu_tlb_fill_incr_ctr(cpu, access_type);
         /* Single stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, NULL,
                                    access_type, mmu_idx, true, false, false);
-- 
2.25.1

