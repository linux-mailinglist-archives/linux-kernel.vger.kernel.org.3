Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9735523FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348585AbiEKWBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348479AbiEKWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469516D129
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x12so2915629pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upDqeNl3pI+gZKwdfwq9ACZIdLHvAQS6K2z6WQevVWU=;
        b=DcMp1vm9SnYJCFC7qaNK1e94cg373jL/uP91JW3a5w/9Ew+YOJ9rohTibDsjCNW57j
         Ei0mqJF9rrCVX856zvYVXs1r/YTrNKYRXqNNXoyvrtnl1liqtwdvxRS1AX3DswEPbmBk
         8ZXEiYZAF9DNBB38mC6sPypJUNZMgAbTN8OzNw2x/PEaiCYIutLUC9RTED3yBQSOBl2t
         KXsyhQYHj7tezjkNhDKFoMWQHs2obs3LmYKWj2YdbBIt/i6X3CfJvz2sbbpyWiJXdBlm
         24tx2LQA0vnVOGTLQ1laMYlHl7imAJzdbGuEBXFxivu4YVhe/oGRGotpuglp1K7vyMH4
         4MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upDqeNl3pI+gZKwdfwq9ACZIdLHvAQS6K2z6WQevVWU=;
        b=mthorH9bTUrrk7M4LTIf9rlidYbH7IDFeAK+7/qXPRreZQkPcK1LtKVTI6dni5/nEj
         /ZlWfSsvLdfnGMdL8WrB4yqcmgbCkP4mbk+OfbvNhfiEmg3pS8oXhk2WO6ROPljishxj
         aCckCkZ6nnuGqBh+u+LtK92xZc1YYa/6WT6F0y4fwVWBZbHZM4lF6LpN7v1jZuWKIiU2
         LNAs3zCGBy3AJzDA5Jn2zqyIywdpM36lUpyDZaodbUpGhSL/l+WrzftTHXdVYBrzKKt8
         ujjVbYPEHUVSFRy9H3MMjXiViOziFRsK/3TReCqQnsfIWHFotYzOlgwxUZUmT3xg7HKk
         x1Zw==
X-Gm-Message-State: AOAM530fcC6ls/vxEMFE9lujli+gQcT6GGIHnKsjptrfnS+HJbDDkQl9
        3SMX5p0WrU9T+Wde8/g2YVoBvGQoh24p1Q==
X-Google-Smtp-Source: ABdhPJwtRxU/JDnYbZh7B77FUXAQbgTfPrtJ1WPasIeQIXTyU1BGrLM412d1gXLh6p9q2GIxTYNhIw==
X-Received: by 2002:a63:db17:0:b0:3c1:dc15:7a6e with SMTP id e23-20020a63db17000000b003c1dc157a6emr23147917pgg.107.1652306423461;
        Wed, 11 May 2022 15:00:23 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:22 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 11/12] hw/riscv: virt: Add PMU DT node to the device tree
Date:   Wed, 11 May 2022 14:59:55 -0700
Message-Id: <20220511215956.2351243-12-atishp@rivosinc.com>
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

Qemu virt machine can support few cache events and cycle/instret counters.
It also supports counter overflow for these events.

Add a DT node so that OpenSBI/Linux kernel is aware of the virt machine
capabilities. There are some dummy nodes added for testing as well.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 hw/riscv/virt.c    | 28 +++++++++++++++++++++++
 target/riscv/cpu.c |  1 +
 target/riscv/pmu.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/pmu.h |  1 +
 4 files changed, 87 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3326f4db96a2..1b17ba7f8059 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -29,6 +29,7 @@
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
+#include "target/riscv/pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
@@ -715,6 +716,32 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
     aplic_phandles[socket] = aplic_s_phandle;
 }
 
+static void create_fdt_socket_pmu(RISCVVirtState *s,
+                                  int socket, uint32_t *phandle,
+                                  uint32_t *intc_phandles)
+{
+    int cpu;
+    char *pmu_name;
+    uint32_t *pmu_cells;
+    MachineState *mc = MACHINE(s);
+    RISCVCPU hart = s->soc[socket].harts[0];
+
+    pmu_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
+
+    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
+        pmu_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        pmu_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_PMU_OVF);
+    }
+
+    pmu_name = g_strdup_printf("/soc/pmu");
+    qemu_fdt_add_subnode(mc->fdt, pmu_name);
+    qemu_fdt_setprop_string(mc->fdt, pmu_name, "compatible", "riscv,pmu");
+    riscv_pmu_generate_fdt_node(mc->fdt, hart.cfg.pmu_num, pmu_name);
+
+    g_free(pmu_name);
+    g_free(pmu_cells);
+}
+
 static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                                bool is_32_bit, uint32_t *phandle,
                                uint32_t *irq_mmio_phandle,
