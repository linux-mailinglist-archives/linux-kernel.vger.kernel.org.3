Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042C4824C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhLaQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:20:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46474
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhLaQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:20:15 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 96E923F044
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967614;
        bh=RokD/DGJrMlgd2E3s2EkgL7/9tvyF0Jd9JNsHnvOz7M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZY1yHrwBbNmmWOuGIN4KcdSQ3FBtJSHZFkW4Y8FEUDiqICqE6b3viH/gBOsyd5Kx7
         6XXa+7rb4R1plb0rJbf2XUq2QUhtNFQaUfwnFxZPza+c+y0OkL+zCOhJa7YFrrlVpn
         ZzZhQ5sz/bbV3vA0JzCSSQNXDBY399YLSZJUwEQiYq20EBc0m/G5AmbBiDUP8WNnU0
         d+izqebQ01fPN4/0jkAdEv4xSct+IvF62HRMyUEX5HB8lLOaaInqZ+2ewF8HEE0vOt
         n8Ku+7/yZfWW/Meue77XsScwZSj18DPyu7QECWpZBBktGki0BoqLRtSQdBfMbGp7AA
         +hWczIqlTegDQ==
Received: by mail-lj1-f197.google.com with SMTP id g20-20020a2eb5d4000000b0022e0a6d890dso2556741ljn.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RokD/DGJrMlgd2E3s2EkgL7/9tvyF0Jd9JNsHnvOz7M=;
        b=JFd1GGWllMvR26oGsO7xtwSK+Y/u7Ax7RSA0Ccwfa3zSuyACezQvWduFAxi2qDtlmU
         dLpNOiV5f0TbqTQLh3/X1aFrYXuAXuXTkd7inyXJOVKdt9/IPt4L9fjF7jR+t15tUvVB
         NbFwDJyL0W5H9UnMTqx5ZdgRQhSXLBNZHiMnALnnk+tuas7WlDSL7XlejMcrbbtpkVqB
         JRw99QljpogMcGPgKPef+P8dxYXDM+bZb9HDzHNvU/P4puvkVjmzPUfQPwI036x/1cGR
         Qjw8HOYfVjwzRg7KhAtOlRWHBMDvY6Fl/84KgaYGdjpR4KbI7uEzvXlUO96O6WWi9dBP
         mp5g==
X-Gm-Message-State: AOAM533uXJ6hnNGa6ADZcIIj1Hw5BGaUjHD7f2PS/s9CH0YxfnReBIAa
        tVDjMTa5/4aiCHfEOi7/B8484SmMg4aywJdxPFfYb/t8L8fm0p8xFvEqOMd2sJOl/JRKMUdzDLa
        6dAm5NiKrFUiziaQHFtxLPXJlsBiYpULBXm+24uDO6Q==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr32393592lfr.317.1640967613854;
        Fri, 31 Dec 2021 08:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwquDx4H3zk3uO8+LuXX9iCZ840MCSzCuuUfqQ90VmDyuUyAI+f89vfxZ/mSt/2j2z4jKlOqA==
X-Received: by 2002:ac2:4e11:: with SMTP id e17mr32393571lfr.317.1640967613658;
        Fri, 31 Dec 2021 08:20:13 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bx10sm2817607ljb.3.2021.12.31.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:20:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 00/24] pinctrl: dt-bindings: samsung: convert to dtschema
Date:   Fri, 31 Dec 2021 17:19:06 +0100
Message-Id: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependencies
============
1. Patch 2 ("pinctrl: samsung: accept GPIO bank nodes with a suffix") is
   necessary for DTS patches, so would be nice to apply it before this merge
   window.

2. Everything else is independent.

Best regards,
Krzysztof

