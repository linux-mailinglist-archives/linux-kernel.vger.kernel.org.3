Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9B472E08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhLMNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:52:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49116 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhLMNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403551; x=1670939551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wAej8zbZ2Z8QMflPY6dkTpKKqPVWmjJ48/bava7RNWY=;
  b=zVi9oAmEA6Bn1uYv4ebBcbyuKZs+3UnIfdvUO6fZhQj1JxGu7vii2z8+
   n1gKpn/c2kkLtWBOp32B6X1HxkuVUEHPVxiLw+Jph+xZukzHlmRpxMs8M
   1xrB/8Of59288UdT2Ym6d91Yjt/QHQGm3WtJruEqWtq0S0LbHq8DTV+Oi
   Bem1xwXrdowlMadj86kBk4yEx1zY/3gpeIPs6WnIMXN3JDw/IBbEQjPCo
   Max80RZAs4JXfDZvyZy+aHF+g6tVqpn0Y900Dz4PjhxKaOV8ms24l7a96
   JHr0WOTW3VerIt42Sb6/8CIbDSYN7KpsuNeT9Z11n5wrf1uc5AqmRrIOz
   w==;
IronPort-SDR: 599aJWp803J+oMAyfn+chvLvjzlwg9oh+44yXjG1eiGl0w3Bv5y2H4xXRkyZ7u/uzbljoR3gYJ
 f1u3HibW+CQiSajjpmFJyM6xqNlzuK7CEqtGguSOEZIEjTw4sAhCgO2uXa2itFYAPHraM4gNdv
 ASPD3yr21BGzSAdg2qGgLXwfIsAI1UsREXOmi+IaZf/OsxhsnglpGt51phXeoQlxlB4qT2HyBz
 dduFS36DUvmQDUonqyDsXZlpR79JbPljTJz8UTR3mmhk/ZbGe50MYv8+CE84LXE/NlAST41RN/
 ssQ5zOemL8fTv/K5bEh3iKT8
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79361735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:52:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:52:30 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:52:20 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 10/23] media: atmel: atmel-isc-base: implement mbus_code support in enumfmt
Date:   Mon, 13 Dec 2021 15:49:27 +0200
Message-ID: <20211213134940.324266-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enumfmt is called with an mbus_code, the enumfmt handler should only
return the formats that are supported for this mbus_code.
To make it more easy to understand the formats, changed the report order
to report first the native formats, and after that the formats that the ISC
can convert to.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 51 ++++++++++++++++---
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index bf638d201b29..2cb8446ff90c 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -498,21 +498,56 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
 	u32 index = f->index;
 	u32 i, supported_index;
 
-	if (index < isc->controller_formats_size) {
-		f->pixelformat = isc->controller_formats[index].fourcc;
-		return 0;
+	supported_index = 0;
+
+	for (i = 0; i < isc->formats_list_size; i++) {
+		if (!isc->formats_list[i].sd_support)
+			continue;
+		/*
+		 * If specific mbus_code is requested, provide only
+		 * supported formats with this mbus code
+		 */
+		if (f->mbus_code && f->mbus_code !=
+		    isc->formats_list[i].mbus_code)
+			continue;
+		if (supported_index == index) {
+			f->pixelformat = isc->formats_list[i].fourcc;
+			return 0;
+		}
+		supported_index++;
 	}
 
-	index -= isc->controller_formats_size;
+	/*
+	 * If the sensor does not support this mbus_code whatsoever,
+	 * there is no reason to advertise any of our output formats
+	 */
+	if (supported_index == 0)
+		return -EINVAL;
+
+	/*
+	 * If the sensor uses a format that is not raw, then we cannot
+	 * convert it to any of the formats that we usually can with a
+	 * RAW sensor. Thus, do not advertise them.
+	 */
+	if (!isc->config.sd_format ||
+	    !ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+		return -EINVAL;
 
+	/*
+	 * Iterate again through the formats that we can convert to.
+	 * However, to avoid duplicates, skip the formats that
+	 * the sensor already supports directly
+	 */
+	index -= supported_index;
 	supported_index = 0;
 
-	for (i = 0; i < isc->formats_list_size; i++) {
-		if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
-		    !isc->formats_list[i].sd_support)
+	for (i = 0; i < isc->controller_formats_size; i++) {
+		/* if this format is already supported by sensor, skip it */
+		if (find_format_by_fourcc(isc, isc->controller_formats[i].fourcc))
 			continue;
 		if (supported_index == index) {
-			f->pixelformat = isc->formats_list[i].fourcc;
+			f->pixelformat =
+				isc->controller_formats[i].fourcc;
 			return 0;
 		}
 		supported_index++;
-- 
2.25.1

