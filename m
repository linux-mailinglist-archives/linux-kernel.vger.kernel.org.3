Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987154E4BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiCWDmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbiCWDmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:42:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B66C483
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:41:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5D6F82C0821;
        Wed, 23 Mar 2022 03:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648006861;
        bh=3kRD+oortahrXsHkmlIWk4d3La4jPOGfcWeSyoZ6p3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXefxU0NqTGdouL3WTTHJ0pjo7CiBySqtxTe/ys2bdFwuc7+UpSjPs2XDp2cOeQrp
         QMYm5kSN3wFifxu9ehHK4H0nB4yeHiGqFriwrqZGP79mb5zmUG6D5uQtPvqsYCBNZa
         Bz5RBxzsJm47Uj8K9jdYDyjQPXp6EoU+RnnJ48wsvMzFGmDK9rNwnUP+jKVtLrXfCv
         3hfoZ37yE4fZQre/PENuBRv0UukL3YfsZp1D7nvTB3pzPfk96yO84P6erHQbhMcUnp
         iSLt8vW3t1iTTYZD0jIS5U125wZwiK1nkjwwuLSFhhjv1BqwZsLS/GPUp1eCI3ngA3
         xz3vHUd5wq+SA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623a96cc0003>; Wed, 23 Mar 2022 16:41:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id E113B13EE8E;
        Wed, 23 Mar 2022 16:41:00 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 276AB2A2678; Wed, 23 Mar 2022 16:40:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/3] hwmon: (adt7475) Use enum chips when loading attenuator settings
Date:   Wed, 23 Mar 2022 16:40:56 +1300
Message-Id: <20220323034056.260455-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=LMJ1QkyDWGgx0nKO9dUA:9
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

Make use of enum chips and use a switch statement in load_attenuators()
so that the compiler can tell us if we've failed to cater for a
supported chip.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Reword commit message
    - Use switch instead of if/else
    Changes in v2:
    - New

 drivers/hwmon/adt7475.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6de501de41b2..ac480e6e4818 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1569,12 +1569,12 @@ static int set_property_bit(const struct i2c_clie=
nt *client, char *property,
 	return ret;
 }
=20
-static int load_attenuators(const struct i2c_client *client, int chip,
+static int load_attenuators(const struct i2c_client *client, enum chips =
chip,
 			    struct adt7475_data *data)
 {
-	int ret;
-
-	if (chip =3D=3D adt7476 || chip =3D=3D adt7490) {
+	switch (chip) {
+	case adt7476:
+	case adt7490:
 		set_property_bit(client, "adi,bypass-attenuator-in0",
 				 &data->config4, 4);
 		set_property_bit(client, "adi,bypass-attenuator-in1",
@@ -1584,18 +1584,15 @@ static int load_attenuators(const struct i2c_clie=
nt *client, int chip,
 		set_property_bit(client, "adi,bypass-attenuator-in4",
 				 &data->config4, 7);
=20
-		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG4,
-						data->config4);
-		if (ret < 0)
-			return ret;
-	} else if (chip =3D=3D adt7473 || chip =3D=3D adt7475) {
+		return i2c_smbus_write_byte_data(client, REG_CONFIG4,
+						 data->config4);
+	case adt7473:
+	case adt7475:
 		set_property_bit(client, "adi,bypass-attenuator-in1",
 				 &data->config2, 5);
=20
-		ret =3D i2c_smbus_write_byte_data(client, REG_CONFIG2,
-						data->config2);
-		if (ret < 0)
-			return ret;
+		return i2c_smbus_write_byte_data(client, REG_CONFIG2,
+						 data->config2);
 	}
=20
 	return 0;
--=20
2.35.1