Krzysztof Kozlowski (24):
  pinctrl: samsung: drop pin banks references on error paths
  pinctrl: samsung: accept GPIO bank nodes with a suffix
  ARM: dts: exynos: drop unused pinctrl defines in Exynos3250
  ARM: dts: exynos: simplify PMIC DVS pin configuration in Odroid XU
  ARM: dts: exynos: override pins by label in Peach Pit
  ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pit
  ARM: dts: exynos: override pins by label in Peach Pi
  ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pi
  ARM: dts: s3c64xx: drop unneeded pinctrl wake-up interrupt mapping
  ARM: dts: exynos: align pinctrl with dtschema in Exynos3250
  ARM: dts: exynos: align pinctrl with dtschema in Exynos4210
  ARM: dts: exynos: align pinctrl with dtschema in Exynos4412
  ARM: dts: exynos: align pinctrl with dtschema in Exynos5250
  ARM: dts: exynos: align pinctrl with dtschema in Exynos5260
  ARM: dts: exynos: align pinctrl with dtschema in Exynos5410
  ARM: dts: exynos: align pinctrl with dtschema in Exynos542x/5800
  arm64: dts: exynos: align pinctrl with dtschema in Exynos5433
  arm64: dts: exynos: align pinctrl with dtschema in Exynos7
  arm64: dts: exynos: align pinctrl with dtschema in Exynos850
  arm64: dts: exynos: align pinctrl with dtschema in ExynosAutov9
  ARM: dts: s3c24xx: align pinctrl with dtschema
  ARM: dts: s3c64xx: align pinctrl with dtschema
  ARM: dts: s5pv210: align pinctrl with dtschema
  dt-bindings: pinctrl: samsung: convert to dtschema

 .../pinctrl/samsung,pinctrl-gpio-bank.yaml    |  52 +++
 .../pinctrl/samsung,pinctrl-pins-cfg.yaml     |  81 ++++
 .../samsung,pinctrl-wakeup-interrupt.yaml     |  76 ++++
 .../bindings/pinctrl/samsung,pinctrl.yaml     | 381 +++++++++++++++++
 .../bindings/pinctrl/samsung-pinctrl.txt      | 383 ------------------
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi      |  10 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi     | 165 ++++----
 arch/arm/boot/dts/exynos4210-i9100.dts        |  30 +-
 arch/arm/boot/dts/exynos4210-origen.dts       |   2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi     | 226 +++++------
 arch/arm/boot/dts/exynos4210-smdkv310.dts     |   4 +-
 arch/arm/boot/dts/exynos4210-trats.dts        |   6 +-
 .../boot/dts/exynos4210-universal_c210.dts    |  12 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi   |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |   2 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  30 +-
 .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts      |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts       |   4 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi      |  44 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi     | 252 ++++++------
 arch/arm/boot/dts/exynos4412-smdk4412.dts     |   4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts      |   2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi     | 220 +++++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |   2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  22 +-
 arch/arm/boot/dts/exynos5250-snow-rev5.dts    |   2 +-
 arch/arm/boot/dts/exynos5250-snow.dts         |   2 +-
 arch/arm/boot/dts/exynos5250-spring.dts       |  20 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi     | 148 +++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts    |   2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts     |  22 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi     | 170 ++++----
 arch/arm/boot/dts/exynos5410-smdk5410.dts     |   4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  89 ++--
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 194 ++++-----
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   6 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   2 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi |   6 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  89 ++--
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi        |  60 +--
 arch/arm/boot/dts/s3c6410-mini6410.dts        |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi        | 210 +++++-----
 arch/arm/boot/dts/s3c64xx.dtsi                |  16 +-
 arch/arm/boot/dts/s5pv210-aquila.dts          |   2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi          |  40 +-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts     |  12 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts         |  16 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi        | 226 +++++------
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   | 211 +++++-----
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 259 ++++++------
 .../boot/dts/exynos/exynos7-espresso.dts      |   6 +-
 .../boot/dts/exynos/exynos7-pinctrl.dtsi      | 176 ++++----
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    |  52 +--
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi |  50 +--
 drivers/pinctrl/samsung/pinctrl-samsung.c     |  86 +++-
 59 files changed, 2212 insertions(+), 2000 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt

-- 
2.32.0

