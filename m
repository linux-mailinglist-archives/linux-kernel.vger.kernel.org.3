Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0BB52B162
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiEREUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiEREUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD521251
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c205-20020a254ed6000000b0064d5bd93479so873953ybb.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/et+mNXky9AxgqPAZ+01K1qLv9QXAe8M1JaYskOrLf4=;
        b=aYImPI0UwHk+52e5no/ILuPrJfO3c3hinpptzjjpVQXzYxqXKctJPuu6vh7PjAQwGh
         5YxQ59UjalDv7cVWGPtIZUuQ67qUayzv7cX/6ZWbi4VtWGZIntGJOb3oWax4NCunNetS
         L8ZekdeFUTPnlfnT/r6EWJQwP8FzXZBbrsR983XBL6YbqumBcv1Ae5jjGClfiVfGCvrI
         rGqtJgbI8D9AZQTHjd1+TSZZIKCzzisFzHV1NI+98fTGdpbqwa/yxR7MQvL0NUpNoiwx
         ++/W35XpKsPWGA7XCcN5TISjB1/eLUlL3VFNK11UkwGm/Fx1+DDzUKq1Z0GaLwmGepRA
         Oo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/et+mNXky9AxgqPAZ+01K1qLv9QXAe8M1JaYskOrLf4=;
        b=ZZwFc0XaIg93ShsjRpmJ2L7nhEkmdeJYUVXrcekhUm5oK5uoTlM2mjT35l9YSoKfP8
         kbng+6Qg/BmP70fCAXvwrWeDEQ5/IfDER1YOne4QccuHGpTYf7oB+9JHqDN6HQJgwcNF
         3mU9agg+IO1FVtnB83lXpnaXWq8T4gXeI92c0X2poNx0DK2QTRNYCkloLdS3NxUrkG56
         tpnRczT61L9lA6fpvIwyxtooreUIiddbwcGRGcwftmpop5QuWQzNRxl16xDjMIaqV8bC
         ch7CVIRWtR70Z2tDa7xrYD3VdAVoQlTL7+aI2zWH+pciPwIoegTDaQ0TUrjQeiHVgin6
         ifTQ==
X-Gm-Message-State: AOAM530OqOMmd7/Xp72jlI4yw3K+vh8ZVDuBBl1ZSLCueonJzGVYnpAo
        2JkWp0+NgQn1O+W0HMHO8YGLn+pYj5jR
X-Google-Smtp-Source: ABdhPJzA31F5Eh2pcBc3NkRDp7vhQd5a9Npu6LdorVkBhQJSHBs+FimXYU6pTuBJ4J9+7Ei5NKS7HwZYyWmk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:7008:0:b0:648:6d04:f4ab with SMTP id
 l8-20020a257008000000b006486d04f4abmr26390471ybc.127.1652847637939; Tue, 17
 May 2022 21:20:37 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:21 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-3-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 2/8] perf test: Use skip in vmlinux kallsyms
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
index 93dee542a177..4fd8d703ff19 100644
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
+		pr_debug("machine__create_kernel_maps failed");
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

