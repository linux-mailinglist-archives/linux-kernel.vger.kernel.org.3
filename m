Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC24DC546
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiCQL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiCQL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9F1700BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:02 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4AF4C3F625
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518281;
        bh=nw83rNQU0DG2T5abexM+HrA3AT5FpHyglSBWAvBerB4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kQ2mLTAXFpuho4SExyqLuVNWBR6HKM2OQyzLi8AN3pXhVYdQAMb97fXIvg9FmR+zT
         26bpUNONzM+rI016Xal/E519i0ZboEJQik7j8LgoXcLuWNS5f6KnM7vFv6uPmgMGlI
         mg+5XGBrTtC453y1tbJ9OddeqzIW7rJBW6wgIo8QBp1XjnRDWLYaDnbGcmcRpSCO3t
         VYhp+rHUjWzRgtz59X1i4cBHuDOIanPOzKXFxZyMqc5BxbHD18LVoqC+1JduxWv2hr
         8s7NcoDjzh90JG/ZJLd57y151KQowWdzoAQg7msclm3OkJ2y4WgMwewzul6rYI0Tpa
         b1lDv0B/41dQg==
Received: by mail-lj1-f197.google.com with SMTP id v9-20020a2e9909000000b00247ecf60956so1986897lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw83rNQU0DG2T5abexM+HrA3AT5FpHyglSBWAvBerB4=;
        b=JXPxQ93UFj31UPNMp61qMyJxuqCJ6RM2HTvoePVm4WncZuO0gMVSsAY2ug7Lf2muxH
         1epx1WuqMW1CcMP8xUyvUpAelPXST+MJZm94JUkKmwvO5Cypqt+7JQ8Z3yWhypn4fVd2
         L+S61GHKh6bAeOuYH6+TFRVl0vEC1ZcQ+qAkqs0rlusJYl/RgbGGIQ9isaqxNdjbJv8f
         hl09R3CK3NRjOsHTdJJ4LDT6MJeegqDzAf4pf7QC+LxkMpynPAc0ClP6q2bghFrAwRpY
         NQjpMSSrT3Z2F1WTp/CAFSAYgRaLkQq0V4a4wuTPZ5TObs6AZihkIvesix9h2rW3Ncrl
         +nDA==
X-Gm-Message-State: AOAM533aQ9MgwrypiGz2u+Jp1okcrWgtDj6GRTeqrWU2neiZRNj2UX43
        h0H9CV9yCRmPFUhGnws0AoW4gI3Aw8ldbjnZtDx5wax1LrqsKXHRwHYXZ5lFCqAotftngIcEApI
        CTBRJPl7XB8AzFHRiDOmPxcQY9qJfnJasGJKXcrAfiA==
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id g5-20020adfd1e5000000b00203d60938damr3610511wrd.675.1647518269088;
        Thu, 17 Mar 2022 04:57:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjFXvDvHdQ01w0zg1EFDDh642eLMUzgHUDqkxXLdtcKH+7Ko3TzWiEFBj3msxkYp0Y5lUMFA==
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id g5-20020adfd1e5000000b00203d60938damr3610457wrd.675.1647518268881;
        Thu, 17 Mar 2022 04:57:48 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:47 -0700 (PDT)
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
Subject: [PATCH 15/18] dt-bindings: irqchip: realtek,rtl-intc: include generic schema
Date:   Thu, 17 Mar 2022 12:57:02 +0100
Message-Id: <20220317115705.450427-14-krzysztof.kozlowski@canonical.com>
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
 .../bindings/interrupt-controller/realtek,rtl-intc.yaml      | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff20323..4c00d44923b9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -11,6 +11,9 @@ maintainers:
   - Bert Vermeulen <bert@biot.com>
   - John Crispin <john@phrozen.org>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: realtek,rtl-intc
@@ -40,7 +43,7 @@ required:
   - "#address-cells"
   - interrupt-map
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

