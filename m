Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE747B31E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhLTSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:46:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:1620 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhLTSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640026010; x=1671562010;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JCS9rNTJrHOV1HM7f5tTJKz8qdR33j8X2+1T8JtpTrc=;
  b=a+Yb8mXArZ91rNzYaJZF4FyC7hrqhgv9iCEAH2EPuLVQ8WbvZ1eaapec
   +A4nxT0tP0YmN2vN4BVVOtXkwlND4GhCUUU1VEfVkOYnYdH3+FZJqkrnR
   k5pdvzMGg6a86jhKDVF3W1UIerHIihBmpvHrLASCt7R8F/dnn+XMiBf6k
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Dec 2021 10:46:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 10:46:49 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 10:46:49 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 10:46:46 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "thara . gopinath @ linaro . org" <thara.gopinath@linaro.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v3 1/2] power_supply: Register cooling device outside of probe
Date:   Tue, 21 Dec 2021 00:16:27 +0530
Message-ID: <1640025988-20754-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registering the cooling device from the probe can result in the
execution of get_property() function before it gets initialized.

To avoid this, register the cooling device from a workqueue
instead of registering in the probe.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/power/supply/power_supply_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 10a357a..ea3e75e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -132,6 +132,7 @@ void power_supply_changed(struct power_supply *psy)
 }
 EXPORT_SYMBOL_GPL(power_supply_changed);
 
+static int psy_register_cooler(struct power_supply *psy);
 /*
  * Notify that power supply was registered after parent finished the probing.
  *
@@ -139,6 +140,8 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
  * calling power_supply_changed() directly from power_supply_register()
  * would lead to execution of get_property() function provided by the driver
  * too early - before the probe ends.
+ * Also, registering cooling device from the probe will execute the
+ * get_property() function. So register the cooling device after the probe.
  *
  * Avoid that by waiting on parent's mutex.
  */
@@ -156,6 +159,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 	}
 
 	power_supply_changed(psy);
+	psy_register_cooler(psy);
 
 	if (psy->dev.parent)
 		mutex_unlock(&psy->dev.parent->mutex);
@@ -1257,10 +1261,6 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	rc = psy_register_cooler(psy);
-	if (rc)
-		goto register_cooler_failed;
-
 	rc = power_supply_create_triggers(psy);
 	if (rc)
 		goto create_triggers_failed;
@@ -1290,8 +1290,6 @@ __power_supply_register(struct device *parent,
 add_hwmon_sysfs_failed:
 	power_supply_remove_triggers(psy);
 create_triggers_failed:
-	psy_unregister_cooler(psy);
-register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 	device_del(dev);

