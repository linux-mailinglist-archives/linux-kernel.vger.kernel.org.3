Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35E597B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiHRC1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:27:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B571BE9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:27:20 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M7THk64QCzmVym;
        Thu, 18 Aug 2022 10:25:06 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 10:27:18 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <yuancan@huawei.com>,
        <baolu.lu@linux.intel.com>, <haifeng.zhao@linux.intel.com>
Subject: [PATCH -next v2] iommu: return early when devices in a group require different domain type
Date:   Thu, 18 Aug 2022 02:24:33 +0000
Message-ID: <20220818022433.41770-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When alloc default domain for an iommu_group in
probe_alloc_default_domain, the expected domain type
of each device in the iommu_group is checked in a loop,
if two devices require different types, the loop can
be broken since the default domain will be set to
iommu_def_domain_type.
Return 1 when this happened to break the loop in
__iommu_group_for_each_dev.

Signed-off-by: Yuan Can <yuancan@huawei.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 74bc9111c7be..0d4d78946d31 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1653,6 +1653,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 				 dev_name(gtype->dev),
 				 iommu_domain_type_str(gtype->type));
 			gtype->type = 0;
+			return 1; /* end the outer loop */
 		}
 
 		if (!gtype->dev) {
-- 
2.17.1

