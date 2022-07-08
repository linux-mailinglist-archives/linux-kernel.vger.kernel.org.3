Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2256C007
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiGHScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiGHScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:32:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9822F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:32:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay25so3179456wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=B0BNs4nOwOtWXpSnh0Sk8e0/yhMsisqXUANXdlv4wV9Ln/BjUKPy5vQf9TWj3QQQ8t
         Z2tzvB+kZ6ohiPy4eh881B/569E7ujYz3jhxrvuAboW0cEXuOqaKc6UbzEf1d1XfIpcU
         cLeBVZ2j96Z+9k52a78bHdo4k7SuvKHoRXfalILLU12WA0eqXstzz2rRJxzsfu6Jhc20
         7FJtbcylNwMGBLTWpxNPbix5P+hS3aUJDdlsiBHjbPACXeqy5ISqlJP8XoAKpnGQs8DQ
         oule4vZpMp4nmQ1Kpw18JHtIOxKILK6dqlxpQHx1OxjVsZI1l7zvwgga5CIVcuegkFDw
         uXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8W1S2KUuL89TqEwWGa5XSTCs1irHk/zbJh1P5bOgERI=;
        b=WcdSV3kZHeAsak7VfRaDpGrQa2tb7m5/B77ZQhctyQ/4UoHlK0c3eacOx+XKtokt9J
         gn18k5pOl0hSRyMqizfaenrX0de3g3YkK8PIWYStCzvp+wuUj/ykoPERJvF5XT3PC6v4
         hWpeoO1PxcLTK5lAHbYb8B40XH38NeP+Os7jy/Qxs57UuDiuuW2tjsOJqhxAa0JsTBGk
         wBP3U2MCg7ML4z8q+KCNi8mlfXUB4HQE21bgpyKr5Gqp3OrdUZovyT7l2xOsnxL6hBUH
         RH9rgqNwu4s5z0o6rXKUyy7+UZzxTf4Z2yOQQdpZ6eDBu6p5pdO4pLtGxWguuuPw1HoJ
         ekcQ==
X-Gm-Message-State: AJIora8Tj6L5YFlbuzlsRKxcQ0JlxTATMBkX7Z83ohD+K1boRrJi1GPr
        1jaUkaGdtuv8svdA2lhsK1f+sQ==
X-Google-Smtp-Source: AGRyM1vhfGP9ifazaZ9vpI32bu2RGhrdCwI/+vHiooP3kQWcNm3jdvENg1s6UXKL7QCpNTTxr5yomA==
X-Received: by 2002:a05:600c:22da:b0:3a0:4e7b:4237 with SMTP id 26-20020a05600c22da00b003a04e7b4237mr1159282wmg.101.1657305139981;
        Fri, 08 Jul 2022 11:32:19 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0021d887f9468sm4292073wrn.25.2022.07.08.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:32:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 1/3] thermal/core: Encapsulate the trip point crossed function
Date:   Fri,  8 Jul 2022 20:32:07 +0200
Message-Id: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine where the trip point crossed is detected is a strategic
place where different processing will happen. Encapsulate the code in
a function, so all specific actions related with a trip point crossed
can be grouped.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42..d9f771b15ed8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -358,6 +358,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->critical(tz);
 }
 
+static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
+					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
+{
+	if (tz->last_temperature == THERMAL_TEMP_INVALID)
+		return;
+
+	if (tz->last_temperature < trip_temp &&
+	    tz->temperature >= trip_temp) {
+		thermal_notify_tz_trip_up(tz->id, trip,
+					  tz->temperature);
+	}
+
+	if (tz->last_temperature >= trip_temp &&
+	    tz->temperature < (trip_temp - trip_hyst)) {
+		thermal_notify_tz_trip_down(tz->id, trip,
+					    tz->temperature);
+	}
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
@@ -372,16 +391,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
-	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip,
-						  tz->temperature);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip,
-						    tz->temperature);
-	}
+	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
-- 
2.25.1

