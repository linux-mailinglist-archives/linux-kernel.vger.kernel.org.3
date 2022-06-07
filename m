Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44F540028
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiFGNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbiFGNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:35:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6BC5E6A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:35:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w27so22987866edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDQbY/64npGudGixqFX4Cr/5hLlk9RCSz25mhEaqA2c=;
        b=m2ARHIniY851xN8CFtadCNZjqaVeAHydgmzCm+xX+Ru5UzM97CKTsIrQmrwTMuKqoA
         qq/LVaQlkK5EQKx9mkGt9foUSMiGdVvX/eNmmxL0FG97RgFcZtM9cSu3EEwY+Qp1mc1j
         RZV++y2nZR0rNieLFBGuwYMnW8Y2s2J9niujersBAyc1ywS3ZcJmy2VIdyxEWZth6Tci
         DU1hNjr4h1vCNvSj7eQD1T/EJQlxB/Kh5aSEVC8cUnygrJOKBqhURnGT3NlCHtFr02qn
         59fVxJzsCFKvVR65WJHvsA3fkCZjgwzfO6eti9s61Hld5UvWXtyIS+Xan03FZ4kJYh/j
         Cw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDQbY/64npGudGixqFX4Cr/5hLlk9RCSz25mhEaqA2c=;
        b=HVjBnKlUjMcNfbwTg1dTJdGs6j0as/kKxLG5gjsAtmrDzes0QYn0ptNRouHnH/yiqZ
         UOW4paFA8uEYLyfztpNIWGkUMXp/rVe6gNEoHV8sfiCSqN4P0ZTmXrWLyOJoj80jdkqa
         TAS6gMYoWUBGOESMRgoM/rq+NwX+kMRLUUN2t5sMWtguoEAT/VglBtaWb/iv84AFBRA9
         unIhTtLwoAZWwEcfeC9mPNsEbFp7mIwOvpMaIYp7lEshhgF9W1nslNGd3Q8PMENF5ySN
         f6tB/aUEg034bDm0UgwTXVHQanrOA2GFCL9PjgRP14kUwqD6TL+iZ9Qvpv/upKog4uxT
         LOOQ==
X-Gm-Message-State: AOAM532lO+ZNHAmLswVmGEoSAmQ/P3gOYGtuUpmAJv2xDBtW7HhYrFe5
        0SZPbyD+w9+kLO930G8HJzCk1Q==
X-Google-Smtp-Source: ABdhPJz2bmmQ/mb8Z+m00RUNU/4Q9fwi2oEPL0lZSscE/c56c7Vu+nsR2ZqBwPjPSbWamBkIWnA8SA==
X-Received: by 2002:a05:6402:42c1:b0:42d:fba6:d5c5 with SMTP id i1-20020a05640242c100b0042dfba6d5c5mr33801935edc.295.1654608920839;
        Tue, 07 Jun 2022 06:35:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090630d700b0070e1adff390sm5644204ejb.34.2022.06.07.06.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:35:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: mfd: qcom,tcsr: Add qcom,tcsr-mdm9615
Date:   Tue,  7 Jun 2022 15:34:43 +0200
Message-Id: <20220607133443.182468-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
References: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
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

Document the (already used) TCSR on MDM9615.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 428973f97a72..2f816fd0c9ec 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -21,6 +21,7 @@ properties:
               - qcom,tcsr-apq8064
               - qcom,tcsr-apq8084
               - qcom,tcsr-ipq8064
+              - qcom,tcsr-mdm9615
               - qcom,tcsr-msm8660
               - qcom,tcsr-msm8916
               - qcom,tcsr-msm8953
-- 
2.34.1

