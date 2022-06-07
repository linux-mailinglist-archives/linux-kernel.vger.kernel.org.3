Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E153FFF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbiFGNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiFGNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:25:28 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 06:25:25 PDT
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net [37.140.190.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C1BE164;
        Tue,  7 Jun 2022 06:25:25 -0700 (PDT)
Received: from myt5-a76c7b0c543c.qloud-c.yandex.net (myt5-a76c7b0c543c.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2908:0:640:a76c:7b0c])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id F3ED745C4C8B;
        Tue,  7 Jun 2022 16:17:06 +0300 (MSK)
Received: from myt6-654ec0a0ab93.qloud-c.yandex.net (myt6-654ec0a0ab93.qloud-c.yandex.net [2a02:6b8:c12:1d80:0:640:654e:c0a0])
        by myt5-a76c7b0c543c.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 0JqJ9qHZUZ-H6fOeVsZ;
        Tue, 07 Jun 2022 16:17:06 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654607826;
        bh=H5ZJSB+X5ZPk+u9IuwBsHvhkdVj5IngYfZMVK2pBn+Q=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=nYhgRjYg+zJOPmbF47oV3H7hZ0cLH7P5Uk6Ki6HcvRMzoaJb0SsL1tRVTCoW953Q6
         yfG5q9/auzw8JMI3gNKAPFT+Rp/Zb4YWDXcPQkaRSI2h8d7QRw56mBlOg2TUpKWqkr
         4YwbpAkC8jkQv7KTU6thzeGxEKvPmGsZsaAnSR2s=
Authentication-Results: myt5-a76c7b0c543c.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-654ec0a0ab93.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sOXgg17Zrk-H5M4o90G;
        Tue, 07 Jun 2022 16:17:05 +0300
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
Subject: [PATCH v3 3/4] RISC-V: Added generic pmu-events mapfile
Date:   Tue,  7 Jun 2022 16:16:46 +0300
Message-Id: <20220607131648.29439-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607131648.29439-1-nikita.shubin@maquefel.me>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>

The pmu-events now supports custom events for RISC-V, plus the cycle,
time and instret events were defined.

Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Tested-by: Nikita Shubin <n.shubin@yadro.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  | 14 +++++++++++++
 .../pmu-events/arch/riscv/riscv-generic.json  | 20 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
new file mode 100644
index 000000000000..4f2aa199d9cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -0,0 +1,14 @@
+# Format:
+#	MIDR,Version,JSON/file/pathname,Type
+#
+# where
+#	MIDR	Processor version
+#		Variant[23:20] and Revision [3:0] should be zero.
+#	Version could be used to track version of JSON file
+#		but currently unused.
+#	JSON/file/pathname is the path to JSON file, relative
+#		to tools/perf/pmu-events/arch/riscv/.
+#	Type is core, uncore etc
+#
+#
+#Family-model,Version,Filename,EventType
diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
new file mode 100644
index 000000000000..013e50efad99
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
@@ -0,0 +1,20 @@
+[
+  {
+    "PublicDescription": "CPU Cycles",
+    "EventCode": "0x00",
+    "EventName": "riscv_cycles",
+    "BriefDescription": "CPU cycles RISC-V generic counter"
+  },
+  {
+    "PublicDescription": "CPU Time",
+      "EventCode": "0x01",
+      "EventName": "riscv_time",
+      "BriefDescription": "CPU time RISC-V generic counter"
+  },
+  {
+    "PublicDescription": "CPU Instructions",
+      "EventCode": "0x02",
+      "EventName": "riscv_instret",
+      "BriefDescription": "CPU retired instructions RISC-V generic counter"
+  }
+]
\ No newline at end of file
-- 
2.35.1

