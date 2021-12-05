Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD961468D9F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhLEWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbhLEWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:15:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF9C061751;
        Sun,  5 Dec 2021 14:12:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so34980006edd.9;
        Sun, 05 Dec 2021 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBcdqsk+/45KerpNcW9C51NhDflwIVG9MSn/OERq6xw=;
        b=UOxquxnmUW9ghH5u1oIfksR1mMcVEY4PzJnsVkDYnSeXhsXI2RWo6gww3rG0oRjIMy
         iKiWApPVjtLeam8aTL8Jt2VHh8oVQa2RAnxZzWkbzmvdWCzNUH21ShsZE/hL1y4804Xf
         0SA0++2srWh0b1ywtAKYxZGV/Q4SXeYADaBcaEbCicIVQ09RGYYpcNLwjZk28TFtjx/Z
         sJ9KkWXfqEODaE564wZtldrm9OH4s4HGGx60aLCl29QPaVHoCDMDy3TFMz8wN58f2jCu
         44U9tLn62nqtZhnY5NfbdM8486l3DYQGZmrziUGDuJRHmURS58764VDtI7xtj18UOBwK
         r5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBcdqsk+/45KerpNcW9C51NhDflwIVG9MSn/OERq6xw=;
        b=JKq3q5ZDI798FLJOiGpn32DvcCKBTu1DWm5apbp+GgDfQedUjyuBuRj2pA0mcmhwbe
         rAHuYFp2txWfWCycf6/l6+3AMgIUgrmVp4DoAataUWxSNKmMsG3a4PK2ZvS7PaLjxaDw
         k5VgCL5AEw5EJlRXxtiyFNHkR9KRJwiwAqQejI+HC2GoQ6TIlk1SXR+AhXNfL6xb5lSv
         UNLP/Kthuo6+LYtBj9QnHeAmvvaZ7Y8k3837YHbl3rMtnmV09HWx36oCYSk3sAAaqzqZ
         GXBxVE9Md0yJfE/WqAE/KJZPJ+ZhstvuhoKhlFDNpJIjc02h5d1gNj6R9VZdJ0fzWXW3
         3R5Q==
X-Gm-Message-State: AOAM531NZld12aC0b7AKbjTV4EiHJCA6G30DcJGzVfl6I/1sRn9SK50d
        AYR/OSpApldHB9vCXbnNRV4=
X-Google-Smtp-Source: ABdhPJyycc1aHkOwd9r4L9fLQouHNmLB9AX1qV8RulYKZcHqoE2y5QUk5MZ/+k04f/hglbBMpKb+Nw==
X-Received: by 2002:aa7:c347:: with SMTP id j7mr48696293edr.272.1638742350425;
        Sun, 05 Dec 2021 14:12:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id gb18sm5608079ejc.95.2021.12.05.14.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:12:30 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: arm: samsung: document jackpotlte board binding
Date:   Sun,  5 Dec 2021 23:11:02 +0100
Message-Id: <20211205221108.193400-4-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205221108.193400-1-virag.david003@gmail.com>
References: <20211205221108.193400-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the jackpotlte board (Samsung Galaxy A8 (2018)).

Signed-off-by: David Virag <virag.david003@gmail.com>
---
Changes in v2:
  - Nothing

 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index ef6dc14be4b5..d88571202713 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -199,6 +199,12 @@ properties:
               - samsung,exynos7-espresso        # Samsung Exynos7 Espresso
           - const: samsung,exynos7
 
+      - description: Exynos7885 based boards
+        items:
+          - enum:
+              - samsung,jackpotlte              # Samsung Galaxy A8 (2018)
+          - const: samsung,exynos7885
+
       - description: Exynos Auto v9 based boards
         items:
           - enum:
-- 
2.34.1

