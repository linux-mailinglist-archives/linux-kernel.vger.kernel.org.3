Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67D544A86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbiFILkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiFILkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8731DD4EF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z7so30789483edm.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hk45y8qg0TijcVloTKD2QUlJ8SLct5jsD0wtYz0wctM=;
        b=dCysHo+wV3b6rhcbXJ02dDqextk07Ftyf3ShUOtoADi710qB7HdXXJlt5Eql7OhVGv
         VdoMSrWX53MJfnf0PFpHgmT0YAT0QazGH1uN1IXV41ZP/w/lzcQ1dHDKtzTDQpPl3MlH
         59/+9NEaTKXW96KT30hLGn1vZCmqWOgP6UhyoKMx07ZFOdJXVlbGH4O37bIl2JoqYQpd
         lKR3PXjIib1S2zobCJ/R79Voyf0vFMRF3ZiPsr3AQW7AQqX63tYjxY+6Z0Ypuoix7yje
         ZQx+pWI8pOgLVo8BVxvRpDUowFEHfGEYidnYqv+FInDXAhTskHS4Egijo9MYQhdx24Sn
         pDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hk45y8qg0TijcVloTKD2QUlJ8SLct5jsD0wtYz0wctM=;
        b=IGLpnWBvD6bARkeEMVNZJZzSBVfsgegejz0bRAhe8mRoQOhIyBvz4MB+Ey1hiCoK5N
         zRyGUjHquJ/e4qzdJRpO8Ni9j4UFH1ARHCkMe6nnkr+PWNYURdJemoG50+5knM1CVFtr
         w2mZ0RcOh4PJmjJHhLi03oozlz+ZzFM+oHWZsGdaM4hnH41d5Se6RxZAwK5N7IGckLMM
         LwXi3SwV6bjo33Dy3T13lK/uaRmllh1NyW/IKw5ov5jyYoiI9MpxejoKUIbTrDiXiFvO
         /Q/6imp7EiTOI1NhtI3w4fIaDOIGEAJkcBvl2aIya5NP9vFOjQGhLfW7G4T/VZ3XOJts
         YLRA==
X-Gm-Message-State: AOAM53311vgPjZyiSFpTRnG9vJL1k7Bofby0O9svefcJfap7/oFBHxMX
        4prwWSEysFBB7pQYZ6ZaZFr/wg==
X-Google-Smtp-Source: ABdhPJz1DPyaMSlaZrobu0Ns2R2wkkgKs5hcB09Ys87/bOBT+HrZRhThi35KhfVZt40jyOCKf2gWmw==
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id j18-20020a05640211d200b0042de68aeae0mr44342368edw.111.1654774791883;
        Thu, 09 Jun 2022 04:39:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 16/48] arm64: dts: hisilicon: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:39:35 +0200
Message-Id: <20220609113938.380466-7-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index ad53066ac495..c4eaebbb448f 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -29,8 +29,6 @@ chosen {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		pwr-button {
 			label = "Power Button";
-- 
2.34.1

