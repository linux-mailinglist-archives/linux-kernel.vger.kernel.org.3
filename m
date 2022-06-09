Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07039544AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbiFILms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiFILlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50FF1E96D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so30792064edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXB5XzjU8LfwcLqwKO65LrYsijml7F+eyLiUznyo7HA=;
        b=YONyQm9OPL92w7ANCTIJJeD1A564n8Z/1Smd0v6dgfKJPFGxRDLYjiKDADO1PxCCna
         Q4QXUi70jYQGsAZVvcNsK/D990hxIjJTZ8s6+dyNOcdNzHo3WGnLNzWNnGD3sV7CLsn1
         H0JwnnGDPe7IHgx5pFvD1FYPasSi5GejvhOO4h55GGPELkO2Z5RP3v4ruhz8hqz9B5wN
         6cJV4FsVIZ/d+8AI3rjlyZ8a+3zhvdY/nsxFUlb7ZpBxgOglq2lwyzXD4YXRYgs8tS2h
         e/hDos3tX7KACP92eA1TVjDZLmV0+71XpJt/kMXQtKVOn2IbLJ5v36K7AJ1dmqczYdbl
         TrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXB5XzjU8LfwcLqwKO65LrYsijml7F+eyLiUznyo7HA=;
        b=Y77qWschO5yJzV+rJGmjdivxacSYLkdw2QSrWi2cN8nKetnjwKhzMDbvG7iYWdk12t
         J6nwFSyuhJgwU6JQW8uZ7BK1rJuoTtRz1IIgWBkSoaW/GFetvyotYU5D+kqQZNSleFMx
         lfez6uSeTl0VKMC/1xmjYG5UW+4Mv73utftdu24AA1In49NXoIsXy9ZrBkpAOXn0cbHY
         RBwEJpZAlBeFkg1irLeNc1j5edmDKOfzBPVXU+JckGRz/AJas2uKJg4ZmNq7Ybmf/Ysx
         S9U+GCY22njbm5H3QZ2E3AItMt4y1S1M0hZiTL3armX7ZclG6CIPUjh0y2ZJrG8+VR0E
         UkHw==
X-Gm-Message-State: AOAM533NXM/ABjOyHItk/oLfuvWtueoo7dC/ZXlIt/+bUiphQHhG9Mw3
        poEneAXOwOIwhQsCer5OFLcXMw==
X-Google-Smtp-Source: ABdhPJxUclF4ULlGFjz01jV+wOJBGG61wx/rlp8x0HAu8Yv6J08fW8jDciyDz5F/25kGVs9vASxfMw==
X-Received: by 2002:a05:6402:1f8c:b0:42d:c3a9:5beb with SMTP id c12-20020a0564021f8c00b0042dc3a95bebmr44617549edc.160.1654774838347;
        Thu, 09 Jun 2022 04:40:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906058a00b007101f6f0720sm7760844ejn.120.2022.06.09.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 34/48] ARM: dts: rockchip: rk3288-tinker: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:21 +0200
Message-Id: <20220609114026.380682-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
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

