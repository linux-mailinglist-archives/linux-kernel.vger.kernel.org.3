Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838D4DC541
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiCQL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiCQL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1CDE8F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:51 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7D3B93F20A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518264;
        bh=AiHDlYAYl7vWuI/w9+Je6flygausyauwLZYAswD6HM8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bSuTyic/bDdLAlengR4ZQ2PJFLilDuYVlnV3NWkqQWgxZnyZIKrSLM7KgzjGbg5+s
         DwM6gVBPRw0cHLyjM7TCQQ9j2Apq6owEnAf9EveVIBF3io72X4JvI8n0tHcB7Qv9k7
         LSMX5kiAoaHKY1aHKJE2UECNT8IZ+neQn9pGXZY/TCA5mkzL+/9CGqtk7lkUye5cog
         maSdGWWeJj9QyA+lvVIyjecGfFEO7IMz4yoWfmHHdCgxvugrptZhRJRwd4M3oYH4dl
         B1MIt+Y6IJB9Za69cyrVo23mHcWhxh3ocI9KpLspISBzpMTr4nBhsykT8MYP/zqxjE
         s7HvSBPu5lacg==
Received: by mail-wr1-f69.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so1465851wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiHDlYAYl7vWuI/w9+Je6flygausyauwLZYAswD6HM8=;
        b=3srC4D8OUAr0BUoXcXWV3pX3Xp+5jDu9EbxTv/tApfl/1osRjLFjOdk8w4qm9CIGnv
         NF7AkF7nN7Xq3lXEes4cLJ+Tk/u4xXGQMJc4JtKnOt0N9d5zadmHM+Fngd0vh3NotQGd
         gm7U71oVBrsYDimM/3edfeh8BPZ1qEcUQ+U2jF/NLS8fvNoInBGJ5rUMWny3JH+P6Lft
         ppxbdZCPqjZ7dDERnbA38p0vraQSWL7B9f2bvlGVQOYpEFkGLli7KQ63NeiDzdyuhB65
         SkrdOxWA28uOsttzGk/j7vlT+E1qoXvSpumLMbBbdwupqDCE3ofWhOlTeeYw57qu5AEo
         4TcQ==
X-Gm-Message-State: AOAM532H/zegaqemTik6+KYe0CwKdmm6UDqRyrxrheg7+QLY1WyOP6MT
        2/Npp1q3oja7UlvUq606g9YhXNGLqLV6hFFDhgMemYcBFKy7E0jx7DACgW7WM7f/QlWly0FugeM
        PGzz++unFUR/djCBLxZJcTUAFnqxjxojY4qUO9OJghQ==
X-Received: by 2002:adf:9123:0:b0:1ef:9b6d:60c1 with SMTP id j32-20020adf9123000000b001ef9b6d60c1mr3679206wrj.169.1647518264121;
        Thu, 17 Mar 2022 04:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy83F7kPkAkGVyjO+KTdOeUdR+4CCrIBL1sfHo6WvsJ744fdOezCreCsgf4wqag4r59ItpL0g==
X-Received: by 2002:adf:9123:0:b0:1ef:9b6d:60c1 with SMTP id j32-20020adf9123000000b001ef9b6d60c1mr3679179wrj.169.1647518263842;
        Thu, 17 Mar 2022 04:57:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:43 -0700 (PDT)
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
Subject: [PATCH 13/18] dt-bindings: irqchip: mti,gic: include generic schema
Date:   Thu, 17 Mar 2022 12:57:00 +0100
Message-Id: <20220317115705.450427-12-krzysztof.kozlowski@canonical.com>
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
 .../devicetree/bindings/interrupt-controller/mti,gic.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
index 91bb3c2307a7..d29c2a924acd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mti,gic.yaml
@@ -16,6 +16,9 @@ description: |
   interrupts which can be used as IPIs. The GIC also includes a free-running
   global timer, per-CPU count/compare timers, and a watchdog.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: mti,gic
@@ -95,7 +98,7 @@ properties:
 
     additionalProperties: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible
-- 
2.32.0

