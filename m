Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1104A62D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiBARrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiBARrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:47:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD7C061714;
        Tue,  1 Feb 2022 09:47:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 2A7BB1F42600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643737633;
        bh=OkkKZ3FYGEgZTul8yQpicqMp2cbfoH6C3I3tztPrqUE=;
        h=From:To:Cc:Subject:Date:From;
        b=hhxrF6mDNLVvBLQEG5CZ0rtWouQinB10zZriDIzvQiUtWwiwTDrhUYVvhq/XMMH4q
         BFSiI7qDHgjKNmMhMI+zZ1vQP5vpsDh4Qpwf5SEqlPKirc1S2SaEvuHmR1vOyW2t6A
         RoHYC3xbgJ03Ej7OVTweS9iVSs3eLk7SMjvEPJSAeNF5cNlqoaBKlWMm2ZLm3YRGH5
         K3oe2skX2hmB5B/hOtEu9LI/M2DtfI6rozcqna3Qq0olGDw1nkYfXC6Q7qT6Rf37X0
         6rrn3BAxCUle9me82u5XkhqKy9fi2ZUSsMEhUsCVG0ttDNCUNNllCnvdGHn+qngWek
         dkBkuo1rGOGzw==
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
Subject: [PATCH v2] arm64: dts: mt8183: jacuzzi: Fix bus properties in anx's DSI endpoint
Date:   Tue,  1 Feb 2022 12:46:43 -0500
Message-Id: <20220201174643.843102-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
v1: https://lore.kernel.org/all/20220120224204.773117-1-nfraprado@collabora.com

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

