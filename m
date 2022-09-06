Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A475ADD9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiIFCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiIFCyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:54:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396EE15736;
        Mon,  5 Sep 2022 19:54:46 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MM8z40fY1zmV9w;
        Tue,  6 Sep 2022 10:51:12 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:54:24 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 10:54:23 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 3/3] perf c2c: Prevent potential memory leak in c2c_he_zalloc
Date:   Tue, 6 Sep 2022 11:29:06 +0800
Message-ID: <20220906032906.21395-4-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906032906.21395-1-shangxiaojing@huawei.com>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated resources when zalloc is failed for members in c2c_he, to
prevent potential memory leak in c2c_he_zalloc.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
changes in v2:
- clear omissible free labels due to zero allocated c2c_he.
---
 tools/perf/builtin-c2c.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 12f272811487..f35a47b2dbe4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -146,15 +146,15 @@ static void *c2c_he_zalloc(size_t size)
 
 	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
 	if (!c2c_he->cpuset)
-		return NULL;
+		goto out_free;
 
 	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
 	if (!c2c_he->nodeset)
-		return NULL;
+		goto out_free;
 
 	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
 	if (!c2c_he->node_stats)
-		return NULL;
+		goto out_free;
 
 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
@@ -163,6 +163,12 @@ static void *c2c_he_zalloc(size_t size)
 	init_stats(&c2c_he->cstats.load);
 
 	return &c2c_he->he;
+
+out_free:
+	free(c2c_he->nodeset);
+	free(c2c_he->cpuset);
+	free(c2c_he);
+	return NULL;
 }
 
 static void c2c_he_free(void *he)
-- 
2.17.1

