Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8C4B71DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiBOPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiBOPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4713108772;
        Tue, 15 Feb 2022 07:11:21 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FF3rTL007750;
        Tue, 15 Feb 2022 15:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CwnMi/2c4QJHMS+MQeJ3zcFvrjSZ/vSRpTXDKgZxgFs=;
 b=UZZHMEE1df4MoG+DscfuZMMefHUr/3K1ekPE7nvIZXi8WCxuX6wlFRu3F6B81EKr/I2O
 bE4/gY3i6zd8PlO9ZGGq2jzF7Q3SQ2GCN4+zXthDcJCKy8g06Bnnyr4nHip8lF4AvVcU
 OEZymq7Lij/8yB3AsZlhqwbvz4HPQSZ3kGg6p1vkwXem55/8vv7LGGTur59ncl2zKPTA
 wgic2P+UcIZPNbWjTUwMt+SXtogGT6ZMP0dANBn+0GLelGcOJp5T/O90s5xFk/ruzbPs
 vY20oSgnIrdfzkD4g/fdM1BtX66Y3Led77EIYDfrIHxd3SW8WKR4DZtlTilHKMf+8ypy Vw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8edn8d0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:06 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FF8MIl007887;
        Tue, 15 Feb 2022 15:11:05 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3e64hb94gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:05 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FFB3uh31785408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:11:03 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44C49124052;
        Tue, 15 Feb 2022 15:11:03 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9CDB124085;
        Tue, 15 Feb 2022 15:11:01 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.156.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 15:11:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH 3/4] hwmon: (occ) Add sysfs entries for additional extended status bits
Date:   Tue, 15 Feb 2022 09:10:21 -0600
Message-Id: <20220215151022.7498-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220215151022.7498-1-eajames@linux.ibm.com>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ydSGys_Sws354-17k1wr3k__DS5gQ9RE
X-Proofpoint-ORIG-GUID: ydSGys_Sws354-17k1wr3k__DS5gQ9RE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=767 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add sysfs entries for DVFS due to a VRM Vdd over-temperature condition,
and add the GPU throttling condition bits (such that if bit 1 is set,
GPU1 is throttling).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
index 88f655887c95..b2f788a77746 100644
--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -19,6 +19,8 @@
 #define OCC_EXT_STAT_DVFS_POWER		BIT(6)
 #define OCC_EXT_STAT_MEM_THROTTLE	BIT(5)
 #define OCC_EXT_STAT_QUICK_DROP		BIT(4)
+#define OCC_EXT_STAT_DVFS_VDD		BIT(3)
+#define OCC_EXT_STAT_GPU_THROTTLE	GENMASK(2, 0)
 
 static ssize_t occ_sysfs_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
@@ -69,6 +71,12 @@ static ssize_t occ_sysfs_show(struct device *dev,
 	case 9:
 		val = header->mode;
 		break;
+	case 10:
+		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_VDD);
+		break;
+	case 11:
+		val = header->ext_status & OCC_EXT_STAT_GPU_THROTTLE;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -96,6 +104,8 @@ static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
 static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
 static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
 static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
+static SENSOR_DEVICE_ATTR(occ_dvfs_vdd, 0444, occ_sysfs_show, NULL, 10);
+static SENSOR_DEVICE_ATTR(occ_gpu_throttle, 0444, occ_sysfs_show, NULL, 11);
 static DEVICE_ATTR_RO(occ_error);
 
 static struct attribute *occ_attributes[] = {
@@ -109,6 +119,8 @@ static struct attribute *occ_attributes[] = {
 	&sensor_dev_attr_occs_present.dev_attr.attr,
 	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
 	&sensor_dev_attr_occ_mode.dev_attr.attr,
+	&sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr,
+	&sensor_dev_attr_occ_gpu_throttle.dev_attr.attr,
 	&dev_attr_occ_error.attr,
 	NULL
 };
@@ -166,6 +178,18 @@ void occ_sysfs_poll_done(struct occ *occ)
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
 	}
 
+	if ((header->ext_status & OCC_EXT_STAT_DVFS_VDD) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_VDD)) {
+		name = sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->ext_status & OCC_EXT_STAT_GPU_THROTTLE) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_GPU_THROTTLE)) {
+		name = sensor_dev_attr_occ_gpu_throttle.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
 	if ((header->status & OCC_STAT_MASTER) &&
 	    header->occs_present != occ->prev_occs_present) {
 		name = sensor_dev_attr_occs_present.dev_attr.attr.name;
-- 
2.27.0

