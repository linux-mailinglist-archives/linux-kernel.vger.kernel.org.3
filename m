Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE48C47933E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhLQR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbhLQR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:06 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA764C061574;
        Fri, 17 Dec 2021 09:58:05 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 13so4530185ljj.11;
        Fri, 17 Dec 2021 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JO0eGwLLz0htK5AL/Osj6kMOG2fBVADJOFwbMhccx2c=;
        b=d5Le4BhUw5QzNbC7DQKgQqpXdfvh6u9SezZgTCbqnUlmOtwuN0GnLY6AG306dbTfE1
         YumWoEYHgEWiKe2maOm4gQuhb6PYqbI51Qul5Jaoy6lsnyz8PrkyME3Oes6RyYDd0DrA
         en73kuwm9PnbtvQS3Bz4pVVYRbTdBEd6LSuNV+unLpb/sxu3SmZfObXyFQ8v/8UdjSJA
         gYvcO58LSEEVN5qbu+JMwfpjvddKNGFUynHDkyiuuJMyfaBiMYFt5gqrNN/iTo6aWL2X
         k/wzPaBsbm6Hp4vvpVi9Io24YqlqRBB/EJbcw7f4IyOx2TeEvSaurcZathgZL/aDy6Nk
         OG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JO0eGwLLz0htK5AL/Osj6kMOG2fBVADJOFwbMhccx2c=;
        b=Jqd80balRk4XkXUBgId2TLuUcZ181trLA9i2W/E7lAHUFYbAyw9dkXOtfSZYk0ArXq
         ymaolkwL/I9oVQvvuZvfbaUFb/UnoX2Mgbq63fdrr38Uj9knIpYSkZgBMSA/qnGQZ3rB
         48cj7+mMinin81ECVYjUrvOm9r6Qv/jf8wjmGPP1MTT7eiWCjQKwe/4ZZcelIju5A5J8
         IMYmtzsmVtUMFeUTHab2dhDuL1LT7b4v38V7JEqsRHX+8Q7jjS/XBoi75MWhhVUQfh41
         RlpXa79DjO2b5dsoK9xes1MmJge7SdR4HCAHyy7oPqjJPAeRt72H2OwcupF1eGnzIBhV
         kSVA==
X-Gm-Message-State: AOAM533MVgpvIkRx2aP5Yd0eLuyVKlDWuIXmJQSP7EhKnFplAX8+hRTX
        YGo0DuWoljLNj6BbeWKBmwg=
X-Google-Smtp-Source: ABdhPJzWhLeDED2hHghcC5fAa2gjRzuaP7qnOlGcCDZ2vQfhpumBT/J4D1ToEkRHaNTc007UnY0kQw==
X-Received: by 2002:a2e:a175:: with SMTP id u21mr3807462ljl.284.1639763884028;
        Fri, 17 Dec 2021 09:58:04 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 00/11] Support HDMI audio on NVIDIA Tegra20
Date:   Fri, 17 Dec 2021 20:55:55 +0300
Message-Id: <20211217175606.22645-1-digetx@gmail.com>
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

(!) These patches are made on top of stable dmaengine branch from Vinod Koul.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine_topic_slave_id_removal_5.17

for you to fetch changes up to 3c219644075795a99271d345efdfa8b256e55161:

  dmaengine: remove slave_id config field (2021-12-17 11:23:56 +0530)

Changelog:

v5: - Dropped all patches that were already applied by Thierry Reding.

    - Made minor changes that were suggested by Thierry Reding.

    - Added acks from Thierry Reding.

    - Rebased patches on top of stable dmaengine branch from Vinod Koul.

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

Dmitry Osipenko (11):
  ASoC: dt-bindings: Add binding for Tegra20 S/PDIF
  ASoC: dt-bindings: tegra20-i2s: Convert to schema
  ASoC: dt-bindings: tegra20-i2s: Document new nvidia,fixed-parent-rate
    property
  ASoC: tegra20: spdif: Set FIFO trigger level
  ASoC: tegra20: spdif: Support device-tree
  ASoC: tegra20: spdif: Improve driver's code
  ASoC: tegra20: spdif: Use more resource-managed helpers
  ASoC: tegra20: spdif: Reset hardware
  ASoC: tegra20: spdif: Support system suspend
  ASoC: tegra20: spdif: Filter out unsupported rates
  ASoC: tegra20: i2s: Filter out unsupported rates

 .../bindings/sound/nvidia,tegra20-i2s.txt     |  30 ---
 .../bindings/sound/nvidia,tegra20-i2s.yaml    |  77 +++++++
 .../bindings/sound/nvidia,tegra20-spdif.yaml  |  85 ++++++++
 sound/soc/tegra/tegra20_i2s.c                 |  49 +++++
 sound/soc/tegra/tegra20_spdif.c               | 198 +++++++++++++-----
 sound/soc/tegra/tegra20_spdif.h               |   1 +
 sound/soc/tegra/tegra_pcm.c                   |   6 +
 sound/soc/tegra/tegra_pcm.h                   |   1 +
 8 files changed, 359 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml

-- 
2.33.1

