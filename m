Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2CA519049
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiECV3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbiECV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:29:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A922AE05;
        Tue,  3 May 2022 14:25:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 046C31F43B53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651613136;
        bh=4LP/jKCMumd2WzQHTLcpeW44tdUtgMXLREom1d6+3d8=;
        h=From:To:Cc:Subject:Date:From;
        b=U6uwvqLWQz1rrgHBmyInvOdwj2a6NsnXgBaLDmfjzuWitxhBVPkxEfKiQ/zHtLaad
         hr0qqA7zPswCSym0S5/b/p4XxmNMhoYHcdqd/lWjegnfnDpXEIcsmEbXNztOynVVhl
         xarPslAab2CEed/rlVqJUSduVQg1MPtDjBk1bf/xxh7kyJzWhTCP3Q0F0bgkA+r8LG
         vVGjtHfiZLqxzlwXdAobGcCXlCaaumMnVUlg3kHCyMm1EAoSDBuYrOT4v9upgAD6uz
         xHJ0H/jA9Fshsxgn3EiV1PSpsN2E/+ZNPegH4r4eDNd+wzvKxd0u9ayFLUxS8daiEu
         Qqw3eEUBib0/w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mt8192: Follow binding order for SCP registers
Date:   Tue,  3 May 2022 17:25:31 -0400
Message-Id: <20220503212531.2657870-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The dt-binding for SCP documents the reg-names order as sram, cfg,
l1tcm. Update the SCP node on the mt8192 devicetree to follow that
order, which gets rid of a dtbs_check warning. This doesn't change any
behavior since the SCP driver accesses the memory regions through the
names anyway.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 26dbe9ecc528..733aec2e7f77 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -699,9 +699,9 @@ spi7: spi@1101e000 {
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8192-scp";
 			reg = <0 0x10500000 0 0x100000>,
-			      <0 0x10700000 0 0x8000>,
-			      <0 0x10720000 0 0xe0000>;
-			reg-names = "sram", "l1tcm", "cfg";
+			      <0 0x10720000 0 0xe0000>,
+			      <0 0x10700000 0 0x8000>;
+			reg-names = "sram", "cfg", "l1tcm";
 			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&infracfg CLK_INFRA_SCPSYS>;
 			clock-names = "main";
-- 
2.36.0

