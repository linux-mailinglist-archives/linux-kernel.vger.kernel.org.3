Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A4585B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiG3QUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3QUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 12:20:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA6EE12;
        Sat, 30 Jul 2022 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659198020; x=1690734020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KMxqD33OIAG5+LVA9hLBAgj59Xmw6ck7YXvwZ5dHDn4=;
  b=ctKrE4vfxeBEgG0qz23nDSVPfoqL91aTrgZZc4p3jJhgDXwg4SGEbYqj
   rjZbtdURxhTPWULOhdb9pPJdJJBx6Kk6Szlkyc7zUGQV5Lr0XqdrfLFql
   UR0A3Fz+TdpGKYP0RsV67LGdxR4MtnqkoEtWgfOgl0VMOSdPBnfvvPoOa
   o1Yd2gGLj2jvNfdPpUxX6K0f32TA3BZFdKhfgt4Pv92S7MyhdvVO4/upJ
   LPpuAXalhFUfK270crRy33IA0RWz4iOtMLYPKop3yVpszwpiIM8dxg68B
   uOXQatAhRsC/oudrXKclqRftGdsBQ5lst9uxQqh4BMw+/JHZIcYQ9sokH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375231589"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="375231589"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 09:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="691026007"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2022 09:20:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 075A4F1; Sat, 30 Jul 2022 19:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] media: atomisp_gmin_platform: Unexport and split camera_sensor_csi()
Date:   Sat, 30 Jul 2022 19:20:27 +0300
Message-Id: <20220730162027.1011-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera_sensor_csi() is not used outside the module, hence make it
static. While at it, split it to _alloc() and _free() to clearly show
the idea behind the last parameter @flag that is passed to
gmin_csi_cfg().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../include/linux/atomisp_gmin_platform.h     |  2 -
 .../media/atomisp/pci/atomisp_gmin_platform.c | 68 ++++++++++---------
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_gmin_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_gmin_platform.h
index 58e0ea5355a3..5463d11d4295 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_gmin_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_gmin_platform.h
@@ -26,8 +26,6 @@ struct v4l2_subdev *atomisp_gmin_find_subdev(struct i2c_adapter *adapter,
 int atomisp_gmin_remove_subdev(struct v4l2_subdev *sd);
 int gmin_get_var_int(struct device *dev, bool is_gmin,
 		     const char *var, int def);
-int camera_sensor_csi(struct v4l2_subdev *sd, u32 port,
-		      u32 lanes, u32 format, u32 bayer_order, int flag);
 struct camera_sensor_platform_data *
 gmin_camera_platform_data(
     struct v4l2_subdev *subdev,
diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index f7fc5137199c..4032239fcb86 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1066,6 +1066,38 @@ static int gmin_flisclk_ctrl(struct v4l2_subdev *subdev, int on)
 	return ret;
 }
 
+static int camera_sensor_csi_alloc(struct v4l2_subdev *sd, u32 port, u32 lanes,
+				   u32 format, u32 bayer_order)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(sd);
+	struct camera_mipi_info *csi;
+
+	csi = kzalloc(sizeof(*csi), GFP_KERNEL);
+	if (!csi)
+		return -ENOMEM;
+
+	csi->port = port;
+	csi->num_lanes = lanes;
+	csi->input_format = format;
+	csi->raw_bayer_order = bayer_order;
+	v4l2_set_subdev_hostdata(sd, csi);
+	csi->metadata_format = ATOMISP_INPUT_FORMAT_EMBEDDED;
+	csi->metadata_effective_width = NULL;
+	dev_info(&client->dev,
+		 "camera pdata: port: %d lanes: %d order: %8.8x\n",
+		 port, lanes, bayer_order);
+
+	return 0;
+}
+
+static void camera_sensor_csi_free(struct v4l2_subdev *sd)
+{
+	struct camera_mipi_info *csi;
+
+	csi = v4l2_get_subdev_hostdata(sd);
+	kfree(csi);
+}
+
 static int gmin_csi_cfg(struct v4l2_subdev *sd, int flag)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
@@ -1074,8 +1106,11 @@ static int gmin_csi_cfg(struct v4l2_subdev *sd, int flag)
 	if (!client || !gs)
 		return -ENODEV;
 
-	return camera_sensor_csi(sd, gs->csi_port, gs->csi_lanes,
-				 gs->csi_fmt, gs->csi_bayer, flag);
+	if (flag)
+		return camera_sensor_csi_alloc(sd, gs->csi_port, gs->csi_lanes,
+					       gs->csi_fmt, gs->csi_bayer);
+	camera_sensor_csi_free(sd);
+	return 0;
 }
 
 static struct camera_vcm_control *gmin_get_vcm_ctrl(struct v4l2_subdev *subdev,
@@ -1358,35 +1393,6 @@ int gmin_get_var_int(struct device *dev, bool is_gmin, const char *var, int def)
 }
 EXPORT_SYMBOL_GPL(gmin_get_var_int);
 
-int camera_sensor_csi(struct v4l2_subdev *sd, u32 port,
-		      u32 lanes, u32 format, u32 bayer_order, int flag)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(sd);
-	struct camera_mipi_info *csi = NULL;
-
-	if (flag) {
-		csi = kzalloc(sizeof(*csi), GFP_KERNEL);
-		if (!csi)
-			return -ENOMEM;
-		csi->port = port;
-		csi->num_lanes = lanes;
-		csi->input_format = format;
-		csi->raw_bayer_order = bayer_order;
-		v4l2_set_subdev_hostdata(sd, (void *)csi);
-		csi->metadata_format = ATOMISP_INPUT_FORMAT_EMBEDDED;
-		csi->metadata_effective_width = NULL;
-		dev_info(&client->dev,
-			 "camera pdata: port: %d lanes: %d order: %8.8x\n",
-			 port, lanes, bayer_order);
-	} else {
-		csi = v4l2_get_subdev_hostdata(sd);
-		kfree(csi);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(camera_sensor_csi);
-
 /* PCI quirk: The BYT ISP advertises PCI runtime PM but it doesn't
  * work.  Disable so the kernel framework doesn't hang the device
  * trying.  The driver itself does direct calls to the PUNIT to manage
-- 
2.35.1

