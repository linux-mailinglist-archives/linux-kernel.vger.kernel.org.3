Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB675882CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHBTrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiHBTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:47:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144E4AD63;
        Tue,  2 Aug 2022 12:47:44 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JkEE8010761;
        Tue, 2 Aug 2022 19:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UCu96v+PoXqH6TThpduEionJ8Gjk0/uHBNwYtT0Bioo=;
 b=Jh/0tCylrsH76M20KMM6rTUzE0CIEzbuArR/x8sD6WZ5JpfLboK6OJ3kaBv5WVH1gCUH
 UGceaDaLhziQiRs3OPnLTyrVhTZEwNPze4EDzrUwTcFZTv13BuYfdjoKk/k0tDa8JNLF
 fWQn1dKVqxzNBrZY93uQffJjaIz1LZn8TxfTsR0K9HyuFy/e81FLAUa+T6fa9LkqTJRD
 Tk9KgXuYmH0RTyqhEkegJz/MuAiHsGvXN+U5npe5wR4QHWoEueNAvs4wNtIehK/IX+Yn
 SL6OJ87rMiKo7nuYVCMOxy3Rc6QtQGLSFHvMRLP8CzRPvmNzasiqoeK8XdRua/9Hnvh+ rQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqac7r0g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 272JKixv012973;
        Tue, 2 Aug 2022 19:47:18 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3hmv99m0kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:18 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 272JlIwN50921870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 19:47:18 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DD74124052;
        Tue,  2 Aug 2022 19:47:18 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DF39124054;
        Tue,  2 Aug 2022 19:47:17 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.144.23])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Aug 2022 19:47:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 3/3] hwmon: (occ) Check for device property for setting OCC active during probe
Date:   Tue,  2 Aug 2022 14:46:56 -0500
Message-Id: <20220802194656.240564-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802194656.240564-1-eajames@linux.ibm.com>
References: <20220802194656.240564-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GyuehN5cECTtDHGRUBr-72EanMVEfRD-
X-Proofpoint-ORIG-GUID: GyuehN5cECTtDHGRUBr-72EanMVEfRD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 45407b12db4b..95f16bb0e685 100644
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
+	if (!device_property_read_bool(occ->bus_dev, "ibm,inactive-on-init")) {
+		rc = occ_active(occ, true);
+		if (rc)
+			occ_shutdown_sysfs(occ);
+	}
 
 	return rc;
 }
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 4a1fe4ee8e2c..bc0f190065aa 100644
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
+MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
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

