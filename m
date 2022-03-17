Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0D4DC533
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiCQL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiCQL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA71E8CC1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:50 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A0CA3FDC7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518267;
        bh=9NVaJhFyk/7XIToYVXJ7m5aI93pLstb15hWUEyZBYi8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DcpbK+tUABWB6T4PB1jKjHfXpt+IIdj02N/ZNcslK08QR0g4jNMZsGOhVa9JrW25w
         TtKxSLVkW6oMcIkKB7V8WwurQmobjwiIp7AH3RxOYYPomOIEuyhtIuSBTeXnT6EABt
         MbMTuCFqXe9fgaRHYVyzbVHZsG+2IPTdC84PTEKRPvPYsZ/UDdOZ1TQn7sg8qnS1Nd
         79S06hSXWkqvyTpgJCQRKqU9ZqEFiNcMaxPj4wGxnRiisFtRqf80YxjHv3AJNQzVBA
         9WsTl6xPtnOgBhCDs8NXwVErjfK9RINSjvSGsrSG9AeXGxwyejS8ghYtkoM7GMy3CL
         2disZ1xINbWOQ==
Received: by mail-wr1-f69.google.com with SMTP id 15-20020adf808f000000b00203e488fa4eso992911wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NVaJhFyk/7XIToYVXJ7m5aI93pLstb15hWUEyZBYi8=;
        b=iFERo57SaX5bxpOMN1adxqXdWrWCL3sH6xGJHkmWp5Z8ndanp0Iz51geOOPaCLXXQ+
         IcXalDWZ/Qq5Owh0ikfc2zyMLseh9hudQUNn9Qj72W5480TNaD24oqm+8gKqgAccpZGG
         E5uLzQ/OoWPgKYR+JT27/9MbyVqyr4VKa3daD+NxvLAJn/3Hp5hsvsUdskqa5PkFsmHI
         9j4K4Y3OSC8UNiZJvItqE5bqr2LQbJhzwHb33qOzUbjoo0Pc0kqdqeoSFHIdJ/jISN0X
         k3XUlQGu16Rabqd7RSBVlirx9gng7myUZRU9x7It3hhqwM7s0qAGxhNB2/YJRAgPI12r
         MLtA==
X-Gm-Message-State: AOAM533n+gbH3v+bvlWlhFI2Ckn5GC/bzO/I8IJyH5+UcKqSzqwS7ppD
        BBOVlccTzl0CKcrZcxAvmWKLKMsKKvC3kPXu+uXkOIuJLhxI9h8MojcjlMN2kGpJoHNlh1xpuD1
        UjIv1dbb1l3fBH+rZoe7NRsJj2lofNHEbdoTnWoT1mw==
X-Received: by 2002:a05:6000:156f:b0:1f1:f99e:779e with SMTP id 15-20020a056000156f00b001f1f99e779emr3699051wrz.99.1647518266483;
        Thu, 17 Mar 2022 04:57:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymVAcTeO15IweAkScwvNQ6HG8sMEO3vGt45XqrwFfDK9yidy0suv6zYu7bE0rR0hIs55pTgQ==
X-Received: by 2002:a05:6000:156f:b0:1f1:f99e:779e with SMTP id 15-20020a056000156f00b001f1f99e779emr3699013wrz.99.1647518266228;
        Thu, 17 Mar 2022 04:57:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:45 -0700 (PDT)
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
Subject: [PATCH 14/18] dt-bindings: irqchip: nuvoton,wpcm450-aic: include generic schema
Date:   Thu, 17 Mar 2022 12:57:01 +0100
Message-Id: <20220317115705.450427-13-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Include generic interrupt-controller.yaml schema, which enforces node
naming and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml
index 9ce6804bdb99..285c20de0962 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml
@@ -9,6 +9,9 @@ title: Nuvoton WPCM450 Advanced Interrupt Controller bindings
 maintainers:
   - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   '#interrupt-cells':
     const: 2
@@ -21,14 +24,14 @@ properties:
   reg:
     maxItems: 1
 
-additionalProperties: false
-
 required:
   - '#interrupt-cells'
   - compatible
   - reg
   - interrupt-controller
 
+unevaluatedProperties: false
+
 examples:
   - |
     aic: interrupt-controller@b8002000 {
-- 
2.32.0

