Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06A654DF84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376589AbiFPKvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376484AbiFPKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:51:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4337D5DE48;
        Thu, 16 Jun 2022 03:51:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25GApV0d091863;
        Thu, 16 Jun 2022 05:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655376691;
        bh=AplBO2dgFdhgppnaG/hf43xYN+u1cgW5+n0ebc5nfVE=;
        h=From:To:CC:Subject:Date;
        b=kOEJ1RS3CrrLucyBb2DVRA8xRZHOrfUyNP6A3oEmzvifQsSdVJaBHcUcECoTqASQs
         Omh3yNa7mxSOQDlEiwz747BBNU+M6z8xenBboo75itnCtJaxLDKazKKYF1Uji/NzM4
         Fi8W0RAv513oGJp39FXzAtiGikrng4daNgdY4TOc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25GApV3A010184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jun 2022 05:51:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Jun 2022 05:51:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Jun 2022 05:51:31 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25GApOXS018038;
        Thu, 16 Jun 2022 05:51:26 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <mranostay@ti.com>, Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory region
Date:   Thu, 16 Jun 2022 03:51:12 -0700
Message-ID: <20220616105112.289719-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

GICD region was overlapping with GICR causing the latter to not map
successfully, and in turn the gic-v3 driver would fail to initialize.

This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
replaced of_iomap() calls with of_io_request_and_map() that internally
called request_mem_region().

Respective console output before this patchset:

[    0.000000] GICv3: /bus@100000/interrupt-controller@1800000: couldn't map region 0

Cc: Marc Zyngier <maz@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index be7f39299894..19966f72c5b3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -33,7 +33,7 @@ gic500: interrupt-controller@1800000 {
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		reg = <0x00 0x01800000 0x00 0x100000>, /* GICD */
 		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
 		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
 		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
-- 
2.36.1

