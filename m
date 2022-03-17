Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549A4DC539
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiCQL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiCQL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119F1E6EA5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:39 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73B133F7E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518258;
        bh=nSwS54FLcijToE2aK+yEI4OGn17JP6PMWHAMiQXMIj8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PT2jj0e+JyQ2s0l5t7kVIdSaiAvGp0yT9zEI2ItJ0s+/6oy8Z+LjHLztjWreNegxy
         HpzZwHXbIpbOJR/le+lYsdGo196viUTcnpx+TSshZ6iN09M6WQ8uGc0r9Wxxdm0tie
         4UBZ9GQypYBuy2amB6EGSzu5yuQGqlNXpflSygfPozh76ReS9LBjpi+2kob9tzj7/L
         acnZLsh0EVxGFs+d/6j9f/lkraT+kK6cw74+vB3kcSdDoAMLq2kbqK5e5KftdclJdL
         NH8WAQ5r2UR60zERyn2LTkYMWp43V4dKCIbq+5Pc/faaX+SDJq9p52GRKi6XKSysRx
         AySgPxse8EeAw==
Received: by mail-lf1-f72.google.com with SMTP id b7-20020a056512218700b0044869874779so1743321lft.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSwS54FLcijToE2aK+yEI4OGn17JP6PMWHAMiQXMIj8=;
        b=fWo0c9EJdbvQsqzCTWz7daLUWyT8iRdQx/OV7q9uk5QN/d/K9FaY4J91u/ZLkG9nal
         el9dnAnnMQ4IZJlJCd9LhWvVJbr9ZHhtH5O5O42kePu/RbVBcOye8xxj5H38KXgBKuos
         HcbrtfZbusyJxAX5SDLHOIrfSDXomTm4MZnM8HXCqYHtxWh8N8/0+rDdPu/1VAvxwE5C
         6G1QIXWUrw01+hcRWhQ5k6wVEXzkwSHRw2m8jmuwlyYIyfbi3F2ccthUHPc7EHnJ2Jm6
         EqDnHY3IzhnDJ7HkzZ6uUEGyr8zmGK+2ncNBP5F2YVS0pe6lN1gRKnFugSG6FTJdJu7i
         itRw==
X-Gm-Message-State: AOAM530Wpe9QkpsXq+sq8HrC4f+OvSjLgDpJgk1LNnXtgsxelDUGctrR
        3hvxd+vrwNzjGEpKSQV8dNQuHy7bQ3UBMphStYID6RRC1V/Htjqva0f1VAMxh5bMSjlkyGJoZJp
        LMGrWH4gHDkDPm3wEVED10Rl0vlf0QwFZzQkJbPLRgw==
X-Received: by 2002:a05:6000:15c1:b0:1f0:73d6:b716 with SMTP id y1-20020a05600015c100b001f073d6b716mr3661594wry.293.1647518247282;
        Thu, 17 Mar 2022 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG3c2rG8wtLfvYQbJABDH6zuNp51t36w+nKsTHklu2oA2xBjTj2AvcWZKYkNP1t4hn/llH6w==
X-Received: by 2002:a05:6000:15c1:b0:1f0:73d6:b716 with SMTP id y1-20020a05600015c100b001f073d6b716mr3661557wry.293.1647518247090;
        Thu, 17 Mar 2022 04:57:27 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:25 -0700 (PDT)
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
Subject: [PATCH 07/18] dt-bindings: irqchip: intel,ixp4xx: include generic schema
Date:   Thu, 17 Mar 2022 12:56:54 +0100
Message-Id: <20220317115705.450427-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 .../interrupt-controller/intel,ixp4xx-interrupt.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
index 14dced11877b..38290b38e13e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
@@ -21,6 +21,9 @@ description: |
   families were the only ones to reach the developer and consumer
   market.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     items:
@@ -44,7 +47,7 @@ required:
   - interrupt-controller
   - '#interrupt-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

