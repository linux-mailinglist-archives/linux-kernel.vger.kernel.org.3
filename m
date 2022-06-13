Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CCB5498F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiFMPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiFMPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:53:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242318C077;
        Mon, 13 Jun 2022 06:38:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5BF86660166D;
        Mon, 13 Jun 2022 14:38:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655127504;
        bh=TETKvO7yzhsJVee/QiNgQ4n1RUjV1Q6NM9vNQ/zTq6g=;
        h=From:To:Cc:Subject:Date:From;
        b=ISTT2qz2Uyfiiw/NGE69FIQJpUcFunEyQIjA0OPA0lQm6Y2JP2VYTXkZXjfLK6cRU
         jA00XhL5XBc3E0JDjP6ionTLRksMHx8CewzRBrOrNiEJtKwuOuBdTDF58856O+6Mcc
         857EqIUc0PM69AoGuYR+GqBpbRbGdUOZ/Q60jYnmvTgOF5rQ3582ba/Tb7QcZ51+qB
         sEJQDFU7uMGxABrvDyIPJgO5YyygHQbRdFWbJbyUQSwBoGcnvpxbFK9YW6Eck6g+u6
         a749PHjxH5RZohl9hFeuqJAuXMH91HqdVyKV0995iMMv8iP2sEMHTyUHzkzuZ9At8z
         z7qx0gXheIO5w==
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
Subject: [PATCH v4 0/2] MediaTek SoC ARM/ARM64 System Timer
Date:   Mon, 13 Jun 2022 15:38:17 +0200
Message-Id: <20220613133819.35318-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support to start the System Timer for the CPU
cores found in various MediaTek SoCs including, but not limited to the
MT6795 Helio X10 - and will most probably unblock many developers for
the upstreaming of various platforms.

For a broad overview of why/what/when, please look at the description
of patch [2/2] in this series.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v4:
 - Changed statement in documentation, now saying:
   "MediaTek SoCs have different timers on different platforms"

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

 .../bindings/timer/mediatek,mtk-timer.txt     |   6 +-
 drivers/clocksource/timer-mediatek.c          | 114 ++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

-- 
2.35.1

