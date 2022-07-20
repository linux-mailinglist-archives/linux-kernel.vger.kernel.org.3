Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B12057B486
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiGTK2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiGTK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:28:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA8D2E681;
        Wed, 20 Jul 2022 03:28:27 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66D5E660159F;
        Wed, 20 Jul 2022 11:28:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658312906;
        bh=7l+2CZgG+sIADvhql1OGVojBV4addG3U3EH5rwCDuag=;
        h=From:To:Cc:Subject:Date:From;
        b=evumRvnk7RBzc5HkvS6nWuSxEMS0AqMj8TyvUq71LPCaNmEvwvMG/XkE25SP5NJkE
         qfGAI5ZVtWUvHQzZobwuQfPAU2v1wYCJnJcybUTVPdsqi2gBjcSGba8Z6lsLxMc+mV
         RmK+yj+yRu4Qd2FRf/O4eDT+MlRTHW+OrXzGIMTH06VgLYy6aIxZI4rLV4Rsb8qRC1
         cK2T1PBgI6bZcUBoG9MrYFa0zgsx4pNRYxKXuqF60PbUJ1cOFAv4N73N+f4dyopCwL
         2jSy4aiEIb/60Pohd0Au3kHjePd7twmQ+lpVvjqf2YW5Z+LvLklZYLRexa229g7qGC
         3G4mNEWl+qIcQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] MT8195: Add reset for T-PHY (usb/pcie)
Date:   Wed, 20 Jul 2022 12:28:15 +0200
Message-Id: <20220720102817.237483-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the resets for TPHY Port 1 which, depending on the board layout,
is used either as USB or PCIe PHY.

This is required on MT8195 Tomato Chromebooks for correct initialization
of the secondary PCI-Express controller, where we have a MT7621 PCIe
WiFi chip.

For reference, the PCIe1 controller devicetree node resets will look
like this:

pcie@112f8000 {
	... blurb ...

	resets = <&infracfg_ao MT8195_INFRA_RST2_USBSIF_P1_SWRST>,
		 <&infracfg_ao MT8195_INFRA_RST2_PCIE_P1_SWRST>;
	reset-names = "phy", "mac";

	... blurb ...
};

This series depends on an earlier one where I introduce the MAC
resets for both PCIe (p0, p1) controllers [1]

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=654980

AngeloGioacchino Del Regno (2):
  dt-bindings: reset: mt8195: Add resets for USB/PCIe t-phy port 1
  clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY

 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 1 +
 include/dt-bindings/reset/mt8195-resets.h  | 1 +
 2 files changed, 2 insertions(+)

-- 
2.35.1

