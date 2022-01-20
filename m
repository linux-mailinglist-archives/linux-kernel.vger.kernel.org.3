Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D0494AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359349AbiATJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:37:05 -0500
Received: from mail-mw2nam10on2095.outbound.protection.outlook.com ([40.107.94.95]:64449
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241681AbiATJhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:37:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEPAJN0rrtCgXK57OlM40upq01wQlx4W3yUvdYIhUqnXfe/WkaYylqLwDkmaqheujriG32MeOYpLhe8iUnX0I43MFoV05krRwrKi79GGN7IGmujsvJ497N8CZ3KhSjinnQrzq+0y9YV5EbGAvj3nDhcEVZhnc0lb46yc1aIZq2WSETT4pQKEDQpjFbVLNjk0Ygo/veJEtlbgGiJEJygelGDLbXN/MdPidA5cy+jpy+WZBfQJ6jau7PdE27DhW4JeBAFXSWvBdg0WeCilMHqMSIujxOfsK2z5RxA43T8hYOlpEUFsOJttjnN/nLb/LQyBcpq015gQ0vz8FAi7bmE2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfyss5ifwipWgWfKORpYBhpxcjpis1AuNxQIg/iNg0Y=;
 b=DcJuuHLqJVpeVWD8Fpp/5toMalYKRwy4dsyFUIelmATLmLA5wAqJBypN875p6S4w6YR991mJpP72KwP9Gp0asBRhHX9dA8oLnkrjfkhuvnMXOqNKp3OI7QXSrQ+qJKVA2cl9lHqXfnPp1pgZslrbXe2NJKniK/+Q72YlonNn8aKqN7IHiUZqk26wIQpeFBUONIVGplNPL9RNugCeeyXj/mmwiacp/dsK1CVOkpxgj6VdnY2WhaVQuVJeSmO2h/e0CqHz/5KI4rj62wKidst3oA6RQd/UcNzOPQliTTWwjS91yckmbKkl84mYBPBRyDO+DiwWf1QxAFUrxuWBF5eyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfyss5ifwipWgWfKORpYBhpxcjpis1AuNxQIg/iNg0Y=;
 b=e0XUGxpBsprQvIgkHHPC4a6BiSwdwMayzpXjwcq6gsfAcPAA1M37jmmCXRxtw7PRT+Ttx4S/h95Ad0dR1Uf2lLZfGjYCILN+OijSlCoO+QPW9VroK6E3NAP8XblbFmobugkEDg1FdFmyQzyEf++hvLihtVYTI0o8SXFEza7ULjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by SN6PR04MB5374.namprd04.prod.outlook.com (2603:10b6:805:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 20 Jan
 2022 09:37:01 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::8c2c:1b0f:8516:a941%7]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 09:37:01 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] usb: typec: anx7411: Add Analogix PD ANX7411 support
Date:   Thu, 20 Jan 2022 17:36:15 +0800
Message-Id: <20220120093615.2026590-2-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120093615.2026590-1-xji@analogixsemi.com>
References: <20220120093615.2026590-1-xji@analogixsemi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a69ec9-d10f-4e27-8faa-08d9dbf868ff
X-MS-TrafficTypeDiagnostic: SN6PR04MB5374:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB53744774DDEA2CF222DB5C72C75A9@SN6PR04MB5374.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFYuceS80Ki20Nm6T4sUdJu3sdeSwA1wRoWgwP987ST+vGoDadoBwtq/KnYxtkSUzXY2BIzQkllAPgnp/6QYZP+mVS81ivrUNgbZfAztU/8+cVeAHEVChRq1n1hSzFRu9sywdKmoYqygpHG/fQqCPFTIQ1g0v+q274MCqrlyjt2klYT/iS30V2JDf8M8but/7I5Po0azGN1UCXfkh1S3ekfuhLG2KIqF3zmieMdgnO2KnwUZvk0wJROKoHhTjprRME+jjP35zAKyY4J/JM13ZVFz4ppKKE9WPhILYh5uhrVCnWSU60szXfDH00HMzvPgJozYXusdT9ja0sgtcHeKEZyQsOAAgMpQSja07TB1P6TdAHA6rv8ExP62QEP76Pnc2mplESch8H1vCPNzHxTgRaU/tRkTLyMp3199C+FCUt5AuH1O5uW0sU87Nibl2gAgT8cJ5yLKpTJZV8KA6vhQetj28ijPouEI5jv6zQQlOsouxsj2PsC2TZFTPXSmabrDdGI4xWuwQ+nJF9aLMskE8s9WBuVZOkP+I1lB45P16C8jc6ZcUI70FNAfmNIJzy841X4IV703tJeLEYlIejvWcsd48IIJfo6nj5ncwZe4PWxvCKoDEzCHsHw+Ua1//Rw5HAdFPXg5m86G4Xcpi+kntgG/9SyZJaAV1PhhxFhes4Dc7VFVSFZiDcj9ZhG8mLszifnT48nT2C0tSbqb7FIb8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(110136005)(2616005)(83380400001)(6506007)(66556008)(66476007)(66946007)(38350700002)(8676002)(55236004)(86362001)(508600001)(6486002)(54906003)(4326008)(36756003)(5660300002)(8936002)(186003)(6512007)(6666004)(2906002)(1076003)(30864003)(38100700002)(52116002)(26005)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BICC4pwcMHD1Fg68tnnNM7Zyuzu+iTob/RG6nPp0ZUUADwA9rHmM3vSYgsOF?=
 =?us-ascii?Q?4FdIWY/TbmaSr75bwlX8leYm/pS5rYsf5Tx2exCq4QDBTOjre0E/TxbW2lzb?=
 =?us-ascii?Q?wKzDHVN5JihMuXarEc0LVAOQSBcwJsuMKKEjpr8TNj8XVtE20oi3ORSGecQg?=
 =?us-ascii?Q?Lds8okbcNN76CEkJ4LxTACNhopmUi52kS/aC2I29jO4jP17wiihT8pK67jQ8?=
 =?us-ascii?Q?Tyvu9GQkYkyJfEiRtLNJsGcaKZzl/YHI1GLwFZwZUW+WdMnqg4IXbqtWP5Q+?=
 =?us-ascii?Q?+Z4FrVdfaMTWkxB4wUoE7oxWy0qtwgk04sga2InZycrDSbr3rS+RvtqJ9wck?=
 =?us-ascii?Q?LoO+gQr2i220lU14G+S4ESbC1jQqdcMgJ+Q5X2XyDMLVEyjr2eCDAj9DZSsY?=
 =?us-ascii?Q?ye5CBN3y+L2bRu0OUsK9UYC8IKSMN/ThywrMoa9gdUeKB3iaEVC2Z2Je4Bia?=
 =?us-ascii?Q?Eid+A9JWvq+d/5qwwjcR0fZ+v/avLqgzv3djRIlsVfbMLjWwO2190Wx9qlQ2?=
 =?us-ascii?Q?y/pckh0mrh2v8DHFmLjLeubNHZbXLLQES2iFVtP9bsgN1xtbyM+8qoVEhLyK?=
 =?us-ascii?Q?L+NiSPHHKBmLnxHyq3yLfgnto8xVTQtKq91zHtjynCd7ZKOG+FTTFJQm0xEs?=
 =?us-ascii?Q?+SzZJYPJEukgitN9zOJLl3hCq6gVuCDKLo77Fto+bGFNiwwvhjUJswUSsRjT?=
 =?us-ascii?Q?42UqwpZhJHypK8pU2jPfILFFqlwhnmYXRN5W4VcgmRJTXxZRXe54KTe4RsQF?=
 =?us-ascii?Q?ZjIoTIzaRREmNvyVnaTOSnqB8K+HRRkKS3N+2J6Xkn0gEqCjtyJYY12+MFDm?=
 =?us-ascii?Q?1/qtS/yqfqboWSpPl+Omd/m/HroG9+pHCPPK51M+sZT3kwlyYHzmsNlO8S9u?=
 =?us-ascii?Q?Yov+2lLtw0kT0P1y9S9MmFo9Ovvp7EQ+R7wYa9zjK9d312JQ2Th0ViHdLMcD?=
 =?us-ascii?Q?OsWSyURe/sxuAZ1aMtGVOX1Wv2CMOsN4rk2VAXtOzQHlWlzoJItlt6GXPQL0?=
 =?us-ascii?Q?SMKNyJVXRrccv8FxJz4JumUAgzKT2vjPWnwdrdhBeMnCIDq1UMNCVSEL807w?=
 =?us-ascii?Q?gjauspubjJb+HTlZ5zdybI7mtz8rAcefK3tFObHCxPnds82yvyIAw22W6r4C?=
 =?us-ascii?Q?2Tw0RckdvSjRBYOzOBhtT6l6qMs2kGNuxXtEzR4VkaN2yMhg/XZVVXu6Dt33?=
 =?us-ascii?Q?FvNqMr6kP8qVlNcvxsRUtE46n2PEaUBpsM77O80/USBEJQVjAlD62LQOcA/4?=
 =?us-ascii?Q?X+QzAjvdr51dF9n4zdLzaiwaDO4TS0Mcx7L4bhdOrNZue0Z8xk41axIW163V?=
 =?us-ascii?Q?MDhzaIEqjMJe9I4eykMuLBYNgCisBu3lhbepHAJVc5UQodLBHEJ3VUlgCLfm?=
 =?us-ascii?Q?IgSQ8IEFS2BjqnBXlHMI+p3zPDK2p0wAF/zMpdi87kN58oRrqHimHDwTLlGM?=
 =?us-ascii?Q?tOtzZWJZa8UpMdx5j6nQirCOUZ0gxbqrpWmmoQiNmXIhFmixkbE9t9aue12j?=
 =?us-ascii?Q?rhEEzbIJG8mZNV21wk8MH8ae8PGCnJyWhL9TnMsJkciZAfkYvtumiUOV0dg0?=
 =?us-ascii?Q?Dg9GhsIH3yMAu8cSD4usPbcwWhZQAHemHwaXxYIkYx7JeEqCZd2yM8SZaja/?=
 =?us-ascii?Q?GQByqYNA1hvy0O9g6hCwcC8=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a69ec9-d10f-4e27-8faa-08d9dbf868ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 09:37:01.3351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6SafYGFBF9A6lfP+yhVs5boJe7unsDjubLxMXgouLd9kgZUNP4Mgrc5DrcOIBFWYKXuzdz59CmFCoxi7jWvLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for analogix ANX7411 USB Type-C DRP port controller.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/usb/typec/Kconfig   |   11 +
 drivers/usb/typec/Makefile  |    1 +
 drivers/usb/typec/anx7411.c | 1473 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/anx7411.h |  271 +++++++
 4 files changed, 1756 insertions(+)
 create mode 100644 drivers/usb/typec/anx7411.c
 create mode 100644 drivers/usb/typec/anx7411.h

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index ab480f38523a..615183f46405 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -52,6 +52,17 @@ source "drivers/usb/typec/ucsi/Kconfig"
 
 source "drivers/usb/typec/tipd/Kconfig"
 
