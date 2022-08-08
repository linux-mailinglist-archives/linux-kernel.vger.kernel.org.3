Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4603D58CDA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiHHScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiHHScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:32:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB917E0F;
        Mon,  8 Aug 2022 11:32:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278IWZhX045032;
        Mon, 8 Aug 2022 13:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659983555;
        bh=0CdOs2sbB/ye+wjuvMndLZxeOJ/mSjL8P5zFmnIyAS8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dl0rRMkPPm7c7Jm8/pD8hL9k4dRrQ8pO+56Jwv4Y0qhjqwHM1TD7/eXL+nuzJV0HD
         KWarssgSytWT4L+tZiXhxQBePL3uzc2cEOr2zAiNt+4Nib8juqp5/9SoFd+4QLZYEh
         5fk/0ZvDYP5GUagEsq2DloCmnJRUhXwhznYpERtg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278IWZbM126836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 13:32:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 13:32:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 13:32:35 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278IWZcm126680;
        Mon, 8 Aug 2022 13:32:35 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64-main: fix RNG node clock id
Date:   Mon, 8 Aug 2022 13:32:01 -0500
Message-ID: <7961aebd737de637fa98bc6a8478380be8449b46.1659981162.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
References: <f29e2c65dc7310a926af8a676651592afac04b03.1659981162.git.danielrparks@ti.com>
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

The RNG node for this platform claims pka_in_clk. Change it to claim the
correct clock x1_clk. [1]

This patch depends on "[PATCH v2 0/2] Enable SA2UL support on AM64X" [2]

[1]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/am64x/clocks.html#clocks-for-sa2-ul0-device
[2]: https://lore.kernel.org/linux-arm-kernel/20220711085743.10128-1-j-choudhary@ti.com/

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 293b6b8e8fb2..aa3b43c515d2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1324,7 +1324,7 @@
 			compatible = "inside-secure,safexcel-eip76";
 			reg = <0x00 0x40910000 0x00 0x7d>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&k3_clks 133 0>;
+			clocks = <&k3_clks 133 1>;
 			status = "disabled"; /* Used by OP-TEE */
 		};
 	};
-- 
2.17.1

