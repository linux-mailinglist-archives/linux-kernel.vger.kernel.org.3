Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1B464164
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbhK3Wl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbhK3Wl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:41:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE26C061574;
        Tue, 30 Nov 2021 14:38:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c32so57739608lfv.4;
        Tue, 30 Nov 2021 14:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukerStZwJQBbcdthWoYapstsdo+733zEd1LvbzsNaBI=;
        b=oQnXXnVge3m7fqIA+e55hdNd6FeCm6kGl3HCzcX8oKof+QkkmYp8tTXG9pBzIGiCqh
         g4DFHiFtU5ZQ5H51gJwnfoHdqc6KI9uYNVuKyuJPC/dVG4AzTqBn9ztQmRunHcc25Lma
         ck0rVZZ1n6yqHg9SKiLxFLCP+90Jyr7IzNEBpo5HuZ8KvtRhBLASHZsoSqXBOpgDFUVy
         QOODHb4anFwpNwl/Q+atPHS5RIei/Y5/z4yOmKtBxx72f7ICrR/eo9Nc3PWRkqxrsvOW
         tEU/KBOmw6fkjEIa9FCPt5+97UIq7tywUEas6TWBGWW8lEqhN1k1y5V+cN11nmdv//pk
         TCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukerStZwJQBbcdthWoYapstsdo+733zEd1LvbzsNaBI=;
        b=Hi0n1avycX5g7e1MDApU/seI0jTyNWnTit6NX/yIHGC59D8NeiesuOIYtbFrsLRUgI
         Y/Dn/27ZAIJ7EVEWGud2Y5HxZDNKAgzSdTGnBoEsea6g1vVm0ahry0RCRFmLUBPW4Jwm
         Ufym391u5EBl9kmpquAcPVgzXBxBcVtw0P5w7vppIIv6tdZBgXdSHivdPuZ4vUaTA1l1
         GG/QLq36TAWRAlbJs+h05jsuEIbSdaoeTsqRb+zq5jWJyDJOhh4uHScXhYYjlT2241FR
         s7MxXtvUuw0vy36QC3Wiee3a+2LR0F/2O/p3mDw0Ous07VR+SJzUZ+ypwdckZmpzYmkI
         nlFw==
X-Gm-Message-State: AOAM530sXgzBDZcZoKRL5V9m9jwZohweDy+tYBow0apebQqkrs4vyCyO
        nQjMW2XvAAzGNGq58j862fo=
X-Google-Smtp-Source: ABdhPJxGQmIcsQSaYFW7hCmANcxQioHcq7DDH8z9igEfVFfKRFjezPqDwZGlTXrntZXrJMIxptfYYQ==
X-Received: by 2002:a05:6512:12d6:: with SMTP id p22mr1945297lfg.5.1638311916289;
        Tue, 30 Nov 2021 14:38:36 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/24] NVIDIA Tegra ARM32 device-tree patches for 5.17 (new devices and more)
Date:   Wed,  1 Dec 2021 01:37:56 +0300
Message-Id: <20211130223820.23609-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patchset you will find:

  - New device-trees of ASUS Transformer and Pegatron Chagall tablets.

  - New device-tree of Nyan Big Chromebook variant that has 1080p display
    panel.

  - Enabled video decoder on Tegra114.

  - Minor cleanup of Nexus7 device-tree.

  - Renamed clocks and regulator nodes. I'm sending this patch second time
    because previously there was no good reason given about why not to apply
    it. Please apply it this time.

  - Fixes for T124 device-tress.

Changelog:

v4: - Factored out common parts of ASUS device-trees into separate patches.
      I retained the original author of the tegra30-asus-transformer-common.dtsi
      after chatting with Svyatoslav. Initially I wanted to change the
      authorship to Michał, but not that much left from the original DT that
      was created by Michał, so it's fair to keep Svyatoslav the author.
      I explained in the commit message that the common DT was derived from
      the Michał's TF300T DT and then reworked heavily, I also added Michał
      as co-developer of the common part.

    - Added new T124 patches that were requested by Thomas Graichen. They
      restore USB, CPUFreq and fix overheating of Nyan Chromebooks.

    - Added patches that update tegra_defconfig and multi_v7_defconfig with
      enabled drivers used by ASUS Transformers and Nyan Chromebooks.

    - Added acks that were given by Rob Herring to v3.

    - Changed display panel compatible of ASUS TF701T like it was suggested
      by Rob Herring in other thread.

    - Removed yet unused SDMMC1 pinmux from TF701T DT as was requested by
      Anton Bambura.

    - Added patch which adds node labels to T30 DTSI. It eases porting
      devices to upstream. This was requested by Michał Mirosław.

v3: - Maxim added couple "FIXME" comments to Transformer device-trees for
      things that are yet missing on kernel side, and thus, can't be enabled
      in the DT for now.

    - Maxim also found that v2 had a small problem in the patch which adds
      device-tree for Chagall tablet. Turned out I made a mistake during
      rebase of the patches and haven't noticed it, it's fixed now.

