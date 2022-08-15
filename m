Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B469E592FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiHONX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbiHONXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:23:13 -0400
Received: from forward108j.mail.yandex.net (forward108j.mail.yandex.net [5.45.198.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE4E1CB33;
        Mon, 15 Aug 2022 06:23:11 -0700 (PDT)
Received: from forward502p.mail.yandex.net (forward502p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:121])
        by forward108j.mail.yandex.net (Yandex) with ESMTP id 1E2DE3F1FC33;
        Mon, 15 Aug 2022 16:23:09 +0300 (MSK)
Received: from iva1-dcde80888020.qloud-c.yandex.net (iva1-dcde80888020.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7695:0:640:dcde:8088])
        by forward502p.mail.yandex.net (Yandex) with ESMTP id E0917B80F79;
        Mon, 15 Aug 2022 16:23:05 +0300 (MSK)
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id BL0XdiM9S6-N3i4TfZ0;
        Mon, 15 Aug 2022 16:23:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1660569784;
        bh=LGRYFPPAmfj8X4XSMNybmhYCQW3I5BPKT7pd/kdr0YI=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Tw1DOz6d2T+nxlwDX/gXFgupKtLHGpCTcjTvOfe6K/0knM3EKAVwWaCcmfXFNCWaU
         s038K6Si9EPQ6YZRZmaL2xq+3S45L3PKVD3oiHz2DY2HvQxF4gIXCq4OQXRrnGR00r
         l+0Dql6Ce86KitGq9HGA/RKTkDK1R29+vhQKtfck=
Authentication-Results: iva1-dcde80888020.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Anup Patel <anup@brainfault.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v6 2/3] perf arch events: riscv sbi firmware std event files
Date:   Mon, 15 Aug 2022 16:22:39 +0300
Message-Id: <20220815132251.25702-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815132251.25702-1-nikita.shubin@maquefel.me>
References: <20220815132251.25702-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
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

Firmware events are defined by "RISC-V Supervisor Binary Interface
Specification", which means they should be always available as long as
firmware supports >= 0.3.0 SBI.

Expose them to arch std events, so they can be reused by particular
PMU bindings.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Tested-by: Kautuk Consul <kconsul@ventanamicro.com>
---
v5->v6:
Mayuresh Chitale:
	- fixed FW_SFENCE_VMA_SENT event code
---
 .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json

diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
new file mode 100644
index 000000000000..a9939823b14b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
@@ -0,0 +1,134 @@
+[
+  {
+    "PublicDescription": "Misaligned load trap",
+    "ConfigCode": "0x8000000000000000",
+    "EventName": "FW_MISALIGNED_LOAD",
+    "BriefDescription": "Misaligned load trap event"
+  },
+  {
+    "PublicDescription": "Misaligned store trap",
+    "ConfigCode": "0x8000000000000001",
+    "EventName": "FW_MISALIGNED_STORE",
+    "BriefDescription": "Misaligned store trap event"
+  },
+  {
+    "PublicDescription": "Load access trap",
+    "ConfigCode": "0x8000000000000002",
+    "EventName": "FW_ACCESS_LOAD",
+    "BriefDescription": "Load access trap event"
+  },
+  {
+    "PublicDescription": "Store access trap",
+    "ConfigCode": "0x8000000000000003",
+    "EventName": "FW_ACCESS_STORE",
+    "BriefDescription": "Store access trap event"
+  },
+  {
+    "PublicDescription": "Illegal instruction trap",
+    "ConfigCode": "0x8000000000000004",
+    "EventName": "FW_ILLEGAL_INSN",
+    "BriefDescription": "Illegal instruction trap event"
+  },
+  {
+    "PublicDescription": "Set timer event",
+    "ConfigCode": "0x8000000000000005",
+    "EventName": "FW_SET_TIMER",
+    "BriefDescription": "Set timer event"
+  },
+  {
+    "PublicDescription": "Sent IPI to other HART event",
+    "ConfigCode": "0x8000000000000006",
+    "EventName": "FW_IPI_SENT",
+    "BriefDescription": "Sent IPI to other HART event"
+  },
+  {
+    "PublicDescription": "Received IPI from other HART event",
+    "ConfigCode": "0x8000000000000007",
+    "EventName": "FW_IPI_RECEIVED",
+    "BriefDescription": "Received IPI from other HART event"
+  },
+  {
+    "PublicDescription": "Sent FENCE.I request to other HART event",
+    "ConfigCode": "0x8000000000000008",
+    "EventName": "FW_FENCE_I_SENT",
+    "BriefDescription": "Sent FENCE.I request to other HART event"
+  },
+  {
+    "PublicDescription": "Received FENCE.I request from other HART event",
+    "ConfigCode": "0x8000000000000009",
+    "EventName": "FW_FENCE_I_RECEIVED",
+    "BriefDescription": "Received FENCE.I request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent SFENCE.VMA request to other HART event",
+    "ConfigCode": "0x800000000000000a",
+    "EventName": "FW_SFENCE_VMA_SENT",
+    "BriefDescription": "Sent SFENCE.VMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received SFENCE.VMA request from other HART event",
+    "ConfigCode": "0x800000000000000b",
+    "EventName": "FW_SFENCE_VMA_RECEIVED",
+    "BriefDescription": "Received SFENCE.VMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent SFENCE.VMA with ASID request to other HART event",
+    "ConfigCode": "0x800000000000000c",
+    "EventName": "FW_SFENCE_VMA_RECEIVED",
+    "BriefDescription": "Sent SFENCE.VMA with ASID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received SFENCE.VMA with ASID request from other HART event",
+    "ConfigCode": "0x800000000000000d",
+    "EventName": "FW_SFENCE_VMA_ASID_RECEIVED",
+    "BriefDescription": "Received SFENCE.VMA with ASID request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.GVMA request to other HART event",
+    "ConfigCode": "0x800000000000000e",
+    "EventName": "FW_HFENCE_GVMA_SENT",
+    "BriefDescription": "Sent HFENCE.GVMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.GVMA request from other HART event",
+    "ConfigCode": "0x800000000000000f",
+    "EventName": "FW_HFENCE_GVMA_RECEIVED",
+    "BriefDescription": "Received HFENCE.GVMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.GVMA with VMID request to other HART event",
+    "ConfigCode": "0x8000000000000010",
+    "EventName": "FW_HFENCE_GVMA_VMID_SENT",
+    "BriefDescription": "Sent HFENCE.GVMA with VMID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.GVMA with VMID request from other HART event",
+    "ConfigCode": "0x8000000000000011",
+    "EventName": "FW_HFENCE_GVMA_VMID_RECEIVED",
+    "BriefDescription": "Received HFENCE.GVMA with VMID request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.VVMA request to other HART event",
+    "ConfigCode": "0x8000000000000012",
+    "EventName": "FW_HFENCE_VVMA_SENT",
+    "BriefDescription": "Sent HFENCE.VVMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.VVMA request from other HART event",
+    "ConfigCode": "0x8000000000000013",
+    "EventName": "FW_HFENCE_VVMA_RECEIVED",
+    "BriefDescription": "Received HFENCE.VVMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.VVMA with ASID request to other HART event",
+    "ConfigCode": "0x8000000000000014",
+    "EventName": "FW_HFENCE_VVMA_ASID_SENT",
+    "BriefDescription": "Sent HFENCE.VVMA with ASID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.VVMA with ASID request from other HART event",
+    "ConfigCode": "0x8000000000000015",
+    "EventName": "FW_HFENCE_VVMA_ASID_RECEIVED",
+    "BriefDescription": "Received HFENCE.VVMA with ASID request from other HART event"
+  }
+]
-- 
2.35.1

