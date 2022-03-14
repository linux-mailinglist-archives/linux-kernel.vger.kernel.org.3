Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C44D8BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbiCNSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbiCNSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:21:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2435241
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:20:15 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A96E405CA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647282010;
        bh=U8OU69oA8CY5cA8ZS5yQs0dGgRqDiUpqozJ7NxlASIk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=b2NvLmlZ0LfX8sNcJUapJJWj1z7h6pw3iLWcqKk7ARfy4/ZovpR79m4prxfvvyB77
         HlM7o5Vo4EcvfSBL7dIwEl58fXMAGoo68VejJGUmv0gQbbwhJxOvqhPYFKk4SKtGPW
         JEEWZvf+ten4Ns6uTbK9+mdx10bUsmAMU5wQP42UWhswuE8OsUXoxpyIQTQuRlhhC+
         zqXIEYZ/bXIpykw4WgOP+xryIaadwFvrxNDSNbxaGdvItlnuzCaOO/QTtN/qowOU03
         cJwnkF5YQN7tu8sD1oos21C5bil6IQsyZycp/Ys+aIh0btBBnfEfjnbq0BeERYfRKw
         iQlsOQ6qW1ewA==
Received: by mail-ed1-f70.google.com with SMTP id n11-20020a50cc4b000000b00415e939bf9eso9219877edi.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U8OU69oA8CY5cA8ZS5yQs0dGgRqDiUpqozJ7NxlASIk=;
        b=N1Gx+ZhEbP4MFiK1PJ5YbhTp4cRNmT1lSy6ty37hnNqb9LPO95SLIPW/yNhyf5djF/
         B+8bva/24tt0CSuSpf3/nLINJrAiw8XhCyohNuwLosQdazH8bGWZBP33ua1XDPLZLNg4
         Erdb7fQqGBsGEQ3JbvMBQFaiAHLH6MEHWU//ic4Idhz/bgD8cblbo/WUUYwP+vSyrdNm
         Nc74uk8JRySygvwaQYzjyURlAEwYLJiYZUJlXpPDhYfDgTJppWd6/nO8ufPSnLiakcLw
         6d6Xb1dR1QeKqVulf5ZPvDwXuD5gfXjDjj19Uj9Wf2QLVCLDV3fx0q8+jVOEE1dw6rUm
         jWBQ==
X-Gm-Message-State: AOAM531QqbYjyEDnXQN9HooSgbBe0V1Fxw9ytDWLK8zBsxre0hgm1ryz
        Fa6wmOTd/b/zq8EDOHcQYBsAqGAPJhEI5MP+iGaxw1IPqqEABdd27BtqnWhFdgG5AHaX7GVNzNY
        O9PcbjBCqt8hm3Vq2Otoj66JTqCyuzgRF2LqYDrZ1HA==
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id q7-20020a1709064cc700b006d07efb049fmr19162180ejt.639.1647282009783;
        Mon, 14 Mar 2022 11:20:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykfuiix6CGfcuVN3LbtcoNjfp49yxsV/G1SXPbVJxr5AUlGKmZWMubD6N2B5kngeBfouUT/A==
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id q7-20020a1709064cc700b006d07efb049fmr19162170ejt.639.1647282009622;
        Mon, 14 Mar 2022 11:20:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id i25-20020a50fd19000000b0041614eca4d1sm8566449eds.12.2022.03.14.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:20:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/5] ARM: dts: exynos: align EHCI/OHCI nodes with dtschema on Exynos4
Date:   Mon, 14 Mar 2022 19:19:44 +0100
Message-Id: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
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

The node names should be generic and USB DT schema expects "usb" names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e81b3ee4e0f7..5fd17bc52321 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -373,7 +373,7 @@ hsotg: hsotg@12480000 {
 			status = "disabled";
 		};
 
-		ehci: ehci@12580000 {
+		ehci: usb@12580000 {
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12580000 0x100>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
@@ -384,7 +384,7 @@ ehci: ehci@12580000 {
 			phy-names = "host", "hsic0", "hsic1";
 		};
 
-		ohci: ohci@12590000 {
+		ohci: usb@12590000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12590000 0x100>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.32.0

