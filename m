Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36754D67C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356148AbiFPAzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbiFPAzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470957176
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so3708plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXB5XzjU8LfwcLqwKO65LrYsijml7F+eyLiUznyo7HA=;
        b=VGry34Lsq0AAS5nS8T6G1tLJmFhnHD7ECJLqZEOUaJy7QdnDMbPqUOUZY6b0P6If+x
         3Uol647tBlTWP6/ZisPA7IHqknVh+L9peADwDRasaWhMrymZ41xMQwCp6s3Y4WwGB5pG
         Ds/a0MWQIUGMskAyAgZW3yACJAm/N0IzCY2sK5fuOPhKxxqhXCucmeW2oGgcCCuy8BxZ
         z+xri6fR8xTTHBaWhZj6XAfXbG8wl4u/ET6YjeKflaW24AurN7ZA/63448M5zw62FM3j
         +mRfFSzgTFX2ghXYud3l1uu4BGvm2tF6mzs61wuv5+waU2zF0CTi0+D8HNccvczicN5y
         e/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXB5XzjU8LfwcLqwKO65LrYsijml7F+eyLiUznyo7HA=;
        b=FpgOjAAvMSwhoqos/GcRnbJryxQTikz52CsOaeEizqbYuwTkWQQtgqDEDbgvNUT+Lw
         pqnZzKj00YiZIcK+vWRx5vcPnS4NK6We1FwG0dXuU+Fqufiw53Sha2R7JLls3iWl3fpD
         PhDhl5y6n83uhVa35tkk8kOIKOY4pd4E3GxD3R56YfZgtxm6rCufqksfaabmbng1zJyx
         m14WTlOyObDixWG5P3NdiMzQuiXTzLqMnkc2//JYuvJc0IvVZb2F6MQ6hlWs58mnS+KV
         w9KqrgSSc8Z9qxbfpQ+GT1BwXag1sQ3Sk1xn32EiuHVUejcfA948zAF0uQIbRPkLjxHz
         uRTw==
X-Gm-Message-State: AJIora8QKeoOzao1yxOCdspBZDDx/2XUdY3R2EaWpPR8ym4fhEqNI5TQ
        jZnA4zDG6UxmhXn8y7+U6fdaCg==
X-Google-Smtp-Source: AGRyM1tTJuVv6wY6oC6Dqloj1ueiXM7oVUn01PuF4hqwTjmcDmQnxyteBUfMI5SU0Y3/qkOFQiy+jw==
X-Received: by 2002:a17:902:f54c:b0:163:f64a:612c with SMTP id h12-20020a170902f54c00b00163f64a612cmr2228151plf.22.1655340876407;
        Wed, 15 Jun 2022 17:54:36 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 28/40] ARM: dts: rockchip: rk3288-tinker: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:53:21 -0700
Message-Id: <20220616005333.18491-28-krzysztof.kozlowski@linaro.org>
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 9c1e38c54eae..09618bb7d872 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -26,14 +26,12 @@ ext_gmac: external-gmac-clock {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		button@0 {
+		button {
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
-- 
2.34.1

