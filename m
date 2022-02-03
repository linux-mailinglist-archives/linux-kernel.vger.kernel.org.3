Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1AA4A8FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355201AbiBCVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:31:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:32981 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355213AbiBCVbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643923860; x=1675459860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIhH4CM4evimqz3TCvPcYBmKpfEz3YdBXWrCIR1Reg0=;
  b=js8SjGQ/Rlp+7Tw3pDwa3GL8AuiYAvxhAmUDa030kQ4oBwXglhSQ1RDt
   E5gHzgs5a7P88SWkAopWRcyCyOpMYcbScTuV96vzRFOz8PP9JpsWVqs80
   osD6K0d+MuZxUDI6ysfiSYnr9BDmSZH5NJ+6edkZwVBkgJpN5+y5iqoPt
   k5C9uKYmy/L/voG3wWjKPSdSN5AtEbePWarPlhI8OTkaSwE3VM/11P0Sd
   YtNLGuInmSB1OLXXNFcEJfJ0sbOL67jOUa1f+kHNRPUQ7QciLre8ua7HF
   OgxLe85rCK6g8ChmeRtUkhte+gW3+DkWXVsgzGAKfS9HHcBL+/VnggCNC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334633986"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334633986"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:31:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583931511"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.6.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:30:59 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 2/5] firmware_loader: Check fw_state_is_done in loading_store
Date:   Thu,  3 Feb 2022 14:30:49 -0700
Message-Id: <20220203213053.360190-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203213053.360190-1-russell.h.weight@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

