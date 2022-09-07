Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F65AFFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiIGIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiIGIxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:53:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC83A3D77
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:53:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCGH005930;
        Wed, 7 Sep 2022 03:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Pgl4azxf90HlSnGT8l1UNSDlf+sSOeBJVYvFNp1rmXo=;
 b=CJupAH/ps0RJGmKbjqfzN/rUahuP78Azkb28zRDeHZGVSi0n77qXzjfpJMgBaSz2dXJB
 BGkj58HgwyM/3W0084nPJzchTLiGo953iqKnq471pnSryP/vca80xjpjrvvgw9r0TrYx
 hLwETdHByiKcTzqh5+CLtpzoUQ3V2raWkIOc+T4SluiQOoGuDAeBLHfBRy0xFmN2q+pH
 DK+DyEe2aajCEwrQ0DL6/3Peln4WDCZsnJ2jDNrTbPBp/j+5jIaQy/OgURN8FUz2nOeF
 S+WDmj+10qdoMNgtMSvf7DMlm56OlPuyMQF+rh9WwukOQf9enN3xWhZHFNUa1Xa97YFP AQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw21n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 03:53:04 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 03:53:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 03:53:03 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 75F75B06;
        Wed,  7 Sep 2022 08:53:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/5] soundwire: cadence: fix updating slave status when a bus has multiple peripherals
Date:   Wed, 7 Sep 2022 09:52:55 +0100
Message-ID: <20220907085259.3602-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907085259.3602-1-rf@opensource.cirrus.com>
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q76nhonttBlPNPKlQdDNQld2kmrvMoCH
X-Proofpoint-ORIG-GUID: q76nhonttBlPNPKlQdDNQld2kmrvMoCH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 57 +++++++++++++-----------------
 1 file changed, 25 insertions(+), 32 deletions(-)

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
-		}
-
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
-			status[i] = SDW_SLAVE_ATTACHED;
-			set_status++;
-		}
+		if (mask) {
+			is_slave = true;
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
-			status[i] = SDW_SLAVE_ALERT;
-			set_status++;
-		}
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_RESERVED) {
+				status[i] = SDW_SLAVE_RESERVED;
+				set_status++;
+			}
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
-			status[i] = SDW_SLAVE_UNATTACHED;
-			set_status++;
-		}
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
+				status[i] = SDW_SLAVE_ATTACHED;
+				set_status++;
+			}
 
-		/* first check if Slave reported multiple status */
-		if (set_status > 1) {
-			u32 val;
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
+				status[i] = SDW_SLAVE_ALERT;
+				set_status++;
+			}
 
-			dev_warn_ratelimited(cdns->dev,
-					     "Slave %d reported multiple Status: %d\n",
-					     i, mask);
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
+				status[i] = SDW_SLAVE_UNATTACHED;
+				set_status++;
+			}
+		}
 
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

