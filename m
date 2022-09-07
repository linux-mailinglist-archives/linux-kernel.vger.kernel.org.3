Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C65AFFAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiIGIxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIGIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:53:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE7B0899
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:53:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2876sQ6A005118;
        Wed, 7 Sep 2022 03:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NO/TgnBOshihnILAwvDzrDcQ8BeiAeimcDuScgp8AQA=;
 b=nnbIaFh34OpFDgKNJWuE1MQRaxytPRVlBUprlW+OAjke9rM0G5ARuxrKEBxJb/GGv3R1
 36XrT3XTf+d7bc4FMjxfelh+N30hGeAl7AOk5g2hZZfh/2uP8Y1XiHE92tGYNUS09eiT
 5Nqu99NbSSuh6DnHMT9/KhqCWcNfxN5jWP3p034ISdrB5veGdAsDNLGWFIGyqdB7Juvg
 7K6VpW8os0w2/lyTsTbF/+SeySjcc6k+0cJMKiCXDQNB7X8k8AS9bwtui69dp59AEybF
 mp17v3QEUC1O54r37+eQj5XZKamPeFmZ+g3zEZ64WU8+FJZJYiX+ODJw9TtRQdJ7P13b nQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jc4b2dcun-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 03:53:07 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 03:53:05 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 03:53:05 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 18286B10;
        Wed,  7 Sep 2022 08:53:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 5/5] soundwire: bus: Don't exit early if no device IDs were programmed
Date:   Wed, 7 Sep 2022 09:52:59 +0100
Message-ID: <20220907085259.3602-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907085259.3602-1-rf@opensource.cirrus.com>
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UQJ2C3Z2WExUYeJlSVo1G2mAbdA1IZED
X-Proofpoint-ORIG-GUID: UQJ2C3Z2WExUYeJlSVo1G2mAbdA1IZED
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only exit sdw_handle_slave_status() right after calling
sdw_program_device_num() if it actually programmed an ID into at
least one device.

sdw_handle_slave_status() should protect itself against phantom
device #0 ATTACHED indications. In that case there is no actual
device still on #0. The early exit relies on there being a status
change to ATTACHED on the reprogrammed device to trigger another
call to sdw_handle_slave_status() which will then handle the status
of all peripherals. If no device was actually programmed with an
ID there won't be a new ATTACHED indication. This can lead to the
status of other peripherals not being handled.

The status passed to sdw_handle_slave_status() is obviously always
from a point of time in the past, and may indicate accumulated
unhandled events (depending how the bus manager operates). It's
possible that a device ID is reprogrammed but the last PING status
captured state just before that, when it was still reporting on
ID #0. Then sdw_handle_slave_status() is called with this PING info,
just before a new PING status is available showing it now on its new
ID. So sdw_handle_slave_status() will receive a phantom report of a
device on #0, but it will not find one.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6e569a875a9b..0bcc2d161eb9 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -736,20 +736,19 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	struct sdw_slave_id id;
 	struct sdw_msg msg;
 	bool found;
-	int count = 0, ret;
+	int count = 0, num_programmed = 0, ret;
 	u64 addr;
 
 	/* No Slave, so use raw xfer api */
 	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
 			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	do {
 		ret = sdw_transfer(bus, &msg);
 		if (ret == -ENODATA) { /* end of device id reads */
 			dev_dbg(bus->dev, "No more devices to enumerate\n");
-			ret = 0;
 			break;
 		}
 		if (ret < 0) {
@@ -781,7 +780,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 				 * assigned a device ID.
 				 */
 				if (slave->status != SDW_SLAVE_UNATTACHED)
-					return 0;
+					return num_programmed;
 
 				/*
 				 * Assign a new dev_num to this Slave and
@@ -794,9 +793,11 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 					dev_err(bus->dev,
 						"Assign dev_num failed:%d\n",
 						ret);
-					return ret;
+					return num_programmed;
 				}
 
+				++num_programmed;
+
 				break;
 			}
 		}
@@ -825,7 +826,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 
 	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));
 
-	return ret;
+	return num_programmed;
 }
 
 static void sdw_modify_slave_status(struct sdw_slave *slave,
@@ -1787,14 +1788,16 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 	if (status[0] == SDW_SLAVE_ATTACHED) {
 		dev_dbg(bus->dev, "Slave attached, programming device number\n");
-		ret = sdw_program_device_num(bus);
-		if (ret < 0)
-			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
+
 		/*
-		 * programming a device number will have side effects,
-		 * so we deal with other devices at a later time
+		 * Programming a device number will have side effects,
+		 * so we deal with other devices at a later time.
+		 * But only if any devices were reprogrammed, because
+		 * this relies on its PING state changing to ATTACHED,
+		 * triggering a status change.
 		 */
-		return ret;
+		if (sdw_program_device_num(bus))
+			return 0;
 	}
 
 	/* Continue to check other slave statuses */
-- 
2.30.2

