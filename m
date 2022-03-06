Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B84CEC17
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiCFPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 10:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiCFPb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 10:31:29 -0500
X-Greylist: delayed 1885 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 07:30:35 PST
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6B403F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 07:30:35 -0800 (PST)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nQsLi-0001BA-1O; Sun, 06 Mar 2022 15:59:06 +0100
X-Virus-Scanned: by amavisd-new 2.12.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from odroid-x2.fritz.box (p5b125a90.dip0.t-ipconnect.de [91.18.90.144])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 226Ex2O1032520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 6 Mar 2022 15:59:03 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w1: w1_therm: Add support for Maxim MAX31850 thermoelement IF.
Date:   Sun,  6 Mar 2022 15:58:08 +0100
Message-Id: <20220306145817.8753-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1646580635;4b2939a2;
X-HE-SMSGID: 1nQsLi-0001BA-1O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX31850 shares family number 0x3B with DS1825. The device is generally
compatible with DS1825 but needs a different temperature readout.
It operates always in 14 bit mode and has all 4 higher bits of the
Config register set to 1. Conversion time is 100ms.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 drivers/w1/slaves/w1_therm.c | 70 ++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index ca70c5f03206..5c794f558945 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -574,6 +574,41 @@ static inline int w1_DS18S20_convert_time(struct w1_slave *sl)
 		return SLAVE_CONV_TIME_OVERRIDE(sl);
 }
 
+static inline int w1_DS1825_convert_time(struct w1_slave *sl)
+{
+	int ret;
+
+	if (!sl->family_data)
+		return -ENODEV;	/* device unknown */
+
+	if (SLAVE_CONV_TIME_OVERRIDE(sl) != CONV_TIME_DEFAULT)
+		return SLAVE_CONV_TIME_OVERRIDE(sl);
+
+	/* Return the conversion time, depending on resolution,
+	 * select maximum conversion time among all compatible devices
+	 */
+	switch (SLAVE_RESOLUTION(sl)) {
+	case 9:
+		ret = 95;
+		break;
+	case 10:
+		ret = 190;
+		break;
+	case 11:
+		ret = 375;
+		break;
+	case 12:
+		ret = 750;
+		break;
+	case 14:
+		ret = 100; /* MAX31850 only. Datasheet says 100ms  */
+		break;
+	default:
+		ret = 750;
+	}
+	return ret;
+}
+
 static inline int w1_DS18B20_write_data(struct w1_slave *sl,
 				const u8 *data)
 {
@@ -594,6 +629,7 @@ static inline int w1_DS18B20_set_resolution(struct w1_slave *sl, int val)
 
 	/* DS18B20 resolution is 9 to 12 bits */
 	/* GX20MH01 resolution is 9 to 14 bits */
+	/* MAX31850 resolution is fixed 14 bits */
 	if (val < W1_THERM_RESOLUTION_MIN || val > W1_THERM_RESOLUTION_MAX)
 		return -EINVAL;
 
@@ -649,6 +685,7 @@ static inline int w1_DS18B20_get_resolution(struct w1_slave *sl)
 		+ W1_THERM_RESOLUTION_MIN;
 	/* GX20MH01 has one special case:
 	 *   >=14 means 14 bits when getting resolution from bit value.
+	 * MAX31850 delivers fixed 15 and has 14 bits.
 	 * Other devices have no more then 12 bits.
 	 */
 	if (resolution > W1_THERM_RESOLUTION_MAX)
@@ -715,6 +752,34 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
 	return t;
 }
 
+/**
+ * w1_DS1825_convert_temp() - temperature computation for DS1825
+ * @rom: data read from device RAM (8 data bytes + 1 CRC byte)
+ *
+ * Can be called for any DS1825 compliant device.
+ * Is used by MAX31850, too
+ *
+ * Return: value in millidegrees Celsius.
+ */
+
+static inline int w1_DS1825_convert_temp(u8 rom[9])
+{
+	u16 bv;
+	s16 t;
+
+	/* Signed 16-bit value to unsigned, cpu order */
+	bv = le16_to_cpup((__le16 *)rom);
+
+	/* Config register bit 7 = 1 - MA31850 found, 14 bit resolution */
+	if (rom[4] & 0x80) {
+		/* Mask out bits 0 (Fault) and 1 (Reserved) */
+		/* Avoid arithmetic shift of signed value */
+		bv = (bv & 0xFFFC); /* Degrees, lowest 4 bits are 2^-1, 2^-2 and 2 zero bits */
+	}
+	t = (s16)bv;	/* Degrees, lowest bit is 2^-4 */
+	return (int)t * 1000 / 16;	/* Sign-extend to int; millidegrees */
+}
+
 /* Device capability description */
 /* GX20MH01 device shares family number and structure with DS18B20 */
 
@@ -757,9 +822,10 @@ static struct w1_therm_family_converter w1_therm_families[] = {
 		.bulk_read			= false
 	},
 	{
+		/* Also used for MAX31850 */
 		.f				= &w1_therm_family_DS1825,
-		.convert			= w1_DS18B20_convert_temp,
-		.get_conversion_time	= w1_DS18B20_convert_time,
+		.convert			= w1_DS1825_convert_temp,
+		.get_conversion_time	= w1_DS1825_convert_time,
 		.set_resolution		= w1_DS18B20_set_resolution,
 		.get_resolution		= w1_DS18B20_get_resolution,
 		.write_data			= w1_DS18B20_write_data,
-- 
2.30.2

