Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A672552649
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiFTVMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiFTVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:12:19 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7681A83C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:12:15 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B3F632013A;
        Mon, 20 Jun 2022 23:12:13 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-akatsuki: Round down l22a regulator voltage
Date:   Mon, 20 Jun 2022 23:12:12 +0200
Message-Id: <20220620211212.269956-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2700000 is not a multiple of pmic4_pldo's step size of 8000 (with base
voltage 1664000), resulting in pm8998-rpmh-regulators not probing.  Just
as we did with MSM8998's Sony Yoshino Poplar [1], round the voltages
down to err on the cautious side and leave a comment in place to
document this discrepancy wrt downstream sources.

[1]: https://lore.kernel.org/linux-arm-msm/20220507153627.1478268-1-marijn.suijten@somainline.org/

Fixes: 30a7f99befc6 ("arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C / XZ3 (Tama platform)")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 36ff1178b705..3839850cf7dd 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -22,8 +22,9 @@ &vreg_l14a_1p8 {
 };
 
 &vreg_l22a_2p8 {
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <2700000>;
+	/* Note: Round-down from 2700000 to be a multiple of PLDO step-size 8000 */
+	regulator-min-microvolt = <2696000>;
+	regulator-max-microvolt = <2696000>;
 };
 
 &vreg_l28a_2p8 {
-- 
2.36.1

