Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80B5532F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351283AbiFUNGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350821AbiFUNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:05:58 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5C5237F2;
        Tue, 21 Jun 2022 06:05:57 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LCFCs4032492;
        Tue, 21 Jun 2022 15:05:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=kGFdEOd4Hn+bp4L8O4UHs/GgLmuaX/4g+RGps8zypXM=;
 b=0Tf5P62jv13J/ItGHFfVm9NGBAcYfEZ67Mlz8icx/CwLABbG6IlNp26/tiRRNNz9s0tT
 lAY0X0P62tNOZyWp1rOieE1zwSe53I4EvY+TpA9Xw1Kcg/skj+z1oQDZ/IPzX9mf7yD0
 dLvEKaEC+R5TIYGNdX4xa6MW2VEtyUIyDy4Be2LXUqbtGe63+tjhP/6+kR/iicQLk4K1
 2px2luFv6F0soSyv3DVCvgpxRhb8W11lJ+bWEw2QzfiEtxfm6YuSzPEPH+YlZbo4mA2k
 zqtiQN/EdZAx7+tdHAIkkSpPRJPRac8qqQu78HvvvJTTIl6CIZpmVLJqIbI1QaBWPbCh nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gu9vcj2n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 15:05:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8503E100034;
        Tue, 21 Jun 2022 15:05:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 805682248AA;
        Tue, 21 Jun 2022 15:05:33 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 15:05:33 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 3/3] usb: dwc2: host: add TPL support
Date:   Tue, 21 Jun 2022 15:05:06 +0200
Message-ID: <20220621130506.85424-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621130506.85424-1-fabrice.gasnier@foss.st.com>
References: <20220621130506.85424-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_06,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

The TPL support is used to identify targeted devices during EH compliance
test. The user can add "tpl-support" in the device tree to enable it.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f63a27d11fac8..4567f3c24d225 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -52,6 +52,7 @@
 
 #include <linux/usb/hcd.h>
 #include <linux/usb/ch11.h>
+#include <linux/usb/of.h>
 
 #include "core.h"
 #include "hcd.h"
@@ -5339,6 +5340,8 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 	/* Don't support SG list at this point */
 	hcd->self.sg_tablesize = 0;
 
+	hcd->tpl_support = of_usb_host_tpl_support(hsotg->dev->of_node);
+
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_host(hsotg->uphy->otg, &hcd->self);
 
-- 
2.25.1

