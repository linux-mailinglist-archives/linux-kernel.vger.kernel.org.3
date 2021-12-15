Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61279475CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbhLOQJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhLOQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:09:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD1C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so16323079wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz9umB5IGIToqYZftMBO3IU3Cs19TgfRkZ7uiNPvoRw=;
        b=Lckz/WAa0xszZdKca065FH4mciLh/lYpayGiAm3jCEqUBANW+FM5KouHbtkuh9xUZi
         wc2OyvBCIn6/4n3DOEjw1QgJPxDyngupSYwQKM4N+KuBUV5GTUoVZUdOQUlqJ/UeaY90
         aWQDdTZxYyWTfIVpsbJOBv81+jjlmae6J5VzEHaUYvFwpq+6OlE1wQNopYOmLbGN3wDk
         1oU8cvmfiDR8XLBOuyV6LFBavUi2Y8WARzAbj1AbfuBovQoQ+OSDkYxU/aUZ0DNqo4Qv
         og2PXuI5ykIrXEozOAfw06I3+RTM7P4k6q8zqtb6yi/1J3JcIpOTA5z9RC8whXF7Ge42
         lJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dz9umB5IGIToqYZftMBO3IU3Cs19TgfRkZ7uiNPvoRw=;
        b=kUyjqbxgTZO9hFF1inbN+dL0Y74Z7xUdDraSM1/XxSa1lmXFe49XH3dJDgAuqz7saS
         3AEaRfWYiw6PRXXJ24yWDPk1y6zsp3VLUo+H3a1ebP9N9OVp20foDojds8a1idoY/Oy9
         27IM40gTwqSPoqg3Uf8COT6+aqXcL/itc6MdAgxutIzdiijykKByeoWwhtjY0zGC/MM/
         3gxhBjlikHc139YDvLLvJ8Sdy9kEjwxdAONRUgxkXVtVO9gZgZS9ZMdzZKIqf2PqtEgN
         HQWKHN6ByfQ464+lB+E5qabHWlDHawbJlTXYC7CGa20o/EXGGBcur6j9PktMFvR4k5eu
         DnXg==
X-Gm-Message-State: AOAM533EoweRH8G7LIPiq9Ym5BRpAiPgGfFn5AntCRn/CxDkKqYIm2X7
        dUbiQ2RE98Sm+L8lbPsnEdrhsQ==
X-Google-Smtp-Source: ABdhPJwyEiH0fomN/E3toR4LTUG8ouZsXe50NaVQvsh+mAJZehnftHhVnF2WZv6uA4D3FjmVmvUPZQ==
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr547905wmj.52.1639584553539;
        Wed, 15 Dec 2021 08:09:13 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j14sm1859285wrn.88.2021.12.15.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:09:13 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: arm: samsung: Document E850-96 board binding
Date:   Wed, 15 Dec 2021 18:09:03 +0200
Message-Id: <20211215160906.17451-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215160906.17451-1-semen.protsenko@linaro.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the WinLink E850-96 board, which is based on Samsung
Exynos850 SoC.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index ef6dc14be4b5..00f122197476 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -205,6 +205,12 @@ properties:
               - samsung,exynosautov9-sadk   # Samsung Exynos Auto v9 SADK
           - const: samsung,exynosautov9
 
+      - description: Exynos850 based boards
+        items:
+          - enum:
+              - winlink,e850-96                 # WinLink E850-96
+          - const: samsung,exynos850
+
 required:
   - compatible
 
-- 
2.30.2

