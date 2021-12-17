Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2C478253
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhLQBq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhLQBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:46:24 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18CAC06175C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:22 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id l7so973401lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VcLGSgV6/NSps52EShuns7K7yBcmStDgIhJiXXEDqLA=;
        b=DmYHqFLGBjjHzA36/wA8dhtzvkCIhDKoDDxGNC54ODGq9kbmNcLc7uhhsKwca3WzhQ
         9UVcNINeXxYsC/C/126muLfE0kPsd0wmyCrgbpNRwKolaO7CYhkJAKQ8C8aeE+F8YNk2
         mdJZoeeI7GYYTLFE6L9wwBUxLRp3d5DjG6XVhAIGyBRIhiaydpgYPpAiIkD8FYSHKPIC
         VNk3SQF0w140bS+TeG1qxtLVt4DXb386Xak3YJ75YV0vmnWN7Ezjkh82YOFMp3zhzqSz
         J1G/z5S6HTMt4XGpqoRGq3kvbiTjRdGN+pSaAEtVL4piPljsMdUbgWK10o+siLsCZpBD
         dt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcLGSgV6/NSps52EShuns7K7yBcmStDgIhJiXXEDqLA=;
        b=i1NGJufbVFF1NOK1ZRw3sfxXijn5cCAdbdtaP2pjX2hYSn/sW3w+6OdgnRdn0WhNgN
         XqC58G2Jpcfz2L7L1HP6TbDhau6ZgtB56TbTZQK5O33ZItR8+DYkalh8NIKTpj/C37JI
         G8Db8HR1DbdZ5X5DtMyyzx30Jm953WWIh2vVjZ1FXRjPPuX01w03qx93c2yrCuiR0ElQ
         Vw2clJUK46Xv9oRhggmgAB0pB6uW/D+Utw6GMvJfsZIlmE5D6/KxIq0l4ESmy7VTMHGB
         sCUpserDDLSuevyBVaszdJCCr37+pmSMlTq5uaKRYaYHP1jBe5O7xhbrRWtvRr33z7YT
         /Akw==
X-Gm-Message-State: AOAM5327oWhpV8EytVI8+ZQl5RIqB0Dx9WWlRni5AP1s2p57RGBk6ZQR
        LHpBJBR4HhRBRp+7vp61FnyXsw==
X-Google-Smtp-Source: ABdhPJzq55H+PxOli9A5MPidjCbrvGksaEn8lXcFujTLV0gKbSPpqogVMOILGkXbr9q/jnnGd/+JgQ==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr742594ljg.13.1639705581030;
        Thu, 16 Dec 2021 17:46:21 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m9sm1428853ljp.79.2021.12.16.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:46:20 -0800 (PST)
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
Subject: [PATCH v3 4/7] dt-bindings: arm: samsung: Document E850-96 board binding
Date:   Fri, 17 Dec 2021 03:46:10 +0200
Message-Id: <20211217014613.15203-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217014613.15203-1-semen.protsenko@linaro.org>
References: <20211217014613.15203-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the WinLink E850-96 board, which is based on Samsung
Exynos850 SoC.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

