Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918B57352C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiGMLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiGMLQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:16:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0B102715;
        Wed, 13 Jul 2022 04:15:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 85C0C66015AE;
        Wed, 13 Jul 2022 12:15:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657710944;
        bh=he62TNO8XhfyzG98GzZOCha5TyM78B31K/Jr/Qt68kI=;
        h=From:To:Cc:Subject:Date:From;
        b=HyVpqpitt+9SP9MGnE9dBIeE1RmtbmliD1qYbJ8mpfhAhmubKxRw7b0LkxBwdcRYU
         aqs/grOUGGtnLCjBIEZVYSB40GrtfCFOu2u6K+GsNsdVN+ERco8WLbHCHIXVHn3NFo
         VeYI35zsVDzkPudMYLNTTOq/EHG25AGJR8GvkWpxj4ZNizpO2+VXNTAg9P79gB8X8p
         fc6qJDEkjDCvT7KxKCW5GYPIxSDL/i5oRM5ymltOlVlIxTn8M4Dq9kSB8lCEGgQrDO
         w2yy1QOKl38cXNRRimqK2CkhRz1F9gE1xfDZm3bMfbgcF3RtMOcPIYZ7wbBcu5uSIf
         rjoJHB3qAq5Pw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: mediatek: Handle sram regulator probe deferral
Date:   Wed, 13 Jul 2022 13:15:36 +0200
Message-Id: <20220713111536.115097-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the regulator_get_optional() call for the SRAM regulator returns
a probe deferral, we must bail out and retry probing later: failing
to do this will produce unstabilities on platforms requiring the
handling for this regulator.

Fixes: ffa7bdf7f344 ("cpufreq: mediatek: Make sram regulator optional")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 3a2be4552020..7f2680bc9a0f 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -439,9 +439,13 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 
 	/* Both presence and absence of sram regulator are valid cases. */
 	info->sram_reg = regulator_get_optional(cpu_dev, "sram");
-	if (IS_ERR(info->sram_reg))
+	if (IS_ERR(info->sram_reg)) {
+		ret = PTR_ERR(info->sram_reg);
+		if (ret == -EPROBE_DEFER)
+			goto out_free_resources;
+
 		info->sram_reg = NULL;
-	else {
+	} else {
 		ret = regulator_enable(info->sram_reg);
 		if (ret) {
 			dev_warn(cpu_dev, "cpu%d: failed to enable vsram\n", cpu);
-- 
2.35.1

