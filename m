Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5D54032C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbiFGP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbiFGPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:54:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5413D72
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654617293; x=1686153293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zq4qMj7BmV5+vvcmcNdpEc9+svzoU+Bzr9zO/b/QpeA=;
  b=bG0MygdrRkaVbjdnOMF65xf7lU/3UuP0CZQ45P/wbplfz/aA8o6Ljz+X
   baAxarfMTictLzOnul6/XKC6qtxPoAjJPYJyIFoKH6KjM9dZowvAiYQom
   o9kjqAlUpEedG8/sceU3tl+V24fRMdPEITHUtDkYQ8d9gIbbFLqqllo2/
   z4efOz13UJAuXRcPorIcNMmQm2hZkDWWhP+bIlXJZKDphoGeoYPnewbJa
   HUC+J+otQKl2rurFVtkOpCgOQ8FpEX5IDvWEax1oqNhhMu4rjtpWMTgc+
   tr4ULoQwsdVLPIiQxBS77DWkihX0fHCR7aIfLqH0tPMdu37hFtlzmVUFL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277581317"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277581317"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="579645368"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2022 08:37:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83A36109; Tue,  7 Jun 2022 18:37:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] nvdimm/namespace: drop unneeded temporary variable in size_store()
Date:   Tue,  7 Jun 2022 18:37:50 +0300
Message-Id: <20220607153750.33639-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor size_store() in order to remove temporary variable on stack
by joining conditionals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvdimm/namespace_devs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 3dae17c90e8c..0f863fda56e6 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -836,7 +836,6 @@ static ssize_t size_store(struct device *dev,
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	unsigned long long val;
-	uuid_t **uuid = NULL;
 	int rc;
 
 	rc = kstrtoull(buf, 0, &val);
@@ -850,16 +849,12 @@ static ssize_t size_store(struct device *dev,
 	if (rc >= 0)
 		rc = nd_namespace_label_update(nd_region, dev);
 
-	if (is_namespace_pmem(dev)) {
+	/* setting size zero == 'delete namespace' */
+	if (rc == 0 && val == 0 && is_namespace_pmem(dev)) {
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
-		uuid = &nspm->uuid;
-	}
-
-	if (rc == 0 && val == 0 && uuid) {
-		/* setting size zero == 'delete namespace' */
-		kfree(*uuid);
-		*uuid = NULL;
+		kfree(nspm->uuid);
+		nspm->uuid = NULL;
 	}
 
 	dev_dbg(dev, "%llx %s (%d)\n", val, rc < 0 ? "fail" : "success", rc);
-- 
2.35.1

