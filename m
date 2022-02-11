Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25CF4B27CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350801AbiBKO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiBKO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:07 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E319A;
        Fri, 11 Feb 2022 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589686; x=1676125686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qk+HxTPyafSPDOnzZ98EqCzlxI4X1vpCf3VT5BqZ4+c=;
  b=KXyyijYVszZEezbsu/lN/myu7GVj8nVyB4ZXXLpx+25LO7JdlQZUaymc
   qT/hkyuSJEWbKRyawa92ASX4CQkuLRqbJDHM1bYk9dpz9chruU7duw4Ar
   hPe12JgMce/duTFtKBEx5paN+n0Zg4IOJt2LuxcESrIaqEa1KKUBTx6rg
   ANKg2E6MKy7vwhfwSezoo8L/sL9Uf/Z/Q0qXomSLncIuND9StrlENqYgW
   509loUFF4ZgY0/93iSsVMtQuacKch3l9XjziwxF4Bv4edl6vZrnsaCQ+D
   Y4PLAWAUYq5jQA4vL9dDskdc/9utuD+E8xM57AFel8/AsvrUt0o33XBqr
   g==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042283"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Feb 2022 15:28:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 11 Feb 2022 15:28:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 11 Feb 2022 15:28:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589681; x=1676125681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qk+HxTPyafSPDOnzZ98EqCzlxI4X1vpCf3VT5BqZ4+c=;
  b=RQKxMKFuZ1BP2VHsEEo9L3vXAFXY7qcWOA/m4Rl0+lzuCmChN9tZ8Xtz
   kpSc81AvVI7pb2Ogr9XAs3Exi41xM9LqsaEmd42PMM5bmwsxVlVA7h1Uj
   H5HXhfugzoUPKrwS0ciztgIfxPowdU7OOGFyMOB3j35a1fhh+pot3aSsa
   svHP25M+dzgbmx0rcmtDsbG70VOw1Hz8edamanDPMMfJpCvI+YZddWNRW
   3GnEarWMk5T2vHrPEi7kx0WB18CvFSXriCQaUwKqOYy2AmF05RgcWPMqH
   K8BkGbkD1sbX/ATmRVtYicVVqy2d0u8efRH43RT35C3Ojb3wjvhtc19f9
   A==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042282"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:01 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1FBF0280065;
        Fri, 11 Feb 2022 15:28:01 +0100 (CET)
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
Subject: [PATCH v2 3/9] media: imx: Use dedicated format handler for i.MX7/8
Date:   Fri, 11 Feb 2022 15:27:46 +0100
Message-Id: <20220211142752.779952-4-alexander.stein@ew.tq-group.com>
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

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

This splits out a format handler which takes into account
the capabilities of the i.MX7/8 video device,
as opposed to the default handler compatible with both i.MX5/6 and i.MX7/8.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Switch back to using enum
* Get rid of an additional call to v4l2_fill_pixfmt()

 drivers/staging/media/imx/imx-media-utils.c | 60 +++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index c42f3da8e3a8..02a4cb124d37 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -516,10 +516,9 @@ void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
 }
 EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
 
-int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
-				  const struct v4l2_mbus_framefmt *mbus,
-				  const struct imx_media_pixfmt *cc,
-				  enum imx_media_device_type type)
+static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
+					   const struct v4l2_mbus_framefmt *mbus,
+					   const struct imx_media_pixfmt *cc)
 {
 	u32 width;
 	u32 stride;
@@ -568,6 +567,59 @@ int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 
 	return 0;
 }
+
+static int imx78_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
+					   const struct v4l2_mbus_framefmt *mbus,
+					   const struct imx_media_pixfmt *cc)
+{
+	u32 aligned_width;
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
+	 * Only 8bits-per-pixel formats may need to get aligned to 8 pixels,
+	 * because both 10-bit and 16-bit pixels occupy 2 bytes.
+	 * In those, 4-pixel aligmnent is equal to 8-byte alignment.
+	 */
+	if (cc->bpp == 1)
+		aligned_width = round_up(mbus->width, 8);
+	else
+		aligned_width = round_up(mbus->width, 4);
+
+	ret = v4l2_fill_pixfmt(pix, cc->fourcc,
+			       aligned_width, mbus->height);
+	if (ret)
+		return ret;
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
+				  enum imx_media_device_type type)
+{
+	switch (type) {
+	case DEVICE_TYPE_IMX56:
+		return imx56_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
+	case DEVICE_TYPE_IMX78:
+		return imx78_media_mbus_fmt_to_pix_fmt(pix, mbus, cc);
+	}
+	return -EINVAL;
+}
 EXPORT_SYMBOL_GPL(imx_media_mbus_fmt_to_pix_fmt);
 
 void imx_media_free_dma_buf(struct device *dev,
-- 
2.25.1

