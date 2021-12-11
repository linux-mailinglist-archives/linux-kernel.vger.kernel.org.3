Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC947165A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhLKVOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhLKVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36088C061714;
        Sat, 11 Dec 2021 13:14:22 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z8so18453485ljz.9;
        Sat, 11 Dec 2021 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQgbXLDygjds0YLNQGqPucAQ1zkcXHyC+uTKGssc/nw=;
        b=d0s/oQOZmkvjre/cNKFItCJ/1EZLydSntVWLC6j8cJ0HxRoODrT0Y0xdaEwR8Eemx5
         w1xguGi84Cz/SO+y5YujOm0yS57TPWugvXlp9PP3jMXo+y5kakvBb1WHCDYz0h7muABt
         Uos+Gv7SpgpXdJErj21hvFtkK7ZE8cjEMkVuk+pK+4PJTt4kQD3T2yaAhI+5jkLGwDh3
         kFX5iS8hcl+J0G6GFJ8VQFfuJx2Zu3KTdBgPbYVhR7QaJL5hKWb3c6wQ0nZpPw89+GNc
         dpUj4JGUtcnBz/UqTER0xkEcgxOjweJEUJN8hIrv4TOnqOTGHSwP639EeYXzo1K5CQs7
         62Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQgbXLDygjds0YLNQGqPucAQ1zkcXHyC+uTKGssc/nw=;
        b=tcL/10e1SC3fuoNjreZyJlEXoJl0YtTN47hl0mCWLa9Djte5BN+oufxGTzC7vl1SUj
         OzNLL1FlmcOA6xNwXJi58KM0pwnYDgsEZM22djKCXhB/Gm9zg1P8QjUE9mdSb9xKeCQ4
         /NXUDmGDsrkkNjO4wQ9td05b+rojlN2XdlWosUJ9lTvD9MMIUxD2gUoawRkc3F44uQAP
         T5k8o5SiqXVPs1/RJOBV0+7X30Ir8iZCiEw7jnFG4hCGo8+4WnNs7Y/GVokFHjypq/k8
         Sv+0IK+kF1xR6ZYWfEv+4c9i6QTYoA/qX9vtZlaX1xPLwNclV2tP+WWnOmQMQMdz+ZDh
         RHEg==
X-Gm-Message-State: AOAM530Yc02yKvr0rWvDIPXuBQcfJUGlXXNyEnbO5bdG2heA5mslKZrD
        juCKcecPDNourwqZEeOy/iU=
X-Google-Smtp-Source: ABdhPJyrlmPEmlo7S0omL3v5zrt7N4IvW8LO438GG5Yg2+OeJeOMN8ckgThZGPzE2oRoDy5kxLOh1A==
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr20749966lji.200.1639257260232;
        Sat, 11 Dec 2021 13:14:20 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:19 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/28] NVIDIA Tegra ARM32 device-tree patches for 5.17 (new devices and more)
Date:   Sun, 12 Dec 2021 00:13:44 +0300
Message-Id: <20211211211412.10791-1-digetx@gmail.com>
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

  - Renamed clocks and regulator nodes.

  - Fixes for T124 device-trees.

Changelog:

v6: - Added my s-o-b to all patches.

    - Separated clk/regulator nodes renaming patch and gave Thierry Reding
      credit for that.

    - Borrowed "ARM: tegra: Add #reset-cells for Tegra114 MC" patch from
      Thierry to resolve merge conflict with the video decoder patch.

    - Added old patch from Stefan Agner that enables gpio-ranges, it was
      brought up in the other DT thread. I borrowed "ARM: tegra: Remove stray
      #reset-cells property" patch from Thierry to resolve merge conflict of
      these patches.

    - Reordered all DT nodes alphabetically.

    - Enabled couple more options in tegra_defconfig needed by Nyan
      Chromebook, as was requested by Thomas Graichen.

    - Improved thermal zones of TF101, making them to match what latest
      DT of Acer A500 uses. Previous versions used older variant of the
      A500 zones.

v5: - Minor update. Maxim improved commit messages. We added links to the
      postmarketOS Wiki.

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
  ARM: tegra: Rename top-level clocks
  ARM: tegra: nexus7: Drop clock-frequency from NFC node

