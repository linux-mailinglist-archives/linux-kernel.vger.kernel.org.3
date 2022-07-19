Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269425794FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGSIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiGSIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:09:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179363B952;
        Tue, 19 Jul 2022 01:09:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26J88xD8051616;
        Tue, 19 Jul 2022 03:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658218139;
        bh=Cb7Wkj97XLd+o09FdkfKJN28acdGbBYRIfpnXJmYk4o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P1omX8Ya6mcd6/txrDL9oiozCYQDQFDV438Sq2Sofbit/qqJWM3rPghpZxZgrLYYr
         CnTUE5qF9dTlJX4VqrTVNE9MNH5t23UThTufsgJ426cuLvI9418kqih0bazdR2hxH8
         rx3ypzk37Pagk06zbLSzYuIew7FL9dj0SBeAu1k0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26J88xoL044039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 03:08:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 03:08:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 03:08:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26J88vTO020251;
        Tue, 19 Jul 2022 03:08:58 -0500
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
Subject: [PATCH 8/8] drm/tidss: Enable Dual and Duplicate Modes for OLDI
Date:   Tue, 19 Jul 2022 13:38:45 +0530
Message-ID: <20220719080845.22122-9-a-bhatia1@ti.com>
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

The AM625 DSS peripheral supports 2 OLDI TXes which can work to enable 2
duplicated displays of smaller resolutions or enable a single Dual-Link
display with a higher resolution (1920x1200).

Configure the necessary register to enable the different modes.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 44 +++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 0b9689453ee8..28cb61259471 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1021,8 +1021,8 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
 	int count = 0;
 
 	/*
-	 * For the moment DUALMODESYNC, MASTERSLAVE, MODE, and SRC
-	 * bits of DISPC_VP_DSS_OLDI_CFG are set statically to 0.
+	 * For the moment MASTERSLAVE, and SRC bits of DISPC_VP_DSS_OLDI_CFG are
+	 * set statically to 0.
 	 */
 
 	if (fmt->data_width == 24)
@@ -1039,7 +1039,45 @@ static void dispc_enable_oldi(struct dispc_device *dispc, u32 hw_videoport,
 
 	oldi_cfg |= BIT(0); /* ENABLE */
 
-	dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+	/*
+	 * As per all the current implementations of DSS, the OLDI TXes are present only on
+	 * hw_videoport = 0 (OLDI TX 0). However, the config register for 2nd OLDI TX (OLDI TX 1)
+	 * is present in the address space of hw_videoport = 1. Hence, using "hw_videoport + 1" to
+	 * configure OLDI TX 1.
+	 */
+
+	switch (dispc->oldi_mode) {
+	case OLDI_MODE_OFF:
+		oldi_cfg &= ~BIT(0); /* DISABLE */
+		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		break;
+
+	case OLDI_SINGLE_LINK_SINGLE_MODE_0:
+		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		break;
+
+	case OLDI_SINGLE_LINK_SINGLE_MODE_1:
+		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		break;
+
+	case OLDI_SINGLE_LINK_DUPLICATE_MODE:
+		oldi_cfg |= BIT(5); /* DUPLICATE MODE */
+		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		break;
+
+	case OLDI_DUAL_LINK:
+		oldi_cfg |= BIT(11); /* DUALMODESYNC */
+		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		dispc_vp_write(dispc, hw_videoport + 1, DISPC_VP_DSS_OLDI_CFG, oldi_cfg);
+		break;
+
+	default:
+		dev_warn(dispc->dev, "%s: Incorrect oldi mode. Returning.\n",
+			 __func__);
+		return;
+	}
 
 	while (!(oldi_reset_bit & dispc_read(dispc, DSS_SYSSTATUS)) &&
 	       count < 10000)
-- 
2.37.0

