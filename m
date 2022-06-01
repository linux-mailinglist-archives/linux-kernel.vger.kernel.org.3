Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93947539DA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350094AbiFAG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350064AbiFAG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421632B182;
        Tue, 31 May 2022 23:58:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so1174535pjf.5;
        Tue, 31 May 2022 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjKuGihzL/MP0z9+OCRyWKWmjzrMu46K8cjCG0rnT4o=;
        b=qO0Nup+l63oUcIC4Fx3l5w+xOQo/ReDtZIkCcVF+cml3GF/+s6zBmZ49+REKewd9PQ
         Cgp2Xumia7koGuVg+ww9V2x0fZAP8zyj55u3PrmPaezDvEiijFYcxhub6dBg+HPpkDkW
         c6Jbipz+vOrBVxAM5L1zR23AYoXmE1uDMDFwPr9+XpxETZRQ54JCzPzOjEuH9Jlu8Cv/
         To9bR+KTVtY0KyZ84Q1SYGlbfO+AiRBRoYEr8IS70hkKec9GgvwyZyoqGEonFvyPF8+1
         Tcg5KEnqsNL7rv2WfLSekgHVJ0q9MNkqbTT8Oz726UsSh0NGj75duQmsK8DHb7tyvF5c
         utHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NjKuGihzL/MP0z9+OCRyWKWmjzrMu46K8cjCG0rnT4o=;
        b=bCtTZkrFDdT2GzVwiRjdBLYE/onLUowR6up60bINcDmf6sA4bIGJI101kgDdH+1w2M
         uO5MPldN6F8gaQIfjBc6BddvfJcyNSD2VOV17gJSrHxrAf7txDswSfyhFa1Fl9WEbFc6
         VUD/Z864KXGwGZW0BKjeJRjk33dU7gkUm/I0Cf/foP+KadGavv7k5uqbOCC8SKSYpphr
         xXZ1gDnesnx7gDjrROBePzAGj0FbZm6mHczAEE9e4817yglXNG5GPqLWHZWX7VvW9/XW
         Vawrxj+2hcv22uMkIEB9OaKzXlIv7BIsRpfHWI82/yAvLs6ahGKWyjNKoI6uDyoa058g
         kNVg==
X-Gm-Message-State: AOAM531NJc5zSUqnUjHq2PbEQoq2KoZ7mcn9bCykxzS3OK3olRKnrKCZ
        NlUXsm3rjDOyx8ecYGPxQfI=
X-Google-Smtp-Source: ABdhPJxmwnu1AQmw42c3A7SvAwXsGJqnihla9cDw0ZjcapNtFWFhBz096TPq3vcqUlctmfRt9vXCgA==
X-Received: by 2002:a17:902:e849:b0:163:df09:9082 with SMTP id t9-20020a170902e84900b00163df099082mr13509559plg.163.1654066733779;
        Tue, 31 May 2022 23:58:53 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:53 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 4/5] perf record: Allow to specify max stack depth of fp callchain
Date:   Tue, 31 May 2022 23:58:45 -0700
Message-Id: <20220601065846.456965-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601065846.456965-1-namhyung@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
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

Currently it has no interface to specify the max stack depth for perf
record.  Extend the command line parameter to accept a number after
'fp' to specify the depth like '--call-graph fp,32'.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/util/callchain.c              | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b4e9ef7edfef..d2759e2ccf9e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -275,6 +275,11 @@ OPTIONS
 	User can change the size by passing the size after comma like
 	"--call-graph dwarf,4096".
 
+	When "fp" recording is used, perf tries to save stack enties
+	up to the number specified in sysctl.kernel.perf_event_max_stack
+	by default.  User can change the number by passing it after comma
+	like "--call-graph fp,32".
+
 -q::
 --quiet::
 	Don't print any message, useful for scripting.
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5c27a4b2e7a7..7e663673f79f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -31,6 +31,7 @@
 #include "callchain.h"
 #include "branch.h"
 #include "symbol.h"
+#include "util.h"
 #include "../perf.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
@@ -266,12 +267,17 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 	do {
 		/* Framepointer style */
 		if (!strncmp(name, "fp", sizeof("fp"))) {
-			if (!strtok_r(NULL, ",", &saveptr)) {
-				param->record_mode = CALLCHAIN_FP;
-				ret = 0;
-			} else
-				pr_err("callchain: No more arguments "
-				       "needed for --call-graph fp\n");
+			ret = 0;
+			param->record_mode = CALLCHAIN_FP;
+
+			tok = strtok_r(NULL, ",", &saveptr);
+			if (tok) {
+				unsigned long size;
+
+				size = strtoul(tok, &name, 0);
+				if (size < (unsigned) sysctl__max_stack())
+					param->max_stack = size;
+			}
 			break;
 
 		/* Dwarf style */
-- 
2.36.1.255.ge46751e96f-goog

