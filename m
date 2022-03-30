Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAE4EBFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbiC3Lf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiC3LfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:35:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD912AA6;
        Wed, 30 Mar 2022 04:33:38 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 774BE2223B;
        Wed, 30 Mar 2022 13:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648640016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsecLKMJ23DcPDvyv9r6OEmkMjx2OTnETouEGlm5Tm0=;
        b=Uy9QprrSkIP0z3KiMZZ4KQPu+srXJ91o+O/FJTOKyTD2KyutF3fNV6TumTaKNwWHH+2wio
        /IARoslpaB4rpFPv12Cms944VBkRtZeWDk27ayCOVPeYTwmdREBJM5luLKRw+WPr/HBVmV
        gY2YgJjESCedin5Mz3DlsIynqPrTRUA=
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: sl28: use ocelot-8021q tagging by default
Date:   Wed, 30 Mar 2022 13:33:29 +0200
Message-Id: <20220330113329.3402438-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ocelot-8021q tagger by default which supports ethernet flow
control.

The new default is set in the common board dtsi. The actual switch
node is enabled on a per board variant basis. Because of this we
set the new tagger default for both internal ports and a particular
variant is free to choose among the two port.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 7ef47b80e343..68d11a9c67f3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -328,6 +328,14 @@ &lpuart1 {
 	status = "okay";
 };
 
+&mscc_felix_port4 {
+	dsa-tag-protocol = "ocelot-8021q";
+};
+
+&mscc_felix_port5 {
+	dsa-tag-protocol = "ocelot-8021q";
+};
+
 &usb0 {
 	status = "okay";
 };
-- 
2.30.2

