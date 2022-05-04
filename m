Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1751AFE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378450AbiEDVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378422AbiEDVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:01:38 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2418387;
        Wed,  4 May 2022 13:58:01 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 22B893F8E1;
        Wed,  4 May 2022 22:57:59 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] leds: qcom-lpg: Add PM660L configuration and compatible
Date:   Wed,  4 May 2022 22:57:02 +0200
Message-Id: <20220504205704.699500-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504205704.699500-1-marijn.suijten@somainline.org>
References: <20220504205704.699500-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherit PM660L PMIC LPG/triled block configuration from downstream
drivers and DT sources, consisting of a triled block with automatic
trickle charge control and source selection, three colored led channels
belonging to the synchronized triled block and one loose PWM channel.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 17576f77c423..e75db1813baa 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1271,6 +1271,23 @@ static int lpg_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct lpg_data pm660l_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 0x100,
+
+	.triled_base = 0xd000,
+	.triled_has_atc_ctl = true,
+	.triled_has_src_sel = true,
+
+	.num_channels = 4,
+	.channels = (struct lpg_channel_data[]) {
+		{ .base = 0xb100, .triled_mask = BIT(5) },
+		{ .base = 0xb200, .triled_mask = BIT(6) },
+		{ .base = 0xb300, .triled_mask = BIT(7) },
+		{ .base = 0xb400 },
+	},
+};
+
 static const struct lpg_data pm8916_pwm_data = {
 	.num_channels = 1,
 	.channels = (const struct lpg_channel_data[]) {
@@ -1379,6 +1396,7 @@ static const struct lpg_data pm8150l_lpg_data = {
 };
 
 static const struct of_device_id lpg_of_table[] = {
+	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
 	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
 	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
 	{ .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
-- 
2.36.0

