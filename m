Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB284DC522
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiCQL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiCQL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308B1E6E9A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:21 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F2863F366
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518239;
        bh=aSGezm1yIxV4XCs71xtI5EKoFHjXL820ywE13DRNOT4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kP40/AcRzh78psvl69t+INXZAatYaeYLa92P2c4coCB0MaLQgxtCbYBDxRHgmsOea
         fiiMC4i5Tdk+fpNuXStJq5a03J9kQRP6c/fySZ4pFHE9B/6ZLeSAdqpUI/jnjvKTdw
         E3k9T+RbtkWWsRiwmhKvsVID7EzQZM6h3tber2yZwUs7pMjx6zgJ5OP19hZjzh27dy
         uVqL5gSyNcCCy5LsuqSjz8YBM80C8JExhGhtk2uCVxwfJSdwyzM+qETH0011J9wkKS
         VN0N23HfDCvhGUj39PEPOZ/5LjM/wtCQUNf2P+W426aOStiMggTXl/QrFok5Ladgy+
         wi8g55bblvcIw==
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c22da00b00388307f3503so2031520wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSGezm1yIxV4XCs71xtI5EKoFHjXL820ywE13DRNOT4=;
        b=yIXPCEMZuWLIwwOiKf3fmYhPDSrcuXpbcOwkWdUr8QYM9TShwsrrRJ33kBE+FEGg5X
         Qvg2cQoDfT7zaVMfUS9eiweDB6kDgnnIoFXNNnREA04VsPUj0cYV+PQyvyQGY925CCAb
         aTdMnAt7e+P/0H4eut8zMjZig1Q93zDjidfcaH06CSiD6FrCACulhW6niQnHjEWlYOfn
         ZgakRYQY/oVqeei/eQ8bRVQbrMrGe4WNm8mLPSSkfRNjQ/RAhL95hxQyyNApdmP3p22c
         vFQIuSUJLlxKK5dR9XwUB+/Q6I13238FJDyAWCfBqFmu6+YqAPfIJmVPDb902OkHhEax
         v12g==
X-Gm-Message-State: AOAM533bzYe3qm7sWvjpNRLRDN+TrUPrv/LsktQLOgKyiTT66kEHmwx2
        QXh/4t4WgGY7jt/7po3nePKG7Cb+sOeI+v+R6iIO/3X0yIQDEC03yJK3rW5FG6BqY4BU5C0RCcw
        hEGF2fagfhhYUCVfpSwxLLKn8cVyu4mmUazyWIEzTYw==
X-Received: by 2002:adf:a302:0:b0:1ed:bf30:40e3 with SMTP id c2-20020adfa302000000b001edbf3040e3mr3777928wrb.270.1647518238530;
        Thu, 17 Mar 2022 04:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2T8BZ9r1cayLerGnUvxU9+ZIYyhi9vmiexAY/nI3LK3OqgvQvruoxbLO/RKMhjARnY2yv2A==
X-Received: by 2002:adf:a302:0:b0:1ed:bf30:40e3 with SMTP id c2-20020adfa302000000b001edbf3040e3mr3777906wrb.270.1647518238317;
        Thu, 17 Mar 2022 04:57:18 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:17 -0700 (PDT)
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
Subject: [PATCH 04/18] dt-bindings: irqchip: actions,owl-sirq: include generic schema
Date:   Thu, 17 Mar 2022 12:56:51 +0100
Message-Id: <20220317115705.450427-3-krzysztof.kozlowski@canonical.com>
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

Include generic interrupt-controller.yaml schema, which enforces node
naming and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/actions,owl-sirq.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
index 5da333c644c9..c058810cf475 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -14,6 +14,9 @@ description: |
   This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
   and S900) and provides support for handling up to 3 external interrupt lines.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     enum:
@@ -46,7 +49,7 @@ required:
   - '#interrupt-cells'
   - 'interrupts'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

