Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F409581494
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiGZNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiGZNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:55:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC3A6567
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v13so12488352wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRAXgknnujaKg4Y8xAc9gwmU3XgmouGtPlayIr+CeFQ=;
        b=KrVhtqwt4ghxBcQ7BHk+gIXSc0ZctgVQNeRus03e1qw1Zb4a9TF+doBcOiaOIIwUFF
         FWRcPWIAVVnV6sMOcMnxH1HwxhsDNx5/YRtWaxR+Mf4JVtFMaPhAOsRl6XmhaJveJQlW
         Mt655y8Bz1uN9vZHplDqRNHvFnabzBLWwSd4f3oVQoPSekjsolFtNP75kuRmDVpgO3P+
         Av9HfTgLCx/lifQnvkRfvhpqMPTy9XVoTRdPJKLkU2XcglCPo8SiGgKY8ZFdHCWHD71R
         pOG5j/iRUnlLmc3y8Ut1uTwIIVlskDbob1uj+sQsgX3FlK97jNzyu9+Cb5aqH9/XCccb
         JxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRAXgknnujaKg4Y8xAc9gwmU3XgmouGtPlayIr+CeFQ=;
        b=mSP1NZ5USL6nL/MO0EmYWMFddc+Y4PLNhn+vm2veO5aERSk5zF1xF4ou2/Y5fzVGlv
         aDTsj0gGFJvxJEA7M+TtVeZvZnH4pEYjkkGW25D+0XFnj1No9D8lGfJMh94Y5o3zO7E7
         0tYx3Mgjj50n2qBVaXkfXSiPeGwseFitKLXQ/R24TQNPe27SU+VmWXBGzS1zeV1rXx4m
         3+s+kPt8Vx++NYo9A7vBOwwFRcXl8wJGCXffDWxT8Ds93aHUpApbJMf6TJZ6EAXdFY9S
         qmeAEI+YnvRNxHG8I6Qr5RLodnZRZrLHiFOi65dQGXFUb/se8qBMza817Snlmu0E/VcG
         bHjw==
X-Gm-Message-State: AJIora8i+cnRp/Weec1POolsuqN2TwsZ+KzEXVBqBL8k7I7lxJiNdQTU
        ldFEiF+OzlzQoCs2TlEmRWPX9A==
X-Google-Smtp-Source: AGRyM1s4PQktP1/lpdXvhNgX9YiuT1FJm8lx9eDXYPnVNEEQe4+s8xmvMXcX7o+RyaDnO0TXbFY7Kw==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id u11-20020a5d6dab000000b0021d9fc83029mr11140889wrs.172.1658843716767;
        Tue, 26 Jul 2022 06:55:16 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d13-20020adf9c8d000000b0021e4c3b2967sm15244670wre.65.2022.07.26.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:55:16 -0700 (PDT)
From:   Balsam CHIHI <bchihi@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v8 0/6] Add LVTS architecture thermal
Date:   Tue, 26 Jul 2022 15:55:00 +0200
Message-Id: <20220726135506.485108-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves thermal files related to MediaTek to the mediatek folder.
And introduce the new architecture LVTS (low voltage thermal sensor) driver to report
the highest temperature in the SoC and record the highest temperature sensor,
each sensor as a hot zone.
The LVTS body is divided into two parts, the LVTS controller and the LVTS device.
The LVTS controller can connect up to 4 LVTS devices, and each LVTS device
can connect up to 7 TSMCUs.

The architecture will be the first to be used on mt8192 and mt8195.

Changelog:
Changes in v8:
        - Fix Coding style issues
        - Rebase to kernel-5.18.rc8
        - Rebase on top of these series :
          - [RESEND v8 00/19] Cleanup MediaTek clk reset drivers and support SoCs :
                https://lore.kernel.org/all/20220523093346.28493-1-rex-bc.chen@mediatek.com/
          - [PATCH v6 00/12] thermal OF rework :
                https://lore.kernel.org/all/20220722200007.1839356-1-daniel.lezcano@linexp.org/
        - Add multi-instance support and SRC Modularization :
          - Rewrite DTS and DT bindings
            - Add DT bindings for MT8195
            - One LVTS node for each HW Domain (AP and MCU)
          - One SW Instance for each HW Domain, for each SoC
          - Add an SRC file for each SoC (MT8192 and MT8195)
          - Add a Kconfig sub-menu entry for each SoC
        - Shrink LVTS instance iospace length from 0x1000 to 0x400
        - Replace platform_get_resource by platform_get_mem_or_io to get Base Address
        - Replace platform_get_resource by platform_get_irq to get Interrupt Number
        - Add "lvts_" prefix to functions and structs

Changes in v7:
        - Fix coding style issues
        - Rewrite dt bindings
          - was not accurate
          - Use mt8195 for example (instead of mt8192)
          - Rename mt6873 to mt8192
          - Remove clock name
        - Rebased on top of to series:
          - https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
          - https://patchwork.kernel.org/project/linux-pm/list/?series=639386

Changes in v6:
        - Remove temperature aggregation (it will be added in another series)
        - Update the way to read the temperature (read one sensor instead of all)
        - Add support of mt8195

Changes in v5:
        - Use 'git mv' for the relocated file.

Changes in v4:
        - Rebase to kernel-v5.13-rc1
        - Resend

Changes in v3:
        - change the expression in the lvts_temp_to_raw to dev_s64.

Changes in v2:
        - Rebase to kernel-5.11-rc1.
        - sort headers
        - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
        - disconstruct the api of lvts_read_tc_msr_raw.
        - add the initial value max_temp = 0 and compare e.q.
          in the lvts_read_all_tc_temperature.
        - add the return with an invalid number in the lvts_init.

This series depends on [1] and [2].

[1]https://lore.kernel.org/all/20220523093346.28493-1-rex-bc.chen@mediatek.com/
[2]https://lore.kernel.org/all/20220722200007.1839356-1-daniel.lezcano@linexp.org/

Alexandre Bailon (2):
  dt-bindings: thermal: Add binding document for LVTS thermal
    controllers
  arm64: dts: mt8195: Add efuse node to mt8195

Michael Kao (3):
  thermal: mediatek: Relocate driver to mediatek folder
  thermal: mediatek: Add LVTS drivers for SoC theraml zones for mt8192
  thermal: mediatek: Add thermal zone settings for mt8195

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zone

 .../thermal/mediatek,mt8192-lvts.yaml         |  73 ++
 .../thermal/mediatek,mt8195-lvts.yaml         |  75 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 131 ++-
 drivers/thermal/Kconfig                       |  14 +-
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/mediatek/Kconfig              |  62 ++
 drivers/thermal/mediatek/Makefile             |   4 +
 drivers/thermal/mediatek/lvts_mt8192.c        | 241 +++++
 drivers/thermal/mediatek/lvts_mt8195.c        | 253 +++++
 .../{mtk_thermal.c => mediatek/soc_temp.c}    |   2 +-
 drivers/thermal/mediatek/soc_temp_lvts.c      | 928 ++++++++++++++++++
 drivers/thermal/mediatek/soc_temp_lvts.h      | 366 +++++++
 12 files changed, 2138 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 create mode 100644 drivers/thermal/mediatek/lvts_mt8192.c
 create mode 100644 drivers/thermal/mediatek/lvts_mt8195.c
 rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (99%)
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
 create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h

-- 
2.34.1

