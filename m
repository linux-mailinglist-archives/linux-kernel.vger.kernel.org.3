Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD8596F12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiHQNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiHQNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:04:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC537F91
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so18933517lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vdE5nDV3qdB6mAn0Qwup5zvvjj6Xy+e1DVZdaTpFju4=;
        b=hbL4Mc0yVll+ohqUSOFIwI5UQgyQ9IAczH/skLzCKCFgstC9xHSqgdFyDWs7reUdHA
         py4cQCracHpGd4bYfZ0lgsS9wLGJdciW1hzyKhGcnWCu2/9UlYGesp0IEgN9C8tncS8Y
         dxonBj6qBS7Vz8Cp+xTxTpSsbwpqFzrIXjvVfZorMq9oNOCZM/J9jFsVw3znpTCYiuAC
         KUCVMRMrFzTTuRxiDuPcbm7GSxOGl0OIDunh8ts6tKX0uaPXBO6LGndw0D/1n8EHReTk
         dAcszMMKzUYHlaIvY/XO/HWPTkQCLU1FMFyw6qAopt9rrFTVQ4YiRk50/2YeRsqZIUav
         9ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vdE5nDV3qdB6mAn0Qwup5zvvjj6Xy+e1DVZdaTpFju4=;
        b=e+DeXg+1TKIhFm9BL6HFA0c4Kio0BoQAlEf7gWhEuJu3g11BU7+5UJFVgzBmRzuGWU
         avcfWRaD4ScMIm01TNF0nEsmi6ALe9y8ik38bh9xXBJiWK7P1/od8Vab3IrL+HkZVJEv
         5X0ovcYlqBhI121zatC9u2b6jIGkL39pnZaqEhqV7owltg7WL+3htXo9/6YGs3XGv9jm
         HaLdfF3xJPKBEqCVJjwvrcK01UAQjlDb8nDkE9ldDJPh2EBEvEZjExWTNOri87ffHtip
         l5RlLOIENxK1pFjOAm2eBfZ/+b2XO7z+46x4TNuDoKXrvf+m6e963GM+4H3qsltlqqLc
         ucnA==
X-Gm-Message-State: ACgBeo0OQ3GcZvS1CQUYgjpGwp6/Al+L6kr2ZAmH8ohdJfEtWvlFlgPK
        DCg8we+DoupvJeCNgOHxtO4G3A==
X-Google-Smtp-Source: AA6agR4TcR6MepQivrVzkp+HkVxK5fgE0thyMcGv9meclAUouUUgdAshS0KF0s85NEVvW9ZPsqBjrg==
X-Received: by 2002:a05:6512:2248:b0:48a:f36a:2e63 with SMTP id i8-20020a056512224800b0048af36a2e63mr9118402lfu.485.1660741438859;
        Wed, 17 Aug 2022 06:03:58 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b0048b3768d2ecsm1683243lfd.174.2022.08.17.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:03:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 06/14] arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
Date:   Wed, 17 Aug 2022 16:03:34 +0300
Message-Id: <20220817130342.568396-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
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

