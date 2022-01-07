Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA9487D65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiAGT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:58:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36536 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233643AbiAGT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:58:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207Fo27W008191;
        Fri, 7 Jan 2022 13:58:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=iAIOic3fs3DHgtceBaD28ld8RhX+XmG05O99KFICyHU=;
 b=XPWqkznJBIRRv+0nGKG99jyGmAhHuZz25lvG1mbkdTli0NT/f9av32Hzh/UBhG+N70vi
 vMW1FdKzEwOWId7wOLTlcz+RZRas0YdmiPCCS3x1lS59n7CPv5pFL1l8c/ZyBxwXKA0k
 +0ZF1/W9ZKuKBZ7a2UtpIf+e+JCTzkTtAH72QB+xrJIpJ/i8WgFF7KZG6IgTo1Xnk6hy
 Ka74CiIMmVatEwHdxLMVMpOLKDGiRNeP5QHwvi5baS6jUDXMe58b+E1/78svbb/8tvjD
 iojPFPJstGaaXScW6CyjlhZHPnKLI2kWHFzhzSZ7GRFX+SlQ6DHDtQ23vmrsHXiWafEc qA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dergng88j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Jan 2022 13:58:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 19:58:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 7 Jan 2022 19:58:23 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B1B322A9;
        Fri,  7 Jan 2022 19:58:22 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v2 2/2] power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS
Date:   Fri, 7 Jan 2022 13:58:06 -0600
Message-ID: <20220107195806.100956-3-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
References: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RxiIQ-00gsJ3Jt_9PZaV9c8XlGmn6LfY
X-Proofpoint-ORIG-GUID: RxiIQ-00gsJ3Jt_9PZaV9c8XlGmn6LfY
X-Proofpoint-Spam-Reason: safe
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

