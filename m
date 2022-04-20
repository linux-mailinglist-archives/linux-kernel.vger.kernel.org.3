Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B636507ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbiDTCdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348564AbiDTCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:33:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790811161
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650421849; x=1681957849;
  h=from:to:cc:subject:date:message-id;
  bh=2x5p0qshyNJJblwHIKzMWnvRCa7FvV22Ri0Wm88vg/s=;
  b=Ceb8FsFw+OB0nGb7cFtOAqLPqVbfUB5Lng0+WpWJ+7Wpl+b+eNnVDYAR
   9R36Yf+/bFOsJTBF/H2I/dOAXTywht1jQn8yYrabtKTbq0Eo3xIyy3scv
   tVx4RBxoYgnwG2NePbIrTQ2Q0ntVuaoy0middT1vOxs+kJGm3Ryi2pjQP
   HwwzUELly8SWh2qjVN0fCu6QIXwfC81fbfG2EDJDH01HJOEkrvliduCtB
   k33muiVm1VUIg6QwDRxtE+S/LoV5BbO7D3OPNSozTWCmfcBvxxiN9SatA
   0+rKRnKEeuzS42tbzhRUZqPOTcE9ifI+hdHqbmZhZq8cjZnD+iSOvwW87
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243852890"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="243852890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:30:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529554083"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:30:46 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: cadence: recheck device0 attachment after status change
Date:   Wed, 20 Apr 2022 10:30:39 +0800
Message-Id: <20220420023039.14144-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This patch adds a status check after device0 attachment to solve race
conditions observed during attachment with multiple devices per link

The sequence is the following

1) deviceA attaches as device0

2) the hardware detects a device0 status change and throws an
 interrupt.

3) the interrupt handler schedules the work function

4) the workqueue starts, we read the status
slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);

we deal with the status change and program deviceA device number to a
non-zero value.

5) deviceB attaches as device0, the device0 status seen by the
hardware does not change.

6) we clear the CDNS_MCP_SLAVE_INTSTAT0/1 registers -> we will never detect
deviceB!

This patch suggest re-checking in a loop the device0 status with a
PING frame, i.e. using the real device0 status instead of information
on status changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 558390af44b6..47d59190a96e 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -959,6 +959,8 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 		container_of(work, struct sdw_cdns, work);
 	u32 slave0, slave1;
 	u64 slave_intstat;
+	u32 device0_status;
+	int retry_count = 0;
 
 	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
 	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
@@ -968,10 +970,45 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 
 	dev_dbg_ratelimited(cdns->dev, "Slave status change: 0x%llx\n", slave_intstat);
 
+update_status:
 	cdns_update_slave_status(cdns, slave_intstat);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
 
+	/*
+	 * When there is more than one peripheral per link, it's
+	 * possible that a deviceB becomes attached after we deal with
+	 * the attachment of deviceA. Since the hardware does a
+	 * logical AND, the attachment of the second device does not
+	 * change the status seen by the driver.
+	 *
+	 * In that case, clearing the registers above would result in
+	 * the deviceB never being detected - until a change of status
+	 * is observed on the bus.
+	 *
+	 * To avoid this race condition, re-check if any device0 needs
+	 * attention with PING commands. There is no need to check for
+	 * ALERTS since they are not allowed until a non-zero
+	 * device_number is assigned.
+	 */
+
+	device0_status = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+	device0_status &= 3;
+
+	if (device0_status == SDW_SLAVE_ATTACHED) {
+		if (retry_count++ < SDW_MAX_DEVICES) {
+			dev_dbg_ratelimited(cdns->dev,
+					    "Device0 detected after clearing status, iteration %d\n",
+					    retry_count);
+			slave_intstat = CDNS_MCP_SLAVE_INTSTAT_ATTACHED;
+			goto update_status;
+		} else {
+			dev_err_ratelimited(cdns->dev,
+					    "Device0 detected after %d iterations\n",
+					    retry_count);
+		}
+	}
+
 	/* clear and unmask Slave interrupt now */
 	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
 	cdns_updatel(cdns, CDNS_MCP_INTMASK,
-- 
2.17.1

