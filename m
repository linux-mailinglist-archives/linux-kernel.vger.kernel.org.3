Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476B5313FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiEWP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiEWP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:27:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FF590BD;
        Mon, 23 May 2022 08:27:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D2CF31F4388B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653319647;
        bh=ECuRIHZVc4uUQwghJj0RU9C81x2ASHEftsiIARksYqk=;
        h=From:To:Cc:Subject:Date:From;
        b=nZdlCDvArOlyITPdldlyl5Cu42ag/8ys2ryteghMhhDm1emAO0Ty+NelQBuz5ryEv
         ZT4uUT0QjLiwwCv8eu0l/sGUNpIqWwGez+zVn3Dvk2E/V+V5Uk33JigGe05nEXTq5x
         z3uV7GPONCImnCN007v6Hdm52TuotU0my3zz+/4KgFWIszwbzihSn8v8wA+6x2F8y1
         AJtldlQ04T4Oe04tS0/OxLfqPtrSZCm7CpO/lzCYxUVVBmhukHDD5ODp7METgfmlvC
         hAFWvsg5ipYhRyyw+paYNR+vrmfahgVRaoOEuCzAkPcWkluM6oH6XX2HL38zEYqSye
         7gSNDjy2b6hIA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/4] MediaTek Helio X10 MT6795 - MT6331/6332 Regulators
Date:   Mon, 23 May 2022 17:27:12 +0200
Message-Id: <20220523152716.117062-1-angelogioacchino.delregno@collabora.com>
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

This series adds support for the regulators found in MT6331 and MT6332
main/companion PMICs.

Adding support to each driver in each subsystem is done in different
patch series as to avoid spamming uninteresting patches to maintainers.

This series depends on another two series series [1], [2] named
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper" and
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration"

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

[1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t
[2]: https://lore.kernel.org/lkml/20220520124617.228808-1-angelogioacchino.delregno@collabora.com/T/#t

Changes in v2:
 - Refactored description in dt-bindings
 - Simplified get_status() function and removed callback
   where not needed
 - Simplified set_mode()/get_mode() functions and removed
   callback where not needed
 - Added new regulator_ops for no_qi (no .get_status) and
   for no_ms (no .{get, set}_mode)
 - Fixed vsel mask on some regulators and removed pattern of
   repeated voltage entries present in some voltage tables,
   avoiding to set higher bits for safety
 - Reordered regulators (and some formatting fixes) in
   mt6331-regulator.c in per-type alphabetic order

AngeloGioacchino Del Regno (4):
  dt-bindings: regulator: Add bindings for MT6331 regulator
  regulator: Add driver for MT6331 PMIC regulators
  dt-bindings: regulator: Add bindings for MT6332 regulator
  regulator: Add driver for MT6332 PMIC regulators

 .../regulator/mediatek,mt6331-regulator.yaml  | 273 ++++++++++
 .../regulator/mediatek,mt6332-regulator.yaml  | 112 ++++
 .../bindings/regulator/mt6332-regulator.yaml  | 111 ++++
 drivers/regulator/Kconfig                     |  18 +
 drivers/regulator/Makefile                    |   2 +
 drivers/regulator/mt6331-regulator.c          | 507 ++++++++++++++++++
 drivers/regulator/mt6332-regulator.c          | 422 +++++++++++++++
 include/linux/regulator/mt6331-regulator.h    |  46 ++
 include/linux/regulator/mt6332-regulator.h    |  27 +
 9 files changed, 1518 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6332-regulator.yaml
 create mode 100644 drivers/regulator/mt6331-regulator.c
 create mode 100644 drivers/regulator/mt6332-regulator.c
 create mode 100644 include/linux/regulator/mt6331-regulator.h
 create mode 100644 include/linux/regulator/mt6332-regulator.h

-- 
2.35.1

