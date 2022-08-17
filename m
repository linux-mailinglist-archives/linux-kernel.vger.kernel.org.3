Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B55970BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiHQOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiHQOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:16:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5F5F980
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1082803wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EnCQXIgNjt6cA5rnmWMREUxDAgbBiGVYT5YSsOL2zmY=;
        b=SgaTLiUsCLYvcdypKjacFEQ5CZB/2F0beLesU0gunTgGaR47x+9UoEBQHRHGKlmrtl
         2dxqUzoxswuZ1SO3IW4xv7eIyG8soY9tKGU1pfYkMFoSRWZZUSbTbJp3ZAoxYo8O/2hz
         y7+hMjSQYd6GW8n3YR/1wzb5efO0bJSOmmsRwOs9hCjB0rWvQqeNuaO4+D7NoM5tu7hF
         gE1NrvNb1oc1+C2he2DTMZKPOxbqsP0mox/4tUbog18wIpUWfzNXEou+5+FVtIJZR24n
         jNqyMVWwQCZ3y6sFR1xlzUfHORjAoA/1hnLZTUuHi+Hb7SiEnJn4J4nETMywVTMNQtaY
         Qp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EnCQXIgNjt6cA5rnmWMREUxDAgbBiGVYT5YSsOL2zmY=;
        b=2ajFpphoUZ2zQHSaNJOx7U/19q9UI3abW0+hmLwYcVnVzhQPmEkgCRoLEr3XcfeAF9
         myA/Spnl7umaCDgEunzCTwojhIQtJV7DMxCs7hhhlot7SxvEP7VKLu2U8ajC/nIAKrNt
         w7IPI9GHT6JVp0LbfjzE3yR2ibwWyhlX77EbdAdfkrxezmOoFaw9/6Ix/1hQE6g5fKnR
         amfgi31f+nuxeWN7h5QoHrnq1Wd3SBkWa2+C7101uasnkeWWXUwY2IbQ5/eNfi63hz9B
         n2FzYjLLZ10UIy1X4tFpwWQMAyOEoXShDA1C/DaER5AjuONf/jQ34+3ACrz1b8MOezu6
         12Zg==
X-Gm-Message-State: ACgBeo1mHKbO079EU++LKcrUAO+T8XYOeeUiKl18Dz7PplHRipP09TMU
        ZYjRuAdBrvS9ZwTEhObn9b46Cw==
X-Google-Smtp-Source: AA6agR44v3ca+iM7s/1610FvreyfjJ7wxkSmjn0583Ztd6iehD28eRNDX+OwmyvSeyaS6PUFnkUR4A==
X-Received: by 2002:a05:600c:1e10:b0:3a5:4f31:3064 with SMTP id ay16-20020a05600c1e1000b003a54f313064mr2254190wmb.136.1660745793544;
        Wed, 17 Aug 2022 07:16:33 -0700 (PDT)
Received: from localhost.localdomain (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b003a5f3de6fddsm2416533wms.25.2022.08.17.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:16:32 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v5 2/3] Documentation: ABI: sysfs-bus-counter: add capture items
Date:   Wed, 17 Aug 2022 16:16:19 +0200
Message-Id: <20220817141620.256481-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817141620.256481-1-jpanis@baylibre.com>
References: <20220817141620.256481-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds capture items to counter ABI file
(e.g. TI ECAP used in capture operating mode).

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 49 +++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..52ddec7cc76a 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,6 +203,24 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/count_cumul
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attribute that indicates the raw cumulated count
+		since count Y start, computed as follow:
+		count_cumul = (max_counter_val + 1) * nb_counter_overflows
+
+What:		/sys/bus/counter/devices/counterX/countY/captureZ
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attributes that indicate the last raw timestamp captured
+		for the respective capture Z register.
+		Raw timestamp can be converted to nanoseconds as follow:
+		time_ns = 10^9 * (captureZ + count_cumul) / frequency
+		count_cumul and frequency parameters are described in this document.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
@@ -213,6 +231,8 @@ What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+What:		/sys/bus/counter/devices/counterX/countY/count_cumul_component_id
+What:		/sys/bus/counter/devices/counterX/countY/captureZ_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
@@ -345,3 +365,32 @@ Description:
 			via index_polarity. The index function (as enabled via
 			preset_enable) is performed synchronously with the
 			quadrature clock on the active level of the index input.
+
+What:		/sys/bus/counter/devices/counterX/signalY/polarityZ
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Capture modules include N timestamp capture registers.
+		For all N sequenced timestamp capture events
+		(1->2->3->...->N->1->...), edge polarity can be selected.
+		The following polarities are available:
+
+		rising edge:
+			Low state transitions to high state.
+
+		falling edge:
+			High state transitions to low state.
+
+What:		/sys/bus/counter/devices/counterX/signalY/polarityZ_available
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Discrete set of available values for the respective polarity Z
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/signalY/frequency
+KernelVersion:	6.0
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attribute that indicates the signal Y frequency, in Hz.
-- 
2.25.1

