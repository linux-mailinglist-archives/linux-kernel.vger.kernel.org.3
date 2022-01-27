Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379549E7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiA0Qhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiA0Qhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:37:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD912C06173B;
        Thu, 27 Jan 2022 08:37:36 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 200D4223EF;
        Thu, 27 Jan 2022 17:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Lgm3+ejR5iCeubB0LLMdHYvyTni/SmF/Frp1FWA+zQ=;
        b=N7MkleU7MH65Ylw+E3wXvQlrSPAYLtG9X+bqa/5ZS1OgKkzI5+MIzLvEnfSEi0jvcJh5Jp
        NeQrKXwbQCwDuzZOnxZD6capkLl4AnMk+sTJnExlRt8VbWkWe/B2KhVzMyUt6aNEUV/yAc
        gOh5uaX59wo8iyUJkTqvqB4ORl/reYM=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 3/3] arm64: dts: ls1028a: add efuse node
Date:   Thu, 27 Jan 2022 17:37:28 +0100
Message-Id: <20220127163728.3650648-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127163728.3650648-1-michael@walle.cc>
References: <20220127163728.3650648-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Layerscape SoCs contain a Security Fuse Processor which is basically a
efuse controller. Add the node, so userspace can read the efuses.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d44102d9c6c..4b248cee830a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,6 +224,17 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
+		efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ls1028a_uid: unique-id@1c {
+				reg = <0x1c 0x8>;
+			};
+		};
+
 		scfg: syscon@1fc0000 {
 			compatible = "fsl,ls1028a-scfg", "syscon";
 			reg = <0x0 0x1fc0000 0x0 0x10000>;
-- 
2.30.2