Dmitry Osipenko (7):
  ARM: tegra: Add device-tree for 1080p version of Nyan Big
  ARM: tegra: Enable HDMI CEC on Nyan
  ARM: tegra: Enable CPU DFLL on Nyan
  ARM: tegra: Add CPU thermal zones to Nyan device-tree
  ARM: tegra: Rename top-level regulators
  ARM: tegra_defconfig: Enable drivers wanted by Acer Chromebooks and
    ASUS tablets
  ARM: config: multi v7: Enable display drivers used by Tegra devices

Maxim Schwalm (2):
  ARM: tegra: Add common device-tree for LVDS display panels of Tegra30
    ASUS tablets
  ARM: tegra: nexus7: Use common LVDS display device-tree

Michał Mirosław (2):
  ARM: tegra: Add labels to tegra30.dtsi
  ARM: tegra: Add device-tree for ASUS Transformer Pad TF300T

Nikola Milosavljevic (1):
  ARM: tegra: Add device-tree for ASUS Transformer EeePad TF101

Stefan Agner (1):
  ARM: tegra: Re-add gpio-ranges properties

Stefan Eichenberger (1):
  ARM: tegra: Add usb-role-switch property to USB OTG ports

Svyatoslav Ryhel (6):
  dt-bindings: ARM: tegra: Document ASUS Transformers
  ARM: tegra: Add common device-tree base for Tegra30 ASUS Transformers
  ARM: tegra: Add device-tree for ASUS Transformer Prime TF201
  ARM: tegra: Add device-tree for ASUS Transformer Pad TF300TG
  ARM: tegra: Add device-tree for ASUS Transformer Infinity TF700T
  ARM: tegra: Add device-tree for Pegatron Chagall

Thierry Reding (2):
  ARM: tegra: Add #reset-cells for Tegra114 MC
  ARM: tegra: Remove stray #reset-cells property

 .../devicetree/bindings/arm/tegra.yaml        |   19 +
 arch/arm/boot/dts/Makefile                    |   10 +-
 arch/arm/boot/dts/tegra114-asus-tf701t.dts    |  788 +++++
 arch/arm/boot/dts/tegra114-dalmore.dts        |   16 +-
 arch/arm/boot/dts/tegra114-roth.dts           |   14 +-
 arch/arm/boot/dts/tegra114-tn7.dts            |    8 +-
 arch/arm/boot/dts/tegra114.dtsi               |   92 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi   |    1 +
 arch/arm/boot/dts/tegra124-apalis.dtsi        |    1 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     |   26 +-
 arch/arm/boot/dts/tegra124-nyan-big-fhd.dts   |   11 +
 arch/arm/boot/dts/tegra124-nyan.dtsi          |   84 +-
 arch/arm/boot/dts/tegra124-venice2.dts        |   30 +-
 arch/arm/boot/dts/tegra124.dtsi               |    2 -
 .../boot/dts/tegra20-acer-a500-picasso.dts    |   12 +-
 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 1228 ++++++++
 arch/arm/boot/dts/tegra20-harmony.dts         |   16 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts     |    8 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |    6 +-
 arch/arm/boot/dts/tegra20-plutux.dts          |    8 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        |   16 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |    4 +-
 arch/arm/boot/dts/tegra20-tec.dts             |    8 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |   12 +-
 arch/arm/boot/dts/tegra20-ventana.dts         |   12 +-
 arch/arm/boot/dts/tegra20.dtsi                |    2 -
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
 .../dts/tegra30-asus-transformer-common.dtsi  | 1729 ++++++++++
 arch/arm/boot/dts/tegra30-beaver.dts          |   20 +-
 arch/arm/boot/dts/tegra30-cardhu-a02.dts      |   12 +-
 arch/arm/boot/dts/tegra30-cardhu-a04.dts      |   14 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |   28 +-
 arch/arm/boot/dts/tegra30-ouya.dts            |    5 -
 .../arm/boot/dts/tegra30-pegatron-chagall.dts | 2794 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |   38 +-
 arch/arm/configs/multi_v7_defconfig           |    5 +
 arch/arm/configs/tegra_defconfig              |   12 +
 46 files changed, 10497 insertions(+), 271 deletions(-)
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