@@ -760,6 +787,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
                     &intc_phandles[phandle_pos]);
             }
         }
+        create_fdt_socket_pmu(s, socket, phandle, intc_phandles);
     }
 
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a8f156a66eba..b51ad7496f71 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1032,6 +1032,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str, int max_str_len)
         ISA_EDATA_ENTRY(zkt, ext_zkt),
         ISA_EDATA_ENTRY(zve32f, ext_zve32f),
         ISA_EDATA_ENTRY(zve64f, ext_zve64f),
+        ISA_EDATA_ENTRY(sscofpmf, ext_sscofpmf),
         ISA_EDATA_ENTRY(svinval, ext_svinval),
         ISA_EDATA_ENTRY(svnapot, ext_svnapot),
         ISA_EDATA_ENTRY(svpbmt, ext_svpbmt),
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 7bb85d8d6ad7..0163758297c4 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -20,11 +20,68 @@
 #include "cpu.h"
 #include "pmu.h"
 #include "sysemu/cpu-timers.h"
+#include "sysemu/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
 #define MAKE_32BIT_MASK(shift, length) \
         (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
 
+/**
+ * To keep it simple, any event can be mapped to any programmable counters in
+ * QEMU. The generic cycle & instruction count events can also be monitored
+ * using programmable counters. In that case, mcycle & minstret must continue
+ * to provide the correct value as well. Heterogeneous PMU per hart is not
+ * supported yet. Thus, number of counters are same across all harts.
+ */
+void riscv_pmu_generate_fdt_node(void *fdt, int num_ctrs, char *pmu_name)
+{
+    uint32_t fdt_event_ctr_map[20] = {};
+    uint32_t cmask;
+
+    /* All the programmable counters can map to any event */
+    cmask = MAKE_32BIT_MASK(3, num_ctrs);
+
+   /**
+    * The event encoding is specified in the SBI specification
+    * Event idx is a 20bits wide number encoded as follows:
+    * event_idx[19:16] = type
+    * event_idx[15:0] = code
+    * The code field in cache events are encoded as follows:
+    * event_idx.code[15:3] = cache_id
+    * event_idx.code[2:1] = op_id
+    * event_idx.code[0:0] = result_id
+    */
+
+   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
+   fdt_event_ctr_map[0] = cpu_to_be32(0x00000001);
+   fdt_event_ctr_map[1] = cpu_to_be32(0x00000001);
+   fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
+
+   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
+   fdt_event_ctr_map[3] = cpu_to_be32(0x00000002);
+   fdt_event_ctr_map[4] = cpu_to_be32(0x00000002);
+   fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
+
+   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[6] = cpu_to_be32(0x00010019);
+   fdt_event_ctr_map[7] = cpu_to_be32(0x00010019);
+   fdt_event_ctr_map[8] = cpu_to_be32(cmask);
+
+   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[9] = cpu_to_be32(0x0001001B);
+   fdt_event_ctr_map[10] = cpu_to_be32(0x0001001B);
+   fdt_event_ctr_map[11] = cpu_to_be32(cmask);
+
+   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
+   fdt_event_ctr_map[12] = cpu_to_be32(0x00010021);
+   fdt_event_ctr_map[13] = cpu_to_be32(0x00010021);
+   fdt_event_ctr_map[14] = cpu_to_be32(cmask);
+
+   /* This a OpenSBI specific DT property documented in OpenSBI docs */
+   qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
+                    fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
+}
+
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     if (ctr_idx < 3 || ctr_idx >= RV_MAX_MHPMCOUNTERS ||
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 036653627f78..3004ce37b636 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -31,5 +31,6 @@ int riscv_pmu_init(RISCVCPU *cpu, int num_counters);
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
+void riscv_pmu_generate_fdt_node(void *fdt, int num_counters, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
-- 
2.25.1

