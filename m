Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1923848C750
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349424AbiALPho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:37:44 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43104 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354652AbiALPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:37:31 -0500
X-UUID: 1d33b5f761bb4638be6da5f2e36adf00-20220112
X-UUID: 1d33b5f761bb4638be6da5f2e36adf00-20220112
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2104030689; Wed, 12 Jan 2022 23:37:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 23:37:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 23:37:27 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <andrzej.hajda@intel.com>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v8, PATCH 1/3] drm/dsi: transfer DSI HS packets ending at the same time
Date:   Wed, 12 Jan 2022 23:36:37 +0800
Message-ID: <20220112153639.12343-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
References: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a HS transmission is composed of an arbitrary number
of bytes that may not be an integer multiple of lanes, some
lanes may run out of data before others.
(Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)

However, for some DSI RX devices (for example, anx7625),
there is a limitation that packet number should be the same
on all DSI lanes. In other words, they need to end a HS at
the same time.

Because this limitation is for some specific DSI RX devices,
it is more reasonable to put the enable control in these
DSI RX drivers. If DSI TX driver knows the information,
they can adjust the setting for this situation.

Therefore, add a flag to control this situation beacuse the
mipi DSI specification is not forbidden this situation.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 147e51b6d241..df4d15345326 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -177,6 +177,8 @@ struct mipi_dsi_device_info {
  * @lp_rate: maximum lane frequency for low power mode in hertz, this should
  * be set to the real limits of the hardware, zero is only accepted for
  * legacy drivers
+ * @hs_packet_end_aligned: transfer DSI HS packets ending at the same time
+ * for all DSI lanes
  */
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
@@ -189,6 +191,7 @@ struct mipi_dsi_device {
 	unsigned long mode_flags;
 	unsigned long hs_rate;
 	unsigned long lp_rate;
+	bool hs_packet_end_aligned;
 };
 
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
-- 
2.18.0

