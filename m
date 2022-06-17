Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3EA54F67E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382352AbiFQLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380571AbiFQLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:12:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F322500;
        Fri, 17 Jun 2022 04:12:53 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B53C4660179A;
        Fri, 17 Jun 2022 12:12:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655464372;
        bh=gW6UerJ1ORzjD0MbtZbHUrldkZVnFiwBi9ZNmW1eHC4=;
        h=From:To:Cc:Subject:Date:From;
        b=RaLfKMPnFOjxHSKNhZi9a076M0kae3pMwZPels+9MG7T2PpBuOzGeANIeecEnyxv1
         yBq0dD6q91QPoRPUGw6NB5zX74ty0TcTp0AB8yQnuplI/SELLOWZyokBz6+om4u23l
         RKzlH8jOExlvcCwKhsYVRBcuZmrI8jyLnCLPKDjtQ/W5gas0NcSQtLBRiiM0fEg0Om
         wHHIM6Y7u2znG3dFXGhvqGroM3d/ZFqDqvJ8BrMXdApmuLpGuw5LcGWohiubucE6cj
         YXtNoTcxvN8A5V4eH37yWm1aI9rOP5RxfVpebCKbsZHAw3y0p5/OvulpMCp3c9RNbe
         f7V8MV84larPA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] MediaTek Kompanio 1200 MT8195 - DisplayPort clocks fixes
Date:   Fri, 17 Jun 2022 13:12:46 +0200
Message-Id: <20220617111248.90505-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the two DPINTF clocks to propagate rate change
requests to their own parent (and also fixes vdo1_dpintf's parent name).

This is needed in order to stay clean in the DisplayPort driver and
avoid adding (now useless) custom handling of clocks reparenting based
on the wanted final clock rate.

Changes in v3:
 - Fixed tags ordering.

AngeloGioacchino Del Regno (2):
  clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's
    parent
  clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's
    parent

 drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.35.1

