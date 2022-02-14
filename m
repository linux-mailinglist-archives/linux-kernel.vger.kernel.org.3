Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B254B5C16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiBNVDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:03:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiBNVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:02:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17095D21EB;
        Mon, 14 Feb 2022 13:02:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 719871F43907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644869128;
        bh=1uxuJpUNgwUp11TPN1NKA7OMJKeBwVw0ZqlthMDA3F0=;
        h=From:To:Cc:Subject:Date:From;
        b=dgCpr307YqBKISxEPPv8wm5ciiXYOnfRHSotaSu8avXJ+gv4zXKhvUIayUkFttVLP
         ep4Nb0BaR5hda+XrvZQUeKxpuEyIx7L0lpMzuRxSLrk+qTk6o7gx6B3+2xKreJmaVK
         Wio52gU7WsIdGBoqwAiZ0Yl3s1PeRYSUz1tHEuUUXOIGuYPlTK1rAZ5cL6KWbFATSh
         MW9TDixQhqFuKt6rch0Z0ul1nfbzq7CKZ5aOYs3EBnrW10ssQv5fb7+Ica6EWBVAlo
         wRAFjrJ9vB2c45YKkADeGEFcUfEmJPaJd3DeZYAX6Z4yMIB3Kc7k3HcxCc36pwj8ho
         YYno4Uc8EVAiQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI endpoint
Date:   Mon, 14 Feb 2022 15:05:07 -0500
Message-Id: <20220214200507.2500693-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
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

mt8183-kukui-jacuzzi has an anx7625 bridge connected to the output of
its DSI host. However, after commit fd0310b6fe7d ("drm/bridge: anx7625:
add MIPI DPI input feature"), a bus-type property started being required
in the endpoint node by the driver to indicate whether it is DSI or DPI.

Add the missing bus-type property and set it to 5
(V4L2_FWNODE_BUS_TYPE_PARALLEL) so that the driver has its input
configured to DSI and the display pipeline can probe correctly.

While at it, also set the data-lanes property that was also introduced
in that same commit, so that we don't rely on the default value.

Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
v2: https://lore.kernel.org/all/20220201174643.843102-1-nfraprado@collabora.com
v1: https://lore.kernel.org/all/20220120224204.773117-1-nfraprado@collabora.com

Changes in v3:
- Added missing Reviewed-by

Changes in v2:
- (thanks Rob) Use proper format when refering to commit in commit
  message as pointed out by checkpatch

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 8f7bf33f607d..e8f133dc96b9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -171,6 +171,8 @@ port@0 {
 
 			anx7625_in: endpoint {
 				remote-endpoint = <&dsi_out>;
+				bus-type = <5>;
+				data-lanes = <0 1 2 3>;
 			};
 		};
 
-- 
2.35.1

