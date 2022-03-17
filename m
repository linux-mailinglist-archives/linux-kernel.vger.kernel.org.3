Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7194DC513
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiCQL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiCQL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:57:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B1C1E5335
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:55:48 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 69CC43F20A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518147;
        bh=FcFbQHcGNFkpGdda+W/UDbbdrtmD52pzfetu6Zdta/c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YZbm3vVQ5reIqHrD1wDGRrwe2UaTeuW2u/cuxT1NCrAqf5Qh1AgPwhikB1ksPwYO+
         PBlU9Or+mWV/avsWVAvB2cGO46wyyrPJlYdZVuRa9OdFtAc8RDV/XT8x6Npt2jn+lz
         Z5UlkzAlfWa9hjcP53b8pJUfRUmoXPmHdJdaYsYN0JmNI4PLphHznVs87zGNFJn/Ue
         atJSFJnE7P7wts6qJoYD13LwslAr0Ng86jpe4PJ8v4g2pMgiMSo5mgDmG4KOlH7PWT
         86/nV5ar7/ALyIRlYPXoZogYfrT8JYkjnYTQvx9x8o/iUnnXIPj7enFPWjtv47HPbi
         tdRlfXPm0DdSw==
Received: by mail-wm1-f70.google.com with SMTP id q65-20020a1c4344000000b0038c7c65e120so341868wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcFbQHcGNFkpGdda+W/UDbbdrtmD52pzfetu6Zdta/c=;
        b=vaMTkyiXHlM97cabQRfgpw7qPsQZaoGmib9K6uq2Fn0JtMqlB5tNziMmcbT0psJB3g
         kjFF36CJQ3uWQ/kzWTKEv8S4LzaIATcpRr+0iRJbPgFWLT/+8L4wxq+LmJlLSkbPagjd
         55NiZZ/ji0oTHjge1oR+d0k7OCWFw3RpRfcYdGz98+rFM0s56YS32zi+jWS03/0fkg0E
         qO1t67d2C41mq6ZKX2RMBVvOuSDKVKQ5os9bUW3ZaGh4fReF/p0fjYZzZKX6gmsffXOS
         Skwj4Z+7qkXcmkaOdzX2S3D0u0ILe7nz9UaFcOc8mel32l9KzY4PkODGl4ck7ucn+Ywq
         m6Rg==
X-Gm-Message-State: AOAM533vFzeIpljrdvRIYkOYl0CCgJxk2dHydvm+QBG4lsDgUm8c4J9H
        rOlSYCZoDJFDwF0mTgWwd4RdpAxDrPU0/2l9P1VDtwRaUfK9rQva8P3OnT+QODvkfMgyMm3YNP5
        QuyyrpISVnotJVw4KeA0EWt91FEdb40QRC7Rv97R6rA==
X-Received: by 2002:adf:ebc3:0:b0:203:da35:a9c1 with SMTP id v3-20020adfebc3000000b00203da35a9c1mr3846086wrn.610.1647518147100;
        Thu, 17 Mar 2022 04:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo+9tYsHqgUbTsMitSzq8mwjoiBGte5RGn6KnSHAj4SsmoojLzUqarbdnwawIw9oRk9oUklg==
X-Received: by 2002:adf:ebc3:0:b0:203:da35:a9c1 with SMTP id v3-20020adfebc3000000b00203da35a9c1mr3846069wrn.610.1647518146894;
        Thu, 17 Mar 2022 04:55:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b0038995cb915fsm11462862wms.9.2022.03.17.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:55:46 -0700 (PDT)
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
Subject: [PATCH 00/18] dt-bindings: irqchip: include generic schema
Date:   Thu, 17 Mar 2022 12:55:24 +0100
Message-Id: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Hi,

The DTS patches can be picked up independently.

Best regards,
Krzysztof

Krzysztof Kozlowski (18):
  ARM: dts: nspire: use lower case hex addresses in node unit addresses
  ARM: dts: ox820: align interrupt controller node name with dtschema
  ARM: dts: socfpga: align interrupt controller node name with dtschema
  dt-bindings: irqchip: actions,owl-sirq: include generic schema
  dt-bindings: irqchip: fsl: include generic schema
  dt-bindings: irqchip: ingenic: include generic schema
  dt-bindings: irqchip: intel,ixp4xx: include generic schema
  dt-bindings: irqchip: kontron,sl28cpld: include generic schema
  dt-bindings: irqchip: loongson: include generic schema
  dt-bindings: irqchip: microchip,eic: include generic schema
  dt-bindings: irqchip: mrvl,intc: include generic schema
  dt-bindings: irqchip: mstar,mst-intc: include generic schema
  dt-bindings: irqchip: mti,gic: include generic schema
  dt-bindings: irqchip: nuvoton,wpcm450-aic: include generic schema
  dt-bindings: irqchip: realtek,rtl-intc: include generic schema
  dt-bindings: irqchip: renesas: include generic schema
  dt-bindings: irqchip: sifive: include generic schema
  dt-bindings: irqchip: ti: include generic schema

 .../actions,owl-sirq.yaml                     |  5 +-
 .../interrupt-controller/fsl,intmux.yaml      |  5 +-
 .../interrupt-controller/fsl,irqsteer.yaml    |  5 +-
 .../interrupt-controller/ingenic,intc.yaml    |  5 +-
 .../intel,ixp4xx-interrupt.yaml               |  5 +-
 .../kontron,sl28cpld-intc.yaml                |  5 +-
 .../interrupt-controller/loongson,htvec.yaml  |  5 +-
 .../loongson,pch-msi.yaml                     |  5 +-
 .../loongson,pch-pic.yaml                     |  5 +-
 .../interrupt-controller/microchip,eic.yaml   |  5 +-
 .../interrupt-controller/mrvl,intc.yaml       |  3 +-
 .../interrupt-controller/mstar,mst-intc.yaml  |  5 +-
 .../interrupt-controller/mti,gic.yaml         |  5 +-
 .../nuvoton,wpcm450-aic.yaml                  |  7 ++-
 .../realtek,rtl-intc.yaml                     |  5 +-
 .../renesas,intc-irqpin.yaml                  | 28 +++++----
 .../interrupt-controller/renesas,irqc.yaml    |  5 +-
 .../sifive,plic-1.0.0.yaml                    |  5 +-
 .../interrupt-controller/ti,pruss-intc.yaml   |  5 +-
 .../interrupt-controller/ti,sci-inta.yaml     |  1 +
 .../interrupt-controller/ti,sci-intr.yaml     |  3 +-
 arch/arm/boot/dts/nspire-classic.dtsi         | 10 ++--
 arch/arm/boot/dts/nspire-cx.dts               |  4 +-
 arch/arm/boot/dts/nspire.dtsi                 | 60 +++++++++----------
 arch/arm/boot/dts/ox820.dtsi                  |  2 +-
 arch/arm/boot/dts/socfpga.dtsi                |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi        |  2 +-
 27 files changed, 129 insertions(+), 73 deletions(-)

-- 
2.32.0

