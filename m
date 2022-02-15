Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD794B5ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiBOAIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:08:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiBOAIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:08:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1617797BAC;
        Mon, 14 Feb 2022 16:08:26 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ED8OWX007514;
        Mon, 14 Feb 2022 18:08:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=O8T/YqduycuFSaC3l7VKvTNlSLrGHSoXe+0Lz9rd/4o=;
 b=ds/RDGgv+cEYogB6ecuJXgGskbzRQ36QeXx1GalA+A1MisgtVYXwWZx1j2Q2P0+q+f3P
 lwsg0F383TUEuS9TTH8t4NturUskd2FehB9FzlyiXzA8pzOH8O01RlhRF/rhcm1v77OP
 6keSQD5h9EwGm/lX5YsIvD90rPyKF3Zy4rKfX/p4JWroUAoS2WqYIT/MwN+F+HFau15n
 dqWQa0T7X8+431jZxbuLm6fALFKnpxt1Ap+e4BC+Kjyia394iAPtXK+hnnRsvWjnl/WN
 IHbv7AB5E0GgLeFHLOlfgTiZv/W0bUppP+Xq/N4OgwWU106vqT0vZtOFGR16gssZ3ql+ +Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e7qq18nh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 18:08:17 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 00:08:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 00:08:15 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F2E1FB16;
        Tue, 15 Feb 2022 00:08:14 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v3 1/3] power: supply: Introduces bypass charging property
Date:   Mon, 14 Feb 2022 18:07:56 -0600
Message-ID: <20220215000758.803501-2-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
References: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fgYY-myAEmJ9d6AMNAbrolTDl10Knhq6
X-Proofpoint-GUID: fgYY-myAEmJ9d6AMNAbrolTDl10Knhq6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the POWER_SUPPLY_PROP_CHARGE_TYPE
property to facilitate bypass charging operation.

In bypass charging operation, the charger bypasses the charging path around the
integrated converter allowing for a "smart" wall adaptor to perform the power
conversion externally.

This operational mode is critical for the USB PPS standard of power adaptors and is
becoming a common feature in modern charging ICs such as:

- BQ25980
- BQ25975
- BQ25960
- LN8000
- LN8410

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 Documentation/ABI/testing/sysfs-class-power | 7 +++++--
 drivers/power/supply/power_supply_sysfs.c   | 1 +
 include/linux/power_supply.h                | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f7904efc4cfa..8e3bf1aa6268 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -380,13 +380,16 @@ Description:
 		algorithm to adjust the charge rate dynamically, without
 		any user configuration required. "Custom" means that the charger
 		uses the charge_control_* properties as configuration for some
-		different algorithm.
+		different algorithm. "Bypass" means the charger bypasses the
+		charging path around the integrated converter allowing for a
+		"smart" wall adaptor to perform the power conversion
+		externally.
 
 		Access: Read, Write
 
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
-			      "Adaptive", "Custom"
+			      "Adaptive", "Custom", "Bypass"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..1368e13dc94b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -89,6 +89,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
 	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
 	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
 	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
+	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	= "Bypass",
 };
 
 static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..9432234d7900 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -49,6 +49,7 @@ enum {
 	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
 	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
 	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
+	POWER_SUPPLY_CHARGE_TYPE_BYPASS,	/* bypassing the charger */
 };
 
 enum {
-- 
2.25.1

