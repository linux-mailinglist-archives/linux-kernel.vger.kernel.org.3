Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A774653C5A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbiFCHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbiFCHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:01:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FBD38D8D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:59:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t13so7524020ljd.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+1GcNao+MpcpUVYncd1ScTVUmB5P8PxXyVNWxX2GeI=;
        b=hXxiVy1rMerVPYFxAvTrykMJn8GqMTIJNFtHoByV5ZBEWKRtM39ia9F2+cH8fgXEIr
         iP7gJYpSd/3qtmlrWywrzA6HIomjjBXUGwI/GgpjN2KffBFs6XIUujHTMsRypkcaxU5i
         OlXkg1AnmArJyAm26K/MQGFTK/Ulg0HeFb9rYrJ+4pzNX1dPF4EtcRQUeisB4fQddQop
         9D0qUbeL/Crer8BcYc68rYX7iWR1rtc3CnHJaI9p3tEVnFA/s7gFYG5A3w4vtGFTob50
         6YN1DVfe5YWhCMk7HPYNWbrdkzdMxOLOQ+h53dCW20Yp+ZBn959P9B3vsF3Cmzw7ak+n
         vkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+1GcNao+MpcpUVYncd1ScTVUmB5P8PxXyVNWxX2GeI=;
        b=QrE1mzYWzYguZq7EHjG30EVkI6WzC0z429AVVIE8kluN6l/TC53FevhjarQUGQpqb5
         s5180+hj/YgqgtjTK3zTXMiL+Bff6INMQXuVmOyMLoRs6Ts1mN4A9IvWNJPkpAcqw+vk
         M3czL0IRnRz3m3/p3z7HF/2udL/VeAKqzfxg1ET9dWEnDPDScRRcncKjq41qTak7a12j
         3knI+KQi6rH42785FVGW+w32LYstNgVCSw1yIwQQkJ/aZ7LzfOXcTy1w09NbSP2Vlb/Q
         IuD6tCVz2Ref+Cf6D3vWJF6Ehkb2Pin4vfT3KJSs972+uHrIXrqw/dPvomD2v90xGdpL
         NgbA==
X-Gm-Message-State: AOAM530xM+PRPBav7ZDiJAmYFh6dT1nHMqKHBxYSroI/29jKVhwutcKe
        BfZh8FPYfyXAe9QJwOFaN/eEBQ==
X-Google-Smtp-Source: ABdhPJxHYTA/EEeEDJiAAhWlWqMNTPnVXX/fz/LXtjkkK3yxKHbGCiRqOCNrUak3T/G6aOkRiV4erA==
X-Received: by 2002:a2e:b601:0:b0:255:6786:bbc0 with SMTP id r1-20020a2eb601000000b002556786bbc0mr8202055ljn.27.1654239565917;
        Thu, 02 Jun 2022 23:59:25 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id b8-20020ac247e8000000b004786321c697sm1056447lfp.138.2022.06.02.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:59:25 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v3 2/5] ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
Date:   Fri,  3 Jun 2022 08:58:13 +0200
Message-Id: <20220603065816.87952-3-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603065816.87952-1-pan@semihalf.com>
References: <20220603065816.87952-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ecc manager is a part of the Arria 10 SoC, move it to the correct
dts.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 10 ++++++++++
 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi | 12 ------------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 26bda2557fe8..4370e3cbbb4b 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -736,6 +736,16 @@ emac0-tx-ecc@ff8c0c00 {
 					     <37 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			sdmmca-ecc@ff8c2c00 {
+				compatible = "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c2c00 0x400>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					     <47 IRQ_TYPE_LEVEL_HIGH>,
+					     <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <48 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			dma-ecc@ff8c8000 {
 				compatible = "altr,socfpga-dma-ecc";
 				reg = <0xff8c8000 0x400>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
index 4b21351f2694..b0d20101cd00 100644
--- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -23,18 +23,6 @@ chosen {
 	};
 };
 
-&eccmgr {
-	sdmmca-ecc@ff8c2c00 {
-		compatible = "altr,socfpga-sdmmc-ecc";
-		reg = <0xff8c2c00 0x400>;
-		altr,ecc-parent = <&mmc>;
-		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
-			     <47 IRQ_TYPE_LEVEL_HIGH>,
-			     <16 IRQ_TYPE_LEVEL_HIGH>,
-			     <48 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
-
 &gmac0 {
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-- 
2.36.1.255.ge46751e96f-goog

