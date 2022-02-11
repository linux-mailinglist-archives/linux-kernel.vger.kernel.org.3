Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227D04B27DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350822AbiBKO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiBKO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:09 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A295C7;
        Fri, 11 Feb 2022 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589687; x=1676125687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jyjqm1guo7eCJ26INStDNcH149noY5F5ukFsurO5hjM=;
  b=ijElK8zyd2cKjOmSa73n9lPxOhSeZi25Ppd6hRgF4SczvbUdz6oK+fPG
   /MLEc1Q33ztPD1nNaMi/f0fKW/uCjZtQqZBQzNaE1o+5iOKiOqzfAUJDD
   oLUM31Gm7IBHvbnLOLFn0M0ASyUrSJxCA/fLEh8zqe0++44EcuzLAH6Yn
   u55fM9sZvnb85mrl9oDkxEIl4D2XeeKWctZQvOKYre4/q6IYEiPx5RXHJ
   6fjJrMh9KUw/ob6si3+GXQYaSVyY4KpAncZSf35JSaCYi7vKws4PJ+Yow
   H/pydG+xC3zQSmSgV8jceRDt/WK5ywV8Iebi3G+4KrgMSU2wutRApsO9b
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042287"
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
  bh=jyjqm1guo7eCJ26INStDNcH149noY5F5ukFsurO5hjM=;
  b=jUJbuqe9IzrHR55d/NDW2BudEfLR7S1sHyC8mcxeAipryI/O1JEWUtmM
   DZTrwwhyqnm4Y8Y2iY2iPmqFKT1iuQfWRz4EfT/Rp9ADL7o9jiu0RK4UD
   Xm7EtI4fk4An7zG2AKBNxCVi4HIIVnmWi95zNbRf9mAx2BKwwWlwOlSZm
   YSUtzY5CtMsUoGAzXVKci3hpcGtV/xNkYQRA35Jaf7gJAB/FVboRQAjrM
   4jtTgRnbi2LbwHNXu/zO7AtM2E2E70vOltJ3yGOmzoD4DwOTGZJdfteJT
   cu0fTJV0GM1tBfzzA1SHNXYkc1qxTLTOTf3fBKdEtkp7erkdzhPMi7XLl
   A==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042286"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:02 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D0D31280078;
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
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] media: imx: imx7_mipi_csis: store colorspace in set_fmt as well
Date:   Fri, 11 Feb 2022 15:27:48 +0100
Message-Id: <20220211142752.779952-6-alexander.stein@ew.tq-group.com>
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

Without this the default (SMPTE 170M) from init_cfg stays unchanged.
Even after configuring 'srgb' colorspace (or 'raw')
$ media-ctl -V "'csis-32e30000.mipi-csi':0 [colorspace:srgb]"
the colorspace does not change at all:
$ media-ctl --get-v4l2 "'csis-32e30000.mipi-csi':0"
  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:smpte170m xfer:709
   ycbcr:601 quantization:lim-range]

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Store other colorspace-related fields as well

 drivers/staging/media/imx/imx7-mipi-csis.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index a22d0e6b3d44..388cfd012212 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -1062,6 +1062,10 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
 	fmt->code = csis_fmt->code;
 	fmt->width = sdformat->format.width;
 	fmt->height = sdformat->format.height;
+	fmt->colorspace = sdformat->format.colorspace;
+	fmt->quantization = sdformat->format.quantization;
+	fmt->xfer_func = sdformat->format.xfer_func;
+	fmt->ycbcr_enc = sdformat->format.ycbcr_enc;
 
 	sdformat->format = *fmt;
 
-- 
2.25.1

