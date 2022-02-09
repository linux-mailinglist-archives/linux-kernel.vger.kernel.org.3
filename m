Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD57B4AF473
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiBIOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiBIOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:53:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B7C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:53:07 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AA283F1C6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644418385;
        bh=onzsmpCQRgb85GIJjW98hJcEB7Fnm+j4zs7gFVVnUu8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=JaFAH+Mn5pDX92vHW8fwNIhHUnZ9frHiekxLfZ7+BGwjpdNaN08PVcZGP6gpUh9th
         Zh0N0D3k6Exz5CrVNsTiAoHMz8HZZawZRJs4aRqHKGE1Vuhoos6vEnDU5yhXPLYMQD
         PJHqba3sxMsKI0AHMFPL45t40iXr3s+zg8NfEot1rX2CNS1gcSZvPo6bHJtULXJGAC
         73bSv5HoxnxozR7cmvil2d7SStePgdxoKvzErBxZs9pdbkfDCsDse5irtXsBGWcBpO
         cieY9tbmMhzCCFWmMc7GGATiwkU38gYuSYEnVPJag5zYW7YF+x7efdFCSFA8OuPnzK
         NkD+cgYo7heig==
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so1317557ejf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onzsmpCQRgb85GIJjW98hJcEB7Fnm+j4zs7gFVVnUu8=;
        b=QdcXjZ11QE5k7AxtUJpQ5wkvXMEf83IJU8xL6r0IYsT4PxsQa3GcYtSQAnRkOS9mYl
         pOVihC7VsKZNRELFOcWYDBWFhySquKMv5e3rpcweL8M9Vxe4X+M/zSNbaGbmVAUpI7E+
         A/WB6tpyeNXK5UibW/1FvKUqHXFFHeAu9v8ZiNZtUlwPT9ZgVPkYw0/auNuRH8LxcmPw
         KSB4oezTVKDynTVlcblkGHUhMnX0V8XmvJ2y8YfudCeAWE3nGe+pZpAK8LqN5YR7cyuQ
         v84/HxPN7be0q1Z5Q4GVKzM+ANKBkvQKq5VKRIpB5SViU51HaZbxQk8MMGols9/lYh7i
         +rgA==
X-Gm-Message-State: AOAM530d0sNC3zjXAh+NYC7JenOPRYBtd/A1oVJQ1C/HBbHPNy7/Ejo1
        GdENP5BzmrYThrl0Fpjzzjcmn9qaIWLuAw/zp++ve9Pzqe7GuXFJSf+gHrtKsQSfNh2IT2eXo5E
        ZUm8VzZI7m3Ar0mKgAU9mBTbBi5zr1wCKdd3yFLw8MA==
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr2283078ejc.493.1644418385015;
        Wed, 09 Feb 2022 06:53:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA9pA2uua5qmpzfkk8gPsTc68MfUtN9mYGVJc0g6plaESL7cEnVm/8ZAMV0jkvQ/RQWXCVgg==
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr2283068ejc.493.1644418384761;
        Wed, 09 Feb 2022 06:53:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f18sm2839309ejl.12.2022.02.09.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:53:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] ARM: dts: samsung: dts for v5.18
Date:   Wed,  9 Feb 2022 15:52:25 +0100
Message-Id: <20220209145226.184375-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

New platforms and a lot of dtschema cleanups.

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.18

for you to fetch changes up to f5b721d2c91144b7c494a05003fc840f1607e876:

  ARM: dts: exynos: use generic node name for LPDDR3 timings in Odroid (2022-02-05 13:04:43 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.18

1. Minor improvements and dtschema fixes (node names, properties).
2. Fix issues pointed out by DT schema checks:
 - Add necessary clock controller inputs on Exynos5260.
 - Drop unsupported regulators on Odroid XU.
 - Add USB DWC3 supplies.
 - Drop old thermal properties from Exynos4210.
3. Add support for Samsung Chagall WiFi (Exynos5420, Samsung Galaxy Tab
   S 10.5", SM-T800 ) and a similar Samsung Klimt WiFi (Samsung Galaxy
   Tab S 8.4").
4. Add battery to Samsung P4Nnote (Exynos4412, Samsung Galaxy Note
   10.1).

----------------------------------------------------------------
Alim Akhtar (1):
      ARM: dts: exynos: update dma node name with dtschema

Henrik Grimler (4):
      dt-bindings: arm: samsung: document Chagall WiFi board binding
      ARM: dts: exynos: Add support for Samsung Chagall WiFi
      dt-bindings: arm: samsung: document Klimt WiFi board binding
      ARM: dts: exynos: Add support for Samsung Klimt WiFi

Krzysztof Kozlowski (16):
      ARM: dts: exynos: split dmas into array of phandles in Exynos5250
      ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
      ARM: dts: exynos: add necessary clock controller inputs in Exynos5260
      ARM: dts: exynos: drop unsupported MAX77802 regulators on Odroid XU
      ARM: dts: exynos: add USB DWC3 supplies to Arndale
      ARM: dts: exynos: add USB DWC3 supplies to SMDK5250
      ARM: dts: exynos: add USB DWC3 supplies to Chromebook Snow
      ARM: dts: exynos: add USB DWC3 supplies to Chromebook Spring
      ARM: dts: exynos: add USB DWC3 supplies to ArndaleOcta
      ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pit
      ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pi
      ARM: dts: exynos: add USB DWC3 supplies to SMDK5420
      ARM: dts: exynos: add fake USB DWC3 supplies to SMDK5410
      ARM: dts: exynos: drop old thermal properties from Exynos4210
      ARM: dts: exynos: use define for TMU clock on Exynos4412
      ARM: dts: exynos: use generic node name for LPDDR3 timings in Odroid

Martin Jücker (1):
      ARM: dts: exynos: add charger and battery to p4note

 .../bindings/arm/samsung/samsung-boards.yaml       |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/exynos3250-monk.dts              |   2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   2 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   6 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |   2 -
 arch/arm/boot/dts/exynos4412-p4note.dtsi           |  34 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   5 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   5 +
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   5 +
 arch/arm/boot/dts/exynos5250-spring.dts            |   5 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  19 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |  21 +
 arch/arm/boot/dts/exynos5260.dtsi                  | 128 ++++
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  12 -
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  23 +
 arch/arm/boot/dts/exynos5410.dtsi                  |   4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  10 +
 arch/arm/boot/dts/exynos5420-chagall-wifi.dts      |  75 +++
 .../arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 691 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-klimt-wifi.dts        |  75 +++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  10 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  10 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  10 +
 29 files changed, 1136 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-chagall-wifi.dts
 create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-klimt-wifi.dts
