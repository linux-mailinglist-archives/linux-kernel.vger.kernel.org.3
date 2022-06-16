Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1348454D69F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356290AbiFPA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354237AbiFPAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551CD583AA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r5so6200136pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjxoc+L6eqxwMNT3+yJrollfGrhiqYTPiC+5llKZhTw=;
        b=yw7fTFrBXvWvrvsb5WkegfMEW/6IhL1KT9/hAYo8dWOs2GGKYjkucklo/1t1qezcEc
         36/DUzR/HVQ825/6vqnL6eYxLMj9Eql7/LVFx3+V99KJp0liIri67BryhRUZDTnB10N2
         pSrGwGvl1QOmOOV3y67xfjcdFYTEjLb8lGp0k6OtSBxmUtCL6Cj6YPI2f+Co22OPUKmI
         Xe4ZkuZipAQRt655H0W4wuauqWhZGkX0gjVqusAmaOyHnn5U7e1/mzs7L1HcJVv4Nceg
         6pp44m0mzlGuZ46j+eWe3s+J5AdaeJqqTONXHX3A47HjMuA6xrbzLdGxkDkGWq/Wlvq5
         y8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjxoc+L6eqxwMNT3+yJrollfGrhiqYTPiC+5llKZhTw=;
        b=igP30oUbHa1942VCcN7KzSbm/9ivg8oe8+l+nIlON0JDLheI/XCqiTKLK8e/G0brvt
         BC3vKUTTUTOtisy4xHEFUDO9d3mLI+kwzFiJHhJGQsgwrgznElGObyxLubwBuMwLkZeK
         FccXC2T9guOuEqGLgMfV95/6xTjFgRg/ttxtbsHpGfDIk2CaVa1fKNJx5xi8IL7mKZft
         Wrtf387nW2RC5wKmPhoJ0B3nA3ru4ARe53h5i5VbGJVU/w4UZGpl82v5B+cB3HhjKdr3
         A7D6Cp/NdWSkdeRAVcV2N8mft4Ai8qwU7v167Cia+R1LlCSce1oCRtochMG4/F1aQxV9
         7OtQ==
X-Gm-Message-State: AJIora/oPNAM5iYv2JWQLdpBJpWfzMJSCCbvRJnpfL5Z4UAMrWnh8cKT
        O5fTM89d0KaAmUsOTSyqHJTfdQ==
X-Google-Smtp-Source: AGRyM1swqFLCvRDEgjzbq+By9bni7CFAlZXUZ04FXfBNf/bNoRe54RXWN+qNVPTzbe2p1Q8ydbs30Q==
X-Received: by 2002:a63:170b:0:b0:401:a7b6:a9d4 with SMTP id x11-20020a63170b000000b00401a7b6a9d4mr2185789pgl.107.1655340885064;
        Wed, 15 Jun 2022 17:54:45 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 35/40] ARM: dts: animeo: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:53:28 -0700
Message-Id: <20220616005333.18491-35-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/animeo_ip.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 3fa3db2d9d02..29936bfbeeb7 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -170,8 +170,6 @@ tx_red {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		key-switch-in {
 			label = "keyswitch_in";
-- 
2.34.1

