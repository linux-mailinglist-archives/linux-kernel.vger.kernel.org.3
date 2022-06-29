Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160B55F436
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiF2DkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiF2DkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:40:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BAA183B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:40:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31bf3674d86so37798117b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8RjJYdBEhWa5aatIqYt/+XHoNzjc8NbJULBjsluYrVE=;
        b=jLGZbFhMtG722wzXR5XwfWchvwR72cPKTIpobAg8wvD70E5RqeB3lvA6SatbU7elpm
         vt+MQ/ZhkpIcW7UVc/hstqVf8mFkPB/fg+GY0qPCwcvb7ofuJSxt9qJlQ2R7j3xV3bPY
         16gVFGNQg1q6fxUo1T41huOihcyeh+17WtTNVCMFjC4YZHCDHisyRfR/Oil2zK73k1HJ
         QIA85R2Ox9X0Jp3eHrZUkY3cNSzh/1Ea64UFWETJowKxFVGfvQkMkDGk1CNtNckoauVn
         FGeyaghBfNu9x65AzTFHcbhTXVSyMeY4ywtEXWXp9YLjG0L83aSjlGaUwa6P8kqjesKY
         SYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8RjJYdBEhWa5aatIqYt/+XHoNzjc8NbJULBjsluYrVE=;
        b=J/Dia0bJtU5lMU0Q89N1/1F3wQAQFMoV374CJ485EaMlnSsBdMdIJChJWmMRmqefQn
         FsaQPdywc508Gz4/wFSxdByFsb0JH1+4VxRWTcPazqa5xJy8FtOZA4NPHVUbaygeUa3A
         3+XfVe+0LSR40wr1+61sCdHJk4q9Y4vSDmo84sY+u4KS4I2k+T3qxmzUAf3SEKqZgwch
         RE1C0JUprLSveDDjuBhsaLsDFNcAHFbmbMpCRg0WDNz5mIkqNAOge/p+c8YiWxN63WC4
         qgck5HvDCpQxG2SoEpz24MCpZyuBHcdlV4xGNZnD20qVk8XZ7tmUC9t0ycgIMxMcM0YJ
         GcTQ==
X-Gm-Message-State: AJIora9fWpfYQ2UDR1BvnrNyDbUgNgej0PfKw4s4ah478rEQWt4Il8lF
        WjqTh1Vc0EUHcT9OcbGz8EpyaPp5kHqX
X-Google-Smtp-Source: AGRyM1vF1/Ms3NeGo8pVqEI3ypqHRU7b3dURRNAvivVmfK2Vf/5cSVDGylX6xTncJcRD1uf3YUIFQkYp9Rno
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a05:690c:110:b0:2ec:2d79:eee1 with SMTP id
 bd16-20020a05690c011000b002ec2d79eee1mr1732489ywb.21.1656474018652; Tue, 28
 Jun 2022 20:40:18 -0700 (PDT)
Date:   Tue, 28 Jun 2022 20:40:07 -0700
Message-Id: <20220629034007.332804-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf test: Skip for paranoid 3
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

Add skip tests for paranoid level being 3.
Rather than skipping lines starting "Failed", skip lines containing
"failed" - making the behavior consistent with the previous python
version.

Fixes: ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test on s390")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 38c26f3ef4c1..b165c81fccb4 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -26,9 +26,8 @@ function commachecker()
 
 	while read line
 	do
-		# Check for lines beginning with Failed
-		x=${line:0:6}
-		[ "$x" = "Failed" ] && continue
+		# Skip lines containing failed.
+		(echo "$line" | grep -q "failed") && continue
 
 		# Count the number of commas
 		x=$(echo $line | tr -d -c ',')
@@ -51,6 +50,11 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, true 2>&1 | commachecker --no-args
 	echo "[Success]"
 }
@@ -83,6 +87,11 @@ check_system_wide_no_aggr()
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, -I 1000 true 2>&1 | commachecker --interval
 	echo "[Success]"
 }
@@ -91,6 +100,11 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
 	echo "[Success]"
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

