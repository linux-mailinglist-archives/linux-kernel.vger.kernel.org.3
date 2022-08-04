Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D43589C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiHDNKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiHDNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:09:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7118E21
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:09:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso2480236wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/550FRoRwhwiWa23UJcURfUhwjAKd0WneHpFmZPlwqw=;
        b=nHKiKcjX72Na/r5yh2xsHteZvjaIFfk3+PwiCpogq5p/Or0Oc//pj3zPrKYmUlEr5V
         zLzQZ6rmU6Vfkv7uL/DnL7HAtHYnNAakGKkSMbjXhzbQs4HqtZv6UZOy2M016wbIWgOy
         +wApUHQaQwm0NLF//egJ1amCnId7COEMhnaOMeqGrgXo926zvAgU95BqKK5Gb+xQjBT3
         78zRJKXfTDc1hvcTOVzh3sfxdDQIiDw8zG0v8RDVUyZXLquxH67A7briquUYzekmDgs/
         igPuK2C7sPS8vFK0ZEK4GTesaEfgxsLQ4Hxy4+Bi1uFlZI8LKWcSu89Zami5qbnQIanR
         A5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/550FRoRwhwiWa23UJcURfUhwjAKd0WneHpFmZPlwqw=;
        b=Yz+N8fqd4Kc/qNzr5vhRLXArL8kDmmnHh6HaOrBSgtYXgsnRWRnt1hMWHYmr64tNj2
         JMsiBA+kDG27RnjKICZmW2WrUI0hOKYNvsasV04+5i4hJBnRCmmJbCWsBCOdA97zwRen
         GdYwCuPuDdh/Gpw/gX3fmdPiRQaz8v3mnO+23Y6swhRoz/4yDvZRXSdPxez9wkQWC29u
         JVKdvW75Mgna4HHhWRICuKv887URjvAXX6vUHiIk6GG+pB1smuoL0IPa9uBntte5fIVN
         elC1dYO6SZmaMU61wyFeEggU0Lvy5ZbLXFYq1yTGeOSwMfZCGYm054gGwvABV8K/F9za
         pSDQ==
X-Gm-Message-State: ACgBeo2oJYsySM5tO0AAJv++wBcqoF6ovnbQ9clVqsfOnCYVLV8jnEyW
        BkVY4YMDGUdnrnPErjtdv6XIKw==
X-Google-Smtp-Source: AA6agR5EDjcdFhE33k318QdP42SioQ8FJinf54Xtn+XGNTbDKaLLK6czAFeIqHHSqOI7XN4hCvAOog==
X-Received: by 2002:a05:600c:4fd4:b0:3a3:2c30:5749 with SMTP id o20-20020a05600c4fd400b003a32c305749mr1405025wmq.62.1659618596268;
        Thu, 04 Aug 2022 06:09:56 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.. (235.163.185.81.rev.sfr.net. [81.185.163.235])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm1156817wrj.47.2022.08.04.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:09:55 -0700 (PDT)
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
Subject: [PATCH v8.1, 0/7] Add LVTS architecture thermal
Date:   Thu,  4 Aug 2022 15:09:05 +0200
Message-Id: <20220804130912.676043-1-bchihi@baylibre.com>
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

From: Balsam CHIHI <bchihi@baylibre.com>

This series moves thermal files related to MediaTek to the mediatek folder.
And introduce the new architecture LVTS (low voltage thermal sensor) driver to report
the highest temperature in the SoC and record the highest temperature sensor,
each sensor as a hot zone.
The LVTS body is divided into two parts, the LVTS controller and the LVTS device.
The LVTS controller can connect up to 4 LVTS devices, and each LVTS device
can connect up to 7 TSMCUs.

The architecture will be the first to be used on mt8192 and mt8195.

Changelog:
Changes in v8.1 :
        - Fix Coding style issues
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
  dt-bindings: thermal: Add binding document for LVTS thermal
    controllers
  arm64: dts: mt8195: Add efuse node to mt8195

Balsam CHIHI (1):
  arm64: dts: mt8192: Add thermal zone

Michael Kao (3):
  thermal: mediatek: Relocate driver to mediatek folder
  thermal: mediatek: Add LVTS driver for mt8192 thermal zones
  thermal: mediatek: Add thermal zone settings for mt8195

Tinghan Shen (1):
  arm64: dts: mt8195: Add thermal zone

 .../thermal/mediatek,lvts-thermal.yaml        |  77 ++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 113 ++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 125 ++-
 drivers/thermal/Kconfig                       |  14 +-
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/mediatek/Kconfig              |  47 +
 drivers/thermal/mediatek/Makefile             |   3 +
 drivers/thermal/mediatek/lvts_thermal.c       | 855 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.h       | 377 ++++++++
 drivers/thermal/mediatek/lvts_v4.c            | 464 ++++++++++
 .../mtxxxx_thermal.c}                         |   2 +-
 11 files changed, 2065 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.h
 create mode 100644 drivers/thermal/mediatek/lvts_v4.c
 rename drivers/thermal/{mtk_thermal.c => mediatek/mtxxxx_thermal.c} (99%)

-- 
2.34.1

