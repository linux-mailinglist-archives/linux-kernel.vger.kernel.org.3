Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C0512576
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiD0WtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiD0WtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:49:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92212AE25;
        Wed, 27 Apr 2022 15:45:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g23so3523092edy.13;
        Wed, 27 Apr 2022 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okSCVW6L9a34IlYWN73Yo/cqzfL3+UCVtrLqSo2aTpU=;
        b=VyANRZ/fd8iCMPLNuxR0ZdOBJri3vl+dxRpNFPNquueLmI22pt9z1CufLP/RCkXqBU
         HE12KYCU7tCdTdS3MgP92myFap+2Qhpo2234wAoziCfC3S1iemkiDrGwqB5vRqWJaZfi
         k1sFXfrF4Iib9dchS73RcWhVzyzNKdhFlupxPTlrrJypPWNACuLGxEni82BSSwO7fdZC
         0eJpCrVmILCL49swcmkPA0pbU7xhtF0uuPEldPw83lgfJ6mZD30u/FnzvBTwazqgsd++
         H2RaOrmUgEDLgKLsRINUb/PL6So+DvxhcTLIZtn8A3VHJwwUNvs6jsVpWoxGVKA76j3C
         qxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okSCVW6L9a34IlYWN73Yo/cqzfL3+UCVtrLqSo2aTpU=;
        b=FGM/9JcnmN1kaU+CKK+7wr/zndEgOMyMjg1G9wWLN7Ant30aHMnrFWuvh1ZC6f5Ddq
         /8xiaLjyBF0bSgtKsxJ4wLM+Sbc8xS4S3ANogrzOkA31NpY1IZo3OY2fL+GZK75NK+8X
         5XkQ8XndEojvdJbPo35SI35NOCjOeOKQI9BWSes67m/2Qr+PHaaYilsmYgPU2f71X4CV
         XNteg6Hk7MLwq6fLWM6z5Go+mSmkSvt/m9Zqk+4oDRcMYyiBl1aXIA1Vg/A14KeaODAe
         cRLEtvWQeS5ADFE7loSUTvYA1E3EbxGgjUtStZALRtwoabZdRqWX8kZB57EQ9X1Qcmxv
         hR9g==
X-Gm-Message-State: AOAM531Gj8SIx7wA4EFrzEA0dSHdoe455NEmZV71nOKaD7HojZYPpTIn
        DYYZjcSa5hzZfU0TSDwEKv8=
X-Google-Smtp-Source: ABdhPJxuX/e930JKFnJ2zC30aKyv2otNuL/qGXSH74OgjR0UxhNtPyRDKxd10Peu7Gb553HbllMRbg==
X-Received: by 2002:a05:6402:1e8d:b0:426:9:6ec with SMTP id f13-20020a0564021e8d00b00426000906ecmr9938522edf.55.1651099545994;
        Wed, 27 Apr 2022 15:45:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b006f3a94f5194sm3762594eji.77.2022.04.27.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:45:45 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add JPEG encoder node to rk356x
Date:   Thu, 28 Apr 2022 00:44:38 +0200
Message-Id: <20220427224438.335327-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3566 and RK3568 come with a dedicated Hantro instance solely
for JPEG encoding. This patch adds a node for this to the device
tree, along with a node for its MMU.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..276b76d5f3fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -508,6 +508,27 @@ gpu: gpu@fde60000 {
 		status = "disabled";
 	};
 
+	vepu_jpeg: video-codec@fdee0000 {
+		compatible = "rockchip,rk3568-jpeg-vepu";
+		reg = <0x0 0xfdee0000 0x0 0x800>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vepu";
+		clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vepu_jpeg_mmu>;
+		power-domains = <&power RK3568_PD_RGA>;
+	};
+
+	vepu_jpeg_mmu: iommu@fdee0800 {
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

