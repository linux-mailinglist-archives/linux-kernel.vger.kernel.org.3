Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE94AB764
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349082AbiBGJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiBGJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:05:38 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150139.outbound.protection.outlook.com [40.107.15.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1456C0401C0;
        Mon,  7 Feb 2022 01:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXSgQulrkueqll5bo9hZOW84UAkG6PdEzTAEUK5JNI9GpA4tORnay7Ys3i+H1mLBq1ZKuL8TS0aot8Druf0lK+ACJJgECxWOcer4dppR6i3nuMdGljlKiU9yhsRALz9eR/+zcAI07xHREV6WCw94pXj926erBRi53nBYOvt23fOhH6Or1gYu/qf3hHEN5YaW2tlTtIM3OoztLGlW7Dpj9Vra3dewAtgYXX4/v6thNQm6XEETs7rdvZYADPsKjvL7mAgFBdRSIj6jYFLn6cQbul/glqnL/6kzdHK/uhpywTLwI/h/TvQSMicUF+YOkUZLW7QYzvFsewQzGiXvTcWnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBB+qAVf3XpJfENe2HzFYwXis4U3Nljh76OrmKsTuqw=;
 b=kMrB/1i9pag3Nzj84bnu/y0GnvugPUhse4rFST77vTM5LuqWIL75JaRoEkwTz4UC9psMD+ZG08Y6YWU2ngRu2ckoYIdaVNHulQpcn3lzY70WI2RNfTjfkSdX99t+6CHeDpi9y2ojvdH5Z9Ew5MyqNy3SBQm1iQebzZwODoh0Jvbejpq5d0FAS//WZgXaz3Ov4K6IAn4nGkiD9LcB0H48DDDyTV1SWvIRuMr8Vn04MIM/isYIOazTDd7wsDYvUHSkzzaBCgl3mOltnBcV4a4OMdSML8p5cWFAoSpW5/ROpmbvAAe6CJQeNo9Ikn123wszRRkdKK8egTtXxYs1GpS3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBB+qAVf3XpJfENe2HzFYwXis4U3Nljh76OrmKsTuqw=;
 b=IPS4BMj+ri3gxFAgY8PvSH6aIR6u5mA61pO3Mq566dlaMQn3xgXdirGTbGjoy07JhIB1xqpKOmEPdH2Kv6IqpnnxkLMM4V/PhmCVrZZ77VCzN1VUjHfMBn8ygnhtWU72GFOhLhG5/fEYKuUXc5k+bsilvwyFibqpzPA6p2t9XqA=
Received: from AM6P193CA0105.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::46)
 by DB7PR06MB4828.eurprd06.prod.outlook.com (2603:10a6:10:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 09:05:34 +0000
Received: from VE1EUR02FT034.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::3) by AM6P193CA0105.outlook.office365.com
 (2603:10a6:209:88::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 09:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com;
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT034.mail.protection.outlook.com (10.152.12.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 09:05:34 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Mon, 7 Feb 2022 10:05:34 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        caihuoqing@baidu.com, aardelean@deviqon.com,
        andy.shevchenko@gmail.com, hdegoede@redhat.com,
        Qing-wu.Li@leica-geosystems.com.cn, stephan@gerhold.net,
        linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Subject: [PATCH 1/2] iio: st_sensors: add always_on flag
Date:   Mon,  7 Feb 2022 09:04:42 +0000
Message-Id: <20220207090443.3710425-2-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
 <20220207090443.3710425-1-massimo.toscanelli@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2022 09:05:34.0072 (UTC) FILETIME=[DD4BFF80:01D81C01]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08657150-49ba-4eeb-858e-08d9ea18fff2
X-MS-TrafficTypeDiagnostic: DB7PR06MB4828:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB482891B84C67305FE256B835A02C9@DB7PR06MB4828.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGAkh6zQWR4WYXeQZ/4EY59WzemDZM83KfWn6PzQOdV4W1WGL9moFUTS5E3L4dmzWf/4JhbLTqSkZjYFg9SQtWg67/EU9AG8gVUMSxQIYxltjWPutR5repx259H3Mfs6nVMXiCDVtDDieglnBe2QdJ4EA+CJbTCCV0yLHxo33Hrur/CIE2ZUGkZM6+14/5LCERC477vTvj2v8J1XOe1jvPADmI/RPfZ9PbsOA43Rdc9YyC7weE5PgEYGGCmDP5H3hxCAQxHhr+lgnX/+DvHaQctdlkRGYO4CjJrrg4MpSIxBfP2TTiSivsU3ltDfDSip/bKqFSy/7/OGf8/GIYHkAfIHXk4gFzYFuj8+liPTGz5W4o0QFdxvloI4WknDqcksbx9mjU238uvgVklMjZseEwGSwNjFa99hmdeAAtjGAuYs26EmlKPlTocPVaOXs97DTD7anhx0EBRJ70GsKpF+VvsIRqn/RCf1fgJBG9z9Q6TKjEBoTqM3aSry1kiX5zcWDurshdk29FLBSJMC7WD084EP5xJ9DEZiSVz5nvl/hk8qly4dQ9aDiNnSxfnEomTAr3wrnwCSf5BJKyWUISYM+vtBS5ZkTpsx448A6n+xm+Y89RX5yLBWNeOxK93VMiZZyvZPdmlZi3nEFqADeHoJaJ2hk/mrdmh/K9CgcyFg7fasYJo1Y2zG8VqV5kRNtbVEFMHlyB0SxaYvwwQvrczXWPCf2dczBBsXJ8d5d1E+lto=
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(356005)(5660300002)(36860700001)(44832011)(70206006)(86362001)(6666004)(82310400004)(6916009)(2906002)(316002)(186003)(336012)(70586007)(107886003)(450100002)(8936002)(4326008)(2616005)(34020700004)(40460700003)(26005)(1076003)(8676002)(83380400001)(47076005)(36756003)(508600001)(309714004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:05:34.3365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08657150-49ba-4eeb-858e-08d9ea18fff2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT034.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st_sensors_read_info_raw() implementation allows to get raw data
from st_sensors, enabling and disabling the device at every read.
This leads to delays in data access, caused by the msleep that waits
the hardware to be ready after every read.

Introduced always_on flag in st_sensor_data, to allow the user to
keep the device always enabled. In this way, every data access to the
device can be performed with no delays.

Add always_on sysfs attribute.

Signed-off-by: Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 85 +++++++++++++++++--
 include/linux/iio/common/st_sensors.h         | 14 +++
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index eb452d0c423c..5d16eab30853 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -378,6 +378,8 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	if (err < 0)
 		return err;
 
+	sdata->always_on = false;
+
 	/* Disable DRDY, this might be still be enabled after reboot. */
 	err = st_sensors_set_dataready_irq(indio_dev, false);
 	if (err < 0)
@@ -554,18 +556,21 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		err = -EBUSY;
 		goto out;
 	} else {
-		err = st_sensors_set_enable(indio_dev, true);
-		if (err < 0)
-			goto out;
+		if (!sdata->enabled) {
+			err = st_sensors_set_enable(indio_dev, true);
+			if (err < 0)
+				goto out;
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+			msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+		}
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto out;
 
 		*val = *val >> ch->scan_type.shift;
 
-		err = st_sensors_set_enable(indio_dev, false);
+		if (!sdata->always_on)
+			err = st_sensors_set_enable(indio_dev, false);
 	}
 out:
 	mutex_unlock(&indio_dev->mlock);
@@ -680,6 +685,76 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 }
 EXPORT_SYMBOL(st_sensors_sysfs_scale_avail);
 
+/*
+ * st_sensors_sysfs_show_always_on() - get the value of the always_on flag.
+ *
+ * @dev: device reference.
+ * @attr: device attribute.
+ * @buf: sysfs buffer.
+ *
+ * Return: Number of bytes printed into the buffer
+ */
+ssize_t st_sensors_sysfs_show_always_on(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", sdata->always_on);
+}
+EXPORT_SYMBOL(st_sensors_sysfs_show_always_on);
+
+/*
+ * st_sensors_sysfs_store_always_on() - set/unset always_on flag.
+ *				       Accepted values are:
+ *				       - 1: to set the flag and keep the
+ *					    device always enabled.
+ *				       - 0: to unset the flag and enable the
+ *					    device just during data access.
+ *
+ * @dev: device reference.
+ * @attr: device attribute.
+ * @buf: sysfs buffer.
+ * @count: number of bytes used from the buffer.
+ *
+ * Return: Either the number of bytes used from the buffer or an error code.
+ */
+ssize_t st_sensors_sysfs_store_always_on(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (!!val == sdata->always_on)
+		return count;
+
+	sdata->always_on = !!val;
+	if (sdata->always_on)
+		ret = st_sensors_set_enable(indio_dev, true);
+	else
+		ret = st_sensors_set_enable(indio_dev, false);
+
+	if (ret < 0)
+		return ret;
+
+	if (sdata->always_on)
+		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+
+	return count;
+}
+EXPORT_SYMBOL(st_sensors_sysfs_store_always_on);
+
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors core");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 22f67845cdd3..a4d4f374487d 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -82,6 +82,10 @@
 		IIO_DEVICE_ATTR(name, S_IRUGO, \
 			st_sensors_sysfs_scale_avail, NULL , 0);
 
+#define ST_SENSORS_DEV_ATTR_ALWAYS_ON() \
+		IIO_DEVICE_ATTR(always_on, 0644, st_sensors_sysfs_show_always_on, \
+				st_sensors_sysfs_store_always_on, 0)
+
 struct st_sensor_odr_avl {
 	unsigned int hz;
 	u8 value;
@@ -228,6 +232,7 @@ struct st_sensor_settings {
  * @vdd_io: Pointer to sensor's Vdd-IO power supply
  * @regmap: Pointer to specific sensor regmap configuration.
  * @enabled: Status of the sensor (false->off, true->on).
+ * @always_on: Flag to keep the sensor always enabled (false->off, true->on).
  * @odr: Output data rate of the sensor [Hz].
  * num_data_channels: Number of data channels used in buffer.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
@@ -248,6 +253,7 @@ struct st_sensor_data {
 	struct regmap *regmap;
 
 	bool enabled;
+	bool always_on;
 
 	unsigned int odr;
 	unsigned int num_data_channels;
@@ -318,6 +324,14 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 
 void st_sensors_dev_name_probe(struct device *dev, char *name, int len);
 
+ssize_t st_sensors_sysfs_show_always_on(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+
+ssize_t st_sensors_sysfs_store_always_on(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count);
+
 /* Accelerometer */
 const struct st_sensor_settings *st_accel_get_settings(const char *name);
 int st_accel_common_probe(struct iio_dev *indio_dev);
-- 
2.25.1

