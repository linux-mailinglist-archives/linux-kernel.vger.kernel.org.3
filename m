Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0664DB9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiCPVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358098AbiCPVLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:11:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A843394
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:10:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so3654189pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuBwkb6Bm2dJygmGjKNMzcQ7V38KULA7oyW33icX/Xs=;
        b=f2Pkm0+UTgAdPrRxaAeSDHe2Wp9gfhaR7VrH65WjuMJTB8JJEn4ensEPYp3kvebZ/1
         Iuzewo74EBgaO5auuBP4euHPDcWXtXahB0WhOJ2A6uDo/KeSm6EuFGApxjRLPpwtxYvH
         k1x1C2KOtBGn46T71xGS0u+hwDMvUxQXmv1XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuBwkb6Bm2dJygmGjKNMzcQ7V38KULA7oyW33icX/Xs=;
        b=w0t6iFZzwp6IHmA/2RUuSu7hrqb1FSX5mub7nHldd/FuVfWT+y+p+yEyUtMWHquurc
         6DppeWzI9JkK0OhaN+ZzCZ7geq3OX5fnimOHJGHTTJRRd+w/3tl6T7jiRHjLR2Xev4RM
         DBnbaIkB3ApEvAVzHkaOicRzqopas6HQ+Q2WWCm/bLZb7+jgvfVg/lJYgaVBbuHsCru5
         FQv4AOxOrzUOMrDU19+C2xIdoiAkGImFdhZAksnW3+u7CtdZqB1PNfAXNpnARcnX7wla
         e8sHhjOVgbjzW9pzYdlOqPWcpjUZXsUZs3mhAWYqMgUeDatcO2EdHGmlABkYeINfejfP
         slsw==
X-Gm-Message-State: AOAM530c8/k8KdgF2LJ6I7YaayizDHxJFb2JstTfb0IRpzlPyoxhlc+H
        ECvvXhA4bCWLwt8AQVX2dY6D3Q==
X-Google-Smtp-Source: ABdhPJxh5UhmNk4YCcGt0E/+WtCoAz7hr3beaRxtARhLtP83XT+fe8dwt5IvhPsE65sdrXs7b6QV8g==
X-Received: by 2002:a17:902:e848:b0:151:e3a5:b609 with SMTP id t8-20020a170902e84800b00151e3a5b609mr1440981plg.137.1647465027663;
        Wed, 16 Mar 2022 14:10:27 -0700 (PDT)
Received: from localhost ([135.84.132.250])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm4476450pfj.112.2022.03.16.14.10.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2022 14:10:27 -0700 (PDT)
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
Subject: [PATCH 1/2] thermal: thermal_of: add pass-through change_mode to ops struct
Date:   Wed, 16 Mar 2022 14:09:44 -0700
Message-Id: <20220316210946.6935-2-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316210946.6935-1-benl@squareup.com>
References: <20220316210946.6935-1-benl@squareup.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional change_mode method to the ops struct, allowing thermal_of-
based drivers to properly implement disabling of sensors/IRQs. Previously
thermal_core would just disable the polling timer when a zone is disabled,
as thermal_of drivers could not provide a change_mode implementation.

This meant thermal_of drivers supporting interrupt-based updates had to
keep sensors/IRQs enabled at all times, and needed to resort to reading
tzd->mode in their IRQ handler or get_temp implementation to actually stop
updating. This is a waste of resources in IRQ handlers to ignore updates,
and for sensors that can power down it's a waste of power.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/thermal/thermal_of.c | 14 ++++++++++++++
 include/linux/thermal.h      |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9233f7e74454..a69ec39780a7 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -106,6 +106,17 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
 	return data->ops->set_trips(data->sensor_data, low, high);
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
 /**
  * of_thermal_get_ntrips - function to export number of available trip
  *			   points.
@@ -405,6 +416,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (ops->set_trips)
 		tzd->ops->set_trips = of_thermal_set_trips;
 
+	if (ops->change_mode)
+		tzd->ops->change_mode = of_thermal_change_mode;
+
 	if (ops->set_emul_temp)
 		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c314893970b3..469a1664f1ed 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -295,6 +295,7 @@ struct thermal_zone_params {
  * @set_trips: a pointer to a function that sets a temperature window. When
  *	       this window is left the driver must inform the thermal core via
  *	       thermal_zone_device_update.
+ * @change_mode: a pointer to a function that enables/disables reporting.
  * @set_emul_temp: a pointer to a function that sets sensor emulated
  *		   temperature.
  * @set_trip_temp: a pointer to a function that sets the trip temperature on
@@ -304,6 +305,7 @@ struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, int, enum thermal_trend *);
 	int (*set_trips)(void *, int, int);
+	int (*change_mode)(void *, enum thermal_device_mode);
 	int (*set_emul_temp)(void *, int);
 	int (*set_trip_temp)(void *, int, int);
 };
-- 
2.17.1

