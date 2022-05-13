Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF664526804
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382813AbiEMRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382358AbiEMRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:16:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20FAE62;
        Fri, 13 May 2022 10:16:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 64F731F463B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652462182;
        bh=ep3jRpBIJW1bdO4ml6xT8OEnFPxxL9DD9DvNn1dh3JM=;
        h=From:To:Cc:Subject:Date:From;
        b=k/stz5y6+b9rlyVbMpTBmuA/COetVN3T6fGAR2yQCBTSuOcBHemKQxnjdzSVRITRW
         fflBmWJNAyAY+rURBGixkvcB7WAyXJkbw3tuIcjuxjmltYf5N+9COgENmEWP0eMh2F
         nu4o0U4KiKX0ri2E2xQAXqQkXA0mFsnbtRdcCm2UqIVFiQKM1mILcD2Wul33WwetQT
         s5TI2ZgkpHzqyK0YpnM5d5rsOod0Y0mzmwzhmyuTP6F8QFpGU2EQ2TGw3sYcDy0zs0
         smliAl3ulpOECgpZO0xPsfUI16Qk/9TkS82Vl5/46c+Siq75Sc8hxbAP+Iq10xixEk
         QLlA6Mu6XOkow==
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
Subject: [PATCH 0/7] MediaTek Helio X10 MT6795 - Devicetree, part 1
Date:   Fri, 13 May 2022 19:16:10 +0200
Message-Id: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (7):
  arm64: dts: mediatek: mt6795: Create soc bus node and move mmio
    devices
  arm64: dts: mediatek: mt6795: Add cpu-map and L2 cache
  arm64: dts: mediatek: mt6795: Add Cortex A53 PMU nodes
  arm64: dts: mediatek: mt6795: Add watchdog node to avoid timeouts
  arm64: dts: mediatek: mt6795: Add fixed clocks for 32kHz and 26MHz XOs
  arm64: dts: mediatek: mt6795: Add general purpose timer node
  arm64: dts: mediatek: mt6795: Add ARM CCI-400 node and assign to CPUs

 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 244 ++++++++++++++++++-----
 1 file changed, 189 insertions(+), 55 deletions(-)

-- 
2.35.1

