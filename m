Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8158E0AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiHIUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbiHIUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015DA2655C;
        Tue,  9 Aug 2022 13:07:40 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JZ973028621;
        Tue, 9 Aug 2022 20:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5lWmcQueinsQygLGMsb13RXdsAya0MtU+krPfKhqrZU=;
 b=qvtKaP/cRX43Jwet/Oo+bHAxHp3D17cfssjyzIyzQx5NA73uGo7WLOOILF5FDSYrtw32
 q6OR054gvDz2V2bLctWugYXKkkg8Mi5jRJAYn154lcOQL9LPIAHbqR3bDUCBeyw9EBe4
 TqpvsC5b3sqWe+YecTEuVQ5+35KFUpJQGao1e0LDG0xZZ18g7b03er1+iC6Qi74QX8u7
 +obHpheFQYfnjYr4Z140asNg4+He+ZyQJJz9aKn1L/cNNA03f2EXVEkttWezOif9R3mW
 wXp08nNusrpxG9mprby/4jVA1TjnaSps2ujSxXnUFEhuyWk/SUHOmnL0qlDJCKcDeIB/ Cg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwv30xhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:20 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279JpGM3020530;
        Tue, 9 Aug 2022 20:07:19 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3huwvk8714-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:19 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279K7Jag1245764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:07:19 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F87DAC059;
        Tue,  9 Aug 2022 20:07:19 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58F78AC05F;
        Tue,  9 Aug 2022 20:07:18 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:07:18 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 3/3] hwmon: (occ) Check for device property for setting OCC active during probe
Date:   Tue,  9 Aug 2022 15:07:01 -0500
Message-Id: <20220809200701.218059-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809200701.218059-1-eajames@linux.ibm.com>
References: <20220809200701.218059-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qL4cxvaRSWOQ-5avp_t9giHqrB95UmkF
X-Proofpoint-ORIG-GUID: qL4cxvaRSWOQ-5avp_t9giHqrB95UmkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit changed the existing behavior of the driver to skip
attempting to communicate with the OCC during probe. Return to the
previous default behavior of automatically communicating with the OCC
and make it optional with a new device-tree property.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 11 ++++++++++-
 drivers/hwmon/occ/p9_sbe.c |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 45407b12db4b..dd690f700d49 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -10,6 +10,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 #include <asm/unaligned.h>
 
@@ -1216,8 +1217,16 @@ int occ_setup(struct occ *occ)
 	occ->groups[0] = &occ->group;
 
 	rc = occ_setup_sysfs(occ);
-	if (rc)
+	if (rc) {
 		dev_err(occ->bus_dev, "failed to setup sysfs: %d\n", rc);
+		return rc;
+	}
+
+	if (!device_property_read_bool(occ->bus_dev, "ibm,no-poll-on-init")) {
+		rc = occ_active(occ, true);
+		if (rc)
+			occ_shutdown_sysfs(occ);
+	}
 
 	return rc;
 }
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 4a1fe4ee8e2c..3adcf8d0b4a6 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -7,6 +7,7 @@
 #include <linux/fsi-occ.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
@@ -179,9 +180,17 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id p9_sbe_occ_of_match[] = {
+	{ .compatible = "ibm,p9-occ-hwmon" },
+	{ .compatible = "ibm,p10-occ-hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, p9_sbe_occ_of_match);
+
 static struct platform_driver p9_sbe_occ_driver = {
 	.driver = {
 		.name = "occ-hwmon",
+		.of_match_table = p9_sbe_occ_of_match,
 	},
 	.probe	= p9_sbe_occ_probe,
 	.remove = p9_sbe_occ_remove,
-- 
2.31.1

