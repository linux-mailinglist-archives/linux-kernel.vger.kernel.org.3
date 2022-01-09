Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812E488B26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiAIR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:26:24 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:10682 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiAIR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641749177; x=1673285177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0fUCqJ/NL6PQdwsVXSoq785o5Pi/zNjfrTElJcS+GAM=;
  b=LWUWzqtw5TEPqYpr4A7eKbWMeVxn6KXjDJ7sVgwRlyI6B0L8C29lS+ts
   Mg7pG3H8mGsSsypuh8iFcDTSqZDds6FwKkPyTDg8piUYbb0/LQr319www
   EjXrrwEx0gJrYPPmQsY4T/OwISQ+U8QS9W7dVJQqx5tYmOatC/mqN/X3z
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Jan 2022 09:26:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 09:26:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:50 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 9 Jan 2022 09:25:46 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 08/10] PM: domains: Store the closest hrtimer event of the domain CPUs
Date:   Sun, 9 Jan 2022 22:55:05 +0530
Message-ID: <1641749107-31979-9-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch timer can not wake up the Qualcomm Technologies, Inc. (QTI)
SoCs when the deepest CPUidle modes results in the SoC also to enter
the low power mode.

RSC is part of CPU subsystem and APSS rsc device is attached to cluster
power domain. RSC has to setup next hrtimer wakeup in CONTROL_TCS which
can wakeup the SoC from deepest low power states. The CONTROL_TCS does
this by writing next wakeup in always on domain timer when the SoC is
entering the low power state.

Store the domain wakeup time from all the CPUs which can be used from
domain power off callback by RSC device.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/base/power/domain_governor.c | 1 +
 include/linux/pm_domain.h            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index cd08c58..a4c7dd8 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -363,6 +363,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 				domain_wakeup = next_hrtimer;
 		}
 	}
+	genpd->next_hrtimer = domain_wakeup;
 
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 67017c9..682b372 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -136,6 +136,7 @@ struct generic_pm_domain {
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	ktime_t next_wakeup;	/* Maintained by the domain governor */
+	ktime_t next_hrtimer;	/* Closest hrtimer event of the domain CPUs */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
-- 
2.7.4

