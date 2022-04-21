Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A150A471
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390244AbiDUPlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349678AbiDUPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:41:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7D47567;
        Thu, 21 Apr 2022 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555497; x=1682091497;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3xS6cEt6lHXiNb+A1o9kWq7JklXoM+r+tP2gN5rJV4=;
  b=Nfped+G9jtnauyMKN4Y3280vytBcN3IOLbF5Di6ZfGLfw1U/uHajWRJI
   l4EaXaO1f1BNQirVHrQmcRPnxKXY4qLcjM1Cba8MkM5MtdD0iaYSsT+o9
   nJaDq3ASlcK47+WWrm992j3TJ2D+5VN6hg3cjhEo+x/5quNI5Pksi7HRX
   xv/fWnnHCK1jKry+ZTdQiX99xyVp2hQuU5BBI9RYgKiNvc2cIVPglSHci
   LhWvZV8D8/X8iIF/VHX66UU18A9swzQLKtOwFooqprihu7kcg69WnyYM5
   frLTs9vaR7G+SwKHT3T41E/dTQr26bWcGh9iefWIdsW7FjJExfke4y1gu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263241291"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263241291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="530353769"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:51 -0700
Subject: [PATCH v3 8/8] nvdimm: Fix firmware activation deadlock scenarios
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     peterz@infradead.org, vishal.l.verma@intel.com,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 08:33:51 -0700
Message-ID: <165055523099.3745911.9091010720291846249.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep reports the following deadlock scenarios for CXL root device
power-management, device_prepare(), operations, and device_shutdown()
operations for 'nd_region' devices:

---
 Chain exists of:
   &nvdimm_region_key --> &nvdimm_bus->reconfig_mutex --> system_transition_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(system_transition_mutex);
                                lock(&nvdimm_bus->reconfig_mutex);
                                lock(system_transition_mutex);
   lock(&nvdimm_region_key);

--

 Chain exists of:
   &cxl_nvdimm_bridge_key --> acpi_scan_lock --> &cxl_root_key

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&cxl_root_key);
                                lock(acpi_scan_lock);
                                lock(&cxl_root_key);
   lock(&cxl_nvdimm_bridge_key);

---

These stem from holding nvdimm_bus_lock() over hibernate_quiet_exec()
which walks the entire system device topology taking device_lock() along
the way. The nvdimm_bus_lock() is protecting against unregistration,
multiple simultaneous ops callers, and preventing activate_show() from
racing activate_store(). For the first 2, the lock is redundant.
Unregistration already flushes all ops users, and sysfs already prevents
multiple threads to be active in an ops handler at the same time. For
the last userspace should already be waiting for its last
activate_store() to complete, and does not need activate_show() to flush
the write side, so this lock usage can be deleted in these attributes.

Fixes: 48001ea50d17 ("PM, libnvdimm: Add runtime firmware activation support")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/core.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 144926b7451c..7c7f4a43fd4f 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -395,10 +395,8 @@ static ssize_t activate_show(struct device *dev,
 	if (!nd_desc->fw_ops)
 		return -EOPNOTSUPP;
 
-	nvdimm_bus_lock(dev);
 	cap = nd_desc->fw_ops->capability(nd_desc);
 	state = nd_desc->fw_ops->activate_state(nd_desc);
-	nvdimm_bus_unlock(dev);
 
 	if (cap < NVDIMM_FWA_CAP_QUIESCE)
 		return -EOPNOTSUPP;
@@ -443,7 +441,6 @@ static ssize_t activate_store(struct device *dev,
 	else
 		return -EINVAL;
 
-	nvdimm_bus_lock(dev);
 	state = nd_desc->fw_ops->activate_state(nd_desc);
 
 	switch (state) {
@@ -461,7 +458,6 @@ static ssize_t activate_store(struct device *dev,
 	default:
 		rc = -ENXIO;
 	}
-	nvdimm_bus_unlock(dev);
 
 	if (rc == 0)
 		rc = len;

