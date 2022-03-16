Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18684DAB92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiCPHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiCPHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:12:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227FB5DA6D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:10:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a3-20020a5b0ac3000000b006288f395b25so1329353ybr.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a+qisDvWjVObOyGt+FASRiXuVdhtv3LpxhYBq5xs2As=;
        b=QkjbnL9ondZiR68ZhRsbkiTB16VZ6RTH3D9ULnuAZHudsRB8UtWAYdIrDcj8ix3GwG
         3Ba6gKWWu9o0Zv6FjtgELRiusoTwnEHPJu/9DCZc5RiA9XXFGcj8cfemzaWkSdS2wGGE
         1/sB32qQSVadBMt1YW5FSogGW8MhOhnhjxD528RDM1GzhEL9a93uv7fBVxnTGt2B4FSR
         Ky1iWRNcsq+LcrC48nL7k3dImo0Uj8BFJzQSrQcniEs6wlZ2cENAH6dZXsLYIgB4Qun/
         jRLQ2bGKEXkEqUsNE/Jb6s439JYz8hRrXwnKaPsemJJXeuMxgLyuk3DMvh21qc+nY7XA
         e/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a+qisDvWjVObOyGt+FASRiXuVdhtv3LpxhYBq5xs2As=;
        b=B3wo8LpzeQc62DGl0UJ22LLX2tkJFKKO8rbhRweDXsEC1UIwQ5wm1luX/na164T2uz
         IT1cleBpUetkMbrnjTZLCY5aKNy4aUtvhqRx+ejMzdUxb9V9RQn0m57mBQ14qYWjnZkW
         DqV/p/jfh4gqx95Hl8KLBuu3khnUS7yn1Cha2fycOrcfdBbn6cIoa3ADXLn+opRCu8sS
         ZEe7mzfbUmcqvl+fZg1NwzhA4lfco9lw8r3bExZAJue943Ohpf5OGb92wjT8qjKyyQ8l
         7G8Hyjbagbm0eWByiFaaAm2ld4lf037nFj4x4NbeqhbJZ0flHMZWGSauZYplITrYO71q
         +OrA==
X-Gm-Message-State: AOAM532n/fnhQIHWLT8j48AfKqLiz6rZnWOY9iATZNNyBPLGloYJ2wFE
        7tdbLd3j0ej8XGVGXg5GRCa6gGh1Evrj
X-Google-Smtp-Source: ABdhPJzoXUwu/pi5bt8zVP3+SSR44xucIUvgs0SqbyAlgve09w3M3cY3SwYBmFocUwvvDwRJTaNIgAaMhftF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b17b:a969:45e3:7c15])
 (user=irogers job=sendgmr) by 2002:a0d:f3c3:0:b0:2db:ed4b:8e2a with SMTP id
 c186-20020a0df3c3000000b002dbed4b8e2amr28469210ywf.397.1647414653304; Wed, 16
 Mar 2022 00:10:53 -0700 (PDT)
Date:   Wed, 16 Mar 2022 00:10:49 -0700
Message-Id: <20220316071049.2368250-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] perf evlist: Avoid iteration for empty evlist.
From:   Ian Rogers <irogers@google.com>
To:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ian Rogers <irogers@google.com>
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

As seen with 'perf stat --null ..' and reported in:
https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/

Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8134d45e2164..a2dba9e00765 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -354,7 +354,10 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 		.affinity = affinity,
 	};
 
-	if (itr.affinity) {
+	if (evlist__empty(evlist)) {
+		/* Ensure the empty list doesn't iterate. */
+		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
+	} else if (itr.affinity) {
 		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
 		affinity__set(itr.affinity, itr.cpu.cpu);
 		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
-- 
2.35.1.723.g4982287a31-goog

