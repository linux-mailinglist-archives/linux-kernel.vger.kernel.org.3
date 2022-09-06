Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE65AF789
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIFV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIFV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:59:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E993505;
        Tue,  6 Sep 2022 14:59:04 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286L3LGa028070;
        Tue, 6 Sep 2022 21:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Xls3+VhiWPL1H7EG04fvTAsiPtahlsrlZhP5ysvCywA=;
 b=KZakbhFNO4ZEhKk8imumV8sO2Lq/zsE2tfgU+DoxGntCPtCCPkS1sTVW1koEctDG6j1u
 cEFf2S9n3aEKIgMide3Qq0Dj5iUMTz5hgCuZ5Bz61peT7yS+qTZvBroOeoNYgQM/SQ/h
 9I5O+KHCcz6sP9n2F9yk8qgjGiqEIHnKnz69uDSDcbqbvr9nMv8/daH//EGbwY5Vmsn0
 LW5PlDFG8VFPqO7WZH65caF0ocJhF0fsGte2ZRYy5YfWAtByBztk2C13nljWLzmYtmDY
 B4WqEZlYImlh3bgGDPrpF7CEyAy94VTC7LrLMQl3+MhqaB271sFvE3u3SPu/T+WhGZVb qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jedsc19mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 21:58:59 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286LLoOB010813;
        Tue, 6 Sep 2022 21:58:59 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jedsc19m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 21:58:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286LpN3l029594;
        Tue, 6 Sep 2022 21:58:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9uh7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 21:58:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Lwv552884192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 21:58:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9369B2065;
        Tue,  6 Sep 2022 21:58:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20A86B205F;
        Tue,  6 Sep 2022 21:58:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.74.237])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 21:58:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, joel@jms.id.au,
        dan.carpenter@oracle.com, eajames@linux.ibm.com
Subject: [PATCH v6 1/4] leds: pca955x: Refactor with helper functions and renaming
Date:   Tue,  6 Sep 2022 16:58:52 -0500
Message-Id: <20220906215855.1937331-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906215855.1937331-1-eajames@linux.ibm.com>
References: <20220906215855.1937331-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UiU7Ak7jAYRX3uw-qJEkR-s5HmJsSX3L
X-Proofpoint-GUID: X7b7_REPAPbyh7mF2IPu9zxtXhxs77nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to clean up the code, and rename a few
oddly named functions and variables.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/leds-pca955x.c | 50 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 81aaf21212d7..a683c872e1ff 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -134,19 +134,21 @@ struct pca955x_led {
 	struct fwnode_handle	*fwnode;
 };
 
+#define led_to_pca955x(l)	container_of(l, struct pca955x_led, led_cdev)
+
 struct pca955x_platform_data {
 	struct pca955x_led	*leds;
 	int			num_leds;
 };
 
 /* 8 bits per input register */
-static inline int pca95xx_num_input_regs(int bits)
+static inline int pca955x_num_input_regs(int bits)
 {
 	return (bits + 7) / 8;
 }
 
 /* 4 bits per LED selector register */
-static inline int pca95xx_num_led_regs(int bits)
+static inline int pca955x_num_led_regs(int bits)
 {
 	return (bits + 3)  / 4;
 }
@@ -161,6 +163,11 @@ static inline u8 pca955x_ledsel(u8 oldval, int led_num, int state)
 		((state & 0x3) << (led_num << 1));
 }
 
