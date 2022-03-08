Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DABC4D1B90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiCHPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiCHPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:21:49 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B024DF4E;
        Tue,  8 Mar 2022 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646752852; x=1678288852;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=I8K/GbKHIgRGVF6Y27S47TZkoaxOyZifE0LQwcfM2Kc=;
  b=MGRjbZe5efZ37TIYTVdZ+qGWqTT27eEvaf3UK47lP2GitOEZbFRGghud
   TsCYues9+ml3Hiq2m7WAr0mn5c0BsZquWtrdbFq50kltF+78A/pZg4fhG
   KRWBMID8ays5r/uKz5QgjABGLwzhL/ljjUEJAssciOjr6WIjKa1ypXiig
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Mar 2022 07:20:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:20:52 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 07:20:51 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 07:20:49 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH] drivers/thermal/thermal_of: Add change_mode ops support for thermal_of sensor
Date:   Tue, 8 Mar 2022 20:50:34 +0530
Message-ID: <1646752834-25043-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
have an option to get thermal zone mode change notification from
thermal core.

Add support for change_mode ops in thermal_of interface so that sensor
driver can use this ops for mode change notification.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/thermal_of.c | 14 ++++++++++++++
 include/linux/thermal.h      |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9233f7e..a4e3820 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -203,6 +203,17 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 	return data->ops->get_trend(data->sensor_data, trip, trend);
 }
 
+static int of_thermal_change_mode(struct thermal_zone_device *tz,
+				enum thermal_device_mode mode)
+{
+	struct __thermal_zone *data = tz->devdata;
+
+	if (!data->ops || !data->ops->change_mode)
+		return -EINVAL;
+
+	return data->ops->change_mode(data->sensor_data, mode);
+}
+
 static int of_thermal_bind(struct thermal_zone_device *thermal,
 			   struct thermal_cooling_device *cdev)
 {
@@ -408,6 +419,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (ops->set_emul_temp)
 		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 
+	if (ops->change_mode)
+		tzd->ops->change_mode = of_thermal_change_mode;
+
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c3148939..365733b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -299,6 +299,8 @@ struct thermal_zone_params {
  *		   temperature.
  * @set_trip_temp: a pointer to a function that sets the trip temperature on
  *		   hardware.
+ * @change_mode: a pointer to a function that notifies the thermal zone
+ *		   mode change.
  */
 struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
@@ -306,6 +308,7 @@ struct thermal_zone_of_device_ops {
 	int (*set_trips)(void *, int, int);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
+	int (*change_mode) (void *, enum thermal_device_mode);
 };
 
 /* Function declarations */
