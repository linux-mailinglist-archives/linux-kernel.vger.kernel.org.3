Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12A59D02B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiHWEq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiHWEqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:46:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31053005
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661229978; x=1692765978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ge8z9tQugUy9cTnjB8duw2RGaf7wv9bBNLATuLcW9CY=;
  b=elrrfJM3eZYdgPKBkZRFAh8d2PCPSOReWZhPprKdzbZFqynsCSa2dwbh
   yoXywks9Ib0f6jEcIIf557P9ViwwfwAcBbUQ7E6IhsQSmRJLUAKzr3wZN
   znT1E4r+Qn9dsCsbDdx97K5ijNC4HRRkD/1/X7SN8OdBJWC4rOVGJJeeS
   IU7iTUvpvjk7BIj+cXf5HzXN/SivEwxXJFqxOdKr0npip4UteruxzBi+B
   kJdA8fN3920NFW6nTI2hZsibfWi15Gk6Zqjcz/QJSJhHovJ/eoedhiiT1
   FsEfjVWBpbNxEcYsa3oMg4JAF/6kRlo2IXKU5XmoQKSJamYQ7Tiem6fZj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291146794"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291146794"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="669855099"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: bus: allow device number to be unique at system level
Date:   Tue, 23 Aug 2022 12:50:03 +0800
Message-Id: <20220823045004.2670658-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
References: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire specification allows the device number to be allocated
at will. When a system includes multiple SoundWire links, the device
number scope is limited to the link to which the device is attached.

However, for integration/debug it can be convenient to have a unique
device number across the system. This patch adds a 'dev_num_ida_min'
field at the bus level, which when set will be used to allocate an
IDA.

The allocation happens when a hardware device reports as ATTACHED. If
any error happens during the enumeration, the allocated IDA is not
freed - the device number will be reused if/when the device re-joins
the bus. The IDA is only freed when the Linux device is unregistered.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 23 +++++++++++++++++------
 include/linux/soundwire/sdw.h |  4 ++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 37638c20c804..8970f8560766 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -12,6 +12,7 @@
 #include "sysfs_local.h"
 
 static DEFINE_IDA(sdw_bus_ida);
+static DEFINE_IDA(sdw_peripheral_ida);
 
 static int sdw_get_id(struct sdw_bus *bus)
 {
@@ -157,9 +158,11 @@ static int sdw_delete_slave(struct device *dev, void *data)
 
 	mutex_lock(&bus->bus_lock);
 
-	if (slave->dev_num) /* clear dev_num if assigned */
+	if (slave->dev_num) { /* clear dev_num if assigned */
 		clear_bit(slave->dev_num, bus->assigned);
-
+		if (bus->dev_num_ida_min)
+			ida_free(&sdw_peripheral_ida, slave->dev_num);
+	}
 	list_del_init(&slave->node);
 	mutex_unlock(&bus->bus_lock);
 
@@ -639,10 +642,18 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 {
 	int bit;
 
-	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
-	if (bit == SDW_MAX_DEVICES) {
-		bit = -ENODEV;
-		goto err;
+	if (slave->bus->dev_num_ida_min) {
+		bit = ida_alloc_range(&sdw_peripheral_ida,
+				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
+				      GFP_KERNEL);
+		if (bit < 0)
+			goto err;
+	} else {
+		bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
+		if (bit == SDW_MAX_DEVICES) {
+			bit = -ENODEV;
+			goto err;
+		}
 	}
 
 	/*
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 39058c841469..a2b31d25ea27 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -889,6 +889,9 @@ struct sdw_master_ops {
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
+ * @dev_num_ida_min: if set, defines the minimum values for the IDA
+ * used to allocate system-unique device numbers. This value needs to be
+ * identical across all SoundWire bus in the system.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -913,6 +916,7 @@ struct sdw_bus {
 	u32 bank_switch_timeout;
 	bool multi_link;
 	int hw_sync_min_links;
+	int dev_num_ida_min;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.25.1

