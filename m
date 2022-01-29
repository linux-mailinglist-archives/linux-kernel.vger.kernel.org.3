Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF44A31A4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353126AbiA2Th0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:26 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60274
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353080AbiA2ThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:12 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A308340048
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485015;
        bh=XuPLAqAJ9YY2uh5AhVfTrXkOsUrsAC204eUS2kAaJyU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Y2uLP/Yl2zL6bTTctHi7wAAp/Uk2FJePeDaikYOYEazxdtIjhafuaZ9Lv8t8MP+3d
         a34dyOwMw6MwCLFpATwWM7g8HyQH7vrIpp8Su1Q7/7jgDXODnUz7asEIyEv99RYeNi
         /DbdLn3Fdm2Mr/b9378kh3uwRSqNgtuQsNxgeZI6sWI6gWQbehIMGjLOQdTNatadFa
         0o+EpT4PD7anZpabDB9+ve9rIYW1OiiR6JbNRf+D579ynrokRb3zioymctO46DDXR4
         /7THT0RWrimMUVe7UAJs2z4yR0nVZkzw8hP/aj1sS7fCwkKY/luxejPG5X9ZYEjg0F
         9iU+LToJFRx4Q==
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so4786949edb.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XuPLAqAJ9YY2uh5AhVfTrXkOsUrsAC204eUS2kAaJyU=;
        b=eYM3hYcB5r+YOATI382x+cidz/4gFPjEPpcda7y2VYuYgK9JrHqhi8yKXMrAze1TRN
         +3FcuCn5Ivwtdt3JGoDKPfVAAcFm2a8wq7fI4Lu/oIMBZ83t2XwmUSxSA46PPjeP6U5Z
         aFns/mrJA1j0/C9ZwW9Us5FLw3ZeJX9KGUMoLpafWx94Je0FPcHwqCE90fgRBc+eDTni
         6vee+6nHsNpzQAeHZnk6zwZrLonFVdJ+FI/OEvNcYlV8SvfPeZpon2dvwIkTK4mIdebH
         yymuHVkTkX9pk7EWuqismrv7VMgJK7YsSUNhFepDhVGxwqBz4VMQ0R5VY9S4NC6Ts4Tn
         Z5XQ==
X-Gm-Message-State: AOAM531AfkVqQ3W0HKsZ5uuHYlZv/iyq391bws38knI7OEtMwiCJ2Hma
        IfgiGVcs+kRATeuV6JeQhHq1+JJ9HEXSqmsNziKIS8WzAVaRhPVSzRsNaSaEY+QDyor3KNkpg2X
        xwQcH4KoGxyllKxGFXXc4O5X0wQ+Xiro9qcT5YD9FQQ==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr13885347edw.293.1643485009962;
        Sat, 29 Jan 2022 11:36:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkRER9zOkkAySGx0C0YpNLKKRr5Djve4lerBLmDsvqlQap4YIrDFg+B4EOx7UpKxurUyVhXg==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr13885341edw.293.1643485009830;
        Sat, 29 Jan 2022 11:36:49 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/8] arm64: dts: exynos: adjust USB DRD clocks with dtschema in Exynos7
Date:   Sat, 29 Jan 2022 20:36:39 +0100
Message-Id: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same order of USB 3.0 DRD controller clocks as in Exynos5433.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 3364b09c3158..e38bb02a2152 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -684,11 +684,10 @@ usbdrd_phy: phy@15500000 {
 			reg = <0x15500000 0x100>;
 			clocks = <&clock_fsys0 ACLK_USBDRD300>,
 			       <&clock_fsys0 OSCCLK_PHY_CLKOUT_USB30_PHY>,
-			       <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER>,
 			       <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PHYCLK_USER>,
+			       <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER>,
 			       <&clock_fsys0 SCLK_USBDRD300_REFCLK>;
-			clock-names = "phy", "ref", "phy_pipe",
-				"phy_utmi", "itp";
+			clock-names = "phy", "ref", "phy_utmi", "phy_pipe", "itp";
 			samsung,pmu-syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
 		};
-- 
2.32.0

