Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3195F4BA5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiBQQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiBQQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934ABB2E08;
        Thu, 17 Feb 2022 08:27:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so8516236eje.10;
        Thu, 17 Feb 2022 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0CAWbNuIuDfQpbJainmJSxgl05KS6pI1nwvw77TVRY=;
        b=XYjjMpDhaV3y4guUdwjcp7pgm0CCJvpxAYqNX/uRe1b80YfpnK0ARRNBQuuarUXsmt
         IuoP9UGADm0phg5YjhICWB2TYsr8Q15w9dvHc8shFxuizpjNbhIo8BnklYElCvt1LVfH
         aHEjCRuS/wUZhdmJDKGXCXZH2MeGUT5QgqowghefD1jO/9ZYE8o3eZGL/FRNKnJPk8ni
         ky4p5t2DWKWEzWnNXX/Q+f4T3nvBS9CpocYX9sHIJdlvOprs79hV9JmszQBdz25z9bUi
         Q2t7B+W8f1RiL4+buQH0S5DKRQ9D5BHYgteg7ctM8Z1DIkqdwZjesChIj/808a++1E4J
         cu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0CAWbNuIuDfQpbJainmJSxgl05KS6pI1nwvw77TVRY=;
        b=5v4SbT74eWBvdrpKEuR6C2yACdN6GvJI9LmPptnr80C4XKH56j6k/94iC/fPG0kybQ
         im6aGSLxQh6uBYqXTxJKmmQtRqO8SNfiSh6xLxyxsSS+Y7jxYXFmHtdhWCrU9c+Sc00p
         W9FtU3qCKZbP2L0M0GkrqGc/FbJz1XZS7jznZjLfueLvgrKQXi7ddoxlFerWoiEO+W+q
         DfJhkweC42W6z6eNGN2qZwp5lJpNmhsqJ75Hd7D3hBRDCrDZ1b1Q+6hiHfZese3VHmAl
         BY8rszViXilMVzRnQ/t8CSYNGgOKTl4kpYoT+Usp9L0nF0fComXmwOQt2Rj0w2+Sduwf
         eT0Q==
X-Gm-Message-State: AOAM533VpJkhagUH9xAj/OKI/SxuLha4CIW8r+BTobfJMbVOCANbwcPT
        6W5KizBWCro6mrguGc04n14=
X-Google-Smtp-Source: ABdhPJzlwfwiOWxf+goTzxLgaAJ6/r/qIVfSm0JJTyMJULqZyhZQz20H7AUpWOyqFSUm3xkOn6AE4Q==
X-Received: by 2002:a17:907:2bf6:b0:6b9:725e:4e1f with SMTP id gv54-20020a1709072bf600b006b9725e4e1fmr2943906ejc.527.1645115256153;
        Thu, 17 Feb 2022 08:27:36 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:35 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 13/13] docs: iio: add documentation for BNO055 driver
Date:   Thu, 17 Feb 2022 17:27:10 +0100
Message-Id: <20220217162710.33615-14-andrea.merello@gmail.com>
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

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/iio/bno055.rst | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/iio/bno055.rst

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
new file mode 100644
index 000000000000..4bb185075325
--- /dev/null
+++ b/Documentation/iio/bno055.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+==============================
+BNO055 driver
+==============================
+
+1. Overview
+===========
+
+This driver supports Bosch BNO055 IMUs (on both serial and I2C busses).
+
+Accelerometer, magnetometer and gyroscope measures are always provided.
+When "fusion_enable" sysfs attribute is set to 1, orientation (both Euler
+angles and quaternion), linear velocity and gravity vector are also
+provided, but some sensor settings (e.g. low pass filtering and range)
+became locked (the IMU firmware controls them).
+
+IIO attributes for unavailable measurements (e.g. Euler angles when fusion
+mode is disabled) just read zero.
+
+This driver supports also IIO buffers.
+
+2. Calibration
+==============
+
+The IMU continuously performs an autocalibration procedure if (and only if)
+operating in fusion mode. The magnetometer autocalibration can however be
+disabled writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
+
+The driver provides access to autocalibration flags (i.e. you can known if
+the IMU has successfully autocalibrated) and to the calibration data blob.
+
+The user can save this blob in a firmware file (i.e. in /lib/firmware) that
+the driver looks for at probe time. If found, then the IMU is initialized
+with this calibration data. This saves the user from performing the
+calibration procedure every time (which consist of moving the IMU in
+various way).
+
+The driver looks for calibration data file using two different names: first
+a file whose name is suffixed with the IMU unique ID (exposed in sysfs as
+serial_number) is searched for; this is useful when there is more than one
+IMU instance. If this file is not found, then a "generic" calibration file
+is searched for (which can be used when only one IMU is present, without
+struggling with fancy names, that change on each device).
+
+Valid calibration file names would be e.g.
+ bno055-caldata-0e7c26a33541515120204a35342b04ff.dat
+ bno055-caldata.dat
+
+In non-fusion mode the IIO 'offset' attributes provide access to the
+offsets from calibration data (if any), so that the user can apply them to
+the accel, angvel and magn IIO attributes. In fusion mode they are not
+needed (the IMU firmware internally applies those corrections) and they
+read as zero.
-- 
2.17.1

