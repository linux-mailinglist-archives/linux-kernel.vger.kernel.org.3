Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185BC54F75A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382003AbiFQMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380126AbiFQMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:17:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5633AA5F;
        Fri, 17 Jun 2022 05:17:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eo8so5995093edb.0;
        Fri, 17 Jun 2022 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCthpcEAF3mRrnq/JjWJ+hCkQXEbYPikiDTi9Vf1eLU=;
        b=ANDlcQsHwB1617Y00BnwnZiE+R+jmlAq7Jc6RnyHnNOw0XBM0k4kIZbxnNZmx4Bkxh
         1DYEr455RL/ch2YnZzrppY3ueoEKjhJFlIR7g2tnteS5KCczArWn1XSuXL1CdtXWmuov
         bCl8iloUjuz9HQr97kJ39UCVh7Hv2IfsV3fQH7yujlXo3dn3Gx8gmdfUdrN1zFl8GUYh
         jO62gIq6A/0USlazcyqVkTp/HbXc+IhcXt2yozxyD5L8I2Xed01B+5vxqShT/bU0wUtt
         9ZxjFAJZ77ShoWRlva9dcGqkKSzsFqfJHC/vDVp0qs1OqFhBksth3S4UVM97Ic+wdwxu
         h/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCthpcEAF3mRrnq/JjWJ+hCkQXEbYPikiDTi9Vf1eLU=;
        b=haXq5cs2+354kCsozzvIJZ9nzfvYXrPrOWDLIv/X4A17+xVzZU1bEnSMKg6VbdyTfQ
         j5PA3PBsvhnHtzFB572mt2K43gUSr3JViUPhiV67IazIcvAuCS5xwzpwW60kHJod7MxN
         VC+o0GWXg5UWmNSXqru/HvnLSzuzz4jKjJCelHqIMLnPaCMKe4UHSn3uL1Uw485b8Xd4
         FfgRu/yvccjSxA1h+ZWvbg2V7yJHdgty48+xSbMzQMBbnNnJnKptJlvOqaEyTFlfn239
         W9CRtyeJT1pTiRG1XmXpLxiPNtPTGL48lH3yVQ/kHUUsnP/TouyiSP3jl7dvHPtzngZJ
         IbJQ==
X-Gm-Message-State: AJIora8coHZo8sAe625WyJ2g6V1Y0ClYR3U2HtApQBuAloWMUfaSy1Kq
        n2oIQMt0CUHVdW983GSnikf2DbwSYyyWOw==
X-Google-Smtp-Source: AGRyM1vzDDRkFbZxlt7z0Ka1jOJZZhUGEMnWOK5rQScjIXnXd9D9PwEvTowb/zLA4Bc50S75xem3gw==
X-Received: by 2002:a05:6402:5388:b0:435:71b:5d44 with SMTP id ew8-20020a056402538800b00435071b5d44mr11976515edb.364.1655468227889;
        Fri, 17 Jun 2022 05:17:07 -0700 (PDT)
Received: from localhost (92.40.168.190.threembb.co.uk. [92.40.168.190])
        by smtp.gmail.com with ESMTPSA id qf6-20020a1709077f0600b006fec4ee28d0sm2094853ejc.189.2022.06.17.05.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:17:07 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
Date:   Fri, 17 Jun 2022 13:18:05 +0100
Message-Id: <20220617121805.738157-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220617121805.738157-1-aidanmacdonald.0x0@gmail.com>
References: <20220617121805.738157-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock is a gate for the TCU hardware block on these SoCs, but
it wasn't included in the device tree since the ingenic-tcu driver
erroneously did not request it.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index b0a034b468bb..42e69664efd9 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -111,8 +111,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1000_CLK_RTCLK>,
 			 <&cgu X1000_CLK_EXCLK>,
-			 <&cgu X1000_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1000_CLK_PCLK>,
+			 <&cgu X1000_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index dbf21afaccb1..65a5da71c199 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -104,8 +104,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1830_CLK_RTCLK>,
 			 <&cgu X1830_CLK_EXCLK>,
-			 <&cgu X1830_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1830_CLK_PCLK>,
+			 <&cgu X1830_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.35.1