v2: - Svyatoslav and Maxim made couple corrections to regulators, comments
      and default brightness of the device-trees.

    - Added thermtrip node to transformers DT as we now have PMIC fix for
      it [1], it works properly now.

      [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20211124190104.23554-1-digetx@gmail.com/

    - Changed sound card model names to make them per-device and consistent
      with the names that other Tegra DTs already use in upstream. This will
      prevent potential ABI breakages in the future if we will find that sound
      of some device needs extra differentiation.

Anton Bambura (3):
  ARM: tegra: Add labels to tegra114.dtsi
  ARM: tegra: Add device-tree for ASUS Transformer Pad TF701T
  ARM: tegra: Enable video decoder on Tegra114

David Heidelberg (3):
  dt-bindings: ARM: tegra: Document Pegatron Chagall
  ARM: tegra: Name clock and regulator nodes according to DT-schema
  ARM: tegra: nexus7: Drop clock-frequency from NFC node

Dmitry Osipenko (6):
  ARM: tegra: Add device-tree for 1080p version of Nyan Big
  ARM: tegra: Enable HDMI CEC on Nyan
  ARM: tegra: Enable CPU DFLL on Nyan
  ARM: tegra: Add CPU thermal zones to Nyan device-tree
  ARM: tegra_defconfig: Enable drivers wanted by Acer Chromebooks and
    ASUS tablets
  ARM: config: multi v7: Enable display drivers used by Tegra devices

Maxim Schwalm (2):
  ARM: tegra: Add common device-tree for display panel of ASUS devices
  ARM: tegra: nexus7: Use common LVDS display device-tree

Michał Mirosław (2):
  ARM: tegra: Add labels to tegra30.dtsi
  ARM: tegra: Add device-tree for ASUS Transformer Pad TF300T

Nikola Milosavljevic (1):
  ARM: tegra: Add device-tree for ASUS Transformer EeePad TF101

Stefan Eichenberger (1):
  ARM: tegra: Add usb-role-switch property to USB OTG ports

Svyatoslav Ryhel (6):
  dt-bindings: ARM: tegra: Document ASUS Transformers
  ARM: tegra: Add common device-tree base for Tegra30 ASUS Transformers
  ARM: tegra: Add device-tree for ASUS Transformer Prime TF201
  ARM: tegra: Add device-tree for ASUS Transformer Pad TF300TG
  ARM: tegra: Add device-tree for ASUS Transformer Infinity TF700T
  ARM: tegra: Add device-tree for Pegatron Chagall tablet

 .../devicetree/bindings/arm/tegra.yaml        |   19 +
 arch/arm/boot/dts/Makefile                    |   10 +-
 arch/arm/boot/dts/tegra114-asus-tf701t.dts    |  802 +++++
 arch/arm/boot/dts/tegra114-dalmore.dts        |   16 +-
 arch/arm/boot/dts/tegra114-roth.dts           |   14 +-
 arch/arm/boot/dts/tegra114-tn7.dts            |    8 +-
 arch/arm/boot/dts/tegra114.dtsi               |   90 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi   |    1 +
 arch/arm/boot/dts/tegra124-apalis.dtsi        |    1 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     |   26 +-
 arch/arm/boot/dts/tegra124-nyan-big-fhd.dts   |   11 +
 arch/arm/boot/dts/tegra124-nyan.dtsi          |   84 +-
 arch/arm/boot/dts/tegra124-venice2.dts        |   30 +-
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   12 +-
 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 1191 +++++++
 arch/arm/boot/dts/tegra20-harmony.dts         |   16 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts     |    8 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |    6 +-
 arch/arm/boot/dts/tegra20-plutux.dts          |    8 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        |   16 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |    4 +-
 arch/arm/boot/dts/tegra20-tec.dts             |    8 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |   12 +-
 arch/arm/boot/dts/tegra20-ventana.dts         |   12 +-
 .../boot/dts/tegra30-asus-lvds-display.dtsi   |   61 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |   64 +-
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |    4 +-
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |    2 +-
 .../boot/dts/tegra30-asus-nexus7-grouper.dtsi |    1 -
 .../boot/dts/tegra30-asus-nexus7-tilapia.dtsi |    2 -
 arch/arm/boot/dts/tegra30-asus-tf201.dts      |  623 ++++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts     | 1030 ++++++
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts    | 1072 +++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts     |  818 +++++
 .../dts/tegra30-asus-transformer-common.dtsi  | 1728 ++++++++++
 arch/arm/boot/dts/tegra30-beaver.dts          |   20 +-
 arch/arm/boot/dts/tegra30-cardhu-a02.dts      |   12 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts      |   14 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |   28 +-
 .../arm/boot/dts/tegra30-pegatron-chagall.dts | 2794 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |   36 +-
 arch/arm/configs/multi_v7_defconfig           |    5 +
 arch/arm/configs/tegra_defconfig              |    6 +
 43 files changed, 10467 insertions(+), 258 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra114-asus-tf701t.dts
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big-fhd.dts
 create mode 100644 arch/arm/boot/dts/tegra20-asus-tf101.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf201.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf300t.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf300tg.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf700t.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-pegatron-chagall.dts

-- 
2.33.1

