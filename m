Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0854F654
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380273AbiFQLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381038AbiFQLHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:07:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2D641C;
        Fri, 17 Jun 2022 04:07:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA3E9660179A;
        Fri, 17 Jun 2022 12:07:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655464056;
        bh=OlBFW53ERgizRVRtQgKbH+lzxjyhexAWk8aT0tzSoZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=QdX6jUJgR7tgj/RIoZpnhXa/CLZMW8q+eI3ShgKImy4sHx2nujjj9sfzX37le/+yE
         KY1OfP3+MdF+yWHaHbKTCXMc1Ao0ppSnoPyqaPwDqXEAaSvCXddzvJmelreynOKDA1
         6b26PnbLLlph/HEb94oZpTk4aqAwKF76o1/9xviP/Tw6RusEa3W6G/FXcJCGd96Ouu
         rsCBHfVMigyv0hLXh/7Uxa7PAUoYAv5oSMDgZ3eJsWnmf9TTOHS8loDwHcCUDqP/5i
         EbqGa1FPibAsi+katm1iVvcKjr/riKK8FMogD5oaDJOyLGNhKoVFvZUnmFitufD1Em
         OMv5ND8U7+VLQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD integration
Date:   Fri, 17 Jun 2022 13:07:26 +0200
Message-Id: <20220617110728.90132-1-angelogioacchino.delregno@collabora.com>
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series adds the necessary headers and support for the MT6331 with
MT6332 companion PMIC in the mt6397 MFD driver, along with some basic
devices.

Adding support to each driver in each subsystem will be done in different
patch series as to avoid spamming uninteresting patches to maintainers.

This series depends on another series [1] named
"MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper", meaning that
even if this builds without, the changes in said series are necessary
to actually use these PMICs.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

[1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t

Changes in v3:
 - Removed unused macros in mt6331/core.h, mt6332/core.h

Changes in v2:
 - Reworded commit description for commit [1/2] to include a list of
   the submodules provided by this hardware
 - Changed keys compatible documentation to a list

AngeloGioacchino Del Regno (2):
  dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
  mfd: mt6397: Add basic support for MT6331+MT6332 PMIC

 .../devicetree/bindings/mfd/mt6397.txt        |   7 +-
 drivers/mfd/mt6397-core.c                     |  47 ++
 drivers/mfd/mt6397-irq.c                      |   9 +-
 include/linux/mfd/mt6331/core.h               |  40 ++
 include/linux/mfd/mt6331/registers.h          | 584 ++++++++++++++++
 include/linux/mfd/mt6332/core.h               |  65 ++
 include/linux/mfd/mt6332/registers.h          | 642 ++++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   2 +
 8 files changed, 1393 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/mfd/mt6331/core.h
 create mode 100644 include/linux/mfd/mt6331/registers.h
 create mode 100644 include/linux/mfd/mt6332/core.h
 create mode 100644 include/linux/mfd/mt6332/registers.h

-- 
2.35.1

