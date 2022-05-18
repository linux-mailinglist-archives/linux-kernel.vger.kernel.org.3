Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE652B208
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiERF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiERF6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763FD5E74A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a11so1201905pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=t+4YJQoMe+V4DMRUuHgB85mCnjS1SZ2TDq3ccYade2iL072bVsB35GmPFzFqHugIZg
         WO3LblcCdyPHp09WYQa3TIohAwxFZXoeKUs99o7/E0+R4crB7c8PmlLdCFA976SIl+EO
         AqD2iOfsZCMoFqq/omq8RE98SdbfG0OcMoF6MftxMxqv7LbjwXtwQEod9fU4KvUEXcrQ
         CQaCZ8lgb5Z9uVV32kzYz1+drSlGaOV1Xd1YnxMNmTtaJCMlS4xQAmMU4FmJHb6yN5TS
         rCo0a0dEai6uYvFetF/woueT85I9VYEXXq2tqKQ5EFeAcEc/yMgX7zaZkzsgOZAEIBjd
         h/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=Eb65lWhyuUXVGxq2/CyShw/YFfedHQXfqrD7+meHGLMBCpLgyRo/qk2txe8kBnnCgB
         ilHjdsFqpy0JOC4r3grJnvaGKUO1jw2oNW7KEK3FdRQmyhIH2vRB+rbro0cP4oUo3CGm
         KNOpwNWgk6TJoiqP1Q1OPzFVq9pllu8ix7Zoxm7kCymcxIkbi9Q1vYXz4e83hZKrt6T0
         CqxlslAtr/nPgLMlkjdIDfjLZdjnVmoYdKuKfFh/Xf3urBkMsf6dGNlu1ROKkvVXe2aB
         CzXP9W2hvOk6qQlbBNpumvkp1ml0Gx8p4B90aj7OS2iqtHw7TWOX2dI0Essfcl64xDVM
         G0Lg==
X-Gm-Message-State: AOAM530wwoC7ScDxG0Ih+GdqS730EmR+rOg/N5/q+OiKRhov9ljX7sFS
        FPne5PzF7LPZpK2hdBy/euvNYQ==
X-Google-Smtp-Source: ABdhPJwhjbJpoPtfs770Lh9O1PaEMl2XMdZts7eu1iWjRUvTlZHh7alvd3Z3d7AN5axMeh2As/suxQ==
X-Received: by 2002:a05:6a00:1806:b0:510:9f7a:61ff with SMTP id y6-20020a056a00180600b005109f7a61ffmr26292631pfa.15.1652853486725;
        Tue, 17 May 2022 22:58:06 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 03/11] perf c2c: Update documentation for store metric 'N/A'
Date:   Wed, 18 May 2022 13:57:21 +0800
Message-Id: <20220518055729.1869566-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'N/A' metric is added for store operations, update documentation to
reflect changes in the report table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-c2c.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 3b6a2c84ea02..6f69173731aa 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -189,9 +189,10 @@ For each cacheline in the 1) list we display following data:
   Total stores
   - sum of all store accesses
 
-  Store Reference - L1Hit, L1Miss
+  Store Reference - L1Hit, L1Miss, N/A
     L1Hit - store accesses that hit L1
     L1Miss - store accesses that missed L1
+    N/A - store accesses with memory level is not available
 
   Core Load Hit - FB, L1, L2
   - count of load hits in FB (Fill Buffer), L1 and L2 cache
@@ -210,8 +211,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
-  Store Refs - L1 Hit, L1 Miss
-  - % of store accesses that hit/missed L1 for given offset within cacheline
+  Store Refs - L1 Hit, L1 Miss, N/A
+  - % of store accesses that hit L1, missed L1 and N/A (no available) memory
+    level for given offset within cacheline
 
   Data address - Offset
   - offset address
-- 
2.25.1

