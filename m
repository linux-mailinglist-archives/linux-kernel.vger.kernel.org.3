Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAE4B70C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbiBOPL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbiBOPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F276D4F0;
        Tue, 15 Feb 2022 07:11:17 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FF3v2a020784;
        Tue, 15 Feb 2022 15:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+S524gr2yY/a9UThKXni+iuVvgWEC/xxBSmrBKnELqY=;
 b=m6xVLZ1s/ukrpwYj3zU6C36aRzXwrXgzJeKfdGTpK/QFBhjur1OGEssg8EhnK5HDuSTD
 H5PUSZq9zciuZ24Sga6rfnc1Tx2TmzS2bYs/22V9oQ+KbHY/9KYVr4XKqrxWMb/f3b2Z
 jiVSoShOXHyfLaHAb2qgah2uJumL8OMvwP+AXBfobJ/rzBsxFimSAgQ1KpIaKwgfw459
 G4cAKbRMIkVIPP7mf105XZqDbLRh4wRpQWM+c2zlEDJeKR26kDc5IjWebOpCTET/IlFF
 LHXwIOmGNWd8HZZJMI4dVzDHiH/gkKXZOq64yZ1f2GzzNHiJtowtHEMzmqT4w16/6TkY pA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8e8c0qeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:02 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FF8Ggu026258;
        Tue, 15 Feb 2022 15:11:01 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3e64hatv8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:00 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FFAx5p37814718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:10:59 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6029A124080;
        Tue, 15 Feb 2022 15:10:59 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3DCA124062;
        Tue, 15 Feb 2022 15:10:57 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.156.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 15:10:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH 1/4] hwmon: (occ) Add sysfs entry for IPS (Idle Power Saver) status
Date:   Tue, 15 Feb 2022 09:10:19 -0600
Message-Id: <20220215151022.7498-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220215151022.7498-1-eajames@linux.ibm.com>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ywrTUjtHauSJeTSWLpiGYN5Qix9lVt91
X-Proofpoint-GUID: ywrTUjtHauSJeTSWLpiGYN5Qix9lVt91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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

BMC control applications need to check the Idle Power Saver status
byte returned by the OCC poll response, so export it in sysfs with
the other OCC-specific data.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.h |  1 +
 drivers/hwmon/occ/sysfs.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 5020117be740..a88c66d36e38 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -119,6 +119,7 @@ struct occ {
 	u8 prev_stat;
 	u8 prev_ext_stat;
 	u8 prev_occs_present;
+	u8 prev_ips_status;
 };
 
 int occ_setup(struct occ *occ, const char *name);
diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
index 03b16abef67f..6dc69c9aa4c2 100644
--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -63,6 +63,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
 		else
 			val = 1;
 		break;
+	case 8:
+		val = header->ips_status;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -88,6 +91,7 @@ static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
 static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
 static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
 static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
+static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
 static DEVICE_ATTR_RO(occ_error);
 
 static struct attribute *occ_attributes[] = {
@@ -99,6 +103,7 @@ static struct attribute *occ_attributes[] = {
 	&sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
 	&sensor_dev_attr_occ_state.dev_attr.attr,
 	&sensor_dev_attr_occs_present.dev_attr.attr,
+	&sensor_dev_attr_occ_ips_status.dev_attr.attr,
 	&dev_attr_occ_error.attr,
 	NULL
 };
@@ -162,6 +167,11 @@ void occ_sysfs_poll_done(struct occ *occ)
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
 	}
 
+	if (header->ips_status != occ->prev_ips_status) {
+		name = sensor_dev_attr_occ_ips_status.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
 	if (occ->error && occ->error != occ->prev_error) {
 		name = dev_attr_occ_error.attr.name;
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
@@ -174,6 +184,7 @@ void occ_sysfs_poll_done(struct occ *occ)
 	occ->prev_stat = header->status;
 	occ->prev_ext_stat = header->ext_status;
 	occ->prev_occs_present = header->occs_present;
+	occ->prev_ips_status = header->ips_status;
 }
 
 int occ_setup_sysfs(struct occ *occ)
-- 
2.27.0

