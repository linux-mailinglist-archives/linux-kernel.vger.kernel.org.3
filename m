Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA004E21F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiCUIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiCUIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:17:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2135.outbound.protection.outlook.com [40.107.243.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1C2124C27;
        Mon, 21 Mar 2022 01:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3MhvcYlx0AjQR6XLY98dKrwtEessm/+AU2tt3DAIzo+kU0qTHuE4SOOIOJ7IB4Manw/aHHxslO1Q5uZxsENiNxAXrn9ZzY/SO13zjSIcMuUNAx+8zysqQ4vnsLmh3S0hsiAcY4Tsbv1yUugFBqmU2BU06Rl6etjvjE6I3IwDR3b6AzxXdx8eWHlFaUHRJQjPRJKDPJg5YykbUZgRUI1MW0yVlBHHen9xhRNxt4qKOSZ5fMnwVDPz2yrnf2dbGEmruhqCEFf89MovRlgPjL+g6OyNpXGRQj3AaeyHQkY4Qrqa7RvRM0Kjzkfl/gMsgBNGKHVMgxPgjIaitr8ODVvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OshPEopB8FSyJnfwFFbLIEYDXIs4H3Fqz+gFId+1zw0=;
 b=GydAOD30/DfPjuKkdPLSQya+c5DAAQSct9zPBQBfFHxZd6wBkuuwqd6XSjFlqIBP72VPiz72DVr0UDkxo7tQVkmawzo6jbJmThvgUy3TxYTawd2bKGUa2Ku8LzqAov6rYDG8gmx2aaz1sEcwyVyiNoMHe/rtCyM3MAij+vy12eFfBUvqyld1bOw+r9ZZfgE7a5pv/KG7TNyybtgb2lalFmLBQi64aUCnZoIdMU1jUCcNNUNmjs0i9pyFtEE2bVq2HZqeoqGJJjkwDWYpmmP1WDCswg149hBi4FYkUenIugJvJ3aoNCH69icaZVNNdix9z945emtLX4shLYXhJbP1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OshPEopB8FSyJnfwFFbLIEYDXIs4H3Fqz+gFId+1zw0=;
 b=Rx9oAP4ti/weys5q4JKvVM8yaHY4V46w1RbqFlFCCBzC4lnprOZNLOuAnJqyDOW36dBY/DcXc/BiTFg759H6QOxtZowxF7dRBcfMfySXaMxgL8hinWSimeOL5QvoemhyrLfIpDsfjF6TIWm6UKahUF1ycLBCH0DQQQt8swzd/vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 SN6PR01MB4112.prod.exchangelabs.com (2603:10b6:805:a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.21; Mon, 21 Mar 2022 08:15:16 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:15:16 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v7 8/9] mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD driver
Date:   Mon, 21 Mar 2022 15:13:54 +0700
Message-Id: <20220321081355.6802-9-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321081355.6802-1-quan@os.amperecomputing.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf88c586-c653-4bab-1733-08da0b12ee74
X-MS-TrafficTypeDiagnostic: SN6PR01MB4112:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB4112FA9FE212B32BDFD50E14F2169@SN6PR01MB4112.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gvV2GxYwoO/J1q+GjY4zd6hXZ/nQuNQsRpyfgXoqx3JoLYJ9LdO5T9XfvyvB47LmORfKVwCRkJzOm82G4NWfpwqV11YpbAzO+QJirFgTzhDzboa1P+1BqlNNQIiBCVCr6t0ozFjdV1cPzM7SyoSJe/TAWCxm9Qsqh9wAqAuKESr0v9cMRtXQG2Ak14IEFJfwGK3DoEadxe5RJ1zsdXqe5MNwotsnl+ZkfxOv6vJrHL709VqevXZpc0GuRvHF2OqXI2UV9U18KEJgaLQBAjOU8hNFfFC1w/6lOQVKXG73bmpSuW3AQNv5XhPBcc+ZyAKrjQ9VR+XXKrTXWJ/MscuCIL2/uCLUdtOuT++HL6amWB/p0nSVKgpf3qZotxKC/ZfEsTs8KATAJlv64nWhic7AsYTPjVx3kWNgJqdyxcvVJBXJ+9OerhVUSZjtIxcmuo7l8OBzC0gwOricRh75CfuCBEH5C2+cgKT/aNGl6cVtubEhDngy3zIDOrOO3MMZfwxYU02ZpcHhFvuLQyqyNFOWFWO7tMcSXgk94hikaUwn/Cv0yJgVeLGLUm/mIXskwO9h5t8xAgTACE9cZkE3Es46d//q1xCm9q+j8hdT+p8loHcFpaiAuR45cyGxOVRCljSU5xhTtsz1qtLxq/dtMwousjXWdL0b5930HFtPpVWg8tweXT5MzW5oIKCLrVhTvyVrgM8YQOwU9zXGoGubbzcKFDz5qoafrgFkbcyBqT0JMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(2616005)(26005)(107886003)(86362001)(8936002)(186003)(2906002)(1076003)(52116002)(7416002)(6666004)(6512007)(6506007)(921005)(38350700002)(38100700002)(110136005)(83380400001)(8676002)(66946007)(316002)(4326008)(66556008)(66476007)(6486002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAOmrhP++4vS3QITzXc3cKgQ0LTAnyPGepFY551JwP6G0mA+ryFME6w+1qal?=
 =?us-ascii?Q?vDkB5cuuCLgyPx8JfKgAP1csu3yjffEeXQSkKm/FzcgtP+fNONJHHG8j/EAZ?=
 =?us-ascii?Q?lA19Cwfg5BU8eV2VM2cWogiBy5je5hK/D33XA87b9T8p9x3ZXUpau282O5Tt?=
 =?us-ascii?Q?4bv0p2bz/6MmMoEbGraPW9kbOpf3hFEWUTEAqw4UsN91FI9VPX9ZUcFssCNB?=
 =?us-ascii?Q?ZhxrDsGYcVLMBFoIZT4d5ZortRGoYEgVz6QnKLTYlZll/wysrbH/BYmFzvpl?=
 =?us-ascii?Q?roGfkFe+yWL6wwR0xTwkkbwCvHx/SmW0MLhC3aNx4DqzY/MyOXZqVJerTJYB?=
 =?us-ascii?Q?3z3tOM8em0cFb/pz2VI5P7te1A+MgPsb4WnlqJH8PJwOxIuDDv7PT2GHcEG/?=
 =?us-ascii?Q?GgqUBhfFu7nlnFaXLjnozS56sq47nDIUmEcw7O1P9/5eA7ZwD7xgZCOUnVPa?=
 =?us-ascii?Q?Zs6hij0Wc3e/Js5d08NWCDtrR5wOllw5dgsVYC9GvABvpHyIAWAW0GpAPXLT?=
 =?us-ascii?Q?HzYF7skjJTg0Q1u2i3dJEDWukY8WlzsfRKULgkdxusjy0JjEJetZ/KgHibpa?=
 =?us-ascii?Q?qaOOlOedq7Hh9Vux2G7tNEFoadHQO4xFpPAYuH/zsBcjZl3f1rVRPQjS26uz?=
 =?us-ascii?Q?HT7yIMzsaNj2mutz2MTLUd0Z8RK2xHI3tw6epTC4j1CBXDayGKHPamZNJms2?=
 =?us-ascii?Q?mLy3xl+kIVeEtdP3U1p3deHLsBIXneDSsQ2XTBJ6+hkyKVpo1VnH0kNxQ1PU?=
 =?us-ascii?Q?1+AXQu8ls6vSpnPV2aDATHt3eRH29KtG8CNgojG/3VzPbyOzTuBtnmQG5wq6?=
 =?us-ascii?Q?FuTVUdrFRc+y9a9JkmyI+XB9UfiHmfm80HiokaFgMYTvtSWFwuLFQYQDYW5P?=
 =?us-ascii?Q?FqhOdljlZQEAaBqIltlwku7aNUFLTRd8KlpGD9RU8smqJaxVIsjYiaATpBVL?=
 =?us-ascii?Q?jOV5AfO20MWqMAmR+4PMGL3c3QGlS5VPhKlIuXMM+ffi2tcBv5dYewE4eJfv?=
 =?us-ascii?Q?egZiqtc1dNdSx3qxgZRPQsSWM7mKOu8CyXrdMyWlHOjtk0UNIEppTHnU/Dm8?=
 =?us-ascii?Q?8mm9ju1CGyJuh3KC6IMGqXbTcBuw/rPVxFS8rcASXC1VRlkcbOQqqVfhigiF?=
 =?us-ascii?Q?TzWo7p0GewmttdbiHLRZ7PCei/wYKT2xsBPVh8NHHpryiur7ZSbXMiAcqn+K?=
 =?us-ascii?Q?bWmD9ZhlOn47vv3d/b4CzTDmJqmWg5eH5EDvoeFKoz5YGIskD5PLvGcldSht?=
 =?us-ascii?Q?JgaGp9z0IrdAZ5L006bIQ9XVpYEEeAb5oFE+ne0PkqWr0+lt2NMW25mXc4fu?=
 =?us-ascii?Q?7jOxvD11mRAn0Pb03fDT1sIGSHxZR3NnM2J5RHwXxcgQ6fsvi7t1h7IUKc2i?=
 =?us-ascii?Q?hyctIvCGv0xrpTrkZbOI0GJ2eZLlq1XbWwsjJuEWeTw5T2o/RirnHJYhKbZ1?=
 =?us-ascii?Q?LqCdG7EE+kEfOk6T/Tx/NAHJSDKieH5ukUG3vNjUxyXakR7icmYOnzmLmj+O?=
 =?us-ascii?Q?MI/QaFjW2d3lHI8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf88c586-c653-4bab-1733-08da0b12ee74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:15:16.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1881ETrCbRz7KbyZY1X48FiuiL3l/DvmGptoYwo2ufPgF9oFpINlQysxnGJt4kMekJdVxxztvtCivBooSYchQG5IFA4gBTR7co6w+d6Mkzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Multi-function devices driver for SMpro co-processor found on the
Mt.Jade hardware reference platform with Ampere's Altra processor family.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
Changes in v7:
  + Smpro-mfd now significant changes in compare with simple-mfd-i2c
    driver, remove the copyright note about simple-mfd-i2c    [Quan]
  + Install bus->read/write()  to handle multiple types of bus
    access.                                                   [Quan]
  + Update license to MODULE_LICENSE("GPL")                   [Quan]
  + Add others minor refactor the code                        [Quan]

Changes in v6:
  + Update license part to reflect that this driver is clone from
  simple-mfd-i2c driver [Quan]

Changes in v5:
  + Dropped the use of simple-mfd-i2c driver [Quan]
  + Introduced drivers/mfd/smpro-mfd.c driver to instantiate
  sub-devices. This is to avoid DT nodes without resource issue [Quan]
  + Revised commit message [Quan]

Changes in v4:
  + Add "depends on I2C" to fix build issue found by kernel test
  robot [Guenter]

Changes in v3:
  + None

Changes in v2:
  + Used 'struct of_device_id's .data attribute [Lee Jones]

 drivers/mfd/Kconfig     |  12 ++++
 drivers/mfd/Makefile    |   1 +
 drivers/mfd/smpro-mfd.c | 134 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/mfd/smpro-mfd.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..383d0e6cfb91 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -77,6 +77,18 @@ config MFD_AS3711
 	help
 	  Support for the AS3711 PMIC from AMS
 
+config MFD_SMPRO
+	tristate "Ampere Computing MFD SMpro core driver"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Say yes here to enable SMpro driver support for Ampere's Altra
+	  processor family.
+
+	  Ampere's Altra SMpro exposes an I2C regmap interface that can
+	  be accessed by child devices.
+
 config MFD_AS3722
 	tristate "ams AS3722 Power Management IC"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..36f8981cc4fd 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
+obj-$(CONFIG_MFD_SMPRO)		+= smpro-mfd.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
new file mode 100644
index 000000000000..485c4f89ebd9
--- /dev/null
+++ b/drivers/mfd/smpro-mfd.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Ampere Altra Family SMPro MFD - I2C
+ *
+ * Copyright (c) 2022, Ampere Computing LLC
+ * Author: Quan Nguyen <quan@os.amperecomputing..com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/core.h>
+#include <linux/regmap.h>
+
+/* Identification Registers */
+#define MANUFACTURER_ID_REG     0x02
+#define AMPERE_MANUFACTURER_ID  0xCD3A
+
+static int smpro_mfd_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_master_send(i2c, data, count);
+	if (ret == count)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int smpro_mfd_read(void *context, const void *reg, size_t reg_size,
+			  void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg xfer[2];
+	unsigned char buf[2];
+	int ret;
+
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+
+	buf[0] = *(u8 *)reg;
+	buf[1] = val_size;
+	xfer[0].len = 2;
+	xfer[0].buf = buf;
+
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = val_size;
+	xfer[1].buf = val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (ret == 2)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static const struct regmap_bus smpro_regmap_bus = {
+	.read = smpro_mfd_read,
+	.write = smpro_mfd_write,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static bool smpro_mfd_readable_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return  (reg == 0x82 || reg == 0x85 || reg == 0x92 || reg == 0x95 ||
+		 reg == 0xC2 || reg == 0xC5 || reg == 0xD2 || reg == 0xDA);
+}
+
+static const struct regmap_config smpro_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.readable_noinc_reg = smpro_mfd_readable_noinc_reg,
+};
+
+static const struct mfd_cell smpro_devs[] = {
+	MFD_CELL_NAME("smpro-hwmon"),
+	MFD_CELL_NAME("smpro-errmon"),
+	MFD_CELL_NAME("smpro-misc"),
+};
+
+static int smpro_mfd_probe(struct i2c_client *i2c)
+{
+	const struct regmap_config *config;
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	config = device_get_match_data(&i2c->dev);
+	if (!config)
+		config = &smpro_regmap_config;
+
+	regmap = devm_regmap_init(&i2c->dev, &smpro_regmap_bus, &i2c->dev, config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* Check for valid ID */
+	ret = regmap_read(regmap, MANUFACTURER_ID_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val != AMPERE_MANUFACTURER_ID)
+		return -ENODEV;
+
+	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
+				    smpro_devs, ARRAY_SIZE(smpro_devs), NULL, 0, NULL);
+}
+
+static const struct of_device_id smpro_mfd_of_match[] = {
+	{ .compatible = "ampere,smpro", .data = &smpro_regmap_config },
+	{}
+};
+MODULE_DEVICE_TABLE(of, smpro_mfd_of_match);
+
+static struct i2c_driver smpro_mfd_driver = {
+	.probe_new = smpro_mfd_probe,
+	.driver = {
+		.name = "smpro-mfd-i2c",
+		.of_match_table = smpro_mfd_of_match,
+	},
+};
+module_i2c_driver(smpro_mfd_driver);
+
+MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
+MODULE_DESCRIPTION("SMPRO MFD - I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

