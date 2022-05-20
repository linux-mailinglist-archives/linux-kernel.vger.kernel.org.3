Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7016752EC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiETMqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiETMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:46:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B135A148;
        Fri, 20 May 2022 05:46:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B4A6C1F462B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050784;
        bh=JxsQV1uov8Evle/1BqSEqQbrTff9TG41/lJE3/vz1ts=;
        h=From:To:Cc:Subject:Date:From;
        b=EWnEKiuSnKe7D1bj4FAEa5tXhyVGepGO00Za8nwol5eJwj+9yFJ7hu/Jce/OdYxL0
         7mpr5HHrNji+rvzG858+wXZyPssgAbSepu00VnqX5W2Nlt7HOhd9VvWCGn5QArGNk0
         FNTkwXshtO0VOEGT75hp8fdcDf4FVQ8jNoBM5VNrrJspcPl7XaE1LZJi8CeoOkZB8g
         P+wd2RetGywcJ8NjA2v0SrA5CWClIWMFXYzlIyMSZN2qlvsi+r/YkIV2wUggvctZ+U
         4b+kCYqWaFPXvukE6QR2TudZKx+kMnhshulil4ouaK77XkMA5wzYPBYUElbjYnddIN
         QUwazKIt8h7Cg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration
Date:   Fri, 20 May 2022 14:46:15 +0200
Message-Id: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
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

This series adds the necessary headers and support for the MT6331 with
MT6332 companion PMIC in the mt6397 MFD driver, along with some basic
devices.

Adding support to each driver in each subsystem will be done in different
patch series as to avoid spamming uninteresting patches to maintainers.

This series depends on another series [1] named
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper"

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.


[1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t

AngeloGioacchino Del Regno (2):
  dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
  mfd: mt6397: Add basic support for MT6331+MT6332 PMIC

 .../devicetree/bindings/mfd/mt6397.txt        |   2 +
 drivers/mfd/mt6397-core.c                     |  47 ++
 drivers/mfd/mt6397-irq.c                      |   9 +-
 include/linux/mfd/mt6331/core.h               |  53 ++
 include/linux/mfd/mt6331/registers.h          | 584 ++++++++++++++++
 include/linux/mfd/mt6332/core.h               |  53 ++
 include/linux/mfd/mt6332/registers.h          | 642 ++++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   2 +
 8 files changed, 1391 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/mfd/mt6331/core.h
 create mode 100644 include/linux/mfd/mt6331/registers.h
 create mode 100644 include/linux/mfd/mt6332/core.h
 create mode 100644 include/linux/mfd/mt6332/registers.h

-- 
2.35.1

