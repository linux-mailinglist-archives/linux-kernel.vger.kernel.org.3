Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECFB55CB75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiF0OVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiF0OUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:20:42 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBCDFD05;
        Mon, 27 Jun 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2C7bvwZpbY0eq72GTwKLtH/NuxtYOf5fz40pL8puD8w=; b=idFX+Wyxs1EEtPItu5TJ0lYju3
        KikYXV0VpCQyyPbnaZ6eyArNasehnnCxD7HQ2e5f/s16ZnBTodEClCTCCiFEnNgWXmMdDg7zvna6O
        tylN2mm0Lb7OHkSlX5wx7Il8ji9b3+PyNWtxkmKZcM61IX+6fi2BF0Pv5Aj33o1q4cpjtvFpGy4Zz
        6dVgw50B3lFuq8lnhuTChNT12GlqO6jTBfOv+WYU6kZQlxixlbyjo/jCge+7clCsJJCeYuMqXCvb6
        TljMp8PLF2UQYBbh6NZcolxmZZ57UDmgdnPe5RX0UcbH1LJLQ7iWjUd3Eog20EBj4kZeg3KDfUKAG
        DcGH/YhA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o5pbK-003N2J-As; Mon, 27 Jun 2022 17:20:29 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7/v3 00/22] Host1x context isolation / Tegra234 support
Date:   Mon, 27 Jun 2022 17:19:46 +0300
Message-Id: <20220627142008.2072474-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Integrated the Host1x context isolation series (patches 1 to 8) and
Tegra234 support series (patches 9 to 22) in one email thread for
the benefit of automatic testers.

Changes from previous versions:

Context isolation:
* Improved check to ensure context devices are attached to IOMMU
* Fixed build failure when CONFIG_IOMMU_API=n as reported by bot
* Dropped Thierry's Host1x schema YAML conversion from this series
  -- it was accidentally included in the previous
* Also dropped arm-smmu change for now. It can be merged later if
  necessary.

Tegra234:
* Split bracketing fix in DT schema to separate patch
* Added Acked-by

Thanks,
Mikko

Mikko Perttunen (22):
  dt-bindings: host1x: Add iommu-map property
  gpu: host1x: Add context device management code
  gpu: host1x: Program context stream ID on submission
  arm64: tegra: Add Host1x context stream IDs on Tegra186+
  drm/tegra: falcon: Set DMACTX field on DMA transactions
  drm/tegra: nvdec: Fix TRANSCFG register offset
  drm/tegra: Support context isolation
  drm/tegra: Implement stream ID related callbacks on engines
  dt-bindings: Add bindings for Tegra234 Host1x and VIC
  dt-bindings: host1x: Fix bracketing in example
  dt-bindings: Add headers for Host1x and VIC on Tegra234
  arm64: tegra: Add Host1x and VIC on Tegra234
  gpu: host1x: Deduplicate hardware headers
  gpu: host1x: Simplify register mapping and add common aperture
  gpu: host1x: Program virtualization tables
  gpu: host1x: Allow reset to be missing
  gpu: host1x: Program interrupt destinations on Tegra234
  gpu: host1x: Tegra234 device data and headers
  gpu: host1x: Rewrite job opcode sequence
  gpu: host1x: Add MLOCK release code on Tegra234
  gpu: host1x: Use RESTART_W to skip timed out jobs on Tegra186+
  drm/tegra: vic: Add Tegra234 support

 .../display/tegra/nvidia,tegra124-vic.yaml    |   1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml  | 115 +++++++++--
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  11 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  11 ++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  46 +++++
 drivers/gpu/drm/tegra/drm.c                   |   1 +
 drivers/gpu/drm/tegra/drm.h                   |  11 ++
 drivers/gpu/drm/tegra/falcon.c                |   8 +
 drivers/gpu/drm/tegra/falcon.h                |   1 +
 drivers/gpu/drm/tegra/nvdec.c                 |  13 +-
 drivers/gpu/drm/tegra/submit.c                |  48 ++++-
 drivers/gpu/drm/tegra/uapi.c                  |  43 ++++-
 drivers/gpu/drm/tegra/vic.c                   |  79 +++++++-
 drivers/gpu/host1x/Makefile                   |   6 +-
 drivers/gpu/host1x/cdma.c                     |  19 +-
 drivers/gpu/host1x/context.c                  | 160 ++++++++++++++++
 drivers/gpu/host1x/context.h                  |  38 ++++
 drivers/gpu/host1x/dev.c                      | 124 ++++++++----
 drivers/gpu/host1x/dev.h                      |  13 ++
 drivers/gpu/host1x/hw/cdma_hw.c               |  34 ++++
 drivers/gpu/host1x/hw/channel_hw.c            | 136 +++++++++----
 drivers/gpu/host1x/hw/host1x01_hardware.h     | 114 +----------
 drivers/gpu/host1x/hw/host1x02_hardware.h     | 113 +----------
 drivers/gpu/host1x/hw/host1x04_hardware.h     | 113 +----------
 drivers/gpu/host1x/hw/host1x05_hardware.h     | 113 +----------
 drivers/gpu/host1x/hw/host1x06_hardware.h     | 118 +-----------
 drivers/gpu/host1x/hw/host1x07_hardware.h     | 118 +-----------
 drivers/gpu/host1x/hw/host1x08.c              |  33 ++++
 drivers/gpu/host1x/hw/host1x08.h              |  15 ++
 drivers/gpu/host1x/hw/host1x08_hardware.h     |  21 ++
 drivers/gpu/host1x/hw/hw_host1x08_channel.h   |  11 ++
 drivers/gpu/host1x/hw/hw_host1x08_common.h    |  11 ++
 .../gpu/host1x/hw/hw_host1x08_hypervisor.h    |   9 +
 drivers/gpu/host1x/hw/hw_host1x08_uclass.h    | 181 ++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x08_vm.h        |  36 ++++
 drivers/gpu/host1x/hw/intr_hw.c               |  11 ++
 drivers/gpu/host1x/hw/opcodes.h               | 150 +++++++++++++++
 include/dt-bindings/clock/tegra234-clock.h    |   4 +
 include/dt-bindings/memory/tegra234-mc.h      |   5 +
 .../dt-bindings/power/tegra234-powergate.h    |   1 +
 include/dt-bindings/reset/tegra234-reset.h    |   1 +
 include/linux/host1x.h                        |  42 ++++
 42 files changed, 1357 insertions(+), 781 deletions(-)
 create mode 100644 drivers/gpu/host1x/context.c
 create mode 100644 drivers/gpu/host1x/context.h
 create mode 100644 drivers/gpu/host1x/hw/host1x08.c
 create mode 100644 drivers/gpu/host1x/hw/host1x08.h
 create mode 100644 drivers/gpu/host1x/hw/host1x08_hardware.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x08_channel.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x08_common.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x08_hypervisor.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x08_uclass.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x08_vm.h
 create mode 100644 drivers/gpu/host1x/hw/opcodes.h

-- 
2.36.1

