Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83F5794F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiGSIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiGSIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:09:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9E73AE5B;
        Tue, 19 Jul 2022 01:09:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26J88qwq051061;
        Tue, 19 Jul 2022 03:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658218132;
        bh=Ipo/HtZNsvyUf/o/G8GYVFgfxoVahEFy4rUPvIHN/L0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QK5XaBjXP19af0PE6su4a91M9yCWL2RRyEx212mBbfK3YwstdFOaQwohmAAFv9QCF
         zPUZSaUigxDKgFdstpH5u5LOHvF1dWtW9nR+cajtBEFQPDYvhaPGLBTsfklaQ/qg+8
         S61C+UgZT3tls7Aa/cOmM27+e6cOed0Le6VgJtYM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26J88qbV043988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 03:08:52 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 03:08:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 03:08:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26J88p0U121356;
        Tue, 19 Jul 2022 03:08:52 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] drm/tidss: Add support for Dual Link LVDS Bus Format
Date:   Tue, 19 Jul 2022 13:38:41 +0530
Message-ID: <20220719080845.22122-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719080845.22122-1-a-bhatia1@ti.com>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2 OLDI TXes in the AM625 SoC can be synced together to output a 2K
resolution video.

Add support in the driver for the discovery of such a dual mode
connection on the OLDI video port, using the values of "ti,oldi-mode"
property.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 39 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index add725fa682b..fb1fdecfc83a 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -853,25 +853,36 @@ void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 	}
 }
 
-enum dispc_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
+enum dispc_oldi_mode_reg_val {
+	SPWG_18		= 0,
+	JEIDA_24	= 1,
+	SPWG_24		= 2,
+	DL_SPWG_18	= 4,
+	DL_JEIDA_24	= 5,
+	DL_SPWG_24	= 6,
+};
 
 struct dispc_bus_format {
 	u32 bus_fmt;
 	u32 data_width;
 	bool is_oldi_fmt;
+	bool is_dual_link;
 	enum dispc_oldi_mode_reg_val oldi_mode_reg_val;
 };
 
 static const struct dispc_bus_format dispc_bus_formats[] = {
-	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, 0 },
-	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, 0 },
-	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, 0 },
-	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, 0 },
-	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, 0 },
-	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, 0 },
-	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, SPWG_18 },
-	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, SPWG_24 },
-	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, JEIDA_24 },
+	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, false, 0 },
+	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, false, SPWG_18 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, false, SPWG_24 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, false, JEIDA_24 },
+	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, true, DL_SPWG_18 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, true, DL_SPWG_24 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, true, DL_JEIDA_24 },
 };
 
 static const
@@ -880,9 +891,15 @@ struct dispc_bus_format *dispc_vp_find_bus_fmt(struct dispc_device *dispc,
 					       u32 bus_fmt, u32 bus_flags)
 {
 	unsigned int i;
+	bool is_dual_link = false;
+
+	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI &&
+	    dispc->oldi_mode == OLDI_DUAL_LINK)
+		is_dual_link = true;
 
 	for (i = 0; i < ARRAY_SIZE(dispc_bus_formats); ++i) {
-		if (dispc_bus_formats[i].bus_fmt == bus_fmt)
+		if (dispc_bus_formats[i].bus_fmt == bus_fmt &&
+		    dispc_bus_formats[i].is_dual_link == is_dual_link)
 			return &dispc_bus_formats[i];
 	}
 
-- 
2.37.0

