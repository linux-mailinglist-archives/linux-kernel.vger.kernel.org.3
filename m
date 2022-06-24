Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BC559737
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFXKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:00:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB87A1A0;
        Fri, 24 Jun 2022 03:00:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BB146601706;
        Fri, 24 Jun 2022 11:00:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656064827;
        bh=kE25mZowYawxksYFtTK6e46BuEVPPKrDas/B81hlGfU=;
        h=From:To:Cc:Subject:Date:From;
        b=dK5lHwZzHT0WmQPPa28n8ROtFdjlfq8SR8AslZ7EoynyJLA/3w7rSAvvob5e2QiNJ
         UAkKJdGIUyczVADiyyXi/M4xZHLQSnHe2zlu5QZb4BdC8O+QQW2gszJAxnbAMoTi1D
         MkyjnSF2M+f3dYN5t5eDVX6yTdJbvsEeIC2T6jV20ic6Jbpfe2vLSp5B/wd7Gp5x/H
         QMUcz2WId2rgFUNWNeXvAsaWS8YpoPpG4lMZuh6D9sVM4Yhbkofx1bKstiQoH6yA3j
         /jMklss5NuhsJCUAkbsez2Nj4IpaGZOuXaD61mBrn0it050z6qWwcng93VF4FTKLKm
         0PcpX0tzAyySw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 0/3] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Date:   Fri, 24 Jun 2022 12:00:13 +0200
Message-Id: <20220624100016.246442-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support for the IOMMUs found on this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v4:
 - Retitled mtk_iommu commits to iommu/mediatek as suggested by Yong Wu
 - Removed unused M4U_LARB5_ID definition
 - Rebased on next-20220624 and
   https://patchwork.kernel.org/project/linux-mediatek/list/?series=650969

Changes in v3:
 - Added new flag as suggested by Yong Wu
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=648784

Changes in v2:
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=642681


AngeloGioacchino Del Regno (3):
  dt-bindings: mediatek: Add bindings for MT6795 M4U
  iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
  iommu/mediatek: Add support for MT6795 Helio X10 M4Us

 .../bindings/iommu/mediatek,iommu.yaml        |  4 +
 drivers/iommu/mtk_iommu.c                     | 21 +++-
 include/dt-bindings/memory/mt6795-larb-port.h | 95 +++++++++++++++++++
 3 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

-- 
2.35.1

