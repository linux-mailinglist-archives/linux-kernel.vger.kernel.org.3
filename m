Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3F4C694D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiB1LEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiB1LEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:04:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFA91EAFE;
        Mon, 28 Feb 2022 03:03:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AFBC81F438DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646046214;
        bh=ZYOkyKhTLblEx5A6tAm4rnRxc2pAq0nxLXlrxOhf0xg=;
        h=From:To:Cc:Subject:Date:From;
        b=IJw4OrE4rZEHPPIPGnIdrxytiUhI42Bm5/d/7/YiKOFqXj79YQCDDNO0+TZOk3te7
         bieZDMd8vCRNgAv+tiV4AJMER8yt5P9OexCN8eOcAQphEe3/wPUrDiFfPv1Ken4j+X
         +afEBBrLDtQVUeIHfgc6b5XzUNwbE8vKzTorBKICWnvuHfMRBCCj850Egfq8qsRRVo
         97KxRqN+MJfMIBpeMWmmiXw7V+E2DPtBhn1H25BE6POgciapnYY8mtQfbGNv2F9vi8
         NyCtDyKAXqgLQdak/ciVPIugM47AzuwAeBzwh9vkGJ+9q1qyu5NT5FonJm875V91al
         BBdL+8U3USB/g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mediatek: mt8173: Add gce-client-reg handle to disp-mutex
Date:   Mon, 28 Feb 2022 12:03:29 +0100
Message-Id: <20220228110329.245366-1-angelogioacchino.delregno@collabora.com>
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

Add a gce client reg handle to the disp mutex to enable MT8173
platforms to use MediaTek's CMDQ for extra performance.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 291db4fcbb25..9eaea1156e25 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1278,6 +1278,7 @@ mutex: mutex@14020000 {
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_MUTEX_32K>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1402XXXX 0 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
                                               <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
 		};
-- 
2.35.1

