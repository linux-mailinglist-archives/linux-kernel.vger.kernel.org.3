Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51191507D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358443AbiDSXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDSXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:19:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8141238BC5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650410223; x=1681946223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E7L2PxFBz6DNdHvbSzbo6sK+tOKGIYTf+cvngmk5gXA=;
  b=czIQUGYLQE42xQe8K0hvaCDOEwz+LvzNbhXSDUGqoxhVj8RlVZxAsuIa
   q9i1p+/66GFtLxLHXHYYPIwVJioabRx5GCPVXxotc1O7m6OT96crfMvIZ
   Jh4i7IlM237o5sfDYDBYIw090CQNW3XhmhihyIsb+rZXWzdp0XyoONnGr
   85Oo23wPWvTqUlZK2+c1v+6jlOUNMUCsWBB8XkNkIq3PqE2XmU3aVa2Tb
   iEc8FJdYffQcVzPa03A7ESjTEzS2ehcrw+SU8yUvLn3QrneJ+IPNuj+w5
   Hf/xHxeoSfUiJZH7Q7TPioHoE4OLDFOPizgeoyxB6Xzel3XYQ8WIJScc3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263656651"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263656651"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="862277679"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.68.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:02 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 2/8] firmware_loader: Check fw_state_is_done in loading_store
Date:   Tue, 19 Apr 2022 16:16:52 -0700
Message-Id: <20220419231658.664388-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419231658.664388-1-russell.h.weight@intel.com>
References: <20220419231658.664388-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename fw_sysfs_done() and fw_sysfs_loading() to fw_state_is_done() and
fw_state_is_loading() respectively, and place them along side companion
functions in drivers/base/firmware_loader/firmware.h.

Use the fw_state_is_done() function to exit early from
firmware_loading_store() if the state is already "done". This is being done
in preparation for supporting persistent sysfs nodes to allow userspace to
upload firmware to a device, potentially reusing the sysfs loading and data
files multiple times.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v1:
  - No change from RFC patch
v2:
  - It was discovered that the new function in v1, fw_state_is_done(), is
    equivalent to the existing fw_sysfs_done() function. Renamed
    fw_sysfs_done() and fw_sysfs_loading() to fw_state_is_done() and
    fw_state_is_loading() respectively, and placed them along side companion
    functions in drivers/base/firmware_loader/firmware.h.
  - Removed the "if !fw_sysfs_done(fw_priv))" condition in switch case 1 of
    firmware_loading_store(). It is rendered unnecessary by other changes
    to the function by this patch.
v3:
  - Added Reviewed-by tag
v4:
  - Added Reviewed-by tag
---
 drivers/base/firmware_loader/fallback.c | 28 +++++++------------------
 drivers/base/firmware_loader/firmware.h | 10 +++++++++
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 4afb0e9312c0..8063eb595719 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -58,16 +58,6 @@ static long firmware_loading_timeout(void)
 		__firmware_loading_timeout() * HZ : MAX_JIFFY_OFFSET;
 }
 
-static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
-{
-	return __fw_state_check(fw_priv, FW_STATUS_DONE);
-}
-
-static inline bool fw_sysfs_loading(struct fw_priv *fw_priv)
-{
-	return __fw_state_check(fw_priv, FW_STATUS_LOADING);
-}
-
 static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
 {
 	return __fw_state_wait_common(fw_priv, timeout);
@@ -91,7 +81,7 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
 	 * There is a small window in which user can write to 'loading'
 	 * between loading done/aborted and disappearance of 'loading'
 	 */
-	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
+	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
 		return;
 
 	fw_state_aborted(fw_priv);
@@ -220,7 +210,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 
 	mutex_lock(&fw_lock);
 	if (fw_sysfs->fw_priv)
-		loading = fw_sysfs_loading(fw_sysfs->fw_priv);
+		loading = fw_state_is_loading(fw_sysfs->fw_priv);
 	mutex_unlock(&fw_lock);
 
 	return sysfs_emit(buf, "%d\n", loading);
@@ -250,19 +240,17 @@ static ssize_t firmware_loading_store(struct device *dev,
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
-	if (fw_state_is_aborted(fw_priv))
+	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
 		goto out;
 
 	switch (loading) {
 	case 1:
 		/* discarding any previous partial load */
-		if (!fw_sysfs_done(fw_priv)) {
-			fw_free_paged_buf(fw_priv);
-			fw_state_start(fw_priv);
-		}
+		fw_free_paged_buf(fw_priv);
+		fw_state_start(fw_priv);
 		break;
 	case 0:
-		if (fw_sysfs_loading(fw_priv)) {
+		if (fw_state_is_loading(fw_priv)) {
 			int rc;
 
 			/*
@@ -350,7 +338,7 @@ static ssize_t firmware_data_read(struct file *filp, struct kobject *kobj,
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
-	if (!fw_priv || fw_sysfs_done(fw_priv)) {
+	if (!fw_priv || fw_state_is_done(fw_priv)) {
 		ret_count = -ENODEV;
 		goto out;
 	}
@@ -410,7 +398,7 @@ static ssize_t firmware_data_write(struct file *filp, struct kobject *kobj,
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
-	if (!fw_priv || fw_sysfs_done(fw_priv)) {
+	if (!fw_priv || fw_state_is_done(fw_priv)) {
 		retval = -ENODEV;
 		goto out;
 	}
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 2889f446ad41..d5ff32a1ba2d 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -149,6 +149,16 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 	__fw_state_set(fw_priv, FW_STATUS_DONE);
 }
 
+static inline bool fw_state_is_done(struct fw_priv *fw_priv)
+{
+	return __fw_state_check(fw_priv, FW_STATUS_DONE);
+}
+
+static inline bool fw_state_is_loading(struct fw_priv *fw_priv)
+{
+	return __fw_state_check(fw_priv, FW_STATUS_LOADING);
+}
+
 int assign_fw(struct firmware *fw, struct device *device);
 
 #ifdef CONFIG_FW_LOADER
-- 
2.25.1

