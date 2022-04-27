Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B73511DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiD0QDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiD0QCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280B1632E7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so4318447ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IksiNhcQ6mciop9yOBJfsgBTzjVfi6pE2+JXa5kV6jQ=;
        b=beD8ORtMzxP6rFpwCfmFTFN1r6Yb1KIRS/9H+HxtQMyp3BfaB5MUx/4CsZPnAA/dZ8
         ZxnXELdl/VWcT4X2ygao3zP1cHUfTTEanMUQbRn7qDU2Zqcg1CC+2I4xwL6FM5IS6ZeL
         vUnbb2Ahx4bllPivcg2dXne3HFQCtFutDAoCbUCx1aMdkaOKqPbmlcvdFh4ZEQLRMiKQ
         WxDLBf4qLZDmpf0EVOFJ6VpzXQrbznf+lAj0GJSo/ysQiEBzUR1cmB2mXRQ/CAfUds7c
         Kq607GEACCNcao8/Z2lZuH4R5aJEZH+GELyfXfqhS+I79k9h3iCmszY8DtWmvD6MceYQ
         rUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IksiNhcQ6mciop9yOBJfsgBTzjVfi6pE2+JXa5kV6jQ=;
        b=IBqeJiCg4DdFI8W2kHPM4PVPHe3GfzYrXWMkq8UO+aXhQ9bX0wZ1T/yEBIBJRYOSk7
         J/eDH5dMDiXf2kXJ5lSDB0fefugrlwS5bXxzxbbDfddivx71boOeN0lLx201B6wTO7kq
         0oVIZD9Adj+gKkLJd9N6cNepLW8tPzHyF21Aiedhot8F3mI3r9/Ta1RtMELLhdOcxp8X
         4rmDJwvMTH2yhrMKhLxDN1LiWtSrnzNs8zUhM3L9O8nAb5X8i3HpiVUOBvlQRRUy2rk8
         JBGqWklq8IzHogY9UoslWljvSvnY0Akv4vKef7N3IaA8samwRnbaJBrhrYmU9Rfrz3DK
         Ba/g==
X-Gm-Message-State: AOAM531rK0lRT0HhHM+W+urmS54zyN2H+Z+q+c1oH5DOmfqXTh08t81b
        hiEqJoIjV+xl2u6upXTe3aBcdg==
X-Google-Smtp-Source: ABdhPJytNvI2RmQmaTFyUReVtLPKo6iYa/E2OYQyQive6MOG9yr+D0tvn9hqoKO/QQWI7KDnvCSYJQ==
X-Received: by 2002:a17:907:6d9b:b0:6f3:9a8d:6a08 with SMTP id sb27-20020a1709076d9b00b006f39a8d6a08mr14580252ejc.87.1651075134261;
        Wed, 27 Apr 2022 08:58:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 06/10] dt-bindings: mfd: samsung,exynos5433-lpass: fix 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:36 +0200
Message-Id: <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
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

pl330 DMA controller bindings documented 'dma-channels' and
'dma-requests' properties (without leading hash sign), so fix the DTS to
match the bindings.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: e18183cefc8b ("mfd: Add DT bindings documentation for Samsung Exynos LPASS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
index f7bb67d10eff..b97b06848729 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml
@@ -79,8 +79,8 @@ examples:
             clocks = <&cmu_aud CLK_ACLK_DMAC>;
             clock-names = "apb_pclk";
             #dma-cells = <1>;
-            #dma-channels = <8>;
-            #dma-requests = <32>;
+            dma-channels = <8>;
+            dma-requests = <32>;
             power-domains = <&pd_aud>;
         };
 
-- 
2.32.0

