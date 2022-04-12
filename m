Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299964FCF69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348825AbiDLGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348812AbiDLGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:24:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61933527D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:21:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso151626807b3.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HzomVY0olxlcRBNiMB5SwP5ngXXVoIPEfEro53+54ZQ=;
        b=SEyq9ho4qtyAgW+mk2g98z38qAKJ6HQIWpDEYkiWnICB1BxbuMWhCkUUr0rv+SpocO
         XQBL9XC9gjwufJwJSASAW7yYVJCnKj9ljVvPDs5IV/nyBRof+y5BMXPeOSjSQLXg6tDI
         f3g13iT4aw6qrNAq21r4TWjdDNMjmJsabhUGV5KcFNbRSwkbbWG01pKtaSU1vw2DW2d/
         sZOhqy5uNB5lzijRkpbalr/lkFN/FJzfhIZypHTxLfWqu2WwD0K9YzBz0ap8P6mcDN22
         VwxWhls0eTW4VLCdFNTPCCT3LkWTU0ozj5wJ31QIT5X6//opc7FwMLaAOMROqkegBGLM
         hSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HzomVY0olxlcRBNiMB5SwP5ngXXVoIPEfEro53+54ZQ=;
        b=y/mRvuG57V5LEU7WMBr8AZWLEH//3u3zA2RuYxENBowwpnXNYXJLLccyVEGAStbsq3
         CwZMksWHxbjV+X4+x9LZkZQWgDT7N7KloTXJEyQYM6cYo2n1feL7RhOjtFA4XNHv17ts
         W49XVyqyf0KJWd0inP+VkBlpF69QI884eRadbQHfdQN7vW9Gj11cyVK6fnXSOdP3R+qM
         KEXx3pkK35D+eHPjs26/UmbP4uBsqooypESdS/rlEAAjRtDrRjY38w/t/IblwY4wYKMK
         IsMGOqKW7yt8Re4k8QaZTJGyv+5g2VpWjqO3ZOLABPSnH1sbOHUtk6dmVnRRGWfOjhEJ
         ibCg==
X-Gm-Message-State: AOAM5338Npg0AiIx8LieEVrK0vJx4dACahklDUOw+y/jUmu09cid7/IW
        dMKnELfE+j2nV48Xk7DiITNzOWJPIzmp
X-Google-Smtp-Source: ABdhPJyOArb9eQdHrqf/7roL1sLSn1N5NiksCkxSmd1GeFjfDvdKab7zSPrk8yU94iF3JAqSSvRxYc2f0Nzq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a25:94a:0:b0:615:7cf4:e2cd with SMTP id
 u10-20020a25094a000000b006157cf4e2cdmr26355407ybm.227.1649744513096; Mon, 11
 Apr 2022 23:21:53 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:21:33 -0700
In-Reply-To: <20220412062133.2546080-1-irogers@google.com>
Message-Id: <20220412062133.2546080-3-irogers@google.com>
Mime-Version: 1.0
References: <20220412062133.2546080-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 3/3] perf test: Add basic perf record tests
From:   Ian Rogers <irogers@google.com>
To:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the --per-thread flag.
Test Intel machine state capturing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 tools/perf/tests/shell/record.sh

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
new file mode 100755
index 000000000000..2c85e73a0af4
--- /dev/null
+++ b/tools/perf/tests/shell/record.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# perf record tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+test_per_thread() {
+  echo "Basic --per-thread mode test"
+  perf record -o - --per-thread true | perf report -i - > /dev/null
+  echo "Basic --per-thread mode test [Success]"
+}
+
+test_register_capture() {
+  echo "Register capture test"
+  if ! perf list | egrep -q 'br_inst_retired.near_call'
+  then
+    echo "Register capture test [Skipped missing instruction]"
+    return
+  fi
+  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
+  then
+    echo "Register capture test [Skipped missing registers]"
+    return
+  fi
+  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p -c 1000 --per-thread true | perf script -F ip,sym,iregs  -i - | egrep -q "DI:"
+  then
+    echo "Register capture test [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Register capture test [Success]"
+}
+
+test_per_thread
+test_register_capture
+exit $err
-- 
2.35.1.1178.g4f1659d476-goog

