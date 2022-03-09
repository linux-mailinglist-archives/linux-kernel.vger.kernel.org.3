Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B94D2E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiCILnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiCILm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:42:56 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394F16BCE0;
        Wed,  9 Mar 2022 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826117; x=1678362117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KJ+O3nYPIihhIJRWVWC0Ti5XvYqw22h8GOfUjQMO6g=;
  b=RqYeDzGPLAkgSxyfgbrupWLPhlyUmPj2DJtsNaHbyNwSACxHKPlpZpur
   82pnpEtCadvk7HaccQS8lRwyG4Qq/b95ILSIJX1NpOxet+E3Z77QK0lYy
   LxKZgpwegyvfVnV8oDcttm+PkOg0Jp6AwOKMqjgwnNK74d56hvpD9FmB/
   BiofGWmhBWU1WN2A/46BTdI8kifYY79/lbnq+kDM0pnAjXIpQ+S0R9Okg
   jztP58q26MqdVTo1O243U6KE4Uep2vjOUtgdGEzajrkwLCHW911mpsPke
   Jhk/mDvAyxFS51DGuStwg5gAUbkpJ/In6oJwO66udrHMFrLJXM37AZL2D
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553362"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2022 12:41:53 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Mar 2022 12:41:54 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Mar 2022 12:41:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826114; x=1678362114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KJ+O3nYPIihhIJRWVWC0Ti5XvYqw22h8GOfUjQMO6g=;
  b=MoV0fOnBB/Pbka/c+R3xkAE3pMxhNflkz11Zhv8Vpkxl9MJR96oGmH9f
   aBI+m2SKAE/Fdsnw16bDxgpVU6pdFtHUUZzPGpuwjb3rBDv4GhwBzyqFF
   JE0rllsbm88mhnCj1Webz6gISDUtGnnsKtvifpl/ZUDqzQsR1FKtoAtyW
   4fc+dtfchXurYZXCKYdVFIgWGv8gGeYy/o0aBvOKXdGudOSYd+K/CU5fl
   8GLpttv5K0ILhPbPpaurbusSrSUQwWAnTwNt//Gm+StZpv8uWhMcyWryN
   +Ff4hLWwXqRILwlpK/DDXbOY4X11ARpsCDONx5dD0LcSJ2KYlsT5c2yIe
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553361"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2022 12:41:53 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 88D4E280065;
        Wed,  9 Mar 2022 12:41:53 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v3 2/8] media: imx: Forward type of hardware implementation
Date:   Wed,  9 Mar 2022 12:41:38 +0100
Message-Id: <20220309114144.120643-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
References: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

Pass down the hardware type so imx_media_mbus_fmt_to_pix_fmt can do
the actual switch.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* None

 drivers/staging/media/imx/imx-media-capture.c | 15 +++++++++------
 drivers/staging/media/imx/imx-media-utils.c   |  3 ++-
 drivers/staging/media/imx/imx-media.h         |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 65dc95a48ecc..7a6384b3e5e6 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -139,7 +139,8 @@ static int capture_g_fmt_vid_cap(struct file *file, void *fh,
 }
 
 static const struct imx_media_pixfmt *
-__capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
+__capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose,
+		  enum imx_media_device_type type)
 {
 	struct v4l2_mbus_framefmt fmt_src;
 	const struct imx_media_pixfmt *cc;
@@ -171,7 +172,7 @@ __capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
 	}
 
 	v4l2_fill_mbus_format(&fmt_src, pixfmt, 0);
-	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src, cc);
+	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src, cc, type);
 
 	if (compose) {
 		compose->width = fmt_src.width;
@@ -184,7 +185,9 @@ __capture_try_fmt(struct v4l2_pix_format *pixfmt, struct v4l2_rect *compose)
 static int capture_try_fmt_vid_cap(struct file *file, void *fh,
 				   struct v4l2_format *f)
 {
-	__capture_try_fmt(&f->fmt.pix, NULL);
+	struct capture_priv *priv = video_drvdata(file);
+
+	__capture_try_fmt(&f->fmt.pix, NULL, priv->type);
 	return 0;
 }
 
@@ -199,7 +202,7 @@ static int capture_s_fmt_vid_cap(struct file *file, void *fh,
 		return -EBUSY;
 	}
 
-	cc = __capture_try_fmt(&f->fmt.pix, &priv->vdev.compose);
+	cc = __capture_try_fmt(&f->fmt.pix, &priv->vdev.compose, priv->type);
 
 	priv->vdev.cc = cc;
 	priv->vdev.fmt = f->fmt.pix;
@@ -418,7 +421,7 @@ __capture_legacy_try_fmt(struct capture_priv *priv,
 		}
 	}
 
-	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src->format, cc);
+	imx_media_mbus_fmt_to_pix_fmt(pixfmt, &fmt_src->format, cc, priv->type);
 
 	return cc;
 }
@@ -889,7 +892,7 @@ static int capture_init_format(struct capture_priv *priv)
 		fmt_src.format.height = IMX_MEDIA_DEF_PIX_HEIGHT;
 	}
 
-	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt, &fmt_src.format, NULL);
+	imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt, &fmt_src.format, NULL, priv->type);
 	vdev->compose.width = fmt_src.format.width;
 	vdev->compose.height = fmt_src.format.height;
 
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 94bc866ca28c..c42f3da8e3a8 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -518,7 +518,8 @@ EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
 
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 				  const struct v4l2_mbus_framefmt *mbus,
-				  const struct imx_media_pixfmt *cc)
+				  const struct imx_media_pixfmt *cc,
+				  enum imx_media_device_type type)
 {
 	u32 width;
 	u32 stride;
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index e4c22b3ccd57..f59feccb26bf 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -203,7 +203,8 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
 			       bool ic_route);
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 				  const struct v4l2_mbus_framefmt *mbus,
-				  const struct imx_media_pixfmt *cc);
+				  const struct imx_media_pixfmt *cc,
+				  enum imx_media_device_type type);
 void imx_media_grp_id_to_sd_name(char *sd_name, int sz,
 				 u32 grp_id, int ipu_id);
 struct v4l2_subdev *
-- 
2.25.1