+config TYPEC_ANX7411
+	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
+	depends on I2C
+	depends on USB_ROLE_SWITCH
+	help
+	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
+	  controller driver.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called anx7411.ko.
+
 config TYPEC_HD3SS3220
 	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
 	depends on I2C
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index a0adb8947a30..f4e7188f174a 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
 obj-$(CONFIG_TYPEC_TPS6598X)	+= tipd/
+obj-$(CONFIG_TYPEC_ANX7411)	+= anx7411.o
 obj-$(CONFIG_TYPEC_HD3SS3220)	+= hd3ss3220.o
 obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
 obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
new file mode 100644
index 000000000000..e25417a89cdb
--- /dev/null
+++ b/drivers/usb/typec/anx7411.c
@@ -0,0 +1,1473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
+ *
+ */
+#include <linux/gcd.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_gpio.h>
+#include <linux/of_graph.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/usb/pd.h>
+#include <linux/usb/role.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+
+#include "anx7411.h"
+
+#define DEBUG
+
+static u8 snk_identity[] = {
+	VENDOR_ID & 0xFF, (VENDOR_ID >> 8) & 0xFF, 0x00, 0x82,  /* snk_id_hdr */
+	0x00, 0x00, 0x00, 0x00,                                 /* snk_cert */
+	0x00, 0x00, PRODUCT_ID & 0xFF, (PRODUCT_ID >> 8) & 0xFF,/* 5snk_ama */
+};
+
+static u8 dp_caps[4] = {0xC6, 0x00, 0x00, 0x00};
+
+static int anx7411_reg_read(struct i2c_client *client,
+			    u8 reg_addr)
+{
+	return i2c_smbus_read_byte_data(client, reg_addr);
+}
+
+static int anx7411_reg_block_read(struct i2c_client *client,
+				  u8 reg_addr, u8 len, u8 *buf)
+{
+	return i2c_smbus_read_i2c_block_data(client, reg_addr, len, buf);
+}
+
+static int anx7411_reg_write(struct i2c_client *client,
+			     u8 reg_addr, u8 reg_val)
+{
+	return i2c_smbus_write_byte_data(client, reg_addr, reg_val);
+}
+
+static int anx7411_reg_block_write(struct i2c_client *client,
+				   u8 reg_addr, u8 len, u8 *buf)
+{
+	return i2c_smbus_write_i2c_block_data(client, reg_addr, len, buf);
+}
+
+static struct anx7411_i2c_select anx7411_i2c_addr[] = {
+	{TCPC_ADDRESS1, SPI_ADDRESS1},
+	{TCPC_ADDRESS2, SPI_ADDRESS2},
+	{TCPC_ADDRESS3, SPI_ADDRESS3},
+	{TCPC_ADDRESS4, SPI_ADDRESS4},
+};
+
+static int anx7411_detect_power_mode(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	int ret;
+	int mode;
+
+	ret = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
+	if (ret < 0) {
+		dev_info(dev, "failed to read request current.\n");
+		return ret;
+	}
+	ctx->typec.request_current = ret * CURRENT_UNIT; /* 50ma per unit */
+
+	ret = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
+	if (ret < 0) {
+		dev_info(dev, "failed to read voltage.\n");
+		return ret;
+	}
+	ctx->typec.request_voltage = ret * VOLTAGE_UNIT; /* 100mv per unit */
+
+	if (ctx->psy_online == ANX7411_PSY_OFFLINE) {
+		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
+		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
+		power_supply_changed(ctx->psy);
+	}
+
+	if (!ctx->typec.cc_orientation_valid) {
+		dev_info(dev, "cc orientation is 0(debug cable plug in).\n");
+		return 0;
+	}
+
+	if (ctx->typec.cc_connect == CC1_CONNECTED)
+		mode = CC1_RP(ctx->typec.cc_status);
+	else
+		mode = CC2_RP(ctx->typec.cc_status);
+	if (mode) {
+		dev_info(dev, "set power opmode as %d.\n", mode - 1);
+		typec_set_pwr_opmode(ctx->typec.port, mode - 1);
+		return 0;
+	}
+
+	typec_set_pwr_opmode(ctx->typec.port, TYPEC_PWR_MODE_PD);
+
+	return 0;
+}
+
+static int anx7411_register_partner(struct anx7411_data *ctx,
+				    int pd, int accessory)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	struct typec_partner_desc desc;
+
+	if (ctx->typec.partner) {
+		dev_info(dev, "ignore register typec partner request.\n");
+		return 0;
+	}
+
+	dev_info(dev, "register typec partner port.\n");
+
+	desc.usb_pd = pd;
+	desc.accessory = accessory;
+	desc.identity = NULL;
+	ctx->typec.partner = typec_register_partner(ctx->typec.port, &desc);
+	if (IS_ERR(ctx->typec.partner)) {
+		dev_err(dev, "failed to register partner\n");
+		ctx->typec.partner = NULL;
+		return PTR_ERR(ctx->typec.partner);
+	}
+
+	return 0;
+}
+
+static int anx7411_detect_cc_orientation(struct anx7411_data *ctx)
+{
+	int ret;
+	int cc1_rd, cc2_rd;
+	int cc1_ra, cc2_ra;
+	int cc1_rp, cc2_rp;
+	struct device *dev = &ctx->spi_client->dev;
+
+	ret = anx7411_reg_read(ctx->spi_client, CC_STATUS);
+	if (ret < 0) {
+		dev_info(dev, "failed to read cc status.\n");
+		return ret;
+	}
+
+	dev_info(dev, "cc status %.02x\n", ret);
+
+	ctx->typec.cc_status = ret;
+
+	cc1_rd = ret & CC1_RD ? 1 : 0;
+	cc2_rd = ret & CC2_RD ? 1 : 0;
+	cc1_ra = ret & CC1_RA ? 1 : 0;
+	cc2_ra = ret & CC2_RA ? 1 : 0;
+	cc1_rp = CC1_RP(ret);
+	cc2_rp = CC2_RP(ret);
+
+	/* Debug cable, nothing to do */
+	if (cc1_rd && cc2_rd) {
+		ctx->typec.cc_orientation_valid = 0;
+		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_DEBUG);
+		return 0;
+	}
+
+	if (cc1_ra && cc2_ra) {
+		ctx->typec.cc_orientation_valid = 0;
+		anx7411_register_partner(ctx, 0, TYPEC_ACCESSORY_AUDIO);
+		return 0;
+	}
+
+	ctx->typec.cc_orientation_valid = 1;
+
+	anx7411_register_partner(ctx, 1, TYPEC_ACCESSORY_NONE);
+
+	if (cc1_rd || cc1_rp) {
+		dev_info(dev, "set orientation to normal\n");
+		typec_set_orientation(ctx->typec.port,
+				      TYPEC_ORIENTATION_NORMAL);
+		ctx->typec.cc_connect = CC1_CONNECTED;
+	}
+
+	if (cc2_rd || cc2_rp) {
+		dev_info(dev, "set orientation to reverse\n");
+		typec_set_orientation(ctx->typec.port,
+				      TYPEC_ORIENTATION_REVERSE);
+		ctx->typec.cc_connect = CC2_CONNECTED;
+	}
+
+	dev_info(dev, "cc1_rp(%d), cc2_rp(%d)", cc1_rp, cc2_rp);
+	dev_info(dev, "\tcc1_rd(%d), cc2_rd(%d), cc_connected(%d).\n",
+		 cc1_rd, cc2_rd, ctx->typec.cc_connect);
+
+	return 0;
+}
+
+static int anx7411_set_mux(struct anx7411_data *ctx, int pin_assignment)
+{
+	int mode = TYPEC_STATE_SAFE;
+	struct device *dev = &ctx->spi_client->dev;
+
+	switch (pin_assignment) {
+	case SELECT_PIN_ASSIGMENT_U:
+		/* default 4 line USB 3.1 */
+		mode = TYPEC_STATE_MODAL;
+		break;
+	case SELECT_PIN_ASSIGMENT_C:
+	case SELECT_PIN_ASSIGMENT_E:
+		/* 4 line DP */
+		mode = TYPEC_STATE_SAFE;
+		break;
+	case SELECT_PIN_ASSIGMENT_D:
+		/* 2 line DP, 2 line USB */
+		mode = TYPEC_MODE_USB3;
+		break;
+	default:
+		mode = TYPEC_STATE_SAFE;
+		break;
+	}
+
+	ctx->typec.pin_assignment = pin_assignment;
+
+	dev_info(dev, "pin assignment %d, mux mode %d.\n",
+		 pin_assignment, mode);
+
+	return typec_set_mode(ctx->typec.port, mode);
+}
+
+static void anx7411_set_usb_role(struct anx7411_data *ctx, enum usb_role role)
+{
+	struct device *dev = &ctx->spi_client->dev;
+
+	if (!ctx->typec.role_sw) {
+		dev_info(dev, "no usb role switch");
+		return;
+	}
+
+	usb_role_switch_set_role(ctx->typec.role_sw, role);
+}
+
+static int anx7411_data_role_detect(struct anx7411_data *ctx)
+{
+	int ret;
+	struct device *dev = &ctx->spi_client->dev;
+
+	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
+	if (ret < 0) {
+		dev_err(dev, "read system status failed: %d.\n", ret);
+		return ret;
+	}
+
+	ctx->typec.data_role = (ret & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
+	ctx->typec.vconn_role = (ret & VCONN_STATUS) ? TYPEC_SOURCE : TYPEC_SINK;
+
+	typec_set_data_role(ctx->typec.port, ctx->typec.data_role);
+	typec_set_vconn_role(ctx->typec.port, ctx->typec.vconn_role);
+
+	if (ctx->typec.data_role == TYPEC_HOST)
+		anx7411_set_usb_role(ctx, USB_ROLE_HOST);
+	else
+		anx7411_set_usb_role(ctx, USB_ROLE_DEVICE);
+
+	dev_info(dev, "data role change, status(0x%.02x), data role(%d)\n",
+		 ret, ctx->typec.data_role);
+
+	return 0;
+}
+
+static int anx7411_power_role_detect(struct anx7411_data *ctx)
+{
+	int ret;
+	struct device *dev = &ctx->spi_client->dev;
+
+	ret = anx7411_reg_read(ctx->spi_client, SYSTEM_STSTUS);
+	if (ret < 0) {
+		dev_err(dev, "read system status failed: %d.\n", ret);
+		return ret;
+	}
+
+	ctx->typec.power_role = (ret & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
+
+	if (ctx->typec.power_role == TYPEC_SOURCE) {
+		ctx->typec.request_current = DEF_1_5A;
+		ctx->typec.request_voltage = DEF_5V;
+	}
+
+	dev_info(dev, "power role change, status(0x%.02x), power role(%d).\n",
+		 ret, ctx->typec.power_role);
+	typec_set_pwr_role(ctx->typec.port, ctx->typec.power_role);
+
+	return 0;
+}
+
+static int anx7411_cc_status_detect(struct anx7411_data *ctx)
+{
+	anx7411_detect_cc_orientation(ctx);
+	anx7411_detect_power_mode(ctx);
+
+	return 0;
+}
+
+static int anx7411_partner_unregister_altmode(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	int i;
+
+	dev_info(dev, "unregister typec altmode.\n");
+
+	ctx->typec.dp_altmode_enter = 0;
+	ctx->typec.cust_altmode_enter = 0;
+
+	for (i = 0; i < MAX_ALTMODE; i++)
+		if (ctx->typec.amode[i]) {
+			typec_unregister_altmode(ctx->typec.amode[i]);
+			ctx->typec.amode[i] = NULL;
+		}
+
+	ctx->typec.pin_assignment = 0;
+	return 0;
+}
+
+static int anx7411_typec_register_altmode(struct anx7411_data *ctx,
+					  int svid, int vdo)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	struct typec_altmode_desc desc;
+	int i;
+
+	dev_info(dev, "register typec altmode -> vdo = 0x%x.\n", vdo);
+	desc.svid = svid;
+	desc.vdo = vdo;
+
+	for (i = 0; i < MAX_ALTMODE; i++)
+		if (!ctx->typec.amode[i])
+			break;
+
+	desc.mode = i + 1; /* start with 1 */
+
+	if (i >= MAX_ALTMODE) {
+		dev_info(dev, "no altmode space for registering\n");
+		return -ENOMEM;
+	}
+
+	ctx->typec.amode[i] = typec_partner_register_altmode(ctx->typec.partner,
+							     &desc);
+	if (IS_ERR(ctx->typec.amode[i])) {
+		dev_err(dev, "failed to register altmode\n");
+		ctx->typec.amode[i] = NULL;
+		return PTR_ERR(ctx->typec.amode);
+	}
+
+	return 0;
+}
+
+static int anx7411_unregister_partner(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+
+	dev_info(dev, "unregister typec partner port.\n");
+	if (ctx->typec.partner) {
+		typec_unregister_partner(ctx->typec.partner);
+		ctx->typec.partner = NULL;
+	}
+
+	return 0;
+}
+
+static int anx7411_update_altmode(struct anx7411_data *ctx, int svid)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	int i;
+
+	dev_info(dev, "update typec altmode to true.\n");
+
+	if (svid == DP_SVID)
+		ctx->typec.dp_altmode_enter = 1;
+	else
+		ctx->typec.cust_altmode_enter = 1;
+
+	for (i = 0; i < MAX_ALTMODE; i++) {
+		if (!ctx->typec.amode[i])
+			continue;
+
+		if (ctx->typec.amode[i]->svid == svid) {
+			typec_altmode_update_active(ctx->typec.amode[i], true);
+			typec_altmode_notify(ctx->typec.amode[i],
+					     ctx->typec.pin_assignment,
+					     &ctx->typec.data);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int anx7411_register_altmode(struct anx7411_data *ctx,
+				    bool dp_altmode, u8 *buf)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	int ret;
+	int svid;
+	int mid;
+
+	if (!ctx->typec.partner) {
+		dev_info(dev, "partner not register yet, ignore altmode(%d)\n",
+			 dp_altmode);
+		return 0;
+	}
+
+	svid = DP_SVID;
+	if (dp_altmode) {
+		dev_info(dev, "register DP altmode\n");
+		mid = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
+
+		return anx7411_typec_register_altmode(ctx, svid, mid);
+	}
+
+	svid = (buf[3] << 8) | buf[2];
+	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_ENTER_MODE)) {
+		dev_info(dev, "svid(0x%x) enter mode\n", svid);
+		return anx7411_update_altmode(ctx, svid);
+	}
+
+	if ((buf[0] & VDM_CMD_AND_ACK_MASK) != (VDM_ACK | VDM_CMD_DIS_MOD)) {
+		dev_info(dev, "ignore VDM message 0x%.02x%.02x\n",
+			 buf[0], buf[1]);
+		return 0;
+	}
+
+	mid = buf[4] | (buf[5] << 8) | (buf[6] << 16) | (buf[7] << 24);
+
+	ret = anx7411_typec_register_altmode(ctx, svid, mid);
+	if (ctx->typec.cust_altmode_enter)
+		ret |= anx7411_update_altmode(ctx, svid);
+
+	return ret;
+}
+
+static int anx7411_parse_cmd(struct anx7411_data *ctx, u8 type, u8 *buf, u8 len)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	u8 cur_50ma, vol_100mv;
+
+	dev_info(dev, "received message: type:0x%.02x, len:%d, buf[0]:%d\n",
+		 type, len, buf[0]);
+
+	switch (type) {
+	case TYPE_SRC_CAP:
+		cur_50ma = anx7411_reg_read(ctx->spi_client, REQUEST_CURRENT);
+		vol_100mv = anx7411_reg_read(ctx->spi_client, REQUEST_VOLTAGE);
+		dev_info(dev, "get current(%dma), voltage(%dmv), power(%dmw)\n",
+			 cur_50ma * CURRENT_UNIT, vol_100mv * VOLTAGE_UNIT,
+			 cur_50ma * vol_100mv * 5);
+
+		ctx->typec.request_voltage = vol_100mv * VOLTAGE_UNIT;
+		ctx->typec.request_current = cur_50ma * CURRENT_UNIT;
+
+#ifndef CUST_SINK_CTRL_EN
+		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
+		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
+		power_supply_changed(ctx->psy);
+#else
+		/* Enable OCM automatically control sink_ctrl pin*/
+		dev_info(dev, "Enable OCM auto control sink_ctrl pin\n");
+		anx7411_reg_write(ctx->tcpc_client, FW_CTRL_2,
+				  anx7411_reg_read(ctx->tcpc_client, FW_CTRL_2) &
+				  ~SINK_CTRL_DIS_FLAG);
+		if (vol_100mv != REQ_VOL_20V_IN_100MV)
+			break;
+
+		if (cur_50ma != REQ_CUR_2_25A_IN_50MA &&
+		    cur_50ma != REQ_CUR_3_25A_IN_50MA)
+			break;
+
+		/* Disable OCM automatically control sink_ctrl pin*/
+		dev_info(dev, "Disable OCM auto control sink_ctrl pin\n");
+		anx7411_reg_write(ctx->tcpc_client, FW_CTRL_2,
+				  anx7411_reg_read(ctx->tcpc_client, FW_CTRL_2) |
+				  SINK_CTRL_DIS_FLAG);
+
+		ctx->psy_online = ANX7411_PSY_FIXED_ONLINE;
+		ctx->usb_type = POWER_SUPPLY_USB_TYPE_PD;
+		power_supply_changed(ctx->psy);
+#endif
+		break;
+	case TYPE_SNK_CAP:
+		break;
+	case TYPE_SVID:
+		break;
+	case TYPE_SNK_IDENTITY:
+		break;
+	case TYPE_GET_DP_ALT_ENTER:
+		/* DP alt mode enter success */
+		if (buf[0])
+			anx7411_update_altmode(ctx, DP_SVID);
+		break;
+	case TYPE_DP_ALT_ENTER:
+		/* Update DP altmode */
+		anx7411_update_altmode(ctx, DP_SVID);
+		break;
+	case TYPE_OBJ_REQ:
+		anx7411_detect_power_mode(ctx);
+		break;
+	case TYPE_DP_CONFIGURE:
+		anx7411_set_mux(ctx, buf[1]);
+		break;
+	case TYPE_DP_DISCOVER_MODES_INFO:
+		/* Make sure discover modes valid */
+		if (buf[0] | buf[1])
+			/* Register DP Altmode */
+			anx7411_register_altmode(ctx, 1, buf);
+		break;
+	case TYPE_VDM:
+		/* Register other altmode */
+		anx7411_register_altmode(ctx, 0, buf);
+		break;
+	default:
+		dev_info(dev, "ignore message(0x%.02x).\n", type);
+		break;
+	}
+
+	return 0;
+}
+
+static u8 checksum(struct device *dev, u8 *buf, u8 len)
+{
+	u8 ret;
+	u8 i;
+
+	ret = 0;
+	for (i = 0; i < len; i++)
+		ret += buf[i];
+
+	return ret;
+}
+
+static int anx7411_read_msg_ctrl_status(struct i2c_client *client)
+{
+	return anx7411_reg_read(client, CMD_SEND_BUF);
+}
+
+static int anx7411_wait_msg_empty(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	int ret, val;
+
+	ret = readx_poll_timeout(anx7411_read_msg_ctrl_status,
+				 client, val, (val < 0) || (val == 0),
+				 2000, 2000 * 150);
+	if (ret)
+		dev_info(dev, "msg buffer busy\n");
+
+	return ret;
+}
+
+static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	u8 msg[MSG_LEN];
+	u8 crc;
+	int ret;
+
+	if (size)
+		memcpy(&msg[MSG_RAWDATA], buf, size);
+	msg[MSG_TYPE] = type;
+	msg[MSG_HEADER] = size + 1;
+
+	crc = checksum(dev, msg, size + HEADER_LEN);
+	msg[size + HEADER_LEN] = 0 - crc;
+
+	ret = anx7411_wait_msg_empty(ctx->spi_client);
+	if (ret) {
+		dev_info(dev, "firmware busy, ret(0x%.02x)\n", ret);
+		return ret;
+	}
+
+	anx7411_reg_block_write(ctx->spi_client,
+				CMD_SEND_BUF + 1, size + HEADER_LEN,
+				&msg[MSG_TYPE]);
+	return anx7411_reg_write(ctx->spi_client, CMD_SEND_BUF,
+				 msg[MSG_HEADER]);
+}
+
+static int anx7411_process_cmd(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	u8 msg[MSG_LEN];
+	u8 len;
+	u8 crc;
+
+	/* Read message from firmware */
+	anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF, MSG_LEN, msg);
+	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);
+
+	if (!msg[MSG_HEADER]) {
+		dev_info(dev, "message empty\n");
+		return 0;
+	}
+
+	len = msg[MSG_HEADER] & MSG_LEN_MASK;
+	crc = checksum(dev, msg, len + HEADER_LEN);
+	if (crc) {
+		dev_err(dev, "message error crc(0x%.02x)\n", crc);
+		return -1;
+	}
+
+	return anx7411_parse_cmd(ctx, msg[MSG_TYPE],
+				 &msg[MSG_RAWDATA], len - 1);
+}
+
+static void anx7411_translate_payload(struct device *dev, u32 *payload,
+				      u32 *pdo, int nr, const char *type)
+{
+	int i;
+
+	dev_info(dev, "convert %s pdos to little endian format\n", type);
+	if (nr > PDO_MAX_OBJECTS) {
+		dev_err(dev, "nr(%d) exceed PDO_MAX_OBJECTS(%d)\n",
+			nr, PDO_MAX_OBJECTS);
+
+		return;
+	}
+
+	for (i = 0; i < nr; i++)
+		payload[i] = cpu_to_le32(pdo[i]);
+}
+
+static void anx7411_config(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	struct typec_params *typecp = &ctx->typec;
+	u32 payload[PDO_MAX_OBJECTS];
+
+	dev_info(dev, "initial anx7411\n");
+	/* Config PD FW work under PD 2.0 */
+	anx7411_reg_write(ctx->spi_client, PD_REV_INIT, PD_REV20);
+	anx7411_reg_write(ctx->tcpc_client, FW_CTRL_0,
+			  UNSTRUCT_VDM_EN | DELAY_200MS |
+			  VSAFE1 | FRS_EN);
+	anx7411_reg_write(ctx->spi_client, FW_CTRL_1,
+			  AUTO_PD_EN | FORCE_SEND_RDO);
+
+	/* Set VBUS current threshold */
+	anx7411_reg_write(ctx->tcpc_client, VBUS_THRESHOLD_H, 0xff);
+	anx7411_reg_write(ctx->tcpc_client, VBUS_THRESHOLD_L, 0x03);
+
+	/* Fix dongle compatible issue */
+	anx7411_reg_write(ctx->tcpc_client, FW_PARAM,
+			  anx7411_reg_read(ctx->tcpc_client, FW_PARAM) |
+			  DONGLE_IOP);
+	anx7411_reg_write(ctx->spi_client, INT_MASK, 0);
+
+	anx7411_reg_write(ctx->spi_client, PD_EXT_MSG_CTRL, 0xFF);
+
+	if (typecp->caps_flags & HAS_SOURCE_CAP) {
+		anx7411_translate_payload(dev, payload, typecp->src_pdo,
+					  typecp->src_pdo_nr, "source");
+		anx7411_send_msg(ctx, TYPE_SRC_CAP, (u8 *)&payload,
+				 typecp->src_pdo_nr * 4);
+		anx7411_send_msg(ctx, TYPE_SNK_IDENTITY, snk_identity,
+				 sizeof(snk_identity));
+		anx7411_send_msg(ctx, TYPE_SET_SNK_DP_CAP, dp_caps,
+				 sizeof(dp_caps));
+	}
+
+	if (typecp->caps_flags & HAS_SINK_CAP) {
+		anx7411_translate_payload(dev, payload, typecp->sink_pdo,
+					  typecp->sink_pdo_nr, "sink");
+		anx7411_send_msg(ctx, TYPE_SNK_CAP, (u8 *)&payload,
+				 typecp->sink_pdo_nr * 4);
+	}
+
+	if (typecp->caps_flags & HAS_SINK_WATT) {
+		if (typecp->sink_watt) {
+			anx7411_reg_write(ctx->spi_client, MAX_POWER,
+					  typecp->sink_watt);
+			/* Set min power to 1W */
+			anx7411_reg_write(ctx->spi_client, MIN_POWER, 2);
+		}
+
+		if (typecp->sink_voltage)
+			anx7411_reg_write(ctx->spi_client, MAX_VOLTAGE,
+					  typecp->sink_voltage);
+	}
+
+	if (!typecp->caps_flags)
+		usleep_range(5000, 6000);
+
+	ctx->fw_version = anx7411_reg_read(ctx->spi_client, FW_VER);
+	ctx->fw_subversion = anx7411_reg_read(ctx->spi_client,
+					      FW_SUBVER);
+	dev_info(dev, "power on, ocm version %.02x%.02x\n",
+		 ctx->fw_version, ctx->fw_subversion);
+}
+
+static void anx7411_chip_standby(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->tcpc_client->dev;
+
+	dev_info(dev, "Anx7411 enter into standby mode.\n");
+
+	anx7411_reg_write(ctx->spi_client, OCM_CTRL_0,
+			  anx7411_reg_read(ctx->spi_client, OCM_CTRL_0) |
+			  OCM_RESET);
+	anx7411_reg_write(ctx->tcpc_client, ANALOG_CTRL_10, 0x80);
+	/* Set TCPC to RD and DRP enable */
+	anx7411_reg_write(ctx->tcpc_client, TCPC_ROLE_CONTROL, 0x4A);
+	/* Send DRP toggle command */
+	anx7411_reg_write(ctx->tcpc_client, TCPC_COMMAND, 0x99);
+
+	/* Send TCPC enter standby command */
+	anx7411_reg_write(ctx->tcpc_client, TCPC_COMMAND, 0xFF);
+}
+
+static void anx7411_work_func(struct work_struct *work)
+{
+	int ret;
+	u8 buf[STATUS_LEN];
+	u8 int_change, int_status, alert0, alert1;
+	struct anx7411_data *ctx = container_of(work,
+						struct anx7411_data, work);
+	struct device *dev = &ctx->spi_client->dev;
+
+	mutex_lock(&ctx->lock);
+
+	/* Read interrupt change status */
+	ret = anx7411_reg_block_read(ctx->spi_client, INT_STS,
+				     STATUS_LEN, buf);
+	if (ret < 0) {
+		/* Power standby mode, just return */
+		goto unlock;
+	}
+	int_change = buf[0];
+	int_status = buf[1];
+
+	/* Read alert register */
+	ret = anx7411_reg_block_read(ctx->tcpc_client, ALERT_0,
+				     STATUS_LEN, buf);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register(%d)\n", ALERT_0);
+		goto unlock;
+	}
+	alert0 = buf[0];
+	alert1 = buf[1];
+
+	/* Clear interrupt and alert status */
+	anx7411_reg_write(ctx->spi_client, INT_STS, 0);
+	anx7411_reg_write(ctx->tcpc_client, ALERT_0, alert0);
+	anx7411_reg_write(ctx->tcpc_client, ALERT_1, alert1);
+
+	dev_info(dev, "int_change(0x%.02x), int_status(0x%.02x).\n",
+		 int_change, int_status);
+	dev_info(dev, "alert0(0x%.02x), alert1(0x%.02x).\n", alert0, alert1);
+
+	if (alert1 & INTP_POW_OFF) {
+		anx7411_partner_unregister_altmode(ctx);
+		anx7411_set_usb_role(ctx, USB_ROLE_NONE);
+		anx7411_unregister_partner(ctx);
+		ctx->psy_online = ANX7411_PSY_OFFLINE;
+		ctx->usb_type = POWER_SUPPLY_USB_TYPE_C;
+		ctx->typec.request_voltage = 0;
+		ctx->typec.request_current = 0;
+		power_supply_changed(ctx->psy);
+		anx7411_chip_standby(ctx);
+		goto unlock;
+	}
+
+	if ((alert0 & SOFTWARE_INT) && (int_change & OCM_BOOT_UP)) {
+		anx7411_config(ctx);
+		anx7411_data_role_detect(ctx);
+		anx7411_power_role_detect(ctx);
+		anx7411_set_mux(ctx, SELECT_PIN_ASSIGMENT_C);
+	}
+
+	if (alert0 & RECEIVED_MSG)
+		anx7411_process_cmd(ctx);
+
+	ret = (int_status & DATA_ROLE) ? TYPEC_HOST : TYPEC_DEVICE;
+	if (ctx->typec.data_role != ret)
+		anx7411_data_role_detect(ctx);
+
+	ret = (int_status & SINK_STATUS) ? TYPEC_SINK : TYPEC_SOURCE;
+	if (ctx->typec.power_role != ret)
+		anx7411_power_role_detect(ctx);
+
+	if ((alert0 & SOFTWARE_INT) && (int_change & CC_STATUS_CHANGE))
+		anx7411_cc_status_detect(ctx);
+
+unlock:
+	mutex_unlock(&ctx->lock);
+}
+
+static irqreturn_t anx7411_intr_isr(int irq, void *data)
+{
+	struct anx7411_data *ctx = (struct anx7411_data *)data;
+
+	queue_work(ctx->workqueue, &ctx->work);
+
+	return IRQ_HANDLED;
+}
+
+static int anx7411_register_i2c_dummy_clients(struct anx7411_data *ctx,
+					      struct i2c_client *client)
+{
+	int i;
+	u8 spi_addr;
+
+	for (i = 0; i < sizeof(anx7411_i2c_addr); i++) {
+		if (client->addr == (anx7411_i2c_addr[i].tcpc_address >> 1)) {
+			spi_addr = anx7411_i2c_addr[i].spi_address >> 1;
+			ctx->spi_client = i2c_new_dummy_device(client->adapter,
+							       spi_addr);
+			if (ctx->spi_client) {
+				dev_info(&client->dev, "found spi slave\n");
+				return 0;
+			}
+		}
+	}
+
+	dev_err(&client->dev, "unable to get SPI slave\n");
+	return -ENOMEM;
+}
+
+static void anx7411_port_unregister_altmodes(struct typec_altmode **adev)
+{
+	int i;
+
+	for (i = 0; i < MAX_ALTMODE; i++)
+		if (adev[i]) {
+			typec_unregister_altmode(adev[i]);
+			adev[i] = NULL;
+		}
+}
+
+static int anx7411_usb_mux_set(struct typec_mux *mux,
+			       struct typec_mux_state *state)
+{
+	struct anx7411_data *ctx = typec_mux_get_drvdata(mux);
+	struct device *dev = &ctx->spi_client->dev;
+	int has_dp;
+
+	has_dp = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
+		  state->alt->mode == USB_TYPEC_DP_MODE);
+	dev_info(dev, "callback: mux set: %d", has_dp);
+	if (!has_dp) {
+		dev_info(dev, "dp altmode not register\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+static int anx7411_usb_set_orientation(struct typec_switch *sw,
+				       enum typec_orientation orientation)
+{
+	struct anx7411_data *ctx = typec_switch_get_drvdata(sw);
+	struct device *dev = &ctx->spi_client->dev;
+
+	dev_info(dev, "callback: orientation set %d\n", orientation);
+
+	return 0;
+}
+
+static int anx7411_register_switch(struct anx7411_data *ctx,
+				   struct device *dev,
+				   struct fwnode_handle *fwnode)
+{
+	struct typec_switch_desc sw_desc = { };
+
+	sw_desc.fwnode = fwnode;
+	sw_desc.drvdata = ctx;
+	sw_desc.name = fwnode_get_name(fwnode);
+	sw_desc.set = anx7411_usb_set_orientation;
+
+	ctx->typec.typec_switch = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(ctx->typec.typec_switch)) {
+		dev_err(dev, "switch register failed\n");
+		return PTR_ERR(ctx->typec.typec_switch);
+	}
+
+	return 0;
+}
+
+static int anx7411_register_mux(struct anx7411_data *ctx,
+				struct device *dev,
+				struct fwnode_handle *fwnode)
+{
+	struct typec_mux_desc mux_desc = { };
+
+	mux_desc.fwnode = fwnode;
+	mux_desc.drvdata = ctx;
+	mux_desc.name = fwnode_get_name(fwnode);
+	mux_desc.set = anx7411_usb_mux_set;
+
+	ctx->typec.typec_mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(ctx->typec.typec_mux)) {
+		dev_err(dev, "mux register failed\n");
+		return PTR_ERR(ctx->typec.typec_mux);
+	}
+
+	return 0;
+}
+
+static void anx7411_unregister_mux(struct anx7411_data *ctx)
+{
+	if (ctx->typec.typec_mux) {
+		typec_mux_unregister(ctx->typec.typec_mux);
+		ctx->typec.typec_mux = NULL;
+	}
+}
+
+static void anx7411_unregister_switch(struct anx7411_data *ctx)
+{
+	if (ctx->typec.typec_switch) {
+		typec_switch_unregister(ctx->typec.typec_switch);
+		ctx->typec.typec_switch = NULL;
+	}
+}
+
+static int anx7411_typec_switch_probe(struct anx7411_data *ctx,
+				      struct device *dev)
+{
+	int ret;
+	struct device_node *node;
+
+	node = of_find_node_by_name(dev->of_node, "orientation_switch");
+	if (!node) {
+		dev_info(dev, "no typec switch exist\n");
+		return 0;
+	}
+
+	dev_info(dev, "register switch\n");
+	ret = anx7411_register_switch(ctx, dev, &node->fwnode);
+	if (ret) {
+		dev_err(dev, "failed register switch");
+		return ret;
+	}
+
+	node = of_find_node_by_name(dev->of_node, "mode_switch");
+	if (!node) {
+		dev_err(dev, "no typec mux exist");
+		ret = -ENODEV;
+		goto unregister_switch;
+	}
+
+	dev_info(dev, "register mode switch\n");
+	ret = anx7411_register_mux(ctx, dev, &node->fwnode);
+	if (ret) {
+		dev_err(dev, "failed register mode switch");
+		ret = -ENODEV;
+		goto unregister_switch;
+	}
+
+	return 0;
+
+unregister_switch:
+	anx7411_unregister_switch(ctx);
+
+	return ret;
+}
+
+static int anx7411_typec_port_probe(struct anx7411_data *ctx,
+				    struct device *dev)
+{
+	struct typec_capability *cap = &ctx->typec.caps;
+	struct typec_params *typecp = &ctx->typec;
+	struct fwnode_handle *fwnode;
+	const char *buf;
+	int ret, i;
+
+	fwnode = device_get_named_child_node(dev, "connector");
+	if (!fwnode)
+		return -EINVAL;
+
+	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
+	if (ret) {
+		dev_err(dev, "power-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_power_role(buf);
+	if (ret < 0)
+		return ret;
+	cap->type = ret;
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
+	if (ret) {
+		dev_err(dev, "data-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_data_role(buf);
+	if (ret < 0)
+		return ret;
+	cap->data = ret;
+
+	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
+	if (ret) {
+		dev_err(dev, "try-power-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_power_role(buf);
+	if (ret < 0)
+		return ret;
+	cap->prefer_role = ret;
+
+	/* Get source pdos */
+	ret = fwnode_property_count_u32(fwnode, "source-pdos");
+	if (ret > 0) {
+		dev_info(dev, "%d source-pdos found\n", ret);
+		typecp->src_pdo_nr = min(ret, PDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
+						     typecp->src_pdo,
+						     typecp->src_pdo_nr);
+		if (ret < 0) {
+			dev_err(dev, "source cap validate failed: %d\n", ret);
+			return -EINVAL;
+		}
+
+		typecp->caps_flags |= HAS_SOURCE_CAP;
+	}
+
+	ret = fwnode_property_count_u32(fwnode, "sink-pdos");
+	if (ret > 0) {
+		dev_info(dev, "%d sink-pdos found\n", ret);
+		typecp->sink_pdo_nr = min(ret, PDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
+						     typecp->sink_pdo,
+						     typecp->sink_pdo_nr);
+		if (ret < 0) {
+			dev_err(dev, "sink cap validate failed: %d\n", ret);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < typecp->sink_pdo_nr; i++) {
+			ret = 0;
+			switch (pdo_type(typecp->sink_pdo[i])) {
+			case PDO_TYPE_FIXED:
+				ret = pdo_fixed_voltage(typecp->sink_pdo[i]);
+				break;
+			case PDO_TYPE_BATT:
+			case PDO_TYPE_VAR:
+				ret = pdo_max_voltage(typecp->sink_pdo[i]);
+				break;
+			case PDO_TYPE_APDO:
+			default:
+				ret = 0;
+				break;
+			}
+
+			/* 100mv per unit */
+			typecp->sink_voltage = max(5000, ret) / 100;
+		}
+
+		typecp->caps_flags |= HAS_SINK_CAP;
+	}
+
+	if (!fwnode_property_read_u32(fwnode, "op-sink-microwatt", &ret)) {
+		dev_info(dev, "%d sink-microwat found\n", ret);
+		typecp->sink_watt = ret / 500000; /* 500mw per unit */
+		typecp->caps_flags |= HAS_SINK_WATT;
+	}
+
+	cap->fwnode = fwnode;
+
+	ctx->typec.role_sw = usb_role_switch_get(dev);
+	if (IS_ERR(ctx->typec.role_sw)) {
+		dev_err(dev, "USB role switch not found.\n");
+		ctx->typec.role_sw = NULL;
+	}
+
+	ctx->typec.port = typec_register_port(dev, cap);
+	if (IS_ERR(ctx->typec.port)) {
+		ret = PTR_ERR(ctx->typec.port);
+		ctx->typec.port = NULL;
+		dev_err(dev, "Failed to register type c port %d\n", ret);
+		return ret;
+	}
+
+	typec_port_register_altmodes(ctx->typec.port, NULL, ctx,
+				     ctx->typec.port_amode,
+				     MAX_ALTMODE);
+
+	return 0;
+}
+
+static int anx7411_typec_check_connection(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->spi_client->dev;
+	int ret;
+
+	ret = anx7411_reg_read(ctx->spi_client, FW_VER);
+	if (ret < 0) {
+		/* No device attached in typec port */
+		dev_info(dev, "no connection detect.\n");
+		return 0;
+	}
+
+	dev_info(dev, "detected typec connected, ocm ver:0x%.02x.\n", ret);
+	dev_info(dev, "force clear interrupt and alert.\n");
+	/* Clear interrupt and alert status */
+	anx7411_reg_write(ctx->spi_client, INT_STS, 0);
+	anx7411_reg_write(ctx->tcpc_client, ALERT_0, 0xFF);
+	anx7411_reg_write(ctx->tcpc_client, ALERT_1, 0xFF);
+
+	anx7411_cc_status_detect(ctx);
+
+	anx7411_power_role_detect(ctx);
+
+	dev_info(dev, "PD %s voltage(%d), current(%d).\n",
+		 ctx->typec.power_role == TYPEC_SOURCE ? "supply" : "request",
+		 ctx->typec.request_voltage, ctx->typec.request_current);
+
+	anx7411_data_role_detect(ctx);
+
+	anx7411_set_mux(ctx, SELECT_PIN_ASSIGMENT_C);
+
+	anx7411_send_msg(ctx, TYPE_GET_DP_ALT_ENTER, NULL, 0);
+
+	anx7411_send_msg(ctx, TYPE_GET_DP_DISCOVER_MODES_INFO, NULL, 0);
+
+	return 0;
+}
+
+static int __maybe_unused anx7411_runtime_pm_suspend(struct device *dev)
+{
+	struct anx7411_data *ctx = dev_get_drvdata(dev);
+
+	mutex_lock(&ctx->lock);
+
+	anx7411_partner_unregister_altmode(ctx);
+
+	if (ctx->typec.partner)
+		anx7411_unregister_partner(ctx);
+
+	mutex_unlock(&ctx->lock);
+
+	return 0;
+}
+
+static int __maybe_unused anx7411_runtime_pm_resume(struct device *dev)
+{
+	struct anx7411_data *ctx = dev_get_drvdata(dev);
+
+	mutex_lock(&ctx->lock);
+	/* Detect PD connection */
+	anx7411_typec_check_connection(ctx);
+
+	mutex_unlock(&ctx->lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops anx7411_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(anx7411_runtime_pm_suspend,
+			   anx7411_runtime_pm_resume, NULL)
+};
+
+static void anx7411_get_gpio_irq(struct anx7411_data *ctx)
+{
+	struct device *dev = &ctx->tcpc_client->dev;
+
+	ctx->intp_gpiod = devm_gpiod_get_optional(dev, "interrupt", GPIOD_IN);
+	if (!ctx->intp_gpiod) {
+		dev_info(dev, "no interrupt gpio property\n");
+		return;
+	}
+
+	ctx->intp_irq = gpiod_to_irq(ctx->intp_gpiod);
+	dev_info(dev, "request gpio(%d) irq(%d)\n",
+		 desc_to_gpio(ctx->intp_gpiod), ctx->intp_irq);
+
+	if (!ctx->intp_irq)
+		dev_err(dev, "failed to get GPIO IRQ\n");
+}
+
+static const char *anx7411_psy_name_prefix = "anx7411-source-psy-";
+
+static enum power_supply_usb_type anx7411_psy_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_C,
+	POWER_SUPPLY_USB_TYPE_PD,
+	POWER_SUPPLY_USB_TYPE_PD_PPS,
+};
+
+static enum power_supply_property anx7411_psy_props[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int anx7411_psy_set_prop(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct anx7411_data *ctx = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	if (psp == POWER_SUPPLY_PROP_ONLINE) {
+		pr_info("[DEBUG] set prop -> %d\n", val->intval);
+		ctx->psy_online = val->intval;
+#ifdef CUST_SINK_CTRL_EN
+		if (ctx->psy_online == ANX7411_PSY_HANG)
+			anx7411_reg_write(ctx->tcpc_client,
+					  TCPC_COMMAND,
+					  SINK_CTRL_DIS);
+		else if (ctx->psy_online)
+			anx7411_reg_write(ctx->tcpc_client,
+					  TCPC_COMMAND,
+					  SINK_CTRL_EN);
+#endif
+	} else {
+		ret = -EINVAL;
+	}
+
+	power_supply_changed(ctx->psy);
+	return ret;
+}
+
+static int anx7411_psy_prop_writeable(struct power_supply *psy,
+				      enum power_supply_property psp)
+{
+	return (psp == POWER_SUPPLY_PROP_ONLINE) ? 1 : 0;
+}
+
+static int anx7411_psy_get_prop(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct anx7411_data *ctx = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = ctx->usb_type;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ctx->psy_online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = (ctx->psy_online) ?
+			ctx->typec.request_voltage * 1000 : 0;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = (ctx->psy_online) ?
+			ctx->typec.request_current * 1000 : 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int anx7411_psy_register(struct anx7411_data *ctx)
+{
+	struct power_supply_config psy_cfg = {};
+	const char *port_dev_name = dev_name(ctx->dev);
+	size_t psy_name_len = strlen(anx7411_psy_name_prefix) +
+				     strlen(port_dev_name) + 1;
+	char *psy_name;
+	struct power_supply_desc *psy_desc = &ctx->psy_desc;
+
+	psy_cfg.drv_data = ctx;
+	psy_cfg.fwnode = dev_fwnode(ctx->dev);
+	psy_name = devm_kzalloc(ctx->dev, psy_name_len, GFP_KERNEL);
+	if (!psy_name) {
+		dev_warn(ctx->dev, "unable to alloc psy memory\n");
+		return -ENOMEM;
+	}
+
+	snprintf(psy_name, psy_name_len, "%s%s", anx7411_psy_name_prefix,
+		 port_dev_name);
+
+	psy_desc->name = psy_name;
+	psy_desc->type = POWER_SUPPLY_TYPE_USB;
+	psy_desc->usb_types = anx7411_psy_usb_types;
+	psy_desc->num_usb_types = ARRAY_SIZE(anx7411_psy_usb_types);
+	psy_desc->properties = anx7411_psy_props,
+	psy_desc->num_properties = ARRAY_SIZE(anx7411_psy_props),
+
+	psy_desc->get_property = anx7411_psy_get_prop,
+	psy_desc->set_property = anx7411_psy_set_prop,
+	psy_desc->property_is_writeable = anx7411_psy_prop_writeable,
+
+	ctx->usb_type = POWER_SUPPLY_USB_TYPE_C;
+	ctx->psy = devm_power_supply_register(ctx->dev, psy_desc, &psy_cfg);
+
+	if (IS_ERR(ctx->psy))
+		dev_warn(ctx->dev, "unable to register psy\n");
+
+	return PTR_ERR_OR_ZERO(ctx->psy);
+}
+
+static int anx7411_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct anx7411_data *plat;
+	struct device *dev = &client->dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENODEV;
+
+	plat = kzalloc(sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->tcpc_client = client;
+	i2c_set_clientdata(client, plat);
+
+	mutex_init(&plat->lock);
+
+	ret = anx7411_register_i2c_dummy_clients(plat, client);
+	if (ret) {
+		dev_err(dev, "fail to reserve I2C bus\n");
+		return ret;
+	}
+
+	ret = anx7411_typec_switch_probe(plat, dev);
+	if (ret) {
+		dev_err(dev, "fail to probe typec switch\n");
+		goto free_i2c_dummy;
+	}
+
+	ret = anx7411_typec_port_probe(plat, dev);
+	if (ret) {
+		dev_err(dev, "fail to probe typec property.\n");
+		ret = -ENODEV;
+		goto free_typec_switch;
+	}
+
+	plat->intp_irq = client->irq;
+	if (!client->irq) {
+		dev_info(dev, "no default interrupt IRQ, probe GPIO interrupt");
+		anx7411_get_gpio_irq(plat);
+	}
+
+	if (!plat->intp_irq) {
+		dev_err(dev, "fail to get interrupt IRQ\n");
+		goto free_typec_port;
+	}
+
+	plat->dev = dev;
+	plat->psy_online = ANX7411_PSY_OFFLINE;
+	anx7411_psy_register(plat);
+
+	if (plat->intp_irq) {
+		INIT_WORK(&plat->work, anx7411_work_func);
+		plat->workqueue = alloc_workqueue("anx7411_work",
+						  WQ_FREEZABLE |
+						  WQ_MEM_RECLAIM,
+						  1);
+		if (!plat->workqueue) {
+			dev_err(dev, "fail to create work queue\n");
+			ret = -ENOMEM;
+			goto free_typec_port;
+		}
+
+		ret = devm_request_threaded_irq(dev, plat->intp_irq,
+						NULL, anx7411_intr_isr,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"anx7411-intp", plat);
+		if (ret) {
+			dev_err(dev, "fail to request irq\n");
+			goto free_wq;
+		}
+
+		dev_info(dev, "registered irq %d handler\n", plat->intp_irq);
+	}
+
+	anx7411_typec_check_connection(plat);
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+free_wq:
+	destroy_workqueue(plat->workqueue);
+
+free_typec_port:
+	typec_unregister_port(plat->typec.port);
+	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+
+free_typec_switch:
+	anx7411_unregister_switch(plat);
+	anx7411_unregister_mux(plat);
+
+free_i2c_dummy:
+	i2c_unregister_device(plat->spi_client);
+
+	return ret;
+}
+
+static int anx7411_i2c_remove(struct i2c_client *client)
+{
+	struct anx7411_data *plat = i2c_get_clientdata(client);
+
+	anx7411_partner_unregister_altmode(plat);
+	anx7411_unregister_partner(plat);
+
+	if (plat->workqueue)
+		destroy_workqueue(plat->workqueue);
+
+	if (plat->spi_client)
+		i2c_unregister_device(plat->spi_client);
+
+	if (plat->typec.role_sw)
+		usb_role_switch_put(plat->typec.role_sw);
+
+	anx7411_unregister_mux(plat);
+
+	anx7411_unregister_switch(plat);
+
+	if (plat->typec.port)
+		typec_unregister_port(plat->typec.port);
+
+	anx7411_port_unregister_altmodes(plat->typec.port_amode);
+
+	return 0;
+}
+
+static const struct i2c_device_id anx7411_id[] = {
+	{"anx7411", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, anx7411_id);
+
+static const struct of_device_id anx_match_table[] = {
+	{.compatible = "analogix,anx7411",},
+	{},
+};
+
+static struct i2c_driver anx7411_driver = {
+	.driver = {
+		.name = "anx7411",
+		.of_match_table = anx_match_table,
+		.pm = &anx7411_pm_ops,
+	},
+	.probe = anx7411_i2c_probe,
+	.remove = anx7411_i2c_remove,
+
+	.id_table = anx7411_id,
+};
+
+module_i2c_driver(anx7411_driver);
+
+MODULE_DESCRIPTION("Anx7411 USB Type-C PD driver");
+MODULE_AUTHOR("Xin Ji <xji@analogixsemi.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1.4");
diff --git a/drivers/usb/typec/anx7411.h b/drivers/usb/typec/anx7411.h
new file mode 100644
index 000000000000..97bd670a4d0c
--- /dev/null
+++ b/drivers/usb/typec/anx7411.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
+ *
+ */
+
+#ifndef __ANX7411_H__
+#define __ANX7411_H__
+
+#define TCPC_ADDRESS1		0x58
+#define TCPC_ADDRESS2		0x56
+#define TCPC_ADDRESS3		0x54
+#define TCPC_ADDRESS4		0x52
+#define SPI_ADDRESS1		0x7e
+#define SPI_ADDRESS2		0x6e
+#define SPI_ADDRESS3		0x64
+#define SPI_ADDRESS4		0x62
+
+struct anx7411_i2c_select {
+	u8 tcpc_address;
+	u8 spi_address;
+};
+
+#define VENDOR_ID		0x1F29
+#define PRODUCT_ID		0x7411
+
+/* TCPC register define */
+
+#define TCPC_ROLE_CONTROL	0x1A
+
+#define TCPC_COMMAND		0x23
+#define SINK_CTRL_EN		0x55
+#define SINK_CTRL_DIS		0x44
+
+#define ANALOG_CTRL_10		0xAA
+
+#define STATUS_LEN		2
+#define ALERT_0			0xCB
+#define RECEIVED_MSG		BIT(7)
+#define SOFTWARE_INT		BIT(6)
+#define MSG_LEN			32
+#define HEADER_LEN		2
+#define MSG_HEADER		0x00
+#define MSG_TYPE		0x01
+#define MSG_RAWDATA		0x02
+#define MSG_LEN_MASK		0x1F
+
+#define ALERT_1			0xCC
+#define INTP_POW_ON		BIT(7)
+#define INTP_POW_OFF		BIT(6)
+
+#define VBUS_THRESHOLD_H	0xDD
+#define VBUS_THRESHOLD_L	0xDE
+
+#define FW_CTRL_0		0xF0
+#define UNSTRUCT_VDM_EN		BIT(0)
+#define DELAY_200MS		BIT(1)
+#define VSAFE0			0
+#define VSAFE1			BIT(2)
+#define VSAFE2			BIT(3)
+#define VSAFE3			(BIT(2) | BIT(3))
+#define FRS_EN			BIT(7)
+
+#define FW_PARAM		0xF1
+#define DONGLE_IOP		BIT(0)
+
+#define FW_CTRL_2		0xF7
+#define SINK_CTRL_DIS_FLAG	BIT(5)
+
+/* SPI register define */
+#define OCM_CTRL_0		0x6E
+#define OCM_RESET		BIT(6)
+
+#define MAX_VOLTAGE		0xAC
+#define MAX_POWER		0xAD
+#define MIN_POWER		0xAE
+
+#define REQUEST_VOLTAGE		0xAF
+#define VOLTAGE_UNIT		100 /* mV per unit */
+
+#define REQUEST_CURRENT		0xB1
+#define CURRENT_UNIT		50 /* mA per unit */
+
+#define CMD_SEND_BUF		0xC0
+#define CMD_RECV_BUF		0xE0
+
+#define REQ_VOL_20V_IN_100MV	0xC8
+#define REQ_CUR_2_25A_IN_50MA	0x2D
+#define REQ_CUR_3_25A_IN_50MA	0x41
+
+#define DEF_5V			5000
+#define DEF_1_5A		1500
+
+enum anx7411_typec_message_type {
+	TYPE_SRC_CAP = 0x00,
+	TYPE_SNK_CAP = 0x01,
+	TYPE_SNK_IDENTITY = 0x02,
+	TYPE_SVID = 0x03,
+	TYPE_SET_SNK_DP_CAP = 0x08,
+	TYPE_PSWAP_REQ = 0x10,
+	TYPE_DSWAP_REQ = 0x11,
+	TYPE_VDM = 0x14,
+	TYPE_OBJ_REQ = 0x16,
+	TYPE_DP_ALT_ENTER = 0x19,
+	TYPE_DP_DISCOVER_MODES_INFO = 0x27,
+	TYPE_GET_DP_CONFIG = 0x29,
+	TYPE_DP_CONFIGURE = 0x2A,
+	TYPE_GET_DP_DISCOVER_MODES_INFO = 0x2E,
+	TYPE_GET_DP_ALT_ENTER = 0x2F,
+};
+
+#define REQUEST_CURRENT		0xB1
+#define REQUEST_VOLTAGE		0xAF
+
+#define FW_CTRL_1		0xB2
+#define AUTO_PD_EN		BIT(1)
+#define TRYSRC_EN		BIT(2)
+#define TRYSNK_EN		BIT(3)
+#define FORCE_SEND_RDO		BIT(6)
+
+#define FW_VER			0xB4
+#define FW_SUBVER		0xB5
+
+#define INT_MASK		0xB6
+#define INT_STS			0xB7
+#define OCM_BOOT_UP		BIT(0)
+#define OC_OV_EVENT		BIT(1)
+#define VCONN_CHANGE		BIT(2)
+#define VBUS_CHANGE		BIT(3)
+#define CC_STATUS_CHANGE	BIT(4)
+#define DATA_ROLE_CHANGE	BIT(5)
+#define PR_CONSUMER_GOT_POWER	BIT(6)
+#define HPD_STATUS_CHANGE	BIT(7)
+
+#define SYSTEM_STSTUS		0xB8
+/* 0: SINK off; 1: SINK on */
+#define SINK_STATUS		BIT(1)
+/* 0: VCONN off; 1: VCONN on*/
+#define VCONN_STATUS		BIT(2)
+/* 0: vbus off; 1: vbus on*/
+#define VBUS_STATUS		BIT(3)
+/* 1: host; 0:device*/
+#define DATA_ROLE		BIT(5)
+/* 0: Chunking; 1: Unchunked*/
+#define SUPPORT_UNCHUNKING	BIT(6)
+/* 0: HPD low; 1: HPD high*/
+#define HPD_STATUS		BIT(7)
+
+#define DATA_DFP		1
+#define DATA_UFP		2
+#define POWER_SOURCE		1
+#define POWER_SINK		2
+
+#define CC_STATUS		0xB9
+#define CC1_RD			BIT(0)
+#define CC2_RD			BIT(4)
+#define CC1_RA			BIT(1)
+#define CC2_RA			BIT(5)
+#define CC1_RD			BIT(0)
+#define CC1_RP(cc)		(((cc) >> 2) & 0x03)
+#define CC2_RP(cc)		(((cc) >> 6) & 0x03)
+
+#define PD_REV_INIT		0xBA
+
+#define PD_EXT_MSG_CTRL		0xBB
+#define SRC_CAP_EXT_REPLY	BIT(0)
+#define MANUFACTURER_INFO_REPLY	BIT(1)
+#define BATTERY_STS_REPLY	BIT(2)
+#define BATTERY_CAP_REPLY	BIT(3)
+#define ALERT_REPLY		BIT(4)
+#define STATUS_REPLY		BIT(5)
+#define PPS_STATUS_REPLY	BIT(6)
+#define SNK_CAP_EXT_REPLY	BIT(7)
+
+#define NO_CONNECT		0x00
+#define USB3_1_CONNECTED	0x01
+#define DP_ALT_4LANES		0x02
+#define USB3_1_DP_2LANES	0x03
+#define CC1_CONNECTED		0x01
+#define CC2_CONNECTED		0x02
+#define SELECT_PIN_ASSIGMENT_C	0x04
+#define SELECT_PIN_ASSIGMENT_D	0x08
+#define SELECT_PIN_ASSIGMENT_E	0x10
+#define SELECT_PIN_ASSIGMENT_U	0x00
+#define REDRIVER_ADDRESS	0x20
+#define REDRIVER_OFFSET		0x00
+
+#define DP_SVID			0xFF01
+#define VDM_ACK			0x40
+#define VDM_CMD_RES		0x00
+#define VDM_CMD_DIS_ID		0x01
+#define VDM_CMD_DIS_SVID	0x02
+#define VDM_CMD_DIS_MOD		0x03
+#define VDM_CMD_ENTER_MODE	0x04
+#define VDM_CMD_EXIT_MODE	0x05
+#define VDM_CMD_ATTENTION	0x06
+#define VDM_CMD_GET_STS		0x10
+#define VDM_CMD_AND_ACK_MASK	0x5F
+
+#define MAX_ALTMODE		2
+
+#define HAS_SOURCE_CAP		BIT(0)
+#define HAS_SINK_CAP		BIT(1)
+#define HAS_SINK_WATT		BIT(2)
+
+enum anx7411_psy_state {
+	/* copy from drivers/usb/typec/tcpm */
+	ANX7411_PSY_OFFLINE = 0,
+	ANX7411_PSY_FIXED_ONLINE,
+
+	/* private */
+	/* PD keep in, but disconnct power to bq25700,
+	 * this state can be active when higher capacity adapter plug in,
+	 * and change to ONLINE state when higher capacity adapter plug out
+	 */
+	ANX7411_PSY_HANG = 0xff,
+};
+
+struct typec_params {
+	int request_current; /* ma */
+	int request_voltage; /* mv */
+	int cc_connect;
+	int cc_orientation_valid;
+	int cc_status;
+	int data_role;
+	int power_role;
+	int vconn_role;
+	int dp_altmode_enter;
+	int cust_altmode_enter;
+	struct usb_role_switch *role_sw;
+	struct typec_port *port;
+	struct typec_partner *partner;
+	struct typec_mux *typec_mux;
+	struct typec_switch *typec_switch;
+	struct typec_altmode *amode[MAX_ALTMODE];
+	struct typec_altmode *port_amode[MAX_ALTMODE];
+	struct typec_displayport_data data;
+	int pin_assignment;
+	struct typec_capability caps;
+	u32 src_pdo[PDO_MAX_OBJECTS];
+	u32 sink_pdo[PDO_MAX_OBJECTS];
+	u8 caps_flags;
+	u8 src_pdo_nr;
+	u8 sink_pdo_nr;
+	u8 sink_watt;
+	u8 sink_voltage;
+};
+
+struct anx7411_data {
+	int fw_version;
+	int fw_subversion;
+	struct i2c_client *tcpc_client;
+	struct i2c_client *spi_client;
+	struct gpio_desc *intp_gpiod;
+	struct fwnode_handle *connector_fwnode;
+	struct typec_params typec;
+	int intp_irq;
+	struct work_struct work;
+	struct workqueue_struct *workqueue;
+	/* Lock for interrupt work queue */
+	struct mutex lock;
+
+	enum anx7411_psy_state psy_online;
+	enum power_supply_usb_type usb_type;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	struct device *dev;
+};
+
+#endif /* __ANX7411_H__ */
-- 
2.25.1

