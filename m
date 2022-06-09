Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9598544AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244715AbiFILnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiFILmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73561ECD42
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so46920138eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouHToTpfN91IdC1bQjCsmRZ9s0XMaKvgoUPDfBZdkoE=;
        b=MCGCVjufFqOOIqY2BmXcaAlOQZP/Mb+gEcACSVAlis2Z8u5cPYXb0vv1bolsxVRWIL
         6w8c7VAOzqydEgwsZrxcNAjPTgKFSWbtgFo5K/dU3ikxMhoSakVBi5ZsZVu88h6PZ8vV
         eKJFs1KM9Pric7/nas8TK64Mibp6DgyMO00AQS6rB5QI624a/23Ajww+GB6jBy3Z+464
         m3h1BxP0wtfBG6hxyUXwFl0qgLRXBJZ4O/hZ6axe/6wPj8C8SLqLPdRYU/5qLfc4LnRx
         pKqCTW5/szu1KTxaulfufe8/WxKqGAiDvLzN13ijGS245X3U28yqx5qxu8HiWnb3U8jz
         5YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouHToTpfN91IdC1bQjCsmRZ9s0XMaKvgoUPDfBZdkoE=;
        b=SVTfkbkIW0nuY/knuLb5xRfQiZ5IQdV74Cm4HjSS9RYjzjNbU0dXWjzBGVi0q83o7n
         yCZ7Gmr93sdp+Y1vlMVojbGQftJ4XNcXj8yugJhwTgYXP5QmigxYGEHIsG6LIcxwI50U
         tJ/mMtngXzHrquip8T2P60+4PfhzAqLj2LTPjj3/9MUOa7NRcVn1y4f99apY0e8r0F3s
         eyULWVVnvTioLYsp+gS+Q3ljRziXtjnH6hyDfGDGAL3VbYrkwdEk960+1njYCoO+TRs4
         vXLMtNXltptTat+lwzCgXhFsoE1BoOYKSrawHqJ2FOUFQt0Ko78mrxl2cRhWUzx2ZkdX
         QRBw==
X-Gm-Message-State: AOAM5301ROD06f7NukikfaJf7oEbrUSDDMRkDMJddtbglo+YsLj6MLRq
        zqH9MmC2+0BXTOUXWym3YBkSbA==
X-Google-Smtp-Source: ABdhPJzz6M1UXqHNUIFcQq/P9/vNHhMGDrGeRXnd7+DWHIroLqIpwMzDeGqSSb7yKePjKhWbv85fhQ==
X-Received: by 2002:a17:907:3f97:b0:711:d61d:df9 with SMTP id hr23-20020a1709073f9700b00711d61d0df9mr16406402ejc.644.1654774852403;
        Thu, 09 Jun 2022 04:40:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 40/48] ARM: dts: animeo: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:39 +0200
Message-Id: <20220609114047.380793-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/animeo_ip.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 7da718abbd85..3fa3db2d9d02 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -168,26 +168,26 @@ tx_red {
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		keyswitch_in {
+		key-switch-in {
 			label = "keyswitch_in";
 			gpios = <&pioB 1 GPIO_ACTIVE_HIGH>;
 			linux,code = <28>;
 			wakeup-source;
 		};
 
-		error_in {
+		key-error-in {
 			label = "error_in";
 			gpios = <&pioB 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <29>;
 			wakeup-source;
 		};
 
-		btn {
+		key-s {
 			label = "btn";
 			gpios = <&pioC 23 GPIO_ACTIVE_HIGH>;
 			linux,code = <31>;
-- 
2.34.1

