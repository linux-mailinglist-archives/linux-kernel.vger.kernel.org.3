Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFC47A917
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhLTLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:55:40 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34726
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232119AbhLTLzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:55:36 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA61C3FFDD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640001335;
        bh=Cu4+11DOXZRrdhilEoPCVYJODFzNISiCGs5MUOme0+k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gWbccULEuHjPvE0f3+Ss/T97vrALZs+Aj3U08m9RRdVT1MtLsWX6ZpqrqIoyLtf3V
         c1uYVR7iSX4jPV8c2lFnAmj0bpYw6H0rnw8liRkyxkN+z+xLLz6I+9Bfsg8VWNd7aJ
         TEHI7RZYw5nu5wB7PZMbOo9bsgyo6VdqD5BkLtw7t9fxvVRHRluW1ZcYj8AAZ4m661
         0kFglbx9AwBDk7v9NM+oKzBI+kkQcTLJImzvBDj5o5QpKW2byE5pLDxQkYtb4OlqGM
         z9lDwsq+Ji5F0v5diDP3GCxByDCaJk4o8uftm79COg1W9c++sWFxi0ZE1mDbXBcqEC
         v5vD/CP3i+TNA==
Received: by mail-lf1-f72.google.com with SMTP id g2-20020a19e042000000b00425cfac0e67so1237321lfj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cu4+11DOXZRrdhilEoPCVYJODFzNISiCGs5MUOme0+k=;
        b=EiiSve+hxk3AuTlIhi1Y99eJIqsQ4DzamLWBTxURK9D1FY+q0NMv+TjIXr4HI7o8ve
         EUZC6PIUnIV94+MPzyxDP9VUK3yPHY6yZeGAd3IsrnuQ0XxlG+Ag2IG3/rjrzkQaygEC
         Xi5P5Gv+rnOgm5YWtM2I3Cds58V7ywHg5NReghEtQ9iypgOEZ8alWz0Tzs/L7Af71K07
         PT9I9oCC97QCXvSZUYlwg620bd2IXoJQOmfu9HZb/gshmEcOCfj9dqqeIQR+9URFKqwF
         ISrQJEj8LgmDxZdfXUDcmZdnDaXn+fhcJhcugKIMNXins3JfM4vHQ3RUque3ISU23dH2
         2/Aw==
X-Gm-Message-State: AOAM530OxKJYL0VEWDUbrOJxFjQRgcC1EENlrO3sNFFj/vEaUZ5P4Wfi
        E3DViI+a7m8hzaF5mYq8jjrv1hsTEE4fXG4Pp4ef4HpI2VMDU/E8p14IemXrnhc/bSqw6EUfguK
        okpm9VmwOpj4wlFXXov5SM8htawPx/3ja6367foI+BQ==
X-Received: by 2002:a2e:97cb:: with SMTP id m11mr14450441ljj.324.1640001335171;
        Mon, 20 Dec 2021 03:55:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGhcJV5zeGlTyPSC5Du9hpwQvZ9l7m0zQ8PCOvgtcgSgSX7pPLOaZ60p72RxVXeQ9BYz4bew==
X-Received: by 2002:a2e:97cb:: with SMTP id m11mr14450429ljj.324.1640001334960;
        Mon, 20 Dec 2021 03:55:34 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id n2sm2523746ljq.30.2021.12.20.03.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:55:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/6] arm64: dts: samsung: for v5.17
Date:   Mon, 20 Dec 2021 12:55:27 +0100
Message-Id: <20211220115530.30961-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220115405.30434-1-krzysztof.kozlowski@canonical.com>
References: <20211220115405.30434-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17

for you to fetch changes up to 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:

  dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.17

1. Add bindings for: Exynos USI, Samsung Galaxy A8 (2018) board, WinLink
   E850-96 board and WinLink vendor prefix.
2. Add pinctrl definitions used for Exynos850.
3. Minor fixes and improvements.
4. Convert serial on ExynosAutov9 to new hierarchy where serial is part
   of USI node.

----------------------------------------------------------------
Chanho Park (1):
      arm64: dts: exynos: convert serial_0 to USI on ExynosAutov9

David Virag (1):
      dt-bindings: arm: samsung: document jackpotlte board binding

Krzysztof Kozlowski (1):
      Merge branch 'for-v5.17/dt-usi' into next/dt64

Sam Protsenko (6):
      arm64: dts: exynos: Rename hsi2c nodes to i2c for Exynos5433 and Exynos7
      dt-bindings: soc: samsung: Add Exynos USI bindings
      dt-bindings: soc: samsung: Fix I2C clocks order in USI binding example
      dt-bindings: Add vendor prefix for WinLink
      dt-bindings: arm: samsung: Document E850-96 board binding
      dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850

 .../bindings/arm/samsung/samsung-boards.yaml       |  12 ++
 .../bindings/soc/samsung/exynos-usi.yaml           | 159 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  24 ++--
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  24 ++--
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts   |   4 +
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |  36 +++--
 include/dt-bindings/pinctrl/samsung.h              |  13 +-
 include/dt-bindings/soc/samsung,exynos-usi.h       |  17 +++
 9 files changed, 258 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
