Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8192153268D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiEXJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiEXJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:35:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCC5FF36;
        Tue, 24 May 2022 02:35:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8719C1F42BE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653384912;
        bh=HPhSCFsRWt1WRYsQVwuXJfLERolxskKrILtU/HHC2QY=;
        h=From:To:Cc:Subject:Date:From;
        b=QRpNuS60XWbSPl2Q/45n7UwTA7/71z36HzZZwU+6jRJbt6Wfe4YAjV5IWbLPUYWAn
         cq3pw96Fo2Z+QyjZ4DF/PTXju3aHl+JSefwagEB6dMmpWKMMMfgZ+xYm6TQMdeq/bG
         YSIV4w48bCZPc5gC+AqmpUDnq9/EmFjwtJJGeg8GJd1ITyGJH++zGEux1Sjz3JW2wP
         OWZ4YQOkjRO/Fp2SI38vP7D9tAtzK6RAu/Wu+I4xs00k2rlEObjEGpiLsuDm7G88w5
         i1dt/3BYN8XnxTsqkxF9eSP9kUWUkMZrl1XQ5dMK66AjWlzuxJukU+3lJqdNweZLrR
         qgBbC3O81NOxQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3]  MediaTek Helio X10 MT6795 - MT6331 PMIC Keys
Date:   Tue, 24 May 2022 11:35:02 +0200
Message-Id: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series performs some cleanups in mtk-pmic-keys and adds support for
the MT6331 PMIC's keys.

Adding support to each driver in each subsystem is done in different
patch series as to avoid spamming uninteresting patches to maintainers.

This series depends on another two series series [1], [2] named
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper" and
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration"

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

[1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t
[2]: https://lore.kernel.org/lkml/20220520124617.228808-1-angelogioacchino.delregno@collabora.com/T/#t

Changes in v2:
 - Dropped first two patches, as Dmitry pushed a different solution
 - Refactored on top of [3]
 - Dropped Mattijs R-b tags from patches [1/3], [2/3] due to the refactoring

[3]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=644484

AngeloGioacchino Del Regno (3):
  Input: mtk-pmic-keys - Transfer per-key bit in mtk_pmic_keys_regs
  Input: mtk-pmic-keys - Move long press debounce mask to mtk_pmic_regs
  Input: mtk-pmic-keys - Add support for MT6331 PMIC keys

 drivers/input/keyboard/mtk-pmic-keys.c | 66 +++++++++++++++++++-------
 1 file changed, 49 insertions(+), 17 deletions(-)

-- 
2.35.1

