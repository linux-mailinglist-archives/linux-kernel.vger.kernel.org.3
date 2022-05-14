Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE3527156
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiENNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiENNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:37:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006F22BDD;
        Sat, 14 May 2022 06:37:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd25so444066edb.3;
        Sat, 14 May 2022 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toXlyjRqxPOMu7FU0IW8LcSR73wz0FAFwkKHEk9OfQg=;
        b=mF0fvJmaxcPEJXwm3QYVF49GBdsbPWOj4de02PwDIcByndRXk4h4m06jv73pa0pSme
         2N2z/KsA3+HjyKj/TcHeWYFR54jRG+Hi7JuCuU5QLpIZlXTFIMttfIl9PQ9uZUhKYmaV
         tVIA5a3GN0/FUA1Vj+m+mcARIuiNLdN+633pa1cT7gXQ+XYCnGwbVy1IB5yO7eaC3cvI
         8pn4LKgtnupFAwjzNlYsh2u9B9A4rcjy8FuDyhfE7YjGW7xxhv0eBGyNx/oa7ACQ+HBE
         yDB3dTIOmazon6wB7+se0uhHtLlSzBumYL8BMnYndo89GFwO/jsmGx+Jq/Wh8fOTIpAc
         gdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toXlyjRqxPOMu7FU0IW8LcSR73wz0FAFwkKHEk9OfQg=;
        b=O/eb0Gp1atkITlV9zxq6209jGBJJGHh6GO0zUcitmjphM2JQcdLdZmYMkOeBj0UUB0
         skGbNAKUgZ1pyITzfeQ4RdMIHelLhi57BD99QJM/GadIj3NxdvblOm6Xhs2LtmRlk7BF
         7+mnZMmk+89lPpk+SGiqKtcDq2vgYClpcB+LuhKDqFgg4ihLzM+VdJXFT323xvTaeYqA
         fBKqJ1PHDncSjkMqpc3QH+lzgMizN3lfzosFCBTWNbnl0BL6srIfE185paXOP31XtapL
         a412U0/SFth3kR8oIds0UrX+sPBcIPm9+RM5M6tOoqL8gNXhVvS+16c6wZttdjFA3rZY
         cHaQ==
X-Gm-Message-State: AOAM533+oQX7VTJmBPqMWn6vZG97ihUdbi8yuXxjWqRx93pvVKY+8RZx
        b+KJt6vELjQImmNT/iLkDOw=
X-Google-Smtp-Source: ABdhPJwWj2/+V8JJuLG/en/GhFUmBSvLuOfOdP0FDOK6FKh3Z6r87dGQpB9uw240uYeEwToco2nhzA==
X-Received: by 2002:a50:fe1a:0:b0:425:e276:5adf with SMTP id f26-20020a50fe1a000000b00425e2765adfmr3840879edt.284.1652535422140;
        Sat, 14 May 2022 06:37:02 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006f3ef214e49sm1736739ejc.175.2022.05.14.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:37:01 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Sat, 14 May 2022 15:36:04 +0200
Message-Id: <20220514133604.174905-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 1042e68602de..9b4bed7a8a44 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -569,6 +569,26 @@ gpu: gpu@fde60000 {
 		status = "disabled";
 	};
 
+	vepu: video-codec@fdee0000 {
+		compatible = "rockchip,rk3568-vepu";
+		reg = <0x0 0xfdee0000 0x0 0x800>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
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
2.36.1

