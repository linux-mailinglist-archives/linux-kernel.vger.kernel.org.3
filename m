Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4D479DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhLRVw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:52:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234948AbhLRVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:51:55 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BILJjLJ029088;
        Sat, 18 Dec 2021 22:51:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=AGQhVrufT/qOBHcyJMs9MvSX9bAivaHoR3YLt0V3MKo=;
 b=KC3C6CiBwNUQx3BiVQ+t/10c4oVEaN2TlOCNb+nV+MYWsB22srJKb1IPB+0uATwUbG4A
 hOBrrHpc2f8lUGQl0rA3Eyt4zY0yB4t+m1ICkcLSAFdckVyjJl+sN3g+i0WdeaJlZuV1
 mVTDSrOTEMrma1++ifTw0C1LLJQWGAD90XYvKvJE/Bh80zWtzL+YWQ6T5xE0yZrCpKVI
 egvhr0XZToTBGpUmhMA+GfJjmtfJB2smA/WuMmFXJUolFXUYktRCSucKlCDSvPCEqe2n
 /FvCPVR20ttP5s+TFWkg4VRb4nFCE5GfwMTIG7ynSqqvQapj2pcCJ9UEgYj/7SKAC9if Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d17v3te3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 22:51:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 554F610002A;
        Sat, 18 Dec 2021 22:51:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46A0C209F50;
        Sat, 18 Dec 2021 22:51:15 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Sat, 18 Dec 2021 22:51:14
 +0100
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drm/stm: dsi: move lane capability detection in probe()
Date:   Sat, 18 Dec 2021 22:50:52 +0100
Message-ID: <20211218215055.212421-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-18_08,2021-12-16_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to re-compute the dsi lane capability because it
only depends on dsi hw version.
Since dsi hw version is detected at probe(), move there also the
assignment of dsi lane capability.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
To: David Airlie <airlied@linux.ie>
To: Daniel Vetter <daniel@ffwll.ch>
To: Andrzej Hajda <a.hajda@samsung.com>
To: Neil Armstrong <narmstrong@baylibre.com>
To: Robert Foss <robert.foss@linaro.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>
To: Philippe Cornu <philippe.cornu@foss.st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: dri-devel@lists.freedesktop.org
To: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 32cb41b2202f..480fdf256f01 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -247,14 +247,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 	int ret, bpp;
 	u32 val;
 
-	/* Update lane capabilities according to hw version */
-	dsi->lane_min_kbps = LANE_MIN_KBPS;
-	dsi->lane_max_kbps = LANE_MAX_KBPS;
-	if (dsi->hw_version == HWVER_131) {
-		dsi->lane_min_kbps *= 2;
-		dsi->lane_max_kbps *= 2;
-	}
-
 	pll_in_khz = (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
 
 	/* Compute requested pll out */
@@ -417,6 +409,14 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 		goto err_dsi_probe;
 	}
 
+	/* set lane capabilities according to hw version */
+	dsi->lane_min_kbps = LANE_MIN_KBPS;
+	dsi->lane_max_kbps = LANE_MAX_KBPS;
+	if (dsi->hw_version == HWVER_131) {
+		dsi->lane_min_kbps *= 2;
+		dsi->lane_max_kbps *= 2;
+	}
+
 	dw_mipi_dsi_stm_plat_data.base = dsi->base;
 	dw_mipi_dsi_stm_plat_data.priv_data = dsi;
 

base-commit: 70704fbf67ddc07ffc81073a3af1f7b2171697eb
-- 
2.34.1

