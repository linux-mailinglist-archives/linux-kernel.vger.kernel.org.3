Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7664B27DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiBKO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350803AbiBKO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:15 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4B21F;
        Fri, 11 Feb 2022 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589689; x=1676125689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2YbGiltNp/YE4sAiVmdcESfjGWWvEMo8y3ASodgdy24=;
  b=ASSIUh4/GBZc//5scbIVr5axhNENCuiYSoyZlMmjqT2GLi6Biw/r7YEl
   1QJphKAPdXzIMtQPSMSDBBkDN2dKEctaO87NO3uz3dcSSeyF4N0XrOXh9
   FUylGNeSrsPAAhJRFTYdrEMgidaiSt3rnueaTvFzBOgpEA6ExYOjyJcGZ
   j3BfF9Vmhu5x76Gr0fk01h3e5ENE4+rytdkz739FVWdSW/TS+mJVAYAdl
   d4zUn4U61dbaY9q4Q6ixiCdYuB+mo9Cl16IApZ12+ek26r3VHAWSCacK/
   kwIHctHGosaarootPcGHlKPZZ22mur7l8tLRYFNLiNQeAaapuUN7vjrjB
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042291"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Feb 2022 15:28:02 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 11 Feb 2022 15:28:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 11 Feb 2022 15:28:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589682; x=1676125682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2YbGiltNp/YE4sAiVmdcESfjGWWvEMo8y3ASodgdy24=;
  b=RVnyBrXpP49Mnw3iSjq5n36YBxv+AjKKAhB8lryGc/V9ZSEJRMZ6uGr5
   HgS9tw/9Ax7nz9aSy+8c4PqHcooukytnpx3xl8/kHEZBWCAXYadSgwCGZ
   pv+i/SP1S2w5575egc6DFYxZbpgdVPZy1MuCDZcAOJFKI+rerBCtTy5nX
   9p1BbMAc1s3DgMGOr3v9hJZC9HVHQriaPLWiaQMjpKuA3eHYZHEnoCFBV
   mbRbnQ7+I7Xkx6NTf84c/SkFyb04QZTkdtt6rQ3etc1hwHraZO7oL5ekg
   bnZzDkROzk/ZspBfXpmOBE0j1ymFhbLHTHKeGRLbtZOAKkciEl+W33SBE
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042290"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:02 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6C212280082;
        Fri, 11 Feb 2022 15:28:02 +0100 (CET)
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
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] media: imx: utils: Add more Bayer formats
Date:   Fri, 11 Feb 2022 15:27:50 +0100
Message-Id: <20220211142752.779952-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
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

Without this the ioctl VIDIOC_ENUM_FMT will not list the 10/12/14-Bit
Bayer formats. This in return results in
"v4l2-ctl --set-fmt-video pixelformat='RG10'" failing to set the
pixelformat.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Added Reviewed-by: Laurent Pinchart

 drivers/staging/media/imx/imx-media-utils.c | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index e59aaa77172a..57eb1c5897c0 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -130,6 +130,78 @@ static const struct imx_media_pixfmt pixel_formats[] = {
 		.cs     = IPUV3_COLORSPACE_RGB,
 		.bpp    = 8,
 		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB10,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB10_1X10),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 10,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB12,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB12_1X12),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 12,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SBGGR14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SBGGR14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGBRG14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGBRG14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SGRBG14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SGRBG14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
+	}, {
+		.fourcc = V4L2_PIX_FMT_SRGGB14,
+		.codes  = IMX_BUS_FMTS(MEDIA_BUS_FMT_SRGGB14_1X14),
+		.cs     = IPUV3_COLORSPACE_RGB,
+		.bpp    = 14,
+		.bayer  = true,
 	}, {
 		.fourcc = V4L2_PIX_FMT_SBGGR16,
 		.codes  = IMX_BUS_FMTS(
-- 
2.25.1

