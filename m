Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5776053FFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbiFGN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbiFGN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:26:31 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 06:26:29 PDT
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B3C3D28;
        Tue,  7 Jun 2022 06:26:29 -0700 (PDT)
Received: from myt5-3819f28180eb.qloud-c.yandex.net (myt5-3819f28180eb.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2815:0:640:3819:f281])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id C4A9E94258C;
        Tue,  7 Jun 2022 16:17:15 +0300 (MSK)
Received: from myt6-654ec0a0ab93.qloud-c.yandex.net (myt6-654ec0a0ab93.qloud-c.yandex.net [2a02:6b8:c12:1d80:0:640:654e:c0a0])
        by myt5-3819f28180eb.qloud-c.yandex.net (mxback/Yandex) with ESMTP id GRfsCTAl1R-HFgKe2sS;
        Tue, 07 Jun 2022 16:17:15 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654607835;
        bh=T/sjv6r+evzZz3D9hOnrBsFuwTi03hkMjzMpfeipj8g=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=l5oGOhT7hZTF8satbdLVJ0oUXVdcdHju83EkF1ccx4nf2uh4NtHjtBlJ8FXfFwklS
         2jXlFB5FC2zIaXKj4+YrRxIcpVZQmroRUDUdUpuhuWC3fnDJTKITWlQ9k/QUkw6CKk
         Iqdsr29Somb6sF5nZVmwwj4juo6G22c9zqjhzagk=
Authentication-Results: myt5-3819f28180eb.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-654ec0a0ab93.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sOXgg17Zrk-HEM4WJNa;
        Tue, 07 Jun 2022 16:17:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org (open list),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH v3 4/4] RISC-V: Added HiFive Unmatched PMU events
Date:   Tue,  7 Jun 2022 16:16:47 +0300
Message-Id: <20220607131648.29439-5-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607131648.29439-1-nikita.shubin@maquefel.me>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
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

From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>

This patch contains all the available events for the HiFive Unmatched performance monitoring unit.

Depends on patch [3], for the base mapfile.csv file.

Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Tested-by: Nikita Shubin <n.shubin@yadro.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/sifive/u74/instructions.json   | 92 +++++++++++++++++++
 .../arch/riscv/sifive/u74/memory.json         | 32 +++++++
 .../arch/riscv/sifive/u74/microarch.json      | 57 ++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 4f2aa199d9cb..bda3fb9382f1 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -12,3 +12,4 @@
 #
 #
 #Family-model,Version,Filename,EventType
+0x48980072018,v1,sifive/u74,core
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

