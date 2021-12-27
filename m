Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0447FC32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhL0LaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:30:14 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37608
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232628AbhL0LaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:30:13 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31FC33F1AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640604612;
        bh=aWHjr9hGiX3Xkq17ZpqoeHCadE3NVT5LQHwejDb2nGg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XeRhOYM4+t0pxs2rOT4djeQD0GiEZJFp9Yv/pf/6T8lBHafJAch9Jz/eaMS8R3Z3o
         3jkAqP39xmGYLkQN7MXPyjdyhTycgXNebr1omCXR2om6jsL2ExtmcSbgy3KxfgFVhj
         hfMZ/zoK5CRuyko8nfJ+MFQvBRaXK/99CkfJabOXCyBuT8IBrh9oMPqRWsnC9kj31K
         384+xZVgbXyHPHYiTFv/rbTRATCkJb1l7PeTg3ZgDf3m5cv2njXnMIhc066vnCSQoW
         hF2GQXH3ehJkXBs6dyW3NgvPNgJDEvxAnGfUQsUDbb6/auEJjr86m8VjudZOtIyFls
         P/DjnKj4ygAkQ==
Received: by mail-lj1-f199.google.com with SMTP id n6-20020a2e82c6000000b00221698ffa68so4860585ljh.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 03:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWHjr9hGiX3Xkq17ZpqoeHCadE3NVT5LQHwejDb2nGg=;
        b=g0nIDFVS1OzbYKc/KOw2zrzY3Oz59HDdan9VOGp9CH/V5psZwakKSnf6LUMWdSQk/o
         aeHdrxt7DV8M/qrDfLE/j7yjbOmJKvv+zaljHr/Bo2zkpI/Zp1vqBRyUk7KwR7H0i1cB
         IMXQcJq8JkWHStasL/vY+aRtIKkU5XE3pS6MaULL6BxuCZJk3KWmSUVY/SVklfwS0zDS
         jt6S+/L2xNjTXELKO869YOKXGTgu59jwCSxu8CzqLrH9jq17tIaQiFWW+TQ1Q0hviWtl
         NZsVWp3N8feVLWmTz4ZPCaI2aXFp81nzvEP7n03FerPOY+WbhFFSWazhvSIzp7sYq5eY
         tQmA==
X-Gm-Message-State: AOAM532BcAwC5peCM55ANU7pQBSUVU6QXLYE+rvor0GI2ePcA66oZIoH
        2tGWkGc4YGmhdiTAW7CxaMK0XRSB2xzSV1TwgDE355Lku9hUk1E4Po6sfLgeoUojqP/miaU2kQ4
        dGsVuyczrC/Minf6KEB4q1SIKT5DQsNDGOB8ECFbFDg==
X-Received: by 2002:a05:6512:b1f:: with SMTP id w31mr15148519lfu.240.1640604610068;
        Mon, 27 Dec 2021 03:30:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqmovMOAurIAVtXtVAkod909IMEuDYkOk35Wo6mVXh3Ui2RjRndjpYwT1yH9TfhijrlWPqnA==
X-Received: by 2002:a05:6512:b1f:: with SMTP id w31mr15148503lfu.240.1640604609760;
        Mon, 27 Dec 2021 03:30:09 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s10sm1623075lfr.45.2021.12.27.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 03:30:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
Date:   Mon, 27 Dec 2021 12:29:59 +0100
Message-Id: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Second pull with DTS for ARM64, on top of previous pull.

Best regards,
Krzysztof


The following changes since commit 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:

  dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17-2

for you to fetch changes up to a1828d772e0738c30a383a7d335aded2f2baf908:

  arm64: dts: exynos: Add initial E850-96 board support (2021-12-22 12:31:13 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.17, part two

Add initial Exynos850 support and WinLink E850-96 board using it.

----------------------------------------------------------------
Sam Protsenko (2):
      arm64: dts: exynos: Add initial Exynos850 SoC support
      arm64: dts: exynos: Add initial E850-96 board support

 arch/arm64/boot/dts/exynos/Makefile               |   1 +
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts  | 195 ++++++
 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi | 643 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi         | 759 ++++++++++++++++++++++
 4 files changed, 1598 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
