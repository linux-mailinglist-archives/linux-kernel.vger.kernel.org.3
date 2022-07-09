Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775F656C9AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGINvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGINvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 09:51:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CF3CBDF;
        Sat,  9 Jul 2022 06:51:04 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n68so1288016iod.3;
        Sat, 09 Jul 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhrFKWsUCK+BEM0aD0PrGGBv2e+dmfgaO+e2DAm5ZiE=;
        b=O9uPFm51xM7K/hgLWUIW74XZXRNNWTWWThuRBvqm3TbblTxJozdWj9lPD/Qieghg0M
         uGxAaOO36kyvhqAQ7GY9i4hpwwROU0AwLtZfzveVNiDeSBKIWEd5kpXjWiHSKHICJO3s
         IM8co9HVRxopSuLnq50DNVK1pOO1hP9caboruKR7qBzWd5l5vQ6KYuTwNgONAr03Mh+a
         xYv/PQE9f95tyF8vS9GSVQDZFay+DiN3dmrt0EpnlEva4M0hiscANAy90kOiYMxE5jdt
         6j1tOMf+g3dir4KkhAQzZvJbFxLCt0yQsMAfQXNFFh+brxx6J0Mzx+G1VaUBwK6O2acc
         CyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhrFKWsUCK+BEM0aD0PrGGBv2e+dmfgaO+e2DAm5ZiE=;
        b=OZuMDcW5vir8vMbzl/Y3w/h9j+q5Kf6xXBN7n+aFyQti1Yjrpan0C/zq2DAhDhHtmY
         1wj7Q1rwxvPVIp25+SH2du7485RUVhiiO8jTi0QhLX6b0BEsJdGiaBvcUeuDlGRWzKKR
         QAgYrEa+BgKADMxlXRFO4HskXE7sP37nEiwjeyl2uZtrZPaFoEj/Qo++hQVDS2XCSw8+
         9qSJdsfGFNAFsb615zpbgUXO1HxlvElV4iKdKyMJSI78c4c65QUKXR7K2hoXLolwhaYk
         XJr0/F7xsvzSpBvH7H1BCxf5IzmMAGKU9RvgtNMnDLRITEaltIeeOLWwYVH42RDPgBH8
         jqCw==
X-Gm-Message-State: AJIora/pHeTwN9FKDdgnhqDhhsxk9jVyzUvxpsRXX2CkQxFxt7hKBxGz
        iIze+4xdTJc/FyC4Ib+sQG6bJbPSNSD/pg==
X-Google-Smtp-Source: AGRyM1vvZBKEC12QLqFg9kHGAU8PXpG/tJ2fNzo2LCKP78NqdF/KGiqH9Hkb3wf0NpmGiMis7ftFzA==
X-Received: by 2002:a02:8797:0:b0:33c:8c21:5a3c with SMTP id t23-20020a028797000000b0033c8c215a3cmr5125292jai.172.1657374663627;
        Sat, 09 Jul 2022 06:51:03 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:4a65:3ca1:59ec:e66b])
        by smtp.gmail.com with ESMTPSA id p133-20020a02298b000000b0033f3e34f3b4sm635441jap.150.2022.07.09.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 06:51:03 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     dave.stevenson@raspberrypi.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, Adam Ford <aford173@gmail.com>
Subject: [PATCH 2/2] media: i2c: imx219: Support four-lane operation
Date:   Sat,  9 Jul 2022 08:50:52 -0500
Message-Id: <20220709135052.3850913-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220709135052.3850913-1-aford173@gmail.com>
References: <20220709135052.3850913-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx219 camera is capable of either two-lane or four-lane
operation.  When operating in four-lane, both the pixel rate and
link frequency change. Regardless of the mode, however, both
frequencies remain fixed.

Helper functions are needed to read and set pixel and link frequencies
which also reduces the number of fixed registers in the table of modes.

Since the link frequency and number of lanes is extracted from the
endpoint, move the endpoint handling into the probe function and
out of the imx219_check_hwcfg.  This simplifies the imx219_check_hwcfg
just a bit.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Keep the helper function doing the link and lane parsing to
     keep th probe function small.

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index faa5dab3c2ec..bb4125e7e113 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -42,10 +42,16 @@
 /* External clock frequency is 24.0M */
 #define IMX219_XCLK_FREQ		24000000
 
