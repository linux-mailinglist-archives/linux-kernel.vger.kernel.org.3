Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B325256C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358556AbiELU5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358537AbiELU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:57:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C296970B;
        Thu, 12 May 2022 13:56:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 521881F45AAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652389002;
        bh=GrZDgZ5n77I8KtnjA2tOlTRA6mI8tLLdvbtiFZXUTG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RU7yVXKMRydUYzQRyyhaqN22pMIXICErdzLysumVSWsTvVh2ykx91P6ya5K1xuOr4
         bnndX9h8DfFGC39p68a77R/glGAXwKjNVabl1xUHEWjIrwx19kB66OVmUUL2uAIbQ3
         lGU3pB6s4hlRlofDYaM3MYL2TuzSjKFJZc1Oke3ZkEpE3qveHSmOnNvPxO8Pj8iuhF
         h9reHCdOSEzjmHxQABet1e8eXIPOby31AH4CyaJlmIIaz3rQeYFmxSYnt0t6MjwXpX
         E48kMIRmvxooddEfnOf5R1TMuMRuKrvg1J4Qxq8e2VTFMT+AkUIOwTTbdGI0iihdbX
         J4l3W/In322LQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 13/16] arm64: dts: mediatek: asurada: Enable XHCI
Date:   Thu, 12 May 2022 16:55:59 -0400
Message-Id: <20220512205602.158273-14-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
References: <20220512205602.158273-1-nfraprado@collabora.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v2)

Changes in v2:
- Added this patch

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index d9c9852339a8..ecae2730789e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -583,5 +583,13 @@ &uart0 {
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
2.36.1

