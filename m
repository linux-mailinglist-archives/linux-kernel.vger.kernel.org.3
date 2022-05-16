Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D652847F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiEPMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiEPMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2464393FA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j6so28396338ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gc4L/U1sGUxTmqbsfQnXmF+tBQ2PByc+1ucAJIje5U=;
        b=pKT9sHk7QMLLgQCHPUYBQAWn42G+4qKmw2AC4F5hW6SHI+NjCoiaOnbG81ZvzhN1Hm
         RAISO1jvR6J23zsFQpc/FCCNi8eci3eGxCBvmX4SlhIP0Km1cl2H1SbkMA92LDOthCoR
         eJ2Vo2oxHyOPPojAkrfeGfEqvOAFbWEAw8Lm7U6FKlY5nxK+rjOQ1y9hPMBrY4zKpNtg
         ukBvc3svi2unSKWa3cHkigINhFd7Xtld3XReMc+EzjNKARZ42XufoFP6GMwVTbmfN4y7
         3+gf9hZfw/d+d8CQR0bczUkINrSPKwl/SKOjTiOU7V0htwUKzyFG8TWDsFm4gtuDUxX1
         asOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gc4L/U1sGUxTmqbsfQnXmF+tBQ2PByc+1ucAJIje5U=;
        b=rxbW2pktSzZpmJwyBt7nLi3ePSX1Y5dDx5yoIxT2aNkBDkb34R2uW7e0dib9Xc6QFf
         knGwcK6BJ1gO1Vk7ZzCu2PZLvr5ejN/Yi/SPAYH2cB3goahFhydSv7qEZqZq7iU6//O7
         KicF2ONmMxC9bq90/XLTseR2T3PFDHTO8J7+qFqeF0l+Z0LxdKhsXRUHINplQVFhX7oA
         FB4QQ1fZA6ObdY6IFN6Y/wUbnJOzyZkSiP2+V5KRgCNJLncTVZq2G/AwUKkd0LHn2VOZ
         w8vv0OsEQnumWmVDPO1B1BREJDhKOeJ1NOn9WxUJQ0SK5p5SUz0NgLp1y9VGzuQEp4vP
         d2gA==
X-Gm-Message-State: AOAM530AaPqwxQOJ8YNkRcrS7gzJKqPjYwQjR9NXHjnGD24xYRC4+Dpf
        WltEv8h/GQOunReXO4H4yjlgZQ==
X-Google-Smtp-Source: ABdhPJxwciocmfUVKDnvZ+KKTzJOCpRVmHIwm8HBsQ87h+hOQLnqKIGIrCGrGWt7e/RDBuFBf9JFzQ==
X-Received: by 2002:a17:907:a41f:b0:6f3:e75c:5a77 with SMTP id sg31-20020a170907a41f00b006f3e75c5a77mr15036529ejc.70.1652705327154;
        Mon, 16 May 2022 05:48:47 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:46 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 06/10] arm64: dts: marvell: uDPU: remove LED node pinctrl-names
Date:   Mon, 16 May 2022 14:48:24 +0200
Message-Id: <20220516124828.45144-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pinctrl-names requires the appropriate pinctrl-0 property, otherwise
it is not utilized at all.

Since its not required, just remove it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index f216777acacc..b89c7455612d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -28,7 +28,6 @@ memory@0 {
 	};
 
 	leds {
-		pinctrl-names = "default";
 		compatible = "gpio-leds";
 
 		led-power1 {
-- 
2.36.1

