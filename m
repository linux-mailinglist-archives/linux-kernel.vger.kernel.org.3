Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5774F8C13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiDHBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiDHBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:21:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B234BB7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:19:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 8FD2F1F46B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649380752;
        bh=DRF0VVql1NDF1AFBXdreQkrM736cxZe8TLofRJp+rIE=;
        h=From:To:Cc:Subject:Date:From;
        b=CzKotq9B/GtJeR8NyobQE7fpb4jsG3di7QvNmI8YKfpttbMaevDT9Uf0OdhsDS3Wq
         kW0OUMPFd8j73Nlc3Lx7iohdfUWUeC1u6t+C0BUkKMEfMlejJb/BOwbGK3j4oiaQzl
         zV1wC6Be1FGMR6a/4BlZpDjMns3t8ZmMr6qU8M/9H3+myE196Vsk92YjgRydOUwQhB
         F1h6D4bzcLn4Cau+hHx5IL9LmniCCecJfT4lHOneb0gonTu8akKH5rN3Lxdb82jKcK
         rYHceKabJgfRjDlxubAvqcymueNkYSqbcd2MEn7p1ifNkTqfkboJOVEsqsCUZcY+/0
         Qj2e/jOnJFqkA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: dpi: Use mt8183 output formats for mt8192
Date:   Thu,  7 Apr 2022 21:19:07 -0400
Message-Id: <20220408011907.672120-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration for mt8192 was incorrectly using the output formats
from mt8173. Since the output formats for mt8192 are instead the same
ones as for mt8183, which require two bus samples per pixel, the
pixelclock and DDR edge setting were misconfigured. This made external
displays unable to show the image.

Fix the issue by correcting the output format for mt8192 to be the same
as for mt8183, fixing the usage of external displays for mt8192.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/gpu/drm/mediatek/mtk_dpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4554e2de1430..e61cd67b978f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -819,8 +819,8 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 	.max_clock_khz = 150000,
-	.output_fmts = mt8173_output_fmts,
-	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.35.1

