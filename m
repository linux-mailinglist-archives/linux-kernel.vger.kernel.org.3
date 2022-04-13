Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF174FEF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiDMGFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiDMGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C40517EB;
        Tue, 12 Apr 2022 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829751; x=1681365751;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZkEJiezDzZSvDLuQ4QlHaZeACSH7DvqyONtGcXuk/g=;
  b=jlsmJu5c5+x9EuFl3X9rQOK4W3wbbUQuUk8hR67BWi+VR07SwExtknht
   3wcaN1++dtW3sOc4WRuBaZIyIHmKMqCUCbXlyXvoxdtnVbDDhu0Nx75CZ
   ubOvbVjXjVRMCmjLAxVCUf9iPcwUgRdfX7k1fMBUiAPqalGpO8IY3CUkB
   2cELgDw8meMiDkaupBLzSPXkMhj6bOFZjiIn2LmCosBl/ec2szb1dxyKZ
   t0CThEHZRmxKdv1rJTwHmmxIz7tGwBc2KrR3fEkLLIf4k/cBgGbWVhivg
   8LIL6kh7yEXoShBQp/V/D7+1+cmu+w0AIxSpvOiJdEwDQxdEkh+NDBL1f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323027736"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="323027736"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:01:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="724768554"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:01:55 -0700
Subject: [PATCH v2 05/12] cxl/core: Clamp max lock_class
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:01:55 -0700
Message-ID: <164982971542.684294.12980151056534955888.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_LOCKDEP_SUBCLASSES limits the depth of the CXL topology that can be
validated by lockdep. Given that the cxl_test topology is already at
this limit collapse some of the levels and clamp the max depth.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6c1a027e389..b86aac8cde4f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -410,20 +410,37 @@ enum cxl_lock_class {
 	CXL_ANON_LOCK,
 	CXL_NVDIMM_LOCK,
 	CXL_NVDIMM_BRIDGE_LOCK,
-	CXL_PORT_LOCK,
+	/*
+	 * Collapse the compatible port and nvdimm-bridge lock classes
+	 * to save space
+	 */
+	CXL_PORT_LOCK = CXL_NVDIMM_BRIDGE_LOCK,
 	/*
 	 * Be careful to add new lock classes here, CXL_PORT_LOCK is
 	 * extended by the port depth, so a maximum CXL port topology
-	 * depth would need to be defined first.
+	 * depth would need to be defined first. Also, the max
+	 * validation depth is limited by MAX_LOCKDEP_SUBCLASSES.
 	 */
 };
 
+static inline int clamp_lock_class(struct device *dev, int lock_class)
+{
+	if (lock_class >= MAX_LOCKDEP_SUBCLASSES) {
+		dev_warn_once(dev,
+			      "depth: %d, disabling lockdep for this device\n",
+			      lock_class);
+		return -1;
+	}
+
+	return lock_class;
+}
+
 static inline int cxl_lock_class(struct device *dev)
 {
 	if (is_cxl_port(dev)) {
 		struct cxl_port *port = to_cxl_port(dev);
 
-		return CXL_PORT_LOCK + port->depth;
+		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth);
 	} else if (is_cxl_decoder(dev)) {
 		struct cxl_port *port = to_cxl_port(dev->parent);
 
@@ -431,7 +448,7 @@ static inline int cxl_lock_class(struct device *dev)
 		 * A decoder is the immediate child of a port, so set
 		 * its lock class equal to other child device siblings.
 		 */
-		return CXL_PORT_LOCK + port->depth + 1;
+		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth + 1);
 	} else if (is_cxl_nvdimm_bridge(dev))
 		return CXL_NVDIMM_BRIDGE_LOCK;
 	else if (is_cxl_nvdimm(dev))

