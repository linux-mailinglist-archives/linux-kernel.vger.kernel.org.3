Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6D4BA23C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiBQN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:59:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiBQN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:59:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8C2B0B06;
        Thu, 17 Feb 2022 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106377; x=1676642377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inbCfOApjHcZj6rPnStLuoDA+QTiQF8O+NIL6iLwJf0=;
  b=gS2xgvHuwxPghenft8uY1RPFw7CY6xHc7DNwZvOX2HQ1hU15Iq4yt0qz
   jHgVesy48N+TP1JO6Xsw1+hFN8NFsA4V/YXRi6TViFbbierLfBF5e1/18
   yQ0hTLGWxta0eqWeyOL8LeCZvN4B/7wW7Q4SGZ+a9taxb5PnQqIK/sg2/
   WHT48nv/GsY3D7aOPYmtzEPUEMiUBR/i3t2/aaNW61fCNIBZGdv2Nqbzj
   mrpMaldp5npjsXjVXezmUDxIV5dYq/BfzBPT3yoEGnJbk2IjPoqo6UZo2
   K8sqGUONjUses/2B8aK1X8o/IOStSlkiz+cOXfdF5VbRdYcEgllJGOuhl
   g==;
IronPort-SDR: vA1LO23cUspxTA9+vKKxFGXby8p3yhvA0tehHzhbW2r0jfWqs/PvAWhbNbaJtUp7huL7pdtylr
 bFCV8UABV18wmjRqlP4Kw4m+w1YkerAGEn2mYsnSiFHsWQxOwgC+a+MGx/UnfgEGu6yOYEo5il
 hwZc+UPtKq01vcODfaxsStK8dVO41gxiZcxBKfYhccr3YxdQtaqCnjwfPmFdaLnBTQhlRQOxbf
 JT8midOO8GGtFgWbK1WXYsLwDF9b1eTxE4PzLgOpeLUN8qRmVjlFVSrcyIB/QfooSqcyWL1nBS
 eblsYAZygTk9wNd1U6uiolLz
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="149064309"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:59:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:59:35 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:59:09 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 07/13] media: atmel: atmel-isc: compact the controller formats list
Date:   Thu, 17 Feb 2022 15:56:39 +0200
Message-ID: <20220217135645.1427466-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compact the list array to be more readable.
No other changes, only cosmetic.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../media/platform/atmel/atmel-sama5d2-isc.c  | 51 ++++++----------
 .../media/platform/atmel/atmel-sama7g5-isc.c  | 60 +++++++------------
 2 files changed, 37 insertions(+), 74 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 025c3e8a7e95..d96ee3373889 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -60,56 +60,39 @@
 static const struct isc_format sama5d2_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_ARGB444,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ARGB555,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_RGB565,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_XBGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV420,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUYV,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV422P,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_GREY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
 	},
 };
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 9dc75eed0098..e07ae188c15f 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -63,65 +63,45 @@
 static const struct isc_format sama7g5_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_ARGB444,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ARGB555,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_RGB565,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_ABGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_XBGR32,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV420,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_UYVY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_VYUY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUYV,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_YUV422P,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_GREY,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_Y16,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
-	},
-	{
+	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
 	},
 };
-- 
2.25.1

