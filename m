Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B150B42B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446073AbiDVJhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352701AbiDVJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:37:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E463527EE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:34:16 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kl8P74l4kzhY7q;
        Fri, 22 Apr 2022 17:34:03 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:34:14 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 17:34:14 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: rework calculation of bdi_min_ratio in bdi_set_min_ratio
Date:   Fri, 22 Apr 2022 17:51:59 +0800
Message-ID: <20220422095159.2858305-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function bdi_set_min_ratio, min_ratio is unsigned int, it will
result underflow when setting min_ratio below bdi->min_ratio, it
is confusing. Rework it, no functional change.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/page-writeback.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 438762173a59..d4291de77097 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -655,18 +655,25 @@ static unsigned int bdi_min_ratio;
 
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ratio)
 {
+	unsigned int delta;
 	int ret = 0;
 
 	spin_lock_bh(&bdi_lock);
 	if (min_ratio > bdi->max_ratio) {
 		ret = -EINVAL;
 	} else {
-		min_ratio -= bdi->min_ratio;
-		if (bdi_min_ratio + min_ratio < 100) {
-			bdi_min_ratio += min_ratio;
-			bdi->min_ratio += min_ratio;
+		if (min_ratio < bdi->min_ratio) {
+			delta = bdi->min_ratio - min_ratio;
+			bdi_min_ratio -= delta;
+			bdi->min_ratio = min_ratio;
 		} else {
-			ret = -EINVAL;
+			delta = min_ratio - bdi->min_ratio;
+			if (bdi_min_ratio + delta < 100) {
+				bdi_min_ratio += delta;
+				bdi->min_ratio = min_ratio;
+			} else {
+				ret = -EINVAL;
+			}
 		}
 	}
 	spin_unlock_bh(&bdi_lock);
-- 
2.25.1

