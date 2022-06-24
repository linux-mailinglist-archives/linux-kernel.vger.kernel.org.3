Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB5559E23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiFXQCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:02:29 -0400
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C8527F5;
        Fri, 24 Jun 2022 09:02:28 -0700 (PDT)
Received: from myt6-9503d8936a58.qloud-c.yandex.net (myt6-9503d8936a58.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4684:0:640:9503:d893])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id A544B6CB8372;
        Fri, 24 Jun 2022 19:01:41 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt6-9503d8936a58.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 86JPym46TO-1ffSsmEq;
        Fri, 24 Jun 2022 19:01:41 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656086501;
        bh=qfYFwSd6zhJPXDppEJzFmsfoBlq0uAMta4BnC0i2seI=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=MlL1W4WTbDu39xNkTLR1Uj5l2gYFnTxBC0BQygKpttxeRS78tjAzX2dPWZ3AGqPEG
         bpKRteWYMnWpbZQlOO9NwN9iVGqaA3SpNI/spW9iNdgHDdT9an/sh4drx59egqt0jV
         6msH57zzfWdrGRFcUot+M4pkRqe6I3eTBh1FcjSY=
Authentication-Results: myt6-9503d8936a58.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iVUkuL8Azf-1eMKkS5t;
        Fri, 24 Jun 2022 19:01:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 4/5] perf arch events: riscv sbi firmware std event files
Date:   Fri, 24 Jun 2022 19:00:54 +0300
Message-Id: <20220624160117.3206-5-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624160117.3206-1-nikita.shubin@maquefel.me>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json

diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
new file mode 100644
index 000000000000..bcaa9891e595
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
@@ -0,0 +1,134 @@
+[
+  {
+    "PublicDescription": "Misaligned load trap",
+    "EventCode": "0x8000000000000000",
+    "EventName": "FW_MISALIGNED_LOAD",
+    "BriefDescription": "Misaligned load trap event"
+  },
+  {
+    "PublicDescription": "Misaligned store trap",
+    "EventCode": "0x8000000000000001",
+    "EventName": "FW_MISALIGNED_STORE",
+    "BriefDescription": "Misaligned store trap event"
+  },
+  {
+    "PublicDescription": "Load access trap",
+    "EventCode": "0x8000000000000002",
+    "EventName": "FW_ACCESS_LOAD",
+    "BriefDescription": "Load access trap event"
+  },
+  {
+    "PublicDescription": "Store access trap",
+    "EventCode": "0x8000000000000003",
+    "EventName": "FW_ACCESS_STORE",
+    "BriefDescription": "Store access trap event"
+  },
+  {
+    "PublicDescription": "Illegal instruction trap",
+    "EventCode": "0x8000000000000004",
+    "EventName": "FW_ILLEGAL_INSN",
+    "BriefDescription": "Illegal instruction trap event"
+  },
+  {
+    "PublicDescription": "Set timer event",
+    "EventCode": "0x8000000000000005",
+    "EventName": "FW_SET_TIMER",
+    "BriefDescription": "Set timer event"
+  },
+  {
+    "PublicDescription": "Sent IPI to other HART event",
+    "EventCode": "0x8000000000000006",
+    "EventName": "FW_IPI_SENT",
+    "BriefDescription": "Sent IPI to other HART event"
+  },
+  {
+    "PublicDescription": "Received IPI from other HART event",
+    "EventCode": "0x8000000000000007",
+    "EventName": "FW_IPI_RECEIVED",
+    "BriefDescription": "Received IPI from other HART event"
+  },
+  {
+    "PublicDescription": "Sent FENCE.I request to other HART event",
+    "EventCode": "0x8000000000000008",
+    "EventName": "FW_FENCE_I_SENT",
+    "BriefDescription": "Sent FENCE.I request to other HART event"
+  },
+  {
+    "PublicDescription": "Received FENCE.I request from other HART event",
+    "EventCode": "0x8000000000000009",
+    "EventName": "FW_FENCE_I_RECEIVED",
+    "BriefDescription": "Received FENCE.I request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent SFENCE.VMA request to other HART event",
+    "EventCode": "0x80000000000000a",
+    "EventName": "FW_SFENCE_VMA_SENT",
+    "BriefDescription": "Sent SFENCE.VMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received SFENCE.VMA request from other HART event",
+    "EventCode": "0x800000000000000b",
+    "EventName": "FW_SFENCE_VMA_RECEIVED",
+    "BriefDescription": "Received SFENCE.VMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent SFENCE.VMA with ASID request to other HART event",
+    "EventCode": "0x800000000000000c",
+    "EventName": "FW_SFENCE_VMA_RECEIVED",
+    "BriefDescription": "Sent SFENCE.VMA with ASID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received SFENCE.VMA with ASID request from other HART event",
+    "EventCode": "0x800000000000000d",
+    "EventName": "FW_SFENCE_VMA_ASID_RECEIVED",
+    "BriefDescription": "Received SFENCE.VMA with ASID request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.GVMA request to other HART event",
+    "EventCode": "0x800000000000000e",
+    "EventName": "FW_HFENCE_GVMA_SENT",
+    "BriefDescription": "Sent HFENCE.GVMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.GVMA request from other HART event",
+    "EventCode": "0x800000000000000f",
+    "EventName": "FW_HFENCE_GVMA_RECEIVED",
+    "BriefDescription": "Received HFENCE.GVMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.GVMA with VMID request to other HART event",
+    "EventCode": "0x8000000000000010",
+    "EventName": "FW_HFENCE_GVMA_VMID_SENT",
+    "BriefDescription": "Sent HFENCE.GVMA with VMID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.GVMA with VMID request from other HART event",
+    "EventCode": "0x8000000000000011",
+    "EventName": "FW_HFENCE_GVMA_VMID_RECEIVED",
+    "BriefDescription": "Received HFENCE.GVMA with VMID request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.VVMA request to other HART event",
+    "EventCode": "0x8000000000000012",
+    "EventName": "FW_HFENCE_VVMA_SENT",
+    "BriefDescription": "Sent HFENCE.VVMA request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.VVMA request from other HART event",
+    "EventCode": "0x8000000000000013",
+    "EventName": "FW_HFENCE_VVMA_RECEIVED",
+    "BriefDescription": "Received HFENCE.VVMA request from other HART event"
+  },
+  {
+    "PublicDescription": "Sent HFENCE.VVMA with ASID request to other HART event",
+    "EventCode": "0x8000000000000014",
+    "EventName": "FW_HFENCE_VVMA_ASID_SENT",
+    "BriefDescription": "Sent HFENCE.VVMA with ASID request to other HART event"
+  },
+  {
+    "PublicDescription": "Received HFENCE.VVMA with ASID request from other HART event",
+    "EventCode": "0x8000000000000015",
+    "EventName": "FW_HFENCE_VVMA_ASID_RECEIVED",
+    "BriefDescription": "Received HFENCE.VVMA with ASID request from other HART event"
+  }
+]
-- 
2.35.1

