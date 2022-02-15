Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB74B71B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiBOPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiBOPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB4108572;
        Tue, 15 Feb 2022 07:11:19 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FF9WIK002341;
        Tue, 15 Feb 2022 15:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a+iuWb53O1yR35Q/SiXyv/UA3c60dTEY9xh/KCry72g=;
 b=Iaz4v0XMPuB3N3KQ+6mUYgvtK+j/k95UqHerBly5xD2N27y6nQyCaD237aEM5+JuJBch
 hQNCq+02IVoychnt8e0Dflsg8moBC8zA9W+y+kkmZaz/VElEOh+WM6n5gh1wbVF3bUli
 ci69v/rWgrihV8izv6hRr1+VYuEol6VGz/8oOqpKrjRzIe1x013jNoOSP+vELkRPlYuW
 Wz8xR/MUcA38woBoORa+p971sEjg1z8PzKIY7m9e0ICW8MPaX34e6SWYfWAao/x+v1vG
 LrfeuCpHhpHMKa0G8w6/qWZ6UKzg4Ct93HxmRfVX3bIBe7rUPPVv9M8BGU/ji2Xayt5j 7Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8atse3xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:03 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FF8PEO029351;
        Tue, 15 Feb 2022 15:11:02 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3e64hajvvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FFB15A20971938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:11:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4647812407F;
        Tue, 15 Feb 2022 15:11:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF0FA124066;
        Tue, 15 Feb 2022 15:10:59 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.156.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 15:10:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH 2/4] hwmon: (occ) Add sysfs entry for OCC mode
Date:   Tue, 15 Feb 2022 09:10:20 -0600
Message-Id: <20220215151022.7498-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220215151022.7498-1-eajames@linux.ibm.com>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W6rH2zBTLXAMblnhqE1HGru988coMkUd
X-Proofpoint-GUID: W6rH2zBTLXAMblnhqE1HGru988coMkUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=936
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BMC control applications need to check the OCC mode returned by the
OCC poll response, so export it in sysfs with the other OCC-specific
data.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.h |  1 +
 drivers/hwmon/occ/sysfs.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index a88c66d36e38..2dd4a4d240c0 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -120,6 +120,7 @@ struct occ {
 	u8 prev_ext_stat;
 	u8 prev_occs_present;
 	u8 prev_ips_status;
+	u8 prev_mode;
 };
 
 int occ_setup(struct occ *occ, const char *name);
diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
index 6dc69c9aa4c2..88f655887c95 100644
--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -66,6 +66,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
 	case 8:
 		val = header->ips_status;
 		break;
+	case 9:
+		val = header->mode;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -92,6 +95,7 @@ static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
 static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
 static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
 static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
+static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
 static DEVICE_ATTR_RO(occ_error);
 
 static struct attribute *occ_attributes[] = {
@@ -104,6 +108,7 @@ static struct attribute *occ_attributes[] = {
 	&sensor_dev_attr_occ_state.dev_attr.attr,
 	&sensor_dev_attr_occs_present.dev_attr.attr,
 	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
+	&sensor_dev_attr_occ_mode.dev_attr.attr,
 	&dev_attr_occ_error.attr,
 	NULL
 };
@@ -172,6 +177,11 @@ void occ_sysfs_poll_done(struct occ *occ)
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
 	}
 
+	if (header->mode != occ->prev_mode) {
+		name = sensor_dev_attr_occ_mode.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
 	if (occ->error && occ->error != occ->prev_error) {
 		name = dev_attr_occ_error.attr.name;
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
@@ -185,6 +195,7 @@ void occ_sysfs_poll_done(struct occ *occ)
 	occ->prev_ext_stat = header->ext_status;
 	occ->prev_occs_present = header->occs_present;
 	occ->prev_ips_status = header->ips_status;
+	occ->prev_mode = header->mode;
 }
 
 int occ_setup_sysfs(struct occ *occ)
-- 
2.27.0

