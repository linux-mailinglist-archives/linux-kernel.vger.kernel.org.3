Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05B57D26F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGUR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiGUR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:27:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79F89EAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:27:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD84A6601ABB;
        Thu, 21 Jul 2022 18:27:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658424452;
        bh=Jh+MlVqOqL9qKgG98dGWwY/Of15G6iLMIOH710td1SM=;
        h=From:To:Cc:Subject:Date:From;
        b=cayjJKtQwMz2Rn6isFsbHQLUnPG5gkgRifmNaeGhfEyIqF5wkn8W9ec+CT3UKaLo3
         hti6Z2gjaW588AK2Zy3kfucW7qVMpylIcHDFviC0FJqs2IHqvZ6j88ojd0U/HLkDWy
         csRXO0pTonVcJK0lxLhuvMxtjvogs6tpEDChwxa4jg2nBfEh0N2tjR4UTYeEXRwpsU
         GnqyqK4huOn84Y6EntLAqy4hhimFYLVfrS3qXHOKWKwWlK4axoLcdrzoIAw6MN9y5s
         KRfzDXhgifHXM1okNdwOE7dZzVU0nDtjzfDuPo3mWl2PupKe6bPykK1p6xu5xsetFy
         lZkXlDXEMKo6Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/mediatek: dsi: Add atomic {destroy,duplicate}_state, reset callbacks
Date:   Thu, 21 Jul 2022 19:27:27 +0200
Message-Id: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add callbacks for atomic_destroy_state, atomic_duplicate_state and
atomic_reset to restore functionality of the DSI driver: this solves
vblank timeouts when another bridge is present in the chain.

Tested bridge chain: DSI <=> ANX7625 => aux-bus panel

Fixes: 7f6335c6a258 ("drm/mediatek: Modify dsi funcs to atomic operations")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Note: The commit that has been mentioned in the Fixes tag should
      *not* have my Reviewed-by tag, as the author changed it but
      erroneously retained the tag that I had released for an
      earlier version of that commit (which was fine, but the new
      version broke mtk_dsi!).

 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 9cc406e1eee1..5b624e0f5b0a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -808,10 +808,13 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.attach = mtk_dsi_bridge_attach,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_disable = mtk_dsi_bridge_atomic_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_enable = mtk_dsi_bridge_atomic_enable,
 	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
 	.atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
-- 
2.35.1

