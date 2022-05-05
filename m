Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E354B51C98B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385451AbiEETvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385443AbiEETug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AD5E748;
        Thu,  5 May 2022 12:46:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 9B9201F45CD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651780011;
        bh=m1JTt5Fhkh+wV/Wx5MQaFp1SHyGbtuJWnkpiKW7wYyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gag2AsnwQgh2vQVDAEVDp4CJ0Gg0ajkhD3r6zJ6ryZ0yKuIZg0659ICdeIjNunthQ
         IYhJNu0FB7Yetj0JqD0+lQtapqYLyC1MG88tvbbrvEdVVyPNKYs/Z3p2TFprrh2hAS
         qIzVyQ6I7NgSznVSvf0F3GDHxMW4pFgF6rgtbwhTua9kjdXIIHAnfxnW7DGSN/Ou4Z
         hZ2ILyVPMOihj/DUAZTGHFe0HL695bWtSxlVu3CTji/ksEs7i7haJHSeFdrkHEqBp2
         oLDQtZxowi/i8TqBvVhRI7zJVnO6uZ+IZ5lfQJLA2Rai3e1afiilN+M9GlaJ9jqLMn
         IgUs2DYqCXetA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 13/16] arm64: dts: mediatek: asurada: Enable XHCI
Date:   Thu,  5 May 2022 15:45:47 -0400
Message-Id: <20220505194550.3094656-14-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable XHCI controller on the Asurada platform. This allows the use of
the USB ports, and therefore a rootfs can be loaded and a usable shell
reached from a live USB image.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Added this patch

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index c852cb0e8b63..4f9a9ec046b0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -583,6 +583,14 @@ &uart0 {
 	status = "okay";
 };
 
+&xhci {
+	status = "okay";
+
+	wakeup-source;
+	vusb33-supply = <&pp3300_g>;
+	vbus-supply = <&pp5000_a>;
+};
+
 #include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
 
-- 
2.36.0

