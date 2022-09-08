Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC55B17DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiIHI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIHI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:58:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDAF7760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:58:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y29so6472697ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jhsX+3/ZSrQLWbkIR9R09MJjTx2RHdKDwk2l4SWRmW4=;
        b=KLOITiWeQfLiMQ9kcV6GcIi+KtsV4KcxAP95Z9/z/aJoKuOyKaa/7c/ANDOl908hBl
         uCvaTIgNFjX62UOqkmBy7cmyMIgK1u3CQjcrOYteBIXXaulOxaMGOTGmpf8nWrfzUHkA
         ddhojYNk1qFm0v5Pgt/9N4K0rA7q58NqABxvrkIQm/BU/WvG39XrqUW9Dtwk1RsiprkF
         dk+uzC9JDE7K7UYG9d7sYMOj/pSo4jhKLkeGmJ2J4ifWigd+/h287QrdoPHA8+QZEgZF
         Z7VuTJIlfZgtadfQ4xThgukosQtecmf66e5sSu48Cs5qfajk8Q0Ysh15Cr24mtMyyXWX
         HgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jhsX+3/ZSrQLWbkIR9R09MJjTx2RHdKDwk2l4SWRmW4=;
        b=zLPSkXOc4A0TUm8sPhDOsVQHteiCAVF/zD0Jh2sE1AndLp7na9Bptw/czNPr1R3MJi
         exuT4jYFHCAiR+PePAtMc8BQzcqnYwu/rZgMn6qqzN+TWLJT3KvnQP8uVfeJ0QNtMLFo
         C7k+mSL7SaaiVHnU096IiQA8mGz1f5XKjRmWNZ1IP4bJwEhEyhQbh6n6nJTr4jpHEtsN
         Ng6uCptpmszBIqNvl2lbaP8fVETuFYZcENaYZHmEaQigK9JurP93vENdSQ3uu0uiBNxH
         OSxw4eGs1mNANZe1TJ2e4VN8ukQn/b3J21+5Bpb9zlt/M4bXjUjlzsdIEeMGUXCW6/tJ
         J5gA==
X-Gm-Message-State: ACgBeo2U1VTonf5EISJbIJjlOlSrAmp1CHtm8I9H/B2IPL2mbAjnLipj
        M3qKjWwuWxHy4W75tyW7+Z+PYA==
X-Google-Smtp-Source: AA6agR7jYGTkfjAN8kshYYAM6/Y8Ns61ZfYj030nyqiiiEqZsQL2IxAX9BcGKeaDPUPDn+nCKIs51A==
X-Received: by 2002:a2e:8509:0:b0:26a:c954:978c with SMTP id j9-20020a2e8509000000b0026ac954978cmr2260829lji.471.1662627513360;
        Thu, 08 Sep 2022 01:58:33 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512209000b0048aef1abb08sm2936677lfr.297.2022.09.08.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:58:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: correct CPU BWMON unit address
Date:   Thu,  8 Sep 2022 10:58:30 +0200
Message-Id: <20220908085830.39141-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Correct CPU BWMON unit address to match the "reg" property.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Fixes: b2f3eac1b77c ("arm64: dts: qcom: sc7280: Add cpu and llcc BWMON")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fixes tag for commit in current Bjorn's for-next.
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ad04025a8a1a..a58916009281 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3328,7 +3328,7 @@ opp-7 {
 			};
 		};
 
-		pmu@90b6000 {
+		pmu@90b6400 {
 			compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
 			reg = <0 0x090b6400 0 0x600>;
 
-- 
2.34.1

