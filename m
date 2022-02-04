Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972D84A9913
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358808AbiBDMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:51 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:57020 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358662AbiBDMPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976934; x=1675512934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxzlrhc4NRiZGi76LZW5C2eEFoWSR5gV+Yrp/AZNDME=;
  b=OfUdnJa1G/hmBovLC1ygxQHVCDQSzizePd0DYa6qbZpK1VYwZq6D8Rm7
   lyzP2ayLmfa+BtaEESPL0/x391Vqh1m/zyyokHi6sk9hwTHW77SY/OboE
   O3XxQd689YskBNnx2jMsYs7fbzr1JmB14nYKHoFwJnC6eiheG3YPOKfEm
   ADfTykG+Ys+Wv+GaLLfrqlT8VrYhBBRHhMppe4QBVetnt56nRO+oBt8zG
   Rz/VVzFaIC0rj1NORphDLZC5R/4CaHxWcqhjDosM5qFt35o3rP7BGwtEN
   0sK2XVvAYnPqpskUzT+lBXz4k7uozaZ9xWsDEg7S/qelT9tft/ZZnuiFY
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903444"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:30 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:30 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976930; x=1675512930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxzlrhc4NRiZGi76LZW5C2eEFoWSR5gV+Yrp/AZNDME=;
  b=M2TltVT6lr+eQS8IzKEtkI2FlEQDvXhnt93Q/Kcryg9f/56KiGAY6L+X
   OO+DeFuvGn7+9h18ih075dR3jETsTCh+J04ULa7a5/px+kKcveZPKjRaH
   WBKgOhAX9BHBTMyePPbq3gAtTw97728+JAuAg/mRgd5/higVxxtI1I6D7
   CzzSx9H61CYy3uryj3vwiUCsp6RLExdaKVwWjSjb/BKo674jFT82b9v8p
   tjKOlf2OSWPSYm9KtAwSo7uFFKiQJXyrUZW9NRKpgaaASmAf+qnf9UH0M
   RJbZVG/cjZe3AVauClUzWkTHg5mIOCpEv6kDifd+aZ5VM80EZKrknwTPP
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903428"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:25 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F12C9280075;
        Fri,  4 Feb 2022 13:15:24 +0100 (CET)
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
Subject: [PATCH 3/8] media: imx: Use dedicated format handler for i.MX7/8
Date:   Fri,  4 Feb 2022 13:15:09 +0100
Message-Id: <20220204121514.2762676-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

This splits out a format handler which takes into account
the capabilities of the i.MX7/8 video device,
as opposed to the default handler compatible with both i.MX5/6 and i.MX7/8.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in comparison to original commit from Dorota:
* is_imx56 is used instead of enum

 drivers/staging/media/imx/imx-media-utils.c | 56 +++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 0daa6aad45f4..32aaa2e81bea 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -516,10 +516,9 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
 }
 EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
 
-int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
-				  const struct v4l2_mbus_framefmt *mbus,
-				  const struct imx_media_pixfmt *cc,
-				  bool is_imx56)
+static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
+					   const struct v4l2_mbus_framefmt *mbus,
+					   const struct imx_media_pixfmt *cc)
 {
 	u32 width;
 	u32 stride;
@@ -568,6 +567,55 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 
 	return 0;
 }
+
+static int imx78_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
+					   const struct v4l2_mbus_framefmt *mbus,
+					   const struct imx_media_pixfmt *cc)
+{
+	int ret;
+
+	if (!cc)
+		cc = imx_media_find_mbus_format(mbus->code, PIXFMT_SEL_ANY);
+
+	if (!cc)
+		return -EINVAL;
+	/*
+	 * The hardware can handle line lengths divisible by 4 pixels
+	 * as long as the whole buffer size ends up divisible by 8 bytes.
+	 * If not, use the value of 8 pixels recommended in the datasheet.
+	 */
+	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
+			       round_up(mbus->width, 4), mbus->height);
+	if (ret)
+		return ret;
+
+	/* Only 8bits-per-pixel formats may need to get aligned to 8 pixels,
+	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
+	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
+	 */
+	if (pix->sizeimage % 8 != 0)
+		ret = v4l2_fill_pixfmt(pix, cc->fourcc,
+				       round_up(mbus->width, 8), mbus->height);
+
+	pix->colorspace = mbus->colorspace;
+	pix->xfer_func = mbus->xfer_func;
+	pix->ycbcr_enc = mbus->ycbcr_enc;
+	pix->quantization = mbus->quantization;
+	pix->field = mbus->field;
+
+	return ret;
+}
+
+int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
+				  const struct v4l2_mbus_framefmt *mbus,
+				  const struct imx_media_pixfmt *cc,
+				  bool is_imx56)
+{
+	if (is_imx56)
+		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
+	else
+		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
+}
 EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
 
 void imx_media_free_dma_buf(struct device *dev,
-- 
2.25.1

