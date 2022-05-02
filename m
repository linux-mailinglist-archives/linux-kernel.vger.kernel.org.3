Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FED517AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiEBXZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiEBXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:24:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1691C10C;
        Mon,  2 May 2022 16:20:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p12so13485706pfn.0;
        Mon, 02 May 2022 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDpDR9wAUTORHbMw+Bx24K6jMVk7XvcBry4ZGUpvw4A=;
        b=TWHFN0kgWl3KN6BOSZtk3AJnAJPyFyVXrG+zjy7Hp3i2mwEVWukpaeZTfztSuCveXQ
         5D4lzoh8vP3qFWYfySI7VneE4TIiE/F6ws5kjEsHd9Fc1WwiJg6rApmE0V5ZjNCxztWc
         0ViBwKr1R/zWhJyOqL5tUCi77tdMSFkYrl0aKdRYrOU3uTW7VyF8LDgOV8FwCmiScxsN
         t1S6pJ/ofgG1lzozGX71Bgo6d31bSn9syx2W1pAOD9Hx+xsplfaMa5//z6vcvQAIPgDB
         FSpLhx3J5/D7sfG3UGyKCWOSf5/7ly5L09t6/knm32IF1bGu/Z1ZBQIafCHESlV5KyXe
         lCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QDpDR9wAUTORHbMw+Bx24K6jMVk7XvcBry4ZGUpvw4A=;
        b=N9Ef05e+Sx63f5/udZcCV7EbD7/ZFIRLGBlhSGHpbQYi90Yh46axCjnbfC6y/u2QV+
         rrgiKgtYvOrSwwcQc5BKeafVwRU1Zj9FlZweKbpAq5ZPEdo0n0MbYAfLXARpieRotVaj
         mfnIsi8l03E26P4jTOpbDSrLz4eCxi7k6y+46lAKRHB89Yq7pNvmCEy0ScnK06hLjk+W
         ruJsSY3Q6GqJzXOefYLkpMT7P17RS+BdG0ZTcas7Z8vYw6jCLBXNMtDhgnwScZGBAoqP
         ecnDCtUZNdWFqzk/Zk+hbRxYY7LkemqUN9UUyz+fI4au0cDyeGpFTyN8tbSrA/Mku/tc
         vC9Q==
X-Gm-Message-State: AOAM5333jZ4yq/JIB21EpAAnLjlKaajvPpYVUUXnlT8pgw4+dbYOijuz
        IsbJYXArk8hKeZzt+sV3ofo=
X-Google-Smtp-Source: ABdhPJw8rU3MsmiYAdp4cC8oRvGFVWP3lDoAc5iK0zmhY30ODH6xO4CeJaWX2nhzcw/0gtjEC4awJA==
X-Received: by 2002:aa7:938c:0:b0:50d:418a:cdfb with SMTP id t12-20020aa7938c000000b0050d418acdfbmr13646250pfe.72.1651533617615;
        Mon, 02 May 2022 16:20:17 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:4f92:5746:ebb:6bda])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b0015e8d4eb1eesm5176029plj.56.2022.05.02.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:20:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf annotate: Add --percent-limit option
Date:   Mon,  2 May 2022 16:20:15 -0700
Message-Id: <20220502232015.697243-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
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

Like in perf report and perf top, Add this option to limit the number
of functions it displays based on the overhead value in percent.

This affects only stdio and stdio2 output modes.  Without this, it
shows very long disassembly lines for every function in the data
file.  If users don't want this behavior, they can set a value in
percent to suppress that.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  5 +++++
 tools/perf/builtin-annotate.c              | 24 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 33c2521cba4a..18fcc52809fb 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -147,6 +147,11 @@ include::itrace.txt[]
 	The period/hits keywords set the base the percentage is computed
 	on - the samples period or the number of samples (hits).
 
+--percent-limit::
+	Do not show functions which have an overhead under that percent on
+	stdio or stdio2 (Default: 0).  Note that this is about selection of
+	functions to display, not about lines within the function.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e65dc380be15..2ffe071dbcff 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -54,6 +54,7 @@ struct perf_annotate {
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
+	float	   min_percent;
 	const char *sym_hist_filter;
 	const char *cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -324,6 +325,17 @@ static void hists__find_annotations(struct hists *hists,
 		    (strcmp(he->ms.sym->name, ann->sym_hist_filter) != 0))
 			goto find_next;
 
+		if (ann->min_percent) {
+			float percent = 0;
+			u64 total = hists__total_period(hists);
+
+			if (total)
+				percent = 100.0 * he->stat.period / total;
+
+			if (percent < ann->min_percent)
+				goto find_next;
+		}
+
 		notes = symbol__annotation(he->ms.sym);
 		if (notes->src == NULL) {
 find_next:
@@ -457,6 +469,16 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	return ret;
 }
 
+static int parse_percent_limit(const struct option *opt, const char *str,
+			       int unset __maybe_unused)
+{
+	struct perf_annotate *ann = opt->value;
+	double pcnt = strtof(str, NULL);
+
+	ann->min_percent = pcnt;
+	return 0;
+}
+
 static const char * const annotate_usage[] = {
 	"perf annotate [<options>]",
 	NULL
@@ -557,6 +579,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_CALLBACK(0, "percent-limit", &annotate, "percent",
+		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
-- 
2.36.0.464.gb9c8b46e94-goog

