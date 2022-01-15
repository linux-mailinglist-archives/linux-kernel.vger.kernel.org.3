Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5748F969
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiAOVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiAOVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:04:47 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC6C061574;
        Sat, 15 Jan 2022 13:04:46 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9717A22246;
        Sat, 15 Jan 2022 22:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642280681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EOFAi8C5JK3apd+Ptn3OSlWNng34gktrSqmr7op8tlE=;
        b=mRdneA3Hjw+RZBSw8YKueFnYw6fpZNPnghKYfSO9ZuXL90hTtjpXCsM0o0agCDqXvhuF1W
        FG7tyTjBm8uHnHtBattXzbeuA18KS+fz6Hld6ullbfj5dxID91NFTb6NSXJe3OXQl2EUNs
        11b77YWhUiPUypWplXdjyMCv16Xmd0Y=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] arm64: dts: ls1028a: sl28: re-enable ftm_alarm0
Date:   Sat, 15 Jan 2022 22:04:32 +0100
Message-Id: <20220115210432.449968-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd3d936a1b17 ("arm64: dts: ls1028a: add ftm_alarm1 node to be
used as wakeup source") disables ftm_alarm0 in the SoC dtsi but doesn't
enable it on the board which is still using it. Re-enable it on the sl28
board.

Fixes: dd3d936a1b17 ("arm64: dts: ls1028a: add ftm_alarm1 node to be used as wakeup source")
Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index dd4773d1cf03..5dc85d088ec2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -190,6 +190,10 @@ base_mac_address: base-mac-address@17 {
 	};
 };
 
+&ftm_alarm0 {
+	status = "okay";
+};
+
 &gpio1 {
 	gpio-line-names =
 		"", "", "", "", "", "", "", "",
-- 
2.30.2

