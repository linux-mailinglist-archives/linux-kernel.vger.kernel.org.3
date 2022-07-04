Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401B95658BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiGDOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiGDOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:36:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383E65CB;
        Mon,  4 Jul 2022 07:36:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so11947501edb.6;
        Mon, 04 Jul 2022 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQcJjn3ARqMYdbJS4pFTA/MzxJjJFrNvD2Fd+FyIdLc=;
        b=oQYwfsf0MHUnEgA0ixt7Vr9jO3hYveqzhAMBh2cAQHItMnykopGDxlXg1SbXLIcQ/P
         VR2zZNrbl2fIKg6HsRDQIpwNuAXf6K3NajbohHxygvHZjHxRV2soR2UFYXwv1tHuIRH7
         yeuHqy32s0X8T9FiiDKCdXp+4kzWPtK8IfcMoS5izxyukA6qbRNcf3sOpjtxCXOj4Zh0
         Aq/pbUpQoyleEYGvwCu+VLA9jpzHNL317eN467V3irADhseXoT2kF0vsn3Zz27yQDplw
         IDZnmn+xtI1e0nLE40WyHyppF/mUrl1BcYIgC5egDq/1+29LTbqbcMV7bL02jSgmpnca
         zadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQcJjn3ARqMYdbJS4pFTA/MzxJjJFrNvD2Fd+FyIdLc=;
        b=ACItXWjGaVfWO8Nz5HJfJ2MSkiGVkiK0s5NyvOLHBxjjJJzG7a4mH6kMAaY2bOIENo
         BIc6fAVSas88MJFS48w+qPefq7LzZZXkZ+t+kT0YAHmtWPMVDkn7D9DrkFnvkozXSKwn
         uJDYdFEMPJNyM9r/xg9dWbTS3T0626w+BxEvUhsqkXWDmnqmtg1SpO7galV7S/gMkV+9
         ZJPTfNM5Ga9ayh2vm8KfEgDXMoIKqUhmSgmGlR04yBxTFEG3Zcc1Y1PAOaztMvmn+kP4
         R+vuAX/ZehLGuQtWpyDIWLEQOLOijnmEhEfONME1hOh2smjVpv+qFDr76JXUCjQiwqvI
         +qnQ==
X-Gm-Message-State: AJIora8F/7e7F4toMR6uatRHJGmBfEuUiz5TDbN5jcHrZMu0G4m2CR5O
        ITX/7nShbyI95GH9JdFrt04=
X-Google-Smtp-Source: AGRyM1tNFEs5Coillq7eNgQw4vZaTRfahwhoYhWBTxbXDWAfVDr48Nx3QKNtO/fA4SrKT0iOiHqgBw==
X-Received: by 2002:aa7:c0c4:0:b0:43a:20cf:3c68 with SMTP id j4-20020aa7c0c4000000b0043a20cf3c68mr11751577edp.172.1656945358622;
        Mon, 04 Jul 2022 07:35:58 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k10-20020a170906970a00b006fea59ef3a5sm14286020ejx.32.2022.07.04.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:35:58 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        bhupesh.sharma@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: ipq8074: add reset to SDHCI
Date:   Mon,  4 Jul 2022 16:35:54 +0200
Message-Id: <20220704143554.1180927-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704143554.1180927-1-robimarko@gmail.com>
References: <20220704143554.1180927-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset to SDHCI controller so it can be reset to avoid timeout issues
after software reset due to bootloader set configuration.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index ddafc7de6c5f..d685ca1969a3 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -482,6 +482,7 @@ sdhc_1: mmc@7824900 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo>;
 			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC1_BCR>;
 			max-frequency = <384000000>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
-- 
2.36.1

