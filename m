Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA55A104D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiHYMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbiHYMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F6B14CE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P5nj9c003635;
        Thu, 25 Aug 2022 07:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=lrFfeaNaq0qk25xBy3PLt6CJ1MTiZDp2a4Mc7/DICTo=;
 b=ibFyVbbt2GhRhghLUIN3juqWwBmei8RzYMsW06jOJnwJPMWdNYZi68rCYWI/gOiW0akn
 RTuuebA+Jfiy+p7LZeV2bMrhxQchdQ6cWzFbyiF6cD/hF2tlY4BWy2qXEO0Q3DH+80fL
 s8OfXDJNtuPwPz/jk85jv7w07taOcBiKGZwBgO3vXpnlY92SWOgwzieT0fvf1G914rLA
 V4J5cwAUfDW+WPf521p36rtN+p9DMJik8Z8vjHsmEBzknIc7JjLQRpvUsiGBn80ONQlh
 VH7gFwxxTe1wneJUCss0CD99g6dHYBZjpw+zQqOb636JpZ7UxpGWB9dCtN79lI4rOBu+ +w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j4dgmbu3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:43 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 25 Aug
 2022 07:22:41 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 25 Aug 2022 07:22:41 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BCCC0B0E;
        Thu, 25 Aug 2022 12:22:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] soundwire: bus: Fix lost UNATTACH when re-enumerating
Date:   Thu, 25 Aug 2022 13:22:41 +0100
Message-ID: <20220825122241.273090-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825122241.273090-1-rf@opensource.cirrus.com>
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vVYFBcLd_1lRC5qoVfwSSvPy0OCEKWAe
X-Proofpoint-GUID: vVYFBcLd_1lRC5qoVfwSSvPy0OCEKWAe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange sdw_handle_slave_status() so that any peripherals
on device #0 that are given a device ID are reported as
unattached. The ensures that UNATTACH status is not lost.

Handle unenumerated devices first and update the
sdw_slave_status array to indicate IDs that must have become
UNATTACHED.

Look for UNATTACHED devices after this so we can pick up
peripherals that were UNATTACHED in the original PING status
and those that were still ATTACHED at the time of the PING but
then reverted to unenumerated and were found by
sdw_program_device_num().

As sdw_update_slave_status() is always processing a snapshot of
a PING from some time in the past, it is possible that the status
is changing while sdw_update_slave_status() is running.

A peripheral could report attached in the PING, but detach and
revert to device #0 and then be found in the loop in
sdw_program_device_num(). Previously the code would not have
updated slave->status to UNATTACHED because there was never a
PING with that status. If the slave->status is not updated to
UNATTACHED the next PING will report it as ATTACHED, but its
slave->status is already ATTACHED so the re-attach will not be
properly handled.

This situations happens fairly frequently with multiple
peripherals on a bus that are intentionally reset (for example
after downloading firmware).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index bb8ce26c68b3..1212148ac251 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -718,7 +718,8 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 }
 EXPORT_SYMBOL(sdw_extract_slave_id);
 
-static int sdw_program_device_num(struct sdw_bus *bus)
+static int sdw_program_device_num(struct sdw_bus *bus,
+				  enum sdw_slave_status status[])
 {
 	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
 	struct sdw_slave *slave, *_s;
@@ -776,6 +777,12 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 					return ret;
 				}
 
+				/*
+				 * It could have dropped off the bus since the
+				 * PING response so update the status array.
+				 */
+				status[slave->dev_num] = SDW_SLAVE_UNATTACHED;
+
 				break;
 			}
 		}
@@ -1735,10 +1742,21 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
+	bool programmed_dev_num = false;
 	bool attached_initializing;
 	int i, ret = 0;
 
-	/* first check if any Slaves fell off the bus */
+	/* Handle any unenumerated peripherals */
+	if (status[0] == SDW_SLAVE_ATTACHED) {
+		dev_dbg(bus->dev, "Slave attached, programming device number\n");
+		ret = sdw_program_device_num(bus, status);
+		if (ret < 0)
+			dev_warn(bus->dev, "Slave attach failed: %d\n", ret);
+
+		programmed_dev_num = true;
+	}
+
+	/* Check if any fell off the bus */
 	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
 		mutex_lock(&bus->bus_lock);
 		if (test_bit(i, bus->assigned) == false) {
@@ -1764,17 +1782,12 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 		}
 	}
 
-	if (status[0] == SDW_SLAVE_ATTACHED) {
-		dev_dbg(bus->dev, "Slave attached, programming device number\n");
-		ret = sdw_program_device_num(bus);
-		if (ret < 0)
-			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
-		/*
-		 * programming a device number will have side effects,
-		 * so we deal with other devices at a later time
-		 */
-		return ret;
-	}
+	/*
+	 * programming a device number will have side effects,
+	 * so we deal with other devices at a later time
+	 */
+	if (programmed_dev_num)
+		return 0;
 
 	/* Continue to check other slave statuses */
 	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
-- 
2.30.2

