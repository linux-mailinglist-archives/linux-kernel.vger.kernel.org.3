Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5C4FEF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiDMGEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiDMGEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4C51330;
        Tue, 12 Apr 2022 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829731; x=1681365731;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=faqWslrqMKaVyC0Fx4CcmYrY8vRuemnJ7TWhZUeAea8=;
  b=VJKkowjm710fKNmGlii/Veymc4Tfmw+e7yJb0A1zbXXlmUs1yWdP6UjX
   R6bniwC8cQuxhiw0p0M9bj9R7fd070HfYpxv9L5NUfAZtreeHU5wkroEP
   mfwOe+S03nB5dU7zSRDUVDreeHO4xNNtwFS/04DUKDc431WorYi2G+xwU
   GGAhP0963VQehuVNAHJAdOP2maWiuiov46U3znTPl/VPARRtDsBRk/gRQ
   2DVFUbGR+WXwJU+x5VQKIkaGhe+JT8UkRxUrIAumg8oSQzi4QTJJ2WP7O
   0+oNNvDL55FFEJ+W+ag+fslrdXl6Crkntl1lRImz5pG/p9rIWEfNWIq1r
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349020019"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="349020019"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="590632349"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:10 -0700
Subject: [PATCH v2 08/12] libnvdimm: Refactor an nvdimm_lock_class() helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        alison.schofield@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:02:10 -0700
Message-ID: <164982973080.684294.10727665061649724835.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving to the device-core device_lock lockdep
validation, refactor an nvdimm_lock_class() helper to be used with
device_set_lock_class().

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/nd-core.h |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 448f9dcb4bb7..deb3d047571e 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -174,22 +174,27 @@ enum {
 	LOCK_CLAIM,
 };
 
-static inline void debug_nvdimm_lock(struct device *dev)
+static inline int nvdimm_lock_class(struct device *dev)
 {
 	if (is_nd_region(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_REGION);
+		return LOCK_REGION;
 	else if (is_nvdimm(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_DIMM);
+		return LOCK_DIMM;
 	else if (is_nd_btt(dev) || is_nd_pfn(dev) || is_nd_dax(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_CLAIM);
+		return LOCK_CLAIM;
 	else if (dev->parent && (is_nd_region(dev->parent)))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_NAMESPACE);
+		return LOCK_NAMESPACE;
 	else if (is_nvdimm_bus(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_BUS);
+		return LOCK_BUS;
 	else if (dev->class && dev->class == nd_class)
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_NDCTL);
+		return LOCK_NDCTL;
 	else
-		dev_WARN(dev, "unknown lock level\n");
+		return -1;
+}
+
+static inline void debug_nvdimm_lock(struct device *dev)
+{
+	mutex_lock_nested(&dev->lockdep_mutex, nvdimm_lock_class(dev));
 }
 
 static inline void debug_nvdimm_unlock(struct device *dev)

