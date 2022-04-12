Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C34FE33C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356633AbiDLN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356551AbiDLN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:58:06 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348145C363;
        Tue, 12 Apr 2022 06:55:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 9so22359972iou.5;
        Tue, 12 Apr 2022 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8DeuU4bXc6zU0q+bgkdN6fbdKB+U/wdEnUo15LU1Nc=;
        b=QnlX9EilNA8BiDeOisYscb5ns5BE43Aq1VmpvLkYJqwkmonoaIUpo/5rSvKq3gkazK
         THXifA6e77zCxsPBbrzgptTmWWAhWYmCCabRqYuNscENpjM36Q7vjuttvpLWhTFYQFbG
         fY/kQrDGcsIFt+JOwhF7X0Dre/8jQ/tB6eQkGsQIkEXDr0X+vHnGa+zQnOBG1RGjNbI8
         GvdmmedIegLhHyqImOrqi7cBx8th3R2L2cypPFKpoHJd0btz1qAfwylQsWAveGjRmOWw
         /Wk26FP5sWy0R5OrbYX5uZQ1qdIbQZniRP5O4NsWGIsjwnH7XdbOSj5FbKS23WFpnqIk
         vR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8DeuU4bXc6zU0q+bgkdN6fbdKB+U/wdEnUo15LU1Nc=;
        b=naHccf6H+hIA4QTlAzkcaW623nQ93krFrdj30ilXU9pxujOeZ6pAPeRerpN1vWTYkv
         UBHGBTtgbZ40O161aCCPSW6dAKMXVG1HqYpzbsXXfEW3FDLqCjsPn2PfJr1r39ctVKI4
         8ghd8i4SHbJaWbTtzI6ww+yKmWjabnH6ybqJpz3KoUEM/0gaFfklx8NUK+E716l+cp3H
         TjBskUadoX0RsLFaJEPDfJjhFXHKv4n7ImskjOxcEot7qkFAUfiSUomBLPQsf8DWYuvT
         lvQ8kTe0dEJ+NpAdbjs7hgCzhlY4DxqYeEh/xeWC6vYjw6QNRXmREKdunhDqwsaS6PXn
         YXrg==
X-Gm-Message-State: AOAM531vqZZ/UXukMGxpRtf6QMPr+qDovqQhpMKLID32sR2kGiHW0y6/
        n4X+vqc1gboxSHjzxsVMdHaFE+lEBm+57g==
X-Google-Smtp-Source: ABdhPJw4jLdO5Vlakce9yzwJiCHyVez7b4GNZPVyrDslqPWh+rn6M0zcpKSTD6XI/2kkDlZNbWbKVA==
X-Received: by 2002:a05:6638:1301:b0:323:3b47:8b3f with SMTP id r1-20020a056638130100b003233b478b3fmr18100042jad.291.1649771747175;
        Tue, 12 Apr 2022 06:55:47 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2611:a7ae:f1c9:5ec2])
        by smtp.gmail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm2280748ilm.0.2022.04.12.06.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tharvey@gateworks.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] media: i2c: imx219: Support four-lane operation
Date:   Tue, 12 Apr 2022 08:55:31 -0500
Message-Id: <20220412135534.2796158-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412135534.2796158-1-aford173@gmail.com>
References: <20220412135534.2796158-1-aford173@gmail.com>
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
just a bit, and places all the parameters into the imx219 structure.
It then allows imx219_check_hwcfg to simply validate the settings.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/media/i2c/imx219.c | 144 ++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 48 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index b7cc36b16547..d13ce5c1ece6 100644
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
+#define IMX219_DEFAULT_LINK_FREQ_4LANE	702000000
+
+#define IMX219_REG_CSI_LANE_MODE	0x0114
+#define IMX219_CSI_2_LANE_MODE		0x01
+#define IMX219_CSI_4_LANE_MODE		0x03
 
 /* V_TIMING internal */
 #define IMX219_REG_VTS			0x0160
@@ -175,7 +181,6 @@ static const struct imx219_reg pll_clk_table[] = {
  * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
  */
 static const struct imx219_reg mode_3280x2464_regs[] = {
-	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
 	{0x012b, 0x00},
@@ -216,7 +221,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 };
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
-	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
 	{0x012b, 0x00},
@@ -257,7 +261,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 };
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
-	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
 	{0x012b, 0x00},
