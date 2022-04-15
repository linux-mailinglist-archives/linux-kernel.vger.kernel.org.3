Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12612502883
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352478AbiDOKxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352359AbiDOKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:52:44 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62873BA72;
        Fri, 15 Apr 2022 03:50:15 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id B9D784045A;
        Fri, 15 Apr 2022 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650019813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpMeInSeGLr2M/cKBKR/bsw167szY9U7Y8rOwB1eC+g=;
        b=xa/MHuLErIJSvr4HFZHA/fAkCJJWJgp6TXLjDbjeURjYppmeqpdwbHUh2DHfpFoRf10f+2
        uLb4teRhqiW964RAYNk62LPq2A+Wc5UvQoIi7XRO9Eb/KRMwJEvCxnhmtbCQF7Oh/BkDRA
        KdF62T+2WjOks+3ONv4oLdtrC7iVAaM=
Received: from localhost.localdomain (fttx-pool-217.61.153.244.bambit.de [217.61.153.244])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 68344100501;
        Fri, 15 Apr 2022 10:50:12 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: enable the gpu on BPI-R2-Pro
Date:   Fri, 15 Apr 2022 12:49:51 +0200
Message-Id: <20220415104951.27104-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415104951.27104-1-linux@fw-web.de>
References: <20220415104951.27104-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ef0374fb-5767-4ac8-ba53-f4bf2682b8aa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Enable the GPU core on the Rockchip RK3568 BananaPi R2 Pro

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index cc3591251bab..10f68d054f76 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -196,6 +196,11 @@ &gmac1m1_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	avdd-0v9-supply = <&vdda0v9_image>;
 	avdd-1v8-supply = <&vcca1v8_image>;
@@ -566,6 +571,8 @@ &spi3 {
 };
 
 &tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
 	status = "okay";
 };
 
-- 
2.25.1

