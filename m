Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7E5A5D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiH3HiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiH3HiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:38:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B401BA15E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661845070; x=1693381070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4146rQbNgpJKmVBNz3ybM+Hn/wyGiAEsiucLmRjbNWI=;
  b=hXSXDo0zxr8FQjTsgXbgW4ccI4lN4Hf6kAdVtNcXgtuT6iu1UYZzpYno
   3GHj0Lm9nC+8CG0EsH7OBhxUVyOkHG+6dlKaPvq5sts2U6Flw+jJwdQJ8
   WZsMTwcaBPNeKcZP0lOLHPRALgGBqzzaymkw8xX9VJyBCtCYVmXBsjsaz
   1FpfrThFlgm40HMx/rnN9qLGgYgmFLcUCq2KFqQAeZUBzYCamw+pEl+u6
   K+6A3xm2wVZ1VpfuNP3gpw4EPS8e5KgtcSzh4GYSZpsxqxN8YGqKW0Oy3
   4HfQxpJopSvfieMwxdILnnZ1Fs0QrLTzDzzVXEjsVxEDsY+/hMHGqJzby
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282078621"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282078621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:37:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672734380"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:37:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: bus: conditionally recheck UNATTACHED status
Date:   Tue, 30 Aug 2022 15:42:24 +0800
Message-Id: <20220830074224.2924179-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

In configurations with two amplifiers on the same link, the Intel CI
reports occasional enumeration/initialization timeouts during
suspend-resume stress tests, where one of the two amplifiers becomes
UNATTACHED immediately after being enumerated. This problem was
reported both with Maxim and Realtek codecs, which pointed initially
to a problem with status handling on the Intel side.

The Cadence IP integrated on Intel platforms throws an interrupt when
the status changes, and the information is kept with sticky bits until
cleared. We initially added more checks to make sure the edge
detection did not miss any transition, but that did not improve the
results significantly.

With the recent addition of the read_ping_status() callback, we were
able to show that the status in sticky bits is shown as UNATTACHED
even though the PING frames show the problematic device as
ATTACHED. That completely breaks the entire logic where we assumed
that a peripheral would always re-attach as device0. The resume
timeouts make sense in that in those cases, the
enumeration/initialization never happens a second time.

One possible explanation is that this problem typically happens when a
bus clash is reported, so it could very well be that the detection is
fooled by a transient electrical issue or conflict between two
peripherals.

This patch conditionally double-checks the status reported in the
sticky bits with the actual PING frame status. If the peripheral
reports as attached in PING frames, the early detection based on
sticky bits is discarded.

Note that this patch only corrects issues of false positives on the
manager side.

If the peripheral lost and regain sync, then it would report as
attached on Device0. A peripheral that would not reset its dev_num
would not be compliant with the MIPI specification.

BugLink: https://github.com/thesofproject/linux/issues/3638
BugLink: https://github.com/thesofproject/linux/issues/3325
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
Hi Vinod,

You will need the "ASoC/soundwire: log actual PING status on resume issues"
series which is applied at ASoC tree before appling this patch.

---
 drivers/soundwire/bus.c       | 19 +++++++++++++++++++
 drivers/soundwire/intel.c     |  1 +
 include/linux/soundwire/sdw.h |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 2772973eebb1..d0d486f07673 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1767,6 +1767,25 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		    slave->status != SDW_SLAVE_UNATTACHED) {
 			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
 				 i, slave->status);
+
+			if (bus->recheck_unattached && bus->ops->read_ping_status) {
+				u32 ping_status;
+
+				mutex_lock(&bus->msg_lock);
+
+				ping_status = bus->ops->read_ping_status(bus);
+
+				mutex_unlock(&bus->msg_lock);
+
+				ping_status >>= (i * 2);
+				ping_status &= 0x3;
+
+				if (ping_status != 0) {
+					dev_warn(&slave->dev, "Slave %d state in PING frame is %d, ignoring earlier detection\n",
+						 i, ping_status);
+					continue;
+				}
+			}
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 		}
 	}
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 25ec9c272239..0c6e674dbf85 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1311,6 +1311,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 
 	bus->link_id = auxdev->id;
 	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
+	bus->recheck_unattached = true;
 
 	sdw_cdns_probe(cdns);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a2b31d25ea27..51ac71984260 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -892,6 +892,8 @@ struct sdw_master_ops {
  * @dev_num_ida_min: if set, defines the minimum values for the IDA
  * used to allocate system-unique device numbers. This value needs to be
  * identical across all SoundWire bus in the system.
+ * @recheck_unattached: if set, double-check UNATTACHED status changes
+ * by reading PING frame status.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -917,6 +919,7 @@ struct sdw_bus {
 	bool multi_link;
 	int hw_sync_min_links;
 	int dev_num_ida_min;
+	bool recheck_unattached;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.25.1

