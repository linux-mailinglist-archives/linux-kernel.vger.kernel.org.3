Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42F6502AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353998AbiDONDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353916AbiDONDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C66393D1;
        Fri, 15 Apr 2022 06:00:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z12so9872535edl.2;
        Fri, 15 Apr 2022 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtsnvqbbeV5TO2kjb923S9kE2789W8TuX2/aYcoLqHQ=;
        b=bjShH9vrpELZOz2s40Cx9YvVW34GLxS8ve+f68W4+cTXVVErpafgJM/ZuKH0tRaQla
         OnRrktH7An4idN04nogHWT95nk7A2SJ/kld00KwN04oCHuKkrJP4MHSDK1VHXsTRVtaL
         DSg6BtIv4CLXhlXNwE4xvc4dqB1wW1aInPxXoEX6SUhoVadEUh/7HJix1SRJXBxYsjHU
         OVfAppHaSJsrGReEc59uBITrJRwVm2IlD1K1NMpN8pXniG/JEezCsTTb/xXbnEDB18qm
         3GreFICGWn7jRubVRJsOpNNzRNmEBFbAduXMGzSwZ9T3hxfo9dV2mo1kIwohY83F7WeT
         vLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtsnvqbbeV5TO2kjb923S9kE2789W8TuX2/aYcoLqHQ=;
        b=CREXZ3EJ8IpW9Y8ZxOINJzc2ispVBUOwdYhmLsCAQGvDvhVGwEk/vlqmda0BLKWhkn
         0731eILYn8hzKE3l6KGKSKDzNATOSl27wNmb12JnpdpW5jYps3TSXCV75dmgEb5vDV4T
         t78FZ2CuYLZ4yqkOvSOspGjO701vjqZN/DvGN3GNwhSPbCyoDo53kNMw3quUNXbNJs0P
         mwL6UqkHNPvE8Of2PLD0EQS4oUSpbB6lphlCOIz60ILiGAXKcLEjsuzgjFpFrcrxKTUO
         EeqorbfJC3SgktzY6k7pvA9P+7G0G7djiFd+ZRdcrBC/LZzTlSvZ3upmF/Og918pl6aQ
         r0dQ==
X-Gm-Message-State: AOAM532l1+3kNuE2f2+PfVMB6iRRTC5ANUIq6CLfLTjYFaEFT1S1fc9G
        IV2G67Qi/NUDB0wcxHpgGX8=
X-Google-Smtp-Source: ABdhPJxxq1Uv3qn35IDNwgcPgMK60LbQlUaTtmFpTK+eruHFS3FrREoUCy3NEdHDH66FdeEbvC34Cw==
X-Received: by 2002:a05:6402:5210:b0:41f:90a3:18a9 with SMTP id s16-20020a056402521000b0041f90a318a9mr8205684edd.194.1650027633034;
        Fri, 15 Apr 2022 06:00:33 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:32 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 09/14] iio: document bno055 private sysfs attributes
Date:   Fri, 15 Apr 2022 15:00:00 +0200
Message-Id: <20220415130005.85879-10-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

This patch adds ABI documentation for bno055 driver private sysfs
attributes.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../ABI/testing/sysfs-bus-iio-bno055          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
new file mode 100644
index 000000000000..22a5c6dc90dc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,81 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) range for acceleration readings. Unit after
+		application of scale is m/s^2. Note that this doesn't affects
+		the scale (which should be used when changing the maximum and
+		minimum readable value affects also the reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in radians per second. Note
+		that this does not affects the scale (which should be used when
+		changing the maximum and minimum readable value affects also the
+		reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the accelerometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the gyroscope sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the magnetometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the status for the IMU overall autocalibration.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
-- 
2.17.1

