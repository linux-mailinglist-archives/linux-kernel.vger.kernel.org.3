Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9778F59D089
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiHWFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbiHWFfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:35:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C405E302
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232899; x=1692768899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5tPQYoYyQx9LRdvjr1phTNkVbVqfOYGd3NZCF5nUc8=;
  b=lC1wfESVPINOzfROirqADEQIhhougjwrIs3V85VR/FryCitKt/JI4wCs
   nUzEztwa8TRY4oeOsdhee9q/gB0lxAQZC27O50lIM4R/bewvZjFZ/47S9
   TbKJ4XN9cmWgfECfWho1Yi1bIQx6ru69KQn+pc+5wQseY/AqaeDjVFjLu
   AaEOtFxRVdu55Fr6lq3CuTPihnnGEb1607oLUFFzbdkNCQfVxj+b6tE0n
   I0eQSLizJBzPtmMWC7HltCpYCDGdNaJ0XfrCLSQz7IIy8t33W1vtK53zO
   wzbETjy5hKb+TEHQ0BnWzRpkGzb0UKG7/bNzvelJYRJ2pvVifH8nqy/Z/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568600"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568600"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558270"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 04/11] soundwire: intel: cleanup SHIM SYNC
Date:   Tue, 23 Aug 2022 13:38:39 +0800
Message-Id: <20220823053846.2684635-5-yung-chuan.liao@linux.intel.com>
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

Regroup offset and bitfields, no functionality change

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 581a9ba32f82..66503cf29f48 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -27,8 +27,17 @@
 #define SDW_SHIM_LCTL_CPA		BIT(8)
 #define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
 
+/* SYNC */
 #define SDW_SHIM_SYNC			0xC
 
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
+#define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
+#define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
+#define SDW_SHIM_SYNC_CMDSYNC		BIT(16)
+#define SDW_SHIM_SYNC_SYNCGO		BIT(24)
+
 #define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
 #define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
 #define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
@@ -45,14 +54,6 @@
 #define SDW_SHIM_WAKEEN			0x190
 #define SDW_SHIM_WAKESTS		0x192
 
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
-#define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
-#define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
-#define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
-#define SDW_SHIM_SYNC_CMDSYNC		BIT(16)
-#define SDW_SHIM_SYNC_SYNCGO		BIT(24)
-
 #define SDW_SHIM_PCMSCAP_ISS		GENMASK(3, 0)
 #define SDW_SHIM_PCMSCAP_OSS		GENMASK(7, 4)
 #define SDW_SHIM_PCMSCAP_BSS		GENMASK(12, 8)
-- 
2.25.1

