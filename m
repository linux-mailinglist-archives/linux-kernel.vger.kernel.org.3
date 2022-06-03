Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AAD53D3F1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiFCX5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348179AbiFCX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:57:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03A6BE19;
        Fri,  3 Jun 2022 16:57:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso13219462pjf.5;
        Fri, 03 Jun 2022 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWHqqF01MR1hRCUv+JftvZxTCLeuaSF/IGUn/jKBQVI=;
        b=bvLB0tB91sc5OP4Cx9RpfzMIQCntlGl65UdtCUTji8gEczrLHlA8vphgUKVyCM62tH
         xf24reUm8P8o+uxBBJa62OkaaQTFbbdxjlNX0t05ISM8EVatAOBdCoAKBsT/aZW/FASq
         EEyZf0pWSeQU/s07XwCr/SiVhVq98m7lLif/ZsYnHfk1DQMZbSKFVxRlPQfLktqr+hz9
         R6loU8FarC8GyFEA0LS4ZYN3jp1Oou4xsx0HJDS2CSsj23Uk2NkBIq9iA0fqT8AF5C+t
         rvvQ4vV01sP72KaEAkxI2FY5hsSzUlzvpbRdJXPeep8/wlvNUlQIcw3d0eNbVg9cjgFm
         vKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CWHqqF01MR1hRCUv+JftvZxTCLeuaSF/IGUn/jKBQVI=;
        b=jD8B7jiHpPkjqotWTKl6cf5uKoaLU1rgYKQowyo8WOmkUeDmhJzqmXirXlzdwJHz/1
         /MtdtndvBU948Km5527xrXFqZwcbLq5JeAFgkNNjVgVjWPth4mlZYdH2AlHodPe/lm1i
         hszaWpFMuXn5cWbW6OHOcrdC7Ujp0jM/uvlATrvBmktuVramik7SyY8QyXZLyTofw/lq
         9j/D+8RBv/FPROO/9hEDc/qb5hOKFXqMG+noxZT/AhpQFzuTTy3UuJ4OKLAoxzD4E/lE
         mJ3KFOHnUsFQIToJ1FYgxFS8Zjm2zwq853v6Cr+iNKGjJBb5JS54FSm3+MkV9+7gTYNk
         uGeg==
X-Gm-Message-State: AOAM533uZ/f0s/sBcRkqRj1uZVQ8HH8kbrtFuQH9jd5463zqUpsZ/rRk
        lvufRZgd3lHffd009E66FEI=
X-Google-Smtp-Source: ABdhPJyD+Wh1DqzXpIx6Z2OjkFhYJF2YU1qvPrp1ZgW/EEAhzP7jOj/FmYTZ+tTBxuXZ9ilqWNYf6A==
X-Received: by 2002:a17:90a:2c43:b0:1e0:b3fe:1bf5 with SMTP id p3-20020a17090a2c4300b001e0b3fe1bf5mr48384101pjm.27.1654300622383;
        Fri, 03 Jun 2022 16:57:02 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:e599:3567:7c60:5f5a])
        by smtp.gmail.com with ESMTPSA id a37-20020a631a65000000b003c14af50626sm5868289pgm.62.2022.06.03.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:57:02 -0700 (PDT)
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
Date:   Fri,  3 Jun 2022 16:56:55 -0700
Message-Id: <20220603235656.715800-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603235656.715800-1-namhyung@kernel.org>
References: <20220603235656.715800-1-namhyung@kernel.org>
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

