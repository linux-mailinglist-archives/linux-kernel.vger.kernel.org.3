Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18C559E13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiFXQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFXQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:01:43 -0400
Received: from forward501p.mail.yandex.net (forward501p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301B52534
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:01:41 -0700 (PDT)
Received: from myt5-d8fb82618a34.qloud-c.yandex.net (myt5-d8fb82618a34.qloud-c.yandex.net [IPv6:2a02:6b8:c12:59a3:0:640:d8fb:8261])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id B2D0B6215D67;
        Fri, 24 Jun 2022 19:01:36 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt5-d8fb82618a34.qloud-c.yandex.net (mxback/Yandex) with ESMTP id cyUyyZV0wd-1afeYLWn;
        Fri, 24 Jun 2022 19:01:36 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656086496;
        bh=abAFNI17TtevmvwX9RIhVhlH0z4SjFXAqbUQQLt25Yw=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=iLGXD1rC/AY6NKP7zBvtime9CVxW1/ZTQblFSr7nQbojY7tklxefLb/vqLudWfxHP
         FH93mkv2rQIX2iPBgUWD6YzBoUmZ1EdCadbYEHx8hltDilu+KmZJGJVEHp5qhxL4ki
         BUoiCtHlvwF+KHY3tBi3Aqd1lIMrFO7BEIW2O5S8=
Authentication-Results: myt5-d8fb82618a34.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iVUkuL8Azf-1ZMKvOse;
        Fri, 24 Jun 2022 19:01:35 +0300
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
Subject: [PATCH v4 3/5] perf arch events: riscv arch std event files
Date:   Fri, 24 Jun 2022 19:00:53 +0300
Message-Id: <20220624160117.3206-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624160117.3206-1-nikita.shubin@maquefel.me>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

cycles, time and instret counters are defined by RISC-V privileged
spec and they should be available on any RISC-V implementation, epose them
to arch std event files, so they can be reused by particular PMU
bindings.

Derived-from-code-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 .../pmu-events/arch/riscv/riscv-generic.json  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json

diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
new file mode 100644
index 000000000000..a7ffbe87a0f7
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
+    "EventCode": "0x01",
+    "EventName": "riscv_time",
+    "BriefDescription": "CPU time RISC-V generic counter"
+  },
+  {
+    "PublicDescription": "CPU Instructions",
+    "EventCode": "0x02",
+    "EventName": "riscv_instret",
+    "BriefDescription": "CPU retired instructions RISC-V generic counter"
+  }
+]
-- 
2.35.1

