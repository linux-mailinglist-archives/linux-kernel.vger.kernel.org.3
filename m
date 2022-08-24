Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACB059F2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiHXFGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiHXFGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:06:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF5558C7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:06:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334ab1f0247so271976637b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=6TPsU2u1PMlB6YEiiiYUheNwo8SxpDri4fU5Br0CXQc=;
        b=YBkaKI8h6AyjFuz63flYtzVgEDtViIr0D7upY2rEoRmQg7fG15/hl32j6Pf/w+UOHn
         6ew2wXwQfvRTb/vM38DCOMNHvpBfv+rbmHjxhCSmU8PA9O6dP+UEwO0qOOCGKYLrePQh
         Ml21rDb6bDusGC8ZWRg42X2JiPsvJqMNfJbvcJQYfcK0iGci/fktUMlF27FRs5ni1Iek
         adhIuUkwQc+vUxZkNklHMG1Gh1KmhfJLg5zj8iugaGR2W5TckfplQioVG9szmc+/bLCa
         ihGiPbS2ieBCTpEN4jGigJHeIZRHI8uYRePR7nyS9XUcYFp1dTf5YeYbKUrMd12jZ3g2
         ZifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=6TPsU2u1PMlB6YEiiiYUheNwo8SxpDri4fU5Br0CXQc=;
        b=5YNkLYuSIurDgOdLTEDvEi5/bSLM6MVQFNgphbg+ydUE/+/5IdIiEvYDkzUTn+7hPx
         fHSeRfS0BRK5PQCjPpx25Sha6Tc6Lg+65EXroXPefzSA7BhtfQJPBHTbYv+wlBcD6Rxw
         If1uRxArN0gqEzgX7F1ISYey749nGPsjEGKw4Z//XNdEW3WgDr8MwQnaIJScAEdFdkuu
         Z4cK3CapmFQno3p0vYVhr43m1cvlG0bzyEmNvHw2kC6GdT+/VhxVhwLKl4ukqGlqgEUI
         1iqeaH8LKF1/l8KRoOKEDUQcneXhw5dKrfWJJm+U3bhu+YT7RWGutAM+2eFpXH9/uMNq
         bH+Q==
X-Gm-Message-State: ACgBeo2BX09L9wDqymnWFJD5Vwd86Np/mAfybbIzPqWwySxB4JYfAXEk
        QVzbAHXHxD8tPDQA67KxH/1Y/BVr+aRC
X-Google-Smtp-Source: AA6agR6iMWv1lcKmOl/fH+3BXHWl8wtTx/veQrq/92ytBQenoeT4YYDXoPhBZfZEscrInxF+AY7CFxoGW9N0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:6d88:0:b0:695:9728:f253 with SMTP id
 i130-20020a256d88000000b006959728f253mr14593907ybc.39.1661317572529; Tue, 23
 Aug 2022 22:06:12 -0700 (PDT)
Date:   Tue, 23 Aug 2022 22:06:04 -0700
Message-Id: <20220824050604.352156-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH] perf hashmap: Tidy hashmap dependency
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

When libbpf is present the build uses definitions in libbpf hashmap.c,
however, libbpf's hashmap.h wasn't being used. Switch to using the
correct hashmap.h dependent on the define HAVE_LIBBPF_SUPPORT. This
was the original intent in:
https://lore.kernel.org/lkml/20200515221732.44078-8-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c |  6 +++++-
 tools/perf/util/evsel.c      |  6 +++++-
 tools/perf/util/expr.h       | 11 ++++-------
 tools/perf/util/stat.c       |  6 +++++-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index e2052f4fed33..d657594894cf 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -27,7 +27,11 @@
 #include "util.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
-#include "hashmap.h"
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/hashmap.h>
+#else
+#include "util/hashmap.h"
+#endif
 #include "asm/bug.h"
 
 #include <internal/xyarray.h>
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4852089e1d79..14846b7edb17 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,7 +46,11 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util.h"
-#include "hashmap.h"
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/hashmap.h>
+#else
+#include "util/hashmap.h"
+#endif
 #include "pmu-hybrid.h"
 #include "off_cpu.h"
 #include "../perf-sys.h"
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index bd2116983bbb..0403a92d9dcc 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,14 +2,11 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-// There are fixes that need to land upstream before we can use libbpf's headers,
-// for now use our copy unconditionally, since the data structures at this point
-// are exactly the same, no problem.
-//#ifdef HAVE_LIBBPF_SUPPORT
-//#include <bpf/hashmap.h>
-//#else
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/hashmap.h>
+#else
 #include "util/hashmap.h"
-//#endif
+#endif
 
 struct metric_ref;
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0882b4754fcf..ce5e9e372fc4 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -14,7 +14,11 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#include "hashmap.h"
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/hashmap.h>
+#else
+#include "util/hashmap.h"
+#endif
 #include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
-- 
2.37.2.609.g9ff673ca1a-goog

