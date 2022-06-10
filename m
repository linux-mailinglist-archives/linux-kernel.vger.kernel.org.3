Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176D545A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbiFJCf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiFJCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:35:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF04F44E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654828551; x=1686364551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbfVyJIpKWWl8KF3OlHEusSCn78ZocgcBg7L63EI6as=;
  b=lOQo5XFyvVMEeA+Q4gseyLS5GeIpC/J4f98wFsWOZqhO3RuVs7PvOoB9
   re1ttZhhRxuZasoaAykHYVBEJO0Uo10wnAeJuuH7rASmTe05F0ORITe94
   zPXQo5m3ttJH2SyiUjSWUbx70iKqKRRjqMUDeY/Rt+15y/gZcSJagRLgv
   8t7OxbQMqVktkBJhKJrllix7+66vpc7324SihuNyqnAfSltbvF6Pcg8wB
   r186YkUTSPTN5HAVkAIcBAz05HIzHL0pjST36G1z5AJF6Uax+vsUFJ3oD
   SoG43fWt0udPdD8PEbxNuxklI12UHT86nxLiX439yBFea5NEFqIyyoalC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341555035"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341555035"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:35:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637874955"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:35:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: intel: uniquify debug message
Date:   Fri, 10 Jun 2022 10:35:36 +0800
Message-Id: <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The same debug message is replicated multiple time, add __func__ to
figure out what link is ignored.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 505c5ef061e3..808e2f320052 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 
 	if (bus->prop.hw_disabled) {
 		dev_info(dev,
-			 "SoundWire master %d is disabled, ignoring\n",
-			 sdw->instance);
+			 "%s: SoundWire master %d is disabled, ignoring\n",
+			 __func__, sdw->instance);
 		return 0;
 	}
 
@@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
 	bus = &sdw->cdns.bus;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
@@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
@@ -1609,8 +1609,8 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
@@ -1662,8 +1662,8 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
@@ -1727,8 +1727,8 @@ static int __maybe_unused intel_resume(struct device *dev)
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
@@ -1825,8 +1825,8 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
-		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
-			bus->link_id);
+		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
+			__func__, bus->link_id);
 		return 0;
 	}
 
-- 
2.17.1

