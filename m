Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A11468DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLEXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbhLEXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:12:40 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC982C0613F8;
        Sun,  5 Dec 2021 15:09:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x15so35754767edv.1;
        Sun, 05 Dec 2021 15:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2739k7wp35e5f2PQpt6l2I9OnciPLMqTkMFXvBhNopE=;
        b=RdmWeYtvLtaEmuJFa3Ey+5VFSX+6wuzx5XGpoxG76XwQCc+4UA9esCOIkr7GwXTceh
         Eis5U1OsYqapLiOwjssjPB0Okf2YrLwUu2mzsw3IMC/tUQ3opyXR3vN/PjfKDSEpI3Yt
         tmnj9SUsEkHk/R6ioYgMVlcd7bMFbKoFPBDAQyAWohxXpU85BxN2wYAATEiphCGg5CU8
         ye3kvS/02KAKTg0pTxOZ3ORpsvy8Vp4r5XzdRTssNavPOvv1kOSLSnvj4LslPl5J4MHS
         STZzVJQZe8yIIT/H+rz93pBq8olPDAxkJDcac9wyyxkJNA1TOJRYy2m1TvtmPwTrROoG
         PydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2739k7wp35e5f2PQpt6l2I9OnciPLMqTkMFXvBhNopE=;
        b=LPe6VGuGMk0AiGQHHR5ZguwwOvdqnVh5lWvDfW7DkHQXDUzsyIcE7B1Gv17a/smU13
         X3HKp1zl9gs9c+6kdVa6dxHMacSVmJiOT1E7RmcY7PefYhndCBiN/dWqtqxpgSAA14SX
         VGFlPCbRfS+odUAgKNqyc+i/42ggaaDnQsc6aaqyM+63PeG/5eVExH6tTip11vUR6+Ys
         qApzvekG7hSibJrDQyv/jineCuB2AIm3nd34zzPuCwKBIX0RdIbx2q531W/RNhwxDuFA
         VOyt0C+jARb2r7C611OUkzi2udJXIwvdWONwePHLFHVjj6XwnxYqOMC8lDjCYZXP2rIM
         A9Cg==
X-Gm-Message-State: AOAM530OSvYs81HdbyxY+WmSx/PukvF804LCKW+sO5/nR7CamwZ/yK6d
        dIZelH6pPxfDdMVVWJWvqyI=
X-Google-Smtp-Source: ABdhPJwvj/4WHIKjKzr8ZOv9YIeuTEfQdtjdHtS6kdOwXTHatsYN5GFRcP5jO26mWU6UKKjdEkozog==
X-Received: by 2002:a50:d883:: with SMTP id p3mr48263373edj.94.1638745751390;
        Sun, 05 Dec 2021 15:09:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id co10sm6686569edb.83.2021.12.05.15.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:09:11 -0800 (PST)
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
Subject: [PATCH v3 3/7] dt-bindings: arm: samsung: document jackpotlte board binding
Date:   Mon,  6 Dec 2021 00:07:57 +0100
Message-Id: <20211205230804.202292-4-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205230804.202292-1-virag.david003@gmail.com>
References: <20211205230804.202292-1-virag.david003@gmail.com>
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

Changes in v3:
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

