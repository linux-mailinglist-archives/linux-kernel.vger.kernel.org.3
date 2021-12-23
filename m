Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9F47E7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbhLWSj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbhLWSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:39:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90AC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:39:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso11370010ybs.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TVJiAygomhnsrOQSAYm31X4HGCs9K5bbFFwm5gR602Y=;
        b=AXRSAJcIT5hS0UUyfBMSukDFA5aTFCY85MwAep99fEq3FQW8DXd0kL/nq4yDIMHGYX
         SX+DOqnaoT93XZsHUnkPVtvusbQq5tkN1jIVI7MKP1ovRfvCcPZyecKdG/llHEXOwR4S
         RPlVvI9tnl2QgUSlPKVxS4KuzI9FiIyjsoF7tLvsKKRUeIdCRB5BMR448f1VTAwiBPL/
         l0/KPMBnUbz9tPppQJSef+y4U6S8ww/HSx/7bYSL78Qyklqz4cqmHzyQTa+Vnn4ERE71
         10+HFtf0Z+0TSJMLTdSPZA5W5nJa68I3X6OZOgBcFOPr77CrPndzYhx0WLonBp9T44nU
         auEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TVJiAygomhnsrOQSAYm31X4HGCs9K5bbFFwm5gR602Y=;
        b=sxdRmI3aN9M6Cyhu5keResmduDqdsc8Lojwm9gcRtsvkJeZP6oaTxLrotHcQDli8y7
         lvMw1NID9+cuEdJthSeRic/E3QLWYH6gOlWEsw1BF5wNSAS/fKdf5Ep5aW5pG0ebHOjV
         Baist+eWTyJn33n9Xjg9ymtQPMUim6pP4gMT07XkivAV95wUJz9sM01Tq/xpWsaR71D3
         rH8ClTWi0v6CCSg9cykZdZAz6gMC/XMHzx5UVYe/AOLwyz/76k71KGtfe1fD3P27s5+j
         jK2HhU4WfPUzyqP87HTwka2XEA7rlEj7Vk1EfpcpDDNFG6yslLzzlSv5ZiRxQaKSW1ys
         2CAA==
X-Gm-Message-State: AOAM532JQLHyhklb+TgJKszUOTiEvFuIIXeWRLlFIYV3oyps0hi7eeb/
        JSEbsu+MLDC98hS01RCpBT8kd9SiKQyY
X-Google-Smtp-Source: ABdhPJwikImMY1Hv+0p2ALafNYtwJaisYg7JEEhXUtfEIZvbO90Xnr4QfnNTFesZBy0TorTrIzxAV610tbva
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1c9d:afe4:ff2f:9382])
 (user=irogers job=sendgmr) by 2002:a25:68a:: with SMTP id 132mr4780415ybg.649.1640284793933;
 Thu, 23 Dec 2021 10:39:53 -0800 (PST)
Date:   Thu, 23 Dec 2021 10:39:47 -0800
Message-Id: <20211223183948.3423989-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 1/2] perf test: Enable system wide for metricgroups test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uncore events as group leaders fail in per-thread mode causing exit
errors. Enable system-wide for metricgroup testing. This fixes the HPC
metric group when tested on skylakex.

Fixes: 4a87dea9e60f ("perf test: Workload test of metric and metricgroups")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index de24d374ce24..cb35e488809a 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -6,7 +6,7 @@ set -e
 
 for m in $(perf list --raw-dump metricgroups); do
   echo "Testing $m"
-  perf stat -M "$m" true
+  perf stat -M "$m" -a true
 done
 
 exit 0
-- 
2.34.1.307.g9b7440fafd-goog

