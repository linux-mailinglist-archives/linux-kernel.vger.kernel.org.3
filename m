Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9654CEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356502AbiFOQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355873AbiFOQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F234639D;
        Wed, 15 Jun 2022 09:32:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c196so11923971pfb.1;
        Wed, 15 Jun 2022 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdBujSJIuI5oTCt9ZNeAAGURO8zSMK1uyI+VIKFgR10=;
        b=dxhhk1OvgFuj0lplIBnl0vVS539Tg8JcDuiY/dnMJ9hBKz5Oj7yiFnskHv4qiQCzgZ
         QDB1rZtQ3XNUG773yoCgry9VVJDdqAUiDA0P9TFEejtR3xTBjfGjYCCzpckSBUDswUMp
         8TqVKUSbg6DhdyvhP+xcefR8zcyS5up0LtR7hSB7YDeDBSIJR5CEF0jCoZo4Q6MVp3my
         Fh3aUcdEhJs+2UPG5fRWlkXTS5ILg17TzwimsKU/IdSW19y03vyNsaBK1NWAo9i8h/KU
         rJfrgOOIdnEiB1gf5Q9I9MqGfdeTkjPChOSZbsgdSAWhzUZYdYALcv33n2xgrmZ7KnqC
         tRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kdBujSJIuI5oTCt9ZNeAAGURO8zSMK1uyI+VIKFgR10=;
        b=sKDy65DRBS8tkLsgMwwrwCBwerxEvwGSrXZ23zgZ8jjVB2R6sIkU9xM+1Se7Ye5W0M
         IqUzEVTgqzNDo0Y8uXkfq0CWZlBKfX/ctzw9bIcizKRELXEY8Jc8/wPyDZxUvvB19WjV
         bnGkT051I5SQVgqPvKBKUPcL4QHdRySqEAV78/iawJ85FgV1Fnyhiw9JH7uXzZwzMqrF
         zgaFFJDHnZ0a7F736bKXtYZisyRFvWJSvQfM29jls1zjbi34hMxXpaTFaowr0OxnzvL2
         Kg0CNy1i6Tr910+02AVNyc6jvwcnwlC88zjvrMI2gUgU60WbAZ18yet5njNEgEojJgkN
         UHvw==
X-Gm-Message-State: AJIora+a2d/RjX7QcyQDk7gFA+Snxfz25P8uktvZzruYDk2akaibqIcy
        frAQp8w0NEptYnz6/o9wI10=
X-Google-Smtp-Source: AGRyM1tgc8FswmVOQg38OQCqz090UxCEdxjFrf7i6UE0uhMiZlkUxz75ijG08Sufr729unT8xpip9A==
X-Received: by 2002:a65:48c6:0:b0:403:aef0:bebe with SMTP id o6-20020a6548c6000000b00403aef0bebemr538435pgs.486.1655310754245;
        Wed, 15 Jun 2022 09:32:34 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:33 -0700 (PDT)
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
Date:   Wed, 15 Jun 2022 09:32:21 -0700
Message-Id: <20220615163222.1275500-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
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
2.36.1.476.g0c4daa206d-goog

