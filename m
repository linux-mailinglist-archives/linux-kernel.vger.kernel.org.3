Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E64DC53F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiCQL7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiCQL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB21E6EB9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:43 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AADF43F62D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518261;
        bh=upn41SGXInxzeh9yeucVbbgZI6J+Vh9tnHYXNDkdf7c=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p+8Dc1rpO9FCnvY6LeyXs4OVrkK1sKvpGN4yio0A70e1WyHy3UQOQFwRHoHyn1l3R
         jmgrPlu+igCmo4AQn5DGTplfJkaLD9PVt8LnQ7ohTOjzvrIY2yCTkwQJaOoU8NSJ3f
         wblyz7UQc+oUasp8EOCBrt0YldGDnVdXNgAtH9HUmHFWb7GaHU9IS2+YVBd1Oyr9j8
         YeW4nF9jQ9HM9+PxdplcsHldlpaBhifxy4br/OoefhU0xlubNZzsqVyhLbLZUNmxMn
         +ZipI3Z0kNCwtNP7EU7JBERskgJxu/K2YJov2mAOgm9Wz+r7hbVEdNV3fH0LQ6fEXW
         j791RHUl/C89Q==
Received: by mail-wr1-f69.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so1462404wrh.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upn41SGXInxzeh9yeucVbbgZI6J+Vh9tnHYXNDkdf7c=;
        b=onXneXqV5uxJvecQ/A3V4PPYT9Ra6p1DnDsltzciBY4+nkWRTB4owwgmd8jWCvEhhk
         WKKWo2/eTpX78GI9sSgb7t3jXM49U8QFIQ45306mHAETECgy1lvYd6efhfEqQCYAlKS/
         AjOwB+YzWSCvsSWV9va7aldaLZvB3pXBHjCMPN0RgKY6MiWcTdLTXTZ0+L3T6vS+EPaP
         UEHbYv62qINJfKOE9nUzIbdxactbmwkKCbgv/lPq77TXXdz8zO5P4ePqHiKBKNT4QCAB
         HX8b0G4VJYNcu1nxLlb0N2VrmsC7NiW7imGBP5Tt/Kfuu47wIIW4q55+TGCczJKxG3AJ
         xfYQ==
X-Gm-Message-State: AOAM533V0wmHYV2M5UKab7vTuDB/Bxpcjf4FE1txAG/e4K1aJn+cgkJ3
        bOebRttr7UipE2cjQBf0uOjtDmjjgUyQTceNw7x+lBJLDsw/lDJIo4md0VzBlwUlZINDMPbiBJ9
        O1/XLVN6GEG+tK8vQ/h1GVwH8Y8452yNrcNTdQuSrGg==
X-Received: by 2002:a05:600c:4e12:b0:38b:b715:18a6 with SMTP id b18-20020a05600c4e1200b0038bb71518a6mr3598871wmq.17.1647518261206;
        Thu, 17 Mar 2022 04:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaJnwGCDWCgNxVBPz8602WsRzPCQWkTc7stpH5PT+AGMHTpue3CNd76a9vbasK9iibDzPBWw==
X-Received: by 2002:a05:600c:4e12:b0:38b:b715:18a6 with SMTP id b18-20020a05600c4e1200b0038bb71518a6mr3598815wmq.17.1647518260943;
        Thu, 17 Mar 2022 04:57:40 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:40 -0700 (PDT)
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
Subject: [PATCH 12/18] dt-bindings: irqchip: mstar,mst-intc: include generic schema
Date:   Thu, 17 Mar 2022 12:56:59 +0100
Message-Id: <20220317115705.450427-11-krzysztof.kozlowski@canonical.com>
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
 .../bindings/interrupt-controller/mstar,mst-intc.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
index bbf0f26cd008..7cae52490ff5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
@@ -16,6 +16,9 @@ description: |+
   The HW block exposes a number of interrupt controllers, each
   can support up to 64 interrupts.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: mstar,mst-intc
@@ -49,7 +52,7 @@ required:
   - reg
   - mstar,irqs-map-range
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

