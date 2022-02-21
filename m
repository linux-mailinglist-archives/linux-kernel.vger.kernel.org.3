Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF94BD7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbiBUIXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:23:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbiBUIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:23:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0498305
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:37 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A51CC40041
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645431756;
        bh=fspCJLtE7LEYQw6XkHye8Kq07ah4N6vXGNGBhm+7ar4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=l1CFdi2vGfFWFzZh/vA6J2090OeCzxs6J0i3IpzU4TCuHx2YySZFTSZ+ls7uPPpe/
         b8A9iAJk/tt9x1hamcdImsgGiemFnjX6v1BFnIvEMrv6oHj8JMcjSp4CCZaAX6eY2e
         885DIhczgvviGofWdDNT/v9jw5cK6FNOkECDZXE7Pu7QHV9bzC2C/cyGq9/8cTKnjp
         FEGSRh1NmaSZvgMWyrPZA94+NIYcNLjFiHI5gMx+opos+45JYP2f1GhM1q5keL3E9C
         dW4+318EGfBRqiG8UpKWq+6iD0SupJx3bwl5YpTg8GDZKY4pz50W6p7hTsX/rWM8Sz
         zXLBN3jELOMRQ==
Received: by mail-wm1-f70.google.com with SMTP id ay41-20020a05600c1e2900b0037c5168b3c4so7713345wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fspCJLtE7LEYQw6XkHye8Kq07ah4N6vXGNGBhm+7ar4=;
        b=v+EYb3HFT6suI0zNlnUdnc40Jwn5dE/UvRaGUfeOhfXtoT0i/tZc9o5c0nkclER3hm
         94GZr4fP4GZVBPpffF8N7uN08Be9F+mB3gKRqOgP60tb4/RimWJSJwvjfWn+TB5yrV7h
         ooRerBTRdzRaLkfA7duCKUeFjV6QATdaKC0Pr1lMHXi0n7hW2/RBKDKAbokZmH4LUDAF
         dQidh8j1LIpSlYojekpI4E3gB27eJ878OC1iu/HAbhldohUrV1z0AV02g9pUGhDRUWPt
         9ab5Z8lOXAAb7s2O1/oVOba6s5m1LIri0BtobEIjvvmu673pe8TbS1VGM432ojXYlukV
         14QA==
X-Gm-Message-State: AOAM532bX5RkLago6LCSncTTEJactw5OXwCEiOT4hMWfZgdZUe7M06lP
        qaVAuy6A2qb7e4FEOiOKZagL0SIjgux0wGGQH0cFjGg7lvFo6DDKSXxCEI6CGPcykhWMkox12HI
        6SkRxMqi3k6WiHoZVVgf1QAW3cAt/+S4ADpfzUSmGaQ==
X-Received: by 2002:a5d:452e:0:b0:1e2:e3df:5933 with SMTP id j14-20020a5d452e000000b001e2e3df5933mr15938214wra.158.1645431755557;
        Mon, 21 Feb 2022 00:22:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz77IEo/QTGJFbeIF9OrxTWGYJqcHKNN51p3fYxQmGEuSBNmMUKYmATuYBwKgois8ytkRw3rA==
X-Received: by 2002:a5d:452e:0:b0:1e2:e3df:5933 with SMTP id j14-20020a5d452e000000b001e2e3df5933mr15938201wra.158.1645431755417;
        Mon, 21 Feb 2022 00:22:35 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm6727615wmi.7.2022.02.21.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:22:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: usb: do not use deprecated synopsys prefix
Date:   Mon, 21 Feb 2022 09:22:28 +0100
Message-Id: <20220221082228.34407-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "synopsys" prefix and "synopsys,dwc3" compatible are deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/usb/dwc3-cavium.txt       | 2 +-
 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-cavium.txt b/Documentation/devicetree/bindings/usb/dwc3-cavium.txt
index 710b782ccf65..171df79360ff 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-cavium.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-cavium.txt
@@ -20,7 +20,7 @@ Example device node:
 			    refclk-type-hs = "dlmc_ref_clk0";
 			    power = <0x00000002 0x00000002 0x00000001>;
 			    xhci@1690000000000 {
-				    compatible = "cavium,octeon-7130-xhci", "synopsys,dwc3";
+				    compatible = "cavium,octeon-7130-xhci", "snps,dwc3";
 				    reg = <0x00016900 0x00000000 0x00000010 0x00000000>;
 				    interrupt-parent = <0x00000010>;
 				    interrupts = <0x00000009 0x00000004>;
diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
index f6e91a5fd8fe..b1f65a656528 100644
--- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
@@ -92,7 +92,7 @@ examples:
       ranges;
 
       usb@2690000 {
-        compatible = "synopsys,dwc3";
+        compatible = "snps,dwc3";
         reg = <0x2690000 0x70000>;
         interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
         usb-phy = <&usb_phy>, <&usb_phy>;
-- 
2.32.0

