Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C0587F23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiHBPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiHBPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:40:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4AA21839
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:40:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u1so12264674lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwlezbvhXuRvV5TPdrQiV7stHxCGcT+SmzyEBBd3qdo=;
        b=N0cpFWI/ylXfaxwVjxPbWzBvKvt2QFKUdosx2mmu90xftITQDuB0ZYnRy7mwtY9V4S
         fKV4N4a0JXLzQGnTEkQ0zKxN4fPSw9cy1PHUakHUNQDMT+OPvI5WdBz6isCELWkd8yMd
         HnSEtmi+U9i7LIPXMJ3duagQEsLMFapZZM9faQ/RZqzwltCwg6mER+DOUhNQpPuKePte
         ayhHMD3GmAdEZQTX8syhL0/vfofvEbJBPqRP6v+jNDICrFtFQaU2hY6Uu/TUMZNHk4X6
         ua3w22EcHqHW6WSNXICyCSPN47Mo9agZPv6RmLvHMkjrh+/JZ2STYwpZ2PzV30Qy/3u2
         rrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwlezbvhXuRvV5TPdrQiV7stHxCGcT+SmzyEBBd3qdo=;
        b=alslC9LlsaHqmxkKptR1u4pJClmFlD6c0j966OLnzaa/rDHyIFF+6rfpG5lOTmjZk6
         2fg3pjoazlnwt38NMagZGWZc/ggsb06lA0CkX4RpHRdIBtjWOd/Ru+Vjvo05VRaCBZxR
         7xXJ/JDFbCEJZ89nabQVeRjAiw4kwSws8QTT0yS9qmHs+XMFmrXP/5ZQHLr7yeUKzBZj
         L+s6rpcwcFsgZl/cgqbjt9OzdRUyZMhFUA7ykx6Luas7U/fSQKFOVOWeY62Ah9UT+XX5
         u7RR6GGIglf81VKy9kxE8jZNs1WkGUFtRjeNptO9nNHTjeyQtqssxoYrNf0MyuzltRda
         rtyg==
X-Gm-Message-State: ACgBeo0W3Qkwlv6BZjS0dYdsJUGkm0Z9YkAovUss2Mc5wscjxrqFen9Y
        jeOhbzO38sE7TMGOu93t1GbMyQ==
X-Google-Smtp-Source: AA6agR5oggDH/S0CVwXycN1Z+nIz4U3RvOhhs5EFFUPMEIJLcH2s8mt3kCdoQKDVs+D3+6ECHMGMlQ==
X-Received: by 2002:a05:6512:12c9:b0:48b:138d:c84f with SMTP id p9-20020a05651212c900b0048b138dc84fmr950215lfg.391.1659454803659;
        Tue, 02 Aug 2022 08:40:03 -0700 (PDT)
Received: from krzk-bin.. ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b0048b06f34566sm407669lfs.76.2022.08.02.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:40:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     corbet@lwn.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c: drop gpios from CCI I2C sensors
Date:   Tue,  2 Aug 2022 17:39:44 +0200
Message-Id: <20220802153947.44457-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220802153947.44457-1-krzysztof.kozlowski@linaro.org>
References: <20220802153947.44457-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OV7251 and OV8856 camera sensor bindings do not allow
property "gpios" and Linux driver does not parse it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index b9304f81290a..f313f6964810 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1214,8 +1214,6 @@ camera@10 {
 		reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cam0_default>;
-		gpios = <&tlmm 13 0>,
-			<&tlmm 9 GPIO_ACTIVE_LOW>;
 
 		clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
 		clock-names = "xvclk";
@@ -1256,8 +1254,6 @@ camera@60 {
 		enable-gpios = <&tlmm 21 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cam3_default>;
-		gpios = <&tlmm 16 0>,
-			<&tlmm 21 0>;
 
 		clocks = <&clock_camcc CAM_CC_MCLK3_CLK>;
 		clock-names = "xclk";
-- 
2.34.1

