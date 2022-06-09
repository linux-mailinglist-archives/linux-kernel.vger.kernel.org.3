Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC535449EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbiFILXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiFILXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:23:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558E9D076;
        Thu,  9 Jun 2022 04:23:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA19966017C8;
        Thu,  9 Jun 2022 12:23:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654773788;
        bh=9Ae5YF6irZpp0Rms9XFrNm87VVx0wDKBfDaYKBip0iY=;
        h=From:To:Cc:Subject:Date:From;
        b=kTGqfVH1pAml5TEdtn4V1L6IjyCLLn/p7oz53tNZ4NCG02/TgKQhGwGI0PXypNIJx
         WiQEwpXpg/S1JAjeE9zINrD5W4GHDMwCiATKETd+fkmP0VwM62qvWOdOP2S0rCREME
         +rTnlqhyyBllcPh7Gm4PdX9S9hkjZi69kUB/UMjq5atKW6BFbQ2b8UhPb9snZNMhwb
         UKLhwCCrqmTmFMNu/tDTCsCF6Ks6p9ZNpwRtbkBYuMeRpt6YmeI/g7xWVPq4jl8MW5
         VmA7vF1Noib1pX5tRcSL+X+wPVQvKPNQ+ZzugIQs3yATRD9FBl0fB1DspY9JEP5MkH
         suJIzFwYPi/Hw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 00/10] MediaTek Helio X10 MT6795 - Devicetree, part 1
Date:   Thu,  9 Jun 2022 13:22:53 +0200
Message-Id: <20220609112303.117928-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series modernizes the devicetree of the MT6795 SoC and adds a
couple of nodes that are supported by this SoC.

In my local tree I have much more than that (including the dts for
that Xperia M5 smartphone that I always mention...), but I decided
to push the devicetree commits in multiple parts, as to get these
in sooner than later because that reduces my delta, and this makes
upstreaming a bit easier, especially when having to rebase things
around, which happens a lot.

So, this series *does NOT* depends on any of the other series that
I've pushed and is mergeable in parallel.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v2:
 - Split fixed-clocks addition/removal patch for readability
 - Added patches for pinctrl controller node and vGIC interrupt

AngeloGioacchino Del Regno (10):
  arm64: dts: mediatek: mt6795: Create soc bus node and move mmio
    devices
  arm64: dts: mediatek: mt6795: Add cpu-map and L2 cache
  arm64: dts: mediatek: mt6795: Add Cortex A53 PMU nodes
  arm64: dts: mediatek: mt6795: Add watchdog node to avoid timeouts
  arm64: dts: mediatek: mt6795: Add fixed clocks for 32kHz and 26MHz XOs
  arm64: dts: mediatek: mt6795: Remove incorrect fixed-clocks
  arm64: dts: mediatek: mt6795: Add general purpose timer node
  arm64: dts: mediatek: mt6795: Add ARM CCI-400 node and assign to CPUs
  arm64: dts: mediatek: mt6795: Add pinctrl controller node
  arm64: dts: mediatek: mt6795: Specify interrupts for vGIC

 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 260 ++++++++++++++++++-----
 1 file changed, 205 insertions(+), 55 deletions(-)

-- 
2.35.1

