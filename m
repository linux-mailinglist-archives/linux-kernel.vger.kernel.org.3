Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2E4A990C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiBDMPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:36 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:56996 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358576AbiBDMP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976927; x=1675512927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9MfQeFSRHHpb33Jz73vY5dhj1TL4KHQ2EhLys86WNF0=;
  b=OK++KXztMWoqAzV1h29bf9quIx+KmMVgF3ic1IHCy0Piyy46+jVLAQFh
   xOEUN45FVWIFUjngM6Q+L08pH9NP7Eo3gDV0xcKZA2EaUQ+O0eRZY7VzY
   OxFqc53+66G9WPo8BOrtENeXdcwnrCHE2H1qH23CqV/kUx5ksxpaMpBL9
   clNU8GNkHZlK0F8/vR4nN7CNEa2jC0aCGYhf8fCE4Umzrf84AbctIFI8/
   0MjYaHaT7URIsr0MZeFnimmyRZYdP13/NPggYlLWb9zqhOynScQLrSxra
   bVs4xBP6QYqL+3aR4JZOEgN/TO92e4NGhnn5lGvZjvhP+NEfgPAykkZmE
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903434"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976926; x=1675512926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9MfQeFSRHHpb33Jz73vY5dhj1TL4KHQ2EhLys86WNF0=;
  b=Tl/i8ElgbQohSRh9TncCZ2vgP1zO5+V/esxfIspBt8U/htVenhVqpoGW
   Slh50WGzPJHBnnm8PSYSJznNKr4Z2LMWi8pO9xS5jXS2Ceu0I1gtKt35k
   So7yO2v9y52+ibEikUCm4y3v5UYafkDz/PHFUAa51GioCi1d7CD9pIqjs
   oqvjKqXgWIJfAIclqx4zieUTrDC2w39RKvIR/E0A/Jssx7Oe/FPnT+L5/
   2fjiTWbBU+3wIGMzl3b9ANZlSBFAgM6C6xnKF2arkwWwZxoVINKSS2q09
   qfXoFatZuhUHzbYZ7kKZCi0fF2joAiuZyB13lXUkCUEh9QGGFDPBaMwxj
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903433"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D2359280065;
        Fri,  4 Feb 2022 13:15:25 +0100 (CET)
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
Subject: [PATCH 6/8] media: imx: imx7_media-csi: Add support for additional Bayer patterns
Date:   Fri,  4 Feb 2022 13:15:12 +0100
Message-Id: <20220204121514.2762676-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx7_csi_configure() allows configuring these Bayer patterns when
starting a stream. So allow these in link_validate() as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I'm wondering if V4L2_PIX_FMT_SBGGR16 (and their variants) is correct in this
function. imx7_csi_configure() does not list MEDIA_BUS_FMT_Sxxxx16_1X16.
Also I can't find a proper a proper setting in CSI_CR18 of CSI Bridge in
IMX8M Mini RM for RAW16. The feature list names a  "16-bit data port for
Bayer data input", but is it actually supported? I do not know anything about
the MIPI CSI data formats though. Maybe someone else can clarify this.

 drivers/staging/media/imx/imx7-media-csi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 158d2a736c6d..7e737221f187 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1004,6 +1004,18 @@ static int imx7_csi_pad_link_validate(struct v4l2_subdev *sd,
 	case V4L2_PIX_FMT_SGBRG8:
 	case V4L2_PIX_FMT_SGRBG8:
 	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_SBGGR10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SRGGB10:
+	case V4L2_PIX_FMT_SBGGR12:
+	case V4L2_PIX_FMT_SGBRG12:
+	case V4L2_PIX_FMT_SGRBG12:
+	case V4L2_PIX_FMT_SRGGB12:
+	case V4L2_PIX_FMT_SBGGR14:
+	case V4L2_PIX_FMT_SGBRG14:
+	case V4L2_PIX_FMT_SGRBG14:
+	case V4L2_PIX_FMT_SRGGB14:
 	case V4L2_PIX_FMT_SBGGR16:
 	case V4L2_PIX_FMT_SGBRG16:
 	case V4L2_PIX_FMT_SGRBG16:
-- 
2.25.1

