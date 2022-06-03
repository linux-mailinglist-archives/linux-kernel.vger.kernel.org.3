Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599A53C772
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiFCJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiFCJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:24:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8A3A1AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:24:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a17so4743256lfs.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vN5ummJ5DHnrQ19PgCDPVwMCMWaLv3bV/1IbJgpKEo=;
        b=SWgorJeIrMvP4DjBnRD29As0Pq90LZGB6ryA/CRuU7w74nHAx1YzOyFAXxfHh4+Mvf
         xJul1+0qapgXKvnAMNsmofczndIcUurCOaKSezqCcHMm78Ld3hJv0E0X7NTA1dbladhF
         tzQtlWVEcUwCt1YdqRIwEBDbRsxg/h8fQVyEaMDibtBG7AfbMJc7l7jtVkqjxzx7J/Tc
         HekbqMFPKppWAYN3gmYc4iJCMbzPb7va0zw74idymZgT7JMtYbiyKlZwU6/zvA1wvmmi
         urhpBYD3ZwcXUcrJgUDzpJQS0q+TvlqP7I7Yu0tEKtDxnyaZTPA+2/RZfbiP4B+qNHJD
         APhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vN5ummJ5DHnrQ19PgCDPVwMCMWaLv3bV/1IbJgpKEo=;
        b=ORJLCm/c4TF+uYiLQHIrjbHElfqNivArm6/5wTdIupbaPmpahHfFxHmI10CIryf2c8
         Z3g6H+ZZwYLEy2lCAgFQ+1TB6sQ15fOXgnZaUaYp+RSZ0pWPcwpPODkKNI80wsNfkzSe
         e+GenwSJFoOHqhQFcfSH5sMGBg92X4xFXXxndvi06HLw9DuQnh72brd+O37lvVdIIq+o
         qRCRpN3g/N2NA5BvpcZNY/bUBmax1ym49MpQQAFiVS1JUC+ji6pNyF3AvNscpfuIp/nE
         yTScFqfsRgnWvxSY6E3PBbtxTJl4baKO6HfR8Es/HFJcneIy5jN2hFMH4zvr4/fkwnrv
         82sg==
X-Gm-Message-State: AOAM530KgdsAO5O3ZihNvPiRF3RAOSisBkPxSaRAe63m9KjCTS+QZKNh
        I/66xbkKY3GqgOzZ6J/qNYrmtg==
X-Google-Smtp-Source: ABdhPJwlZQ5PhtQYS7Y9s8wAkHj+MgMIqfgEFJau8eylrLAu2qV3BjhVqL0SIqO/e4PFIKQ7JmJaCw==
X-Received: by 2002:ac2:4c13:0:b0:478:f826:26fb with SMTP id t19-20020ac24c13000000b00478f82626fbmr11845167lfq.529.1654248270361;
        Fri, 03 Jun 2022 02:24:30 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id e10-20020a2e9e0a000000b002555dd9c20fsm1224434ljk.20.2022.06.03.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:24:30 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/5] ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
Date:   Fri,  3 Jun 2022 11:23:51 +0200
Message-Id: <20220603092354.141927-3-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603092354.141927-1-pan@semihalf.com>
References: <20220603092354.141927-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ecc manager is a part of the Arria 10 SoC, move it to the correct
dts.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

