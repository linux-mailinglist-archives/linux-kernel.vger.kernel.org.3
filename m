Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB55237CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiEKPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiEKPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:53:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C99AE7F;
        Wed, 11 May 2022 08:53:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so4898050ejc.13;
        Wed, 11 May 2022 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fg5Nzjhs3fr5rSwk6Iz/2XPkRGYgF2tY/d4ceMcAoM=;
        b=YcB+oMZTgmuRzalJJyIxDg7S8mCjfLNaBcjTjI6H/O/9pBVI5JZAcGOM4KgIdk/psE
         29sA0AHei/DQ7FaqWxRmy18uOoSk4AAqHkcWqr1+NWKejifLM7u7Sa9LyoLudIvPzJrv
         o4EVHDilSgpS1K7VMpEMdc43NqMGWwY949pvQOgmDCJdymeVAot+bs2YsVMBOG58H6vY
         H9NrLiLDwQmmi3TbZhTk/BMhEg0ubePrb2+U6O025RuUXpdXOuwSqmZUiQ3We2RNXPnj
         9yslpZQ+sYoP6AdE26hlXlCG28K2+Praw+OpWVUnMs5S+EZDhFX9F1rMZLhau+CoSsbQ
         NPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fg5Nzjhs3fr5rSwk6Iz/2XPkRGYgF2tY/d4ceMcAoM=;
        b=UsaqNvHTc7RXVKCgQm9Tk23e8GzZh3h731isTXDt4y/6lfwS3jH57ReqiMfIT85vZD
         fGgWE3uf7mN5klZ0OqFFDVb1+HqG0lV1XgjkpC7vh+XsME9SeXuN4IIZWCOiXusZZjRp
         2hVyG0JDNyqGHnSbgUFs7UrkwJeOJ0YFJgCElbFbHsrBtCoYsEnfYiYvJM9qLIQKPxyk
         H6Wg+v7W/fc/Nzo9p9lU82zP2KvJuvBufMJyr3KD472TCNvxJtjcDPY++sWGBYaSJurW
         m6AyGqyYbCh6zgJqwi2i5kBU7AE1V7TACf4f8qMaz5DJI+Ja+CPG+ei3i1Hhs2R0/iC4
         3iJw==
X-Gm-Message-State: AOAM5324F6kWhR7i4P/NdEBeYKnO1T2pRRElWr5JJVNLtSL5wDaOAHEB
        tofObgpUabIZNA2bI/4uWfI=
X-Google-Smtp-Source: ABdhPJybtTb4hy/yCAfASXiU8rK4aH8rB3XXtZigSeku4xIBcXrFT2uAPQURviyW/zkQezUOEjlnCQ==
X-Received: by 2002:a17:906:e9b:b0:6f3:cfcc:922e with SMTP id p27-20020a1709060e9b00b006f3cfcc922emr24996863ejf.346.1652284431371;
        Wed, 11 May 2022 08:53:51 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id fb21-20020a1709073a1500b006f3ef214e1fsm1072458ejc.133.2022.05.11.08.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:53:50 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Wed, 11 May 2022 17:53:08 +0200
Message-Id: <20220511155309.2637-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
References: <20220511155309.2637-1-frattaroli.nicolas@gmail.com>
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
2.36.1

