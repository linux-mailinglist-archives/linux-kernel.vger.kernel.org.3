Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108D472E33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhLMN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:56:12 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:56599 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhLMN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403771; x=1670939771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVsnVhKos+4un4tF8gl8LYrlTAZbplMjYM+lMJCJPa8=;
  b=ngBc/F5jnOBLwGFdGrsD7QfOPLIqaxK07v+7syP/oj4E6IDG6guOeElD
   Qp9tqPfEtSzgXVml1ctboWygMgJzA/GyNQAHncLV90XkBZCY54b2OXFY6
   8hTspISFE4KJ1+bBuPn7HV5K8lyBKbG2iQPycc6VrSVBeWU+7XoWwq+/S
   KSNKvBRQIxBokACcWTcZ/kno4apVB+zquX6DMZhiE1s3I82iJNE9/xmeS
   bZa92BfDbyrwrjWcdphTFEsAyG14+IgU3zqjYURyCergrFugKkcXHThpg
   JrTKebfdjX/e/FD32BzOB35kRbIIrkSz8E4M+2tOFwFXIgdEJ8J921Mcc
   g==;
IronPort-SDR: G7m7IrJHd0B5DVO9t/yLcC/LOTuP7WI2f+VJP5DKyUBCtSmyRi7efqbCtg8lnQziE9Bw9ywpOO
 X811O9omQfPa7XFBgdK2NjXPd74EhOYr6PGQUdC2pT0Mx6czqzYslqqkoHXLKS9WWXf8DK58F7
 OOfTdkk+jXZNcE+YqAobxO0xXIaOJvvzaF4HMrKBfQjY3k1YgNtzJMDsUZ4AidtR/5WS9PEb2X
 MywlScfQROuPdmflpnRg3I/qUY6ch00QwlzqCqbAM6d2G+yrOAFgeWpztXSMWOytuHd5uMH1mr
 c+NymNVN+vDoyj2aZ840S4TA
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="146466682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:56:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:56:10 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:55:55 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 21/23] media: atmel: atmel-isc: add raw Bayer 8bit 10bit output formats
Date:   Mon, 13 Dec 2021 15:49:38 +0200
Message-ID: <20211213134940.324266-22-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISC can dump the 8 bit and 10 bit raw bayer formats directly to
the memory.
Thus, add them to the supported output format list.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../media/platform/atmel/atmel-sama5d2-isc.c  | 24 +++++++++++++++++++
 .../media/platform/atmel/atmel-sama7g5-isc.c  | 24 +++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index a8d4ba60d3ac..025c3e8a7e95 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -88,6 +88,30 @@ static const struct isc_format sama5d2_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_Y10,
 	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+	},
 };
 
 /* This is a list of formats that the ISC can receive as *input* */
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 38721bd902e2..9dc75eed0098 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -100,6 +100,30 @@ static const struct isc_format sama7g5_controller_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_Y16,
 	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+	},
+	{
+		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+	},
 };
 
 /* This is a list of formats that the ISC can receive as *input* */
-- 
2.25.1

