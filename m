Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180459D08D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiHWFf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbiHWFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:35:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE05B5C976
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232906; x=1692768906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yc7RFkUtH2FXd/9strLCaMxqG9dXo+oRJXbSLQ9J/mE=;
  b=WWYXJEzTaBsYLSxab0baFOe8CyVT9tUyjlkyDvRb96/6vtGBXeJpFrBp
   5O6xOncBuFfUDxqPahPJAkxtnVZJKf9t+16M5J2t/AaZl/JPcNgM/rFir
   rawupQ+m4DpU2ItiVCdtgjsNWYwzu2dix1itupHQiE475x2/YfNxzIhsx
   exezt55MLmyqhrrohzCzQFZq8p9zXRSVobEv9VantKd80iEQBbLCTXBth
   pKFom5xZyt25BFZS2EN4UfTbO94yz7ueUkBILO6lVPZfAY1ygeksdZjrz
   744o8CAajB04cmY0e1Qt7hv4JKAaHuDke35yjEeyn2HncISi8UsxBHDLn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568620"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558334"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:04 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 08/11] soundwire: intel: cleanup PCM Stream channel map and channel count
Date:   Tue, 23 Aug 2022 13:38:43 +0800
Message-Id: <20220823053846.2684635-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
References: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Regroup offset and bitfield definitions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 958628e936ea..a1810701642e 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -52,19 +52,23 @@
 #define SDW_SHIM_PCMSCAP_OSS		GENMASK(7, 4)
 #define SDW_SHIM_PCMSCAP_BSS		GENMASK(12, 8)
 
+/* PCM Stream Channel Map */
 #define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
+
+/* PCM Stream Channel Count */
 #define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
-#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
-
-#define SDW_SHIM_WAKEEN			0x190
-#define SDW_SHIM_WAKESTS		0x192
 
 #define SDW_SHIM_PCMSYCM_LCHN		GENMASK(3, 0)
 #define SDW_SHIM_PCMSYCM_HCHN		GENMASK(7, 4)
 #define SDW_SHIM_PCMSYCM_STREAM		GENMASK(13, 8)
 #define SDW_SHIM_PCMSYCM_DIR		BIT(15)
 
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
+
+#define SDW_SHIM_WAKEEN			0x190
+#define SDW_SHIM_WAKESTS		0x192
+
 #define SDW_SHIM_IOCTL_MIF		BIT(0)
 #define SDW_SHIM_IOCTL_CO		BIT(1)
 #define SDW_SHIM_IOCTL_COE		BIT(2)
-- 
2.25.1

