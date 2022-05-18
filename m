Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2052B8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiERLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiERLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:24:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC9D170649;
        Wed, 18 May 2022 04:24:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D609C1F41EF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652873079;
        bh=aTNle9KArjSkwZPxjRCPDIWdKxMDxqxTEvqJionGghc=;
        h=From:To:Cc:Subject:Date:From;
        b=aJkxOINb39+ULvOjftDlYIQVRTrztYqukxC1mEgvjUtBREtipWw29uol/pDyCTag2
         trU/E5tPrjfQwZrBZ5o/W1HkUrT21ydS7jenfqe//H75xu9h9Vl+Z9JEqTw0eQ5C8D
         rsMdHQPVHY7Sm4Y/VfoR9jzknYZwntyc62st+LUbsmGJRkQGZ+6igQf5VDlRnlUsWl
         FTQIXLVmcCVnktgXA7xrgls7nxSgTa3pWpbF0weX6HvXPlDT64/AeOt/whrzPC27Av
         exl9VPA9A5baloYidCdkpHcFBkwVWMj4uqIXWIU4QHZ63eLNrRElfG0Aly710MCDIi
         V0klT+Dd2EmNQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/2] MediaTek SoC ARM/ARM64 System Timer
Date:   Wed, 18 May 2022 13:24:33 +0200
Message-Id: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support to start the System Timer for the CPU
cores found in various MediaTek SoCs including, but not limited to the
MT6795 Helio X10 - and will most probably unblock many developers for
the upstreaming of various platforms.

For a broad overview of why/what/when, please look at the description
of patch [2/2] in this series.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v3:
 - Merged mtk_cpux_{enable,disable}_irq() as one mtk_cpux_set_irq() function
   as suggested by Matthias

Changes in v2:
 - Added back a lost line in commit 2/2 (sorry, commit didn't get amended...!)
 - Tested again for safety

AngeloGioacchino Del Regno (2):
  dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795
    compatible
  clocksource/drivers/timer-mediatek: Implement CPUXGPT timers

 .../bindings/timer/mediatek,mtk-timer.txt     |   4 +
 drivers/clocksource/timer-mediatek.c          | 114 ++++++++++++++++++
 2 files changed, 118 insertions(+)

-- 
2.35.1

