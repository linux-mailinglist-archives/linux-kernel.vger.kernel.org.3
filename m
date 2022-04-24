Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2550D2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiDXPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiDXPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:06:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986821632E5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:03:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so2464340edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwlK9jjG0EHaUq0duy+gRAUhYpTS7gfP9G9S4f5hT6g=;
        b=zcZ1bDliQAxh18O9LMACpJmrsgH/tqMAiuZcptCSSx/J/brrF00uoSkAGzVwtq9qIo
         6xeA/kNmN5XzMmH47LODWF2RL5QIEs/vG4aqK4akFx0EF/3T5jKs7VQ7IFCsScOhb//N
         KS2rJamCo/ge16a3Imh0+oMPSEOgykmEXZFCnxhF0nbpKULXRYjdQmA3M8WoUyv4c5x/
         +iUWfT+ksF5+ZBLE/47en/8MSOwjecreiD2hgBQrGrQRmI9g1/+WsmcwQVyyF+gTICWz
         6+o2HQk+bHTK3CHTd4TlkdrJlaTS+8OeiapR4nlIh4ejdvo5o9k5GE7builpyItYLr8M
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwlK9jjG0EHaUq0duy+gRAUhYpTS7gfP9G9S4f5hT6g=;
        b=lB1r2HpQF6Ya/IbJlBFm7CuPrjfc/oK6HEE/ReEzDQtwTJMSjMQUZoeXqVW9koJ9kZ
         2eNhOzdE6g+4TDrQSdFzQtZMrcdfHGSVSJzuu+ZUmFFtRwHZiz0qTHfzsu/5h3O191Y+
         Ccn2yt/juhKCZ2xHn6+cEReWJdX0+MxI1E8uuLcW2DH9u9GUBhuo4NOGEZSGE+EbCHqO
         yux4wR++Uncw35MXosuT+w2vN4DtYMRq2LExe6Qus3+oJSxLoA6C+DMwYsomq+fs85pU
         DEFbtc/KYUcuCNpXr9+vUl6+JJWl7MCxZAKrPMauiXdLNP3QfuZ0Ece0U1xIEJiGaveK
         jbdg==
X-Gm-Message-State: AOAM530ACoEqC705PQZUo407zYJR0Y+ovN/UXHg1WgvLcbUDUum1kyEU
        FFUXJGFd33f+WBTtBByMKQWMcw==
X-Google-Smtp-Source: ABdhPJxNGI1Ojx4plkpT/9SMClX6rw44WPBHwNsLIXfnk89K2IgDc1ZS5RkgQK9gbZs3zSJPwnNQiA==
X-Received: by 2002:a05:6402:274b:b0:423:fe73:95a0 with SMTP id z11-20020a056402274b00b00423fe7395a0mr14587786edd.224.1650812619186;
        Sun, 24 Apr 2022 08:03:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906071700b006e8a19cefa6sm2655165ejb.106.2022.04.24.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 08:03:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: timer: samsung,exynos4210-mct: define strict clock order
Date:   Sun, 24 Apr 2022 17:03:33 +0200
Message-Id: <20220424150333.75172-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS should always have fixed clock order, even if it comes with
clock-names property.  Drop the pattern to make the order strict.
Existing DTS already match this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 0e28d9bdb8cb..9c81d00b12e0 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -39,8 +39,8 @@ properties:
 
   clock-names:
     items:
-      - pattern: "^(fin_pll|mct)$"
-      - pattern: "^(fin_pll|mct)$"
+      - const: fin_pll
+      - const: mct
 
   reg:
     maxItems: 1
-- 
2.32.0

