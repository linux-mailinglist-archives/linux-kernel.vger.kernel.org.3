Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AE55777F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiFWKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFWKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04949F07;
        Thu, 23 Jun 2022 03:10:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EAF56601796;
        Thu, 23 Jun 2022 11:10:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655979003;
        bh=+y7MosVyFMCeWL500cbHvDLPel8eiklTH/H6ZFzjZ1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=EoOSch7c2DJRjoiRID56J9pJIkXxdG+jxrFhuCoajbcuS9w4U8+i3ecTcwFwRGZF+
         ZJiIbbNNqkSlmgWyveYXvJiM7M9xG+K3hv6/LTDYN2eeOHBl/Px3GziBKAELJx+JoN
         UxeTQpejkI5tZGTAN23bCXxvtGd8mHHifERS9JSWLI8JizcmxfD0nS/CRSJmER5yDM
         9589/DPPRG860wFpos+BWLSD1gQXxcaD1deaS7hk8iSQ6FhtQUPuTNH/fRq+Q8cybz
         HM0xfxegcBAZEO9cj8VjbUaHF/PukGheZR+QVSb5EwkoCLDYniRFV4sFfzf94Leo+0
         AFmx/zGeuNM/Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/5] Allow getting regulator on MFG for multiple SoCs
Date:   Thu, 23 Jun 2022 12:09:46 +0200
Message-Id: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
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

This is one of the steps to enable DVFS with the Panfrost driver:
since Panfrost is already enabling the (required) MFG power domains
and since the mtk-pm-domains driver is already responsible for
actually enabling the SRAM PDN, it makes sense to make sure that
the VSRAM supply is ON when trying to reset/enable the SRAM.

For this reason, the MTK_SCPD_DOMAIN_SUPPLY flag was added to one
more MFG domain, ensuring that the SRAM is actually powered and
also not relying on the bootloader leaving this supply on; on the
other hand, this is also making possible to avoid setting a
sram-supply on the GPU node, making devfreq happy about having
only one supply and finally allowing DVFS to happen.

If no domain-supply is declared in devicetree, mtk-pm-domains driver
probe will anyway keep going, so this is not breaking old devicetrees.

No side effects either when this supply is declared for both a MFG
domain and Panfrost together.

This series has no dependencies.

AngeloGioacchino Del Regno (5):
  soc: mediatek: mt8192-pm-domains: Allow probing vreg supply on MFG0/1
  soc: mediatek: mt8183-pm-domains: Allow probing vreg supply on
    MFG_ASYNC
  soc: mediatek: mt8195-pm-domains: Allow probing vreg supply on MFG1
  soc: mediatek: mt8186-pm-domains: Allow probing vreg supply on MFG1
  arm64: dts: mediatek: mt8183-kukui: Assign sram supply to mfg_async pd

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
 drivers/soc/mediatek/mt8183-pm-domains.h       | 1 +
 drivers/soc/mediatek/mt8186-pm-domains.h       | 2 +-
 drivers/soc/mediatek/mt8192-pm-domains.h       | 2 ++
 drivers/soc/mediatek/mt8195-pm-domains.h       | 2 +-
 6 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.35.1

