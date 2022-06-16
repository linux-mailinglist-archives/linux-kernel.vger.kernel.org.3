Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C854E836
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiFPQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiFPQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4D3CFD8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398710; x=1686934710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acoaQ8+mqVnjlqMPO1bXudjvkmTLR2jpquftzCrTkNk=;
  b=G5zoC7MQrX1D2sTF4OLemEJJMBjo+HD/B3a4qs0GtqYw5gU+dgNADtGA
   wgVNmgr3dcz6oatXVaenXU/z1N/7XwJ5it+x6Tgy47XRcupRhDEXf1ai5
   Xuh37fZBRxrTEPpfJOXUA/8ee9GXcFfpw/gTNTYt7JJzD13XCEHWFK7hw
   8x+ikCppLVrtNaN/o+xY6cgXXTZ4yGGb0FMCPL29LNyNjfh0F+5ZCfwI0
   Ox68ctYvatVbCt5zqTVKzu7iShoNJmswZXc03Y8w19AM85ntYiog9ppqI
   LmXkSbULJWCDQdfy4jUmiCQmCrKHaygB2E1kpa5I6IFQLiqtE5einMc0Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280327625"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="280327625"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="536514740"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 09:58:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A57ED4F4; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 09/11] mfd: intel_soc_pmic_bxtwc: Use sysfs_emit() instead of sprintf()
Date:   Thu, 16 Jun 2022 19:58:21 +0300
Message-Id: <20220616165823.4919-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_emit() is preferred over sprintf() when formatting the value to be
returned to user space in show() functions, because it knows about sysfs
buffer specifics and has sanity checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 529aec38389c..4e890f095721 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -334,7 +334,7 @@ static unsigned long bxtwc_reg_addr;
 static ssize_t addr_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0x%lx\n", bxtwc_reg_addr);
+	return sysfs_emit(buf, "0x%lx\n", bxtwc_reg_addr);
 }
 
 static ssize_t addr_store(struct device *dev,
@@ -364,7 +364,7 @@ static ssize_t val_show(struct device *dev,
 		return ret;
 	}
 
-	return sprintf(buf, "0x%02x\n", val);
+	return sysfs_emit(buf, "0x%02x\n", val);
 }
 
 static ssize_t val_store(struct device *dev,
-- 
2.35.1

