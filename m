Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE5496C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiAVNPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:15:06 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49198
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbiAVNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:15:04 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A877940045
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642857303;
        bh=sq+GqGoHGm/8ryzGZ8Mwkyq3rI/NbpNjgK3K63Ee+P8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=bM6D4ueVZSs4micVd1HbbXDpXx8iPO4QeNglB/kaRoQdUTe4VlZ6WVl1X6J19v+zK
         FsFw257c1NRV0EBwUUU9FFIWmM2uVDMAIrrNpJxPiv3kQkaaF35i06P2O3LMbzHXfi
         gnBiuYMMkmEYwBBKacrs8Iy/tu9Io+OclDQX4NvY0k/0zdeHfuDXMgEWh2TEjMdOqT
         8EwQQ0R7v5UKGn6wCxOsXSW9pJFZV8g3sT/92/PEdMteWCiTWZc8uC9Cvm/m8MED5r
         ywhxf40yOlTyjbBu59ZXOM4wJCF6B1SgYFJuic9LfL30b3kuSkhf/GfGxbG8d4VEr7
         +ZdgoN/lLOPZQ==
Received: by mail-ej1-f72.google.com with SMTP id x16-20020a170906135000b006b5b4787023so943432ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sq+GqGoHGm/8ryzGZ8Mwkyq3rI/NbpNjgK3K63Ee+P8=;
        b=kbZtiuHyt0xp+BkXL2pBELxMpi4H3eMG9tPMC3Qx7tQQwzpAdWqk1BD4ll6O8pI4b5
         wYKGA6zoZ2EmgVxVFVKOTBHUf2KdykHG2KV6L/Rot5k0C3A9iSr7rlPvxOKWAwnaLkXB
         OCrqkF9tkFfPRNOK9E3VVKLMUqEz9gvDhd/OEyIMfdWYBSkiH+1bFxr6bQ5tTGOy1qJX
         I743XYpxs80/fZZsTSHxLcJTpu7tGtr6BQbbAFpJRo1I5FLp6DI5unYoj3KN5MR2TLbx
         DUXw7dIL2COZLlGBN1CHi/7eTxw/SNegMcDgha/a6bFO4d9q3iDh3Q8lqRzxkvJYMSKs
         HCzQ==
X-Gm-Message-State: AOAM533Di9VDjIYMkVp/FjQuPD5+GYWUzX/663ghyELMyFgMIaGt0l81
        gDKgETh4vNNLs0lp++okcg6fIthn+/d7ewFaBVmo6RRmDnS5jwazyq01ZY44z75crwtSMX/7ciQ
        56FjQY+vC5mNqGeoIdYN7coW3pqtVuYLvNTZWr79r5Q==
X-Received: by 2002:a05:6402:1d4d:: with SMTP id dz13mr8232527edb.80.1642857303217;
        Sat, 22 Jan 2022 05:15:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVyWY/MniL6pE8Qvx42ZDYAQcz+ygoyMbJ7Fg2vbPe6otymoWSlG8GropeNe8ENplv5ATIdA==
X-Received: by 2002:a05:6402:1d4d:: with SMTP id dz13mr8232515edb.80.1642857303023;
        Sat, 22 Jan 2022 05:15:03 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id k20sm2914823eja.14.2022.01.22.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 05:15:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: use define for TMU clock on Exynos4412
Date:   Sat, 22 Jan 2022 14:14:57 +0100
Message-Id: <20220122131457.63304-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace clock hard-coded number with a define from bindings.  No
functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d3802046c8b8..aa0b61b59970 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -813,7 +813,7 @@ &tmu {
 	interrupt-parent = <&combiner>;
 	interrupts = <2 4>;
 	reg = <0x100C0000 0x100>;
-	clocks = <&clock 383>;
+	clocks = <&clock CLK_TMU_APBIF>;
 	clock-names = "tmu_apbif";
 	status = "disabled";
 };
-- 
2.32.0

