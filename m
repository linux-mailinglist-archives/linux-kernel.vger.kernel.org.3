Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069714CDED2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiCDU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiCDU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:51 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD021EA29C;
        Fri,  4 Mar 2022 12:25:57 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id i5so9032953oih.1;
        Fri, 04 Mar 2022 12:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LRTPRbN6vPYbVAn2Zdnbpk3vHhhQG4/WkG23Gue8KU=;
        b=grLm8EI1ty0kqlxutbbbwtbXQ13s5bAWSoHMPeyBWDfK01yCrxuqgGbZGPB+T5sT4q
         TYSsDjzGBgYk/qE5M37SFBvZcBRHoCUz69DN+GtEhd0l9LfW0fMAeyateKHyJeBasX39
         Bq2qol/ftMFvHfT33wpRCP2ACb1XnnPE1WFrzOTeslAythcck/kVqY8XjyYp1cjgW96n
         +zcU/1Dt9/zc0zGolC/N4ODVB9VnURBk3dIjP8IOevyLT1mYbublJDJ6l73GqX8QOFPf
         L4lXrHoPXQhtHokK0D535WxOXgsjwMs4Vm7NVLAE2tTHaBoB+J+2FRCIzyxMbFaSDkjQ
         vzsQ==
X-Gm-Message-State: AOAM532Y+l0U6ZP2cqd8o1X2NSbM6huNWlw1RH8d7/yJGuu8YR9mgZmF
        jidXrHaiURmgOpU1POynkw==
X-Google-Smtp-Source: ABdhPJyil+fOgIuPL3tBamTBtK7CBGjApBnucIHKGe+/KrdT8NU++uUoDjlB3F+e8lsmxuQjesQlLg==
X-Received: by 2002:a05:6808:10ca:b0:2d9:a01a:48a8 with SMTP id s10-20020a05680810ca00b002d9a01a48a8mr612946ois.243.1646425556375;
        Fri, 04 Mar 2022 12:25:56 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id b22-20020a0568301df600b005b0af1c835fsm2645052otj.59.2022.03.04.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:25:55 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: broadcom: Fix boolean properties with values
Date:   Fri,  4 Mar 2022 14:25:51 -0600
Message-Id: <20220304202551.317448-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boolean properties in DT are present or not present and don't take a value.
A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
matter.

It may have been intended that 0 values are false, but there is no change
in behavior with this patch.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index ec19fbf928a1..12a4b1c03390 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -111,8 +111,8 @@ slic@0 {
 		compatible = "silabs,si3226x";
 		reg = <0>;
 		spi-max-frequency = <5000000>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
@@ -135,8 +135,8 @@ at25@0 {
 		at25,byte-len = <0x8000>;
 		at25,addr-mode = <2>;
 		at25,page-size = <64>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
-- 
2.32.0

