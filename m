Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE447B321
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbhLTSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:47:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:15774 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240549AbhLTSq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640026018; x=1671562018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jreNBd8GL2W+jK2Fl5aTVEo3XpGVC3QzJVR2KmJIGtg=;
  b=G71PNWbFXVsGqxWdXxaUERwqaKhdDGU2nEsBkhRiNdx/iWCU2viRn2jy
   hJ+E0D8478OkLngPKVhLGbMnB/O3vP1aycTfMRmeP3rc2+Jt2L/00tA1y
   Vt/ib/TfrFp0dTK5Z8cjt5Yd56SmVO3/QKoIx7Y4ZHh7b7wilgZ3rAuUo
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Dec 2021 10:46:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 10:46:55 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 10:46:54 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 10:46:51 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "thara . gopinath @ linaro . org" <thara.gopinath@linaro.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v3 2/2] power_supply: Use of-thermal cdev registration API
Date:   Tue, 21 Dec 2021 00:16:28 +0530
Message-ID: <1640025988-20754-2-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640025988-20754-1-git-send-email-quic_manafm@quicinc.com>
References: <1640025988-20754-1-git-send-email-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With thermal frameworks of-thermal interface, thermal zone parameters can
be defined in devicetree. This includes cooling device mitigation levels
for a thermal zone. To take advantage of this, cooling device should use
the thermal_of_cooling_device_register API to register a cooling device.

Use thermal_of_cooling_device_register API to register the power supply
cooling device. This enables power supply cooling device be included in the
thermal zone parameter in devicetree.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/power/supply/power_supply_core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ea3e75e..800b8a3 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -132,7 +132,7 @@ void power_supply_changed(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_changed);
 
-static int psy_register_cooler(struct power_supply *psy);
+static int psy_register_cooler(struct device *dev, struct power_supply *psy);
 /*
  * Notify that power supply was registered after parent finished the probing.
  *
@@ -159,7 +159,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 	}
 
 	power_supply_changed(psy);
-	psy_register_cooler(psy);
+	psy_register_cooler(psy->dev.parent, psy);
 
 	if (psy->dev.parent)
 		mutex_unlock(&psy->dev.parent->mutex);
@@ -1145,7 +1145,7 @@ static const struct thermal_cooling_device_ops psy_tcd_ops = {
 	.set_cur_state = ps_set_cur_charge_cntl_limit,
 };
 
-static int psy_register_cooler(struct power_supply *psy)
+static int psy_register_cooler(struct device *dev, struct power_supply *psy)
 {
 	int i;
 
@@ -1153,7 +1153,13 @@ static int psy_register_cooler(struct power_supply *psy)
 	for (i = 0; i < psy->desc->num_properties; i++) {
 		if (psy->desc->properties[i] ==
 				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
-			psy->tcd = thermal_cooling_device_register(
+			if (dev)
+				psy->tcd = thermal_of_cooling_device_register(
+							dev_of_node(dev),
+							(char *)psy->desc->name,
+							psy, &psy_tcd_ops);
+			else
+				psy->tcd = thermal_cooling_device_register(
 							(char *)psy->desc->name,
 							psy, &psy_tcd_ops);
 			return PTR_ERR_OR_ZERO(psy->tcd);
@@ -1178,7 +1184,7 @@ static void psy_unregister_thermal(struct power_supply *psy)
 {
 }
 
-static int psy_register_cooler(struct power_supply *psy)
+static int psy_register_cooler(struct device *dev, struct power_supply *psy)
 {
 	return 0;
 }
