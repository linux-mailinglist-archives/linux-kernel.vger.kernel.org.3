Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0C487D63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiAGT61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:58:27 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:11236 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232217AbiAGT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:58:26 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207Fo27V008191;
        Fri, 7 Jan 2022 13:58:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZcE6+fIEhouQflq6SsdYNwRtkbBAzXLAZhmoezOqjSU=;
 b=RlejFORZ7J3XxJb1dGzlxucpDW8KW+3N4m2u0ICJvy7e+k7RMBIdYH2EOyhGwv2GGQPQ
 sg4oQuKqnrSs6YiziGgqNllWcTowjyy4wJ927KinznYDrUFu48F+MjrZjzcXdZnhzTIP
 epRo4bZCALDDiMLLxlLc6jKIfojLjT7JmDeEoV0WUZEs9iOw0I5ztrMM6RCvD+PQw+Gc
 ymkL7DGLlhamN5m43O9ifaZ2SSLjIT8Gc9HWwuOId95KS9Yr1YgTDeFM9gurwOfCv0Hp
 /cE8L1IhY6mFkb2wNGuKNZ1WQDibAa3Z8xtvxvi706iTFNdpUsVpNJYtB5KqF07HXoPC lQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dergng88j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Jan 2022 13:58:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 19:58:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 7 Jan 2022 19:58:22 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 92D6B2A9;
        Fri,  7 Jan 2022 19:58:21 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v2 1/2] power: supply: Introduces bypass charging property
Date:   Fri, 7 Jan 2022 13:58:05 -0600
Message-ID: <20220107195806.100956-2-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
References: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Nr7gaWx5kCf2MvR99VsFb00hGDR_Qh-K
X-Proofpoint-ORIG-GUID: Nr7gaWx5kCf2MvR99VsFb00hGDR_Qh-K
X-Proofpoint-Spam-Reason: safe
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

