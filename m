Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E664F2363
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiDEGhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDEGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:37:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8B186F6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:35:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so14595875ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=sgs8fnLUD89sfYTrE+ztbdtKCYlSgQ+3jxn5yhXrqMc5/ygGoNFT9KdojhBNjhW5sQ
         3FZFGS7u9p4kre51GpHTdZxhjcsDBDal75fVqCM+V2KJ0MInK+oHGpzcCogOau2/4suk
         Zzk35Zfvr4MM/M+bTbcE+hFMvsKhrNrHoXvylaUb9lewRt2e3cZIfg3307dIFH8TcjqB
         xCXVXe14n48fLpEZiRTKH1DHmsnnQVXbWf9BjxlcFZ9wjbbLurOCm+E4/aUniwvNUFTX
         9NHxIInARpWhVFOC7I3QJoIN204dgvT6gf+i5PYIZUcmulal5wLFADust1lEx+J/Mdp/
         INjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=nsnYUzW6bd+UCJ/LDBVangHNRgqbgJQAlg6xFrIISW/v747X87ma2Xf6tFf/3OW83Y
         pSFlAu5LMadrFK/iYWwNJsPC+qpnnfAP9Imt2kl3EnWIfCk4ftYdJUdWk28qQJgiCbuP
         q24Qg/3yGoF6pD8YHszxarusqWG9mb7f2+wK23Mrt6INhNmV8QTuOC8huJR768Bp3OWd
         IcSIF9v2rMewv/N3nhB5OICiR6JNzwSu1yngE2EYqCQgh431f9DQCMFbPvLcafDyuLqt
         jo52DOV7/OeN3aTEJby9dILwZ7FQ4U3Om2pg8viiF5uM/PgR/hIRfb20TiYZ1g8/QXoi
         CmQg==
X-Gm-Message-State: AOAM5332fhyiQRF3MR53FOib9nUmgagBeCpAf/aOkpZhu9sPE9v+f4NR
        dTC99SK0warKJ3fNvYEeq7FWag==
X-Google-Smtp-Source: ABdhPJzRmLtL4M11x2CZ4rufphPdePuc0MVn8NdfZVbdMzqOXEYcT4hpNY+as9aYXAgrEeEOH0BLQg==
X-Received: by 2002:a17:907:168b:b0:6e7:f2a5:bb0f with SMTP id hc11-20020a170907168b00b006e7f2a5bb0fmr1991664ejc.162.1649140514379;
        Mon, 04 Apr 2022 23:35:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/9] ARM: dts: qcom: msm8660: disable GSBI8
Date:   Tue,  5 Apr 2022 08:34:47 +0200
Message-Id: <20220405063451.12011-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
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

The GSBI8 child node (I2C controller) is disabled, so as parent GSBI
node should be the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index a258abb23a64..47b97daecef1 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -212,6 +212,7 @@ gsbi8: gsbi@19800000 {
 			ranges;
 
 			syscon-tcsr = <&tcsr>;
+			status = "disabled";
 
 			gsbi8_i2c: i2c@19880000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-- 
2.32.0

