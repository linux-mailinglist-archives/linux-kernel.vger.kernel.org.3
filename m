Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5710A5182AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiECK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiECK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:57:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3F33374;
        Tue,  3 May 2022 03:54:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 84E591F43E1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575251;
        bh=lZd+DG3UpSGFUrcfauTCxb9uhLYPRfZSRC5NUn+DRL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9z1T1OOuMqKW88TTxHG7ChxBDlOGk61luZJjp6eoeQTUHgevPFlA/3nRL+WLXRcl
         4NSAuZXIELUqPMBFSy29aDdZZbQF5qQnpXWmVmI4hKdQwhfxfJDfp0y2LlE+4Akkjz
         uiqDqSSMalE6PG5ZRQR4UEoMYoGolqul5xzB1CrfqYPQcCKm5PeIgWbnYymaNCFJv2
         pnQE4QrZ+LFKWUkS7Ck/+3H6JatEm3FgHil0eQGIiJ9y3CQFHKCVHex3KYYiT/nAe5
         CAFjy+ZWibVROAA2PaXWbu5IgBzhH2a2C2FU5SgYwJJuzip5shaqVuqWsfT5OFcqDS
         FzklHDM5yr+tQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] pwm: pwm-mediatek: Add support for MediaTek Helio X10 MT6795
Date:   Tue,  3 May 2022 12:54:04 +0200
Message-Id: <20220503105405.54832-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
References: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek Helio X10 MT6795 SoC has 7 PWMs: add a compatible string
to use the right match data.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 568b13a48717..28c2d0e5a8ac 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -264,6 +264,12 @@ static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.has_ck_26m_sel = false,
 };
 
+static const struct pwm_mediatek_of_data mt6795_pwm_data = {
+	.num_pwms = 7,
+	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
+};
+
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
@@ -302,6 +308,7 @@ static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
+	{ .compatible = "mediatek,mt6795-pwm", .data = &mt6795_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
-- 
2.35.1

