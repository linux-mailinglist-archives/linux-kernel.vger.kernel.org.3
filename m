Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D571A51EC7E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiEHJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiEHJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:28:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D51E025
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:24:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq10so10736075pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=JHV7gnh3NYXiAdRA1WXm+zWhMZQYRMfuuvrBAALmzQyuAPV8GId/Hm7iFogCgfky21
         K99kFpaSwtoiI+yhw24x7mbWHUoX8FVN9/ZzlQKeqEyA7e3TrwSeZ8GVR612ZtSsrARn
         Ykdipe4E+U3hYvW+FbW0RkTrdrwv69GBQa7LLfVGCFoPHGq6ifTVsfrnCDGKbd/DDUrg
         fuBS3eC53OtHXTnyUIE0NpRFzB72NgISNo8hBf5oTAkp9yMjjil8fnYGkXV9ZddK+bDE
         D9L09XCVuVEVL2QFnClRTlRhwMtNqefnU52unoBcGvFgKR5zOfVdXkbVEOntbp6uoJuI
         f/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPhdUw6/xRTj5eRnk/v+0C6+XGKs0gs1fQItGV05POc=;
        b=gc0Ah/CWyOLa+uGzjWqyOK5ldK2HtwU3D59vv0u5dZgazDnvBD+tktz+ff8DxNoaw0
         mRgja0/CWDCALR86goNhxOnXWiHljhzBNv/hy8lhHd1KcVHIO05WqvwhCM+4LAAYQAFb
         R3yiCFhnLkNpwUpSQRpFpmA34fewPW/ToZs6cfUS2tBQxxWXr6R5hkc+n9IbYtorvfLJ
         AY3+nzfYgos7aVgVp+Gp5LCN4wLO7b+xPVIq3OJXr5VRIgfd/qhDq+srEcPJo38vwsPr
         DHBp2kmGLSVvquuwxdJHwUiaHzOt0jT4rQ1WMKI6A4UAtnW42+gP3Npqt1rRlViVXGRn
         n35A==
X-Gm-Message-State: AOAM531JDmUPAAkr5gAcNqukaCEyEDYFpzKL0ua9oR+EpLizOFChw7kx
        S1XWEme0OXBd0Ze2w5+pi5RghA==
X-Google-Smtp-Source: ABdhPJx8b1S7DP+l6TbHcjaDTxe+bP3mjVWrvxdRZjRpNA9ShTXWg/U5lWdyGp5WzpTFOapVuyHoYg==
X-Received: by 2002:a17:903:1111:b0:15f:7f0:bbf3 with SMTP id n17-20020a170903111100b0015f07f0bbf3mr2621799plh.12.1652001881479;
        Sun, 08 May 2022 02:24:41 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:24:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 03/11] perf c2c: Update documentation for store metric 'N/A'
Date:   Sun,  8 May 2022 17:23:38 +0800
Message-Id: <20220508092346.255826-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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

