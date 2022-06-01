Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4557C53A5B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353146AbiFANOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbiFANOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:14:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C923CA46;
        Wed,  1 Jun 2022 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654089267; x=1685625267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=thV3dq7IP3pZFJ/eKrgaz8exm55qhJj7BG42P4ZLFS4=;
  b=g8vqqojOIhfpgb6zTUBNH4QKI4yuyNwJ8Kh8qe2dab1QdXukEP1+ipPT
   524lEDQsgfXPgLEsczpCCwtvvijBKQ7cdlwGoKZsVBnrtnen3MJV9bQis
   AQoviHkYFntPSGysOLdm6SNPPibOjvsSOaeDHi8mBxjViiR8fldZDP/RX
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 06:14:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:14:27 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 06:14:27 -0700
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 06:14:24 -0700
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH 1/1] drivers/thermal/thermal_of: Add critical/hot ops support for thermal_of sensor
Date:   Wed, 1 Jun 2022 18:44:00 +0530
Message-ID: <20220601131400.24627-2-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220601131400.24627-1-quic_manafm@quicinc.com>
References: <20220601131400.24627-1-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sensor driver which register through thermal_of interface doesn't
have an option to get thermal zone critical, hot trip violation
notification from thermal core.

Add support for these ops in thermal_of interface so that sensor
driver can use these ops.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/thermal_of.c | 21 +++++++++++++++++++++
 include/linux/thermal.h      |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b65d435cb92f..65e1848cb1dd 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -211,6 +211,20 @@ static int of_thermal_change_mode(struct thermal_zone_device *tz,
 	return data->ops->change_mode(data->sensor_data, mode);
 }
 
+static void of_thermal_hot_notify(struct thermal_zone_device *tz)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	data->ops->hot(data->sensor_data);
+}
+
+static void of_thermal_critical_notify(struct thermal_zone_device *tz)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	data->ops->critical(data->sensor_data);
+}
+
 static int of_thermal_bind(struct thermal_zone_device *thermal,
 			   struct thermal_cooling_device *cdev)
 {
@@ -419,6 +433,11 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (ops->change_mode)
 		tzd->ops->change_mode = of_thermal_change_mode;
 
+	if (ops->hot)
+		tzd->ops->hot = of_thermal_hot_notify;
+
+	if (ops->critical)
+		tzd->ops->critical = of_thermal_critical_notify;
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
@@ -581,6 +600,8 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	tzd->ops->get_trend = NULL;
 	tzd->ops->set_emul_temp = NULL;
 	tzd->ops->change_mode = NULL;
+	tzd->ops->hot = NULL;
+	tzd->ops->critical = NULL;
 
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 365733b428d8..920f7e5c80bb 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -301,6 +301,10 @@ struct thermal_zone_params {
  *		   hardware.
  * @change_mode: a pointer to a function that notifies the thermal zone
  *		   mode change.
+ * @hot:	 a pointer to a function that notifies the thermal zone
+ *		   hot trip violation.
+ * @critical: a pointer to a function that notifies the thermal zone
+ *		   critical trip violation.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
@@ -309,6 +313,8 @@ struct thermal_zone_of_device_ops {
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
 	int (*change_mode) (void *, enum thermal_device_mode);
+	void (*hot)(void *sensor_data);
+	void (*critical)(void *sensor_data);
 };
 
 /* Function declarations */
