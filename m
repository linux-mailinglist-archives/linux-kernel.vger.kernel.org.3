Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67E847A915
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhLTLzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:55:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34698
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhLTLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:55:35 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F9713F17B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640001334;
        bh=wmQkxgphrK4eSzvvYZb7picZLOO5tZUm1QhLP98g8vw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jE6QsbsvM5/qh5ice0BI0ma2I+GPtEXy6rei3jNqxeEq9gWPt/NS6tXsjCFRK10D8
         /uNUdCdP+kKGJ9+MUR00cFVfQBOnfsUFu10PK95eq5KCPe+DUeEWWXJbdcxppKbIwh
         x0kPokiviUnMAPoiLp1P+RiDNdtJYBS1AqTY7wHiebs0NmHAlMyCXON0cY+I4XwRXH
         CiAHwp3DnP1VC0HBD9FtNhAQHZ6W78NUX4u+TCCIUM+L3QttL473uWqY/hz+KdYEOU
         l4Wi4Lr44t91fSmUx/tE49spGetWMEa494C7WQM0JmsEFdnUAlDesq2zznwUk+NjW3
         pBvJuZQxvRO2A==
Received: by mail-lf1-f71.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so2739928lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmQkxgphrK4eSzvvYZb7picZLOO5tZUm1QhLP98g8vw=;
        b=EMOAYliGht+wOqFDnzGnduOjuJlEuconlxHRm+BVTewki2IvbMzTyiPIGnjZhuw1XT
         Yd1seTrYzdCQPia+mD7RkEQBxwmxFY30tdpQEN03d+KMVqmXlHvuw6+fYVrYyjP0+3Yd
         y+cHbzdPlDTGle0LtHKwDdX8Iw1XTbvBsA3rttYaYCXslDHg7juobemQ2uOuXULnYUtU
         U1TFOLQWcI3t7tkhQG0a6F+CgrXRhsIlMAKs6t/9x6wEX8kSP7K0IEiCy63DHI9dWL5a
         TJ282HFCH/O1lGkNhxBpgVF7tTJDrw89q/hfbPPwaNcbM5wtxleynPF2oqBS5t5rTpRn
         DD6Q==
X-Gm-Message-State: AOAM531G834cKStlH/Ivlz+KGV2T6v7acCNpIY/Gbf0F37/uOsF0DwlS
        ZmyTriMUQmbohCQZdYHHIJE6PTvVBmCvJc7yUdh8P+KbNTcUY1uwGXPuEBdUI62pUD1Ejp9Nzk9
        D0XVcL5xJZ2TWCMSX73ZlPbYSbogWX/kxdX2Os2Pdnw==
X-Received: by 2002:a2e:94d7:: with SMTP id r23mr13742784ljh.11.1640001333924;
        Mon, 20 Dec 2021 03:55:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4pOCUOSS32zHR96WEP/TLPmxEy9A2PeWFDvgVU+Jy9Y/NtOqa5tk0sidYan4xX0D45X6FMw==
X-Received: by 2002:a2e:94d7:: with SMTP id r23mr13742763ljh.11.1640001333766;
        Mon, 20 Dec 2021 03:55:33 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id n2sm2523746ljq.30.2021.12.20.03.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:55:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/6] ARM: dts: samsung: for v5.17
Date:   Mon, 20 Dec 2021 12:55:26 +0100
Message-Id: <20211220115530.30961-1-krzysztof.kozlowski@canonical.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.17

for you to fetch changes up to 29bf0ff5ae18ad1a6dd183569cc097e578052c57:

  ARM: dts: exynos: Rename hsi2c nodes to i2c for Exynos5260 (2021-12-06 09:29:01 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.17

1. Fix Bluetooth GPIO on GT-I9100.
2. Minor improvements and dtschema fixes.

----------------------------------------------------------------
Paul Cercueil (2):
      ARM: dts: exynos: Fix BCM4330 Bluetooth reset polarity in I9100
      ARM: dts: exynos: Use interrupt for BCM4330 host wakeup in I9100

Sam Protsenko (1):
      ARM: dts: exynos: Rename hsi2c nodes to i2c for Exynos5260

 arch/arm/boot/dts/exynos4210-i9100.dts | 7 +++++--
 arch/arm/boot/dts/exynos5260.dtsi      | 8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)
