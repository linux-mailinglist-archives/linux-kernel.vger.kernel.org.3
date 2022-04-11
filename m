Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840F4FC12D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiDKPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348114AbiDKPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:44:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE53A72E;
        Mon, 11 Apr 2022 08:42:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12386200wme.5;
        Mon, 11 Apr 2022 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qRlr8ZfTQ3raGd+E44T5DsXd8r35uC0pnPSIlIhBAM=;
        b=V3C7xQeOR3CSb1V0/I+e4R9iEaktHAqeKhhVjzxFUPZ1HebGtBSYM/LuQS3IzTbwgC
         4nzGBwlvzmlBOAAX3IWAMUk+JLmGhtns94OVRpVALquCJ0ipSeXQHUJCyqF4m9ePebst
         S5M5/nqMrjQ8cejdpo4/A7KVChJSRS5r7ehFgsk7rdbBr2yFEi+gy/lpiWQI3zjQKxL6
         r+LvkzrvM2afyIHNfKssBWV3eErgRHIuF0qyAdspn8cGRy+Vy4UIByfdJPoqrgqNmbC2
         wbeOgR/v1XMW5BNM/UYamOMMaMzdGksxkmotKeVawt8tRYavsiiJJ1uEIDwU+zSrjT7A
         Hz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qRlr8ZfTQ3raGd+E44T5DsXd8r35uC0pnPSIlIhBAM=;
        b=BpmQq0SrTmi7OxKAl4a2ljkgmmIp5cnqKCqIF5QeFoAcJ1ZomBZZChDRhc6hjZly2a
         dxAWGCDcvbjO7Mz8a6Jru9rEihco+xT9PnuZ1vEaVAtQ8/FILeoqSac/fM85lX7159if
         jwmrFhgjch+PfUp1RRII+Rg9vj3cuQWlzwS5021wMDqW19ks3yhJH0193xwskXr+9YBv
         xV3HbUIHxAHGIrQ7UNqSmobN4RMsWDbGce6MOd0bRLRyBHsdWK+k89lMkuq5oV8dvNkO
         jQvxtWFFGiKle8W2Ou5KKMGhhvFvRDW4bHrL7VEEP6d0A4TeTx1O6iVqzzd++4Wr+Ome
         FMhw==
X-Gm-Message-State: AOAM533XWx8jMNMJcAFdf+wK/Odl1+KzA77wirF3fLzgdlU86OPcQUvh
        G/OHKgP0ETmHQCVCYzyJOwM=
X-Google-Smtp-Source: ABdhPJyVsB4t3DoK+e84eXlXXtUqWrV6hCqBJHPlpgCG1/hDc7vuBwj10fyw4GAH9Qinrhd5+3Wz9Q==
X-Received: by 2002:a05:600c:6019:b0:38d:fbc:7988 with SMTP id az25-20020a05600c601900b0038d0fbc7988mr29612654wmb.100.1649691722754;
        Mon, 11 Apr 2022 08:42:02 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm12314323wry.36.2022.04.11.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:42:02 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 1/2] mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
Date:   Mon, 11 Apr 2022 16:42:40 +0100
Message-Id: <20220411154241.50834-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
References: <20220411154241.50834-1-aidanmacdonald.0x0@gmail.com>
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

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c69df8eb158e 100644
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
index 2595df8671c7..4408df24ca98 100644
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

