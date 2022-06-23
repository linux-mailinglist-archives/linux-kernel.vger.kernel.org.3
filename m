Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594B557751
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFWKAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiFWKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:00:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F649242;
        Thu, 23 Jun 2022 03:00:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25N9xua9083932;
        Thu, 23 Jun 2022 04:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655978396;
        bh=4kG3Ynj+tbSYV+1UvVXFJIwAJuCohVdrEJEAMdJ9Bgg=;
        h=From:To:CC:Subject:Date;
        b=ae6oG7EBnKt/KRcG+Y/oVC1i7pErTa9HzUcALcNuvtLSR7gkOSxQyLYoUJHy/Bzp8
         jxucjP2ARc/WlrL+kJ2BGRPlA33nKx+YkkQVvP7PLsfF8Qvlgxn53mI1NrYHxaKM68
         LGhgHxamKiN8fqhOFcIawgUM+ge+ZfDu97GfCZ9c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25N9xuiZ002959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 04:59:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 04:59:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 04:59:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25N9xtEM086938;
        Thu, 23 Jun 2022 04:59:55 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j-choudhary@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Enable crypto accelerator
Date:   Thu, 23 Jun 2022 15:29:55 +0530
Message-ID: <20220623095955.161307-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the node for sa3ul crypto accelerator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
On local testing, crypto self-tests and tcrypt tests were passing
for SHA256, SHA512, ECB-AES and CBC-AES algorithms.
RNG node has not been added due to the indirect access of the
hardware random number generator from OP-TEE.

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index df3b9883e887..30bd22ff2fc9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -165,6 +165,19 @@
 		};
 	};
 
+	crypto: crypto@40900000 {
+		compatible = "ti,am62-sa3ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+
+		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
+				<&main_pktdma 0x7507 0>;
+		dma-names = "tx", "rx1", "rx2";
+	};
+
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2ac>;
-- 
2.17.1

