Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746D4525A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbiEMEFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376930AbiEMEFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87D29B025
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7eaa730d9so62510687b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20i4c1kc+enHNe40Ax5Yg1Hwx6kxN38xUQQ6orKgm5M=;
        b=QpsfvaFVhUgzwxz9VTeCun1CQpi20aeZleVBr7p+5qnaq/zf0ooX26/68S/OwE8Cn/
         mI/kdQQAHxlMKD7IZhg5dFosbsXW24XDN60pyUkgxMBMPPikOvyg3T1JpMv2NG9+es61
         Il0duHkhcZeKyHO2nkr/ahOkjkynFMrnCtdzMnhZI5ogSepB6WVAvIyzoZFezhPTv1um
         MzvWxcViOPPWXZlZe2Runzadv/0iOnvUUJF/VO0Ch2FPWxAMEAlCHQ3Tj4qEGa0gCtYY
         jfga3HRFjDuYxPurA7RE2bu3Xd/JdHs3W/em/dT8ttKhNg6VXBaWK0/iISVqpPoNraNw
         YrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20i4c1kc+enHNe40Ax5Yg1Hwx6kxN38xUQQ6orKgm5M=;
        b=f5cayi014KhJxqGySP+uhuWvz7GIHQdusUqqXluGRzl2dpVB8fYBu6JlDgPuJ+rOKA
         pWIq1a90bF5gAmgf4qZJU0T6TLavSbOdcVmqbz3bb82krMDCQ2kZFJbjYSCUtvqoJg3L
         kqrKs7/WMEtYlM24rFKau4cLsbEXVqwXpxNxva6rmS4Pa0WqL9K1C05Gm31m7oZWKar8
         lFQidOnUfHOKfwG+qdr/4uXTCegGkYWgLBZYW1CIwDtuUMRde/UWg1wYH2ltrdp9j/wv
         nTBynb3Ri5oB8D8Ypkdg8taefWraYcRoyPYzbMAIMSWWElTJWp8kEFMCLp1hAsL6UkzG
         YVGQ==
X-Gm-Message-State: AOAM532EDYhB3ggT+nsdTQ4iUqiRBeh5eoEJLGyMys9y3MeUBzC37j0n
        kuwMaIEJ+LTpzMwDITenOegUGwruwSMy
X-Google-Smtp-Source: ABdhPJwaZZfSOmopDsuZd6+bJPH9rtKQAR3lvKZfNgkt+4z4fWX387Ba3M8Eb6MMf0/bEJH5wKU7LPpfgxhY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a81:24d2:0:b0:2f7:b684:de49 with SMTP id
 k201-20020a8124d2000000b002f7b684de49mr3552435ywk.310.1652414729894; Thu, 12
 May 2022 21:05:29 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:14 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-3-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 2/7] perf test: Use skip in vmlinux kallsyms
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently failures in reading vmlinux or kallsyms result in a test
failure. However, the failure is typically permission related. Prefer to
flag these failures as skip.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 93dee542a177..983f32964749 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -114,7 +114,7 @@ static bool is_ignored_symbol(const char *name, char type)
 static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	struct rb_node *nd;
 	struct symbol *sym;
 	struct map *kallsyms_map, *vmlinux_map, *map;
@@ -142,7 +142,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * and find the .ko files that match them in /lib/modules/`uname -r`/.
 	 */
 	if (machine__create_kernel_maps(&kallsyms) < 0) {
-		pr_debug("machine__create_kernel_maps ");
+		pr_info("machine__create_kernel_maps failed");
+		err = TEST_SKIP;
 		goto out;
 	}
 
@@ -158,7 +159,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * code and with the one got from /proc/modules from the "kallsyms" code.
 	 */
 	if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
-		pr_debug("dso__load_kallsyms ");
+		pr_debug("machine__load_kallsyms failed");
+		err = TEST_SKIP;
 		goto out;
 	}
 
@@ -178,7 +180,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * Now repeat step 2, this time for the vmlinux file we'll auto-locate.
 	 */
 	if (machine__create_kernel_maps(&vmlinux) < 0) {
-		pr_debug("machine__create_kernel_maps ");
+		pr_info("machine__create_kernel_maps failed");
 		goto out;
 	}
 
@@ -196,7 +198,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * to fixup the symbols.
 	 */
 	if (machine__load_vmlinux_path(&vmlinux) <= 0) {
-		pr_debug("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
+		pr_info("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
 		err = TEST_SKIP;
 		goto out;
 	}
-- 
2.36.0.550.gb090851708-goog

