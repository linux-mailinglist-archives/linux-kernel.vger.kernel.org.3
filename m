Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6814BA5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbiBQQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbiBQQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723E9AD9B;
        Thu, 17 Feb 2022 08:27:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so8510709ejc.9;
        Thu, 17 Feb 2022 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbdipNgGb568BK6JvdFqLj5QbJ/YCdKI9XyfVVughYc=;
        b=FDGQfbhXaaUO4B926RvwjtMRE/bI9kcTmB98/cTf39VoiK8IP0dTiIinIJLo/YylxV
         /KFEShizihxLpsRUXGYqHbxFrlnoO0U0+rTq4nmM5waEc+a3kbP8KVMSxp2kO/LeHm/B
         WXfS/4L8C7bu9HFT3G03cqKAx1KxSU5ha9Bl8alCK4vVSsrhsZYIZXwPsmmlo2gGDQl/
         cpPdX74yIN60qPkxD9AdvPVXAn61GiUtOdnLRsXFNM6jPyvQ599S6vD+SsuAHlayIdtF
         78CfMLgdqoC6IXvXCvmerVwgPQzPNA3Pq4a80+lSFvaQ2cDTrzFNhAnxBlNIGM43/Mjn
         j0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbdipNgGb568BK6JvdFqLj5QbJ/YCdKI9XyfVVughYc=;
        b=hacf/z2dr3ypIAhawvGCuonKD1W7eoONTujCYrkauiOOWqz14p/Lb5azEVGd9drEts
         pVaYDyN6q2GG9E7NMxZUG6+yulijR2O9SZRWfDjzf9x9cKxwvrwDtH64/+deBijDWMhG
         q3vXppNbZefjsSyri1nmprur/WQOBr0s0KMi1qg2dAFJ29q26yLqqs7/IQI4RYWj0Y5g
         0EYtOHuB514uHIiTRMeH3ZTKgrY3NjjycFCAsNa/9Dkj1ow+JQqCASt90E3YMti/g3Qt
         UpYTeUf1i/CIUJ9JfyEi0ubeWlBlVZMzg3gqxo30t70yath5vNZ/dbUNr7NsxjRIfmwa
         YYvg==
X-Gm-Message-State: AOAM530FSjPVBUaEku10xopNCYW+k1Ey+cuzR9JPjhe3Ytu7Y1nL0LGB
        gHA4ziOcNWSZrfVXEareAaM=
X-Google-Smtp-Source: ABdhPJy3ChPqp5lo7a3SDO69C5a1yNib9JnENaNKabTlATHZxl+qvDSw+zEVHQ5eHDLiKC8wZDGGcA==
X-Received: by 2002:a17:907:213b:b0:6cf:9c02:8964 with SMTP id qo27-20020a170907213b00b006cf9c028964mr2904604ejb.432.1645115250783;
        Thu, 17 Feb 2022 08:27:30 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:30 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 08/13] iio: document bno055 private sysfs attributes
Date:   Thu, 17 Feb 2022 17:27:05 +0100
Message-Id: <20220217162710.33615-9-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This patch adds ABI documentation for bno055 driver private sysfs
attributes.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../ABI/testing/sysfs-bus-iio-bno055          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-bno055 b/Documentation/ABI/testing/sysfs-bus-iio-bno055
new file mode 100644
index 000000000000..c239276f2b0f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-bno055
@@ -0,0 +1,81 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for acceleration readings in m/s^2. Note that this does
+		not affects the scale (which should be used when changing the
+		maximum and minimum readable value affects also the reading
+		scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Range for angular velocity readings in radians per second. Note
+		that this does not affects the scale (which should be used when
+		changing the maximum and minimum readable value affects also the
+		reading scaling factor).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_raw_range_available
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_accel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_raw_range_available
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of allowed values for in_anglvel_raw_range attribute
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_fast_enable
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "Fast Magnetometer
+		Calibration" HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fusion_enable
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Can be 1 or 0. Enables/disables the "sensor fusion" (a.k.a.
+		NDOF) HW function.
+
+What:		/sys/bus/iio/devices/iio:deviceX/calibration_data
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the binary calibration data blob for the IMU sensors.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibration_auto_status
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the accelerometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_calibration_auto_status
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the gyroscope sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_calibration_auto_status
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the autocalibration status for the magnetometer sensor.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sys_calibration_auto_status
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reports the status for the IMU overall autocalibration.
+		Can be 0 (calibration non even enabled) or 1 to 5 where the greater
+		the number, the better the calibration status.
-- 
2.17.1

