Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9E512017
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiD0QKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242666AbiD0QJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866D48C721
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq17so4370526ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJ0Q0VIVseR/Xb4PlIow7xAWcCO8wMqCFaxsrqIqI0E=;
        b=CyT86LbMuLmP2a0EUvz1E/PXFMHcggaxNvy/RctILZfaRgIleePezM7eCYc9bvPz0g
         gjkXCHknC9dwuDLoQN6MsTBqPjn01f+gMaZbjDMDxsBDcLbYdJC5ECFNOy4pu7fL9aeN
         VYK4S12SW7tfyTixOcbJ/KEeUDDDFQ2Pjgwx27I31oV9lSh9vglu7Mu6jkmTDcEaHy8K
         qPuLraY+hgE5Kwzv/WynE+wxNUKCsNUKSTh+iWiwyidHONoJsJOQfh2eHLuIqvOf/JYX
         8idt0SmjiUrJI2GLMHgqS2P/EVvsJ/Tcc4T/1KRoYUsiHwldOLFaEs2AbZhhrz7aYI6W
         sAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ0Q0VIVseR/Xb4PlIow7xAWcCO8wMqCFaxsrqIqI0E=;
        b=VwpI7EiJWaQgRB2KZe9k8HsY5eo4dAOE85FjwCjB6UQgjTQ63Ii4enEJGdJD+i5K3I
         FHw3HW3FJZNTp0l/99kjJ4dldXSfWkwk9MyJyjk3idH77HDneCww9qPKCNVY+HVTROmw
         72mdwK/rMtLOcygMJYRqccS4KxwHj640+h4xLQV9ZPStzfHZPkT9uuHzysRCpyVpVPmr
         tHaDrhDLRsj6hN91BeKNnLWp3+vxHxVRbGJ7ci4t8FMDyHPy7KHikoTMFTsMmY7tgGEU
         neA6f9SZBcFp1wZqxNQci9GbwfGtRLaX4zNltDgnptA+jgVyI+GaPrdn9Gb7HEgawTwZ
         aaPA==
X-Gm-Message-State: AOAM530uRkZeko3oR4yqBrc+Nfc4BqkFZ9/y3Xr0tWdPsgoR2wEXHdbM
        /Y5fKy3Q2U6uewUm7Jj8aJOk7Q==
X-Google-Smtp-Source: ABdhPJwWxW3RPJbnXbqUc4FtIVtMXsr0fm3DFLB6KBeF9ALk49qujynev18Dega95cbb3zdyazAEjQ==
X-Received: by 2002:a17:906:2753:b0:6f0:22ba:92d3 with SMTP id a19-20020a170906275300b006f022ba92d3mr28539217ejd.655.1651075549434;
        Wed, 27 Apr 2022 09:05:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8571437edu.44.2022.04.27.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:05:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: da850: use new 'dma-channels' property
Date:   Wed, 27 Apr 2022 18:05:37 +0200
Message-Id: <20220427160538.646044-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
References: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '#dma-channels' property was deprecated in favor of one defined by
generic dma-common DT bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c3942b4e82ad..0e8b42a95ba4 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -679,7 +679,7 @@ cppi41dma: dma-controller@201000 {
 					    "scheduler", "queuemgr";
 				interrupts = <58>;
 				#dma-cells = <2>;
-				#dma-channels = <4>;
+				dma-channels = <4>;
 				power-domains = <&psc1 1>;
 				status = "okay";
 			};
-- 
2.32.0

