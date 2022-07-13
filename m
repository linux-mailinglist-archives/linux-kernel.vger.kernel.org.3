Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF55737AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiGMNk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiGMNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:40:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8735695AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:40:23 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DAkwjr027681;
        Wed, 13 Jul 2022 15:40:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=JRyv1cb2Gr7w/X2gySSfzHJgcDNDC1uKvi9JD4ouJro=;
 b=uxo6Dn2D4OrxCBt13hKgXlMQssGX75dS+VpBAutkoEczXuGj/bt63GIA/gj1WjROUAEn
 KPuo60hCkMaqwJXcg9N+q3YidK0/RJp1ACrKT4Z1cwaTPrMAzBhsLNzLLbp3z2fu6Vof
 kyZfE8nfW2DlIMGupt5Oxn0gWBH503RDNQfTqSXRB6RdeHGqLWvcr4QsIoBO0Pcxw23m
 ljbj8BTiExwk08Ex5TEKD8L1QHDPRRX9QBJMOw8i44Qkbe7DtW+r/WICfQWiVNsuxEmm
 1h45HJTihG7GcuGCwInsz/newACWSP9dn8ICqV09XAF3DrIK2tXkU6cBKRA6NI4lYVHb DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h93cwhtbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 15:40:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 757C210002A;
        Wed, 13 Jul 2022 15:40:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9273222C90;
        Wed, 13 Jul 2022 15:40:07 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 15:40:07 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>
CC:     <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <linux-phy@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: stm32: fix error return in stm32_usbphyc_phy_init
Date:   Wed, 13 Jul 2022 15:39:53 +0200
Message-ID: <20220713133953.595134-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_03,2022-07-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error code is overridden, in case the PLL doesn't lock. So, the USB
initialization can continue. This leads to a platform freeze.
This can be avoided by returning proper error code to avoid USB probe
freezing the platform. It also displays proper errors in log.

Fixes: 5b1af71280ab ("phy: stm32: rework PLL Lock detection")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 007a23c78d562..a98c911cc37ae 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -358,7 +358,9 @@ static int stm32_usbphyc_phy_init(struct phy *phy)
 	return 0;
 
 pll_disable:
-	return stm32_usbphyc_pll_disable(usbphyc);
+	stm32_usbphyc_pll_disable(usbphyc);
+
+	return ret;
 }
 
 static int stm32_usbphyc_phy_exit(struct phy *phy)
-- 
2.25.1

