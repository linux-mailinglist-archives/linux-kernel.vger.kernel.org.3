Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB75C547AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiFLPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiFLPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:54:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4933818D;
        Sun, 12 Jun 2022 08:54:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o7so6799573eja.1;
        Sun, 12 Jun 2022 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkOhkCBf8L6W0qXjfkueWj/eTLwif/nqIH2509i56Dc=;
        b=DCZIlrl3no93ZcB5AK79UcPT8IC1ngePkvS9mA5G5ZTiUnCY1KvfiXx13TlQhW6lyB
         Z7CYatD000q9XAqjS/rL5b/vUg+6RgUeKpWNtzACWaOnwVl3CSMuh9s4AvVabho6g6OG
         nQV1MoZZX2ssufbRyykH4nI1Pat/KUUYVpGVDWKquEkdDF12bQuw/62OjOClQsfS3SYq
         Cw//QztzF9Fx8HeYB3pz7kOxce6vaBGPoKWyCLL/aKFJOcO9B8tXPyO3BCNvqXzc1LC1
         qPs6ztNL8KvVnjN/sS4qQY0kxwKk1hxmGIOgq5cdMRX1fmGCxNUHkY7t+j36pKzJhqmN
         answ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkOhkCBf8L6W0qXjfkueWj/eTLwif/nqIH2509i56Dc=;
        b=waJFcnm6/7aeE6/CCgg01e32QWGztogxB9hiUHq+zp4+/jQIlqu6G0ybEn7eahMKST
         gYYf7gLeN7ciPC1i7Io+kJvq9LOcylkcmR/l4BzrmbgUNaaRgLDVAt6uisdBZSzx1XY/
         DLDPOM9fm6ruQ9BjzP925/EHRDYNrzpgi+yrSYgr7swKW9gPpmWHeL6L1WFQt3eH+pdS
         Ws/jg257MamFM3xuC+SE8avyCFqmVwQZQ0G9xTTL6ahD6RkdOR6HXmiJQSg6UodaAKbM
         iZiSXU/RA4S839cAPZOCoWCY9zCwFwoEDQoGFn7dkTZBNFtmErzsQWUXlWBDDpMgf+NG
         F2Ug==
X-Gm-Message-State: AOAM531OHuMExUz9H4CGJCwYtKYCDGw6TDpuPPPEceVq8ANbYbVgOTz6
        iJgsn982yBAlDW+HOwivyRQ=
X-Google-Smtp-Source: ABdhPJzo+GfLnE3D16gIoyA3E5dYq4u+nH4Sw5omIc0Bob7QpLXW/EHxy2NWsFEZyk6fMNkZxn4yhQ==
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id b16-20020a1709064d5000b0070dafd41e63mr46025241ejv.618.1655049283717;
        Sun, 12 Jun 2022 08:54:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b006f3ef214de7sm2609459eju.77.2022.06.12.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:54:43 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] arm64: dts: rockchip: Add Hantro encoder node to rk356x
Date:   Sun, 12 Jun 2022 17:53:46 +0200
Message-Id: <20220612155346.16288-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
References: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
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
index cc1c5a65c5e5..73a1403192e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -576,6 +576,26 @@ gpu: gpu@fde60000 {
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

