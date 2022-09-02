Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF55AA52A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiIBBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIBBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:36:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93C901B0;
        Thu,  1 Sep 2022 18:36:53 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJgQr6hRvzkWpQ;
        Fri,  2 Sep 2022 09:33:08 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 09:36:30 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 09:36:29 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] perf: Add build_id_cahce__read_build_id helper
Date:   Fri, 2 Sep 2022 10:11:22 +0800
Message-ID: <20220902021122.18142-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Wrap repeated code in helper function build_id_cahce__read_build_id, which
gets build id if success, or return -1 for failed to read build id.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-buildid-cache.c | 41 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..a55d1c6496ea 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -172,20 +172,31 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 	return 0;
 }
 
-static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
+static int build_id_cahce__read_build_id(const char *filename, struct nsinfo *nsi,
+					  struct build_id *bid)
 {
-	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
-	int err;
 	struct nscookie nsc;
+	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
+	err = filename__read_build_id(filename, bid);
 	nsinfo__mountns_exit(&nsc);
 	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
 		return -1;
 	}
+	return err;
+}
+
+static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+	struct build_id bid;
+	int err;
+
+	err = build_id_cahce__read_build_id(filename, nsi, &bid);
+	if (err < 0)
+		return -1;
 
 	build_id__sprintf(&bid, sbuild_id);
 	err = build_id_cache__add_s(sbuild_id, filename, nsi,
@@ -199,17 +210,11 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 	struct build_id bid;
-	struct nscookie nsc;
-
 	int err;
 
-	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
-	nsinfo__mountns_exit(&nsc);
-	if (err < 0) {
-		pr_debug("Couldn't read a build-id in %s\n", filename);
+	err = build_id_cahce__read_build_id(filename, nsi, &bid);
+	if (err < 0)
 		return -1;
-	}
 
 	build_id__sprintf(&bid, sbuild_id);
 	err = build_id_cache__remove_s(sbuild_id);
@@ -302,17 +307,11 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 	struct build_id bid;
-	struct nscookie nsc;
-
 	int err;
 
-	nsinfo__mountns_enter(nsi, &nsc);
-	err = filename__read_build_id(filename, &bid);
-	nsinfo__mountns_exit(&nsc);
-	if (err < 0) {
-		pr_debug("Couldn't read a build-id in %s\n", filename);
+	err = build_id_cahce__read_build_id(filename, nsi, &bid);
+	if (err < 0)
 		return -1;
-	}
 	err = 0;
 
 	build_id__sprintf(&bid, sbuild_id);
-- 
2.17.1

