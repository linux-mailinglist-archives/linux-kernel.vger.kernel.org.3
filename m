Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866824DBB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349819AbiCPXnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351766AbiCPXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:43:03 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67771AD80
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:41:46 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 060842C0A90;
        Wed, 16 Mar 2022 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647474104;
        bh=DPntaLupexbSQuqCHUpqy2bxzZx7cg0xC2Rn5t8ogeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgWa+h/9AdxzYDO9JbrJWh8pbvVonG+yUGEBtv0g+ef8oTr6jJgEjRk4WW/carfCa
         Tb0KCgyBamMiaZvAXv1H0fls5RKjxuSF8kq90p6z+0PRQuJwbP+Q0eVrwDAn+XVrc2
         xFzxyZ0q5jpeXFnEksUAWChNp/7QrOpGmZ0AWs0HV8yxlh27kSGDZStKbQ+LO8mA+0
         8Xyl8uUMXE9HVRJ527Hc0U3mE3UQsrE+BBSJmhubi6Hrx7UmdXb96Bu83Dfa/3UJ7f
         ZFkL71sM/yn/J5ORlohp3iioVY6I2/brIgJwm9ADSVoJUnQE4xnmtfwRLbUtOZwMls
         iOUS9Jcg4zNpQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623275b70002>; Thu, 17 Mar 2022 12:41:43 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id BC07F13EE43;
        Thu, 17 Mar 2022 12:41:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4AB8E2A267B; Thu, 17 Mar 2022 12:41:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (adt7475) Add support for pin configuration
Date:   Thu, 17 Mar 2022 12:41:34 +1300
Message-Id: <20220316234134.290492-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316234134.290492-1-chris.packham@alliedtelesis.co.nz>
References: <20220316234134.290492-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=3Y0ZRzig23Q1LHC3s8QA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
different functions. On the adt7473 and  adt7475 this is pins 5 and 9.
On the adt7476 and adt7490 this is pins 10 and 14.

The first pin can either be PWM2(default) or SMBALERT#. The second pin
can be TACH4(default), THERM#, SMBALERT# or GPIO.

The adt7475 driver has always been able to detect the configuration if
it had been done by an earlier boot stage. Add support for configuring
the pins based on the hardware description in the device tree.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/hwmon/adt7475.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 9d5b019651f2..ad5e5a7a844b 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -112,6 +112,8 @@
 #define CONFIG3_THERM		0x02
=20
 #define CONFIG4_PINFUNC		0x03
+#define CONFIG4_THERM		0x01
+#define CONFIG4_SMBALERT	0x02
 #define CONFIG4_MAXDUTY		0x08
 #define CONFIG4_ATTN_IN10	0x30
 #define CONFIG4_ATTN_IN43	0xC0
@@ -1460,6 +1462,95 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+static int load_pin10_config(const struct i2c_client *client, const char=
 *propname)
+{
+	const char *function;
+	u8 config3;
+	int err;
+
+	err =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	if (!err) {
+		config3 =3D adt7475_read(REG_CONFIG3);
+
+		if (!strcmp("pwm2", function))
+			config3 &=3D ~CONFIG3_SMBALERT;
+		else if (!strcmp("smbalert#", function))
+			config3 |=3D CONFIG3_SMBALERT;
+		else
+			return -EINVAL;
+
+		return i2c_smbus_write_byte_data(client, REG_CONFIG3, config3);
+	}
+
+	return 0;
+}
+
+static int load_pin14_config(const struct i2c_client *client, const char=
 *propname)
+{
+	const char *function;
+	u8 config4;
+	int err;
+
+	err =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	if (!err) {
+		config4 =3D adt7475_read(REG_CONFIG4);
+		config4 &=3D ~CONFIG4_PINFUNC;
+
+		if (!strcmp("tach4", function))
+			;
+		else if (!strcmp("therm#", function))
+			config4 |=3D CONFIG4_THERM;
+		else if (!strcmp("smbalert#", function))
+			config4 |=3D CONFIG4_SMBALERT;
+		else if (!strcmp("gpio", function))
+			config4 |=3D CONFIG4_PINFUNC;
+		else
+			return -EINVAL;
+
+		return i2c_smbus_write_byte_data(client, REG_CONFIG4, config4);
+	}
+
+	return 0;
+}
+
+static int load_config(const struct i2c_client *client, int chip)
+{
+	int err;
+	const char *conf_prop1, *conf_prop2;
+
+	switch (chip) {
+	case adt7473:
+	case adt7475:
+		conf_prop1 =3D "adi,pin5-function";
+		conf_prop2 =3D "adi,pin9-function";
+		break;
+	case adt7476:
+	case adt7490:
+		conf_prop1 =3D "adi,pin10-function";
+		conf_prop2 =3D "adi,pin14-function";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (chip !=3D adt7476 && chip !=3D adt7490)
+		return 0;
+
+	err =3D load_pin10_config(client, conf_prop1);
+	if (err) {
+		dev_err(&client->dev, "failed to configure PIN10\n");
+		return err;
+	}
+
+	err =3D load_pin14_config(client, conf_prop2);
+	if (err) {
+		dev_err(&client->dev, "failed to configure PIN14\n");
+		return err;
+	}
+
+	return 0;
+}
+
 static int set_property_bit(const struct i2c_client *client, char *prope=
rty,
 			    u8 *config, u8 bit_index)
 {
@@ -1585,6 +1676,10 @@ static int adt7475_probe(struct i2c_client *client=
)
 		revision =3D adt7475_read(REG_DEVID2) & 0x07;
 	}
=20
+	ret =3D load_config(client, chip);
+	if (ret)
+		return ret;
+
 	config3 =3D adt7475_read(REG_CONFIG3);
 	/* Pin PWM2 may alternatively be used for ALERT output */
 	if (!(config3 & CONFIG3_SMBALERT))
--=20
2.35.1

