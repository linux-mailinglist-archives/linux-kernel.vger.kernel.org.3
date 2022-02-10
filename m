Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A494B12B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiBJQ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:26:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiBJQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:26:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2DC26;
        Thu, 10 Feb 2022 08:26:11 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AEBMiL025584;
        Thu, 10 Feb 2022 09:41:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=iAIOic3fs3DHgtceBaD28ld8RhX+XmG05O99KFICyHU=;
 b=OPz9mg1lCGDZFcdrjNWJ1hjxWGEdoO1jB+ngD8AWBqiUWuBULOfNxyhbtIl1s1bRC+nE
 WUDLJ+HsoQkkmvaO36rYOsztpW7kGyiDfTMtD8INGF1z8RlZlffHA+jeLN6xLvbRKwFh
 n44n9bI/jQ0dNoYlV2Md7EJIaZ5TtHgctrcwYSf6ICy8tue/hZ7o67P11En6yDEvrbHf
 4nYHzGr6NDRrfIRffHjJGE5Q646xsPaSr/Z099XvqFKynhUZvGSt1/Kqr1iDdAV4TZzT
 7X0SotbkfJPF7NEaT0/Je3rlImax2cNFpOAN2rktjeVbfZF10boLWI/zwSrY/jPVvi+p wg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e4detskyx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 09:41:21 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 15:41:20 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 10 Feb 2022 15:41:20 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 10A532A1;
        Thu, 10 Feb 2022 15:41:19 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [RESEND v2 2/2] power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS
Date:   Thu, 10 Feb 2022 09:41:08 -0600
Message-ID: <20220210154108.641369-3-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: feDhXOyhHV27GLGeJJQd63wmvEu18Zvo
X-Proofpoint-ORIG-GUID: feDhXOyhHV27GLGeJJQd63wmvEu18Zvo
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remaps the bypass operation from POWER_SUPPLY_CHARGE_TYPE_FAST
to POWER_SUPPLY_CHARGE_TYPE_BYPASS.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 drivers/power/supply/bq25980_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 9daa6d14db4d..9339f5649282 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -764,7 +764,7 @@ static int bq25980_get_charger_property(struct power_supply *psy,
 		if (!state.ce)
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		else if (state.bypass)
-			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_BYPASS;
 		else if (!state.bypass)
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 		break;
-- 
2.25.1

