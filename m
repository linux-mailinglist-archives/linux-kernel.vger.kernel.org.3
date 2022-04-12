Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7D4FE623
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357813AbiDLQoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357766AbiDLQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:44:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89F55576E;
        Tue, 12 Apr 2022 09:42:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CEn2Ra010974;
        Tue, 12 Apr 2022 16:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+kBwWuPEUhZ28vc3jxYK1jdylDIHm9/AR3N8jWcX0+0=;
 b=COnORLH4wWSMGZAwhXok4PsvP1nXPeO292LaGHK4gq+zwkMl9Q0CW6zcJgm3XLeCbi4z
 JurVztrVqWzIL3utq1/Bkp49Cso7UUQu0RjpWJNJ+8D9zKkwMlwm0RGrplla7m1kAkti
 wcseTk/Yq+bP2sQZi+zggcW0L/I3A1lu9EGjcgj9CGqJ2EU3z3zpTY17R0aIdYEPBy9e
 g9y/byYJMEj+9RYMV0VFZvNxKBflDa7NMY7TsyOF+wfB0Oku/lgEnCNd7z+M7Q27kHVe
 yXHzqZniuDinslKeJNjGBQRpJNYAFasHJ6iWVnIK1rBRoF7y26J3Lky+N/VjIwPAFCdW eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd9t0dfev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:42:18 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23CGI8bJ017614;
        Tue, 12 Apr 2022 16:42:17 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fd9t0dfem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:42:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23CGXQZA002200;
        Tue, 12 Apr 2022 16:42:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3fb1s9seq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 16:42:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23CGgGf326739046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 16:42:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E82AE060;
        Tue, 12 Apr 2022 16:42:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50CBCAE05F;
        Tue, 12 Apr 2022 16:42:15 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.113.187])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Apr 2022 16:42:15 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, joel@jms.id.au, dan.carpenter@oracle.com,
        patrick@stwcx.xyz, andy.shevchenko@gmail.com
Subject: [PATCH v4 3/4] leds: pca955x: Optimize probe led selection
Date:   Tue, 12 Apr 2022 11:42:10 -0500
Message-Id: <20220412164211.28824-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412164211.28824-1-eajames@linux.ibm.com>
References: <20220412164211.28824-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AjdQG4IJ5Y1Og2Nu4UBil4xTRt_8cJgq
X-Proofpoint-GUID: e4oUe9cwq3k8QImXIgoI1b_B51L4LzZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=655 priorityscore=1501 adultscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the probe function might do up to 32 reads and writes
to the same 4 registers to program the led selection. Reduce this to
a maximum of 8 operations by accumulating the changes to the led
selection and comparing with the previous value to write the
selection if different.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-pca955x.c | 40 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index cb1895b79eab..61f3cb84a945 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -483,7 +483,9 @@ static int pca955x_probe(struct i2c_client *client)
 	struct led_classdev *led;
 	struct led_init_data init_data;
 	struct i2c_adapter *adapter;
-	int i, err;
+	int i, bit, err, nls, reg;
+	u8 ls1[4];
+	u8 ls2[4];
 	struct pca955x_platform_data *pdata;
 	bool set_default_label = false;
 	bool keep_pwm = false;
@@ -554,6 +556,15 @@ static int pca955x_probe(struct i2c_client *client)
 	init_data.devname_mandatory = false;
 	init_data.devicename = "pca955x";
 
+	nls = pca955x_num_led_regs(chip->bits);
+	for (i = 0; i < nls; ++i) {
+		err = pca955x_read_ls(pca955x, i, &ls1[i]);
+		if (err)
+			return err;
+
+		ls2[i] = ls1[i];
+	}
+
 	for (i = 0; i < chip->bits; i++) {
 		pca955x_led = &pca955x->leds[i];
 		pca955x_led->led_num = i;
@@ -565,21 +576,20 @@ static int pca955x_probe(struct i2c_client *client)
 		case PCA955X_TYPE_GPIO:
 			break;
 		case PCA955X_TYPE_LED:
+			bit = i % 4;
+			reg = i / 4;
 			led = &pca955x_led->led_cdev;
 			led->brightness_set_blocking = pca955x_led_set;
 			led->brightness_get = pca955x_led_get;
 
 			if (pdata->leds[i].default_state ==
-			    LEDS_GPIO_DEFSTATE_OFF) {
-				err = pca955x_led_set(led, LED_OFF);
-				if (err)
-					return err;
-			} else if (pdata->leds[i].default_state ==
-				   LEDS_GPIO_DEFSTATE_ON) {
-				err = pca955x_led_set(led, LED_FULL);
-				if (err)
-					return err;
-			}
+			    LEDS_GPIO_DEFSTATE_OFF)
+				ls2[reg] = pca955x_ledsel(ls2[reg], bit,
+							  PCA955X_LS_LED_OFF);
+			else if (pdata->leds[i].default_state ==
+				   LEDS_GPIO_DEFSTATE_ON)
+				ls2[reg] = pca955x_ledsel(ls2[reg], bit,
+							  PCA955X_LS_LED_ON);
 
 			init_data.fwnode = pdata->leds[i].fwnode;
 
@@ -624,6 +634,14 @@ static int pca955x_probe(struct i2c_client *client)
 		}
 	}
 
+	for (i = 0; i < nls; ++i) {
+		if (ls1[i] != ls2[i]) {
+			err = pca955x_write_ls(pca955x, i, ls2[i]);
+			if (err)
+				return err;
+		}
+	}
+
 	/* PWM0 is used for half brightness or 50% duty cycle */
 	err = pca955x_write_pwm(pca955x, 0, 255 - LED_HALF);
 	if (err)
-- 
2.27.0

