Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ADC544361
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbiFIF5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIF5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:57:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F42DD5E;
        Wed,  8 Jun 2022 22:57:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so20954559pgr.0;
        Wed, 08 Jun 2022 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWHqqF01MR1hRCUv+JftvZxTCLeuaSF/IGUn/jKBQVI=;
        b=JawKMh1AJPHwaPnySc/7xgifRxG+g42ouAQQnHKQJLUdMPPOjY6Ccpvw5vsgS6pR0a
         Jf3OVc3Ip3TvljYNOt6PFuOEBX5bnWpoBljrfTUSDBcBH7LW/dZ84psWzF37vb7JJDRP
         /+W3AOJ0pBkeKzi90SET4+Bi5obxbaXr8lTdCvYZmZmEwSJfrbytgBpuSYvs7S+RmrLX
         Qdc/URP5EdArHaPh5P7MsoA7ro1CiO/7fGkN0YpHesKmKLju8kQcqnn453Y6ejHGiDz8
         wcD2QOxsfStmMoZ5lhn/ylFNHe/So2Jn/kcon5IXMg36RtZeJ10N+Z/vQ75OtVkUjZQY
         Q0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CWHqqF01MR1hRCUv+JftvZxTCLeuaSF/IGUn/jKBQVI=;
        b=fz0N22ZD+xbvA7wn+TTZnpAF/MANQCaQc2cTvhOlXfwM8NzihMCpHlEF8VZuLDxyuZ
         OMfPH0bbDcrxDdSS2mAr6MWPW+AgeEXrajf+yzoXYtWSnmQjOPqByEwQjI8EFF8zCMhO
         mbaFq4xKBZQv7Faju5EizCWGpcxtCQdBKY9fmBQPGfkri/8GQc8B5KcUHfCrPipxnPlf
         jNVQ4ob1CyF9hH6hAjl/rxklg7MJkWZIilw/wdo7XuH0V8PRDUTi8u5RJAClSiI6rEtw
         7k1bdV94t17RxkIK95skrnc8/YyQMN5EYna52gzpAj0tS0V+xrFY67Uyo/PhsnK9FWZa
         WLzQ==
X-Gm-Message-State: AOAM530k0xsXJ77JiTp4J5gupJ032CXYY77oYx7gTk4SLGIKPzRnrq1o
        TpU5kLQUByaQ8evQyPWeSls=
X-Google-Smtp-Source: ABdhPJz2rS8RAd8uReNPfKoijBt8DHgC+S5Snksv2PfXynfJ75ijza012kXYSdVLft3IYry+vz6gIg==
X-Received: by 2002:a05:6a00:2390:b0:51c:21e1:782 with SMTP id f16-20020a056a00239000b0051c21e10782mr18035223pfc.21.1654754220882;
        Wed, 08 Jun 2022 22:57:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:57:00 -0700 (PDT)
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
Subject: [PATCH 6/7] perf record: Allow to specify max stack depth of fp callchain
Date:   Wed,  8 Jun 2022 22:56:51 -0700
Message-Id: <20220609055652.938821-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
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
index cf8ad50f3de1..772777c2a52e 100644
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

