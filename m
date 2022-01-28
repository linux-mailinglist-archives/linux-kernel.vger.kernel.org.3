Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F049FB84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349031AbiA1OVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348069AbiA1OVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:21:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7302C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:21:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BD9831F46061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643379661;
        bh=KYW2yecCoVBOnjMv+GLtAgdWuyfAb453i/OaAeY6CaM=;
        h=From:To:Cc:Subject:Date:From;
        b=TuWi2W6SvZVi9AE07A0UXEqa+MmeT/bLGKQnijiUxFxcG9+oRE6PQydX14DiWpJgq
         VR3SqEm9t7cbM4EvYtBMRPxAg95Ms4cVy6oIWLhbwwXzUao+YLk21sGht8iBTS0zaM
         tIhram3C1GZBcSwPaNCpAwSYWDJk8Bna4WUDioJjWkROX4m9jrW6J22RltQaYc80Ej
         d87yM2k8subrXo1erK0myMENkOCqh8Fnares4C9xXWP8BtUYl/lYTrwIDgLSiVhDpy
         AXwfHd6yupQvMSfB+IqX0GhqommNIqClOrybTKzrrYwIIcb9NlIJZpcchehuQPFyYZ
         dIVVtBwxXYeDw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     yongqiang.niu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mt8192-mmsys: Fix dither to dsi0 path's input sel
Date:   Fri, 28 Jan 2022 15:20:56 +0100
Message-Id: <20220128142056.359900-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table"),
the mmsys routing table for mt8192 was introduced but the input selector
for DITHER->DSI0 has no value assigned to it.

This means that we are clearing bit 0 instead of setting it, blocking
communication between these two blocks; due to that, any display that
is connected to DSI0 will not work, as no data will go through.
The effect of that issue is that, during bootup, the DRM will block for
some time, while atomically waiting for a vblank that never happens;
later, the situation doesn't get better, leaving the display in a
non-functional state.

To fix this issue, fix the route entry in the table by assigning the
dither input selector to MT8192_DISP_DSI0_SEL_IN.

Fixes: d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8192-mmsys.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8192-mmsys.h b/drivers/soc/mediatek/mt8192-mmsys.h
index 6f0a57044a7b..6aae0b12b6ff 100644
--- a/drivers/soc/mediatek/mt8192-mmsys.h
+++ b/drivers/soc/mediatek/mt8192-mmsys.h
@@ -53,7 +53,8 @@ static const struct mtk_mmsys_routes mmsys_mt8192_routing_table[] = {
 		MT8192_AAL0_SEL_IN_CCORR0
 	}, {
 		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
-		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0
+		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0,
+		MT8192_DSI0_SEL_IN_DITHER0
 	}, {
 		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
 		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0,
-- 
2.33.1

