Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076FD4B830F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiBPIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiBPIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:30:59 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9AA22BF7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjyS_1645000244;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjyS_1645000244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:45 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 1/5] mm/damon: Add NUMA local and remote variables in 'damon_region'
Date:   Wed, 16 Feb 2022 16:30:37 +0800
Message-Id: <2fb03665b39d7e3b222955ff690d73fe8e201c24.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
References: <cover.1645024354.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of adding these two variables 'local' & 'remote'
is to obtain the struct 'damon_region' numa access status.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/linux/damon.h | 4 ++++
 mm/damon/core.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5e1e3a128b77..77d0937dcab5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -41,6 +41,8 @@ struct damon_addr_range {
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
  * @age:		Age of this region.
+ * @local:		Local numa node accesses.
+ * @remote:		Remote numa node accesses.
  *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
@@ -56,6 +58,8 @@ struct damon_region {
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	unsigned long local;
+	unsigned long remote;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1dd153c31c9e..933ef51afa71 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -45,6 +45,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->local = 0;
+	region->remote = 0;
 
 	return region;
 }
@@ -740,6 +742,8 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
+	l->remote = (l->remote * sz_l + r->remote * sz_r) / (sz_l + sz_r);
+	l->local = (l->local * sz_l + r->local * sz_r) / (sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	damon_destroy_region(r, t);
@@ -812,6 +816,8 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
+	new->local = r->local;
+	new->remote = r->remote;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.27.0

