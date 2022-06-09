Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C5544318
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiFIFYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbiFIFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67225E9D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:24:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 10-20020a250d0a000000b0065ca0e7be90so19362378ybn.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=m+GH7afRGBYGWqJBmM4w4QGt8MCZhwn+CP1UOE+F21RUMbBBtczrX4dpaH1Th5zjis
         5S6qp7GTToPhKiuLySTPJzaCFI1KR6/8dXZe13wiB6LmZ/xe0yf8PvdBPr+Ok+0x2GdZ
         F9KeQSU1oKIhH6z3bkKeT54UJNjFiHmG15KjOj1sU8IbSC7CS2pxTYRshhKAblVtZfuH
         jhC7NKiOrQp6DtxkRsa8jz/FlBvkRtC8dtfKzI4z4YUZ/Tz8davC212ATw4ccRhYXd2o
         aNBeSMqX1B6ac+B4AKSv+Ftl549whZaXk6ea5N+/HveYjTol1iYFewxASPZxNJt0iEuT
         oF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfkEdtucqgA+wBrOBxrBZd3UEfs8ZNdv2ifdbarRzlY=;
        b=bRAw+xrHubUrGqIiKQtGDDOwakc+WcWMgCeirimfRpe0bkH6rXpg4FHOZBXZdjcCFh
         HVKf37RL4CeqqEIy6RHu1ferySjShFjZ+W46/wfYBeSBztcO4P/7XHHiIeziji6vnoNX
         qsGKKq7/8E6qd/6WVh6L4S3qUq4Ruebnp6VocBocVzc+rbA3InCnUcxt4HlH/UO2Uxq4
         6vSOCP4cWfaNv9Rc3WjR4UUJr4MyTnFT51Zp7Y+kTQuwVO9cPxURXaYhWUcnm4iHYawd
         VnFAZkJ6hxcUuTeQ4srA9z7jyuj7PfSqU7G2UtocOzy2MDrVhZ6VlHjZKn9pDJLKqLdi
         1j1Q==
X-Gm-Message-State: AOAM531Oo1OnSjwdqM4BKvLiIjsWSrDGqqVyMAHG08crCx7QoUtUFyF/
        7dpKsY3lXHviTFzeBINPotNfXLBmy3xH
X-Google-Smtp-Source: ABdhPJzR1whIf7j55WQjVp8vOL2cQbpNCuyhPsZMw7XC5LhktLRlst3wiJkrl8JtpqpEzCumqhY37TGcvUF+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a81:1414:0:b0:30c:1c83:7702 with SMTP id
 20-20020a811414000000b0030c1c837702mr41227650ywu.474.1654752244006; Wed, 08
 Jun 2022 22:24:04 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:52 -0700
In-Reply-To: <20220609052355.1300162-1-irogers@google.com>
Message-Id: <20220609052355.1300162-2-irogers@google.com>
Mime-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 1/4] libperf evsel: Open shouldn't leak fd on failure
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

If the perf_event_open fails the fd is opened but the fd is only freed
by closing (not by delete). Typically when an open fails you don't call
close and so this results in a memory leak. To avoid this, add a close
when open fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c1d58673f6ef..952f3520d5c2 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			int fd, group_fd, *evsel_fd;
 
 			evsel_fd = FD(evsel, idx, thread);
-			if (evsel_fd == NULL)
-				return -EINVAL;
+			if (evsel_fd == NULL) {
+				err = -EINVAL;
+				goto out;
+			}
 
 			err = get_group_fd(evsel, idx, thread, &group_fd);
 			if (err < 0)
-				return err;
+				goto out;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
 						 cpu, group_fd, 0);
 
-			if (fd < 0)
-				return -errno;
+			if (fd < 0) {
+				err = -errno;
+				goto out;
+			}
 
 			*evsel_fd = fd;
 		}
 	}
+out:
+	if (err)
+		perf_evsel__close(evsel);
 
 	return err;
 }
-- 
2.36.1.255.ge46751e96f-goog

