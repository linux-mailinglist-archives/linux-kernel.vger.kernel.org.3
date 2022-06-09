Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6D544AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiFILni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiFILmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655521EE6EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so30792899edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjxoc+L6eqxwMNT3+yJrollfGrhiqYTPiC+5llKZhTw=;
        b=oa5631gPzZ1vSALtmIgPQ+Mf2fsesOimoN3QBdze+ncoEvIoUOZIQzTcCPHrzIKHcg
         yhxu9cReJajlsc0snjM6nbNTjUbBNkjaJRLcGG8lpuE933I0HHW0ltJn1bX49zq2i8D+
         5a8pAxLB0cNfFCNf11VIcbv5cIz4AmXbEl5Ha1ULh3QrBhrZqugtchW7HmyRvJiHCIBc
         ASD8ReYxNzn2piJ/K6/MXRGlb6WaU5h7vWqUUVeOFVOrbDRt732w/3tdtMoIULsI230+
         GTnpEi1uMO+EhFCH/wS/wgTF4wUK9+gJN53r5+fPmWcl2e1lT5d64LI4PEnlQAf8mrh+
         jf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjxoc+L6eqxwMNT3+yJrollfGrhiqYTPiC+5llKZhTw=;
        b=DpqAbJXOCtDoBvIR7rg3J6ishDybGw6PbvN8+04+Urbfj9hiZimI97spdGRPYP4PnM
         9Chv8Chp8nED18a6jvn39kfQQ+a9jrvtdB8jDJ7tn9Cf5h09T/EwnXg1zZgZdvVOFRQG
         Hg5JtEac2cGADtX42pjUG20kUmMnyi5hTxedbGFmznIa5KJZkOmHsJD/IjcNdy0Kf5Ee
         IvEVQeZ9DgeruSf3dxt0QMkOVe75ecq8VRXzOM2k3TWaQD6SdJjEFnLRp/eBmgthLB2N
         65zG6VGmPlotA1qcEm2rAKjkNpk2l79UYz94VtNMsS1+6qScEiq5h4IbSa1k1QMImKdD
         xi7A==
X-Gm-Message-State: AOAM531uX0GA4cwAudsz30OfOXtgJuyM4MdnA/O9fYovaLsx6xC95fXY
        OiHEyHd2PfQXd9WXpHnJ0CeiXShtOl6Xsw==
X-Google-Smtp-Source: ABdhPJxPc63M50iTCbsK+6FFVsXhJJ0JDj0X+1FyV6eeg49NgHlKPMPWQ5q/sd9fNQQFNNP14yzouw==
X-Received: by 2002:a05:6402:510d:b0:42d:e266:e02f with SMTP id m13-20020a056402510d00b0042de266e02fmr44330056edd.277.1654774853478;
        Thu, 09 Jun 2022 04:40:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 41/48] ARM: dts: animeo: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:40 +0200
Message-Id: <20220609114047.380793-2-krzysztof.kozlowski@linaro.org>
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