-/* Pixel rate is fixed at 182.4M for all the modes */
+/* Pixel rate is fixed for all the modes */
 #define IMX219_PIXEL_RATE		182400000
+#define IMX219_PIXEL_RATE_4LANE		280800000
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
+#define IMX219_DEFAULT_LINK_FREQ_4LANE	363000000
+
+#define IMX219_REG_CSI_LANE_MODE	0x0114
+#define IMX219_CSI_2_LANE_MODE		0x01
+#define IMX219_CSI_4_LANE_MODE		0x03
 
 /* V_TIMING internal */
 #define IMX219_REG_VTS			0x0160
@@ -299,6 +305,10 @@ static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
 };
 
+static const s64 imx219_link_freq_4lane_menu[] = {
+	IMX219_DEFAULT_LINK_FREQ_4LANE,
+};
+
 static const char * const imx219_test_pattern_menu[] = {
 	"Disabled",
 	"Color Bars",
@@ -474,6 +484,9 @@ struct imx219 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* Two or Four lanes */
+	u8 lanes;
 };
 
 static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
@@ -936,6 +949,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int imx219_configure_lanes(struct imx219 *imx219)
+{
+	return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
+				IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
+				IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
+};
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -953,6 +973,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
+	/* Configure two or four Lane mode */
+	ret = imx219_configure_lanes(imx219);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
@@ -1184,6 +1211,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
 	.open = imx219_open,
 };
 
+static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
+{
+	return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
+}
+
 /* Initialize control handlers */
 static int imx219_init_controls(struct imx219 *imx219)
 {
@@ -1205,15 +1237,16 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* By default, PIXEL_RATE is read only */
 	imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					       V4L2_CID_PIXEL_RATE,
-					       IMX219_PIXEL_RATE,
-					       IMX219_PIXEL_RATE, 1,
-					       IMX219_PIXEL_RATE);
+					       imx219_get_pixel_rate(imx219),
+					       imx219_get_pixel_rate(imx219), 1,
+					       imx219_get_pixel_rate(imx219));
 
 	imx219->link_freq =
 		v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
 				       V4L2_CID_LINK_FREQ,
 				       ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
-				       imx219_link_freq_menu);
+				       (imx219->lanes == 2) ? imx219_link_freq_menu :
+				       imx219_link_freq_4lane_menu);
 	if (imx219->link_freq)
 		imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
@@ -1308,7 +1341,7 @@ static void imx219_free_controls(struct imx219 *imx219)
 	mutex_destroy(&imx219->mutex);
 }
 
-static int imx219_check_hwcfg(struct device *dev)
+static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
 {
 	struct fwnode_handle *endpoint;
 	struct v4l2_fwnode_endpoint ep_cfg = {
@@ -1328,10 +1361,12 @@ static int imx219_check_hwcfg(struct device *dev)
 	}
 
 	/* Check the number of MIPI CSI2 data lanes */
-	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
-		dev_err(dev, "only 2 data lanes are currently supported\n");
+	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2 &&
+	    ep_cfg.bus.mipi_csi2.num_data_lanes != 4) {
+		dev_err(dev, "only 2 or 4 data lanes are currently supported\n");
 		goto error_out;
 	}
+	imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
 
 	/* Check the link frequency set in device tree */
 	if (!ep_cfg.nr_of_link_frequencies) {
@@ -1339,8 +1374,8 @@ static int imx219_check_hwcfg(struct device *dev)
 		goto error_out;
 	}
 
-	if (ep_cfg.nr_of_link_frequencies != 1 ||
-	    ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
+	if (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
+	    IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE)) {
 		dev_err(dev, "Link frequency not supported: %lld\n",
 			ep_cfg.link_frequencies[0]);
 		goto error_out;
@@ -1368,7 +1403,7 @@ static int imx219_probe(struct i2c_client *client)
 	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
 
 	/* Check the hardware configuration in device tree */
-	if (imx219_check_hwcfg(dev))
+	if (imx219_check_hwcfg(dev, imx219))
 		return -EINVAL;
 
 	/* Get system clock (xclk) */
-- 
2.34.1

