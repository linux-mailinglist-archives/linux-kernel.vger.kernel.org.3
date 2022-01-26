Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64C549CDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiAZPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiAZPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:19:30 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEBC06161C;
        Wed, 26 Jan 2022 07:19:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o12so8510250qke.5;
        Wed, 26 Jan 2022 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwu3myTpJGyKxxQxJSkpa+xw92TaeKDMkG4bkP0rzlc=;
        b=bdRIHzpDCNGv/idJ+H7syQeBaST6wcI+NjJXS96O+HPFHGyaqF2BZJ4V1jav47Ue5F
         QbB0IVPjHS/3WzJ5Od5W6lsN82SeaYTknAaEv2d0AVXo/4RnYobXsGDXP5n5nwV/nQ4K
         99pM6mrQtJPMr1WIQIFIKfTfm40zCW+685nX/vzMnfgMzvGS1tl67qVSpwdDaD2Al2VH
         d6PE8esMxr/5y1KcxOGbEP8rhal7XT3rW37U+gwACnnhCkZiSEAYKC5XLLRh27HL+doG
         yzN2EygZEgyffDsT9ojdlhxr2Jk64EppAsTPLwcSaF0QDLMASCfvSS1TXz6H/ehVHh21
         QjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwu3myTpJGyKxxQxJSkpa+xw92TaeKDMkG4bkP0rzlc=;
        b=01ph9PyarcDQ0gLHITkhGYC8SEe0N8sL9Aa/XMj3Gcj7Z1QyicxqDO0CcOC+e8ZhY9
         MUlxLbXrQBZKCpD45xV7Etum2NK1mu1qS1FLQ9yuVFhkJrlSNMNyMdsB1FcWF7MbdZW0
         x+S668hxe0363oecqWr+wgAXtLWsvNanrJF4SdUNtSOKj5znToXWPlgGlyCUW2shnXTE
         4AG33mPXr8TjsUDv+Upg2lTwGKP95uYGYRZCT9hH6yhk4Ap7S9X0mXjZtP9V+4v15UO/
         W98t5E7R13PsFpkFeMvCohBilYf91+TUF3CNpEsbq/faOayVpAHjnW2ynwyMDnzOTWY/
         e/uA==
X-Gm-Message-State: AOAM532kFDPZ0gJGkmSedlnGo762MBq2Bj1JPuIE6bnPIlS29YhI/1Dc
        1A2rTdIsPg4meUKszS2rlM8=
X-Google-Smtp-Source: ABdhPJxRH2/OLJwV3k87G9szWcyLW3u6rDOnUmzHbD5wix2zLsey858g7sLWONvpDuusuhM4X8OVfg==
X-Received: by 2002:a05:620a:d96:: with SMTP id q22mr18455664qkl.434.1643210369418;
        Wed, 26 Jan 2022 07:19:29 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id j11sm10567395qtj.90.2022.01.26.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:19:29 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] perf/ftrace: system_wide collection is not effective by default
Date:   Wed, 26 Jan 2022 23:19:21 +0800
Message-Id: <20220126151921.2519-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ftrace.target.system_wide must be set before invoking
evlist__create_maps(), otherwise it has no effect.

Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index dec24dc0e767..26bff29ad277 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1115,6 +1115,7 @@ enum perf_ftrace_subcommand {
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
+	int (*cmd_func)(struct perf_ftrace *) = NULL;
 	struct perf_ftrace ftrace = {
 		.tracer = DEFAULT_TRACER,
 		.target = { .uid = UINT_MAX, },
@@ -1221,6 +1222,28 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	switch (subcmd) {
+	case PERF_FTRACE_TRACE:
+		if (!argc && target__none(&ftrace.target))
+			ftrace.target.system_wide = true;
+		cmd_func = __cmd_ftrace;
+		break;
+	case PERF_FTRACE_LATENCY:
+		if (list_empty(&ftrace.filters)) {
+			pr_err("Should provide a function to measure\n");
+			parse_options_usage(ftrace_usage, options, "T", 1);
+			ret = -EINVAL;
+			goto out_delete_evlist;
+		}
+		cmd_func = __cmd_latency;
+		break;
+	case PERF_FTRACE_NONE:
+	default:
+		pr_err("Invalid subcommand\n");
+		ret = -EINVAL;
+		goto out_delete_evlist;
+	}
+
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
@@ -1248,27 +1271,7 @@ int cmd_ftrace(int argc, const char **argv)
 			goto out_delete_evlist;
 	}
 
-	switch (subcmd) {
-	case PERF_FTRACE_TRACE:
-		if (!argc && target__none(&ftrace.target))
-			ftrace.target.system_wide = true;
-		ret = __cmd_ftrace(&ftrace);
-		break;
-	case PERF_FTRACE_LATENCY:
-		if (list_empty(&ftrace.filters)) {
-			pr_err("Should provide a function to measure\n");
-			parse_options_usage(ftrace_usage, options, "T", 1);
-			ret = -EINVAL;
-			goto out_delete_evlist;
-		}
-		ret = __cmd_latency(&ftrace);
-		break;
-	case PERF_FTRACE_NONE:
-	default:
-		pr_err("Invalid subcommand\n");
-		ret = -EINVAL;
-		break;
-	}
+	ret = cmd_func(&ftrace);
 
 out_delete_evlist:
 	evlist__delete(ftrace.evlist);
-- 
2.32.0

