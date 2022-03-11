Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF41A4D5E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347634AbiCKJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbiCKJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:39:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F7C1150;
        Fri, 11 Mar 2022 01:38:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t2so4737219pfj.10;
        Fri, 11 Mar 2022 01:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jav/fi0zl69Rvu23rBiGYix2mFrzEsj77NIMSen2XaI=;
        b=VjXQZHqxoLRyLX7F5aLPCv15b6AqvVlWnJmiQAdhuWRn0KwoNJkh+SWWcsI7FnZmf3
         QVV+IwB8MxlMtI49THKmoI7J0WQnla7zXbAdsVn+/pQN4uWe3YzlZhCOTwprUtGSA9XM
         j87N6Mzm+a9aIKfdVMwABIi+Tumyo9DCxLGi/W8umPpCpjiRk6uaykb/Vk/kicwzAqBs
         oVfxU0QmdMG/uXMPNAbr3NPpQhSdiKggcJ7ZZLU5G70a0lOMD0JTj4QcTiVRXltqGhho
         DBBCDqYlv5Q+E0o3yJ5X7LhZ28W0WOtjzCMLKaHNqVZ8Oh6KORLUUC0gZUViKMcGiV7G
         jRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jav/fi0zl69Rvu23rBiGYix2mFrzEsj77NIMSen2XaI=;
        b=GXpTf0wF+kOaWHeo1pr4DzpYZnSg9UOA/63f9aYXYD2lU+PVPIlpnYlkXjXrepTdXj
         Ml0PQKe1U9pv4FHKCVf026EFd4B875OYF9piLDtpb3wq0luIjSmB21Ce80qLaWoAPfe4
         EVuh26qRAyEgga1zlmpETIZ1/++ZRUXiiAsi9CfRWsoXpStRukDKc7Hg9yQNLGNpb1nR
         tsl1jbs16RbiEKCVGQvk79OABkptgPs+8lYmD8ywatRXjJ9gi9f3Cj6tLRwHasycGlMr
         5oJ/D/hlYFHHHqReMEa2H8BsN3ra3hdI/5WxNhvG7pHK8E6FvzbCU+mVZV/PpXOBB3JH
         ll1w==
X-Gm-Message-State: AOAM533bJgxjeQbxnYNE2g54QIF/ANhzqHYkGu6O1SY5WLhe85wxBQU1
        +nvAP5SxAq5ipqAAKxvt96w=
X-Google-Smtp-Source: ABdhPJwjrAfYTZPyQMA6MOU0MwTXYXZdKqKf5YBttfZnCBljGWbZ5bAoYsy7+x/Yzo4rposTNrmpUA==
X-Received: by 2002:a65:6c0c:0:b0:378:d9d6:cd0a with SMTP id y12-20020a656c0c000000b00378d9d6cd0amr7526184pgu.117.1646991496787;
        Fri, 11 Mar 2022 01:38:16 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm9011011pfk.26.2022.03.11.01.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:38:16 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
Date:   Fri, 11 Mar 2022 15:08:00 +0530
Message-Id: <20220311093800.18778-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PL022 binding require two clocks to be defined but lpc platform doesn't
comply with bindings and define only one clock i.e apb_pclk.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- New patch with similar changeset
- Send to soc ML

 arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c87066d6c995..30958e02d5e2 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -178,8 +178,8 @@ ssp0: spi@20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_SSP0>;
-				clock-names = "apb_pclk";
+				clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
+				clock-names = "sspclk", "apb_pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -202,8 +202,8 @@ ssp1: spi@2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_SSP1>;
-				clock-names = "apb_pclk";
+				clocks = <&clk LPC32XX_CLK_SSP1>, <&clk LPC32XX_CLK_SSP1>;
+				clock-names = "sspclk", "apb_pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.25.1

