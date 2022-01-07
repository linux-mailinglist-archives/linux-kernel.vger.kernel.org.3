Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB8487CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiAGS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:57:52 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1445 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbiAGS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641581832; x=1673117832;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=9vfAV3gOFEUjz+LWPdJMI8NxbEyI+AbCWXgdnv6rab4=;
  b=oJb045fJu1ZFTiD7KqepsZbJD8In6euDhC7Wu62jpUbx+U10jp9AABN9
   KzK7cfs+sWkH6VN4smNlae5DPkW7Q0FZR4rp6K1GwQySI3oQrbTVl5xMl
   VoKrpKExrzSHL5+epi9/eC/gVZGak5G8IPFNHEE/29IlXmUlUymVgtIj4
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Jan 2022 10:57:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:57:11 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 10:57:11 -0800
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 7 Jan 2022
 10:57:07 -0800
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Matthias Kaehlcke" <mka@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH v3] thermal/core: Clear all mitigation when thermal zone is disabled
Date:   Sat, 8 Jan 2022 00:26:46 +0530
Message-ID: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 drivers/thermal/thermal_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 51374f4..e288c82 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	if (mode == THERMAL_DEVICE_ENABLED)
+	if (mode == THERMAL_DEVICE_ENABLED) {
 		thermal_notify_tz_enable(tz->id);
-	else
+	} else {
+		int trip;
+
+		/* make sure all previous throttlings are cleared */
+		thermal_zone_device_init(tz);
+		for (trip = 0; trip < tz->trips; trip++)
+			handle_thermal_trip(tz, trip);
+
 		thermal_notify_tz_disable(tz->id);
+	}
 
 	return ret;
 }

