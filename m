Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8E50343B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiDPCpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiDPCpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:45:15 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FD134;
        Fri, 15 Apr 2022 19:42:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bg9so9363701pgb.9;
        Fri, 15 Apr 2022 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXoVsWrrvVTNRRN6nzP3JgGhrdX3aN2oduI58UStebw=;
        b=TTa2v/vCv9FbhRf5PLykRl5wJuGd+GB0FkIGtTg6Bu02tX8l6WG0kBqp8Nfp+JyqAC
         sIONB0kkIEWvAXZTljhL8sATHEsVpfgTk1jrZDcqiy72DQj5hKXI851orEfjLZsqbZT7
         daCw82iZWYwqcYiZG9lV/z+DSebzHrqBoERIYgXaeIpjfLSoC/W1hSnOVTvCnbm9IfUG
         o1NzkzK8iYoB3Ts3y0bT4L/MvGBVT3lIy7/tQUn9IWzP9ooYcwO9SnCvF5Z6/Ju9iEST
         iWlcGg67m4C+Ncp9ugGVYxZ9EEBCGwp5dmTtvZBJhWRA2CHZSLhzeEsAHI2JpcMLmu0Q
         R5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SXoVsWrrvVTNRRN6nzP3JgGhrdX3aN2oduI58UStebw=;
        b=46vFLfFG9A54K0zN1RiKNyF4L9rAePWEZij5BbYJ8qAfkZzuymCAQHYK933xNSaw8D
         3hNw3+e01xusT2xR+DrFRlwrnQYggRj4LoSli8T9xgPs+p4c+9x4z4xBdUh+p63bYqwA
         M3woGRVsOh7HypuAThNutLjxA9Q8o3+qyp87fhbpY83DNXMDP+9bndkVEm4l0sUrYa0o
         e0cJuXo4zGPVcI/D6QMVC2xPXVFLMXYzf9XmxgiOtVPk2OhVhjjKbVVLiYtKglf1vdEQ
         b//+q9bIkSdMjqkJIoO3Tg+fgUyLWH6vo4fDhZH7kfBc2JEgvYHaZCyFBm2s3YClN1tm
         s1rw==
X-Gm-Message-State: AOAM531vKzFEiP+CYD9RR5iZJ4wGW1V0kW9BVOtNcGWAWGeNnHlAlHqC
        pk9Qbl292g+CAMxTTz46FhsnMfUTYq0=
X-Google-Smtp-Source: ABdhPJwAy3vIuGOqGXEuKHQKtScI4nlcAtfNuxl7peC9v1lMweP6i+J/TEBILTTbRqj2F0hemcztAg==
X-Received: by 2002:a63:451b:0:b0:380:b9f8:13f4 with SMTP id s27-20020a63451b000000b00380b9f813f4mr1159993pga.367.1650069663050;
        Fri, 15 Apr 2022 17:41:03 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:461:36d2:dba1:7530:2cda:19b1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm3913537pfu.82.2022.04.15.17.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:41:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/3] perf symbol: Remove arch__symbols__fixup_end()
Date:   Fri, 15 Apr 2022 17:40:48 -0700
Message-Id: <20220416004048.1514900-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220416004048.1514900-1-namhyung@kernel.org>
References: <20220416004048.1514900-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the generic code can handle kallsyms fixup properly so no need to
keep the arch-functions anymore.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/arm64/util/machine.c   | 21 ---------------------
 tools/perf/arch/powerpc/util/Build     |  1 -
 tools/perf/arch/powerpc/util/machine.c | 25 -------------------------
 tools/perf/arch/s390/util/machine.c    | 16 ----------------
 tools/perf/util/symbol.c               |  5 -----
 tools/perf/util/symbol.h               |  1 -
 6 files changed, 69 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/machine.c

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index d2ce31e28cd7..41c1596e5207 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -8,27 +8,6 @@
 #include "callchain.h"
 #include "record.h"
 
-/* On arm64, kernel text segment starts at high memory address,
- * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
- * address, like 0xffff 0000 00ax xxxx. When only small amount of
- * memory is used by modules, gap between end of module's text segment
- * and start of kernel text segment may reach 2G.
- * Therefore do not fill this gap and do not assign it to the kernel dso map.
- */
-
-#define SYMBOL_LIMIT (1 << 12) /* 4K */
-
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
-{
-	if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
-			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
-		/* Limit range of last symbol in module and kernel */
-		p->end += SYMBOL_LIMIT;
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
-}
-
 void arch__add_leaf_frame_record_opts(struct record_opts *opts)
 {
 	opts->sample_user_regs |= sample_reg_masks[PERF_REG_ARM64_LR].mask;
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 8a79c4126e5b..0115f3166568 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,4 @@
 perf-y += header.o
-perf-y += machine.o
 perf-y += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
diff --git a/tools/perf/arch/powerpc/util/machine.c b/tools/perf/arch/powerpc/util/machine.c
deleted file mode 100644
index e652a1aa8132..000000000000
--- a/tools/perf/arch/powerpc/util/machine.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <inttypes.h>
-#include <stdio.h>
-#include <string.h>
-#include <internal/lib.h> // page_size
-#include "debug.h"
-#include "symbol.h"
-
-/* On powerpc kernel text segment start at memory addresses, 0xc000000000000000
- * whereas the modules are located at very high memory addresses,
- * for example 0xc00800000xxxxxxx. The gap between end of kernel text segment
- * and beginning of first module's text segment is very high.
- * Therefore do not fill this gap and do not assign it to the kernel dso map.
- */
-
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
-{
-	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-		/* Limit the range of last kernel symbol */
-		p->end += page_size;
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
-}
diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 7644a4f6d4a4..98bc3f39d5f3 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -35,19 +35,3 @@ int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 
 	return 0;
 }
-
-/* On s390 kernel text segment start is located at very low memory addresses,
- * for example 0x10000. Modules are located at very high memory addresses,
- * for example 0x3ff xxxx xxxx. The gap between end of kernel text segment
- * and beginning of first module's text segment is very big.
- * Therefore do not fill this gap and do not assign it to the kernel dso map.
- */
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
-{
-	if (strchr(p->name, '[') == NULL && strchr(c->name, '['))
-		/* Last kernel symbol mapped to end of page */
-		p->end = roundup(p->end, page_size);
-	else
-		p->end = c->start;
-	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
-}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 623094e866fd..f72baf636724 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -101,11 +101,6 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
-void __weak arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
-{
-	p->end = c->start;
-}
-
 const char * __weak arch__normalize_symbol_name(const char *name)
 {
 	return name;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5fcdd1f94c56..0b893dcc8ea6 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -241,7 +241,6 @@ const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
 
-void arch__symbols__fixup_end(struct symbol *p, struct symbol *c);
 int arch__compare_symbol_names(const char *namea, const char *nameb);
 int arch__compare_symbol_names_n(const char *namea, const char *nameb,
 				 unsigned int n);
-- 
2.36.0.rc0.470.gd361397f0d-goog

