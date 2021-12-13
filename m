Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297B473543
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbhLMTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:51:10 -0500
Received: from ixit.cz ([94.230.151.217]:46550 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233215AbhLMTvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:51:10 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id BB75824AF5;
        Mon, 13 Dec 2021 20:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639425068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eXNpgvmUGI/xsXfaBGu6T6lZYyCtjGgaudUrm9Xl7kI=;
        b=b/Yc0pvVyMAefjGIHDSrUQVjDjxuarsUKhlfR9KK00OdgNdX790kmPP/ftDjsX/gFZlZMW
        X82xt32gaXmpdEfEjKtPWtT+CRg4uMjNNjdYmKSXeu+kbPPy9bk/dYpftdG4yDydCk8jRi
        QGMFDIILNndw3aueDRdTZtuKjd4nk3M=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: fix microphone bias properties and values
Date:   Mon, 13 Dec 2021 20:51:04 +0100
Message-Id: <20211213195105.114596-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace millivolt with correct microvolt and adjust value to
the minimal value allowed by documentation.

Found with `make qcom/sdm845-oneplus-fajita.dtb`.

Fixes:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: codec@1: 'qcom,micbias1-microvolt' is a required property
        From schema: Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: codec@1: 'qcom,micbias2-microvolt' is a required property
        From schema: Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: codec@1: 'qcom,micbias3-microvolt' is a required property
        From schema: Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: codec@1: 'qcom,micbias4-microvolt' is a required property
        From schema: Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: codec@1: 'qcom,micbias1-millivolt', 'qcom,micbias2-millivolt', 'qcom,micbias3-millivolt', 'qcom,micbias4-millivolt' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Fixes: 27ca1de07dc3 ("arm64: dts: qcom: sdm845: add slimbus nodes")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cfdeaa81f1bb..1bb4d98db96f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3613,10 +3613,10 @@ wcd9340: codec@1{
 					#clock-cells = <0>;
 					clock-frequency = <9600000>;
 					clock-output-names = "mclk";
-					qcom,micbias1-millivolt = <1800>;
-					qcom,micbias2-millivolt = <1800>;
-					qcom,micbias3-millivolt = <1800>;
-					qcom,micbias4-millivolt = <1800>;
+					qcom,micbias1-microvolt = <1800000>;
+					qcom,micbias2-microvolt = <1800000>;
+					qcom,micbias3-microvolt = <1800000>;
+					qcom,micbias4-microvolt = <1800000>;
 
 					#address-cells = <1>;
 					#size-cells = <1>;
-- 
2.33.0

