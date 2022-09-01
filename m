Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1625A97ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIANAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiIAM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:58:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634A90C54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1393187wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QXNec13rQxx7mczo0Bb45Dl1W4/rRz+jQsRU4AeJnZM=;
        b=stFp2ZLkJAsW6hGzxfz+PRuE4PLjXsmpU2vPFtfvFB4D4UY7QRGYTcmrZDewn8b8Ai
         s3KNutoE3J5bhfFRhTK0Uzt5uo9TUlMly5jaflRtPoh2XyUwX5hk/W4yGlb57OT53GcY
         a5QztEb4kIG7jRm8WUgf/+eeUX/8qICHMBJxuL4cfoRw90Izq2TPrlnE7qyp3fkwUvBb
         cdgmHqzVPLDdtLVDMLG/0GirMrCRHYDk2kjjzGnopMKhGabvPyaH52uaJp/ihYkD/83h
         AfLwURWnLcWt7gqHDDqHx+H9Nj6B/lWBDl1hDRDJM4wwF9AulrGJJici9hKemQ98OhwO
         m6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QXNec13rQxx7mczo0Bb45Dl1W4/rRz+jQsRU4AeJnZM=;
        b=rHq4e9zaqulaekt0YVIak3rBcudgKBrQQZy+Y9TuVciLZDnCUXaChIbhOb+15Tb0rK
         aCWrjDOBkc9jqx63xftlBC1pITKgwIGkrTacild3FFjI+HYPLFP/rwbQqhJDY0edLpjS
         diTHfz/0cvItjcyiyjKzcd/jUNLYO2C5HrQjpqLjxQ0EHfPANnBixYyY4W9N9wz+VdPh
         NBR8HccwD2Zo15Htfso1e/45ohtSqoFIlLM8xz1GL8lrXlceAEkMSUL8IY4tfUqAxXnF
         mJu8GCZyaRWh+c6pPzacWjQzgk71klDM3yz/WzlLdAEoOokFzvcvroKlwZkY4dPesAG9
         CvFg==
X-Gm-Message-State: ACgBeo3Xl/9/2E13lvwJDDLSUQgh+6/G5Eg0FoA/oOEoXnewYYWFDVIN
        7F6JIvaJaZOMxmWbNzheNLkv6g==
X-Google-Smtp-Source: AA6agR6kskfAoZag4yYUzmRw/gm3W6IjBrrVyQaAOK+QT10cru5zUronjFtmjvUBalKY+JyRRJLqPQ==
X-Received: by 2002:a1c:4b01:0:b0:3a5:94e8:948e with SMTP id y1-20020a1c4b01000000b003a594e8948emr5115728wma.197.1662037064747;
        Thu, 01 Sep 2022 05:57:44 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:44 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v9 27/33] arm64: dts: rockchip: add rk3328 crypto node
Date:   Thu,  1 Sep 2022 12:57:04 +0000
Message-Id: <20220901125710.3733083-28-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3328 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 49ae15708a0b..96a7a777bae8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1025,6 +1025,17 @@ gic: interrupt-controller@ff811000 {
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3328-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "hclk_master", "hclk_slave", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+		reset-names = "crypto-rst";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.35.1

