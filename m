Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086E447CE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbhLVIl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:41:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40899 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243406AbhLVIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640162514; x=1671698514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=p+xWYQPTAEBWSuFHfW96WbKqkMRMHsg40kv5ZRc8S20=;
  b=Omg0NH/nuKZLRqDWBkYoA2cMUiBVRO3F+6cmmN//vWsLTLgj/3uS7jUH
   Opoov7xjpjD+UNZ/P0kxwn7So8EZHZIg3DT/Tgt7VTB3T3CBhYZZ3F+9K
   iPIet+YXAv13pqHDvLIRt4zLZzmMBClpj6Ss/BR58dHhhHtILzrJBEmxz
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Dec 2021 00:41:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 00:41:53 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 00:41:53 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 22 Dec
 2021 00:41:51 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "thara . gopinath @ linaro . org" <thara.gopinath@linaro.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v4 2/2] power_supply: Use of-thermal cdev registration API
Date:   Wed, 22 Dec 2021 14:11:29 +0530
Message-ID: <1640162489-7847-2-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640162489-7847-1-git-send-email-quic_manafm@quicinc.com>
References: <1640162489-7847-1-git-send-email-quic_manafm@quicinc.com>
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
 drivers/power/supply/power_supply_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ef6f290..f42031c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1134,9 +1134,15 @@ static int psy_register_cooler(struct power_supply *psy)
 	for (i = 0; i < psy->desc->num_properties; i++) {
 		if (psy->desc->properties[i] ==
 				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
-			psy->tcd = thermal_cooling_device_register(
-							(char *)psy->desc->name,
-							psy, &psy_tcd_ops);
+			if (psy->dev.parent)
+				psy->tcd = thermal_of_cooling_device_register(
+						dev_of_node(psy->dev.parent),
+						(char *)psy->desc->name,
+						psy, &psy_tcd_ops);
+			else
+				psy->tcd = thermal_cooling_device_register(
+						(char *)psy->desc->name,
+						psy, &psy_tcd_ops);
 			return PTR_ERR_OR_ZERO(psy->tcd);
 		}
 	}

