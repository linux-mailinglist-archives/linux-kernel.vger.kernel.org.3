Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1775693DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiGFVGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiGFVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:06:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A4618341
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:06:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc7bdd666fso114016807b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e2ErBVv8qaenTIHwGm6BDHlzGLkSDkG7zT48JUlyYnI=;
        b=pQcEOUnjGosM3FwjtyyePdQ4rz547gcUzlhhrQSACVrGQi+DCeSRewah3af7J025bn
         ZFSF9xT9Kd2OHSeRtz2p4X9p14gtjkluqRyylFvS0Ze6B4KPf4Lv+40tmck2kh9L1Qd2
         dlFPCFeoffGzkW1bpmX4aFKTATWyGe8ajPAVOJDBhtTJJCOC12HO25xgVfhK4U3v0HXH
         LdnIoOmr3Z4zCt4EJ5HqiMpmCDavYlyMwc6BUiAn/lzecxj0s+wGHU5UFMPA2d67qyaR
         +aWS6ReKKRUUcR9RAUXT7QzYh72+C0hJdOapn66oIEU84Y+QYNpuQZ6Ik98u8ljrJr4t
         w0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e2ErBVv8qaenTIHwGm6BDHlzGLkSDkG7zT48JUlyYnI=;
        b=hoYyz7Gvshn5cYlXkOvXFLGD/LVBF0WVi/FSShjz93IW3RZbddGGwA2oUL/Nt9VpKo
         i859kDanZA2VvESCjsgPloD74h+J5GWW8iZuqDnTfRU5Zm5tgt5H0qbHD6fBTUwZXA+6
         kCkNUOBaxZB889QE400KfdW75TTQrt/0z+K0bRVTjVUhj8g6y10XCoVZiQWc3/egRK6S
         nji9HMwIKKD5GhqP75ib+rhwwfJQXmUyiyLn2Zf0AnYDkvh5C/cB0kaY3nyVD1yF/wlE
         xc7kKM4Mhfn1MP43pul7EXLZvVUBaLz2/zNdp0WUspHRa72qcvYuUzKAx4FmCtno0zFF
         GGKA==
X-Gm-Message-State: AJIora9KlXtDJSATPewiORb+OgeHByintw1LXWo4pr/jx5NYck0qi2ds
        u6HDZtG6EZG/ddSSKru1Tvotwx3nqyM=
X-Google-Smtp-Source: AGRyM1vgjtm4BaYhDlSs+0r8gz/TW/c6FhBbWoQPUXmQyhX6ufpPiRdiz8rmvNaWqnqTpwxnDkigT2o/aQA=
X-Received: from mpratt.nyc.corp.google.com ([2620:0:1003:1213:37b2:830a:e7cc:7548])
 (user=mpratt job=sendgmr) by 2002:a25:f905:0:b0:66e:4ebe:d61d with SMTP id
 q5-20020a25f905000000b0066e4ebed61dmr17976220ybe.647.1657141586876; Wed, 06
 Jul 2022 14:06:26 -0700 (PDT)
Date:   Wed,  6 Jul 2022 17:06:13 -0400
Message-Id: <20220706210613.1987767-1-mpratt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf: uapi: fix PERF_RECORD_SAMPLE format documentation
From:   Michael Pratt <mpratt@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Pratt <mpratt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented format of PERF_RECORD_SAMPLE does not match the actual
format emitted by perf_output_sample:

* The cgroup field is missing entirely.
* The data_page_size and code_page_size fields are output before the aux
  data, but are documented before.

Fixes: 6546b19f95ac ("perf/core: Add PERF_SAMPLE_CGROUP feature")
Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
Signed-off-by: Michael Pratt <mpratt@google.com>
---
 include/uapi/linux/perf_event.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72f..9a0a9a8678558 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -967,10 +967,11 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
-	 *	{ u64			size;
-	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			cgroup;} && PERF_SAMPLE_CGROUP
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
-- 
2.37.0.rc0.161.g10f37bed90-goog

