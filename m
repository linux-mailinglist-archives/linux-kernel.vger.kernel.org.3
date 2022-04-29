Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9B514CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377260AbiD2O3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377303AbiD2O3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:29:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC216A1454
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 7so2779825pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFKncaOnZsj36cgCwXssHtw7cbUchdfW5A7RWCFJ7yM=;
        b=384bTYX2aM/rqOGE6WsCJQTNL79rpvqSB6FFLpieETQcCxe4bkBKp3PHUHUxNhGhBo
         OrC6RI3a38E7/HAdvIsG2Nx7qmS/7xcqwk7vWCA5UVqzgxMigOT6e3Q7uvtShMtOKPhZ
         Dfl9S51N5BM2lNMJezk08BE3w7BAmiHm4hQovg3Nfff5bgR/a1IcZKzIEZocPr6M4cWT
         tTwGHrEkexmAVVtXROujq+AAOYxOHFDuFGQowUZNSrbib6zdEHTwi99oa7f5rhvg0SjQ
         vRqAubqjuzBzIPstt3HbFWYAeZANPNmKIQt315JO5dEt5JBW/hE0iyb4eV+zoVgoO9gF
         V5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFKncaOnZsj36cgCwXssHtw7cbUchdfW5A7RWCFJ7yM=;
        b=SKM+C3d/SqYpI+YltrbiIhan/992Ac18CRvXT+vMCTERljvJDCaU8RBtKNmSY7FE/r
         RCpkQ1wpG2dSgGk8EXh3rrpjYEgYKSlKFRwRSGOTe4twJYEdBJu/BTrMmyJpm/IBU0xU
         d/3HtUm2jUnNKmu76DL1XHrVvSqOvtNptTNQS45IxCMUhQj3pmoj+HwJewXK8yoVWS8J
         /6WYxZjN78P31XU6AapGie7xZtLJJLXUXbw87mnK0LH1CFiMHLvyQMFO8g+pSRw1aHze
         IUkYGH6vlIvxLvWgmRyPEGewAGhaYMjy8VWt2Qj4po4iTiKN8R1FaOdDXG93VvLzSy88
         x8aQ==
X-Gm-Message-State: AOAM530aJ2Irrk5Q66/YWJ+cXACKGAJtecK6OrHRl9ZojmKSWQsoqHsR
        hYZxLEXaMW+iYa5yXo7ei/sJAQ==
X-Google-Smtp-Source: ABdhPJxtVXUSLrycX5o3L/8LudOkLIuOG0tXjRQVn3FboK4JXL4Qvwb1lBd4ZuJ6uq6RVmuwiX/grw==
X-Received: by 2002:a05:6a00:2391:b0:50a:3ea9:e84d with SMTP id f17-20020a056a00239100b0050a3ea9e84dmr40345445pfc.21.1651242375308;
        Fri, 29 Apr 2022 07:26:15 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm3494734pfx.72.2022.04.29.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:26:14 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Date:   Fri, 29 Apr 2022 22:22:05 +0800
Message-Id: <20220429142206.294714-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429142206.294714-1-pizhenwei@bytedance.com>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the memory failure procedure, hwpoison_filter has higher priority,
if memory_filter() filters the error event, there is no need to do
the further work.

Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ece05858568f..a6a27c8b800f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1800,6 +1800,11 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	if (hwpoison_filter(p)) {
+		res = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 try_again:
 	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
 	if (hugetlb)
@@ -1937,15 +1942,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	page_flags = p->flags;
 
-	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(p))
-			num_poisoned_pages_dec();
-		unlock_page(p);
-		put_page(p);
-		res = -EOPNOTSUPP;
-		goto unlock_mutex;
-	}
-
 	/*
 	 * __munlock_pagevec may clear a writeback page's LRU flag without
 	 * page_lock. We need wait writeback completion for this page or it
-- 
2.20.1

