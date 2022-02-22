Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B584BF705
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiBVLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBVLMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:12:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41569CE5;
        Tue, 22 Feb 2022 03:11:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9BAB21F43807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645528309;
        bh=SPtw+f0uHGh08y5gDzh4Xpm3f82+7RZ5orhUcUoZYGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Q8d20dSILE8ww4QUrdFkHqSYnNYsuq2cRc0b/Ej7cJTuNW1x35LEMn4ilzCqA1s7d
         Wb+puAdIWbkhmgsingHyjCFZfK+d4pMFANtEEE2+jdDKTm4P9fmWdYuIgjhhLovFY+
         8VICeT1K1kEl58iyJJ3/OQLFLftxktUV9u70O9sQsr5kQa+pIxc0uUJA5d9ioYCYbz
         ULJNq3jU2dLkfH9HRohBkB0H87jTrQydMIwV5n8X6Ntux0056ZvlK1VjJDonMIhgWx
         snMfsBfwgm5mM9CagkAoZlXcQEa/9E40mOBCUqB1hMlv+w3VTMstU52CadZc+wtQam
         UHLC0NmOQIwsg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/5] MediaTek pinctrl drivers cleanups
Date:   Tue, 22 Feb 2022 12:11:39 +0100
Message-Id: <20220222111144.20796-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
This series performs some cleanups to the MediaTek pinctrl drivers
by commonizing some functions (reducing code duplication) hence also
simplifying the probe mechanism by removing unnecessary per-driver
probe functions.

This code was tested against multiple platforms.

Changes in v2:
- Patch 2/5: Changed -ENOENT to -ENODEV as per Chen-Yu's suggestion
- Patch 4/5: Removed unnoticed wrong comment change (Chen-Yu)

AngeloGioacchino Del Regno (5):
  pinctrl: mediatek: paris: Unify probe function by using OF match data
  pinctrl: mediatek: common-v1: Add common probe function
  pinctrl: mediatek: common-v1: Use common probe function
  pinctrl: mediatek: common-v1: Commonize spec_pupd callback
  pinctrl: mediatek: common-v1: Commonize spec_ies_smt_set callback

 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 40 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 44 +++----------
 drivers/pinctrl/mediatek/pinctrl-mt6765.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt6779.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 39 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     | 17 ++----
 drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 29 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8183.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8195.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 61 ++++++++++++++-----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 33 +++++++---
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  9 ++-
 drivers/pinctrl/mediatek/pinctrl-paris.h      |  3 +-
 18 files changed, 164 insertions(+), 285 deletions(-)

-- 
2.33.1

