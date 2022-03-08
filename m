Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA094D239C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiCHVun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbiCHVug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:50:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67555BC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646776179; x=1678312179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5B867NxD2rUzUfzuiddRfj7M0tvh5dRqn7VBG5tbW4Q=;
  b=EJVLa3deob0sTv3zd8mQYGIhXK+rBbppMuudMdRXpgr0Kebf8zGcs5tR
   wPF0mw+wBcmd2KKl/LEezKXTUDVeaTn4jVHDrcYV6yBInvmMDT3n1E4uW
   6ADtMBRdz+wv+fGcA98v5P5mxD8OLH/oezEEvJfAv+PrbI0MuGbp/exxX
   gI/lvuxArKDrEKrGx2dMKuduOECLODl3daJo6/ZgrugiH1g87y7gbNED2
   W2lFx6i92enVNErq8YSKKSl2e025Xsg0bSKVtyqGttIcTr1Hpxl8Jj/II
   Vq2c8kDTbsFk7aTq0r5zSkDNcEqYW1oRiShZdBmGB+tS7tMBKmo+oDOkr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254553226"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254553226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:49:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495612832"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.239.204])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:49:37 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 2/8] firmware_loader: Check fw_state_is_done in loading_store
Date:   Tue,  8 Mar 2022 13:49:26 -0800
Message-Id: <20220308214932.24477-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308214932.24477-1-russell.h.weight@intel.com>
References: <20220308214932.24477-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the fw_state_is_done() function and exit early from
firmware_loading_store() if the state is already "done". This is being done
in preparation for supporting persistent sysfs nodes to allow userspace to
upload firmware to a device, potentially reusing the sysfs loading and data
files multiple times.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v1:
  - No change from RFC patch
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 drivers/base/firmware_loader/firmware.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 4afb0e9312c0..d82e055a4297 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -250,7 +250,7 @@ static ssize_t firmware_loading_store(struct device *dev,
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
-	if (fw_state_is_aborted(fw_priv))
+	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
 		goto out;
 
 	switch (loading) {
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 2889f446ad41..58768d16f8df 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -149,6 +149,11 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 	__fw_state_set(fw_priv, FW_STATUS_DONE);
 }
 
+static inline bool fw_state_is_done(struct fw_priv *fw_priv)
+{
+	return __fw_state_check(fw_priv, FW_STATUS_DONE);
+}
+
 int assign_fw(struct firmware *fw, struct device *device);
 
 #ifdef CONFIG_FW_LOADER
-- 
2.25.1

