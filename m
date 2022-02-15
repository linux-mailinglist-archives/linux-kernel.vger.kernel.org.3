Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127BC4B7351
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiBOPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiBOPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6B10BC;
        Tue, 15 Feb 2022 07:11:23 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FF3sNR007859;
        Tue, 15 Feb 2022 15:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Kd1FD4NJgY4bDYP6yHxyjz7rGjiUViUnTQ1l/FQqWVQ=;
 b=TXi2D9R92xTUSwVEXodwRPFO2Hk7KFA++mciV7GLyPjXrMlw+w1S63QX85WY/dPu2RG8
 A66xQqnhydLpjci5K3sFPQVbGqYiv3h6+IxkQrXzuYLhTEgyPhbZO/0S+/wk1iUSLbzj
 HXEimJmzmMipmyGG4rnjDBMbxYJ0qadKUUP8f6BEwUC8aUdRq8fCH/8SSxWMoDfDgWtY
 5AyQk0uiKTDZzmEO/IP87Jj6IUyOb7HlivpDYSYHlIbd0Ead3c6TB9U4W5ZHQMJadaCi
 RIyqTjOUtNctgZ+RFi8FHg1ppHTHB/olc4+B4qPpW5MdBXitvw15v9G6LT/y50wTLSjl oA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8edn8d1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:07 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FF9nHA026176;
        Tue, 15 Feb 2022 15:11:06 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3e64hbh47q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:06 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FFB5Xw31064544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:11:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41D14124066;
        Tue, 15 Feb 2022 15:11:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4313124071;
        Tue, 15 Feb 2022 15:11:03 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.156.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 15:11:03 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH 4/4] hwmon: (occ) Add soft minimum power cap attribute
Date:   Tue, 15 Feb 2022 09:10:22 -0600
Message-Id: <20220215151022.7498-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220215151022.7498-1-eajames@linux.ibm.com>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jzDnhRFcB_nxWz-yQJwHFsTK31JU-xMA
X-Proofpoint-ORIG-GUID: jzDnhRFcB_nxWz-yQJwHFsTK31JU-xMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=941 lowpriorityscore=0 priorityscore=1501
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

Export the power caps data for the soft minimum power cap through hwmon.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 0cb4a0a6cbc1..f00cd59f1d19 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -674,6 +674,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
 	case 7:
 		val = caps->user_source;
 		break;
+	case 8:
+		val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -835,12 +838,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 	case 1:
 		num_attrs += (sensors->caps.num_sensors * 7);
 		break;
-	case 3:
-		show_caps = occ_show_caps_3;
-		fallthrough;
 	case 2:
 		num_attrs += (sensors->caps.num_sensors * 8);
 		break;
+	case 3:
+		show_caps = occ_show_caps_3;
+		num_attrs += (sensors->caps.num_sensors * 9);
+		break;
 	default:
 		sensors->caps.num_sensors = 0;
 	}
@@ -1047,6 +1051,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
 						     show_caps, NULL, 7, 0);
 			attr++;
+
+			if (sensors->caps.version > 2) {
+				snprintf(attr->name, sizeof(attr->name),
+					 "power%d_cap_min_soft", s);
+				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+							     show_caps, NULL,
+							     8, 0);
+				attr++;
+			}
 		}
 	}
 
-- 
2.27.0

