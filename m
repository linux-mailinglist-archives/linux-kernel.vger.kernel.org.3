Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC172468560
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhLDOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhLDOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:40:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724AC061751;
        Sat,  4 Dec 2021 06:37:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u22so11925901lju.7;
        Sat, 04 Dec 2021 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgU/pHcLq1kPA4XVEXWEET210DA2xlasJUSyPcUCpCY=;
        b=HUoDSKQfpe/g37xMOmAVxOTpFaTt/lTR6dyV10GKZMZt22VPgvwSZj4z8Dzk+RBRRU
         sZl62gd/ycHvHWj79abbNFKJmBXn1FkiFvX4Wfy9bfbH1RfmC5yJqHXTC4Z9OxxUtTEH
         egcggw7Ax2wqp0to/h395s50F9EZVnY/lVuEG6zAhdl3hpbsDZS1X8YwCTm1yy+wJViS
         Sx9kdbmRH+S8L0TUPnjgU1dDTRY1/X78kNjXv3NRG+TqoEnu6Q0VpVf/u4R+LytFslmA
         slLzaz5hfuA2fR/sp4N08+ZwcU2gAT0KqIoq/lQIN8mVEmvQyLG3ZOlZSXdRD7dzXKS2
         AGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgU/pHcLq1kPA4XVEXWEET210DA2xlasJUSyPcUCpCY=;
        b=BJTKDYfjO/uqPP0EYKKLgVPtIrV4YK692DKT3QGiPTCfVOuI/fouUzv0ZSQ8R5EKGY
         32misW5bPbLogYkzDTbd91xYzFvIx9UdZcTQkaRkcbCyI7zOoOUyxslU3biF5cod03V4
         +pYnXA2GXDHhKHf7JGgoXbjbyZXd9MXRhMoX72b9QuSqzlMAKv5wk1EGCpK44K93GO6c
         QVnXCTOLvnzUMR2AnFIDTKlAtotvvE/WkSAyKByLHz4TYYxMyO8eHgryWlqT02xbsq1v
         WdicVSTj69i3IhPsH6yblD8r4VbyfN/tlBxHyDJwxByfT1HIih2+keoPAnX4qrB45fRy
         l6aw==
X-Gm-Message-State: AOAM532+hZwa4qWrpJFrjfbBAZaDCVLFm71TTCJpMxDMYMXbOfmQCq94
        EcveT/f4XeNAPtCfWalY6UI=
X-Google-Smtp-Source: ABdhPJwCMJfyK3vFo8uYHtqyUUuRe56EKohyxSP/whDcCXw+74GQlAzEA2DCOd8dbo/Bvyh+x1cOIA==
X-Received: by 2002:a2e:8991:: with SMTP id c17mr23781559lji.361.1638628651146;
        Sat, 04 Dec 2021 06:37:31 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
Date:   Sat,  4 Dec 2021 17:37:03 +0300
Message-Id: <20211204143725.31646-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series revives Tegra20 S/PDIF driver which was upstreamed long time
ago, but never was used. It also turns Tegra DRM HDMI driver into HDMI
audio CODEC provider. Finally, HDMI audio is enabled in device-trees.
For now the audio is enable only for Acer A500 tablet and Toshiba AC100
netbook because they're already supported by upstream, later on ASUS TF101
tablet will join them.

I based S/PDIF patches on Arnd's Bergmann patch from a separate series [1]
that removes obsolete slave_id. This eases merging of the patches by
removing the merge conflict. This is a note for Mark Brown.

I also based this series on top of power management series [2]. I.e. [2]
should be applied first, otherwise "Add S/PDIF node to Tegra20 device-tree"
patch should have merge conflict. This is a note for Thierry.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=273312
[2] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=274534

Changelog:

v4: - Added patches that update multi_v7_defconfig with the enabled S/PDIF
      and APB DMA drivers.

v3: - Renamed S/PDIF device-tree clocks as was suggested by Rob Herring.

    - Added r-bs and acks that were given by Rob Herring to v2.

v2: - Corrected I2S yaml problem that was reported by the DT bot for v1
      by removing the non-existent required clock-names property.

    - Removed assigned-clocks property from S/PDIF yaml since this property
      is now inherited from the clocks property.

    - Reordered the "tegra20: spdif: Set FIFO trigger level" patch, making
      it the first sound/soc patch in the series, like it was suggested by
      Mark Brown in the comment to v1. Also reworded commit message of this
      patch to *not* make it looks like it should be backported to stable
      kernels.

Arnd Bergmann (1):
  ASoC: tegra20-spdif: stop setting slave_id

Dmitry Osipenko (21):
  ASoC: dt-bindings: Add binding for Tegra20 S/PDIF
  ASoC: dt-bindings: tegra20-i2s: Convert to schema
  ASoC: dt-bindings: tegra20-i2s: Document new nvidia,fixed-parent-rate
    property
  dt-bindings: host1x: Document optional HDMI sound-dai-cells
  ASoC: tegra20: spdif: Set FIFO trigger level
  ASoC: tegra20: spdif: Support device-tree
  ASoC: tegra20: spdif: Improve driver's code
  ASoC: tegra20: spdif: Use more resource-managed helpers
  ASoC: tegra20: spdif: Reset hardware
  ASoC: tegra20: spdif: Support system suspend
  ASoC: tegra20: spdif: Filter out unsupported rates
  ASoC: tegra20: i2s: Filter out unsupported rates
  drm/tegra: hdmi: Unwind tegra_hdmi_init() errors
  drm/tegra: hdmi: Register audio CODEC on Tegra20
  ARM: tegra_defconfig: Enable S/PDIF driver
  ARM: config: multi v7: Enable NVIDIA Tegra20 S/PDIF driver
  ARM: config: multi v7: Enable NVIDIA Tegra20 APB DMA driver
  ARM: tegra: Add S/PDIF node to Tegra20 device-tree
  ARM: tegra: Add HDMI audio graph to Tegra20 device-tree
  ARM: tegra: acer-a500: Enable S/PDIF and HDMI audio
  ARM: tegra: paz00: Enable S/PDIF and HDMI audio

 .../display/tegra/nvidia,tegra20-host1x.txt   |   1 +
 .../bindings/sound/nvidia,tegra20-i2s.txt     |  30 ---
 .../bindings/sound/nvidia,tegra20-i2s.yaml    |  77 +++++++
 .../bindings/sound/nvidia,tegra20-spdif.yaml  |  85 ++++++++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   8 +
 arch/arm/boot/dts/tegra20-paz00.dts           |   8 +
 arch/arm/boot/dts/tegra20.dtsi                |  40 +++-
 arch/arm/configs/multi_v7_defconfig           |   2 +
 arch/arm/configs/tegra_defconfig              |   1 +
 drivers/gpu/drm/tegra/Kconfig                 |   3 +
 drivers/gpu/drm/tegra/hdmi.c                  | 168 +++++++++++++--
 sound/soc/tegra/tegra20_i2s.c                 |  49 +++++
 sound/soc/tegra/tegra20_spdif.c               | 197 ++++++++++++------
 sound/soc/tegra/tegra20_spdif.h               |   1 +
 sound/soc/tegra/tegra_pcm.c                   |   6 +
 sound/soc/tegra/tegra_pcm.h                   |   1 +
 16 files changed, 574 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml

-- 
2.33.1

