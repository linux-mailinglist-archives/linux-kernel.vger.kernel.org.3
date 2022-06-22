Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06E5547CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357934AbiFVLtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357933AbiFVLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:49:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B743CFCF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:49:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e25so19160016wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVF1kQELJGnzeWwHQpr93Ja3CpfIbtJSBiq/WRe2Aqw=;
        b=zABfz0t7VSnhzVVzhHPJaaqYYEfCRTXdcmora9jZdD518G3s3GYRKylmrMypRkYGAD
         EEIbxxtRH9myYsihAq3kN1ilp7HVtwpH33NzWjZn0srkey7tNzEbiO+y706xjmO9LjwN
         90J2wXM79tV7wFN3hCoFmWynvVIymsKzTVZtd0RoPg7Qdui4lwh1ggeeDwNHBfjeu81T
         JntOIft9DinEJsL3HvH2TtYNNsULkpdmgl4ZqHiBurXrw0GBfQ1iggSqnJ7H7Qwnuv86
         8m+xoCYtgenEmcuxrLpQkDyib1ORPirOTyjo0/abDyYh1xDd9S8xp5M+uj0JsvJl6Unj
         WXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVF1kQELJGnzeWwHQpr93Ja3CpfIbtJSBiq/WRe2Aqw=;
        b=bnQiL8o4JIQeko5kENPPIYMoVPRQyX4eHPbZwfryFJVuSL1tsiCJ47hO+VIci9/EYn
         Sl6byawVm46bdFqApOze84p4P/CVooR8AuMdwhYz4GXx30mwIrye+Jcfk/JPfseY5iu1
         hReQMIqqg0MqMZ8UeE3dFUzaLKcB3yVxyd3r+neYZKFSFJCc8RbLHeekUcf52BclOH51
         NPoR0MrTbhk4FeDp3Pch5YaZVxgbZzi4Ynne4AZL5Ccbkut0iR/DbmyvjJzKs2NWa/rf
         mz6i174veRL1+A/yNjqk1AV7/G4gD4fAuGBEB8UtN+PuWumOG5mnZ+v03RoAVKl4kswR
         QBxw==
X-Gm-Message-State: AJIora/djNRRsgcM+Ow/Soc/jDXoZtYKIS1XJ6Ypdbqgl95rtIbxgfBW
        hnelA3F378Y9pLdKkZOP6JNr0Q==
X-Google-Smtp-Source: AGRyM1uVutpiNgLs8IpSadKwo1sMPY5fpDSoUGlmZXvZPRWGesc8qdeoOPWBUAeLrngCMVbcks7oeA==
X-Received: by 2002:adf:9d88:0:b0:21b:8a7a:30c5 with SMTP id p8-20020adf9d88000000b0021b8a7a30c5mr2890699wre.606.1655898546073;
        Wed, 22 Jun 2022 04:49:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0039c54bb28f2sm22448760wmq.36.2022.06.22.04.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:49:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples
Date:   Wed, 22 Jun 2022 13:48:56 +0200
Message-Id: <20220622114856.6243-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622114856.6243-1-krzysztof.kozlowski@linaro.org>
References: <20220622114856.6243-1-krzysztof.kozlowski@linaro.org>
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

The qcom,msm-id is an uint32 matrix, so a list of tuples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index 7748b745a5df..15467b697e94 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -17,7 +17,7 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <251 0 252 0>;
+	qcom,msm-id = <251 0>, <252 0>;
 	qcom,pmic-id = <65545 65546 0 0>;
 	qcom,board-id = <12 0>;
 
-- 
2.34.1

