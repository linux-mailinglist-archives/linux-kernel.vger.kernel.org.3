Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625A55DB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbiF1G1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiF1G1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:27:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8672316E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:27:11 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXF3n4sDFz9stm;
        Tue, 28 Jun 2022 14:26:29 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 14:27:09 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 14:27:08 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <emma@anholt.net>, <mripard@kernel.org>, <eric@anholt.net>,
        <bbrezillon@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/vc4: fix dereference before NULL check
Date:   Tue, 28 Jun 2022 14:36:57 +0800
Message-ID: <20220628063657.3169049-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "perfmon" pointer is equal to the return value of idr_find
which may be NULL, access by vc4_perfmon_get before checking if
it was NULL. Fix this by dereferencing "perfmon" after "perfmon"
has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/gpu/drm/vc4/vc4_perfmon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index c7f5adb6bcf8..ca969b8c7dde 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -17,13 +17,17 @@
 
 void vc4_perfmon_get(struct vc4_perfmon *perfmon)
 {
-	struct vc4_dev *vc4 = perfmon->dev;
+	struct vc4_dev *vc4;
+
+	if (!perfmon)
+		return;
+
+	vc4 = perfmon->dev;
 
 	if (WARN_ON_ONCE(vc4->is_vc5))
 		return;
 
-	if (perfmon)
-		refcount_inc(&perfmon->refcnt);
+	refcount_inc(&perfmon->refcnt);
 }
 
 void vc4_perfmon_put(struct vc4_perfmon *perfmon)
-- 
2.25.1

