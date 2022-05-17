Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75E52A339
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbiEQNWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiEQNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:21:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B73616C;
        Tue, 17 May 2022 06:21:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EEE141F433D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652793672;
        bh=OVAmupcImeep7rSBDHFhNuaLOusX/y6qibNhNwPjm9g=;
        h=From:To:Cc:Subject:Date:From;
        b=AwQWRiA+XZoWp6LVlmA0BAa4UYFfmEJsptnY3ren35hQka/i6zRgZXvpgsQzjpt7o
         tKbi05/UA3sjchbZCztyRXBUFY5zEV8qCVxKtO+ow+R6/4S+wFZ+g6RVZ4YISiQdYD
         4cPHeE0fnt8VsvWCPzKeLRV0gavS7ryrQcZKaQMDlKkLiApzWTlrnuM5ypulvAL0qX
         NdvHicWqqcA1Ra9blXd1sFv1ZUx75CgWBKHwXWrrZGKvf8dQfxUUdTMAbv6DhhnqGu
         xRwVn/xG7gkVp7hmnjrC4BzL3YIFeRK9Bwi4xPsIACLJ40hq+3PyAHjQ0nMcIZNOUz
         FyBcYgIh7C5Pg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/8] mtk_iommu: Specify phandles to infracfg and pericfg
Date:   Tue, 17 May 2022 15:20:59 +0200
Message-Id: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (8):
  dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
  iommu: mtk_iommu: Lookup phandle to retrieve syscon to infracfg
  dt-bindings: iommu: mediatek: Add mediatek,pericfg phandle
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

