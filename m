Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F45354CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbiEZUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349046AbiEZUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:42:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BC63F5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q15so3128979edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PoGfKqwaOSA8hY2KbOckVLUzTs3Q4Jc3iaXuQGoRpA=;
        b=s7sEBaSU1vzd54sOOs0rZZNg9jOLdNNbwjwpFo7NPaSSc3/EKIKfGfGqUmjfhdBIZu
         tB3MOE4n0cSRKiu3kMyc9QWQPlCIxLXlFngGQ99MiTppR/kW6DZ2r6vPXjZxisDjDaYy
         k13/DLeamBpnmEzAc+1qsZ1L6InFRZoR/BKSyKI7UfsHpX3PqVH6BgrO/pw4iEh3fnfA
         aDN7/ymbV30iKKJ5/2YpkRPQks9rvdQYpsQEtIyoocUVncRWur4ETpIxqQ7iRrdx9vvs
         r0DbsSw+JAaC5BiER/ilnIVQPfvqwa4W+hnWDhdh1zk68xbe2pzmpU0TmUMNdL8vN6EL
         84Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PoGfKqwaOSA8hY2KbOckVLUzTs3Q4Jc3iaXuQGoRpA=;
        b=mEpIR14MTLzaA/G+0YI/jlU6Z16vzVHguMj2ierkGqhMC2CAjnwSmhYLMi6NEqT26H
         +7ba/jZF+03eawvG74MGkPq9wOgqQ2n32hwU7Dg8K01ogit0Fa2ixvhdsyTZ/RCyjh7k
         gWlnBLDQs+e8Mxu3oRMur6/pVBhRb33BxC6LvL0PPIm2gXhL1yUerPOXjgzPms5fsKn/
         AledS4DwGe1vf3HbnpcHSru5BjUs4X71jB0FXf4pGKFar3vWpqFj+4niKX4RHjtLvYhr
         Q0kC+PgDITAdPfW6AKa/5uAECPzmTFUWL7rkD4pzSj33poI09oUSe6LirbHPWHR86rv6
         EK/Q==
X-Gm-Message-State: AOAM531lwEPQQjdnUwnl7H2sJVaMbgOlAvTRQqALYpn1Ymyo8bAgnpKS
        SsKIM6eU4ef69QZQ47NLEESdPQ==
X-Google-Smtp-Source: ABdhPJx7r6j+aBTRisTlPBtzTk+q8WC0quei+dan1fVS+/Wp2DlSJGxhdl7sKtt7zczYJvjIFb1ifA==
X-Received: by 2002:a05:6402:90d:b0:428:c1ad:1e74 with SMTP id g13-20020a056402090d00b00428c1ad1e74mr41662182edz.345.1653597745304;
        Thu, 26 May 2022 13:42:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r17-20020a50d691000000b0042617ba6389sm1239732edi.19.2022.05.26.13.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: rockchip: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:17 +0200
Message-Id: <20220526204218.832029-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204218.832029-1-krzysztof.kozlowski@linaro.org>
References: <20220526204218.832029-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 .../arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi b/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
index a10d25ac8f7b..f9dde0eef527 100644
--- a/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
@@ -13,10 +13,10 @@ bluetooth {
 			    <&bt_dev_wake>;
 
 		compatible = "brcm,bcm43540-bt";
-		host-wakeup-gpios	= <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios		= <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios	= <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
-		max-speed		= <3000000>;
-		brcm,bt-pcm-int-params	= [01 02 00 01 01];
+		host-wakeup-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		max-speed = <3000000>;
+		brcm,bt-pcm-int-params = [01 02 00 01 01];
 	};
 };
-- 
2.34.1

