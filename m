Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BA254B0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiFNMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbiFNMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:35:13 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354884D621;
        Tue, 14 Jun 2022 05:32:08 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id hl1vse0171sj; Mon, 13 Jun 2022 14:05:57 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=Or8dfIOR3t70/SRnTgbYY
        wtDQvsCBKZHlbKm77AmtvI=; b=BcZOKdZ1/WnnwOHJPDmauAR/bje0erSJkMoQe
        jUvDvgnBc9ytCx5AX/Q31Svg9Api1Zu7nUZ58TKiuoEX9EU9zhlfIce7ihp1DF8T
        Y7FPOnEt4mxzgxkiMgWpp0rwc/BotzUGeyckug/u/cG/Std6RnzxbgbiRPuxFBbR
        KNLdYU=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205570155825-11; Mon, 13 Jun 2022 14:05:57 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:57 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 14/14] docs: iio: add documentation for BNO055 driver
Date:   Mon, 13 Jun 2022 14:05:34 +0200
Message-ID: <20220613120534.36991-15-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205570155825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

The bno055 driver is rather complex and have some oddities and not-obvious
things that worth to document (e.g. calibration files).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/iio/bno055.rst | 50 ++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/iio/bno055.rst

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
new file mode 100644
index 000000000000..af21376d7a25
--- /dev/null
+++ b/Documentation/iio/bno055.rst
@@ -0,0 +1,50 @@
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
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 58b7a4ebac51..1b7292c58cd0 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -10,3 +10,5 @@ Industrial I/O
    iio_configfs
 
    ep93xx_adc
+
+   bno055
-- 
2.17.1

