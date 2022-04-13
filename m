Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7F4FEF22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiDMGEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiDMGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A510515AC;
        Tue, 12 Apr 2022 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829725; x=1681365725;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeXGisg3F5xd5CDMy9xUZA6jIDX7Clw9WAukSk7hrxY=;
  b=Ks4wo2JHJlhUIyGqL0JCdMMRqzV+aAShE+bVLrkjN4JmmvNtXr7wEYBY
   0yuCAeRzA1h3u6ZGArGRr3Yg5UqNecaNdu8u+a6TH8awDLeiPkpQwR05G
   mpi5GYc5hkhFp0JLbdmAVPGyFmYTLrZKKB8wTsa9nLIAF0ixNIlsQFPW2
   2H3y8D4Hyudb+Nco9laJ58hbH153gnuxUBEGzp5/p+RXS30cUqrRCtXII
   gJZ6RZzU//U1Jk89yE5DAIBN5BAOE0qhpLPbBZO+AYGJCGZX8dQr9cv+V
   93uf3Y9luEoXmqH1TNjwGMVlX8WFW7cmn+eIoOM7RNvnbWX7MMGYEsfdn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262025971"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262025971"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="623559249"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:01:44 -0700
Subject: [PATCH v2 03/12] cxl/core: Refactor a cxl_lock_class() out of
 cxl_nested_lock()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:01:44 -0700
Message-ID: <164982970436.684294.12004091884213856239.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for upleveling device_lock() lockdep annotation support into
the core, provide a helper to retrieve the lock class. This lock_class
will be used with device_set_lock_class() to identify the CXL nested
locking rules.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 990b6670222e..c9fda9304c54 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,13 +418,12 @@ enum cxl_lock_class {
 	 */
 };
 
-static inline void cxl_nested_lock(struct device *dev)
+static inline int cxl_lock_class(struct device *dev)
 {
 	if (is_cxl_port(dev)) {
 		struct cxl_port *port = to_cxl_port(dev);
 
-		mutex_lock_nested(&dev->lockdep_mutex,
-				  CXL_PORT_LOCK + port->depth);
+		return CXL_PORT_LOCK + port->depth;
 	} else if (is_cxl_decoder(dev)) {
 		struct cxl_port *port = to_cxl_port(dev->parent);
 
@@ -432,14 +431,18 @@ static inline void cxl_nested_lock(struct device *dev)
 		 * A decoder is the immediate child of a port, so set
 		 * its lock class equal to other child device siblings.
 		 */
-		mutex_lock_nested(&dev->lockdep_mutex,
-				  CXL_PORT_LOCK + port->depth + 1);
+		return CXL_PORT_LOCK + port->depth + 1;
 	} else if (is_cxl_nvdimm_bridge(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
+		return CXL_NVDIMM_BRIDGE_LOCK;
 	else if (is_cxl_nvdimm(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
+		return CXL_NVDIMM_LOCK;
 	else
-		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
+		return CXL_ANON_LOCK;
+}
+
+static inline void cxl_nested_lock(struct device *dev)
+{
+	mutex_lock_nested(&dev->lockdep_mutex, cxl_lock_class(dev));
 }
 
 static inline void cxl_nested_unlock(struct device *dev)

