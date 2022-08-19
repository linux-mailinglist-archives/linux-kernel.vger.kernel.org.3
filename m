Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2515999AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiHSKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346578AbiHSKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:14:31 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7AD7417
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:14:28 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id 9NER2800M4C55Sk06NERnL; Fri, 19 Aug 2022 12:14:26 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oOz1F-001j63-BQ; Fri, 19 Aug 2022 12:14:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oOz1E-004KVP-Rc; Fri, 19 Aug 2022 12:14:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Molly Sophia <mollysophia379@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] arm64: dts: qcom: sdm845-xiaomi-polaris: Fix sde_dsi_active pinctrl
Date:   Fri, 19 Aug 2022 12:14:23 +0200
Message-Id: <629afd26008c2b1ba5822799ea7ea5b5271895e8.1660903997.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make dtbs_check" says:

    bias-disable: boolean property with value b'\x00\x00\x00\x00'

Fix this by dropping the offending value.

Fixes: be497abe19bf08fb ("arm64: dts: qcom: Add support for Xiaomi Mi Mix2s")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Marked RFC as I do not have the hardware or documentation.
Perhaps the "bias-disable" property should be dropped instead?
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 7747081b98875aad..dba7c2693ff50073 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -617,7 +617,7 @@ sde_dsi_active: sde-dsi-active {
 		pins = "gpio6", "gpio10";
 		function = "gpio";
 		drive-strength = <8>;
-		bias-disable = <0>;
+		bias-disable;
 	};
 
 	sde_dsi_suspend: sde-dsi-suspend {
-- 
2.25.1

