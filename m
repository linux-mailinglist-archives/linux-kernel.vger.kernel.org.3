Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D8540272
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbiFGPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFGPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:31:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A136F5067
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654615910; x=1686151910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x+VtFWdXpux7/W9Qk2tMxPNhs7vkk3dWzPjYVSKAWwY=;
  b=lHAKYIm6ErL44ZM9gh8IWxkhHrKUpmyvQZ+VwHJBnAs9scHUSVuLBh6K
   MdYpANmIgyj1Kr7/kaJJd6sk9DR5JGec1bEtd5A1cLx0altU6SlSa0GZO
   ajgXHdPy7DYkt5YcVQ4XEnERWgwwMsPHUegODalvvZTGviZ3e5K7a4tbr
   HREYBUjqEBuPWk9fzi0qSllDyAhrV4a8DhkmUdNOb1OHwno6opogctDNO
   xE3M2nWmCv0/yHrAWU1pu3FOS/2QUAiayvddFjVYu6u1+bLBjXWgGDQCB
   0dWcdkqbIhSM1F6v3T39Mw+etCIKYMfwXjZf+4Dc0XiRW6BGwoSxYX5iu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="259570052"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="259570052"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584242600"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 08:25:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50040109; Tue,  7 Jun 2022 18:25:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] nvdimm/namespace: return uuid_null only once in nd_dev_to_uuid()
Date:   Tue,  7 Jun 2022 18:25:25 +0300
Message-Id: <20220607152525.33468-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor nd_dev_to_uuid() in order to make code shorter and cleaner
by joining conditions and hence returning uuid_null only once.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvdimm/namespace_devs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index bf4f5c09d9b1..3dae17c90e8c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -170,15 +170,12 @@ EXPORT_SYMBOL(nvdimm_namespace_disk_name);
 
 const uuid_t *nd_dev_to_uuid(struct device *dev)
 {
-	if (!dev)
-		return &uuid_null;
-
-	if (is_namespace_pmem(dev)) {
+	if (dev && is_namespace_pmem(dev)) {
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nspm->uuid;
-	} else
-		return &uuid_null;
+	}
+	return &uuid_null;
 }
 EXPORT_SYMBOL(nd_dev_to_uuid);
 
-- 
2.35.1

