Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCB596E20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiHQMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiHQMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766E4D81D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d14so18703064lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vdE5nDV3qdB6mAn0Qwup5zvvjj6Xy+e1DVZdaTpFju4=;
        b=MothkAULivGE5t/I0REdZsq/qGcfROwwWXGp3na9KFPPN4Zy+AkQjk+a0Y/7uxdNOK
         y/rd68UEDiJfDd0k1X+s/+W6B3oJ5LIBi1a9jWW+YazHaXqsR3/YUGwwQBjXpbAe26uP
         nE0ccEQodw2lbJNqg1kVJ/yaAQ+A21DtE8dwpVhuwiu6exZ0hTA8CqOiV4sZrK4KAzwP
         66VRRSHWybNDC+CrLzUjRS/OdXMY8VbZCML6lXC5+LWyToW6/2AN9MPoeJ8KWZcH6Foo
         3HkrBrZdUgQ/09M2nvkN0Mo6EDYAi3fjdXf1H31qUq0lD1Phz3ECJx5937M6XEQGIgc1
         Q+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vdE5nDV3qdB6mAn0Qwup5zvvjj6Xy+e1DVZdaTpFju4=;
        b=aVNwrfqyGUgrZzcYeHlJj68qH2testrxzE1RBfv8D8YipeAmOYt5Lu5+l+32rzkrLs
         aWYPAhpr2riM6VMozOfUanzhdpHadD1uIIl1KWa2XiXMoEprhgObG09wmRWe4GbTlyEZ
         vgWPfrMGhHL9CPbvtOyGDFDeaLSRvTc1c6vYsUtWG6/VIa9c1YgfmV5nCXo0oQWPxG8G
         kGQR/Pu82Ik4BmxkEH0nw1bXGSwLVFpxF3KtC48WgGX5jWs3T28qiOWe5PXm+WzyuD2g
         z61jP9EaYxug2Wc7YDM6K0OYf1GwsprYNOZ7GHy5LlK3j7E1fXl9SzxrKCAO6xr3XCj9
         EARg==
X-Gm-Message-State: ACgBeo2k+tl1EO7YK+ga1o86yPyJ06NJBKkLZYfPCw4oArZ1Q7h7Kx/k
        nRpG1tAJURJKQYt7uKI1nEKvqw==
X-Google-Smtp-Source: AA6agR5OKAEP8ghN+km9ORmOMDn8PGCxJIGdj0PByz2HcfuUHt9EcrDunP64yn9/DfeV3R372TNFNA==
X-Received: by 2002:a05:6512:3c8b:b0:48c:ffd4:a8ce with SMTP id h11-20020a0565123c8b00b0048cffd4a8cemr7954884lfv.628.1660737862807;
        Wed, 17 Aug 2022 05:04:22 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 06/14] arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
Date:   Wed, 17 Aug 2022 15:03:55 +0300
Message-Id: <20220817120403.458000-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
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

TCSR syscon node should come with dedicated compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b82c335c25af..49f28cb531f6 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1468,7 +1468,7 @@ tcsr_mutex_regs: syscon@1f40000 {
 		};
 
 		tcsr_regs: syscon@1fc0000 {
-			compatible = "syscon";
+			compatible = "qcom,sc7180-tcsr", "syscon";
 			reg = <0 0x01fc0000 0 0x40000>;
 		};
 
-- 
2.34.1

