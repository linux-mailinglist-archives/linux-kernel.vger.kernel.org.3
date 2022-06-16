Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2554E0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376987AbiFPMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbiFPMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:31:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8F4DF7E;
        Thu, 16 Jun 2022 05:31:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v10so1825997qvh.9;
        Thu, 16 Jun 2022 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCCtkV0YGTfM+1jj8ZPztr6xh44iTCDAwetDuNnZjPo=;
        b=qYsT0rvCHY+GmzOSIsndXsvrJVreEisSvS7UWu15pUv/ZG8cLe0NO/KTo8pU7jVYy6
         70yyQnHVOcioOf2ZEEmjVzWoKiwdX5xP6QIW7Mqky7t8ncd2MFMIl3YZ6EB+M51gXmq3
         qHs+JV+rMSGZvqjAVHlCU6iN3rTSmd8YtFV773l3pWkSzSD6zLY8baeIFaV6tnXN3wLO
         lOmdoQRvVMiHAaw39K/Me8doerV/jhxmDWpmbq2rLH4mT1A0pcVEtvZLfzL/QZzZWYvW
         SsR7fTdjYgKgXGsboke7+M8IGmgTgQ23OfcSTwydsW9CkeYXNUVJ4hdJnB8sJbdzpgVA
         6iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCCtkV0YGTfM+1jj8ZPztr6xh44iTCDAwetDuNnZjPo=;
        b=pam5QyJfHkEuN51jnnRQZrBAI7OQHrZ58inXzES60F5HWXmJuHF+JJlNkIQh8WcSnZ
         t71pLla3ZZWm5gY/y0yI0cmC445pfj0ubQ5Tj+mWSzbYPiJmJMoWyiFDLSTNvHIoh39U
         fiiB8gQ9Sml95ZQeIvGcE4Ul4FV1PpC8skcSAWyAITMEiERptH1a5tQECdD5DvM82BiT
         IHTk3eJjeyztk7Wltz6CsvvQ2wdMSwRIZcp6Qb0O6DBCiuekq9XMyhzZrXLlw+VVi/l+
         U2mh3DYB5ZV8JBBmFyNwUxNcCgDYMkVkvxpniV+nKT+hdcqZjEZVA8ZmkALIRG17fy2K
         NEog==
X-Gm-Message-State: AJIora8/5rfdNMLKLGfVOog7n9tQyGRCzl3EEchq6+lmJr4Z++Wj0y/a
        IYWTfXZFExbaY0rN5JufVbFXchF3tm4=
X-Google-Smtp-Source: AGRyM1uPe9vsePPuDzbYQ+T+8dUYJgENSpSdIRFpYdJVpEdh72d2s5+bNVyNJHkI/NYXiCm3O1Rx6A==
X-Received: by 2002:a05:622a:550:b0:305:2905:a230 with SMTP id m16-20020a05622a055000b003052905a230mr3680619qtx.478.1655382714573;
        Thu, 16 Jun 2022 05:31:54 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id k20-20020a05620a415400b006a6f1c30701sm1697979qko.115.2022.06.16.05.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:31:54 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     dave.stevenson@raspberrypi.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH V2 2/2] media: i2c: imx219: Support four-lane operation
Date:   Thu, 16 Jun 2022 07:31:50 -0500
Message-Id: <20220616123150.5890-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616123150.5890-1-aford173@gmail.com>
References: <20220616123150.5890-1-aford173@gmail.com>
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
V2:  Replace if-else statements with ternary operator
     Fix 4-lane Link Rate.
     Fix checking the link rate so only the link rate for
     the given number of lanes is permitted.

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index a43eed143999..0d9004a5c4d2 100644
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
@@ -306,6 +312,10 @@ static const s64 imx219_link_freq_menu[] = {
 	IMX219_DEFAULT_LINK_FREQ,
 };
 
+static const s64 imx219_link_freq_4lane_menu[] = {
+	IMX219_DEFAULT_LINK_FREQ_4LANE,
+};
+
 static const char * const imx219_test_pattern_menu[] = {
 	"Disabled",
 	"Color Bars",
@@ -481,6 +491,9 @@ struct imx219 {
 
 	/* Streaming on/off */
 	bool streaming;
+
+	/* Two or Four lanes */
+	u8 lanes;
 };
 
 static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
@@ -943,6 +956,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
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
@@ -960,6 +980,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
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
@@ -1191,6 +1218,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
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
@@ -1212,15 +1244,16 @@ static int imx219_init_controls(struct imx219 *imx219)
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
 
@@ -1315,67 +1348,76 @@ static void imx219_free_controls(struct imx219 *imx219)
 	mutex_destroy(&imx219->mutex);
 }
 
-static int imx219_check_hwcfg(struct device *dev)
+static int imx219_check_hwcfg(struct imx219 *imx219, u64 link_frequency)
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
+	if (link_frequency != ((imx219->lanes == 2) ?
+			      IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE)) {
+		dev_err(&client->dev, "Link frequency not supported: %lld\n",
+			link_frequency);
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
+	u64 link_frequency = 0;
 
+	imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
+	if (!imx219)
+		return -ENOMEM;
+
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
 
 	/* Check the link frequency set in device tree */
-	if (!ep_cfg.nr_of_link_frequencies) {
+	if (ep_cfg.nr_of_link_frequencies != 1) {
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
+	link_frequency = ep_cfg.link_frequencies[0];
 
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
+	if (imx219_check_hwcfg(imx219, link_frequency))
 		return -EINVAL;
 
 	/* Get system clock (xclk) */
-- 
2.34.1

