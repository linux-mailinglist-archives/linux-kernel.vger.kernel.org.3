Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51647BE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLUKmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:42:14 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3776 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhLUKmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640083333; x=1671619333;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=XPGjqvXPP6cr2Sm55+XcJ8Gt9GA1focKj7xOeqqCM78=;
  b=hUt83/wLn6J2tYMLG1Dp7Fevav/2+9kIB9BvDxHuqlbsO/uvLUayBW4k
   yhQNuGk/2nYkVGmEht8Mu9FexNxt2cy3U/Yi+LNqPVgaFYT4dQgnOxPNz
   HxhZHrfAThyQvMofoqWWQsRTBGlnPkRuF/BUDgFR1k6m3qDOhJHly+o1v
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Dec 2021 02:42:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 02:42:12 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 02:42:12 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 02:42:09 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH] thermal/core: Clear all mitigation when thermal zone is disabled
Date:   Tue, 21 Dec 2021 16:11:58 +0530
Message-ID: <1640083318-19277-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a thermal zone is in trip violated state, there is a chance
that the same thermal zone mode can be disabled either via thermal
core API or via thermal zone sysfs. Once it is disabled, the framework
bails out any re-evaluation of thermal zone. It leads to a case where
if it is already in mitigation state, it will stay the same state
until it is re-enabled.

To avoid above mentioned issue, on thermal zone disable request
reset thermal zone and clear mitigation for each trip explicitly.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/thermal/thermal_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 51374f4..a8ae340 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
 	int ret = 0;
+	int count;
 
 	mutex_lock(&tz->lock);
 
@@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
-	else
+	else {
+		/* make sure all previous throttlings are cleared */
+		thermal_zone_device_init(tz);
+		for (count = 0; count < tz->trips; count++)
+			handle_thermal_trip(tz, count);
+
 		thermal_notify_tz_disable(tz->id);
+	}
 
 	return ret;
 }

