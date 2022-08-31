Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47995A7F94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiHaOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:10:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CFCB6D33
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:10:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so20146298lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lGy17wvB/kP5iwD+EDbAM5mvcyJJNjGffo5dUfEtBBM=;
        b=a4BWc5G7tpXzBSAF50gJMVl43eqh4upQt2r0vwY9eTtJUGQxVuTSndUyQk4SIvSV/Y
         OlM6TmNwdRd44Y6BVKCAoX2LTOYFYA4dO3tOQ9Wgr2i2wJHp75hR9E8elYilPPq5PFzT
         h7el/UEZp8hMha26p9bbNDac7sMLXWXGyc4Alg2OiIAVKkBM+IDFJSy7m/Q/VyGESOuS
         se6ujFx3hDnJAb15DwsQ21PrCpVUdaTy0QjgmJDzpVM9K2SmjzRi2NtC7PHnIFlF0EBQ
         hSWrM30nr9AaDnXpZ9GwaeTCVTMxYUlQs9kHMeROTei4rH/uaOxSXpap58l6fbaGVBD3
         Ezfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lGy17wvB/kP5iwD+EDbAM5mvcyJJNjGffo5dUfEtBBM=;
        b=ifrh9lL+MUp87fK4F4CX/1YnCFVEjhc7E3l+CsE6yHHPnw4nN3R9cbaorEdpNZzsMT
         U3eCOzW2cVQsT13EDcZhffOQhTRLH47WDwFDYY26RhV0C496MSMIdIksYOsZlmLhv2EE
         Je+dUYDEZTKmuBJHI/5DHXCy39crUKkEdbkYLc+io0z8vrgU/V0EwdES4JfGUv0T2pjZ
         ebjhhpCNVCBgphXsjhCZjEDZPr6szBFdkiWc31MP8lc0rjSxxpIUhjUlndiFCKmUMfLp
         OeNBIwBPeKbYHvFLIAsroUyjJoQ/152Yw78cE9iJn9324bzeEGHMTyJ5EFwnaVzYejyx
         4Cig==
X-Gm-Message-State: ACgBeo0DzCh0HmN8QVQ6u+mOFEhDWyM22zIYPwBe7PrDbWBWJxfDLV+C
        BaFq+5g8k/b/h6HAycDis7DYag==
X-Google-Smtp-Source: AA6agR6A6bPOAHr5EuhM5oZnH4xaPPQ3rSxMol4RmT+ORZqxAkVPCuB9/CRkZnflf5EJYdY77FxWYw==
X-Received: by 2002:a05:6512:e98:b0:492:cf3c:8860 with SMTP id bi24-20020a0565120e9800b00492cf3c8860mr9151601lfb.603.1661955022696;
        Wed, 31 Aug 2022 07:10:22 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eba09000000b0025df5f38da8sm2122282lja.119.2022.08.31.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:10:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: enable newer Qualcomm SoC sound drivers
Date:   Wed, 31 Aug 2022 17:10:20 +0300
Message-Id: <20220831141020.515887-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound support (machine drivers) for Qualcomm SC7180 and SC7280
SoCs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 265454620682..644d084c6888 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -792,6 +792,8 @@ CONFIG_SND_SOC_APQ8016_SBC=m
 CONFIG_SND_SOC_MSM8996=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
+CONFIG_SND_SOC_SC7180=m
+CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
-- 
2.34.1

