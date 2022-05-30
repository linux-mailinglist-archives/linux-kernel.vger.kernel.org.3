Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B7538882
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbiE3VHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiE3VG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:06:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D36FD36
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:06:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso179567wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4Dsh1MIN0xZI+gwJI4fdmqtKhkwKXeMWuLlT5BOjsQ=;
        b=OKrgQc11yJX8fKEPVNtBzhY21ZbZQAZal/ja/UUIIzsCs6+sNcHH2WixhvN2nxo2l3
         FNT+jV2PNa+JjuBlEkvQOJytcZmfw+V5wg/nrajT/5tDbxVRXfF/XiYY6LmQ1NEJybuK
         l4FrxW9a19JJbTz7ub6N+Uxg/u84OKsuTwASP1bzN69lv8B/llo9epRhEGR1KhRXsk8B
         6dDteDZmF81br7BHZiEN3eacOetqMHcsylMVBmN0YZVFB2CJLBCovPQsva02CUkpivti
         yUUBcB5c0XwUJf448eT+h5yoeDC3lWUS5HuprhstL8BKTMSYwvez+GWsPPyPRLb7gzPf
         dURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4Dsh1MIN0xZI+gwJI4fdmqtKhkwKXeMWuLlT5BOjsQ=;
        b=EwBSjPU2LkSQvtk0Vr39gVPCWEwoVXi/I1R7GNAyEJZn2xhnxnebqdSNlLImL6Felx
         ZBAXNlNkadUfYx4dUkKjrV2eP7Ymv5WTmsn90rCu6p1jNV0LMPhXwHyeJOxXeAI+vA29
         WsaKt5pP6ze0H8huGG9lkrHZo8nbKiZYmQw5bbXXF0MeRVksPCfFBwsWBZF9sI5ROrEO
         b0Il9SHq6fo/BVWDSanV7Bxi1U3C5qgMyfhP5o0t0L7OXxuRFQKM8nmIyja7W0Gipt2S
         iuywLjFLiO5JS0wz0zbZNG0nusvnqCzbvGiGh5du7IOX14MgjlRg4pNidRid2Ozl+aIR
         trng==
X-Gm-Message-State: AOAM532HeQFcfwRrzJmjxNweagCySrYwJDpj5gbvDZHUluwo/0dov7uH
        4IzPVwdX96d/8LY1cQtNWdOxWg==
X-Google-Smtp-Source: ABdhPJwG2tl1jXBhmNLSWLGoslj9EIocsj/Pg6OTboJM3vdwYny+rODj3GwjZ/Vcux1LDjwOK3eaaw==
X-Received: by 2002:a05:600c:3b02:b0:397:5cfb:b849 with SMTP id m2-20020a05600c3b0200b003975cfbb849mr20738067wms.183.1653944813393;
        Mon, 30 May 2022 14:06:53 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c15c700b003958af7d0c8sm270910wmf.45.2022.05.30.14.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 14:06:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] arm64: dts: mt8183: add dpi node to mt8183
Date:   Mon, 30 May 2022 23:06:39 +0200
Message-Id: <20220530210640.927733-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

