Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1938B46BAB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhLGMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:12:07 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32922 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236110AbhLGMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:12:06 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B790Cp5003273;
        Tue, 7 Dec 2021 13:08:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=bNVhcWNGKe71QnGOKZL9SpaPP9zmfeIqYSenMOmT5Gw=;
 b=kGC14QIQRFb8ZTVSkFZLhHyIWyOCUxpsnxtbQsX1PV4889GmkdL3aypHydnR1Z9ERz1M
 iwQWn0OnxNd7z7PPTvQQH9mSTGlp+AJJcVCbft+KAFIoodFiHy9+wzv9wVGnj9OwjSIj
 +V8sPY0BZe7nTc/2+XS8X8lS3RAtUtU8lNGTVYtVH5cmE1L09fakrC3NqeI8wT7Rm1tM
 ruCO5CZhtpaVfWQMuAzbRsgfP2G88BpEksYW3X9l01Aa5d58dEpg2a2/manFz3EVbPa0
 6mLrVd2MSXJejf4VdTQlhU///06koCpWSG0rrd7Bi75gvPLBYmGwVN8PcvV3bTTswWy4 cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csmx0myxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 13:08:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9E4B100034;
        Tue,  7 Dec 2021 13:08:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACA1A23BCEB;
        Tue,  7 Dec 2021 13:08:30 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 13:08:30
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] usb: dwc2: platform: adopt dev_err_probe() to silent probe defer
Date:   Tue, 7 Dec 2021 13:08:29 +0100
Message-ID: <20211207120829.266837-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_04,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of probe defer, a message is logged for resets and clocks. Use
dev_err_probe to log the message only when error code is not -517.
Simplify phy, regulators and drd probe defer handling with dev_err_probe().
Then, take benefit of devices_deferred debugfs in case of probe deferral.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/usb/dwc2/platform.c | 53 +++++++++++--------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c8f18f3ba9e3..a1feaa09be57 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -222,20 +222,16 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	int i, ret;
 
 	hsotg->reset = devm_reset_control_get_optional(hsotg->dev, "dwc2");
-	if (IS_ERR(hsotg->reset)) {
-		ret = PTR_ERR(hsotg->reset);
-		dev_err(hsotg->dev, "error getting reset control %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(hsotg->reset))
+		return dev_err_probe(hsotg->dev, PTR_ERR(hsotg->reset),
+				     "error getting reset control\n");
 
 	reset_control_deassert(hsotg->reset);
 
 	hsotg->reset_ecc = devm_reset_control_get_optional(hsotg->dev, "dwc2-ecc");
-	if (IS_ERR(hsotg->reset_ecc)) {
-		ret = PTR_ERR(hsotg->reset_ecc);
-		dev_err(hsotg->dev, "error getting reset control for ecc %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(hsotg->reset_ecc))
+		return dev_err_probe(hsotg->dev, PTR_ERR(hsotg->reset_ecc),
+				     "error getting reset control for ecc\n");
 
 	reset_control_deassert(hsotg->reset_ecc);
 
@@ -251,11 +247,8 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 		case -ENOSYS:
 			hsotg->phy = NULL;
 			break;
-		case -EPROBE_DEFER:
-			return ret;
 		default:
-			dev_err(hsotg->dev, "error getting phy %d\n", ret);
-			return ret;
+			return dev_err_probe(hsotg->dev, ret, "error getting phy\n");
 		}
 	}
 
@@ -268,12 +261,8 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 			case -ENXIO:
 				hsotg->uphy = NULL;
 				break;
-			case -EPROBE_DEFER:
-				return ret;
 			default:
-				dev_err(hsotg->dev, "error getting usb phy %d\n",
-					ret);
-				return ret;
+				return dev_err_probe(hsotg->dev, ret, "error getting usb phy\n");
 			}
 		}
 	}
@@ -282,10 +271,8 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 
 	/* Clock */
 	hsotg->clk = devm_clk_get_optional(hsotg->dev, "otg");
-	if (IS_ERR(hsotg->clk)) {
-		dev_err(hsotg->dev, "cannot get otg clock\n");
-		return PTR_ERR(hsotg->clk);
-	}
+	if (IS_ERR(hsotg->clk))
+		return dev_err_probe(hsotg->dev, PTR_ERR(hsotg->clk), "cannot get otg clock\n");
 
 	/* Regulators */
 	for (i = 0; i < ARRAY_SIZE(hsotg->supplies); i++)
@@ -293,12 +280,9 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 
 	ret = devm_regulator_bulk_get(hsotg->dev, ARRAY_SIZE(hsotg->supplies),
 				      hsotg->supplies);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(hsotg->dev, "failed to request supplies: %d\n",
-				ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(hsotg->dev, ret, "failed to request supplies\n");
+
 	return 0;
 }
 
@@ -558,16 +542,12 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		hsotg->usb33d = devm_regulator_get(hsotg->dev, "usb33d");
 		if (IS_ERR(hsotg->usb33d)) {
 			retval = PTR_ERR(hsotg->usb33d);
-			if (retval != -EPROBE_DEFER)
-				dev_err(hsotg->dev,
-					"failed to request usb33d supply: %d\n",
-					retval);
+			dev_err_probe(hsotg->dev, retval, "failed to request usb33d supply\n");
 			goto error;
 		}
 		retval = regulator_enable(hsotg->usb33d);
 		if (retval) {
-			dev_err(hsotg->dev,
-				"failed to enable usb33d supply: %d\n", retval);
+			dev_err_probe(hsotg->dev, retval, "failed to enable usb33d supply\n");
 			goto error;
 		}
 
@@ -579,8 +559,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 
 	retval = dwc2_drd_init(hsotg);
 	if (retval) {
-		if (retval != -EPROBE_DEFER)
-			dev_err(hsotg->dev, "failed to initialize dual-role\n");
+		dev_err_probe(hsotg->dev, retval, "failed to initialize dual-role\n");
 		goto error_init;
 	}
 
-- 
2.25.1

