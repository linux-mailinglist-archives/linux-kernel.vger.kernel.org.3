Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57A523FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiEKWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbiEKWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9A316D105
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3257831pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl/bIy4sIdeQ+LppbeDLoegjUd00vZYCBef7PVEx7x8=;
        b=6XDcJOAhJN+rBrE/zRACmI8IndmffeqKQONoxxv6s3kxsXXU07eqNsYpDj2XyhRAT2
         hGZkS5blQgntJik7IfT9EPLqi2FX2K6Lz50xHbNaIgMcOtSIxCB/k6LBtDgYsjvcvVyM
         PeKRBepTgiBmSo2sG2r9QFoO5ojbbaR+g1g/gC6A+1yDOc6oByiuZ+ONSbU9AVKHTeBJ
         1pATZRKPkDWq6HGkxneOeSdxcQXBn8sMAhnw+GTuGReU4PgB6DknIBLcTY60HwGx/f68
         ivc8KNoXBWmWzOON+3CLmtEnve/cceFmFRhlyf6v6/TYGsBodwTgVHJ8z8s5LlY74Anl
         z+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl/bIy4sIdeQ+LppbeDLoegjUd00vZYCBef7PVEx7x8=;
        b=JR7mT6bLrgSl79sKc3wQAlPpFHDBZYeZaDlBH8anyUAKM6MjeFJW9p8diqYy5NBtEd
         /Bt5HSQLmgqcjnr6UJWQiAD1/VbHa01loHbUOgV3PNBU4S6zvYN7uQV+bT3DB8N72hiB
         U3D+jj3vF0k7L1cTSSzq19Eblc/2cct1T9ixlxaSsyqHUOKegeyGqZigtABFD+pVDGfM
         2dwreOaz6OUU0x+zAMw72g/9HBdhExSbUog0zeUb1RBgmyjeFUO2PAyXCeV07gt2pVY2
         mWf8tnRkqHmE3x9trR3tNxx2WxXgpHQRvBHO6Z8q/Tc6bfhI4Lfa76P8Z4Cu7Ai8LAzq
         8jlQ==
X-Gm-Message-State: AOAM530W5uREmZJpJ8Iavt2So0i1EH8C6VNZVQ4zL3ZAdNzDDBzHqQJm
        oy0FntzXwOd6/4u6EH4Oq+uZu/o14QfApg==
X-Google-Smtp-Source: ABdhPJy2axMEpnhXpcegSt4PRtZLSdgXgs1lzAhGg4dNqS4cRKarIJHwIcsAK+psu1xIhqt4zJ7Ixg==
X-Received: by 2002:a17:902:9884:b0:15f:4eb:8e76 with SMTP id s4-20020a170902988400b0015f04eb8e76mr19397445plp.57.1652306422324;
        Wed, 11 May 2022 15:00:22 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:21 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 10/12] target/riscv: Add few cache related PMU events
Date:   Wed, 11 May 2022 14:59:54 -0700
Message-Id: <20220511215956.2351243-11-atishp@rivosinc.com>
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

