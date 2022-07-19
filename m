Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DB57A8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiGSVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiGSVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:19:17 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891015FAD7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:19:16 -0700 (PDT)
Received: from localhost.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 90DD52004B;
        Tue, 19 Jul 2022 23:19:14 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH v4 2/2] leds: qcom-lpg: Add PM660L configuration and compatible
Date:   Tue, 19 Jul 2022 23:18:48 +0200
Message-Id: <20220719211848.1653920-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719211848.1653920-1-marijn.suijten@somainline.org>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Rebased on -next;
- (series) dropped DTS patches that have been applied through the
  Qualcomm DTS tree, leaving only leds changes (driver and
  accompanying dt-bindings).

v3: https://lore.kernel.org/linux-arm-msm/20220511190718.764445-2-marijn.suijten@somainline.org/

Changes since v2:
- Constify channels struct-array (Bjorn);
- Correct LUT size to 49 slots (Bjorn).

v2: https://lore.kernel.org/linux-leds/20220507221123.2201668-1-marijn.suijten@somainline.org/T/#u

Changes since v1:
- Rebased to pick up pm8350c in the diff-context (Pavel).

v1: https://lore.kernel.org/linux-leds/20220504205704.699500-1-marijn.suijten@somainline.org/T/#u

 drivers/leds/rgb/leds-qcom-lpg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 02f51cc61837..102ab0c33887 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1304,6 +1304,23 @@ static int lpg_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct lpg_data pm660l_lpg_data = {
+	.lut_base = 0xb000,
+	.lut_size = 49,
+
+	.triled_base = 0xd000,
+	.triled_has_atc_ctl = true,
+	.triled_has_src_sel = true,
+
+	.num_channels = 4,
+	.channels = (const struct lpg_channel_data[]) {
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
@@ -1424,6 +1441,7 @@ static const struct lpg_data pm8350c_pwm_data = {
 };
 
 static const struct of_device_id lpg_of_table[] = {
+	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
 	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
 	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
 	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },
-- 
2.37.1

