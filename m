Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44A54494F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiFIKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbiFIKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:40:45 -0400
X-Greylist: delayed 3858 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 03:40:11 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D72FAC07;
        Thu,  9 Jun 2022 03:40:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DEE3F66017C5;
        Thu,  9 Jun 2022 11:40:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654771208;
        bh=e0AQfxv8jGpQQTIJ9KKzNfQsGY/6PxPWTtlkTzfZaxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QFp+iinGUw+/GZa9POrbVNX8EqjKqwp/vDjG+HoAKtab89eWAf8/SwDrG7wJSSHzY
         dnoosbFI8+GYD3a08e9TOw9PWSjBZ0Hj7zL0iXt6dQXVBjCrqg/lCvZs8MV7fNsZiv
         TfY6Vjck2tHn3FQmO6C4qTZIEo8TfpGi06NGe1XM9K30kbRkipqzFdlUZxWBAenzW4
         olooBGTyxd9Bn5kx0w5hxsKmFIZnuz68MHXhcGGFX1hOkVrFXNkvgNzsRIzYkid//W
         xUKG36GZfioFha92O78ghvotmX+1BvKmQRUp96KtQvH8XGTgL0J30iZ9KTZLKajZ9U
         DQjswuX2s1dYQ==
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
Subject: [PATCH v3 0/3] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Date:   Thu,  9 Jun 2022 12:39:58 +0200
Message-Id: <20220609104001.97753-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support for the IOMMUs found on this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v3:
 - Added new flag as suggested by Yong Wu
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=648784

Changes in v2:
 - Rebased on top of https://patchwork.kernel.org/project/linux-mediatek/list/?series=642681

AngeloGioacchino Del Regno (3):
  dt-bindings: mediatek: Add bindings for MT6795 M4U
  iommu: mtk_iommu: Introduce new flag TF_PORT_TO_ADDR_MT8173
  iommu: mtk_iommu: Add support for MT6795 Helio X10 M4Us

 .../bindings/iommu/mediatek,iommu.yaml        |  4 +
 drivers/iommu/mtk_iommu.c                     | 21 +++-
 include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
 3 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

-- 
2.35.1

