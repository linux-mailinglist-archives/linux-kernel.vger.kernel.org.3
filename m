Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F051F123
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiEHUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiEHUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:30:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066A1114A;
        Sun,  8 May 2022 13:26:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so23275494ejj.10;
        Sun, 08 May 2022 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSUnltcnxB8eV4VrYsSiSm4/tOdwwwPKXlxEHNw+w2o=;
        b=m6VYQkJuWb7ICTN5thHvelfUzu9+ccnwndD9rTLRax278oSgt0bZQQb3VO0i+pCd3R
         uyOfkYApc5ZyOq5ueuTmDhqqH96VUf5xTDLapsjMf12sfp9WTvWtEnzC4cT5D0JW5ZJQ
         /0EmuXTZKBJQbNTIRRRTvSTM7Eq7FxDH0D/OOuzKBcHxBXWTWXtcGtULPAfOWKlOe+z+
         RU8A6g3K9GmrQo0LpsoQB6sHkFy0I9Jua3CBOKyw+KafJqUq09d9WqrNaRmGIAXSsVUJ
         D62qTk05ZDKloElvhBM5AXuywrW417DI2+oRq7rI0yhMvomyxud5UcLivza634eBNsqg
         Xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSUnltcnxB8eV4VrYsSiSm4/tOdwwwPKXlxEHNw+w2o=;
        b=5qzNAp1V0XMUk1iHEt6Am0wYkHSrtDqClsoYrUp9ZWSp+RnBXbrQfrjKI804v+jKHz
         MCG1w+uSzwq7ueBw4DB6zcISy4k+6ZkLyUrU7FxitQ8PKHmmFgCL/W+v7cIoWLkUkEZ8
         vdwHN1f2R3uthkEX/yPKFr74LjCwZcCk5Lko/aC0hSi7odUJtA4Wg/fQlu3vrU6npuXi
         4eSGxq9KuM/F95QLbKIfyPZdZik9KpN3ZcKlqulnvp0RBqw62r8NhtnXFzBYYslzVQFz
         lkehRH4Nqy8Tfp/FRRRVPdTem+UQQq6yTr83dvrBYMflBoi/s2D7TzyTOWTCAfMabkin
         /RWw==
X-Gm-Message-State: AOAM533kikSftUFA0kQBQFPJcj6C1YIbTmsdzmIVgsavcq4rKmxfaU/6
        BVHaXg4T1eJkn3NSm4NCSPg=
X-Google-Smtp-Source: ABdhPJzdMN/f7ZWaohfNeUNNXrNq/2c59BKKXWhM2P/3Puseb7ir8GLeyLApz66URMK4byTWlj4rxw==
X-Received: by 2002:a17:906:6a14:b0:6f4:78b8:39e7 with SMTP id qw20-20020a1709066a1400b006f478b839e7mr11662003ejc.309.1652041568682;
        Sun, 08 May 2022 13:26:08 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e1esm4341459ejc.132.2022.05.08.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 13:26:08 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Sun,  8 May 2022 22:25:44 +0200
Message-Id: <20220508202544.501981-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3566 and RK3568 come with a dedicated Hantro instance solely for
encoding. This patch adds a node for this to the device tree, along with
a node for its MMU.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..2e3c9e1887e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
 		status = "disabled";
 	};
 
+	vepu: video-codec@fdee0000 {
+		compatible = "rockchip,rk3568-vepu";
+		reg = <0x0 0xfdee0000 0x0 0x800>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vepu";
+		clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vepu_mmu>;
+		power-domains = <&power RK3568_PD_RGA>;
+	};
+
+	vepu_mmu: iommu@fdee0800 {
+		compatible = "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdee0800 0x0 0x40>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3568_PD_RGA>;
+		#iommu-cells = <0>;
+	};
+
 	sdmmc2: mmc@fe000000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe000000 0x0 0x4000>;
-- 
2.36.0

