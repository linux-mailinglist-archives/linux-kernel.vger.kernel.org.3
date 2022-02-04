Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603124AA002
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiBDT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:26:17 -0500
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com ([40.107.21.136]:35169
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233348AbiBDT0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:26:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIeJGv3Kq2vcd/wSBTOIfzYylU/gzLCX4z8GWW73n4UdQ5PtbXaMxhqb+bqAVCp/shqKhoIlCPlfvST7MSpWNb+L7/NgYuG8XM+Zsu0GqT4xv6zGeaYDAN/O5VbfA8JuSspTXJd4XjBI/oAkTKEqOOkgaGzd1HPqXjDQnaY83AB8momq6t9mFXNKvwePn8n221f7z9ilj7BYxSq1p2i2mEzXO9RLcGTWqXLca5IpE/S6eQqfmzRLhV0vNwaXUhTNKqN5cLsrgBMVt15WQO/zwIC/6FvN8YQnVxRNQaSR8ZH7A0gIjyn1dNCZT9GLHGaHPRzb+SdNkJpuaPUHcaH9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBB+qAVf3XpJfENe2HzFYwXis4U3Nljh76OrmKsTuqw=;
 b=nhpbqSXW2C1yns4+Qs+QIrOAkcuEmGT0kxhd0GHeT2Jm75hSR2l8f/y+xcTFIg4KxFvvWiv+MKvrUWQxWJThKdK/GjXt7rIvWw+3WGl+bwbeJlk3y4HnFOzvezhbMfgf3uNADFPbKNkew5nw0BgUWRHpI04LtAZAJqK9OkclHMCRUJh1euKltso5IRue3f9vdl4vInJUAp6UQ65j88k7NY4UFd5OcID1xZ76E/WP+TKW+7JyuaY/ZCk0njoU1gJ+X6hAFNBu2EG+d0U6a9/2qsnsDhtcei9e4Q9RXug22qoodksSFyjPHl50h69kSXQICyFM5tmBHKwSbcy6LbVedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=temperror action=none
 header.from=leica-geosystems.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBB+qAVf3XpJfENe2HzFYwXis4U3Nljh76OrmKsTuqw=;
 b=fPzAtg/WgOYtzcvj9M1UwDhD/vAMjh8hU+t+HJ1nEC+slqXU2VutX0w0gHVyG59vVDyxIrnBxie9icQuqea+Ie+sDPClJLbC+ZN26+PUAPd9NhwPb/upIk3Zn3FlA4U2KZsYkXp7G+pU6dc2mV8+uhK8V+lF9MEdDwLhCJdbATM=
Received: from AS9PR04CA0051.eurprd04.prod.outlook.com (2603:10a6:20b:46a::25)
 by VI1PR06MB3024.eurprd06.prod.outlook.com (2603:10a6:802:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 19:26:08 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46a:cafe::bf) by AS9PR04CA0051.outlook.office365.com
 (2603:10a6:20b:46a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 4 Feb 2022 19:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=leica-geosystems.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of leica-geosystems.com: DNS Timeout)
Received: from hexagon.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:26:07 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.56]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Fri, 4 Feb 2022 20:26:06 +0100
From:   Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Massimo Toscanelli <massimo.toscanelli@leica-geosystems.com>
Subject: [PATCH 1/2] iio: st_sensors: add always_on flag
Date:   Fri,  4 Feb 2022 19:25:51 +0000
Message-Id: <20220204192552.428433-2-massimo.toscanelli@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
References: <20220204192552.428433-1-massimo.toscanelli@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Feb 2022 19:26:06.0798 (UTC) FILETIME=[0E7DDEE0:01D819FD]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 453211d7-bf4f-42d4-c5a6-08d9e814311d
X-MS-TrafficTypeDiagnostic: VI1PR06MB3024:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB30245D39609201A84B9DC22BA0299@VI1PR06MB3024.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAkUnBSsy+qndXX1S5V8NtgIpJCpaYMmwiwF5lAOLe/xxB3Yq2FH0CE1XOm9POW5PDFY+P2uhEC4GPVbU7PxYI2fjMD8hFkat4hEicPvsOuQCY86vTVbMlYMWEuhl1p1Tfay7l3MzDpBto+hLVYCp3h//xXCqPhDtcUqm8RynIGMmoRNROw+sHhHY8xOtVzYVw2+kw4ccP29cZz0eDKQVEmvx9bmMEiXd6s0huN/O3VlE4NfJ64/GWBRw3K3me8fL+7eZe4gHnytFqileABkMUZLDzEFRPRzxWWOXEIcOxATJlCynQlh2dMz+LJD9vfyCyYEAezvwHYa4K3pgsapJ+qog5dTDYDzctyLZ3IZvBj0amyWLiCfaVpSDYwU+fJn0WpTTV/d8buBJ8+I8TcLN6aUDaF4V/ErgrBFs8nCGcNK2+ABg+gWYwhq5dGSQA2E55j/ZBzX6ihzXxZE1UZqtUus+cdWs1Jp+iDVNeECnmHQ3CuIsPSZYXf5yaURnVWla3swM05mYuNgECXFTOXqrUVBpOg5CMKoeqdHd+bPKAeJ30gKkOrbKg3idoUKu7X0E9Y3Qdt3EhUuTusf3hGQyPiPYxssqIqttptT8FjcC8yMfacGThl4evyga/nvdqv+zsmvNsD1P8hb5RL6PvSgHKEvlc5SkgcE2lRHfPpRYEbXZ+B2cjqYmSDDGuy2iTdsTRdh/gyezlSax54x0mPqecPJpwoaV0FaEOM4YCYc4hwE1Gt3UmIWL6pIkTAaVGrMtrsiiNTTtI2vYHjM0PeI3w==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(63370400001)(508600001)(86362001)(63350400001)(40460700003)(356005)(81166007)(336012)(186003)(1076003)(34020700004)(107886003)(2616005)(2906002)(26005)(70206006)(6666004)(36860700001)(8936002)(8676002)(316002)(82310400004)(44832011)(6916009)(36756003)(5660300002)(47076005)(4326008)(70586007)(36900700001)(309714004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:26:07.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453211d7-bf4f-42d4-c5a6-08d9e814311d
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB3024
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

