Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8B51857E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiECNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiECNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:35:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EA1C10D;
        Tue,  3 May 2022 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651584700; x=1683120700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R0qtLJZR68JVrZnY5mJ4pF2K279v+Zoi9zPW0eN/Hm4=;
  b=WMXJFaOCY/GbmB9s9JaoQeXiCXUvnchMvcvAawt61VeXOMa4je+in61l
   k4TjeGA4ISO9yZmRjKvNITocbibqI/1aOQkJv7lPQ/tsm3G7Lipz5dRDl
   xHKpFp5OjPmIWI7o/7fJv05Y62yCVtFCkzCtCMfv6uMsp7wsauFEZddkf
   2tK0/jm5fq7PZXtWdLR+RONlQEgPsktvoTPA0wL6daGJCp46jafEewZ/Q
   QG4VqpaFpdowLwiwnZNSCmHO34IQX/nte/IhLNSvFj9Ls3SOWyGjxhEII
   kHtngQH5FemfZOXyO50alSiO/SDyStFoSSBMJBk+2zwNjrzrSnAb+xFJ0
   g==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="171766718"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 06:31:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 06:31:39 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 06:31:37 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: remove interrupt-parent from gic node
Date:   Tue, 3 May 2022 16:31:27 +0300
Message-ID: <20220503133127.64320-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt-parent is not to be used as a boolean property.
It is already present in the DT in the proper way it's supposed to be used:
interrupt-parent = <&gic>;

This is also reported by dtbs_check:
arch/arm/boot/dts/at91-sama7g5ek.dtb: interrupt-controller@e8c11000: interrupt-parent: True is not of type 'array'
	From schema: /.local/lib/python3.8/site-packages/dtschema/schemas/interrupts.yaml

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index cdaa9c825f69..f4f174314e4e 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -949,7 +949,6 @@ gic: interrupt-controller@e8c11000 {
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 			interrupt-controller;
-			interrupt-parent;
 			reg = <0xe8c11000 0x1000>,
 				<0xe8c12000 0x2000>;
 		};
-- 
2.25.1

