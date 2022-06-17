Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E954F663
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382227AbiFQLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381649AbiFQLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:09:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9926C574;
        Fri, 17 Jun 2022 04:09:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9199660179A;
        Fri, 17 Jun 2022 12:09:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655464172;
        bh=kG26VQ8Q/x/unvWddSRifHSxyfpmVSj9DL0msaHnGTk=;
        h=From:To:Cc:Subject:Date:From;
        b=SzZc7AaVQv6BGAz6/bQTRF7VdL+oQJ8Y+4L3ENHmaHaPTpwWr6CByK1pWvczLCZnK
         IHUHYfhfRL11eAzIUyL2O14QTYYXPON3437DiCYM+GxwQZAyjp6eTY5EIvyP/fcNka
         GE0dZFrn171c5+7rG9c5AUQgbh3n5HOCNoO0GZOPQYyB5N+T2CbbekkVEbIIj2we+w
         upQN7isUtnaH/rYvaLaxI19tinmeuCXhzHUOaY8CVo0scHEAGLhryv8qlpn2ez3FEV
         DLHOkp7fxRC8f6Krl28Yk/sQCsf0J7x6KA43UjHCHSkcQD5Ac9O1463VtNmWq/fg6z
         R45l4D5zWADKw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, rex-bc.chen@mediatek.com,
        jia-wei.chang@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
Date:   Fri, 17 Jun 2022 13:09:26 +0200
Message-Id: <20220617110926.90313-1-angelogioacchino.delregno@collabora.com>
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

This SoC shall use the mediatek-cpufreq driver, or the system will
crash upon any clock scaling request: add it to the cpufreq-dt-platdev
blocklist.

Fixes: 39b360102f3a ("cpufreq: mediatek: Add support for MT8186")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---

v2: Moved fixes tag on top of SoB (oops!), added Matthias' R-b

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 96de1536e1cb..2c96de3f2d83 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -127,6 +127,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8186", },
 	{ .compatible = "mediatek,mt8365", },
 	{ .compatible = "mediatek,mt8516", },
 
-- 
2.35.1

