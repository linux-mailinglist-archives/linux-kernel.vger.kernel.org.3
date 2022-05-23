Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB23530BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiEWI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiEWI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:59:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D153F887
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so13099701pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMEwaRdkK6gE09/mmANscyqoJ+JW8Xoy8gSdws+X3CU=;
        b=mkNY3d+5RlbDWdouuXPsy1WvOh+zU87uNKtUTkm9AcaCWm0r9V283zxllQK6aSJoKQ
         Ucs1qBRgu/49mmaFA5seFi/iJq6QCbChfS2b7YwFwaXDRy1MIYOlLE9ekoe27o4nQtan
         EYO88bor9rTAR40gMFXe1fFcDUiNgsEuJjG1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMEwaRdkK6gE09/mmANscyqoJ+JW8Xoy8gSdws+X3CU=;
        b=0/kRqlEDyG2UcFgDgyryP8d8wu3aJHZcEU7V7cidr7AUNKqH2WDO/SBwwrL0Rp7Vyh
         0HWAZwpW/qCXmHPOKavmszYTqfKOluo6yrjG+LGfl7EzAmw1UXgMZaUQ5qg3jW3+kHqr
         RgxIUh6I1X3MqWreTWQT45Ob+jfo4a07t45cxnYUl1GQKbAb+JjuH/46l5sCzd/xB4UN
         UfIAxazlnk+lQaIKeRHdBsoHZSE72SSVrBoxLd5tll0H269q/LRsOF+pJ3bRzPe0xjzS
         UAsx62Qu7CCDNXIMrQ/OZ7lcIS6mXZPLXaHmAN2IK8qOjZwRtYvvNzE/En4iZYbpe+w9
         i10Q==
X-Gm-Message-State: AOAM530mIxRqvP+nBwlE1AvtQYGrXPjssuUBYCwTiJtG3NT7D+CKuDuE
        wslyMJm3IU2cYPtLAMTeiWofkA==
X-Google-Smtp-Source: ABdhPJzNLddUk7ipQY1wuXRZkYOdiG4wWOnnnSjuM50zWAjN7OkfYPxwabHbECLBOj6SZkTW6IPA+A==
X-Received: by 2002:a65:6413:0:b0:3f5:f306:d2f7 with SMTP id a19-20020a656413000000b003f5f306d2f7mr19551046pgv.341.1653296377785;
        Mon, 23 May 2022 01:59:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1b8:7eae:9793:ff95])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902cf4b00b0015e8d4eb22csm4524719plg.118.2022.05.23.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:59:37 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: mediatek: mt8183: Fix GPU/MFG clock rate changing
Date:   Mon, 23 May 2022 16:59:19 +0800
Message-Id: <20220523085923.1430470-1-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v2 of my MT8183 GPU clock rate fix series.

Changes since v1;
- Moved clk notifier registration into separate function
- Fixed comment style

This series fixes the clock rate changing for the GPU. This work came
about as part of adding DVFS support for the Mali GPU on MT8183, to
support efforts in testing the SVS patches [1] on MT8183.

This series fixes a couple things:

1. Fix the clock reference for the GPU. The device tree incorrectly
   references the top level PLL, when in fact it is fed from the clock
   gate in the MFGCFG block. Fixed in patch 1.

2. Clock rate requests on the MFG clock gate aren't propagated up the
   tree. Fixed in patch 2 by adding CLK_SET_RATE_PARENT.

3. MFG clock needs to be temporarily muxed away from MFG PLL during PLL
   reconfiguration, to avoid glitches. This is done using a notifier.
   The framework is added in patch 3, and added to the driver in patch 4.

This is based on my "clk: mediatek: Move to struct clk_hw provider APIs"
series version 3 [2], which was just merged.

Please have a look.

The GPU DVFS stuff will be sent separately, as that part is a bit more
contentious, and the changes span more subsystems.


Regards
ChenYu

[1] https://lore.kernel.org/linux-mediatek/20220516004311.18358-1-roger.lu@mediatek.com/
[2] https://lore.kernel.org/linux-mediatek/20220519071610.423372-1-wenst@chromium.org/

Chen-Yu Tsai (4):
  arm64: dts: mt8183: Fix Mali GPU clock
  clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
  clk: mediatek: mux: add clk notifier functions
  clk: mediatek: mt8183: Add clk mux notifier for MFG mux

 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c |  6 ++--
 drivers/clk/mediatek/clk-mt8183.c        | 28 ++++++++++++++++
 drivers/clk/mediatek/clk-mux.c           | 42 ++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h           | 15 +++++++++
 5 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

