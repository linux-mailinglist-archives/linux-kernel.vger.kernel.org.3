Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1157BE75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiGTT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGTT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232249B7A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so31829109lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Jzx9GCmk6v8/6FtVhkrN3oIWw/EzIh6GIlVuoE1Wss=;
        b=ncNXY5ZMhxs6oue2vj8JrJJngvwH1OCXkg0OEyjV9wVLBa7K+XN8LzUWdjKPM4iLPA
         m7ajsl4nGEN/6UuiHeyGCNOzMRgKOl+Y+DpPCtovkooexoVbrwPqL4UwGkVoC3XllUd0
         kaQjMyqWa1O+BjBaVHKVfUekVO20IUB7ofdacFSTqf8uqMV0nMbWYxq7BcZSPebSUKUK
         5BWwdFA7hPT6ur9uvrt8zXOzoOoGdjYMVVq333YFDylVsj6/WzlxQ//bH8fQBj45aBAA
         yvzGepTCEMYQ9pJksRuUuHQPmpgCfBtFkGIuLWARMTYckvkPB9ZVhxxjOAQ1YHQ13YBr
         /51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Jzx9GCmk6v8/6FtVhkrN3oIWw/EzIh6GIlVuoE1Wss=;
        b=QzY/v65mk5xyB/cVWX2OM+s0ICpgMRIToFJyG0U1X7Qu9CGqZ9TokaNjIa0TweBcBh
         ERvSNabYmoEJRZLKqp884Noea6qGI1HO9sOepghBYUtDXI+MAVMnFeUp641AsIrPvV8F
         L8WFGOJ7QXToqmELJih5zT9bbvLqIIPKAXUvyLoH+X8BF7gf9JVvupMKInqI/CROl7qJ
         Ca1YhS40ghxl4HEiTxfDb437+gHj5F6NKCYSpjSYIPunLbflw2LcFxGnLgv7usLjRoA/
         o26CaOx/2ywUsjR3Vjw8Oux72tOVrWatQs7LQR+RMALUMoBoWY3D6O4W82FW4tb0ROKI
         HlcA==
X-Gm-Message-State: AJIora+tGx3Z9VK9kmqDfEhgmgamt/XSNmKmG4vQZiZor3axGXDtVr+b
        1VvaFi5JZQEzFrJOpdjGeMbQzg==
X-Google-Smtp-Source: AGRyM1uUEqNC3ROWL6ZvBiUjjCVkJAZ08vDlMUNEhVK5uyrQRUvsIxJ2b25ktWKspvhUgqSN8q2Agg==
X-Received: by 2002:a19:5504:0:b0:488:ac73:254 with SMTP id n4-20020a195504000000b00488ac730254mr21148998lfe.672.1658345295001;
        Wed, 20 Jul 2022 12:28:15 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 02/10] soc: qcom: icc-bwmon: re-use IRQ enable/clear define
Date:   Wed, 20 Jul 2022 21:27:59 +0200
Message-Id: <20220720192807.130098-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
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

The interrupt enable, status and clear registers have the same layout,
so BWMON_GLOBAL_IRQ_ENABLE_ENABLE define can be used also for clearing
IRQ, instead of hard-coded value.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index bea3ea1de7a4..3415f42523cd 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -162,7 +162,8 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * interrupt is cleared.
 	 */
 	writel(BWMON_IRQ_ENABLE_MASK, bwmon->base + BWMON_IRQ_CLEAR);
-	writel(BIT(0), bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
+	writel(BWMON_GLOBAL_IRQ_ENABLE_ENABLE,
+	       bwmon->base + BWMON_GLOBAL_IRQ_CLEAR);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
-- 
2.34.1

