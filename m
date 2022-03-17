Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313C4DC534
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiCQL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiCQL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69561700A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:10 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BAFBD3FFD8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518286;
        bh=KFmifwXJp5W4UT7dzRYgwV6FTL9sctX1thCEx5C+nkM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dy1BtMr9FpqWvrJ0af4Qg0knda8iYlCDRQs5YR+RK0uU/6Gl3ETXxa+EMRlguytC3
         coW4tQaBIjMcmjPofSz2rM9FQtqSSkv1h4ov77iFfUmaQ5BfMo+X7fFTOyT/XELcIL
         6Z3yXFbUIOnDe0B4X3FNL4sbjbp58SXP4ao5S+JW2F8XaDQ7OHz9F2+tEid8j6lAyD
         rHYqniMjDtJNvVcPEViIPgRlkcIE6Psr+/9+8H8TxzO2LoeCwOJLGC4344EuMmMNMi
         ODAdEhEfjoHG60SiNTOXHq6SjJtHPakhKttfrGuey+aK80S33pF867kWUyvPF3DpVX
         75pEMEtdMbuXg==
Received: by mail-ej1-f72.google.com with SMTP id hy26-20020a1709068a7a00b006dfa034862cso550883ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFmifwXJp5W4UT7dzRYgwV6FTL9sctX1thCEx5C+nkM=;
        b=2cwu9pBekbUzqXiSxgelGXcxLGcjWfhJDvB1+AQmhqCVLZsRCyWkAf93T/UbzU8G+M
         LkXmhkJaLqkcMt1v6n3CesrGo9k4ZbfW1WNldp08PLLsLFsS1o4Y34Q/1N3ZeUaDaHoQ
         bKu4NVqybGa0TX8DRI5mJJMYY9NJ/SxfcqMNIoOHh8vGSfFSb+VPt/HyIt8yrd5qXPwe
         8MfChyiAof4ZtybXedazGRKsO+GJneCB3ju77wZgTxISEdznp3ckoBO6XSzZ0XqFZ4Fk
         8MUmR4rSNIlxUC03m4ZVKJdHcLDX4FnmukXkCfgqpOIbXu3dn6qishdP3ff356fFcNHe
         rDlQ==
X-Gm-Message-State: AOAM530ETPQ3Ggh3yL65V8vKsZahFGpHnIN4sWSKHKuOD6dil9xOcGRw
        GMsghJrQXffRQcw+2FY4whdkKQSbRWiRJrTTQKXH2Tf7ySyijKuf05bGfbuw58Z54lDJvVqZ/HQ
        ZZGce/Xv9G8i/uAQmPgKNOSchfpexqlDPG1sKYHv+bA==
X-Received: by 2002:a05:6000:15c1:b0:1f0:73d6:b716 with SMTP id y1-20020a05600015c100b001f073d6b716mr3663317wry.293.1647518274495;
        Thu, 17 Mar 2022 04:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQvKKHcnhZqthCpzLO2USNLVXIsLYfJdNKGccVKarN3fEhfI5+MqhVsRHbxfF78ndbEuW0XA==
X-Received: by 2002:a05:6000:15c1:b0:1f0:73d6:b716 with SMTP id y1-20020a05600015c100b001f073d6b716mr3663274wry.293.1647518274258;
        Thu, 17 Mar 2022 04:57:54 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:53 -0700 (PDT)
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
Subject: [PATCH 17/18] dt-bindings: irqchip: sifive: include generic schema
Date:   Thu, 17 Mar 2022 12:57:04 +0100
Message-Id: <20220317115705.450427-16-krzysztof.kozlowski@canonical.com>
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
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6a86c4..e3c08cff89d2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -44,6 +44,9 @@ maintainers:
   - Paul Walmsley  <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@dabbelt.com>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -91,7 +94,7 @@ required:
   - interrupts-extended
   - riscv,ndev
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

