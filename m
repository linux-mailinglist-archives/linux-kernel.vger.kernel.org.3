Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C164DB9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358145AbiCPVL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358126AbiCPVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:11:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE266AF0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:10:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d18so2818161plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iRv99gRR+dDFqt3eRpswNmiSreBZ631Owy00tW6yZcU=;
        b=c37P/rYSqo6TcipSclHSiCTCd0xxWgz89Nf4rmIGY9y9jjel7xO28Lmh9gP6nJlR0C
         LX5ks4TT5WXNA3tYH4d2s8i/VdLCtak+f0FgUZmmbZbGLTd/WUV0Q+6D+AlTnhth42Fj
         pMdDo4lnir731OXifK8eqYIBmm9smt3/PbitM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iRv99gRR+dDFqt3eRpswNmiSreBZ631Owy00tW6yZcU=;
        b=POiUW7Cfg1LgboPum/KjRvnju2vVWT4tBt8ZO48O0JPxcy1+NBiHSlENR3jgZbMxOq
         rLO1gh0DhcX5KLV10VirecJSF1oIZS4AEZ4v9zPCILfd8ehrciX4xrZIjmO468VoCmVI
         oUbK0iNehwZGLfBmvEfXqUQovko3i77fMkv25ZOERhHWTin6rqj1EUjKxxl/CTqLAXse
         C6C5GJVzRsDpqk1V6tSyJeemuDekESaPttvoAm+Z5py2hhW9Weii/qVitzh16rfGvra9
         T9ng7h94wf43hpal8I1n9YgWLIjNVC9rVTsZm1lVxM4w061MnNeWklJ2NX6IQFeabeU9
         7oJw==
X-Gm-Message-State: AOAM533Qdr4K/1XNYcuDUuLrqy5pXuhKrBVJ2x3eSodF8Q9p9HPjeELf
        9obik3FONFqMcMB1lYdAMKB9PA==
X-Google-Smtp-Source: ABdhPJyhIbq2BD3mzyRKhiWn/+GC/52p+XjCj0nGHchwnpXbu+hGsVhnES70nSuyfEp5Tl3by9Q81g==
X-Received: by 2002:a17:90a:6003:b0:1c6:64a9:2155 with SMTP id y3-20020a17090a600300b001c664a92155mr1740666pji.30.1647465030726;
        Wed, 16 Mar 2022 14:10:30 -0700 (PDT)
Received: from localhost ([135.84.132.250])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004f7a6d338c3sm4386234pfc.41.2022.03.16.14.10.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2022 14:10:30 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zac Crosby <zac@squareup.com>, Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: thermal: tsens: implement change_mode to disable sensor IRQs
Date:   Wed, 16 Mar 2022 14:09:45 -0700
Message-Id: <20220316210946.6935-3-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316210946.6935-1-benl@squareup.com>
References: <20220316210946.6935-1-benl@squareup.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement change_mode() to disable sensor IRQs when a sensor is disabled.

Note that this commit does not touch:
- The tsens device's CPU IRQ, which is global across all sensors on a tsens
  device.
- Power/clock of the sensor. Future work is needed in the tsens_ops
  interface to support single-sensor disable + handle quirks (the only
  implementation of tsens_ops->enable and disable only supports individual
  enable/disable on some sensors, and others must be enabled/disabled as a
  block).

'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
polling mechanism to check for threshold trips. However, tsens supports
an interrupt mechanism to receive notification of trips, implemented in
commit 634e11d5b450 ("drivers: thermal: tsens: Add interrupt support").
This is used sometimes to run performance test cases.

Currently the thermal zone mode that's set by userspace does not control
threshold trip events from IRQs. Let's fix this to restore the abilty to
disable thermal throttling at runtime.

====================

Tested on MSM8939 running 5.17. This platform has 8 cores; the first four
thermal zones control cpu0-3 and the last zone is for the other four CPUs
together.

  for f in /sys/class/thermal/thermal_zone*; do
    echo "disabled" > $f/mode
    echo $f | paste - $f/type $f/mode
  done

/sys/class/thermal/thermal_zone0        cpu0-thermal    disabled
/sys/class/thermal/thermal_zone1        cpu1-thermal    disabled
/sys/class/thermal/thermal_zone2        cpu2-thermal    disabled
/sys/class/thermal/thermal_zone3        cpu3-thermal    disabled
/sys/class/thermal/thermal_zone4        cpu4567-thermal disabled

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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/thermal/qcom/tsens.c | 43 ++++++++++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens.h |  4 ++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 99a8d9f3e03c..d5263436f959 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -564,8 +564,12 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	/* Write the new thresholds and clear the status */
 	regmap_field_write(priv->rf[LOW_THRESH_0 + hw_id], low_val);
 	regmap_field_write(priv->rf[UP_THRESH_0 + hw_id], high_val);
-	tsens_set_interrupt(priv, hw_id, LOWER, true);
-	tsens_set_interrupt(priv, hw_id, UPPER, true);
+	s->trips_configured = true;
+
+	if (s->enable_irqs) {
+		tsens_set_interrupt(priv, hw_id, LOWER, true);
+		tsens_set_interrupt(priv, hw_id, UPPER, true);
+	}
 
 	spin_unlock_irqrestore(&priv->ul_lock, flags);
 
@@ -575,6 +579,40 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	return 0;
 }
 
+static int tsens_change_mode(void *_sensor, enum thermal_device_mode mode)
+{
+	struct tsens_sensor *s = _sensor;
+	struct tsens_priv *priv = s->priv;
+	u32 hw_id = s->hw_id;
+	bool enable = (mode == THERMAL_DEVICE_ENABLED);
+	unsigned long flags;
+
+	if (tsens_version(priv) < VER_0_1) {
+		/* Pre v0.1 IP had a single register for each type of interrupt
+		 * and threshold, so we can't support individual enable/disable.
+		 */
+		hw_id = 0;
+		enable = true;
+	}
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	/* During sensor registration, thermal core calls change_mode(ENABLED)
+	 * before it calls set_trips(low, high). To avoid enabling threshold
+	 * interrupts before thresholds are configured, let's let set_trips do
+	 * the first enable.
+	 */
+	if (s->trips_configured) {
+		tsens_set_interrupt(priv, hw_id, LOWER, enable);
+		tsens_set_interrupt(priv, hw_id, UPPER, enable);
+	}
+	s->enable_irqs = enable;
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	return 0;
+}
+
 static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
@@ -1002,6 +1040,7 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
 	.get_trend = tsens_get_trend,
 	.set_trips = tsens_set_trips,
+	.change_mode = tsens_change_mode,
 };
 
 static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 1471a2c00f15..1a835d7688e0 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -45,6 +45,8 @@ enum tsens_irq_type {
  * @offset: offset of temperature adjustment curve
  * @hw_id: HW ID can be used in case of platform-specific IDs
  * @slope: slope of temperature adjustment curve
+ * @trips_configured: whether this sensor's upper/lower thresholds are set
+ * @enable_irqs: whether this sensor's threshold IRQs should be enabled
  * @status: 8960-specific variable to track 8960 and 8660 status register offset
  */
 struct tsens_sensor {
@@ -53,6 +55,8 @@ struct tsens_sensor {
 	int				offset;
 	unsigned int			hw_id;
 	int				slope;
+	bool				trips_configured;
+	bool				enable_irqs;
 	u32				status;
 };
 
-- 
2.17.1

