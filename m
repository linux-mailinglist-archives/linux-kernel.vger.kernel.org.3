Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7795A5374
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH2RqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiH2RqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:46:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FB5A82D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661795174; x=1693331174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nm3IwFamhOe2Xr7lto2cK6gxI1DLaShGw7vs3xf5IPM=;
  b=lh1uUDYH1U383aURK5Y2TrtuUgiK6nsWi0CGkUOm84Tsw9SMJ1i0FLtm
   rDuYZ6Jz57d9QLf+y3JoOwlK4Ihn0zeKZAcA70R47Nm4TJgK9A5DLsqDM
   MSqhqW7RpGtAwb6h3zz0lPaBaed5IuYPHBsd4EinjR1xKQPi0G4PoyXc9
   1Eyhuk4zVEFSEOiYQURac4vpIzJcgPVy3gtxqt7Vm5e9JDPoVUoD3lovq
   08TjnT84aYWWi+3pYeE34n6cDr3gO96/6n2vX9ZOeEDmp32ZLnrGEM2Qz
   piwVD96zB6mQBPbF2cmizi0d/naF4r7lNOnarC+RnztgdLxYbg1GVt5k0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321080475"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="321080475"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:46:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="644508669"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.252.129.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:46:13 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 1/1] firmware_loader: Fix use-after-free during unregister
Date:   Mon, 29 Aug 2022 10:45:57 -0700
Message-Id: <20220829174557.437047-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following code within firmware_upload_unregister(), the call to
device_unregister() could result in the dev_release function freeing the
fw_upload_priv structure before it is dereferenced for the call to
module_put(). This bug was found by the kernel test robot using
CONFIG_KASAN while running the firmware selftests.

  device_unregister(&fw_sysfs->dev);
  module_put(fw_upload_priv->module);

The problem is fixed by copying fw_upload_priv->module to a local variable
for use when calling device_unregister().

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2: Rebased to latest linux-next branch (next-20220829)
---
 drivers/base/firmware_loader/sysfs_upload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 87044d52322a..63e15bddd80c 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -377,6 +377,7 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 {
 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
+	struct module *module = fw_upload_priv->module;
 
 	mutex_lock(&fw_upload_priv->lock);
 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
@@ -392,6 +393,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 unregister:
 	device_unregister(&fw_sysfs->dev);
-	module_put(fw_upload_priv->module);
+	module_put(module);
 }
 EXPORT_SYMBOL_GPL(firmware_upload_unregister);
-- 
2.25.1

