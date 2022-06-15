Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6254C71F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbiFOLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbiFOLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:03:55 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62562544C3;
        Wed, 15 Jun 2022 04:03:06 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id B456840006;
        Wed, 15 Jun 2022 11:03:04 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     jic23@kernel.org
Cc:     foss+kernel@0leil.net, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] iio: accel: mxc4005: report orientation of accelerometer
Date:   Wed, 15 Jun 2022 13:02:40 +0200
Message-Id: <20220615110240.684744-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The accelerometer can report precise values for x, y and z accelerations
but it can also simply report its orientation on XY plane and Z axis.

Since the orientation of the device may be enough information for
userspace and allows to avoid expensive fusion algorithms, let's add
support for it.

The orientation register stores a 2b value for XY plane orientation:
between 225° and 315°, returns 0, between 315° and 45°, 1, between 45°
and 135°, 2 and between 135° and 225°, 3. We "round" those to 270°,
0°, 90° and 180° degrees.

For Z axis, the register bit returns 0 if facing the user, 1 otherwise,
which the driver translates to 0° and 180° respectively.

Those values are proper if the accelerometer is mounted such that the
XYZ axes are as follows when the device is facing the user in portrait
mode (respecting the right-hand rule):

     y
     ^
     |
     |
     |
     +----------> x
    /
   /
  /
 L
z

Since this information is very basic, imprecise (only 4 values for XY
plane and 2 for Z axis) and can be extrapolated from the actual,
precise, x, y and z acceleration values, it is not made available
through buffers.

A change in XY plane or Z axis orientation can also trigger an interrupt
but this feature is not added in this commit.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/iio/accel/mxc4005.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index b3afbf064915..61f24058d239 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -20,6 +20,11 @@
 #define MXC4005_IRQ_NAME		"mxc4005_event"
 #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
 
+#define MXC4005_REG_TILT_ORIENT		0x01
+#define MXC4005_REG_TILT_ORIENT_Z_MASK		BIT(6)
+#define MXC4005_REG_TILT_ORIENT_XY_MASK		GENMASK(5, 4)
+#define MXC4005_REG_TILT_ORIENT_XY_SHIFT	4
+
 #define MXC4005_REG_XOUT_UPPER		0x03
 #define MXC4005_REG_XOUT_LOWER		0x04
 #define MXC4005_REG_YOUT_UPPER		0x05
@@ -96,6 +101,7 @@ static const struct attribute_group mxc4005_attrs_group = {
 static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MXC4005_REG_TILT_ORIENT:
 	case MXC4005_REG_XOUT_UPPER:
 	case MXC4005_REG_XOUT_LOWER:
 	case MXC4005_REG_YOUT_UPPER:
@@ -214,6 +220,28 @@ static int mxc4005_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_ROT:
+			ret = regmap_read(data->regmap, chan->address, val);
+			if (ret < 0) {
+				dev_err(data->dev, "failed to read rotation\n");
+				return ret;
+			}
+
+			if (chan->channel2 == IIO_MOD_X_AND_Y) {
+				*val &= MXC4005_REG_TILT_ORIENT_XY_MASK;
+				*val >>= MXC4005_REG_TILT_ORIENT_XY_SHIFT;
+				/* 00 = 270°; 01 = 0°; 10 = 90°; 11 = 180° */
+				*val = (360 + (*val - 1) * 90) % 360;
+			} else {
+				*val &= MXC4005_REG_TILT_ORIENT_Z_MASK;
+				*val = *val ? 180 : 0;
+			}
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_ACCEL:
@@ -287,11 +315,22 @@ static const unsigned long mxc4005_scan_masks[] = {
 	},							\
 }
 
+#define MXC4005_CHANNEL_ORIENTATION(_axis) {			\
+	.type = IIO_ROT,					\
+	.modified = 1,						\
+	.channel2 = IIO_MOD_##_axis,				\
+	.address = MXC4005_REG_TILT_ORIENT,			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+	.scan_index = -1,					\
+}
+
 static const struct iio_chan_spec mxc4005_channels[] = {
 	MXC4005_CHANNEL(X, MXC4005_REG_XOUT_UPPER),
 	MXC4005_CHANNEL(Y, MXC4005_REG_YOUT_UPPER),
 	MXC4005_CHANNEL(Z, MXC4005_REG_ZOUT_UPPER),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
+	MXC4005_CHANNEL_ORIENTATION(X_AND_Y),
+	MXC4005_CHANNEL_ORIENTATION(Z),
 };
 
 static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
-- 
2.36.1

