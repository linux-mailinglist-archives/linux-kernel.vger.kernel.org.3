Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E862510473
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353501AbiDZQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbiDZQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:51:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2DF488A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k2so5862338wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4Dsh1MIN0xZI+gwJI4fdmqtKhkwKXeMWuLlT5BOjsQ=;
        b=4RGJ1GWCGaRqYH7/PaHb5ZLmdutMuHjUNGWfkBquGA1U2RooGiMDqO9bvYVUWCYTeS
         3pgWEyaxGDIyUEW6UYtA1v9zTpn01nmefLwkSVdhQuvHtemFICCmTNhLxkRCOpPxAVL/
         Qrhk8lyyFac2/hwXxfqOeNV0ujOVdxkxkcPOf8IPAWWTUbcA+5bkhCrxgnFBqCYOTfrA
         2a9f8sGovPTc+4hS2XPwwRrws22Eu2m78cWLxOCwwSwDoiP12ZvEg3QsIqj6HpceMmVu
         MrKqwLvcfgXDc2pKVro7BGyQizR52D14IABJKwvfREGIPZF51VRnjwcBjQ8yjm3BHjbj
         rI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4Dsh1MIN0xZI+gwJI4fdmqtKhkwKXeMWuLlT5BOjsQ=;
        b=BFUhvBxT/aPBrPttm/6ptjnJrv2M/tDvABlYVtVqhHS/zfSanSQmGudFMbEh7ElVCk
         pQ+7iv4HozLNluvl3HQxnIgNbO5ZYlZey36qhlvkdOlRHD6T23e2G5+1S6g5Odh3SYPq
         qA8yciVJDTWEO8SE+2/V5g8MkRPyYW9Eme4CnPqmmGOW2taAzVzS5dZopmVYtxUk1oIp
         pBbzrEPvCnQtS1YfrKpQAui79rgZN0eyvIbJhNnMlU27fH6KBnCt21iqPMvo5Xe3brmE
         ZHAxDzOiuW+on0cpUv8eNBEyJzJBo3HUStwKVqnPCc/T1Gf4FI/5AL0qeV80z+VkXFoU
         pa4g==
X-Gm-Message-State: AOAM531neYfOJSZJbJTvMiszUxSLs1bU90ETzx8iWo6ZfEzzGD+HhHAY
        HT17TIrWnDCY6RLmLuJEvqAFhA==
X-Google-Smtp-Source: ABdhPJyQj4nlAzq8f49npdb5BnklLFCtyQ6VIVK795e5133V4LSp0puZE2gqfmU4YR9lWfCCN9WEsw==
X-Received: by 2002:adf:b34a:0:b0:20a:d6e4:cea4 with SMTP id k10-20020adfb34a000000b0020ad6e4cea4mr12132328wrd.675.1650991573906;
        Tue, 26 Apr 2022 09:46:13 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm14499539wml.5.2022.04.26.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:46:13 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: mt8183: add dpi node to mt8183
Date:   Tue, 26 Apr 2022 18:45:46 +0200
Message-Id: <20220426164547.434324-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

Add dpi node to mt8183.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: no changes

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 4b08691ed39e..49e662e34b36 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1507,6 +1507,17 @@ dsi0: dsi@14014000 {
 			phy-names = "dphy";
 		};
 
+		dpi0: dpi@14015000 {
+			compatible = "mediatek,mt8183-dpi";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DPI_IF>,
+				 <&mmsys CLK_MM_DPI_MM>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL>;
+			clock-names = "pixel", "engine", "pll";
+		};
+
 		mutex: mutex@14016000 {
 			compatible = "mediatek,mt8183-disp-mutex";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.36.0

