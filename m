Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EA495554
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377606AbiATUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiATUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:20:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CEC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x11so26050530lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SV2+kbDgVtw0lV31uGNVO0MZ2UY0VfBryzePxW9RfDo=;
        b=hjq4AM/+aWwjiHOTI1IslNvdQgEv7Wbun6S6h7xb8cEm5+1TLN/d0WYqA/mc6RvKNN
         gQoe6LKKSpfjOZLCLTLw4Trrwoy5pXt9ZXEhM1B1luwTPNTaZHvZvecumQPBw/nPJ8Vb
         ENXUAiSZ2tztrL1y2h31ulq2bhNPSHGHa5MWThKCSMSusMuK0rbzEQpVlpSLdzHb6Bpk
         FmouJtfAYUYKVnFOUw5o0tObrSmDtyx8Zst5xGxBpe6NhnhpFeLs+PX4HmQJsf0jHfK7
         yOZ9Wp7UrHJmxsXvIXLkY3xAI4Thzz/XA+rA0ufps2f8KuC/1LSFCNNgdMYPwAWozk0B
         8qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SV2+kbDgVtw0lV31uGNVO0MZ2UY0VfBryzePxW9RfDo=;
        b=QVb13Jt4AvM35JkiSg5Zq3FYQC38MLr4k2evwV5vIEngWIgRz+G/4YmOus/8HLyxEt
         DiTVHbejYEg70r0KLhSwHwYOowfShCMUDdf6VupqM/ZIknKp9DzLTOIBf+A3Bqbls8tk
         Y6BOQ8VWJXfvrBKqbqekeCdVHHTg36aD1Ch4PCtHBmEdqJ31hD/MudCWuqSdIs1hDfGo
         P8fZmz+UgzmzOnKJGFMvi4cabpP4SXTTkuwMKiM2PRsMe8Eb6ehGGTgT9+xvJnBXPC1+
         ABA6esqLnKwztGtujqgruDAV2SYIcko3FPas6c9MVhjguMIbnZQ4TI/R5MMbUiAmT9j0
         OqyQ==
X-Gm-Message-State: AOAM531/HtvygPmhTQ38ItcJPspRBQNpCfa9biZg+8XyJLr+OBMUXzz+
        fF0BsEhM0tU3jvKMQlTc5geKQg==
X-Google-Smtp-Source: ABdhPJxE6MkmquotwQB0ocKSKdWoDh5ulhRTbJKLE+X/Kg/iQUIIWJNEWpJYx5Uhrcqz6/tpYGTFTw==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr559195ljp.435.1642709999939;
        Thu, 20 Jan 2022 12:19:59 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id q17sm21155lfb.271.2022.01.20.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:19:59 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Jinkyu Yang <jinkyu1.yang@samsung.com>,
        Alex <acnwigwe@google.com>, Carlos Llamas <cmllamas@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Erick Reyes <erickreyes@google.com>,
        "J . Avila" <elavila@google.com>, Jonglin Lee <jonglin@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 0/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Date:   Thu, 20 Jan 2022 22:19:55 +0200
Message-Id: <20220120201958.2649-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a draft of a new IOMMU driver used in modern Exynos SoCs (like
Exynos850) and Google's GS101 SoC (used in Pixel 6 phone). Most of its
code were taken from GS101 downstream kernel [1], with some extra
patches on top (fixes from Exynos850 downstream kernel and some porting
changes to adapt it to the mainline kernel). All development history can
be found at [2].

Similarities with existing exynos-iommu.c is minimal. I did some
analysis using similarity-tester tool:

8<-------------------------------------------------------------------->8
    $ sim_c -peu -S exynos-iommu.c "|" samsung-*

    exynos-iommu.c consists for 15 % of samsung-iommu.c material
    exynos-iommu.c consists for 1 %  of samsung-iommu-fault.c material
    exynos-iommu.c consists for 3 %  of samsung-iommu.h material
8<-------------------------------------------------------------------->8

So the similarity is very low, most of that code is some boilerplate
that shouldn't be extracted to common code (like allocating the memory
and requesting clocks/interrupts in probe function).

It was tested on v5.4 Android kernel on Exynos850 (E850-96 board) with
DPU use-case (displaying some graphics to the screen). Also it
apparently works fine on v5.10 GS101 kernel (on Pixel 6). On mainline
kernel I managed to build, match and bind the driver. No real world test
was done, but the changes from v5.10 (where it works fine) are minimal
(see [2] for details). So I'm pretty sure the driver is functional.

For this patch series I'd like to receive some high-level review for
driver's design and architecture. Coding style and API issues I can fix
later, when sending real (not RFC) series. Particularly I'd like to hear
some opinions about:
  - namings: Kconfig option, file names, module name, compatible, etc
  - modularity: should this driver be a different platform driver (like
    in this series), or should it be integrated into existing
    exynos-iommu.c driver somehow
  - dt-bindings: does it look ok as it is, or some interface changes are
    needed
  - internal driver architecture: approach seems to be similar to
    exynos-iommu.c, but any comments are welcome
  - ongoing work: please let me know if you're aware of some efforts to
    upstream this driver by some other party (e.g. Google engineers
    might be working on something similar)

Basically, I want to figure out what should be changed/fixed in this
driver (on a high level), so it can be considered "upstreamable".

[1] https://android.googlesource.com/kernel/gs/
[2] https://github.com/joe-skb7/linux/commits/iommu-exynos850-dev

Sam Protsenko (3):
  dt-bindings: iommu: Add bindings for samsung,sysmmu-v8
  iommu/samsung: Introduce Exynos sysmmu-v8 driver
  arm64: defconfig: Enable sysmmu-v8 IOMMU

 .../bindings/iommu/samsung,sysmmu-v8.txt      |   31 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/iommu/Kconfig                         |   13 +
 drivers/iommu/Makefile                        |    3 +
 drivers/iommu/samsung-iommu-fault.c           |  617 +++++++
 drivers/iommu/samsung-iommu-group.c           |   50 +
 drivers/iommu/samsung-iommu.c                 | 1521 +++++++++++++++++
 drivers/iommu/samsung-iommu.h                 |  216 +++
 include/dt-bindings/soc/samsung,sysmmu-v8.h   |   43 +
 9 files changed, 2496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
 create mode 100644 drivers/iommu/samsung-iommu-fault.c
 create mode 100644 drivers/iommu/samsung-iommu-group.c
 create mode 100644 drivers/iommu/samsung-iommu.c
 create mode 100644 drivers/iommu/samsung-iommu.h
 create mode 100644 include/dt-bindings/soc/samsung,sysmmu-v8.h

-- 
2.30.2

