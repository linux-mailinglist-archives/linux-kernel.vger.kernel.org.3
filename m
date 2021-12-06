Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4146A002
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442897AbhLFP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390787AbhLFPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85252C07E5E3;
        Mon,  6 Dec 2021 07:32:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so44277607eda.12;
        Mon, 06 Dec 2021 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4TkEoi0AihbG2VpDaDF3HniM6xDXUj46TSgW3UMkbs=;
        b=cFfaVEt+gm9AiFmdegia5qcNEQfrKy7lm/GikjO514YcydZqMaIsGxjKEIKuSe1Uja
         8LObRrt1I/9pEI4kZxyswyRnBlDnrOlAAjEMtIRF7HYgEE+5MHsSBx4Dvlaw/vN0ZIHJ
         g8keqCVou/q64Mtc2qkZCdsjVrHJ3tuVl3Gr4MhspLYOjhjtsYm6FBS47cNAKmt5rFDT
         wUARhuWm1Y6QE8tTV8Dqs9MxnOW8meN6DRD+R+Pt9h48o67/elWsSBERS+mf3101vqe0
         WbFjRZ4o723Dxcub7v8Xff3IorMCWm0bpqevGOcB5V4o16L+0SPBF4hdNfCYEv2LaKhb
         5DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4TkEoi0AihbG2VpDaDF3HniM6xDXUj46TSgW3UMkbs=;
        b=sEd8nzhcySVgQKKPyWsqqUmjxzLEL7PPxG3izT6rp1jOzkXV9x0UzYbz8Ba1QXoDhR
         EIQyBb5YCSjM2zGk2njTNKMQrxo9CPF9QpqnZEdjoaDhu7wjwfcRIKqZhpyyIqx1GhVM
         j5WgLSASdz9kV9lQ8dd8M9E6i/LtCyMLHXwiTWJjeKbs2f8YHJvy0FVQhkhMEgSj8OIx
         hAOV21oZmmKHfKRoYYIxg4aaTtyA8sGW4EXIBUXPz69RWfTeyMnjGDc3wn8zhorsNicx
         vSW2pQ5fObwRvOD4LRP6KFsdcL9hgcXWLyJRp/KF9YHkGidKgQ5/3sveD2Q/IlnOD1+b
         hGYA==
X-Gm-Message-State: AOAM533QrYYh5VrmEzvfA9eg4uOyn7UshOCg9K9r/xt3stOlOS3NUqsE
        +6PVPUihtYS6goRG+ZnFrmo=
X-Google-Smtp-Source: ABdhPJxHng3wYY3SUeJ6F5E9y+CDHD7CL5TzL+3GArJJw4MpQfu11NdV8ryBtqDsYxMibTHfdoA4Zw==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr45856370ejc.248.1638804751148;
        Mon, 06 Dec 2021 07:32:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id d19sm7364688edt.34.2021.12.06.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:32:30 -0800 (PST)
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
Subject: [PATCH v4 3/7] dt-bindings: arm: samsung: document jackpotlte board binding
Date:   Mon,  6 Dec 2021 16:31:17 +0100
Message-Id: <20211206153124.427102-4-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206153124.427102-1-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
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

Changes in v4:
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

