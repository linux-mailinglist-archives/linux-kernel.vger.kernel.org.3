Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F749E33A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbiA0NUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiA0NUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:20:20 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46371C061714;
        Thu, 27 Jan 2022 05:20:20 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r14so2416062qtt.5;
        Thu, 27 Jan 2022 05:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGHnyxqhToYcWzP+FxpnOsUxGeusoaZ89ztzpJzW4gk=;
        b=JNaXTi6oJAV+zPErJ+0NvjVsdgZ+6XDP6rCTO9rjEnCMsV/g4v89jPD/QVO/TvGoyu
         XF5WCTa91U61BX18AEwDx3/mUZ56p/KQ9LGq+CoSVQ7hYcBZrAT/TL65B6c8BEIKYFYF
         5lBI2rMjzyLyV41Q23YH2KUoW3Ty8Pj/iY0AKIucWz2OkU7aD6bv5aKNIM19XhmIBeOW
         dgghIByuBPaPgZ+In+r3SsBA+ZCt63lhr272S0Aq7/c+6MFWuEiuCLOevAcCnkgslLni
         W2qYA/poqS8x9JSx8uZXG1tSESNKGaPzxY8bARnWr6W2bfc0twtrBDIY9hpbHQEweZkv
         xKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGHnyxqhToYcWzP+FxpnOsUxGeusoaZ89ztzpJzW4gk=;
        b=X1e9HCRUj323g2a1eqdtdcUMdjHH9ruxiBwl2s+FDs3V4YEOnp0ymVWquZfKaUPX2L
         D82PLAH3N10vhA+PSZZJV3gZLr4jQwsXz2hhB66nF8sHcZzS1pFgShIBObPmuxNJaQi6
         8Qw6q2VXrqd6T06cjxPlwLazKX3PaJB/svOIyRWM81T5kbHsiA9zDBee48cgVBLvyVQG
         4lMEzmyzQ5RsyiYijm282ZzaBjjsNzd3utwwkyRWDTv8olfjRD4IhrXQgiZwiOhy//o4
         g2jREfhXyG05+NLUaPrZw9DZNCDwMqvPQef6p800mz2eECVIn+qxnoUPSSqcTf7F0Hyz
         gDvg==
X-Gm-Message-State: AOAM533ONF0+XCPxZivZLWA46npDxvxFhu/05uBuzLO7rNWZplMIkA9t
        OH1d2IHxhMNpbZFhHvmhVXMPd4K+68TXSK4K
X-Google-Smtp-Source: ABdhPJzQu5lxBFfzJlNuVQXt27nxAMR4IznudwK58tbYpXxGLORmpIoRwdukYQfC+7z601lyvgMYPQ==
X-Received: by 2002:a05:622a:342:: with SMTP id r2mr2563637qtw.473.1643289619411;
        Thu, 27 Jan 2022 05:20:19 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id r7sm1271599qtw.25.2022.01.27.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:20:18 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] perf/ftrace: system_wide collection is not effective by default
Date:   Thu, 27 Jan 2022 21:20:10 +0800
Message-Id: <20220127132010.4836-1-changbin.du@gmail.com>
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
v2: fix error handling.
---
 tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index dec24dc0e767..a8785dec5ca6 100644
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
+			goto out_delete_filters;
+		}
+		cmd_func = __cmd_latency;
+		break;
+	case PERF_FTRACE_NONE:
+	default:
+		pr_err("Invalid subcommand\n");
+		ret = -EINVAL;
+		goto out_delete_filters;
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

