Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8799547912A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhLQQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhLQQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:15:59 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B446CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:15:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn20so4125374ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lozW7GxWM/hgMQmsVnQbuh522f/jVKcFkLAm0cqTn1o=;
        b=r9cXOsQblzjc6ewE9l00CYiqf+T767vl2gLXA3XyBTwPf2WKv7ifRS1JVu5vYAM6IW
         FmsYFW+VvCfClHkhf4THZDhvSsRKQkQICSQej2fEisOJdci/NeYLAHTQe++zYs4lQpd2
         ZvNIrbfaf5A2jUtpG+IUaSb9dAi2hFMFdNZ4+8XaSMlMlawMQ1rcPjq3bf2TehoOei4n
         3/WdhDF7fw2GRtzZdTp0LWho2FxPQjy30gjSu/+7tmiTOyuLCGOYoz0E+PqF8KuDoQGV
         rQTfkXlbSmdhFYBZHSpjIfUtE/X64pl2AHvd5kplrQH74Jdu6WwKEHJN1T8Kicyt2S5f
         NRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lozW7GxWM/hgMQmsVnQbuh522f/jVKcFkLAm0cqTn1o=;
        b=Ys3NgEDJAhF/SfiSyWTRCdKkgBkOnbUKmxWp6yXeeBjot+nB4OPd2l4vKfmkokh8nC
         M6xR1Yt4O35E87zNRjKFIfp9CwvSFJVCimtrpGDcEf4YWFY8mV8H6URDBHhIdL2U48H+
         B/ryMxvMZrSjG8M5AyBxTsWox38citZoEe8Rv/dD2BvhvH6njxxzlxGEsYZ4NbKedgHb
         eePjfspmDVREVMCTZuFV1QAwWWZsfBgF8wd68QaVe7s+DFYOEmakNikWptsNNStaYL59
         nnvskUTr6hTy0VRMoV2mUU7K3OQdmKGxtzyPDx3ZKjywDf7cvUMzvNT3hOfEspjk/EXm
         iyxQ==
X-Gm-Message-State: AOAM533AVH2Hh9BTNzbhgWqfuxi4bxiQOr7IY6JBqWId9CykQQ9WMb+E
        716xEztTan0AgzNrNik16EKx/g==
X-Google-Smtp-Source: ABdhPJzlMt2w+xKuQB4LERlzLOFM8bOe6w7cYpxc2nTdKuq6Oj/Myef8Cqb3omSWrzIki1R8qm995g==
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr3369766ljn.354.1639757757038;
        Fri, 17 Dec 2021 08:15:57 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id l6sm41150lfg.47.2021.12.17.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:15:56 -0800 (PST)
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
Subject: [PATCH v4 4/7] dt-bindings: arm: samsung: Document E850-96 board binding
Date:   Fri, 17 Dec 2021 18:15:46 +0200
Message-Id: <20211217161549.24836-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217161549.24836-1-semen.protsenko@linaro.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the WinLink E850-96 board, which is based on Samsung
Exynos850 SoC.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

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

