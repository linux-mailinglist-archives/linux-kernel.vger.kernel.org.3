Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84B496C86
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiAVN0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:26:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44444
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbiAVN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:26:02 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC25A3F1CA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642857960;
        bh=8fMesucJS/Q/CHcDtWavokH1YLXI1OKktuJiUdUDTLs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GFwiiVlvJDuXIgHLpov9RN5ZZHXnXsLy1H6UGg5Ogne+c36chhV/YYe/d2g6GIsl0
         Nx3XtK+ZV8g2wRr4VrqnE4kZoock8wwVJVhzTC4PGyDnjPIjams7o0lou4klDDBab2
         JnsS56iURSxCttm9O5EO7S7uYN+NvFN7pGJd8ApP55XmTrlFLmqFWa5NVYr3omCQkA
         +1P8ORGzgqYj7sz+fGSDlZy9gelX5n30J4i7TzKCcn2osguKFsXSzBuux3kWKesJBD
         3sf7wF//KbGvGF3aFysWIFTXjSg0TSvrXTzik4h8PP/9cKy3W3Au4TvdKgmTpUDOba
         7l/xWjnIjseFA==
Received: by mail-ej1-f69.google.com with SMTP id rl11-20020a170907216b00b006b73a611c1aso252542ejb.22
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 05:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fMesucJS/Q/CHcDtWavokH1YLXI1OKktuJiUdUDTLs=;
        b=z7mBn0XUSZcEx/06FNH7RqGS5Yy0T7FrTtoOI04JuuI4eYHlF8Z5As/NcjuBJSXERL
         nmZuVb6EnD0jEmGa+qiHtH2knOTwurj6egI7fS+uWtcRJHAg0do7ietJGMazljJQ1o4V
         hYQNR8csvgwoHnLRWZ4YnnIeWUdXMq5/dI+NCbDxSGRY4X7ZBtlXUEqag7p+mUnCo5Lj
         sQrF308fpQdukVXq4BHc3D1ll8/DsqNh9iBmPlO2cRJNG1SVr5EoV4t8AvnSFnN7DMie
         YHOm5X9/pB+xINBku3mP7E1a9lM4GkXRBhHVcqvcMfJcRydRKjF7jmlNtjuaHbg04nxU
         RjhA==
X-Gm-Message-State: AOAM531HMc6e7ld0FsClkDHA+Fo0EktPZFaUOPoV/mncWiwhCR9goSux
        /J75sFlnm/HC8VnCFDsA6KlXrdCh4vBTLTOMUTJRUGz63MgnmPxsvzzCLrzNgYw7RErWCsE2dND
        ceNp9ff9KT/pwXNZteI9n+CcswAPtK2bvCSWU8YmBOw==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr6700216ejc.493.1642857958502;
        Sat, 22 Jan 2022 05:25:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNLq+wl/T1aIhyqPK0PgngG1nTaJ+rpaL0m5ALl8KOG7N8L+TA5ORWK4t1DsKSjwTs3nbw4w==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr6700198ejc.493.1642857958277;
        Sat, 22 Jan 2022 05:25:58 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v2sm2373060ejb.114.2022.01.22.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 05:25:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
Date:   Sat, 22 Jan 2022 14:25:52 +0100
Message-Id: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
Exynos Thermal Management Unit driver are not used since April 2018.
They were removed with commit fccfe0993b5d ("thermal: exynos: remove
parsing of samsung,tmu_gain property") and commit 61020d189dbc
("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
property"), so drop them also from Exynos4210 DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

I'll take this patch via Samsung SoC. Adding here for reference, so
Rob's robot will not spot DTS issues when checking against dtschema.
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7e7d65ce6585..2c25cc37934e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -527,8 +527,6 @@ &tmu {
 	compatible = "samsung,exynos4210-tmu";
 	clocks = <&clock CLK_TMU_APBIF>;
 	clock-names = "tmu_apbif";
-	samsung,tmu_gain = <15>;
-	samsung,tmu_reference_voltage = <7>;
 };
 
 #include "exynos4210-pinctrl.dtsi"
-- 
2.32.0

