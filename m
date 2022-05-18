Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BF52B6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiERKFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiERKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A896EB07;
        Wed, 18 May 2022 03:05:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8EE241F44E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868311;
        bh=U70cvP2/Lgt8lNyOqWL39jq+Fark+U7neoHz5F2M2Nw=;
        h=From:To:Cc:Subject:Date:From;
        b=IsAoTuF0LZAK/38ZusnqIkI10GGd2aWgxdN2rhyFkvOY3sbmzggDeRnYWAI6SbDSu
         ARC0oZ7uzAKHX27vDoS7ruoS1PWqv19s3xjNgagzfltsoJoxEwnlt9krLrIyuiHFtA
         W1CTf+5vhhtcu5bLxzlld4STZIHFdhy4fyYNrI6EDrOKNkmJwa1uFM9LvBqyqPBccP
         XnRtWgFvqjV1XeLyqQmiPp3KzW3TvugS98vL9sYxT8ECATIakSJ28M1nmHK/W+Bhh4
         y+fiK2jGk5YvAyqJN/bapRl105yVdat8KERFg8G1mNKQbiRToc6Qqn5wyKjN55r32X
         4HvGjdXoTvj5Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/7] mtk_iommu: Specify phandles to infracfg and pericfg
Date:   Wed, 18 May 2022 12:04:56 +0200
Message-Id: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
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

The IOMMU has registers in the infracfg and/or pericfg iospaces: as
for the currently supported SoCs, MT2712 and MT8173 need a phandle to
infracfg, while MT8195 needs one to pericfg.

Before this change, the driver was checking for a SoC-specific infra/peri
compatible but, sooner or later, these lists are going to grow a lot...
...and this is why it was chosen to add phandles (as it was done with
some other drivers already - look at mtk-pm-domains, mt8192-afe

Please note that, while it was necessary to update the devicetrees for
MT8173 and MT2712e, there was no update for MT8195 because there is no
IOMMU node in there yet.

Changes in v2:
 - Squashed dt-bindings patches as suggested by Matthias
 - Removed quotes from infra/peri phandle refs
 - Changed dev_warn to dev_info in patches [2/7], [3/7]

AngeloGioacchino Del Regno (7):
  dt-bindings: iommu: mediatek: Add phandles for mediatek infra/pericfg
  iommu: mtk_iommu: Lookup phandle to retrieve syscon to infracfg
  iommu: mtk_iommu: Lookup phandle to retrieve syscon to pericfg
  arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
  arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
  dt-bindings: iommu: mediatek: Require mediatek,infracfg for
    mt2712/8173
  dt-bindings: iommu: mediatek: Require mediatek,pericfg for
    mt8195-infra

 .../bindings/iommu/mediatek,iommu.yaml        | 30 +++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
 drivers/iommu/mtk_iommu.c                     | 66 ++++++++++++-------
 4 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.35.1

