Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B5519F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349524AbiEDMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349591AbiEDMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:32:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614B30576;
        Wed,  4 May 2022 05:28:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id be20so1489353edb.12;
        Wed, 04 May 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8deg2KLDPfn0MYLkDdTzpE851zZE5QzG2ocaiOOkBo=;
        b=CLTbKxWNFX6edptI+ZvYTsXKN81abpGJmTLXmBFKatFJax0iYOADG2PnCoD+/l2VwA
         UTy4Ng6y6ptMNezJx/4XMUPYUJJAgvMWuzzmTwKFUkUFIv0epgIVsL5U70nxYIz5LwV8
         9vLpv8YKG7TBGlUdUrHoQepDCvzZ5DUa/+BDwy47FwDS3i51ok/Tt02EAJqjMRZNaENm
         ShehKHGJTI+EyGYgS18O4GjAc5u5IupRKsMIKrUQrkAB4wPzCW9lNk7iRpUpUH5Wfcfb
         9yS/5g40xIJ3BzqRgHvgaMZizwhDizJR7u/JqyDu7rPhRUDbK3hdCWguH9WRf5NZc98J
         aTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8deg2KLDPfn0MYLkDdTzpE851zZE5QzG2ocaiOOkBo=;
        b=PysMEXJWWHjDUD95vJyF6QHbkd3RAc9aVEsaW7Vuo7b1dy01NHA/tpkEjVhaMnn1Cj
         32y2IHUTJMA2rB9ZF6FaejCti8+XJO0p3kL/rYsV7Vg2Ov5TFDlw6Pv5fxWB4s9kDJn3
         4o92VrIOdQ1wOI12/S7sz2ZVKi6aPplcl/q5I95HXFHmBh8C49uuyo7W+UsWVLxZVmLe
         0NvIAxz31orGHINTD4kIWaJ+gupBpq18VFGMraZotwTNofQETK5pjQJHxlc6fhOaC62Q
         +2oqvAY3Wfnp93PdwIq9bA3qNThWBFXLnMqbl01thTPr/Y3uIgVVnoNim99vWHqDr9ab
         W07A==
X-Gm-Message-State: AOAM531CJW38L8Fie+kXIiI0hqWqqr9KKgC2PedHv2RZsyE32gdRU+gA
        Knq2e4mc9b8O2lDaAhZs96s=
X-Google-Smtp-Source: ABdhPJx78kwFzBXfvJvi8YwuMRvR0iUjeHn1QZnqQXHsSFpeV5QrHysEmB7yI8b1v+iASOqFaO2LQA==
X-Received: by 2002:aa7:d459:0:b0:427:bd8f:61f8 with SMTP id q25-20020aa7d459000000b00427bd8f61f8mr16374482edr.157.1651667305522;
        Wed, 04 May 2022 05:28:25 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:28:25 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/13] Mediatek MT6735 main clock and reset drivers
Date:   Wed,  4 May 2022 16:25:48 +0400
Message-Id: <20220504122601.335495-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

This series adds support for the main clock and reset controllers on the
Mediatek MT6735 SoC:
- apmixedsys (global PLLs)
- topckgen (global divisors and muxes)
- infracfg (gates and resets for internal components)
- pericfg (gates and resets for peripherals)

MT6735 has other more specialized clock controllers, support for which is
not included in this series:
- imgsys (camera)
- mmsys (display)
- vdecsys (video decoder)
- audsys (audio)

Some symbols in common objects are exported to get the drivers to compile
as modules, and mtk_unregister_reset_controller() is implemented to allow
for unregistering reset controllers in the infracfg and pericfg drivers
when unloading them.

Yassine Oudjana (13):
  dt-bindings: clock: Add Mediatek MT6735 clock bindings
  dt-bindings: reset: Add MT6735 reset bindings
  dt-bindings: arm: mediatek: Add MT6735 clock controller compatibles
  clk: composite: Export clk_unregister_composite
  clk: mediatek: Export mtk_free_clk_data
  clk: mediatek: Add driver for MT6735 apmixedsys
  clk: mediatek: Add driver for MT6735 topckgen
  clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
  clk: mediatek: reset: Export mtk_register_reset_controller symbols
  clk: mediatek: reset: Return mtk_reset pointer on register
  clk: mediatek: reset: Implement mtk_unregister_reset_controller() API
  clk: mediatek: Add driver for MT6735 infracfg
  clk: mediatek: Add driver for MT6735 pericfg

 .../arm/mediatek/mediatek,infracfg.yaml       |    8 +-
 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |    4 +-
 .../bindings/clock/mediatek,topckgen.yaml     |    4 +-
 MAINTAINERS                                   |   16 +
 drivers/clk/clk-composite.c                   |    1 +
 drivers/clk/mediatek/Kconfig                  |   28 +
 drivers/clk/mediatek/Makefile                 |    4 +
 drivers/clk/mediatek/clk-gate.c               |    1 +
 drivers/clk/mediatek/clk-mt6735-apmixed.c     |  274 ++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c    |  265 ++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c     |  360 +++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c    | 1159 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |    1 +
 drivers/clk/mediatek/clk-mtk.h                |    8 +-
 drivers/clk/mediatek/reset.c                  |   31 +-
 .../clock/mediatek,mt6735-apmixedsys.h        |   16 +
 .../clock/mediatek,mt6735-infracfg.h          |   25 +
 .../clock/mediatek,mt6735-pericfg.h           |   37 +
 .../clock/mediatek,mt6735-topckgen.h          |   79 ++
 .../reset/mediatek,mt6735-infracfg.h          |   31 +
 .../reset/mediatek,mt6735-pericfg.h           |   31 +
 22 files changed, 2366 insertions(+), 18 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

-- 
2.36.0