@@ -298,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 };
 
 static const struct imx219_reg mode_640_480_regs[] = {
-	{0x0114, 0x01},
 	{0x0128, 0x00},
 	{0x012a, 0x18},
 	{0x012b, 0x00},
@@ -352,6 +354,7 @@ static const struct imx219_reg raw10_framefmt_regs[] = {
 
 static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
+	IMX219_DEFAULT_LINK_FREQ_4LANE,
 };
 
 static const char * const imx219_test_pattern_menu[] = {
@@ -529,6 +532,13 @@ struct imx219 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* Two or Four lanes */
+	u8 lanes;
+
+	/* Link Frequency info */
+	unsigned int nr_of_link_frequencies;
+	u64 link_frequency;
 };
 
 static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
@@ -991,6 +1001,20 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int imx219_configure_lanes(struct imx219 *imx219)
+{
+	int ret;
+
+	/* imx219->lanes has already been validated to be either 2 or 4 */
+	if (imx219->lanes == 2)
+		ret = imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
+				       IMX219_REG_VALUE_08BIT, IMX219_CSI_2_LANE_MODE);
+	else
+		ret = imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
+				       IMX219_REG_VALUE_08BIT, IMX219_CSI_4_LANE_MODE);
+	return ret;
+};
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -1008,6 +1032,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
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
@@ -1247,6 +1278,14 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
 	.open = imx219_open,
 };
 
+static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
+{
+	if (imx219->lanes == 2)
+		return IMX219_PIXEL_RATE;
+	else
+		return IMX219_PIXEL_RATE_4LANE;
+}
+
 /* Initialize control handlers */
 static int imx219_init_controls(struct imx219 *imx219)
 {
@@ -1268,14 +1307,15 @@ static int imx219_init_controls(struct imx219 *imx219)
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
-				       ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
+				       ARRAY_SIZE(imx219_link_freq_menu) - 1,
+				       (imx219->lanes == 4),
 				       imx219_link_freq_menu);
 	if (imx219->link_freq)
 		imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
@@ -1371,67 +1411,75 @@ static void imx219_free_controls(struct imx219 *imx219)
 	mutex_destroy(&imx219->mutex);
 }
 
-static int imx219_check_hwcfg(struct device *dev)
+static int imx219_check_hwcfg(struct imx219 *imx219)
 {
-	struct fwnode_handle *endpoint;
+	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
+
+	/* Check the number of MIPI CSI2 data lanes */
+	if (imx219->lanes != 2 && imx219->lanes != 4) {
+		dev_err(&client->dev, "only 2 or 4 data lanes are currently supported\n");
+		return -EINVAL;
+	}
+
+	if (imx219->link_frequency != IMX219_DEFAULT_LINK_FREQ &&
+	    imx219->link_frequency != IMX219_DEFAULT_LINK_FREQ_4LANE) {
+		dev_err(&client->dev, "Link frequency not supported: %lld\n",
+			imx219->link_frequency);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx219_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct imx219 *imx219;
 	struct v4l2_fwnode_endpoint ep_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
 	};
-	int ret = -EINVAL;
+	struct fwnode_handle *endpoint;
+	int ret = 0;
+
+	imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
+	if (!imx219)
+		return -ENOMEM;
 
+	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
+
+	/* Fetch the endpoint to extract lanes and link-frequency */
 	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
 	if (!endpoint) {
 		dev_err(dev, "endpoint node not found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fwnode_cleanup;
 	}
 
 	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg)) {
 		dev_err(dev, "could not parse endpoint\n");
-		goto error_out;
+		ret = -EINVAL;
+		goto fwnode_cleanup;
 	}
 
-	/* Check the number of MIPI CSI2 data lanes */
-	if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
-		dev_err(dev, "only 2 data lanes are currently supported\n");
-		goto error_out;
-	}
+	imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
+	imx219->nr_of_link_frequencies = ep_cfg.nr_of_link_frequencies;
 
-	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
+	if (imx219->nr_of_link_frequencies != 1) {
 		dev_err(dev, "link-frequency property not found in DT\n");
-		goto error_out;
-	}
-
-	if (ep_cfg.nr_of_link_frequencies != 1 ||
-	    ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
-		dev_err(dev, "Link frequency not supported: %lld\n",
-			ep_cfg.link_frequencies[0]);
-		goto error_out;
+		ret = -EINVAL;
+		goto fwnode_cleanup;
 	}
+	imx219->link_frequency = ep_cfg.link_frequencies[0];
 
-	ret = 0;
-
-error_out:
+	/* Cleanup endpoint and handle any errors from above */
+fwnode_cleanup:
 	v4l2_fwnode_endpoint_free(&ep_cfg);
 	fwnode_handle_put(endpoint);
-
-	return ret;
-}
-
-static int imx219_probe(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-	struct imx219 *imx219;
-	int ret;
-
-	imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
-	if (!imx219)
-		return -ENOMEM;
-
-	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
+	if (ret)
+		return ret;
 
 	/* Check the hardware configuration in device tree */
-	if (imx219_check_hwcfg(dev))
+	if (imx219_check_hwcfg(imx219))
 		return -EINVAL;
 
 	/* Get system clock (xclk) */
-- 
2.34.1

