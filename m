Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECEC49566D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378104AbiATWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiATWmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:42:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F620C061574;
        Thu, 20 Jan 2022 14:42:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D44951F40EF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642718549;
        bh=n9nzvUGdd1YQiFhmJQVwJMExyCSnYF3MN5S9On1se6k=;
        h=From:To:Cc:Subject:Date:From;
        b=Gx5LGmfVs1pDMMfMa4ZSil6InBzCwhMelXygPbxag4PlZhUA9YcwTAYl3Qn1lShLR
         Ri9pMcNH1Wxs/JEAEQBMZIrYjI0I7nAxpAQQUZ0rwR/v+cOUQl5fuC2iTyxBIQMNmH
         3ZbngxScmE/R8tVwzUkpdJQRY9uuym5U4ANVRTVzaxOO4UbWMSzhqrFLBbp9Td4qSY
         Mh+A0iDMvExPLmIo0SRKHOUxIcPur+beeqjRquZaPTm6EGmQTDiaeGknjW3fzPHftS
         yDC15r8UABRks9IXEmfmcZgB09bgbdx+eDmiXsM+zF5WppR3+DHB1A6+vYW6tGeCwK
         G3fEtBwmR1bNw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH] arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI endpoint
Date:   Thu, 20 Jan 2022 17:42:04 -0500
Message-Id: <20220120224204.773117-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183-kukui-jacuzzi has an anx7625 bridge connected to the output of
its DSI host. However, after fd0310b6fe7d ("drm/bridge: anx7625: add
MIPI DPI input feature"), a bus-type property started being required in
the endpoint node by the driver to indicate whether it is DSI or DPI.

Add the missing bus-type property and set it to 5
(V4L2_FWNODE_BUS_TYPE_PARALLEL) so that the driver has its input
configured to DSI and the display pipeline can probe correctly.

While at it, also set the data-lanes property that was also introduced
in that same commit, so that we don't rely on the default value.

Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
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
2.34.1

