Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A268A5B01AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIGKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIGKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F555007B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so6949715ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=QUayBXXXQQifaUr7SvEteJ9XjlPDTTT66Q4Cr4Y2pFZe8xZ2d254ZvhSiA9kRb49ld
         McwmwvCp3p8Tuw+ECr9s5WhumW+6i/VW8oPQ1uhAkTr3/xrUvkCtjBUyW6vkFlI9bDnV
         2WzYIUtI/SQmLTiZnq9dZPqKalruCfa74SFxABL50QhOCNsREOGMEHfwkptLLyqX9X3A
         9JWRuj+r9Z7zGAjLKvB4+mloxi6JkHw8oCGOrRx9jtyPgimyBiWG66gPImowHdFBIGla
         Qc5lqJnIrd37Bi8Osls7UaxBhfZKA7iKmN4bkQl0Vgrr5gkXSVfXWbKl3UAFaZBrQQfc
         IeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/UI25rqJUxEZV+KxQUPmeT2zHV2+PmX8LADJ48o6xoo=;
        b=7Wlyv9bqHZgJJl4IZ2yduZ012iUai2jH6PdaiaPuDA3ZoS3DixP9BEcGFr0PYQdMVa
         nAoNZxpdDyYIPODrtg25ac+xfzubSpCUGbts+UswNDbxKrNeWJTO0GATLGZUwy+oBe75
         2dBBByIO7Hb/0k9h2FxPqhAxBzVl7L4QsKkW1huha5horw7S6fGYk1bz+R1ReZSR5jaM
         hzKaT4glwW+SE5u7hN5QNtJHJGWvfxoZPlbLtN1KkgYrh7swcXShaK5mgp85alLQMqf2
         O81ZZ7BGQuSdWAlF+FIGPft1oLpXYavc/o2D6IAOUGnHBALcpCUiweYC1GOuyU9Dxtgk
         EO+Q==
X-Gm-Message-State: ACgBeo2aDGI0PDCMfx7jgKsTaQKliun2uypj1QbAcVO3mlv24QJG21MX
        o/AQujRa/WJXiKvj417baRQknA==
X-Google-Smtp-Source: AA6agR7nOIzZhNtvn8sRXKUjNyuxZEtUpULEKTr10PqSzpitYQCe6cmjzcxlGYW/+BV7LVNfZ/LOeg==
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id o20-20020a2e7314000000b0026aca1860ebmr708771ljc.69.1662545772937;
        Wed, 07 Sep 2022 03:16:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 06/14] arm64: dts: qcom: msm8996: align dai node names with dtschema
Date:   Wed,  7 Sep 2022 12:15:48 +0200
Message-Id: <20220907101556.37394-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects DAI node names to be "dai":

  qcom/msm8996-mtp.dtb: dais: 'hdmi@1' does not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index abc17c905bfe..b346ecccb94d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3402,7 +3402,7 @@ q6afedai: dais {
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#sound-dai-cells = <1>;
-							hdmi@1 {
+							dai@1 {
 								reg = <1>;
 							};
 						};
-- 
2.34.1