+static inline int pca955x_ledstate(u8 ls, int led_num)
+{
+	return (ls >> (led_num << 1)) & 0x3;
+}
+
 /*
  * Write to frequency prescaler register, used to program the
  * period of the PWM output.  period = (PSCx + 1) / 38
@@ -168,7 +175,7 @@ static inline u8 pca955x_ledsel(u8 oldval, int led_num, int state)
 static int pca955x_write_psc(struct i2c_client *client, int n, u8 val)
 {
 	struct pca955x *pca955x = i2c_get_clientdata(client);
-	u8 cmd = pca95xx_num_input_regs(pca955x->chipdef->bits) + (2 * n);
+	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + (2 * n);
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, cmd, val);
@@ -188,7 +195,7 @@ static int pca955x_write_psc(struct i2c_client *client, int n, u8 val)
 static int pca955x_write_pwm(struct i2c_client *client, int n, u8 val)
 {
 	struct pca955x *pca955x = i2c_get_clientdata(client);
-	u8 cmd = pca95xx_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
+	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, cmd, val);
@@ -205,7 +212,7 @@ static int pca955x_write_pwm(struct i2c_client *client, int n, u8 val)
 static int pca955x_write_ls(struct i2c_client *client, int n, u8 val)
 {
 	struct pca955x *pca955x = i2c_get_clientdata(client);
-	u8 cmd = pca95xx_num_input_regs(pca955x->chipdef->bits) + 4 + n;
+	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 4 + n;
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, cmd, val);
@@ -222,7 +229,7 @@ static int pca955x_write_ls(struct i2c_client *client, int n, u8 val)
 static int pca955x_read_ls(struct i2c_client *client, int n, u8 *val)
 {
 	struct pca955x *pca955x = i2c_get_clientdata(client);
-	u8 cmd = pca95xx_num_input_regs(pca955x->chipdef->bits) + 4 + n;
+	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 4 + n;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, cmd);
@@ -238,7 +245,7 @@ static int pca955x_read_ls(struct i2c_client *client, int n, u8 *val)
 static int pca955x_read_pwm(struct i2c_client *client, int n, u8 *val)
 {
 	struct pca955x *pca955x = i2c_get_clientdata(client);
-	u8 cmd = pca95xx_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
+	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + 1 + (2 * n);
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, cmd);
@@ -253,9 +260,7 @@ static int pca955x_read_pwm(struct i2c_client *client, int n, u8 *val)
 
 static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
 {
-	struct pca955x_led *pca955x_led = container_of(led_cdev,
-						       struct pca955x_led,
-						       led_cdev);
+	struct pca955x_led *pca955x_led = led_to_pca955x(led_cdev);
 	struct pca955x *pca955x = pca955x_led->pca955x;
 	u8 ls, pwm;
 	int ret;
@@ -264,8 +269,7 @@ static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
 	if (ret)
 		return ret;
 
-	ls = (ls >> ((pca955x_led->led_num % 4) << 1)) & 0x3;
-	switch (ls) {
+	switch (pca955x_ledstate(ls, pca955x_led->led_num % 4)) {
 	case PCA955X_LS_LED_ON:
 		ret = LED_FULL;
 		break;
@@ -289,19 +293,13 @@ static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
 static int pca955x_led_set(struct led_classdev *led_cdev,
 			    enum led_brightness value)
 {
-	struct pca955x_led *pca955x_led;
-	struct pca955x *pca955x;
+	struct pca955x_led *pca955x_led = led_to_pca955x(led_cdev);
+	struct pca955x *pca955x = pca955x_led->pca955x;
+	int reg = pca955x_led->led_num / 4;
+	int bit = pca955x_led->led_num % 4;
 	u8 ls;
-	int chip_ls;	/* which LSx to use (0-3 potentially) */
-	int ls_led;	/* which set of bits within LSx to use (0-3) */
 	int ret;
 
-	pca955x_led = container_of(led_cdev, struct pca955x_led, led_cdev);
-	pca955x = pca955x_led->pca955x;
-
-	chip_ls = pca955x_led->led_num / 4;
-	ls_led = pca955x_led->led_num % 4;
-
 	mutex_lock(&pca955x->lock);
 
 	ret = pca955x_read_ls(pca955x->client, chip_ls, &ls);
@@ -310,13 +308,13 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
 
 	switch (value) {
 	case LED_FULL:
-		ls = pca955x_ledsel(ls, ls_led, PCA955X_LS_LED_ON);
+		ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_ON);
 		break;
 	case LED_OFF:
-		ls = pca955x_ledsel(ls, ls_led, PCA955X_LS_LED_OFF);
+		ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_OFF);
 		break;
 	case LED_HALF:
-		ls = pca955x_ledsel(ls, ls_led, PCA955X_LS_BLINK0);
+		ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK0);
 		break;
 	default:
 		/*
@@ -329,7 +327,7 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
 		ret = pca955x_write_pwm(pca955x->client, 1, 255 - value);
 		if (ret)
 			goto out;
-		ls = pca955x_ledsel(ls, ls_led, PCA955X_LS_BLINK1);
+		ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK1);
 		break;
 	}
 
-- 
2.31.1

