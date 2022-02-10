Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADB4B126E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiBJQML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:12:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiBJQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:12:10 -0500
X-Greylist: delayed 1842 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 08:12:11 PST
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF340EB;
        Thu, 10 Feb 2022 08:12:11 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AEBMiK025584;
        Thu, 10 Feb 2022 09:41:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZcE6+fIEhouQflq6SsdYNwRtkbBAzXLAZhmoezOqjSU=;
 b=IlCoODTBMzey/Sj5wVEjA1csXujawVmllHw9glGsfo0i7WUSqNldfupDrQYKEg3hCof0
 x8II4XGesbT+TGgJyIZzDhZ/LAbT4tqP7MmQXpiQNRVCasWZfQgsgHUr5LdyF8v8p80X
 AzStJzdSoaC6LM43HAqU4pmIP88gFMKXHZLduYqanhBocWaS+An7+/uJs7lmVUMygdpl
 GZfWjU+mbOyMVA+0X2693baBJNdObpjiLqSt4QUmnBC5t+euWsxIq48WUP7yvR7u0Uad
 to7xjxb1Jg1Q2cnhWGV58qShodp+hXo+5j/QoGyiDVA3pjU3y47FiflMttroAqpadRVW IQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e4detskyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 09:41:21 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 15:41:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 10 Feb 2022 15:41:19 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E66312A1;
        Thu, 10 Feb 2022 15:41:18 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [RESEND v2 1/2] power: supply: Introduces bypass charging property
Date:   Thu, 10 Feb 2022 09:41:07 -0600
Message-ID: <20220210154108.641369-2-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EHQHKr75_rbswWjslGMUEHJFsMAt3tYY
X-Proofpoint-ORIG-GUID: EHQHKr75_rbswWjslGMUEHJFsMAt3tYY
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
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 6ac88fbee3cb..52c909bae457 100644
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
index 86b4d5c4dab9..164779bc7e8f 100644
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

