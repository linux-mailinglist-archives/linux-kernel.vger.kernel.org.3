Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70547821E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhLQBaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhLQBaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:30:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF5C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so1449611lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QM6f47ayHPQt/5IdQ/xMhOSTbh2OemqUyIwCi0r5BpE=;
        b=RgsTKdDzcBwtCxrfX4AqOv4ybgC5se3ZM3CHliwW1pHlvEb0unBiII0kD9nverEGEt
         ykPgkVB+/pv4Iqo4VnrSRcDgwzQxTAGEuJ0F72dyeOdDOO93m6gv7rtw5Fq3nlh6t6EY
         Io1ctoYvxa6g0Qpc503Nba7FwkZqYjzLz4feCNRbDaNgUjiIPWcu2tUySFXf3VTqELWu
         waw8aEu85sjfGpPzL5vfyo2E3j5fGdeD9UGvSwv9wxWSaY/oLsdX0whOAARl2MZOI/ja
         VgyKBPnm1X7S+3ykhovCSA4qrarozdv1WH6iWws62xLkIUNV0S5eqHQGP4FIp14myWDA
         RsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QM6f47ayHPQt/5IdQ/xMhOSTbh2OemqUyIwCi0r5BpE=;
        b=yD4ucdlvs9knjjscxvrUURtt0CeGBCV1M7ayOB8cVV8S+rHbcAz/ojr5k6GomkiwKN
         XRjTuST3q4jDUxkiqFWEWjO2/fKBRJLU5JXIvlD+rtgxROnLbDpgZ7Q9mbk2KoXl959e
         W/l2se1cRbhPWGaYrdf+5RAZvaqfup8wMUIrwDNb6TF5IPfn4C8vL6xw5xmPbVn03gEk
         FvJ6O7CT/t54JcgKGtcfsc8MttUOq4K+lFfOMpbEPTq8b0QqvCDZjBg9Mg3/7aUlAnjL
         7XjfD7hEvBjx55vgii0tJl3JdKt2vlYdVLl/ifBjQbuDTAxO8lhCpSk+i84TDAH63V3d
         8yOw==
X-Gm-Message-State: AOAM533Is+lEoQIsTFjKvgyG3ZGWNRGvb/Ve1Hw+BSIfLY6a2ygZa/LX
        vsqGALO4jTT5scri4KSBtfZ2nQ==
X-Google-Smtp-Source: ABdhPJzjUfwEoYesZqEjPi0VMxKoi6uMmfpS1eDv461HjtDZO3NaH9w7JiiomyHszxF5NgDgY6xQuQ==
X-Received: by 2002:ac2:5930:: with SMTP id v16mr748999lfi.327.1639704612792;
        Thu, 16 Dec 2021 17:30:12 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z8sm1132468lfu.128.2021.12.16.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:30:12 -0800 (PST)
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
Subject: [PATCH v2 4/7] dt-bindings: arm: samsung: Document E850-96 board binding
Date:   Fri, 17 Dec 2021 03:30:02 +0200
Message-Id: <20211217013005.16646-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217013005.16646-1-semen.protsenko@linaro.org>
References: <20211217013005.16646-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the WinLink E850-96 board, which is based on Samsung
Exynos850 SoC.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Moved Exynos850/E850-96 binding before Exynos Auto V9 entry
  - Rebased on krzk/linux.git (for-next), to account for Exynos7885
    changes

 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index d88571202713..052cd94113d4 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -205,6 +205,12 @@ properties:
               - samsung,jackpotlte              # Samsung Galaxy A8 (2018)
           - const: samsung,exynos7885
 
+      - description: Exynos850 based boards
+        items:
+          - enum:
+              - winlink,e850-96                 # WinLink E850-96
+          - const: samsung,exynos850
+
       - description: Exynos Auto v9 based boards
         items:
           - enum:
-- 
2.30.2

