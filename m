Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE2596B15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHQIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiHQIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:08:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E223886
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso617854wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=FReJMBf95H2JfN4DKIQUZZ6GIrrtBYj3TLkuD2pMf0s=;
        b=RcVq+ObdeIi7ZLr6AMU3AB54FBYZH7guJh6ve1QACpVUpJETIFopJGz8loArxpABiL
         KkSwJH/vmTZTi8mrulzR426QRrU36IrQ9q3PG12zYkq8WePLauXjQqDePVZNyaVDfzo9
         ote+zBprUUzlUzCBEc9fxtYG0kjz/awj86x++3JiVar64CxQpT5iLooy5yN3EImF4u2T
         sbTWeYxfyy1g0V0zdJdd0whB/SquCv57ELEWshnInPon9H2EsuYIWKFsBrtuz7iee1QK
         a2XF3okA4+FGd+p8klk3tUFgd2sVEED1OAnhYaUVeQlayxRzbxqV53jSUzNmYSJ/iE99
         VSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=FReJMBf95H2JfN4DKIQUZZ6GIrrtBYj3TLkuD2pMf0s=;
        b=TTjB8brfvus9FL9Q5JGGJPrTqMhHzCrlosi9zkbpG10elaq4fuunYUQWYoWhuokCfo
         I6uGXJZ2ExBWfFwHxcaB5fbggGDpnNDzTmjPpgFWvOqnvqTzP4C6ABTH8ynaQSOw2xd+
         3aWh3FPBHYp88Wes16+gyyf37WAWCQSH1gb9FLmvPExu2wKjn25ROnfUP51QYki07nAH
         AfHXEnThSFU1R80p9iwwtqGGJP4ablP7DWUBnqXw1UaUjU8q8itQS5dbPiPpsecmImda
         eCF6idEGHetBvQPrag5IiiqZ/98LvniLdXpJlWo91OMGN9J0u06Vmc8jRx3FmDgOtjtR
         /Jpg==
X-Gm-Message-State: ACgBeo1eTv3onm5dDP51LVtdEthIy39d3GkbcuS3EQPfHkydKv/VDXve
        dLI1EXzIscJcIP+Z/EtxP0HweQ==
X-Google-Smtp-Source: AA6agR6i1YQzX7Wsp+ATSSC1+nOI/HUnFW47bFbYCczextOqeXGVcaG6bcEn9Fi9MQ9Kl3twixFhZA==
X-Received: by 2002:a05:600c:3b92:b0:3a6:8d6:9a2f with SMTP id n18-20020a05600c3b9200b003a608d69a2fmr1333371wms.159.1660723714458;
        Wed, 17 Aug 2022 01:08:34 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:33 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v9,0/7] Add LVTS thermal architecture
Date:   Wed, 17 Aug 2022 10:07:50 +0200
Message-Id: <20220817080757.352021-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Move thermal files related to MediaTek to the mediatek folder.
Introduce the new thermal architecture LVTS (Low Voltage Thermal Sensor) driver
to report the highest temperature in the SoC and record the highest temperature sensor,
each sensor as a thermal zone.
The LVTS body is divided into two parts, the LVTS controller and the LVTS device,
the LVTS controller can connect up to 4 LVTS devices, and each LVTS device
can connect up to 7 TSMCUs.

The architecture will be first used on mt8192 and mt8195.

Changelog:
Changes in v9 :
        - Rebase on top of 6.0.0-rc1
        - Fix coding style issues
        - Fix commit titles and commit messages
        - Update dt-bindings :
          - Add "allOf:if:then:"
          - Use mt8192 as example (instead of mt8195)
          - Fix dt-binding errors
        - Fix DTS errors

Changes in v8 :
        - Fix coding style issues
        - Rebase on top of next-20220803
        - Add multi-instance support :
          - Rewrite DT-binding and DTS :
            - Add DT-binding and DTS for LVTS_v4 (MT8192 and MT8195)
            - One LVTS node for each HW Domain (AP and MCU)
          - One SW Instance for each HW Domain
          - Add a Kconfig sub-menu entry for LVTS and LVTS_v4 SoCs
        - Replace platform_get_resource by platform_get_mem_or_io to get Base Address
        - Replace platform_get_resource by platform_get_irq to get Interrupt Number
        - Add "lvts_" prefix to functions and structs

Changes in v7 :
        - Fix coding style issues
        - Rewrite dt bindings
          - was not accurate
          - Use mt8195 for example (instead of mt8192)
          - Rename mt6873 to mt8192
          - Remove clock name
        - Rebased on top of to series:
          - https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
          - https://patchwork.kernel.org/project/linux-pm/list/?series=639386

Changes in v6 :
        - Remove temperature aggregation (it will be added in another series)
        - Update the way to read the temperature (read one sensor instead of all)
        - Add support of mt8195

Changes in v5 :
        - Use 'git mv' for the relocated file.

Changes in v4 :
        - Rebase to kernel-v5.13-rc1
        - Resend

Changes in v3 :
        - change the expression in the lvts_temp_to_raw to dev_s64.

Changes in v2 :
        - Rebase to kernel-5.11-rc1.
        - sort headers
        - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
        - disconstruct the api of lvts_read_tc_msr_raw.
        - add the initial value max_temp = 0 and compare e.q.
          in the lvts_read_all_tc_temperature.
        - add the return with an invalid number in the lvts_init.

Alexandre Bailon (2):
  dt-bindings: thermal: Add dt-binding document for LVTS thermal
    controllers
  arm64: dts: mt8195: Add efuse node to mt8195

Balsam CHIHI (1):
  arm64: dts: mt8192: Add thermal zones and thermal nodes

Michael Kao (3):
  thermal: mediatek: Relocate driver to mediatek folder
  thermal: mediatek: Add LVTS driver for mt8192 thermal zones
  thermal: mediatek: Add LVTS driver settings for mt8195 thermal zones

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zones and thermal nodes

 .../thermal/mediatek,lvts-thermal.yaml        | 152 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 111 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 123 +++
 drivers/thermal/Kconfig                       |  14 +-
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/mediatek/Kconfig              |  43 +
 drivers/thermal/mediatek/Makefile             |   3 +
 .../auxadc_thermal.c}                         |   2 +-
 drivers/thermal/mediatek/lvts_thermal.c       | 861 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.h       | 386 ++++++++
 drivers/thermal/mediatek/lvts_v4.c            | 479 ++++++++++
 11 files changed, 2164 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.h
 create mode 100644 drivers/thermal/mediatek/lvts_v4.c

-- 
2.34.1

