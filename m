Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E374DC535
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiCQL6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCQL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15041E6EB9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:29 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54C133F7DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518247;
        bh=9zBbrIVySme8IHRcwhL+hzcd9fjni90AU02iDVUn98k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RUAJlnExixOKv6xQJz+N5sNFJU8dQzq+R+gFQIVdczugTvYrDW8dC/1De1q5E5MCM
         tX5Qcnf2TdgsWx7rFHLZ9Gl0J5qKUYYQfTmubI7KGLrG7w7EnZsw0JxOTR5cGmQ0H7
         H3rbj0QPA63U2zDgPixlQe+meFlIPgXs1EYqSbvu83gXrWi9Zd7qjxm1l1DJlsxnR+
         3JlpACEppq9XKV/Z8pI3uV7T/2kTYRYThqx0J0BvAS14GTRyXFYPdoQuSdHEh5HEiN
         LH0s9atDegDlWvNJJ5UMfAGENn8P014thv6GT73wCF7YxwRj0G2+z7iMhDdyfx+eMq
         7hii9uXips2eA==
Received: by mail-lj1-f197.google.com with SMTP id d16-20020a2e8910000000b00247ff33e987so1972139lji.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zBbrIVySme8IHRcwhL+hzcd9fjni90AU02iDVUn98k=;
        b=y5sctTSNiB8Zn9vFRVs5XD+gEC+LQ8lk3J8+oFqnN9muM10xdcxEnE3fdOXW7ignpe
         42z1RB/U0x+Xn7R5uzxP4AFqe+qiSF9nWrY54bpailAwievZbDwz/13C3j++kWNHusNF
         rGu7LpGX/BuHAdZRYnpMcFfEizgRCp6l9loxOXksSe/GVmILIM7wohZh9dvt93HHo/eu
         ZUBmUTWlIvr499sitTPQzTHbMMmpi3J+5ru/17fc4WGVgsYE6k50tt1i8Baqm7+1Rrpu
         e4Mbhsx1Hw8foAXIbG3sipor7s0ynh7zrI2HUpsstvlrM9bCt2pUeuUi+YWBpyYF1rE1
         GeYQ==
X-Gm-Message-State: AOAM532BeAIXMGNbWDr1AMWVGc0uRgyews9FqofMLXN6hcn7cZrNxK77
        9NJX4O8Zpd5E6xfH8uSV/dk9sbumjG7Ywb4z9UvrUHwc/hunFp479K/1n4pEdC7Fa6FvkZibeDY
        ueONPjrM1095AXlIkABxZEgFxTbA0vPYXDf3jAa9Tmg==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr3633454wry.52.1647518236426;
        Thu, 17 Mar 2022 04:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRVHHUrn4Gc7Ji2R1ZLqLDKn0bipCiLCnFH300rCQjMQzGcy481HRPG22f9lNVTtX9qFN6oQ==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr3633417wry.52.1647518236248;
        Thu, 17 Mar 2022 04:57:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 03/18] ARM: dts: socfpga: align interrupt controller node name with dtschema
Date:   Thu, 17 Mar 2022 12:56:50 +0100
Message-Id: <20220317115705.450427-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  $nodename:0: 'intc@fffed000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7c1d6423d7f8..b8c5dd7860cb 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -46,7 +46,7 @@ pmu: pmu@ff111000 {
 		      <0xff113000 0x1000>;
 	};
 
-	intc: intc@fffed000 {
+	intc: interrupt-controller@fffed000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 3ba431dfa8c9..f1e50d2e623a 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -38,7 +38,7 @@ pmu: pmu@ff111000 {
 		      <0xff113000 0x1000>;
 	};
 
-	intc: intc@ffffd000 {
+	intc: interrupt-controller@ffffd000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-- 
2.32.0

