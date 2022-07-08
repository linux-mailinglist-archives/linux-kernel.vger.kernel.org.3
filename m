Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE256B437
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiGHIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiGHIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:09:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060A8049D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:09:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26888pQK112021;
        Fri, 8 Jul 2022 03:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657267732;
        bh=pSW4QP6rE3DVVlQfx3e1KIdZpOm5BpSBOMUsYnQDylE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FO5lvJ0XOuP77VtwHGwC676BL+YKlQNrmFMr5UU6cSxqLF1gXhzkb5z4HkDma0OAp
         sB7/T+yZFoRe454yDRJ4ALA4trCjnuFSRXyzElh4j3UzHACNuG//+qBqmGFp3ESCcc
         l85E2qPKaHfPtmRswGmfdkg4SaQO8ZdY5EbgPiEA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26888p3r052915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 03:08:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 03:08:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 03:08:51 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26888ioh119145;
        Fri, 8 Jul 2022 03:08:49 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 2/2] dmaengine: ti: k3-psil: add additional TX threads for j7200
Date:   Fri, 8 Jul 2022 01:08:36 -0700
Message-ID: <20220708080836.431043-3-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708080836.431043-1-mranostay@ti.com>
References: <20220708080836.431043-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add matching PSI-L threads mapping for transmission DMA channels
on the J7200 platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/dma/ti/k3-psil-j7200.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j7200.c b/drivers/dma/ti/k3-psil-j7200.c
index 5ea63ea74822..e3feff869991 100644
--- a/drivers/dma/ti/k3-psil-j7200.c
+++ b/drivers/dma/ti/k3-psil-j7200.c
@@ -143,6 +143,57 @@ static struct psil_ep j7200_src_ep_map[] = {
 
 /* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
 static struct psil_ep j7200_dst_ep_map[] = {
+	/* PDMA_MCASP - McASP0-2 */
+	PSIL_PDMA_MCASP(0xc400),
+	PSIL_PDMA_MCASP(0xc401),
+	PSIL_PDMA_MCASP(0xc402),
+	/* PDMA_SPI_G0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0xc600),
+	PSIL_PDMA_XY_PKT(0xc601),
+	PSIL_PDMA_XY_PKT(0xc602),
+	PSIL_PDMA_XY_PKT(0xc603),
+	PSIL_PDMA_XY_PKT(0xc604),
+	PSIL_PDMA_XY_PKT(0xc605),
+	PSIL_PDMA_XY_PKT(0xc606),
+	PSIL_PDMA_XY_PKT(0xc607),
+	PSIL_PDMA_XY_PKT(0xc608),
+	PSIL_PDMA_XY_PKT(0xc609),
+	PSIL_PDMA_XY_PKT(0xc60a),
+	PSIL_PDMA_XY_PKT(0xc60b),
+	PSIL_PDMA_XY_PKT(0xc60c),
+	PSIL_PDMA_XY_PKT(0xc60d),
+	PSIL_PDMA_XY_PKT(0xc60e),
+	PSIL_PDMA_XY_PKT(0xc60f),
+	/* PDMA_SPI_G1 - SPI4-7 */
+	PSIL_PDMA_XY_PKT(0xc610),
+	PSIL_PDMA_XY_PKT(0xc611),
+	PSIL_PDMA_XY_PKT(0xc612),
+	PSIL_PDMA_XY_PKT(0xc613),
+	PSIL_PDMA_XY_PKT(0xc614),
+	PSIL_PDMA_XY_PKT(0xc615),
+	PSIL_PDMA_XY_PKT(0xc616),
+	PSIL_PDMA_XY_PKT(0xc617),
+	PSIL_PDMA_XY_PKT(0xc618),
+	PSIL_PDMA_XY_PKT(0xc619),
+	PSIL_PDMA_XY_PKT(0xc61a),
+	PSIL_PDMA_XY_PKT(0xc61b),
+	PSIL_PDMA_XY_PKT(0xc61c),
+	PSIL_PDMA_XY_PKT(0xc61d),
+	PSIL_PDMA_XY_PKT(0xc61e),
+	PSIL_PDMA_XY_PKT(0xc61f),
+	/* PDMA_USART_G0 - UART0-1 */
+	PSIL_PDMA_XY_PKT(0xc700),
+	PSIL_PDMA_XY_PKT(0xc701),
+	/* PDMA_USART_G1 - UART2-3 */
+	PSIL_PDMA_XY_PKT(0xc702),
+	PSIL_PDMA_XY_PKT(0xc703),
+	/* PDMA_USART_G2 - UART4-9 */
+	PSIL_PDMA_XY_PKT(0xc704),
+	PSIL_PDMA_XY_PKT(0xc705),
+	PSIL_PDMA_XY_PKT(0xc706),
+	PSIL_PDMA_XY_PKT(0xc707),
+	PSIL_PDMA_XY_PKT(0xc708),
+	PSIL_PDMA_XY_PKT(0xc709),
 	/* CPSW5 */
 	PSIL_ETHERNET(0xca00),
 	PSIL_ETHERNET(0xca01),
@@ -161,6 +212,22 @@ static struct psil_ep j7200_dst_ep_map[] = {
 	PSIL_ETHERNET(0xf005),
 	PSIL_ETHERNET(0xf006),
 	PSIL_ETHERNET(0xf007),
+	/* MCU_PDMA_MISC_G0 - SPI0 */
+	PSIL_PDMA_XY_PKT(0xf100),
+	PSIL_PDMA_XY_PKT(0xf101),
+	PSIL_PDMA_XY_PKT(0xf102),
+	PSIL_PDMA_XY_PKT(0xf103),
+	/* MCU_PDMA_MISC_G1 - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0xf200),
+	PSIL_PDMA_XY_PKT(0xf201),
+	PSIL_PDMA_XY_PKT(0xf202),
+	PSIL_PDMA_XY_PKT(0xf203),
+	PSIL_PDMA_XY_PKT(0xf204),
+	PSIL_PDMA_XY_PKT(0xf205),
+	PSIL_PDMA_XY_PKT(0xf206),
+	PSIL_PDMA_XY_PKT(0xf207),
+	/* MCU_PDMA_MISC_G2 - UART0 */
+	PSIL_PDMA_XY_PKT(0xf300),
 	/* SA2UL */
 	PSIL_SA2UL(0xf500, 1),
 	PSIL_SA2UL(0xf501, 1),
-- 
2.36.1

