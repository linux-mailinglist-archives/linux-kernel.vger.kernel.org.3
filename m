Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C3481095
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhL2HDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:03:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13673 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234578AbhL2HDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640761428; x=1672297428;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WJqGvDb0XideLeYh0xqozjj0gj0nuJndHXEfeachqSI=;
  b=wb07dCSaXtff646efuOh0mee8EVqjNpgQDVZJYr5cStnbWK4FhNB37Il
   ErwoGze00uMVI/aHaB2ZaVdSqVIybbQ0D6WLZQ2iJ1jk1csXAfhksquPX
   393FmqGegTz7595jznUwvfQ3o3DbaC+WEpJgPi/yDsCUmpiAACcM5yXp8
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Dec 2021 23:03:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 23:03:47 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 28 Dec 2021 23:03:47 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 28 Dec
 2021 23:03:43 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Matthias Kaehlcke" <mka@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v2] thermal/core: Clear all mitigation when thermal zone is disabled
Date:   Wed, 29 Dec 2021 12:33:27 +0530
Message-ID: <1640761407-2028-1-git-send-email-quic_manafm@quicinc.com>
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
index 51374f4..5f4e35b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
 	int ret = 0;
+	int trip;
 
 	mutex_lock(&tz->lock);
 
@@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
-	else
+	else {
+		/* make sure all previous throttlings are cleared */
+		thermal_zone_device_init(tz);
+		for (trip = 0; trip < tz->trips; trip++)
+			handle_thermal_trip(tz, trip);
+
 		thermal_notify_tz_disable(tz->id);
+	}
 
 	return ret;
 }

