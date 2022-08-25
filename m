Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB545A104E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiHYMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiHYMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C24FB14CC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P5j0L7027893;
        Thu, 25 Aug 2022 07:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=qM/4I4xQgYXa3nyrRPcPpQ8yR5SdWsQYKAd17M1tkEg=;
 b=piPYpx05qSWjLqY5CZUkX5Tp6LkOqZU0nNQgUBiYKYysU9R2QF2e5lyoqZt8uvzjp8/f
 BY3ujyAqY1ksRfVH3sNRsdxTRSnMNULoHJRkA3dGzv7ExWMf1/ZSlv2AQLcSxAEOS2KG
 QPf2/VLKjTeW5rPCWeIDxg40JlyS4oQtogI4/97rxnwCqvcvKb02olNv5YphmuOV/9v8
 SrSBvzZRb2DCgV5y6n3v6ulC0jz+I6m2Zr3jkNgUP24GYzzI75Pnhr8dTWItDXMRKVgk
 LXelENXRgpesPKDChwrb24+Bd2+v+mFsV3X/YrMeb044kAchiQniGQ2uIqJUOrRh9lC5 sg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j4dgmbu3q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:44 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 25 Aug
 2022 07:22:41 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 25 Aug 2022 07:22:41 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 97D7BB10;
        Thu, 25 Aug 2022 12:22:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] soundwire: cadence: fix updating slave status when a bus has multiple peripherals
Date:   Thu, 25 Aug 2022 13:22:39 +0100
Message-ID: <20220825122241.273090-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825122241.273090-1-rf@opensource.cirrus.com>
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qQlJqhbI9BKDInlrStq1RBsORrO6ZASc
X-Proofpoint-GUID: qQlJqhbI9BKDInlrStq1RBsORrO6ZASc
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

From: Simon Trimmer <simont@opensource.cirrus.com>

The cadence IP explicitly reports slave status changes with bits for
each possible change. The function cdns_update_slave_status() attempts
to translate this into the current status of each of the slaves.

However when there are multiple peripherals on a bus any slave that did
not have a status change when the work function ran would not have it's
status updated - the array is initialised to a value that equates to
UNATTACHED and this can cause spurious reports that slaves had dropped
off the bus.

In the case where a slave has no status change or has multiple status
changes the value from the last PING command is used.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 63 +++++++++++++-----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4fbb19557f5e..245191d22ccd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -782,6 +782,7 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
 	u32 mask;
+	u32 val;
 	int i, set_status;
 
 	memset(status, 0, sizeof(status));
@@ -789,41 +790,38 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
 		mask = (slave_intstat >> (i * CDNS_MCP_SLAVE_STATUS_NUM)) &
 			CDNS_MCP_SLAVE_STATUS_BITS;
-		if (!mask)
-			continue;
 
-		is_slave = true;
 		set_status = 0;
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_RESERVED) {
-			status[i] = SDW_SLAVE_RESERVED;
-			set_status++;
+		if (mask) {
+			is_slave = true;
+
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_RESERVED) {
+				status[i] = SDW_SLAVE_RESERVED;
+				set_status++;
+			}
+
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
+				status[i] = SDW_SLAVE_ATTACHED;
+				set_status++;
+			}
+
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
+				status[i] = SDW_SLAVE_ALERT;
+				set_status++;
+			}
+
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
+				status[i] = SDW_SLAVE_UNATTACHED;
+				set_status++;
+			}
 		}
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
-			status[i] = SDW_SLAVE_ATTACHED;
-			set_status++;
-		}
-
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
-			status[i] = SDW_SLAVE_ALERT;
-			set_status++;
-		}
-
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
-			status[i] = SDW_SLAVE_UNATTACHED;
-			set_status++;
-		}
-
-		/* first check if Slave reported multiple status */
-		if (set_status > 1) {
-			u32 val;
-
-			dev_warn_ratelimited(cdns->dev,
-					     "Slave %d reported multiple Status: %d\n",
-					     i, mask);
-
-			/* check latest status extracted from PING commands */
+		/*
+		 * check that there was a single reported Slave status and when
+		 * there is not use the latest status extracted from PING commands
+		 */
+		if (set_status != 1) {
 			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
 			val >>= (i * 2);
 
@@ -842,11 +840,6 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 				status[i] = SDW_SLAVE_RESERVED;
 				break;
 			}
-
-			dev_warn_ratelimited(cdns->dev,
-					     "Slave %d status updated to %d\n",
-					     i, status[i]);
-
 		}
 	}
 
-- 
2.30.2

