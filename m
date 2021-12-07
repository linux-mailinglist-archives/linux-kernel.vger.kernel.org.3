Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64346BB91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhLGMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:48:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35100 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236592AbhLGMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:48:49 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B7B1mmN022007;
        Tue, 7 Dec 2021 13:45:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=OyTJSvDtn+sTc+d0hN/bngh9lylJ5evU6S5CH5TSdX8=;
 b=U6V2zq+HzqH9bz+etOwejddvoGmszT+Z/8Cn9dc5z8LzEwnTIa7wD3LeKMuPz0Zft8Yk
 9mw0HOEa+rf0XnAzu/9zDAclP/0GEXPgt4L5DKf7bmvK5qX/VYyxsuTNl7HV9DBJNLAy
 sCG4r77jw4vjos8lgwuqzoehFfWyIJ9XtSF/etid2JB7uE1WljJROVmRR5v1p6I/+Wzj
 CSL58rhezdaPOeO+5VacnVeJZK0DhE3eQJjx5ccspF79jixHh47JaJ6qiO98bnysIkWr
 TFUAwKMgUNrWwN3GCC2FpEpeiHTtEcQVSn2sQPd6mxrZX7QomFOx+ba5atTbCf8R7GaU Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ct1fxa887-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 13:45:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE15110002A;
        Tue,  7 Dec 2021 13:45:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B05322220AB;
        Tue,  7 Dec 2021 13:45:13 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 13:45:12
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] usb: dwc2: fix STM ID/VBUS detection startup delay in dwc2_driver_probe
Date:   Tue, 7 Dec 2021 13:45:10 +0100
Message-ID: <20211207124510.268841-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_04,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When activate_stm_id_vb_detection is enabled, ID and Vbus detection relies
on sensing comparators. This detection needs time to stabilize.
A delay was already applied in dwc2_resume() when reactivating the
detection, but it wasn't done in dwc2_probe().
This patch adds delay after enabling STM ID/VBUS detection. Then, ID state
is good when initializing gadget and host, and avoid to get a wrong
Connector ID Status Change interrupt.

Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/usb/dwc2/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index a1feaa09be57..55d7fca6f95c 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -555,6 +555,9 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
 		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
 		dwc2_writel(hsotg, ggpio, GGPIO);
+
+		/* ID/VBUS detection startup time */
+		usleep_range(5000, 7000);
 	}
 
 	retval = dwc2_drd_init(hsotg);
-- 
2.25.1

