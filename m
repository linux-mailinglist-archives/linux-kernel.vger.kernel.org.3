Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD2754D661
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbiFPAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349349AbiFPAy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB957165
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s135so12890023pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nap20TqgB0A/v+P7vQ2P8UpGK04XbIqt1wfub5uXnA=;
        b=i/Hj9mgu7iQ0dmF8TKr4SZrvHUysltcYCDmQhRenzfoqKnCKCK5gPhBkdN5qNDTNMU
         zKkPD+Yi94/oA1W2FjMEYBOE9aFtGmnKHaJ7cMJm/8ZSzX5cMgmKc+Gb+BSgTeY6OKxq
         IOcDxM7jFIHaECYn+GsUqhLUzN6ePzgTOqmJr3rf7wEMnyhOUIhMIzKJiSZGTKWaDPbE
         qIKy1WxioqejZCTU0WU3f+T5RD78E2oWfLWKy5HalFp9lsVx4+uArrmeeql//uwhzD8X
         le+sBQ6RN/gf/S1Sz5cpsx/+mpgQraXSDAglTZyNXuN1BwJohyOJdHjVEcllNQd9XF2b
         tV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nap20TqgB0A/v+P7vQ2P8UpGK04XbIqt1wfub5uXnA=;
        b=rwhbckMhhfxbhD1n898s4mf4h4oLnyLNyP93nop0/lMd1oAYwrAhLYWeFMnOvw8+bf
         p4Mhgh5WyhpJd9B2iHD83+tHMJK9Rv0rrLLVkdV8EhEqiapN9M56THNBBJiSXn8cVBME
         69nloOT8YQ4Xqu9kBqAxMBsK/eWQNni3B75mpG3BXJage+m0FfOo+nwlqqeuD6ljYi7U
         iGgvM6uymwwLYCC8rSamCojqS5MDQPCQ7588zTZXFjaNS58M2rAsao8MYUMiLI8TlWdK
         +3q/UfWeYVGefV8u8+9wPdmUb+yOwPADGojN3Evy9XM00IuwJmx0KGu8sl2YoSx5rI0P
         yASw==
X-Gm-Message-State: AJIora+oSmr0MMyPiYli9LijmzFdpYVhcNTd+FJYQBwpErO+L3KeMtjH
        KnSQs0ZNkSk7rSxWmVXtS7zY0w==
X-Google-Smtp-Source: AGRyM1up6OxTQao90fn2iMzGI62yKiM2RJnpZI50FISs1ZyKORF/8rAad3+f2m1qofy/2GP+3z44Ig==
X-Received: by 2002:a63:135b:0:b0:3fd:876c:975a with SMTP id 27-20020a63135b000000b003fd876c975amr2180615pgt.538.1655340850765;
        Wed, 15 Jun 2022 17:54:10 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 12/40] arm64: dts: marvell: armada-3720: align lednode names with dtschema
Date:   Wed, 15 Jun 2022 17:53:05 -0700
Message-Id: <20220616005333.18491-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

The node names should be generic and DT schema expects certain pattern
with 'led'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6721b9b4cf5c..de8d0cfa4cb4 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -35,7 +35,7 @@ memory@0 {
 
 	leds {
 		compatible = "gpio-leds";
-		red {
+		led {
 			label = "mox:red:activity";
 			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
-- 
2.34.1

