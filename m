Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF654A9908
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358633AbiBDMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:31 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:1606 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358561AbiBDMP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976926; x=1675512926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bc6AZVTrc7BoI0dNeWm1pc1eWQvq627GTftRErmHl+E=;
  b=VUyxraYZKkPoqqvU3Qc+gSBIGHoKTiCp5wXXlP8OVkSlS7hb9j1tAzMm
   HLZD4WkGaXxF5cVuHijBzZ83sjkplpK0cZDDjVAu4Ul34cMf09XDlzPVI
   KfAtoH1XbV+yJdXA5fGHE98H0Hko4SaEHIxbsgLiDfoSPzwgAWBrUzkwH
   VmgSjSbycNVWd+SrbFtdH78ZKfzgaBvYpAcLSIhrME5quBZgyuTyHzlxB
   j7KHC99eat/waLz/GaTZpdY/w42IjXsQGmG+ZkXgqT7zxFsl5Znv+WoIO
   TSJzBueSJRKsv0aRxpI21X5vWfxK8ep/1roxfZC/rqW3zFjcqfXPNR09k
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903432"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:25 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:25 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976925; x=1675512925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bc6AZVTrc7BoI0dNeWm1pc1eWQvq627GTftRErmHl+E=;
  b=oZSrnE4np0h67rOeQNqUsg/k2MtCG11arHHHzJrh0isXktCOi31itxhU
   srNAWnbP6WasBHiplUuE0IP9gSbZvg6VVnCKE8dbEc/tf5p9dqDHiaD95
   EhRvDjvF+GL/1ryJH1mdFM4qboHbB6LYlqjs1DKg3Yi2HtJWUMfIpoJAR
   n/ZMVNTOQhFilM9dTp9i0v8qGL8tT+pJYOGQ/9N9oSnx91WN4JXZ2O4xX
   TwPbLmUtiMJnSark8nSZgmBhA7YfNsz8z/3mbPPFPfEwB9f+yGPLTG+nk
   NipuHjVlHgq9aBVps6r1urEGkPaeL2XG7/ZFkm0mOi86D+rUB++0paU7B
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903431"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:25 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8AF2E280075;
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
Subject: [PATCH 5/8] media: imx: imx7_mipi_csis: store colorspace in set_fmt as well
Date:   Fri,  4 Feb 2022 13:15:11 +0100
Message-Id: <20220204121514.2762676-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this the default (SMPTE 170M) from init_cfg stays unchanged.
Even after configuring 'srgb' colorspace (or 'raw')
$ media-ctl -V "'csis-32e30000.mipi-csi':0 [colorspace:srgb]"
the colorspace does not change at all:
$ media-ctl --get-v4l2 "'csis-32e30000.mipi-csi':0"
  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:smpte170m xfer:709
   ycbcr:601 quantization:lim-range]

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/staging/media/imx/imx7-mipi-csis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index a22d0e6b3d44..7b0e57efcf82 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -1062,6 +1062,7 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
 	fmt->code = csis_fmt->code;
 	fmt->width = sdformat->format.width;
 	fmt->height = sdformat->format.height;
+	fmt->colorspace = sdformat->format.colorspace;
 
 	sdformat->format = *fmt;
 
-- 
2.25.1

