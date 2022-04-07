Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB314F817E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbiDGOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343869AbiDGOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:24:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB23518616F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:22:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l7so5779298ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc36ZdLQggjp64Xm41nxUmHXQp3VMbJZtJwCT6Mf3Ok=;
        b=ABr3/OF0kBX350HtclyvC4dSwP+vX7Orxgj+KLA8X0ySA8j1CrVfZ30hK+hn7Hw8la
         8g4leng5C78hi7xBxlaDbz40C1WcpJIIKTVmV1lMCpjxud6FwT3cftvvR/f7ycs78//3
         pVFsNd0EilM3qBdiIG34y9LjBoYO13R8Ng4YA4x9kajsBCmNeT3AP557SKBeRb/cmfEY
         szEVXZ1FuMYaOjoaf2L0rfRq8cw2G8Y5D6zzsr08kgnrQ5TyRHzJQSrL9fvenEe+A5In
         6FTPE7FzzxFlDD57CXCwVRHi4/KudxOMI3tFYz6/Y+xC4YZS0DIt87gkNNYhzZvYU0eg
         BeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc36ZdLQggjp64Xm41nxUmHXQp3VMbJZtJwCT6Mf3Ok=;
        b=k6wqKYQ3Y39V3As63JmNyxrrtTnv5HAMuAqrIpsHNISM7DiAdirk2z0i/i4yr/ZeSg
         hQi4eO8YDVL8BidxYE71ZGD7+6K9reQEQR2V9ZwONSq03sf0q8cJki2mo16GVC5Gn/Yz
         dn4q/guaGwAFXmaaDlZCADJW8nAYIR37wxTjM2fy6iI0j8f7u0CkN+8lJA59nEZ7LkKo
         CNcvFazm4yXzohtw2u+gHubxHrIdYCyJB9H4o+rklWUDhaVxrk1rzTQ9IW70GsxY/KqE
         BwTppvpMy5NrKWeglnk1MN8uabWjZNtdYwpx5XY3ZKm5dHOD3UOEjXiBWFGN3Y5UemG0
         Qnag==
X-Gm-Message-State: AOAM530hE95xJd2S3sxwi1dVmkuNoe+6KeKTPdnm+zqtXJTyCa6e2JL1
        ukieEZJIotGdFMjHwnJxScYJxA==
X-Google-Smtp-Source: ABdhPJxq7xRZCHutmiTGN9LV0M6t9OKBrdXTNKhP6bOb9NNpujMmjyWR7hZ5yzUMqyK4+nC+/TwWOw==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr14036973ejc.395.1649341334259;
        Thu, 07 Apr 2022 07:22:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm7569808eje.183.2022.04.07.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:22:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: meson: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:21:58 +0200
Message-Id: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 61ec929ab86e..56ea875c418c 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -65,7 +65,7 @@ &spifc {
 	pinctrl-0 = <&spi_nor_pins>;
 	pinctrl-names = "default";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "mxicy,mx25l1606e";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.32.0

