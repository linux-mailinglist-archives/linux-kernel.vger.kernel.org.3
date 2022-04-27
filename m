Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5951221E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiD0TIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiD0THT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:07:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147E4093A;
        Wed, 27 Apr 2022 11:55:12 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RIi7oN003967;
        Wed, 27 Apr 2022 18:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dn9Xo1APJ5/6vVv+iF7WatOFLVeO5hfIGBJ+FAorzc0=;
 b=YcMbxZUB03AuxKFVGh6AIP1QKTJmn5COUXzWuPCFltetRhpllGnOXFXADVjaTLYtSnAI
 SL6UJF1cfxIDzbHrZf7OYG4Hg6oyRcZMk/65c/EMeIWWJ0VfTUssDuVdjdk4bY0i+f/Z
 8AuVdApmE7+qEoZ3h8SIXVuvgwU9p2wyobponTN1JiwCFqq7A6G+q0KzdWWdAFYZWgE5
 mEFTuHqWIZMW9Ji7+UpmvB96wcj1cP5F2rCSxMiA3AJvHCEBoUfqasrd8g+c/WwFbY41
 rwXhCWWSrMN9f7LEN+xocj6Xf9vCeCI3rvOl4uUgoRKlbWatnd7DqwhF28Q7ZXpbBVdi Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqbcc85et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:55:01 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23RIkAHF008204;
        Wed, 27 Apr 2022 18:55:00 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqbcc85ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:55:00 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23RIqpB0027554;
        Wed, 27 Apr 2022 18:55:00 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3fm939p2nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:55:00 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23RIsx6S62456230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:54:59 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC8A124055;
        Wed, 27 Apr 2022 18:54:59 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E831C124053;
        Wed, 27 Apr 2022 18:54:58 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.88.172])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 18:54:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, eajames@linux.ibm.com,
        dan.carpenter@oracle.com
Subject: [PATCH v5 1/4] leds: pca955x: Refactor with helper functions and renaming
Date:   Wed, 27 Apr 2022 13:54:54 -0500
Message-Id: <20220427185457.27839-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427185457.27839-1-eajames@linux.ibm.com>
References: <20220427185457.27839-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZZLxCfNRJd7BsaPY8w_7MkYPDbyoMtKp
X-Proofpoint-ORIG-GUID: SEoE9UYgqZGaTH4k7pspuF-dBoT7d7mC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=981 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.27.0

