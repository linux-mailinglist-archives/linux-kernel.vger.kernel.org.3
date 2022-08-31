Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6595A7261
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiHaAZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHaAZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:25:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8382CDE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661905529; x=1693441529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C7FYEbYtlpQOw/iz+YDnE1icy/AvBAahWiFokyrQWzA=;
  b=Xz0r+K/y1y67EkuyEDo2SP+wlDC2T2GImpe9rTxWB5X259uBfeNslaV3
   quyXgU26bu3lAdnvG/zIWJ065e7rMY8V5Kzla6vMnDhthI+yVejJ1k3UY
   M7WIMpkIXVpZfYM5xW48Uhk3kE+0UiFMqsU9D1w0MTBPLPiaTW1M6ikrR
   AJd91sEm1SSR+9EYw5B+o1lSLkhL76b2NMnlyGKMGr1mHJmPXheE+TLq2
   OHipSuFR72C0x/LXQRtQGBQxBtmx0ekSdPzIOYhqrgOEV0mOUIxgr2UIf
   7tHFPgQL673QZtyhMJBj/Lvj6K7y268VStUGafAhwxYkN9JL8EA6orRTU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296123027"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="296123027"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:25:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="787704858"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.251.5.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:25:28 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/1] firmware_loader: Fix memory leak in firmware upload
Date:   Tue, 30 Aug 2022 17:25:18 -0700
Message-Id: <20220831002518.465274-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of firmware-upload, an instance of struct fw_upload is
allocated in firmware_upload_register(). This data needs to be freed
in fw_dev_release(). Create a new fw_upload_free() function in
sysfs_upload.c to handle the firmware-upload specific memory frees
and incorporate the missing kfree call for the fw_upload structure.

Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/base/firmware_loader/sysfs.c        | 7 +++----
 drivers/base/firmware_loader/sysfs.h        | 5 +++++
 drivers/base/firmware_loader/sysfs_upload.c | 9 +++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index 77bad32c481a..5b66b3d1fa16 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -93,10 +93,9 @@ static void fw_dev_release(struct device *dev)
 {
 	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
 
-	if (fw_sysfs->fw_upload_priv) {
-		free_fw_priv(fw_sysfs->fw_priv);
-		kfree(fw_sysfs->fw_upload_priv);
-	}
+	if (fw_sysfs->fw_upload_priv)
+		fw_upload_free(fw_sysfs);
+
 	kfree(fw_sysfs);
 }
 
diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
index 5d8ff1675c79..df1d5add698f 100644
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -106,12 +106,17 @@ extern struct device_attribute dev_attr_cancel;
 extern struct device_attribute dev_attr_remaining_size;
 
 int fw_upload_start(struct fw_sysfs *fw_sysfs);
+void fw_upload_free(struct fw_sysfs *fw_sysfs);
 umode_t fw_upload_is_visible(struct kobject *kobj, struct attribute *attr, int n);
 #else
 static inline int fw_upload_start(struct fw_sysfs *fw_sysfs)
 {
 	return 0;
 }
+
+static inline void fw_upload_free(struct fw_sysfs *fw_sysfs)
+{
+}
 #endif
 
 #endif /* __FIRMWARE_SYSFS_H */
diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 87044d52322a..8e71cde92ea8 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -264,6 +264,15 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 	return 0;
 }
 
+void fw_upload_free(struct fw_sysfs *fw_sysfs)
+{
+	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
+
+	free_fw_priv(fw_sysfs->fw_priv);
+	kfree(fw_upload_priv->fw_upload);
+	kfree(fw_upload_priv);
+}
+
 /**
  * firmware_upload_register() - register for the firmware upload sysfs API
  * @module: kernel module of this device
-- 
2.25.1

