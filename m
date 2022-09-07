Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE09F5B04BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIGNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIGNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:09:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C6E253
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:09:22 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MN2d01Ybmz686xt;
        Wed,  7 Sep 2022 21:08:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 7 Sep 2022 15:09:19 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 14:09:17 +0100
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <jsnitsel@redhat.com>,
        <haifeng.zhao@linux.intel.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 1/3] iova: Remove some magazine pointer NULL checks
Date:   Wed, 7 Sep 2022 21:02:32 +0800
Message-ID: <1662555754-142760-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
References: <1662555754-142760-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
pointers once the IOVA domain has been properly initialized. Previously it
was only possible to have NULL pointers from failure to allocate the
magazines in the IOVA domain initialization. The only other two functions
to modify these pointers - __iova_rcache_{get, insert}() - would already
ensure that these pointers were non-NULL if initially non-NULL.

As such, the mag NULL pointer checks in iova_magazine_full(),
iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/iova.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 47d1983dfa2a..580fdf669922 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	unsigned long flags;
 	int i;
 
-	if (!mag)
-		return;
-
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 
 	for (i = 0 ; i < mag->size; ++i) {
@@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 
 static bool iova_magazine_full(struct iova_magazine *mag)
 {
-	return (mag && mag->size == IOVA_MAG_SIZE);
+	return mag->size == IOVA_MAG_SIZE;
 }
 
 static bool iova_magazine_empty(struct iova_magazine *mag)
 {
-	return (!mag || mag->size == 0);
+	return mag->size == 0;
 }
 
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
-- 
2.25.1

