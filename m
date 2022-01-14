Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154E148E2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiANDOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiANDOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:14:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F492C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 19:14:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo12930795pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 19:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UihRxFe06/0BjCUwssSJVg8d5/WcnG6d9hupQZOxDOM=;
        b=bvFNtVjXhWZB/QjtYGDuou+oOg1zbJqHE1lCE03Hzcg28YrENTk5LeMPjwFoPicoEe
         dbwRbVpTpkrsdZ6/AFx3QdXgpAqiNTrs7UvI7Jty+mhxz0/S38uG1uQVYYNYGuuhvtjx
         GEvqRCLqVIahMktERqUiahUAQSw5kybTBwSmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UihRxFe06/0BjCUwssSJVg8d5/WcnG6d9hupQZOxDOM=;
        b=3OfWShbyxlSAgqN8mlqWXtKeeLlXc3pquJdgiyafgA9nq/pWrraFdJyAbjg685WmZC
         XLc5kGNj5M+Ib5D37pYlDg2gaCaGSZMFJexIp2UpfeJOsL3e/MPXffikV6Or0KSxVcr8
         UIga3/Iyj/q6tIWtH4WmiLi5DOv+3Fn/IGtIr+4hI+GhLcX24/uMWNU36nyiZaVlXCit
         QmNRRiyc/8F6PShz0fpjNXjcGkQy6K4dR35ZXZMSOANaWx08iK61Z+efwwFxKpdFb0yQ
         pFV7P4BLBpMpIFnugQ4ZddYdmooAwtYgO5rU1/r6YxKcMSz0CG/v9IyecCsGf7Ob6Vne
         1P7A==
X-Gm-Message-State: AOAM530OPhTd5DK3k0Sbi4oN53JDZ/c2hd0KLrjpwG5QO92EHthYfArr
        WRecyhkE5g+7gC8pYaczIG+MuA==
X-Google-Smtp-Source: ABdhPJw5u7fOl1HCNeFx7xfSaQq53IeVfxaVK7JmWpf7VCgW+7WNldHq5Yw2s90BuxCArGbxNtnweg==
X-Received: by 2002:a17:902:d505:b0:14a:77ac:1e8b with SMTP id b5-20020a170902d50500b0014a77ac1e8bmr7292312plg.1.1642130071939;
        Thu, 13 Jan 2022 19:14:31 -0800 (PST)
Received: from localhost (99-47-69-49.lightspeed.sntcca.sbcglobal.net. [99.47.69.49])
        by smtp.gmail.com with ESMTPSA id m3sm3813484pfa.183.2022.01.13.19.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 19:14:31 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Benjamin Li <benl@squareup.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: thermal: tsens: respect thermal_device_mode in threshold irq reporting
Date:   Thu, 13 Jan 2022 19:13:37 -0800
Message-Id: <20220114031337.24741-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
polling mechanism to check for threshold trips. However, tsens supports
an interrupt mechanism to receive notification of trips, implemented in
commit 634e11d5b450 ("drivers: thermal: tsens: Add interrupt support").
This is used sometimes to run performance test cases.

Currently the thermal zone mode that's set by userspace is not checked
before propagating threshold trip events from IRQs. Let's fix this to
restore the abilty to disable thermal throttling at runtime.

====================

Tested on MSM8939 running 5.16.0. This platform has 8 cores; the first
four thermal zones control cpu0-3 and the last zone is for the other four
CPUs together.

  for f in /sys/class/thermal/thermal_zone*; do
    echo "disabled" > $f/mode
    echo $f | paste - $f/type $f/mode
  done

/sys/class/thermal/thermal_zone0	cpu0-thermal	disabled
/sys/class/thermal/thermal_zone1	cpu1-thermal	disabled
/sys/class/thermal/thermal_zone2	cpu2-thermal	disabled
/sys/class/thermal/thermal_zone3	cpu3-thermal	disabled
/sys/class/thermal/thermal_zone4	cpu4567-thermal	disabled

With mitigation thresholds at 75 degC and load running, we can now cruise
past temp=75000 without CPU throttling kicking in.

  watch -n 1 "grep '' /sys/class/thermal/*/temp
      /sys/class/thermal/*/cur_state
      /sys/bus/cpu/devices/cpu*/cpufreq/cpuinfo_cur_freq"

/sys/class/thermal/thermal_zone0/temp:82000
/sys/class/thermal/thermal_zone1/temp:84000
/sys/class/thermal/thermal_zone2/temp:87000
/sys/class/thermal/thermal_zone3/temp:84000
/sys/class/thermal/thermal_zone4/temp:84000
/sys/class/thermal/cooling_device0/cur_state:0
/sys/class/thermal/cooling_device1/cur_state:0
/sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu1/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu2/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu3/cpufreq/cpuinfo_cur_freq:1113600
/sys/bus/cpu/devices/cpu4/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu5/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu6/cpufreq/cpuinfo_cur_freq:800000
/sys/bus/cpu/devices/cpu7/cpufreq/cpuinfo_cur_freq:800000

Reported-by: Zac Crosby <zac@squareup.com>
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/thermal/qcom/tsens.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 99a8d9f3e03c..0b6299512e7c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -509,13 +509,16 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 		spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 		if (trigger) {
-			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
-				hw_id, __func__, temp);
-			thermal_zone_device_update(s->tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
+			if (s->tzd->mode == THERMAL_DEVICE_ENABLED) {
+				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+					hw_id, __func__, temp);
+				thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
+			} else {
+				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC) skipped as zone disabled\n",
+					hw_id, __func__, temp);
+			}
 		} else {
-			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
-				hw_id, __func__, temp);
+			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n", hw_id, __func__, temp);
 		}
 
 		if (tsens_version(priv) < VER_0_1) {
-- 
2.17.1

