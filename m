Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA75740DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGNBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiGNBK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:10:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA5201A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657761057; x=1689297057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1J5nWNOz+sncSR+Y9wqNIrStrFxV1lay+BampiPlQo=;
  b=axdpw0YJZ66SQBZnuizFKHJ5NSJwrZZvYvsoPeXCOny5RcY3ezBbS40I
   LenI98fHSP5d44z8Kaypw1D4oMJq0PWQqJgRmLv6aU/oA9f+REvjcQIQs
   8kIxcT4aTuIZHjkyOzwlxZ2yg2qNnvmCGe2gYbuuyKAKBGC1kMWvRPSmW
   s/grbOMseYh//HWvtOQuOLl/Q8QNiRxKMyeaCl+m/EWyO8GgM7uKSjnnk
   UqfN+deqn5U3IpJIfkUalEvJXOBrP4DAqJlnjqjNGxGGlopwheGW+aO2f
   PhmVCo4X75ARK1uHno7wZXNoipe4fULMg4rTxgZOinMNhgau2eygE9QWt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282937922"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282937922"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593192532"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:55 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: add sdw_show_ping_status() helper
Date:   Thu, 14 Jul 2022 09:10:42 +0800
Message-Id: <20220714011043.46059-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This helper provides an optional delay parameter to wait for devices
to resync in case of errors, and checks that devices are indeed
attached on the bus.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 2772973eebb1..0a99ac791c7e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -300,6 +300,38 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 	return ret;
 }
 
+/**
+ * sdw_show_ping_status() - Direct report of PING status, to be used by Peripheral drivers
+ * @bus: SDW bus
+ * @sync_delay: Delay before reading status
+ */
+void sdw_show_ping_status(struct sdw_bus *bus, bool sync_delay)
+{
+	u32 status;
+
+	if (!bus->ops->read_ping_status)
+		return;
+
+	/*
+	 * wait for peripheral to sync if desired. 10-15ms should be more than
+	 * enough in most cases.
+	 */
+	if (sync_delay)
+		usleep_range(10000, 15000);
+
+	mutex_lock(&bus->msg_lock);
+
+	status = bus->ops->read_ping_status(bus);
+
+	mutex_unlock(&bus->msg_lock);
+
+	if (!status)
+		dev_warn(bus->dev, "%s: no peripherals attached\n", __func__);
+	else
+		dev_dbg(bus->dev, "PING status: %#x\n", status);
+}
+EXPORT_SYMBOL(sdw_show_ping_status);
+
 /**
  * sdw_transfer_defer() - Asynchronously transfer message to a SDW Slave device
  * @bus: SDW bus
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a85cf829bb77..9e4537f409c2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -926,6 +926,8 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 		       struct fwnode_handle *fwnode);
 void sdw_bus_master_delete(struct sdw_bus *bus);
 
+void sdw_show_ping_status(struct sdw_bus *bus, bool sync_delay);
+
 /**
  * sdw_port_config: Master or Slave Port configuration
  *
-- 
2.25.1

