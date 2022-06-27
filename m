Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD455DDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiF0PNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiF0PMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:12:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433DD12E;
        Mon, 27 Jun 2022 08:12:37 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25RFCLgk108561;
        Mon, 27 Jun 2022 10:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656342741;
        bh=1x+NxdEoiSFo+pDWtHOPBfvhGy1WzeyR8WRyXcD8FVI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qNBVLupUI/bppft9D6NFgdfn2t1PCDSabHEwbnkQbFXXF3RExX9LmRPZv59ypspYt
         FFmSWRdrgN8tLkcn1ctlpoCBNZfrqaVUZoEYsRqaD9E0ZMzCsJp/2vkNmoGjpNcBsO
         TMT6uQJtb0VkYLh8tYNsk3P2up1eQsHgzLxOFhZM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25RFCLFV096646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jun 2022 10:12:21 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Jun 2022 10:12:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Jun 2022 10:12:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25RFC5pn118508;
        Mon, 27 Jun 2022 10:12:06 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 2/2] drm/tidss: Add support for AM625 DSS
Date:   Mon, 27 Jun 2022 20:42:00 +0530
Message-ID: <20220627151200.4693-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627151200.4693-1-a-bhatia1@ti.com>
References: <20220627151200.4693-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DSS IP on TI's new AM625 SoC in the tidss driver.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Reviewed-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 56 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h |  2 ++
 drivers/gpu/drm/tidss/tidss_drv.c   |  1 +
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index dae47853b728..f084f0688a54 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -272,6 +272,55 @@ const struct dispc_features dispc_j721e_feats = {
 	.vid_order = { 1, 3, 0, 2 },
 };
 
+const struct dispc_features dispc_am625_feats = {
+	.max_pclk_khz = {
+		[DISPC_VP_DPI] = 165000,
+		[DISPC_VP_OLDI] = 165000,
+	},
+
+	.scaling = {
+		.in_width_max_5tap_rgb = 1280,
+		.in_width_max_3tap_rgb = 2560,
+		.in_width_max_5tap_yuv = 2560,
+		.in_width_max_3tap_yuv = 4096,
+		.upscale_limit = 16,
+		.downscale_limit_5tap = 4,
+		.downscale_limit_3tap = 2,
+		/*
+		 * The max supported pixel inc value is 255. The value
+		 * of pixel inc is calculated like this: 1+(xinc-1)*bpp.
+		 * The maximum bpp of all formats supported by the HW
+		 * is 8. So the maximum supported xinc value is 32,
+		 * because 1+(32-1)*8 < 255 < 1+(33-1)*4.
+		 */
+		.xinc_max = 32,
+	},
+
+	.subrev = DISPC_AM625,
+
+	.common = "common",
+	.common_regs = tidss_am65x_common_regs,
+
+	.num_vps = 2,
+	.vp_name = { "vp1", "vp2" },
+	.ovr_name = { "ovr1", "ovr2" },
+	.vpclk_name =  { "vp1", "vp2" },
+	.vp_bus_type = { DISPC_VP_OLDI, DISPC_VP_DPI },
+
+	.vp_feat = { .color = {
+			.has_ctm = true,
+			.gamma_size = 256,
+			.gamma_type = TIDSS_GAMMA_8BIT,
+		},
+	},
+
+	.num_planes = 2,
+	/* note: vid is plane_id 0 and vidl1 is plane_id 1 */
+	.vid_name = { "vid", "vidl1" },
+	.vid_lite = { false, true, },
+	.vid_order = { 1, 0 },
+};
+
 static const u16 *dispc_common_regmap;
 
 struct dss_vp_data {
@@ -775,6 +824,7 @@ dispc_irq_t dispc_read_and_clear_irqstatus(struct dispc_device *dispc)
 		return dispc_k2g_read_and_clear_irqstatus(dispc);
 	case DISPC_AM65X:
 	case DISPC_J721E:
+	case DISPC_AM625:
 		return dispc_k3_read_and_clear_irqstatus(dispc);
 	default:
 		WARN_ON(1);
@@ -790,6 +840,7 @@ void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 		break;
 	case DISPC_AM65X:
 	case DISPC_J721E:
+	case DISPC_AM625:
 		dispc_k3_set_irqenable(dispc, mask);
 		break;
 	default:
@@ -1279,6 +1330,7 @@ void dispc_ovr_set_plane(struct dispc_device *dispc, u32 hw_plane,
 					x, y, layer);
 		break;
 	case DISPC_AM65X:
+	case DISPC_AM625:
 		dispc_am65x_ovr_set_plane(dispc, hw_plane, hw_videoport,
 					  x, y, layer);
 		break;
@@ -2202,6 +2254,7 @@ static void dispc_plane_init(struct dispc_device *dispc)
 		break;
 	case DISPC_AM65X:
 	case DISPC_J721E:
+	case DISPC_AM625:
 		dispc_k3_plane_init(dispc);
 		break;
 	default:
@@ -2307,6 +2360,7 @@ static void dispc_vp_write_gamma_table(struct dispc_device *dispc,
 		dispc_k2g_vp_write_gamma_table(dispc, hw_videoport);
 		break;
 	case DISPC_AM65X:
+	case DISPC_AM625:
 		dispc_am65x_vp_write_gamma_table(dispc, hw_videoport);
 		break;
 	case DISPC_J721E:
@@ -2580,7 +2634,7 @@ int dispc_runtime_resume(struct dispc_device *dispc)
 		REG_GET(dispc, DSS_SYSSTATUS, 2, 2),
 		REG_GET(dispc, DSS_SYSSTATUS, 3, 3));
 
-	if (dispc->feat->subrev == DISPC_AM65X)
+	if (dispc->feat->subrev == DISPC_AM65X || dispc->feat->subrev == DISPC_AM625)
 		dev_dbg(dispc->dev, "OLDI RESETDONE %d,%d,%d\n",
 			REG_GET(dispc, DSS_SYSSTATUS, 5, 5),
 			REG_GET(dispc, DSS_SYSSTATUS, 6, 6),
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index e49432f0abf5..a28005dafdc9 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -61,6 +61,7 @@ enum dispc_dss_subrevision {
 	DISPC_K2G,
 	DISPC_AM65X,
 	DISPC_J721E,
+	DISPC_AM625,
 };
 
 struct dispc_features {
@@ -88,6 +89,7 @@ struct dispc_features {
 extern const struct dispc_features dispc_k2g_feats;
 extern const struct dispc_features dispc_am65x_feats;
 extern const struct dispc_features dispc_j721e_feats;
+extern const struct dispc_features dispc_am625_feats;
 
 void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask);
 dispc_irq_t dispc_read_and_clear_irqstatus(struct dispc_device *dispc);
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 04cfff89ee51..326059e99696 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -235,6 +235,7 @@ static const struct of_device_id tidss_of_table[] = {
 	{ .compatible = "ti,k2g-dss", .data = &dispc_k2g_feats, },
 	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats, },
 	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats, },
+	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
 	{ }
 };
 
-- 
2.36.1

