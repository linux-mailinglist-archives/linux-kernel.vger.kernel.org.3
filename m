Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E5592FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbiHONYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbiHONYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:24:06 -0400
Received: from forward108j.mail.yandex.net (forward108j.mail.yandex.net [5.45.198.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829221CB16;
        Mon, 15 Aug 2022 06:24:05 -0700 (PDT)
Received: from forward502j.mail.yandex.net (forward502j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::112])
        by forward108j.mail.yandex.net (Yandex) with ESMTP id 999273F21D2C;
        Mon, 15 Aug 2022 16:24:00 +0300 (MSK)
Received: from iva1-dcde80888020.qloud-c.yandex.net (iva1-dcde80888020.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7695:0:640:dcde:8088])
        by forward502j.mail.yandex.net (Yandex) with ESMTP id C5F0611220D4;
        Mon, 15 Aug 2022 16:23:17 +0300 (MSK)
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id BL0XdiM9S6-NFi43JgY;
        Mon, 15 Aug 2022 16:23:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1660569796;
        bh=RAkhKkqKjCwKcANcEidTlittrFwUuUmayhzCnj2pejg=;
        h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
        b=U4H/jPfOhDf4pmT0RhrcydepAENX+xGihB8pnGvHMekkxz7P+up+M04xR2QM8sjxf
         S4UyKX1o8zjnNVq8GjwcUE3b7spC7ij7xw3BbJhJ5A+pE1o8HfQCTK2KV9SzpeW5nC
         LvDwiTOtoiseBf5Yf1nM2L9UkbKVRPHWLsimRXZA=
Authentication-Results: iva1-dcde80888020.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Anup Patel <anup@brainfault.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6 3/3] perf vendor events riscv: add Sifive U74 JSON file
Date:   Mon, 15 Aug 2022 16:22:40 +0300
Message-Id: <20220815132251.25702-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815132251.25702-1-nikita.shubin@maquefel.me>
References: <20220815132251.25702-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

This patch add the Sifive U74 JSON file.

Derived-from-code-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Link: https://sifive.cdn.prismic.io/sifive/ad5577a0-9a00-45c9-a5d0-424a3d586060_u74_core_complex_manual_21G3.pdf
Tested-by: Kautuk Consul <kconsul@ventanamicro.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  | 17 ++++
 .../arch/riscv/sifive/u74/firmware.json       | 68 ++++++++++++++
 .../arch/riscv/sifive/u74/instructions.json   | 92 +++++++++++++++++++
 .../arch/riscv/sifive/u74/memory.json         | 32 +++++++
 .../arch/riscv/sifive/u74/microarch.json      | 57 ++++++++++++
 5 files changed, 266 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
