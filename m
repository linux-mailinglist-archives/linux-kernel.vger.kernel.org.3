Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710B4A3120
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352884AbiA2Rxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:53:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36122
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352761AbiA2Rxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:38 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC2CC3F339
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478817;
        bh=bgWRA4jagXRIZ+87s8E1TzK9o6vneJUF41jOIzkhmn8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ONUwmfMYgmOjJVpFEl9qHLSdNgi4Jz1EKCz3is9zKeUxa4HpRH1mBUEhuievkYB8D
         t9NDsaWiRorcFKmgtjuiZOvLDIMgKBFrLoaak4lMKCgQtJn/x9O0wOOIbJ2O8/d2qs
         3/Fl68pdtFfkqeFeXEn8aq+Dx92u8cZyqlJpOhyYOjpHcbvwe9oxSNJP4QAB11lfEe
         ySFMSnd025lycLsduu3T6Pz7HS6mcrzptnyRHcX4zalDopHBsi1aV/ipsVDdlNVaYV
         qscHHTePSfgl+rxqVxJvUep1MM//4MChXKZNKt8OEElu/p4iG/vdyVuxdtUzhG4rQy
         D5+HyVgNFqBoA==
Received: by mail-ed1-f70.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso4686585edi.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgWRA4jagXRIZ+87s8E1TzK9o6vneJUF41jOIzkhmn8=;
        b=jAqO1Zo/QPiyNgY9w/ZIa5It/MTJ1HPAWOLoozvPPiw/beb5mLismdhIHPkb+d9SMQ
         7gUafU7Ey/+YO3/7HcbYsPNk/c2w+/ds85Je6X79KxADucsRPY9QJybmOzTTNyd7CJ3E
         y8WOrMz04e3Qv3Bp16196F4ZB7z28BJqQTJ7l7qRRmSGXjMqh+2EMf5MxdGFYlteo+vQ
         iIpcV5pRpcJ5ua42WM1PObRuZY+zf0BqayfiX+nWJ/MhWGj1wmYnGkoEIOct7mh7xBdH
         OuLs2Qad+jUtfc1OdyeG7cQm9bNrbKjqRMFHQjBeI0aILd793b/1u27t3XR2RfjmGFD7
         Sq/A==
X-Gm-Message-State: AOAM532CJ8RG32yDggwZhRBxW1jXRCvl09ooMHgkeg4OP6MxHVoRZyEA
        ED9/IRPClaMDLDnuQSq/dHXssNeYN4fonjLZ9CLLuoteDBqJsT0WOlf1NhQDZZDgCvAQyyAnxEf
        tYdOBP/xNsXdkYNfinibW0bHFfil4xm++2PWAf4jlzw==
X-Received: by 2002:a17:907:9726:: with SMTP id jg38mr3651951ejc.384.1643478816581;
        Sat, 29 Jan 2022 09:53:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaBAqEWxBwVQz5SVpuSS2UhkhrR1UFQZFLootOZ1zlNqZ0WYYIUdusgJTZcK3C6ZgqYdhF9A==
X-Received: by 2002:a17:907:9726:: with SMTP id jg38mr3651939ejc.384.1643478816415;
        Sat, 29 Jan 2022 09:53:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: exynos: drop unneeded syscon phandle in Exynos5433 LPASS
Date:   Sat, 29 Jan 2022 18:53:29 +0100
Message-Id: <20220129175332.298666-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5433 LPASS audio node does not use syscon phandle since commit
addebf1588ab ("mfd: exynos-lpass: Remove pad retention control").  It
was also dropped from bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index b4cde77e02d3..661567d2dd7a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1885,7 +1885,6 @@ audio-subsystem@11400000 {
 			reg = <0x11400000 0x100>, <0x11500000 0x08>;
 			clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
 			clock-names = "sfr0_ctrl";
-			samsung,pmu-syscon = <&pmu_system_controller>;
 			power-domains = <&pd_aud>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.32.0

