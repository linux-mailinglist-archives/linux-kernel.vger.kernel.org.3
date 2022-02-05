Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984D4AAB7E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381259AbiBES4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:56:17 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39641 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381189AbiBESz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:26 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 46E76240002;
        Sat,  5 Feb 2022 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GwbC5gn4h2V2gFK4wGghF7MDfEkNG/IYlc1iEgQerj0=;
        b=L1JXL3Qty8YbjkBCLhJVJAw9Iqd4UQldBGCTyzEEJkgRDRu2AsUoq3UeW7TuMfbaxUNkwa
        m7infW20DxJQin+WbsuHe6ut42BABmKqYtmwLcdl+VBCTcFFktcTdJkK6v2rPxSxoBezmP
        pydAO11+Uh9weVgn9rbYVfZv2SeAv8i0y+pifvy7y8ZqW0/WAqPVzNd6F/RmlyN1lE5E2w
        bHH8ptkwgdHAqjiat3CtNSiwIVmPcBVI0DJFqBpSVVhvj8CZa4h/q5EuF/zkHeEiy3oQQw
        uIhGXLGdmytN6Udakwg1xk1B1D7pX6ghmO2Jpuv8BN+St7Tx755v3iKDpTnVzA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 26/66] media: sun6i-csi: Register the media device after creation
Date:   Sat,  5 Feb 2022 19:53:49 +0100
Message-Id: <20220205185429.2278860-27-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no particular need to register the media device in the
subdev notify complete callback.

Register it in the v4l2 code instead where it's more in-context.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 688288afae68..6f04f86504bf 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -638,7 +638,7 @@ static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
 	if (ret < 0)
 		return ret;
 
-	return media_device_register(&v4l2->media_dev);
+	return 0;
 }
 
 static const struct v4l2_async_notifier_operations sun6i_csi_async_ops = {
@@ -687,6 +687,12 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 
 	media_device_init(media_dev);
 
+	ret = media_device_register(media_dev);
+	if (ret) {
+		dev_err(dev, "failed to register media device: %d\n", ret);
+		goto error_media;
+	}
+
 	/* V4L2 Control Handler */
 
 	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
@@ -746,6 +752,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 
 error_media:
+	media_device_unregister(media_dev);
 	media_device_cleanup(media_dev);
 
 	return ret;
-- 
2.34.1

