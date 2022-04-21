Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4318F50A46F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390234AbiDUPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390230AbiDUPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:39:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFA4739B;
        Thu, 21 Apr 2022 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555430; x=1682091430;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qo8mEyXyeD/WLpM5PUEvAxSmJze8tzwfv5FGI2P5jME=;
  b=i5PaL36G/QodDj8+IeEkKjLjgOZ5m/0yw1R/iEJ5KAWAhGzREFU0HOwk
   5LInBDwp8zoVd9TL0SilBaNLuRIrOByzt5pk+YoHp/uyTLIcngObjPMUS
   Ix5BEuYjImjn8RYMRaMMsn46zM5RWPw2gn1jCJJVKydWlZzcrfi+dpqvM
   /qql9ufP4v6uu9Om0h8T2cG8QG5r2vIj2vK2Q4QbgpDWzn22NknUmg61A
   SV53IaRG8wZRChxoFUgQXAAedlSHXr+ANNNTcdhKiKck8E1aB2hocbqmy
   amVVDJXXTk4aSKggT7Y3HwFPBMV6MsTC0bzqDsgZwk83RBSYyFQVyepZB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244967323"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="244967323"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="866382131"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:45 -0700
Subject: [PATCH v3 7/8] device-core: Kill the lockdep_mutex
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 08:33:45 -0700
Message-ID: <165055522548.3745911.14298368286915484086.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Per Peter [1], the lockdep API has native support for all the use cases
lockdep_mutex was attempting to enable. Now that all lockdep_mutex users
have been converted to those APIs, drop this lock.

Link: https://lore.kernel.org/r/Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net [1]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |    3 ---
 include/linux/device.h |    5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..2eede2ec3d64 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2864,9 +2864,6 @@ void device_initialize(struct device *dev)
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
-#ifdef CONFIG_PROVE_LOCKING
-	mutex_init(&dev->lockdep_mutex);
-#endif
 	lockdep_set_novalidate_class(&dev->mutex);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
diff --git a/include/linux/device.h b/include/linux/device.h
index 82c9d307e7bd..c00ab223da50 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -400,8 +400,6 @@ struct dev_msi_info {
  * 		This identifies the device type and carries type-specific
  * 		information.
  * @mutex:	Mutex to synchronize calls to its driver.
- * @lockdep_mutex: An optional debug lock that a subsystem can use as a
- * 		peer lock to gain localized lockdep coverage of the device_lock.
  * @bus:	Type of bus device is on.
  * @driver:	Which driver has allocated this
  * @platform_data: Platform data specific to the device.
@@ -499,9 +497,6 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set_drvdata/dev_get_drvdata */
-#ifdef CONFIG_PROVE_LOCKING
-	struct mutex		lockdep_mutex;
-#endif
 	struct mutex		mutex;	/* mutex to synchronize calls to
 					 * its driver.
 					 */

