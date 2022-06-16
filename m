Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209D54DFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbiFPLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376633AbiFPLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:08:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747B5C86F;
        Thu, 16 Jun 2022 04:08:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 686846601747;
        Thu, 16 Jun 2022 12:08:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655377719;
        bh=mpK1TVAIqyX6YVJK1M8Os+7jR/kqhqwVYDvOvGIs95Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Ch6RYiKtPc9VsSjhrKSnp0vU0dODz448sqD29I+hfp7tCSq5/Ms2LWSEmzwV9qCFj
         J3HRBsegQbwFFREW/xctKgGliHrhsNAX/hzS1NR+sNIfg8fXJAyVe/5fqZ0QKL4H6w
         5XeXjANUFC2PrvMdwicA55FIyaMoVZc5uBhj6yMPfuHVu2QLOLG3DQiFH1x0G5qPIF
         BI5vbbrHPn0UYp78uw+RtufGvAbSFKnCq94XwKZFtGPfhDMsIsH8I2XtydLwqLAW93
         sEfCtPjgq0vSZdfTOF91OsyzR9Jq+0/kn8QN0ufQW/4J25FJfL/V6d3ItuimOpVXZh
         R7/M9tiasr5gg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and pericfg
Date:   Thu, 16 Jun 2022 13:08:25 +0200
Message-Id: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
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

Changes in v4:
 - Dropped changes introducing mediatek,pericfg handle
 - Fixed required property in IOMMU example in patch [1/5]
 - Added a pericfg lookup flow cleanup commit

Changes in v3:
 - Different squashing of dt-bindings patches (sorry for misunderstanding!)
 - Removed legacy devicetree print

Changes in v2:
 - Squashed dt-bindings patches as suggested by Matthias
 - Removed quotes from infra/peri phandle refs
 - Changed dev_warn to dev_info in patches [2/7], [3/7]

AngeloGioacchino Del Regno (5):
  dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
  iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
  arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
  arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
  iommu/mediatek: Cleanup pericfg lookup flow

 .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
 drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
 4 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.35.1

