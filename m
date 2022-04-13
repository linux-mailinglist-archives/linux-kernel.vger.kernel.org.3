Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543A84FF3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiDMJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiDMJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:42:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6A235863;
        Wed, 13 Apr 2022 02:40:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so2768098ejb.4;
        Wed, 13 Apr 2022 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vl7mHwjbFJUwGNfezeH0wT3+eHhNeFd4f92YI2gTXZQ=;
        b=Mvl/zm+FJg7S5tEy+CQnEmIgSezVmthI3ntgWt2OQv1cqn/RZFZ+Dx9lpO0nn7cW9A
         13+f6DkL34WP3ab7TehXT2SoL5XlZ4Mcwvzlou0pzrhLpMIC0kflU7lUbl5jayVIGugF
         G8gfTt8auYrThQ+Y3ubir8Prail9T2LLhCMJXBAfPOKECx/r0fAiDmTKN2Pz90/Co9qO
         kPdROQoJavzV02A89FfP1oILkY1w64qraTaHjpgZ7BmFClyl+W5+G9QOZ2v5TnXFfSGj
         fx3aAn2/f4sqPZyzMvNEPFSJyUUKd64A29wDH/KtyI1LPpmsXFYQIVHR+DZBpmznGLa5
         S+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vl7mHwjbFJUwGNfezeH0wT3+eHhNeFd4f92YI2gTXZQ=;
        b=N9T1R3nvKSVrVZVrvvm2r6Xy4+a7qR+d8s95RYK/51hYjtnEVq8lRWTuA1bsHTo+YK
         OCuR4DK8iocXcDL+8ZchrRu8LIAHbXGmeK+r2WWetVXnA8ARJef5pJucOHvIDuownna4
         5rH6G4sYJIEYCG0PGJu2hHhGdnNB4xvLUkloEVp2wYExsmdhyBMwpwvPGP3Ul/0McKr5
         kFoVXPLo8/Xr73tvUWuyr6hB+egUXe9bcFyh3HEFoTroJ9WeBL7ecFAHjXLBQ2qHor9r
         qBLKh/T6cLFw+YM1jdPI5W1/haT8Ik9yTZTbIoXySIOowmnw91Qt9sgI71xVfaVZMWGy
         SplQ==
X-Gm-Message-State: AOAM533EoEGBdUJs1ZK/Dveq/plAJAdAGmeUEAq+6/3a0R08Ve9pD2ea
        M4h8iLIMHfEz3e8G+SYtqeULyTw5wx0=
X-Google-Smtp-Source: ABdhPJxuu9PfRuWqwvpVTz73/7aAA/uVOUZtOUmuVvasWJZHE/VZA1t6r3XRy6PbK3rs8N54LClVFg==
X-Received: by 2002:a17:907:90d0:b0:6e8:9a64:4f2d with SMTP id gk16-20020a17090790d000b006e89a644f2dmr10650468ejb.444.1649842824148;
        Wed, 13 Apr 2022 02:40:24 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm11403265eje.15.2022.04.13.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:40:23 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v1 2/3] iio: ABI: adc: ad4130: document filter_mode{,_available}
Date:   Wed, 13 Apr 2022 12:40:10 +0300
Message-Id: <20220413094011.185269-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413094011.185269-1-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD4130-8 is an ultra-low power, high precision,
measurement solution for low bandwidth battery
operated applications.

The fully integrated AFE (Analog Front-End)
includes a multiplexer for up to 16 single-ended
or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip
reference and oscillator, selectable filter
options, smart sequencer, sensor biasing and
excitation options, diagnostics, and a FIFO
buffer.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
new file mode 100644
index 000000000000..942150991e75
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
@@ -0,0 +1,36 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible filter modes.
+		"sinc4"       - Sinc 4. Excellent noise performance. Long 1st
+				conversion time. No natural 50/60Hz rejection.
+		"sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion time.
+		"sinc3"	      - Sinc3. Moderate 1st conversion time. Good noise
+				performance.
+		"sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling frequency
+				of 50Hz, achieves simultaneous 50Hz and 60Hz
+				rejection.
+		"sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion time.
+				Best used with a sampling frequency of at least
+				216.19Hz.
+		"sinc3+pf1"   - Sinc3 + Post Filter 1.
+				53dB rejection @ 50Hz, 58dB rejection @ 60Hz.
+		"sinc3+pf2"   - Sinc3 + Post Filter 2.
+				70dB rejection @ 50Hz, 70dB rejection @ 60Hz.
+		"sinc3+pf3"   - Sinc3 + Post Filter 3.
+				99dB rejection @ 50Hz, 103dB rejection @ 60Hz.
+		"sinc3+pf4"   - Sinc3 + Post Filter 4.
+				103dB rejection @ 50Hz, 109dB rejection @ 60Hz.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Set the filter mode of the differential channel. When the filter
+		mode changes, the in_voltageY-voltageZ_sampling_frequency and
+		in_voltageY-voltageZ_sampling_frequency_available attributes
+		might also change to accomodate the new filter mode.
+		If the current sampling frequency is out of range for the new
+		filter mode, the sampling frequency will be changed to the
+		closest valid one.
-- 
2.35.1

