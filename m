Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A7567526
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGEREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGERDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:03:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471118E19;
        Tue,  5 Jul 2022 10:03:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 265H3hCp053340;
        Tue, 5 Jul 2022 12:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657040623;
        bh=ku9wzbLDAEKaqpmbOEgxPcBGhRgckaXwz1tDaaNfRTA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CCKWNRgnuY+MPTmzYlWp///cVXepr785bqgeYUhsMbyuIUN20s74DrtrosCjG+tCz
         DkHjHEXhT3fA7ed00QuDmJQH63929koJLeiEZuoOd47SJ63wKZ/EREq7BrYdl6G6T2
         6Y43XPYG4ivd6G/H/M1yLyjzQyKcLdwnaUKvTauw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 265H3hqe103067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jul 2022 12:03:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Jul 2022 12:03:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Jul 2022 12:03:42 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 265H3e09118192;
        Tue, 5 Jul 2022 12:03:42 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 4/6] arm64: dts: ti: k3-am65-main: Move SA2UL to unused PSI-L thread ID
Date:   Tue, 5 Jul 2022 12:03:38 -0500
Message-ID: <20220705170340.26719-4-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705170340.26719-1-afd@ti.com>
References: <20220705170340.26719-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first TX and first two RX PSI-L threads for SA2UL are used
by SYSFW on High Security(HS) devices. Use the next available
threads to prevent resource allocation conflicts.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 113e959ba06d0..2b0bac89b23f2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -117,8 +117,8 @@ crypto: crypto@4e00000 {
 		#size-cells = <2>;
 		ranges = <0x0 0x04e00000 0x00 0x04e00000 0x0 0x30000>;
 
-		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
-				<&main_udmap 0x4001>;
+		dmas = <&main_udmap 0xc001>, <&main_udmap 0x4002>,
+				<&main_udmap 0x4003>;
 		dma-names = "tx", "rx1", "rx2";
 		dma-coherent;
 
-- 
2.36.1

