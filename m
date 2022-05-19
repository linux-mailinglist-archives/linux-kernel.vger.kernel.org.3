Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314C52D5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiESOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiESOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:24:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD505B82C9;
        Thu, 19 May 2022 07:23:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t2so599967qkb.12;
        Thu, 19 May 2022 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qa+RmjWGq636GZ/8xymXuJ2O/Y4ZrpNYQ00uYeEnnps=;
        b=GtwDUuXWMikoAdpZO5iESljNOMEVwaut9jSbx04nSn/WsKu8Xkw384UfcB5+2X6scR
         PJBqMPwQCmFLfHBUd54VAq8Y2PcKY83iffpbQFedSLtz7zAk6BxMPVkIxQ6GWvPKqbPr
         BKjuTH/Qrd7iN9Pb1CdNBG+q8aTXnzFMwSWvsSjAl7vo4kCvhLwYrXb0hT5VtVBFQqm3
         l7A7BpXBaCGM5y6sVYf/ydOD/xiczCPksHyvaTbg/7tmD+pzW0mABofHjXEGv3/F8BAR
         TnD2/A6/iSwYBDqbnhGHGD/1fcZGP6VrTw9CG2DV8UrrRYHTJvzaLH1MCSALg261+XXu
         EcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qa+RmjWGq636GZ/8xymXuJ2O/Y4ZrpNYQ00uYeEnnps=;
        b=Gf20gElKXG0UX1JGs/PWZ+LZ0HHA/ZuFPHct294lsIJq5Gkh27dxZGMMV/5MTZU3pp
         4/USsWSP2nWGufyyr+xlo3lJIz3UfKF2dMPAqQMEBD59v+h5lNZhsXDVR++cWj2+CfBk
         e3qmG5O77Lp52sCyx0KVt6kRJrWssxSqjWY2abll34k4jWPDBMTs+R5Fzfuml5MJHYHp
         YQ9utfcdjzoKa2LEpCXIAPWsFcmEy7KI6LLMwP3Rl7HMacvidDwD1Rti6WJATpGKa/ZW
         Wog56F9Bcy70+cx/mrUs2QOnI0Weu90MZvOwy7M/xgzacrLm2AmePnFxFJZWgfCX+gsR
         0wKQ==
X-Gm-Message-State: AOAM530/qQnnKp+e2htpPAyn5X30MidZGrgJZGiMuN1mDp41+exrnHzJ
        czYH7veTqg2qVhg+KGe4IBs=
X-Google-Smtp-Source: ABdhPJzTGJKtnF2Jao6mYEzO1MdxqaX7B7cQMJFc5dHa8sZmNVz1kZcmFh865P78KZqTjAs5O9p4Cw==
X-Received: by 2002:a05:620a:46a1:b0:6a0:465e:ccca with SMTP id bq33-20020a05620a46a100b006a0465ecccamr3116751qkb.631.1652970238949;
        Thu, 19 May 2022 07:23:58 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id c15-20020ac85a8f000000b002f39b99f697sm1539342qtc.49.2022.05.19.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:23:58 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/4] Mediatek MT6735 main clock and reset drivers
Date:   Thu, 19 May 2022 18:22:07 +0400
Message-Id: <20220519142211.458336-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
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

Tested on a Samsung Galaxy Grand Prime+ "grandpplte" with MT6737T, a slight
variant of MT6735 with no known differences in the clock controllers. 

Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
- clk: mediatek: Improvements to simple probe/remove and reset controller unregistration
  https://patchwork.kernel.org/project/linux-clk/cover/20220519134728.456643-1-y.oudjana@protonmail.com/

Above are dependencies for patch 4/4 only; DT bindings don't need them.

Changes since v1:
- Rebase on some pending patches (listed as dependencies above).
- Move common clock improvemenets to a separate series (last dependency
  listed above).
- Use mtk_clk_simple_probe/remove after making them support several clock types
  in said series.
- Combine all 4 drivers into one patch, and use one Kconfig symbol for all
  following a conversation seen on a different series[1].
- Correct APLL2 registers in apmixedsys driver (were offset backwards by 0x4).
- Make irtx clock name lower case to match the other clocks.

[1] https://lore.kernel.org/linux-mediatek/CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com/

Yassine Oudjana (4):
  dt-bindings: clock: Add Mediatek MT6735 clock bindings
  dt-bindings: reset: Add MT6735 reset bindings
  dt-bindings: arm: mediatek: Add MT6735 clock controller compatibles
  clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |    8 +-
 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |    4 +-
 .../bindings/clock/mediatek,topckgen.yaml     |    4 +-
 MAINTAINERS                                   |   16 +
 drivers/clk/mediatek/Kconfig                  |    9 +
 drivers/clk/mediatek/Makefile                 |    1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c  |  235 ++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c    |  205 ++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c     |  301 +++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c    | 1087 +++++++++++++++++
 .../clock/mediatek,mt6735-apmixedsys.h        |   16 +
 .../clock/mediatek,mt6735-infracfg.h          |   25 +
 .../clock/mediatek,mt6735-pericfg.h           |   37 +
 .../clock/mediatek,mt6735-topckgen.h          |   79 ++
 .../reset/mediatek,mt6735-infracfg.h          |   31 +
 .../reset/mediatek,mt6735-pericfg.h           |   31 +
 17 files changed, 2085 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
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
2.36.1

