Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB259D090
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiHWFfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiHWFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:35:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37DC5E32B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232911; x=1692768911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lIDXQ+rdDpYoI61ktv6nw6pBfN8AbK7G9dl/OtiKCjo=;
  b=lLU3NjgoPzWIvZWJ3MK8/5WxaPuO9Mh4WR7/SbH56sEVdcMc2KJ95VRc
   Kcmg2mz1RW+3zx81/fCzbPwZAHu1neUY9IzYN2zwpAhjWsk8nbHUCZnBD
   oPESgSLUK0W0Nst5wOK0zt2eZ8jMin2pSDSKQkVh3Ah0YanNZ0EMXkms+
   dY3FvRzX3GvRikt2C/uSClYs3Rc7y/szfR/wUfZRqPYBuxLhkDUHZI7ch
   u0f9vkILGZj31oTE1OLokR63MIDi9uQw8fuq+WeZO5/VPLBMAYFCj4r/e
   TKgYeUdTz8Z6ZjL5MkUm88elmQIgjymoCbuvLJwer111W4shOVfMKiSpo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568632"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558361"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:35:09 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 11/11] soundwire: intel: cleanup WakeEnable and WakeStatus
Date:   Tue, 23 Aug 2022 13:38:46 +0800
Message-Id: <20220823053846.2684635-12-yung-chuan.liao@linux.intel.com>
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
 include/linux/soundwire/sdw_intel.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 3a56fd5a6331..2e9fd91572d4 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -76,9 +76,16 @@
 #define SDW_SHIM_IOCTL_CIBD		BIT(8)
 #define SDW_SHIM_IOCTL_DIBD		BIT(9)
 
+/* Wake Enable*/
 #define SDW_SHIM_WAKEEN			0x190
+
+#define SDW_SHIM_WAKEEN_ENABLE		BIT(0)
+
+/* Wake Status */
 #define SDW_SHIM_WAKESTS		0x192
 
+#define SDW_SHIM_WAKESTS_STATUS		BIT(0)
+
 /* AC Timing control */
 #define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
 
@@ -86,9 +93,6 @@
 #define SDW_SHIM_CTMCTL_DODS		BIT(1)
 #define SDW_SHIM_CTMCTL_DOAIS		GENMASK(4, 3)
 
-#define SDW_SHIM_WAKEEN_ENABLE		BIT(0)
-#define SDW_SHIM_WAKESTS_STATUS		BIT(0)
-
 /* Intel ALH Register definitions */
 #define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
 #define SDW_ALH_NUM_STREAMS		64
-- 
2.25.1

