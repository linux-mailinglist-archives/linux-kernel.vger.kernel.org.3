Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617634CD58B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiCDNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiCDNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:53:28 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778453CA63;
        Fri,  4 Mar 2022 05:52:37 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224BsWNn027044;
        Fri, 4 Mar 2022 14:51:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=yG2HlQUVVcKdPHhJLDBcI8iIPMmmChs9y0unwzPfcW8=;
 b=KZ4DoPUyPhrUbK8Ynakguzw0ymd9Ak+sX7T+7rL5n2Ikf976kGd5CtfAcST2e9tmTdj6
 DkP912YQg4M18Dj6Kl7zt28ySFDolR+PkiLn8C9EGxmBJL9zOoaFcn7DZ8Ak3LIXN7P7
 D8LamAgQ4Gh18If+mDqJsy6Nst8bF8VESFVPMf/RVxV1RotgMnVaxOfK/LlwvNEu7CLT
 tkTogtL0uFq3N4V8mzKJdR2tcPNa0kpEW9yEegkV5oBFK5pNDmdO5j4HEYmAyBjgHnHZ
 ynJDlodPs7N1y5WcLZjn9ADQo5Mh0Ka5ErelWHgcknfcbILnZ86AOkGRKfi1qmAZ92Xz 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ek4jxd557-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:51:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A038100034;
        Fri,  4 Mar 2022 14:51:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7067E2278B6;
        Fri,  4 Mar 2022 14:51:43 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Mar 2022 14:51:42
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA LLI
Date:   Fri, 4 Mar 2022 14:51:32 +0100
Message-ID: <20220304135134.47827-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304135134.47827-1-yann.gautier@foss.st.com>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STMicroelectronics variant of PL18x, the DMA Linked Lists are supported
starting from revision v2 of the peripheral. But it has limitations,
as all the buffers should be aligned on block size (except the last one).
But this cannot be guaranteed with SDIO. We should then have a property
to disable the support of LLI.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 1e69a5a42439..309a2c0426e5 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -145,6 +145,11 @@ properties:
       driver to sample the receive data (for example with a voltage switch
       transceiver).
 
+  st,disable-dma-lli:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: ST Micro-specific property, disable DMA linked lists.
+      It is used for SDIO.
+
   st,cmd-gpios:
     maxItems: 1
     description:
-- 
2.25.1

