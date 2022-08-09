Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7658E0AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbiHIUIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbiHIUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03926571;
        Tue,  9 Aug 2022 13:07:41 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JXvYV012724;
        Tue, 9 Aug 2022 20:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TV3sMebpyd3j0lWO2Fy/JyNFKcw+E5PtIgF4uxcUqhw=;
 b=q357ZGuN6hljmU9zD7Xr8Cu4E9slHAPXqgzIhLtcwSJ0Z0akGDaJ7CIpZizoNX16Rc55
 GEGq27ipSk2Zu5m5toHH/3jNQobZrfg07buK1sHKvsFB9V+eGq1Nts7D06rk6OINASFP
 XqDr2BMZ7OwPv4xfksqsl0jpAPtkg8fGAUaxd86YRlteNVN4ZXi2PHlajVPgXqVbdghU
 Z1T5av3JeVBHGJZUjbzpGi+KEZFiadb6Wju5dWmugTrrRlbIOblcqVvUV1ct/T68paRs
 f89otG20zQkTL6JxhYDOQ4k75Xr3HCdyReFPbGqkACfZIswfXMsPURfqjFSQqpZKwR5V kw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwur8vgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:18 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279JpaQ2030268;
        Tue, 9 Aug 2022 20:07:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3huwvr86r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:17 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279K7Gud55968186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:07:16 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5252AC05B;
        Tue,  9 Aug 2022 20:07:16 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC1A8AC059;
        Tue,  9 Aug 2022 20:07:15 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:07:15 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 2/3] fsi: occ: Support probing the hwmon child device from dts node
Date:   Tue,  9 Aug 2022 15:07:00 -0500
Message-Id: <20220809200701.218059-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809200701.218059-1-eajames@linux.ibm.com>
References: <20220809200701.218059-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aGIZUkQvzfO8N_51XEKghxCbmP8tw87b
X-Proofpoint-GUID: aGIZUkQvzfO8N_51XEKghxCbmP8tw87b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=935 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208090074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now a need for reading devicetree properties in the OCC
hwmon driver, which isn't current supported as the FSI driver just
instantiates a basic platform device. Add support for this use case
by checking for an "occ-hwmon" node and if present, creating an
OF device from it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 8f7f602b909d..abdd37d5507f 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -44,6 +44,7 @@ struct occ {
 	struct device *sbefifo;
 	char name[32];
 	int idx;
+	bool platform_hwmon;
 	u8 sequence_number;
 	void *buffer;
 	void *client_buffer;
@@ -598,7 +599,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 }
 EXPORT_SYMBOL_GPL(fsi_occ_submit);
 
-static int occ_unregister_child(struct device *dev, void *data)
+static int occ_unregister_platform_child(struct device *dev, void *data)
 {
 	struct platform_device *hwmon_dev = to_platform_device(dev);
 
@@ -607,12 +608,25 @@ static int occ_unregister_child(struct device *dev, void *data)
 	return 0;
 }
 
+static int occ_unregister_of_child(struct device *dev, void *data)
+{
+	struct platform_device *hwmon_dev = to_platform_device(dev);
+
+	of_device_unregister(hwmon_dev);
+	if (dev->of_node)
+		of_node_clear_flag(dev->of_node, OF_POPULATED);
+
+	return 0;
+}
+
 static int occ_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 reg;
+	char child_name[32];
 	struct occ *occ;
-	struct platform_device *hwmon_dev;
+	struct platform_device *hwmon_dev = NULL;
+	struct device_node *hwmon_node;
 	struct device *dev = &pdev->dev;
 	struct platform_device_info hwmon_dev_info = {
 		.parent = dev,
@@ -671,10 +685,20 @@ static int occ_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	hwmon_dev_info.id = occ->idx;
-	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
-	if (IS_ERR(hwmon_dev))
-		dev_warn(dev, "failed to create hwmon device\n");
+	hwmon_node = of_get_child_by_name(dev->of_node, hwmon_dev_info.name);
+	if (hwmon_node) {
+		snprintf(child_name, sizeof(child_name), "%s.%d", hwmon_dev_info.name, occ->idx);
+		hwmon_dev = of_platform_device_create(hwmon_node, child_name, dev);
+		of_node_put(hwmon_node);
+	}
+
+	if (!hwmon_dev) {
+		occ->platform_hwmon = true;
+		hwmon_dev_info.id = occ->idx;
+		hwmon_dev = platform_device_register_full(&hwmon_dev_info);
+		if (IS_ERR(hwmon_dev))
+			dev_warn(dev, "failed to create hwmon device\n");
+	}
 
 	return 0;
 }
@@ -690,7 +714,10 @@ static int occ_remove(struct platform_device *pdev)
 	occ->buffer = NULL;
 	mutex_unlock(&occ->occ_lock);
 
-	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
+	if (occ->platform_hwmon)
+		device_for_each_child(&pdev->dev, NULL, occ_unregister_platform_child);
+	else
+		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
 	ida_simple_remove(&occ_ida, occ->idx);
 
-- 
2.31.1

