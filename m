Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCDA59D08F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiHWFfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiHWFfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:35:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5B5C976
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232909; x=1692768909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+iNlOszn+gMTSQyypCPfcGYNM5m1UlQ+pzZVRWhcy8=;
  b=GQs11QHFKmZdDMv1oOdEOYYaQg/br0UNFRVhUaokgMV2xrfOowGdLaT3
   9wji8iHpge4CLDNg0HGBTOBazwU7IYFEr9EiX2tfo4KBAyhAeYmD8qqsV
   uPvm2FMteNOafEFxYhwItOLwFqkBBQhDuHjQz1RxokjseerfS2jVlmDP3
   nYC5wk/dTH7mW3GMBUOD5TdwdSa3obWVfVEJ2MrTBGVXitsI3Mo5bcF40
   MHQ0B3MZJcLvC4t6uolh4q1cGH3pqGg70SdBBDCQuM2Lx2Qrjol6DhlHo
   YjFU3Ss8jE2mbavV3sfEnkYCmi+/8S5xEBwPVD+/JrmZqHYQcjX9CCMT1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568626"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558352"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:07 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 10/11] soundwire: intel: cleanup AC Timing Control
Date:   Tue, 23 Aug 2022 13:38:45 +0800
Message-Id: <20220823053846.2684635-11-yung-chuan.liao@linux.intel.com>
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

Regroup offset and bitfield definitions

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index a2e1927ac8ac..3a56fd5a6331 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -76,11 +76,12 @@
 #define SDW_SHIM_IOCTL_CIBD		BIT(8)
 #define SDW_SHIM_IOCTL_DIBD		BIT(9)
 
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
-
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
 
+/* AC Timing control */
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
+
 #define SDW_SHIM_CTMCTL_DACTQE		BIT(0)
 #define SDW_SHIM_CTMCTL_DODS		BIT(1)
 #define SDW_SHIM_CTMCTL_DOAIS		GENMASK(4, 3)
-- 
2.25.1

