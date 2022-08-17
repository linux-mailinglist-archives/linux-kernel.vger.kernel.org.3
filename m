Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC143596FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiHQNOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiHQNOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:14:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97C4C614
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v2so18957604lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G7nHz7460NiblDwkfaLZP3QC942cYsdIM8XAFA/ajO4=;
        b=Ux60q81hVODEZ/9jXK6w497/gC2vI3P1tZbdFxdC7xZz26+r69kF7Ay82VhNZborZk
         L/TqTpH907LPYU7oDzCO2WHPks/3Nt5X5SXUJt65mFu8kNFDwxa2RgNQENDyIenqsVji
         KO4CkIbSeSKX6cthFiFYToS+bSBV0y1bDXlXjNNZhsJRiAG35W3hnRUoprjD3PZyujeA
         /w0blmU9lUw5MSxHa/bbaVsvGmEwGq6tl6LuFQgr6OkeFyryD2WmIW+V5OaMkW0rnjGE
         vWHe0c/ZBQit5GGf5CKS04xciRk1+vWigIp5+kxAiPRRZJNyegN/DGfWEj23co0DWa7J
         igLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G7nHz7460NiblDwkfaLZP3QC942cYsdIM8XAFA/ajO4=;
        b=a7ZxVvBQF6pt8w+gGvvFDzB7pfVg1rFfCmlLT3da2QHDSzBNoUpd6va98Rmw75StAF
         GHYHZKBq/bbQUicAvmGKVwy4ZPE2aFSpNmGPedNC51uIosA93XFi6I+athC4oRDcVyWd
         sYmTWPqX7voonnLN5RlAEaNkIPF2fAnyUCglvIJTyl5N4fpbpT1jB9cRF98W5GRGQfIt
         rYyEgyggWnvXb35msYvmJYoka7Za+fwan6onY+oA1NwfAYCX2rM2DCNSSDMB9lASJXyo
         JIJ1RpIFfgXvsWvUtdFcWt8GJQoDmqG+e+5vt7v/Ur61fCHhLbQshrj+jn63kzGZIHrV
         zwtQ==
X-Gm-Message-State: ACgBeo025WK56h6N/URY0oFEiLuFAu1X3YLsOMLqKwMwwTkpAgy3FQCO
        eVHMiG4n5Q1ACxwoPvGLIdBRWQ==
X-Google-Smtp-Source: AA6agR7VvZ0QXXkcR5lT43JZl+4AdD8B89Fw1v6q71SdS7UPGz75Z3tQMAGOjjFa6BZ9G5qRomKT6w==
X-Received: by 2002:a05:6512:3e0f:b0:491:313d:5b6a with SMTP id i15-20020a0565123e0f00b00491313d5b6amr6822082lfv.223.1660742067199;
        Wed, 17 Aug 2022 06:14:27 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id k1-20020a2ea261000000b0026182f31aa0sm1411307ljm.1.2022.08.17.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:14:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 04/12] hwspinlock: qcom: correct MMIO max register for newer SoCs
Date:   Wed, 17 Aug 2022 16:14:07 +0300
Message-Id: <20220817131415.714340-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
References: <20220817131415.714340-1-krzysztof.kozlowski@linaro.org>
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

Newer ARMv8 Qualcomm SoCs using 0x1000 register stride have maximum
register 0x20000 (32 mutexes * 0x1000).

Fixes: 7a1e6fb1c606 ("hwspinlock: qcom: Allow mmio usage in addition to syscon")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwspinlock/qcom_hwspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index 80ea45b3a815..9734e149d981 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -121,7 +121,7 @@ static const struct regmap_config tcsr_mutex_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
 	.val_bits		= 32,
-	.max_register		= 0x40000,
+	.max_register		= 0x20000,
 	.fast_io		= true,
 };
 
-- 
2.34.1

