Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41F34E4BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiCWDmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiCWDmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:42:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C06C1FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:41:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A0572C019D;
        Wed, 23 Mar 2022 03:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648006861;
        bh=SFKgLIPsvOUN7XZMnx1oJR+KwBhf/ELsJ74Wsq3d3nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRib6Cf0hCfibMSSxXunVx91ScYl6QxUDBcdB01raBJ4ln+MwAMGYIsFTW8MUID19
         LHwveMskdOj7HiLVwdV9qDCvaU3QcCrv9Rffo4cR7wfdPKhN7LSktXUzKLBpDQtc5I
         kh5wf+u8DE/cFueS4JfQ6/Js8mBjWRB8ttPlcAtz2t4WRRy96NoS3Z/+CRD8QLTqao
         D/gFMSDmv1Gpfd+rAfoY7UjRd4QF7cxaISjzgae7mOrWj0AF7eZhgMctT1XJrnnAwP
         cFZ/txxVLWmlUCwC8+sOFoXj3bx+UoEar1QbKj1OCrOwO6CHl5ObCTvONsASeo+19q
         JFmiSq1xlUj0w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623a96cc0002>; Wed, 23 Mar 2022 16:41:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id DE28C13EE82;
        Wed, 23 Mar 2022 16:41:00 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 248D12A2678; Wed, 23 Mar 2022 16:40:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/3] hwmon: (adt7475) Add support for pin configuration
Date:   Wed, 23 Mar 2022 16:40:55 +1300
Message-Id: <20220323034056.260455-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=cFeUy8Ca9zMUrnV-lPcA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Notes:
    Changes in v3:
    - None
    Changes in v2:
    - Use load_config{3,4} instead of load_pin{10,14}_config
    - Handle errors from adt7475_read()
    - Remove obsolete check on chip type
    - Use enum chips instead of int
    - Update error messages

 drivers/hwmon/adt7475.c | 96 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 9d5b019651f2..6de501de41b2 100644
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
@@ -1460,6 +1462,96 @@ static int adt7475_update_limits(struct i2c_client=
 *client)
 	return 0;
 }
=20
+static int load_config3(const struct i2c_client *client, const char *pro=
pname)
+{
+	const char *function;
+	u8 config3;
+	int ret;
+
+	ret =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	if (!ret) {
+		ret =3D adt7475_read(REG_CONFIG3);
+		if (ret < 0)
+			return ret;
+
+		config3 =3D ret & ~CONFIG3_SMBALERT;
+		if (!strcmp("pwm2", function))
+			;
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
+static int load_config4(const struct i2c_client *client, const char *pro=
pname)
+{
+	const char *function;
+	u8 config4;
+	int ret;
+
+	ret =3D of_property_read_string(client->dev.of_node, propname, &functio=
n);
+	if (!ret) {
+		ret =3D adt7475_read(REG_CONFIG4);
+		if (ret < 0)
+			return ret;
+
+		config4 =3D ret & ~CONFIG4_PINFUNC;
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
+static int load_config(const struct i2c_client *client, enum chips chip)
+{
+	int err;
+	const char *prop1, *prop2;
+
+	switch (chip) {
+	case adt7473:
+	case adt7475:
+		prop1 =3D "adi,pin5-function";
+		prop2 =3D "adi,pin9-function";
+		break;
+	case adt7476:
+	case adt7490:
+		prop1 =3D "adi,pin10-function";
+		prop2 =3D "adi,pin14-function";
+		break;
+	}
+
+	err =3D load_config3(client, prop1);
+	if (err) {
+		dev_err(&client->dev, "failed to configure %s\n", prop1);
+		return err;
+	}
+
+	err =3D load_config4(client, prop2);
+	if (err) {
+		dev_err(&client->dev, "failed to configure %s\n", prop2);
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
@@ -1585,6 +1677,10 @@ static int adt7475_probe(struct i2c_client *client=
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