new file mode 100644
index 000000000000..c61b3d6ef616
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -0,0 +1,17 @@
+# Format:
+#	MVENDORID-MARCHID-MIMPID,Version,JSON/file/pathname,Type
+#
+# where
+#	MVENDORID	JEDEC code of the core provider
+#	MARCHID		base microarchitecture of the hart
+#	MIMPID		unique encoding of the version
+#			of the processor implementation
+#	Version could be used to track version of JSON file
+#		but currently unused.
+#	JSON/file/pathname is the path to JSON file, relative
+#		to tools/perf/pmu-events/arch/riscv/.
+#	Type is core, uncore etc
+#
+#
+#MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
+0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
new file mode 100644
index 000000000000..5eab718c9256
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
@@ -0,0 +1,92 @@
+[
+  {
+    "EventName": "EXCEPTION_TAKEN",
+    "EventCode": "0x0000100",
+    "BriefDescription": "Exception taken"
+  },
+  {
+    "EventName": "INTEGER_LOAD_RETIRED",
+    "EventCode": "0x0000200",
+    "BriefDescription": "Integer load instruction retired"
+  },
+  {
+    "EventName": "INTEGER_STORE_RETIRED",
+    "EventCode": "0x0000400",
+    "BriefDescription": "Integer store instruction retired"
+  },
+  {
+    "EventName": "ATOMIC_MEMORY_RETIRED",
+    "EventCode": "0x0000800",
+    "BriefDescription": "Atomic memory operation retired"
+  },
+  {
+    "EventName": "SYSTEM_INSTRUCTION_RETIRED",
+    "EventCode": "0x0001000",
+    "BriefDescription": "System instruction retired"
+  },
+  {
+    "EventName": "INTEGER_ARITHMETIC_RETIRED",
+    "EventCode": "0x0002000",
+    "BriefDescription": "Integer arithmetic instruction retired"
+  },
+  {
+    "EventName": "CONDITIONAL_BRANCH_RETIRED",
+    "EventCode": "0x0004000",
+    "BriefDescription": "Conditional branch retired"
+  },
+  {
+    "EventName": "JAL_INSTRUCTION_RETIRED",
+    "EventCode": "0x0008000",
+    "BriefDescription": "JAL instruction retired"
+  },
+  {
+    "EventName": "JALR_INSTRUCTION_RETIRED",
+    "EventCode": "0x0010000",
+    "BriefDescription": "JALR instruction retired"
+  },
+  {
+    "EventName": "INTEGER_MULTIPLICATION_RETIRED",
+    "EventCode": "0x0020000",
+    "BriefDescription": "Integer multiplication instruction retired"
+  },
+  {
+    "EventName": "INTEGER_DIVISION_RETIRED",
+    "EventCode": "0x0040000",
+    "BriefDescription": "Integer division instruction retired"
+  },
+  {
+    "EventName": "FP_LOAD_RETIRED",
+    "EventCode": "0x0080000",
+    "BriefDescription": "Floating-point load instruction retired"
+  },
+  {
+    "EventName": "FP_STORE_RETIRED",
+    "EventCode": "0x0100000",
+    "BriefDescription": "Floating-point store instruction retired"
+  },
+  {
+    "EventName": "FP_ADDITION_RETIRED",
+    "EventCode": "0x0200000",
+    "BriefDescription": "Floating-point addition retired"
+  },
+  {
+    "EventName": "FP_MULTIPLICATION_RETIRED",
+    "EventCode": "0x0400000",
+    "BriefDescription": "Floating-point multiplication retired"
+  },
+  {
+    "EventName": "FP_FUSEDMADD_RETIRED",
+    "EventCode": "0x0800000",
+    "BriefDescription": "Floating-point fused multiply-add retired"
+  },
+  {
+    "EventName": "FP_DIV_SQRT_RETIRED",
+    "EventCode": "0x1000000",
+    "BriefDescription": "Floating-point division or square-root retired"
+  },
+  {
+    "EventName": "OTHER_FP_RETIRED",
+    "EventCode": "0x2000000",
+    "BriefDescription": "Other floating-point instruction retired"
+  }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
new file mode 100644
index 000000000000..be1a46312ac3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
@@ -0,0 +1,32 @@
+[
+  {
+    "EventName": "ICACHE_RETIRED",
+    "EventCode": "0x0000102",
+    "BriefDescription": "Instruction cache miss"
+  },
+  {
+    "EventName": "DCACHE_MISS_MMIO_ACCESSES",
+    "EventCode": "0x0000202",
+    "BriefDescription": "Data cache miss or memory-mapped I/O access"
+  },
+  {
+    "EventName": "DCACHE_WRITEBACK",
+    "EventCode": "0x0000402",
+    "BriefDescription": "Data cache write-back"
+  },
+  {
+    "EventName": "INST_TLB_MISS",
+    "EventCode": "0x0000802",
+    "BriefDescription": "Instruction TLB miss"
+  },
+  {
+    "EventName": "DATA_TLB_MISS",
+    "EventCode": "0x0001002",
+    "BriefDescription": "Data TLB miss"
+  },
+  {
+    "EventName": "UTLB_MISS",
+    "EventCode": "0x0002002",
+    "BriefDescription": "UTLB miss"
+  }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
new file mode 100644
index 000000000000..50ffa55418cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
@@ -0,0 +1,57 @@
+[
+  {
+    "EventName": "ADDRESSGEN_INTERLOCK",
+    "EventCode": "0x0000101",
+    "BriefDescription": "Address-generation interlock"
+  },
+  {
+    "EventName": "LONGLAT_INTERLOCK",
+    "EventCode": "0x0000201",
+    "BriefDescription": "Long-latency interlock"
+  },
+  {
+    "EventName": "CSR_READ_INTERLOCK",
+    "EventCode": "0x0000401",
+    "BriefDescription": "CSR read interlock"
+  },
+  {
+    "EventName": "ICACHE_ITIM_BUSY",
+    "EventCode": "0x0000801",
+    "BriefDescription": "Instruction cache/ITIM busy"
+  },
+  {
+    "EventName": "DCACHE_DTIM_BUSY",
+    "EventCode": "0x0001001",
+    "BriefDescription": "Data cache/DTIM busy"
+  },
+  {
+    "EventName": "BRANCH_DIRECTION_MISPREDICTION",
+    "EventCode": "0x0002001",
+    "BriefDescription": "Branch direction misprediction"
+  },
+  {
+    "EventName": "BRANCH_TARGET_MISPREDICTION",
+    "EventCode": "0x0004001",
+    "BriefDescription": "Branch/jump target misprediction"
+  },
+  {
+    "EventName": "PIPE_FLUSH_CSR_WRITE",
+    "EventCode": "0x0008001",
+    "BriefDescription": "Pipeline flush from CSR write"
+  },
+  {
+    "EventName": "PIPE_FLUSH_OTHER_EVENT",
+    "EventCode": "0x0010001",
+    "BriefDescription": "Pipeline flush from other event"
+  },
+  {
+    "EventName": "INTEGER_MULTIPLICATION_INTERLOCK",
+    "EventCode": "0x0020001",
+    "BriefDescription": "Integer multiplication interlock"
+  },
+  {
+    "EventName": "FP_INTERLOCK",
+    "EventCode": "0x0040001",
+    "BriefDescription": "Floating-point interlock"
+  }
+]
\ No newline at end of file
-- 
2.35.1

