Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D860553609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352882AbiFUPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352862AbiFUPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:25:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392602AE20;
        Tue, 21 Jun 2022 08:24:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LDOnmN024429;
        Tue, 21 Jun 2022 17:24:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=z23/ct457ABHLQlvL8cij+lhb6Mrl6uZfABnK9FVHkg=;
 b=QUSEcn2nSqrhGS21GkFzYxqaDv286NWi6kfDKvbfl80MWdfwCUSOoy1nV/3SmA/mlKJP
 1NVUvHXvDMpcmmthSOXE78VVBA7D9ALur86cJoWw3cT/hNttBi+Xa34SRes3uBUtgtBC
 kZFWgyZLM7j0quHI1NBwfba6FPC9GOSySX6J7tOQPqAWeRn/YrVi4J2Y/rl/xLAy5kD4
 8jaYjKXsy2A4r34qB7LZvkUC14XgzSmbfBaBLQViAIZDVIFljtTKHfFP2TgpdUlrrwUh
 EQyx5rKW7XIOn77tcKr29puLcsbJbRpaftFOCvQgAz6IHUNIdTQz4uNpOZh+5kGXl5WT Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3guaqhagxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:24:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F2DD10002A;
        Tue, 21 Jun 2022 17:24:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02C9B22ECD3;
        Tue, 21 Jun 2022 17:24:36 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 17:24:35 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <stern@rowland.harvard.edu>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 1/4] usb: host: ohci-platform: add TPL support
Date:   Tue, 21 Jun 2022 17:23:47 +0200
Message-ID: <20220621152350.145745-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
References: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

The Target Peripheral List (TPL) is used to identify targeted devices
during Embedded Host compliance testing. The user can add "tpl-support"
in the device tree to enable it.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- update commit message to clarify TPL and EH meaning
- add collected ack
---
 drivers/usb/host/ohci-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 47dfbfe9e5190..0adae62651276 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/of.h>
 
 #include "ohci.h"
 
@@ -210,6 +211,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 	hcd->rsrc_start = res_mem->start;
 	hcd->rsrc_len = resource_size(res_mem);
 
+	hcd->tpl_support = of_usb_host_tpl_support(dev->dev.of_node);
+
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
 		goto err_power;
-- 
2.25.1

