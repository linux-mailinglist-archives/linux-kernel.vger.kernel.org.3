Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8446B5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhLGI3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:29:15 -0500
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:47406
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232558AbhLGI3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPLh6vsI6k1MR/VqL3uWmqUBpR/YddRblRt6L4tcdM+56HlJyVDxDbhqe74svkG8Wmv8Pyz6S1vgqvdjLVr/7+/QK7+AdVabUyX67VUws6Weqqso5bxKpzrr6ZiGBcRQQVYgPfkYet7NyuezynkP2wpZgpeCMuq3ImEanTQTDzM8suYO2sjlGszJV32fZa+7rEktVmJqZ/YaQ/RsRbO/lPJlh+if/LdO5NERvRV+WrxWLfbpImuQdz6vkcOvx6KXIXP0O79sCLKtwCD8au1GTo6eV8qr/5XvEOdULdT8KswLjYW/TJ2T84/TyIub//bNvkhfqWtt17DkBBUkrbELSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI9e+yMNI1XsKPduIL7vM+nujTv44YCGq2aPByo1beo=;
 b=AQgDAWfA4M8cVqoyhVlpes9l5fuB23y7Za1eRZgy9Fpss/wKzpjpxdE832FfT89SgIExlipfszH/u+SVKpptYCvMTOLI3OJ71H0vgtQXHule+RhpkOF61y2cfSeC5q1BeVeSFu9NUwnsuuhhg1m0BsMM+vTgBx7r5VIGmGEKKsX6OzvCzKasexbX5zSn5eafOQ4YyOxruhCBWZohYv0MQt5PEDY8EGnRnR7W7cGWhMbVK+OhVuDNBtiG3FvPAh9EdKF+EH7iKaL7UpY1ZfMKOxKZz0pHN+uWVSbdAEPBL/Ph0XpET34V/LTNUxW4XCCf+mRf7woN3/7V5K7yQgbLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI9e+yMNI1XsKPduIL7vM+nujTv44YCGq2aPByo1beo=;
 b=bc6p6Jaq8nG9XFpsrWfXN/T+B6kFiRB630GgfdN14GYeetsaMTtY7XDvCrOP7jDpV/lX5BuXcA7bddSurFWpq4BLaDAVZ3bUyKEMi6uDoClYmmdHbpxZc38EML7mnSaasoxMrD/f4kOLvl741Q169dLIaIw3MFfMof7iZZxwH8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB2978.eurprd04.prod.outlook.com (2603:10a6:206:5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 08:25:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:27 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 06/13] media: amphion: add vpu v4l2 m2m support
Date:   Tue,  7 Dec 2021 16:24:21 +0800
Message-Id: <7cb9fcb62f0e24c48644ff86d4423564a318a39f.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7938fc56-60a4-4cac-b73c-08d9b95b1fba
X-MS-TrafficTypeDiagnostic: AM5PR04MB2978:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB29789BF13E04309040C28278E76E9@AM5PR04MB2978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMOezJpSAhll7vR0XniD/1SVNbOu6LOKOKfxNh2fJofdpo15RoQJ8zpH1+LvcVOEEI2JzHmO+SGCi+kzXOiQakRc0TrvERhRTC7IqJ4QgYvTDg9E26d/XyPbxRhqcbJPouoAP0+Gu73EOnknSawqQO1KbS+Kuwv8OUqca5oymCOSHKIKW9pHH4RadhMzqeHhxeOFlFVGqPMHXjb5Z9KS7BZPPs8N9pTGU6HTKqXiz7MYfeTYp/VNeIcm5FNxChkc2vIM01wFb3SSMQUWtS1CyH7dCDoGHdZ380IIpLDQ6GxcG2WwJgSShTqQV5TIy+KhVSqZTrhBnqa3H/9c0YVOrTfgiCzku6xlGDjMs17qsXX8eic5KXps8l4YRQWKl1QZ62LAxZd0cT8xUVqFrRWhEtTq6U7PWGKh+F3PxWhWuDb/8gcqGahdzMI6+tr7r2TX5ipxKgB5u8wM9lgz/Ry6UR4Zo3xV7HIWRiSZMiB/uhC9rCHkVXZfI7r5ryppCBzI9r41L2Bq5aO5daTrBlEqzxH3smHvstLim3wlFu9MeIGZbT57+V3s0wmlZHJBIzSH9RLu+ucvpPTF4v4jTyJlNIDJCn7gOEd8l0F2SyrN3+TjMn3pA+lhsQQKJlq2UuHwXMlDCqQd6PaQqNeqMPD/XTrOR0XuFy4KNMxqTBHSmTqBDdpy6/8kO36AwcUD6rXjthfJ3k0BNtrEZF/gJpMJnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(7696005)(44832011)(508600001)(316002)(5660300002)(7416002)(4326008)(8676002)(36756003)(956004)(38350700002)(38100700002)(186003)(2616005)(83380400001)(26005)(2906002)(66946007)(66476007)(30864003)(8936002)(86362001)(6486002)(66556008)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNG5bFawvhEnJX6XIkG3CseoqCxI5DdPSIVd4OuChhB9qRSm6iPJmHSFgjP9?=
 =?us-ascii?Q?iRHsoyHydgs5UPTXtek/+YNVFoBCgKNTRZmgZptk71w5RmnD4vSJKLXgVL4x?=
 =?us-ascii?Q?HhFLLASUD5opLpW3J1NlTS3rSAam9ZXsBxE5H05eEmQS+ngFefB+i0sKuqBf?=
 =?us-ascii?Q?R2HgDCIJbSYssOOg7Z8i/LgMDv/18Mc6TFXa0CyJzEN9Ujngr+lUcF6hDCPH?=
 =?us-ascii?Q?rMPx27YF3QzK57MEft0cyA1mP5MobGlAIzrxHCEMR14Ryg430U2HaS7NdHZn?=
 =?us-ascii?Q?2nH+JdUBrObwFZ/wGrlw2XyVBAb76w2YjoHZx+H5W7ozBR0mIHHZk/EWSXiZ?=
 =?us-ascii?Q?FnyR5kZ6rdYi8auPy9YqbD3u8ikxcAe71OxyETRaeZnRKT/iC/bs5zHmWDYY?=
 =?us-ascii?Q?snnEv4huFeSUZiiANyOskORvACtB+PA3nyJCSydc8WJit0sPWiK8lgPlkH82?=
 =?us-ascii?Q?eHIU1CacqfIVQtXujbE3bxxJRtdNeP7OeXlYjFYXP1oppzA9A/6luT1AOcgy?=
 =?us-ascii?Q?TFErGc0K+VtfS42p+1oBqeql8Ux4nW+bU3FlrGReJAY1HFZfUjoPnp/MD2uh?=
 =?us-ascii?Q?iuvMBYAISPjsqXUuaZsyGrcna/7PNFNmBZ9Ltkk3OHcmQQBfSlhyzag0Anal?=
 =?us-ascii?Q?CfES+zrWFlM7Rx9IQOs5CGMWnhHzOruGtQTvsVBPUmM5NRwioxjU0vl/i8BJ?=
 =?us-ascii?Q?IK93xeRe2J74s76RB5uN9rltY4BY1qu+cyLEEVPcatJPV9cXUt8btJF3KfMJ?=
 =?us-ascii?Q?gH20xJ7937BvjRwzG7OQn17DEqMyAnXs1icoj97Dwc9+Vn/cmZltX/ZuIxwp?=
 =?us-ascii?Q?YOz0kCgfyT2gXRHLlPC94EHW+ParZIXYCtpgwyJ7ywWUyV98gqnBKT/hHubv?=
 =?us-ascii?Q?e2j4dkVZkm0M9qXeFok4yik4Sn+xHPQ3WZI5lkPdsy55YhTNrQJE9dYZC202?=
 =?us-ascii?Q?1vCx5LmAKwVtAEN8QhYIlh/Pou4hEHGHRwtiRjsD0SUN6D1JMTRI122yfRs1?=
 =?us-ascii?Q?v2lKnTrlo7Jjz9rHYw9HOSLRavScUYoG3OQ6pISIJ4bQB/Xxknk6MrQ4JTZV?=
 =?us-ascii?Q?F8g+zl6uNYu+j8DCc+TdJ9pwbZiXvmpS2VTDzcUgrgHCrpGIHjwkX52vXOOB?=
 =?us-ascii?Q?zE57YnT+zLDD7EPuJjIp3HiQov2i3CUyTrudeo1EDqYKCpYQO8emEfiq/KtN?=
 =?us-ascii?Q?7VMeJnNKEB8ZHYnJoeL9U9+X9+CE+nfjbmo2wfN1I33WMICJ2YaFXftUS1lR?=
 =?us-ascii?Q?ZvDQnDrlR04kwIyRdy7eKsvIym5uVA0/xIZ90ZVIxO3Bn+1qs5nZ+ESBmOlB?=
 =?us-ascii?Q?rgwngRpVLkqtQLYNO88PNtbUel6qV+xYnCVO2elPEhJDWe/GuCDlplSz0lvx?=
 =?us-ascii?Q?TxKD0nmSdWTftzOfS/49xsEjC8K/pybRPKyjgBA5LzhkFNpv0h0vISIBJEnL?=
 =?us-ascii?Q?mFAg8Wo5KAE0nDzGz8oNft0StoXOfj0KzqlZYVfE+lEhhqwtKVjdJhL3MVe7?=
 =?us-ascii?Q?C5QOJnmGg9Cpyz2G7kXq7Y1q2UnI1xF3NZKlNDFsYP6SUv4XWbk3lSE99Rlt?=
 =?us-ascii?Q?fKi5qdyx613CNvPPyJNfVssM4lnMTJUeWcta2GGuIpGZsGM0SFn/jyF4FXty?=
 =?us-ascii?Q?I9TukS19hBXfFXizOgLwIjE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938fc56-60a4-4cac-b73c-08d9b95b1fba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:27.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OK8bLTC4O4EOeIUY7WN9vekygmEE+7bUAEroRVpbTH35g3YBnSGH/HFjwZA+ZRLwmjKBknU9ReJ8eQdG5NfWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2978
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vpu_v4l2.c implements the v4l2 m2m driver methods.
vpu_helpers.c implements the common helper functions
vpu_color.c converts the v4l2 colorspace with
the VUI parameters that specified by ITU-T | ISO/IEC

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/media/platform/amphion/vpu_color.c   | 186 +++++
 drivers/media/platform/amphion/vpu_helpers.c | 416 +++++++++++
 drivers/media/platform/amphion/vpu_helpers.h |  70 ++
 drivers/media/platform/amphion/vpu_v4l2.c    | 733 +++++++++++++++++++
 drivers/media/platform/amphion/vpu_v4l2.h    |  56 ++
 5 files changed, 1461 insertions(+)
 create mode 100644 drivers/media/platform/amphion/vpu_color.c
 create mode 100644 drivers/media/platform/amphion/vpu_helpers.c
 create mode 100644 drivers/media/platform/amphion/vpu_helpers.h
 create mode 100644 drivers/media/platform/amphion/vpu_v4l2.c
 create mode 100644 drivers/media/platform/amphion/vpu_v4l2.h

diff --git a/drivers/media/platform/amphion/vpu_color.c b/drivers/media/platform/amphion/vpu_color.c
new file mode 100644
index 000000000000..1c062dc40306
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_color.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <media/v4l2-device.h>
+#include "vpu.h"
+#include "vpu_helpers.h"
+
+static const u8 colorprimaries[] = {
+	0,
+	V4L2_COLORSPACE_REC709,         /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	V4L2_COLORSPACE_470_SYSTEM_M,   /*Rec. ITU-R BT.470-6 System M*/
+	V4L2_COLORSPACE_470_SYSTEM_BG,  /*Rec. ITU-R BT.470-6 System B, G*/
+	V4L2_COLORSPACE_SMPTE170M,      /*SMPTE170M*/
+	V4L2_COLORSPACE_SMPTE240M,      /*SMPTE240M*/
+	0,                              /*Generic film*/
+	V4L2_COLORSPACE_BT2020,         /*Rec. ITU-R BT.2020-2*/
+	0,                              /*SMPTE ST 428-1*/
+};
+
+static const u8 colortransfers[] = {
+	0,
+	V4L2_XFER_FUNC_709,             /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	0,                              /*Rec. ITU-R BT.470-6 System M*/
+	0,                              /*Rec. ITU-R BT.470-6 System B, G*/
+	V4L2_XFER_FUNC_709,             /*SMPTE170M*/
+	V4L2_XFER_FUNC_SMPTE240M,       /*SMPTE240M*/
+	V4L2_XFER_FUNC_NONE,            /*Linear transfer characteristics*/
+	0,
+	0,
+	0,                              /*IEC 61966-2-4*/
+	0,                              /*Rec. ITU-R BT.1361-0 extended colour gamut*/
+	V4L2_XFER_FUNC_SRGB,            /*IEC 61966-2-1 sRGB or sYCC*/
+	V4L2_XFER_FUNC_709,             /*Rec. ITU-R BT.2020-2 (10 bit system)*/
+	V4L2_XFER_FUNC_709,             /*Rec. ITU-R BT.2020-2 (12 bit system)*/
+	V4L2_XFER_FUNC_SMPTE2084,       /*SMPTE ST 2084*/
+	0,                              /*SMPTE ST 428-1*/
+	0                               /*Rec. ITU-R BT.2100-0 hybrid log-gamma (HLG)*/
+};
+
+static const u8 colormatrixcoefs[] = {
+	0,
+	V4L2_YCBCR_ENC_709,              /*Rec. ITU-R BT.709-6*/
+	0,
+	0,
+	0,                               /*Title 47 Code of Federal Regulations*/
+	V4L2_YCBCR_ENC_601,              /*Rec. ITU-R BT.601-7 625*/
+	V4L2_YCBCR_ENC_601,              /*Rec. ITU-R BT.601-7 525*/
+	V4L2_YCBCR_ENC_SMPTE240M,        /*SMPTE240M*/
+	0,
+	V4L2_YCBCR_ENC_BT2020,           /*Rec. ITU-R BT.2020-2*/
+	V4L2_YCBCR_ENC_BT2020_CONST_LUM  /*Rec. ITU-R BT.2020-2 constant*/
+};
+
+u32 vpu_color_cvrt_primaries_v2i(u32 primaries)
+{
+	return VPU_ARRAY_FIND(colorprimaries, primaries);
+}
+
+u32 vpu_color_cvrt_primaries_i2v(u32 primaries)
+{
+	return VPU_ARRAY_AT(colorprimaries, primaries);
+}
+
+u32 vpu_color_cvrt_transfers_v2i(u32 transfers)
+{
+	return VPU_ARRAY_FIND(colortransfers, transfers);
+}
+
+u32 vpu_color_cvrt_transfers_i2v(u32 transfers)
+{
+	return VPU_ARRAY_AT(colortransfers, transfers);
+}
+
+u32 vpu_color_cvrt_matrix_v2i(u32 matrix)
+{
+	return VPU_ARRAY_FIND(colormatrixcoefs, matrix);
+}
+
+u32 vpu_color_cvrt_matrix_i2v(u32 matrix)
+{
+	return VPU_ARRAY_AT(colormatrixcoefs, matrix);
+}
+
+u32 vpu_color_cvrt_full_range_v2i(u32 full_range)
+{
+	return (full_range == V4L2_QUANTIZATION_FULL_RANGE);
+}
+
+u32 vpu_color_cvrt_full_range_i2v(u32 full_range)
+{
+	if (full_range)
+		return V4L2_QUANTIZATION_FULL_RANGE;
+
+	return V4L2_QUANTIZATION_LIM_RANGE;
+}
+
+int vpu_color_check_primaries(u32 primaries)
+{
+	return vpu_color_cvrt_primaries_v2i(primaries) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_transfers(u32 transfers)
+{
+	return vpu_color_cvrt_transfers_v2i(transfers) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_matrix(u32 matrix)
+{
+	return vpu_color_cvrt_matrix_v2i(matrix) ? 0 : -EINVAL;
+}
+
+int vpu_color_check_full_range(u32 full_range)
+{
+	int ret = -EINVAL;
+
+	switch (full_range) {
+	case V4L2_QUANTIZATION_FULL_RANGE:
+	case V4L2_QUANTIZATION_LIM_RANGE:
+		ret = 0;
+		break;
+	default:
+		break;
+
+	}
+
+	return ret;
+}
+
+int vpu_color_get_default(u32 primaries,
+		u32 *ptransfers, u32 *pmatrix, u32 *pfull_range)
+{
+	u32 transfers;
+	u32 matrix;
+	u32 full_range;
+
+	switch (primaries) {
+	case V4L2_COLORSPACE_REC709:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_709;
+		break;
+	case V4L2_COLORSPACE_470_SYSTEM_M:
+	case V4L2_COLORSPACE_470_SYSTEM_BG:
+	case V4L2_COLORSPACE_SMPTE170M:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_601;
+		break;
+	case V4L2_COLORSPACE_SMPTE240M:
+		transfers = V4L2_XFER_FUNC_SMPTE240M;
+		matrix = V4L2_YCBCR_ENC_SMPTE240M;
+		break;
+	case V4L2_COLORSPACE_BT2020:
+		transfers = V4L2_XFER_FUNC_709;
+		matrix = V4L2_YCBCR_ENC_BT2020;
+		break;
+	default:
+		transfers = V4L2_XFER_FUNC_DEFAULT;
+		matrix = V4L2_YCBCR_ENC_DEFAULT;
+		break;
+	}
+	full_range = V4L2_QUANTIZATION_LIM_RANGE;
+
+	if (ptransfers)
+		*ptransfers = transfers;
+	if (pmatrix)
+		*pmatrix = matrix;
+	if (pfull_range)
+		*pfull_range = full_range;
+
+
+	return 0;
+}
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
new file mode 100644
index 000000000000..f41df259eb1e
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_rpc.h"
+#include "vpu_helpers.h"
+
+int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (array[i] == x)
+			return i;
+	}
+
+	return 0;
+}
+
+bool vpu_helper_check_type(struct vpu_inst *inst, u32 type)
+{
+	const struct vpu_format *pfmt;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (!vpu_iface_check_format(inst, pfmt->pixfmt))
+			continue;
+		if (pfmt->type == type)
+			return true;
+	}
+
+	return false;
+}
+
+const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt)
+{
+	const struct vpu_format *pfmt;
+
+	if (!inst || !inst->formats)
+		return NULL;
+
+	if (!vpu_iface_check_format(inst, pixelfmt))
+		return NULL;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (pfmt->pixfmt == pixelfmt && (!type || type == pfmt->type))
+			return pfmt;
+	}
+
+	return NULL;
+}
+
+const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index)
+{
+	const struct vpu_format *pfmt;
+	int i = 0;
+
+	if (!inst || !inst->formats)
+		return NULL;
+
+	for (pfmt = inst->formats; pfmt->pixfmt; pfmt++) {
+		if (!vpu_iface_check_format(inst, pfmt->pixfmt))
+			continue;
+
+		if (pfmt->type == type) {
+			if (index == i)
+				return pfmt;
+			i++;
+		}
+	}
+
+	return NULL;
+}
+
+u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width)
+{
+	const struct vpu_core_resources *res;
+
+	if (!inst)
+		return width;
+
+	res = vpu_get_resource(inst);
+	if (!res)
+		return width;
+	if (res->max_width)
+		width = clamp(width, res->min_width, res->max_width);
+	if (res->step_width)
+		width = ALIGN(width, res->step_width);
+
+	return width;
+}
+
+u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height)
+{
+	const struct vpu_core_resources *res;
+
+	if (!inst)
+		return height;
+
+	res = vpu_get_resource(inst);
+	if (!res)
+		return height;
+	if (res->max_height)
+		height = clamp(height, res->min_height, res->max_height);
+	if (res->step_height)
+		height = ALIGN(height, res->step_height);
+
+	return height;
+}
+
+static u32 get_nv12_plane_size(u32 width, u32 height, int plane_no,
+			u32 stride, u32 interlaced, u32 *pbl)
+{
+	u32 bytesperline;
+	u32 size = 0;
+
+	bytesperline = ALIGN(width, stride);
+	if (pbl)
+		bytesperline = max(bytesperline, *pbl);
+	height = ALIGN(height, 2);
+	if (plane_no == 0)
+		size = bytesperline * height;
+	else if (plane_no == 1)
+		size = bytesperline * height >> 1;
+	if (pbl)
+		*pbl = bytesperline;
+
+	return size;
+}
+
+static u32 get_tiled_8l128_plane_size(u32 fmt, u32 width, u32 height, int plane_no,
+			u32 stride, u32 interlaced, u32 *pbl)
+{
+	u32 ws = 3;
+	u32 hs = 7;
+	u32 bitdepth = 8;
+	u32 bytesperline;
+	u32 size = 0;
+
+	if (interlaced)
+		hs++;
+	if (fmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+		bitdepth = 10;
+	bytesperline = DIV_ROUND_UP(width * bitdepth, BITS_PER_BYTE);
+	bytesperline = ALIGN(bytesperline, 1 << ws);
+	bytesperline = ALIGN(bytesperline, stride);
+	if (pbl)
+		bytesperline = max(bytesperline, *pbl);
+	height = ALIGN(height, 1 << hs);
+	if (plane_no == 0)
+		size = bytesperline * height;
+	else if (plane_no == 1)
+		size = (bytesperline * ALIGN(height, 1 << (hs + 1))) >> 1;
+	if (pbl)
+		*pbl = bytesperline;
+
+	return size;
+}
+
+static u32 get_default_plane_size(u32 width, u32 height, int plane_no,
+			u32 stride, u32 interlaced, u32 *pbl)
+{
+	u32 bytesperline;
+	u32 size = 0;
+
+	bytesperline = ALIGN(width, stride);
+	if (pbl)
+		bytesperline = max(bytesperline, *pbl);
+	if (plane_no == 0)
+		size = bytesperline * height;
+	if (pbl)
+		*pbl = bytesperline;
+
+	return size;
+}
+
+u32 vpu_helper_get_plane_size(u32 fmt, u32 w, u32 h, int plane_no,
+		u32 stride, u32 interlaced, u32 *pbl)
+{
+	switch (fmt) {
+	case V4L2_PIX_FMT_NV12M:
+		return get_nv12_plane_size(w, h, plane_no, stride, interlaced, pbl);
+	case V4L2_PIX_FMT_NV12M_8L128:
+	case V4L2_PIX_FMT_NV12M_10BE_8L128:
+		return get_tiled_8l128_plane_size(fmt, w, h, plane_no, stride, interlaced, pbl);
+	default:
+		return get_default_plane_size(w, h, plane_no, stride, interlaced, pbl);
+	}
+}
+
+u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 *rptr, u32 size, void *dst)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !rptr || !dst)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *rptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+
+	if (offset < start || offset > end)
+		return -EINVAL;
+
+	if (offset + size <= end) {
+		memcpy(dst, virt + (offset - start), size);
+	} else {
+		memcpy(dst, virt + (offset - start), end - offset);
+		memcpy(dst + end - offset, virt, size + offset - end);
+	}
+
+	*rptr = vpu_helper_step_walk(stream_buffer, offset, size);
+	return size;
+}
+
+u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u32 size, void *src)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !wptr || !src)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *wptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+	if (offset < start || offset > end)
+		return -EINVAL;
+
+	if (offset + size <= end) {
+		memcpy(virt + (offset - start), src, size);
+	} else {
+		memcpy(virt + (offset - start), src, end - offset);
+		memcpy(virt, src + end - offset, size + offset - end);
+	}
+
+	*wptr = vpu_helper_step_walk(stream_buffer, offset, size);
+
+	return size;
+}
+
+u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u8 val, u32 size)
+{
+	u32 offset;
+	u32 start;
+	u32 end;
+	void *virt;
+
+	if (!stream_buffer || !wptr)
+		return -EINVAL;
+
+	if (!size)
+		return 0;
+
+	offset = *wptr;
+	start = stream_buffer->phys;
+	end = start + stream_buffer->length;
+	virt = stream_buffer->virt;
+	if (offset < start || offset > end)
+		return -EINVAL;
+
+	if (offset + size <= end) {
+		memset(virt + (offset - start), val, size);
+	} else {
+		memset(virt + (offset - start), val, end - offset);
+		memset(virt, val, size + offset - end);
+	}
+
+	offset += size;
+	if (offset >= end)
+		offset -= stream_buffer->length;
+
+	*wptr = offset;
+
+	return size;
+}
+
+u32 vpu_helper_get_free_space(struct vpu_inst *inst)
+{
+	struct vpu_rpc_buffer_desc desc;
+
+	if (vpu_iface_get_stream_buffer_desc(inst, &desc))
+		return 0;
+
+	if (desc.rptr > desc.wptr)
+		return desc.rptr - desc.wptr;
+	else if (desc.rptr < desc.wptr)
+		return (desc.end - desc.start + desc.rptr - desc.wptr);
+	else
+		return desc.end - desc.start;
+}
+
+u32 vpu_helper_get_used_space(struct vpu_inst *inst)
+{
+	struct vpu_rpc_buffer_desc desc;
+
+	if (vpu_iface_get_stream_buffer_desc(inst, &desc))
+		return 0;
+
+	if (desc.wptr > desc.rptr)
+		return desc.wptr - desc.rptr;
+	else if (desc.wptr < desc.rptr)
+		return (desc.end - desc.start + desc.wptr - desc.rptr);
+	else
+		return 0;
+}
+
+int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
+		ctrl->val = inst->min_buffer_cap;
+		break;
+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
+		ctrl->val = inst->min_buffer_out;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define READ_BYTE(buffer, pos)	\
+	(*(u8 *)((buffer)->virt + ((pos) % buffer->length)))
+
+int vpu_helper_find_startcode(struct vpu_buffer *stream_buffer,
+			u32 pixelformat, u32 offset, u32 bytesused)
+{
+	u32 start_code;
+	int start_code_size;
+	u32 val = 0;
+	int i;
+	int ret = -EINVAL;
+
+	if (!stream_buffer || !stream_buffer->virt)
+		return -EINVAL;
+
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_H264:
+		start_code_size = 4;
+		start_code = 0x00000001;
+		break;
+	default:
+		return 0;
+	}
+
+	for (i = 0; i < bytesused; i++) {
+		val = (val << 8) | READ_BYTE(stream_buffer, offset + i);
+		if (i < start_code_size - 1)
+			continue;
+		if (val == start_code) {
+			ret = i + 1 - start_code_size;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int vpu_find_dst_by_src(struct vpu_pair *pairs, u32 cnt, u32 src)
+{
+	u32 i;
+
+	if (!pairs || !cnt)
+		return -EINVAL;
+
+	for (i = 0; i < cnt; i++) {
+		if (pairs[i].src == src)
+			return pairs[i].dst;
+	}
+
+	return -EINVAL;
+}
+
+int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 cnt, u32 dst)
+{
+	u32 i;
+
+	if (!pairs || !cnt)
+		return -EINVAL;
+
+	for (i = 0; i < cnt; i++) {
+		if (pairs[i].dst == dst)
+			return pairs[i].src;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/amphion/vpu_helpers.h
new file mode 100644
index 000000000000..8cb9b8c77745
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_helpers.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#ifndef _AMPHION_VPU_HELPERS_H
+#define _AMPHION_VPU_HELPERS_H
+
+struct vpu_pair {
+	u32 src;
+	u32 dst;
+};
+
+#define MAKE_TIMESTAMP(s, ns)		(((s32)(s) * NSEC_PER_SEC) + (ns))
+#define VPU_INVALID_TIMESTAMP		MAKE_TIMESTAMP(-1, 0)
+#define	VPU_ARRAY_AT(array, i)		(((i) < ARRAY_SIZE(array)) ? array[i] : 0)
+#define VPU_ARRAY_FIND(array, x)	vpu_helper_find_in_array_u8(array, ARRAY_SIZE(array), x)
+
+int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
+bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);
+const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index);
+u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
+u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
+u32 vpu_helper_get_plane_size(u32 fmt, u32 width, u32 height, int plane_no,
+					u32 stride, u32 interlaced, u32 *pbl);
+u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 *rptr, u32 size, void *dst);
+u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u32 size, void *src);
+u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+				u32 *wptr, u8 val, u32 size);
+u32 vpu_helper_get_free_space(struct vpu_inst *inst);
+u32 vpu_helper_get_used_space(struct vpu_inst *inst);
+int vpu_helper_g_volatile_ctrl(struct v4l2_ctrl *ctrl);
+void vpu_helper_get_kmp_next(const u8 *pattern, int *next, int size);
+int vpu_helper_kmp_search(u8 *s, int s_len, const u8 *p, int p_len, int *next);
+int vpu_helper_kmp_search_in_stream_buffer(struct vpu_buffer *stream_buffer,
+					u32 offset, int bytesused,
+					const u8 *p, int p_len, int *next);
+int vpu_helper_find_startcode(struct vpu_buffer *stream_buffer,
+			u32 pixelformat, u32 offset, u32 bytesused);
+
+static inline u32 vpu_helper_step_walk(struct vpu_buffer *stream_buffer, u32 pos, u32 step)
+{
+	pos += step;
+	if (pos > stream_buffer->phys + stream_buffer->length)
+		pos -= stream_buffer->length;
+
+	return pos;
+}
+
+int vpu_color_check_primaries(u32 primaries);
+int vpu_color_check_transfers(u32 transfers);
+int vpu_color_check_matrix(u32 matrix);
+int vpu_color_check_full_range(u32 full_range);
+u32 vpu_color_cvrt_primaries_v2i(u32 primaries);
+u32 vpu_color_cvrt_primaries_i2v(u32 primaries);
+u32 vpu_color_cvrt_transfers_v2i(u32 transfers);
+u32 vpu_color_cvrt_transfers_i2v(u32 transfers);
+u32 vpu_color_cvrt_matrix_v2i(u32 matrix);
+u32 vpu_color_cvrt_matrix_i2v(u32 matrix);
+u32 vpu_color_cvrt_full_range_v2i(u32 full_range);
+u32 vpu_color_cvrt_full_range_i2v(u32 full_range);
+int vpu_color_get_default(u32 primaries,
+		u32 *ptransfers, u32 *pmatrix, u32 *pfull_range);
+
+int vpu_find_dst_by_src(struct vpu_pair *pairs, u32 cnt, u32 src);
+int vpu_find_src_by_dst(struct vpu_pair *pairs, u32 cnt, u32 dst);
+#endif
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
new file mode 100644
index 000000000000..a91690f691bc
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -0,0 +1,733 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include "vpu.h"
+#include "vpu_core.h"
+#include "vpu_v4l2.h"
+#include "vpu_msgs.h"
+#include "vpu_helpers.h"
+
+void vpu_inst_lock(struct vpu_inst *inst)
+{
+	mutex_lock(&inst->lock);
+}
+
+void vpu_inst_unlock(struct vpu_inst *inst)
+{
+	mutex_unlock(&inst->lock);
+}
+
+dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no)
+{
+	if (plane_no >= vb->num_planes)
+		return 0;
+	return vb2_dma_contig_plane_dma_addr(vb, plane_no) +
+			vb->planes[plane_no].data_offset;
+}
+
+unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no)
+{
+	if (plane_no >= vb->num_planes)
+		return 0;
+	return vb2_plane_size(vb, plane_no) - vb->planes[plane_no].data_offset;
+}
+
+void vpu_set_buffer_state(struct vb2_v4l2_buffer *vbuf, unsigned int state)
+{
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	vpu_buf->state = state;
+}
+
+unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf)
+{
+	struct vpu_vb2_buffer *vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	return vpu_buf->state;
+}
+
+void vpu_v4l2_set_error(struct vpu_inst *inst)
+{
+	struct vb2_queue *src_q;
+	struct vb2_queue *dst_q;
+
+	if (!inst)
+		return;
+
+	vpu_inst_lock(inst);
+	dev_err(inst->dev, "some error occurs in codec\n");
+	if (inst->fh.m2m_ctx) {
+		src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
+		dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+		if (src_q)
+			src_q->error = 1;
+		if (dst_q)
+			dst_q->error = 1;
+	}
+	vpu_inst_unlock(inst);
+}
+
+int vpu_notify_eos(struct vpu_inst *inst)
+{
+	static const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_EOS
+	};
+
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+	v4l2_event_queue_fh(&inst->fh, &ev);
+
+	return 0;
+}
+
+int vpu_notify_source_change(struct vpu_inst *inst)
+{
+	static const struct v4l2_event ev = {
+		.id = 0,
+		.type = V4L2_EVENT_SOURCE_CHANGE,
+		.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION
+	};
+
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+	v4l2_event_queue_fh(&inst->fh, &ev);
+	return 0;
+}
+
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
+{
+	struct vb2_queue *q;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+	if (!list_empty(&q->done_list))
+		return -EINVAL;
+
+	if (q->last_buffer_dequeued)
+		return 0;
+	vpu_trace(inst->dev, "last buffer dequeued\n");
+	q->last_buffer_dequeued = true;
+	wake_up(&q->done_wq);
+	vpu_notify_eos(inst);
+	return 0;
+}
+
+const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst,
+		 struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	u32 type = f->type;
+	u32 stride = 1;
+	u32 bytesperline;
+	u32 sizeimage;
+	const struct vpu_format *fmt;
+	const struct vpu_core_resources *res;
+	int i;
+
+	fmt = vpu_helper_find_format(inst, type, pixmp->pixelformat);
+	if (!fmt) {
+		fmt = vpu_helper_enum_format(inst, type, 0);
+		if (!fmt)
+			return NULL;
+		pixmp->pixelformat = fmt->pixfmt;
+	}
+
+	res = vpu_get_resource(inst);
+	if (res)
+		stride = res->stride;
+	if (pixmp->width)
+		pixmp->width = vpu_helper_valid_frame_width(inst, pixmp->width);
+	if (pixmp->height)
+		pixmp->height = vpu_helper_valid_frame_height(inst, pixmp->height);
+	pixmp->flags = fmt->flags;
+	pixmp->num_planes = fmt->num_planes;
+	if (pixmp->field == V4L2_FIELD_ANY)
+		pixmp->field = V4L2_FIELD_NONE;
+	for (i = 0; i < pixmp->num_planes; i++) {
+		bytesperline = max_t(s32, pixmp->plane_fmt[i].bytesperline, 0);
+		sizeimage = vpu_helper_get_plane_size(pixmp->pixelformat,
+				pixmp->width, pixmp->height, i, stride,
+				pixmp->field > V4L2_FIELD_NONE ? 1 : 0,
+				&bytesperline);
+		sizeimage = max_t(s32, pixmp->plane_fmt[i].sizeimage, sizeimage);
+		pixmp->plane_fmt[i].bytesperline = bytesperline;
+		pixmp->plane_fmt[i].sizeimage = sizeimage;
+	}
+
+	return fmt;
+}
+
+static bool vpu_check_ready(struct vpu_inst *inst, u32 type)
+{
+	if (!inst)
+		return false;
+	if (inst->state == VPU_CODEC_STATE_DEINIT || inst->id < 0)
+		return false;
+	if (!inst->ops->check_ready)
+		return true;
+	return call_vop(inst, check_ready, type);
+}
+
+int vpu_process_output_buffer(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	if (!vpu_check_ready(inst, inst->out_format.type))
+		return -EINVAL;
+
+	v4l2_m2m_for_each_src_buf(inst->fh.m2m_ctx, buf) {
+		vbuf = &buf->vb;
+		if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_IDLE)
+			break;
+		vbuf = NULL;
+	}
+
+	if (!vbuf)
+		return -EINVAL;
+
+	dev_dbg(inst->dev, "[%d]frame id = %d / %d\n",
+		inst->id, vbuf->sequence, inst->sequence);
+	return call_vop(inst, process_output, &vbuf->vb2_buf);
+}
+
+int vpu_process_capture_buffer(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	if (!vpu_check_ready(inst, inst->cap_format.type))
+		return -EINVAL;
+
+	v4l2_m2m_for_each_dst_buf(inst->fh.m2m_ctx, buf) {
+		vbuf = &buf->vb;
+		if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_IDLE)
+			break;
+		vbuf = NULL;
+	}
+	if (!vbuf)
+		return -EINVAL;
+
+	return call_vop(inst, process_capture, &vbuf->vb2_buf);
+}
+
+struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst,
+						u32 type, u32 sequence)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return NULL;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		v4l2_m2m_for_each_src_buf(inst->fh.m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->sequence == sequence)
+				break;
+			vbuf = NULL;
+		}
+	} else {
+		v4l2_m2m_for_each_dst_buf(inst->fh.m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->sequence == sequence)
+				break;
+			vbuf = NULL;
+		}
+	}
+
+	return vbuf;
+}
+
+struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst,
+						u32 type, u32 idx)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+	struct vb2_v4l2_buffer *vbuf = NULL;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return NULL;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		v4l2_m2m_for_each_src_buf(inst->fh.m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->vb2_buf.index == idx)
+				break;
+			vbuf = NULL;
+		}
+	} else {
+		v4l2_m2m_for_each_dst_buf(inst->fh.m2m_ctx, buf) {
+			vbuf = &buf->vb;
+			if (vbuf->vb2_buf.index == idx)
+				break;
+			vbuf = NULL;
+		}
+	}
+
+	return vbuf;
+}
+
+int vpu_get_num_buffers(struct vpu_inst *inst, u32 type)
+{
+	struct vb2_queue *q;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
+	else
+		q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+
+	return q->num_buffers;
+}
+
+static void vpu_m2m_device_run(void *priv)
+{
+}
+
+static void vpu_m2m_job_abort(void *priv)
+{
+	struct vpu_inst *inst = priv;
+	struct v4l2_m2m_ctx *m2m_ctx = inst->fh.m2m_ctx;
+
+	v4l2_m2m_job_finish(m2m_ctx->m2m_dev, m2m_ctx);
+}
+
+static const struct v4l2_m2m_ops vpu_m2m_ops = {
+	.device_run = vpu_m2m_device_run,
+	.job_abort = vpu_m2m_job_abort
+};
+
+static int vpu_vb2_queue_setup(struct vb2_queue *vq,
+				unsigned int *buf_count,
+				unsigned int *plane_count,
+				unsigned int psize[],
+				struct device *allocators[])
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(vq);
+	struct vpu_format *cur_fmt;
+	int i;
+
+	cur_fmt = vpu_get_format(inst, vq->type);
+
+	if (*plane_count) {
+		if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE) {
+			for (i = 0; i < *plane_count; i++) {
+				if (!psize[i])
+					psize[i] = cur_fmt->sizeimage[i];
+			}
+			return 0;
+		}
+		if (*plane_count != cur_fmt->num_planes)
+			return -EINVAL;
+		for (i = 0; i < cur_fmt->num_planes; i++) {
+			if (psize[i] < cur_fmt->sizeimage[i])
+				return -EINVAL;
+		}
+		return 0;
+	}
+
+	*plane_count = cur_fmt->num_planes;
+	for (i = 0; i < cur_fmt->num_planes; i++)
+		psize[i] = cur_fmt->sizeimage[i];
+
+	return 0;
+}
+
+static int vpu_vb2_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	return 0;
+}
+
+static int vpu_vb2_buf_out_validate(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_format *cur_fmt;
+	u32 i;
+
+	cur_fmt = vpu_get_format(inst, vb->type);
+	if (vb->num_planes != cur_fmt->num_planes)
+		return -EINVAL;
+	for (i = 0; i < cur_fmt->num_planes; i++) {
+		if (vpu_get_vb_length(vb, i) < cur_fmt->sizeimage[i]) {
+			dev_dbg(inst->dev, "[%d] %s buf[%d] is invalid\n",
+					inst->id,
+					vpu_type_name(vb->type),
+					vb->index);
+			vpu_set_buffer_state(vbuf, VPU_BUF_STATE_ERROR);
+		}
+	}
+
+	return 0;
+}
+
+static void vpu_vb2_buf_finish(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_queue *q = vb->vb2_queue;
+
+	if (vbuf->flags & V4L2_BUF_FLAG_LAST)
+		vpu_notify_eos(inst);
+
+	if (list_empty(&q->done_list))
+		call_vop(inst, on_queue_empty, q->type);
+}
+
+void vpu_vb2_buffers_return(struct vpu_inst *inst,
+		unsigned int type, enum vb2_buffer_state state)
+{
+	struct vb2_v4l2_buffer *buf;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		while ((buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	} else {
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->fh.m2m_ctx)))
+			v4l2_m2m_buf_done(buf, state);
+	}
+}
+
+static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(q);
+	struct vpu_format *fmt = vpu_get_format(inst, q->type);
+	int ret;
+
+	vpu_inst_unlock(inst);
+	ret = vpu_inst_register(inst);
+	vpu_inst_lock(inst);
+	if (ret) {
+		vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_QUEUED);
+		return ret;
+	}
+
+	vpu_trace(inst->dev, "[%d] %s %c%c%c%c %dx%d %u(%u) %u(%u) %u(%u) %d\n",
+			inst->id, vpu_type_name(q->type),
+			fmt->pixfmt,
+			fmt->pixfmt >> 8,
+			fmt->pixfmt >> 16,
+			fmt->pixfmt >> 24,
+			fmt->width, fmt->height,
+			fmt->sizeimage[0], fmt->bytesperline[0],
+			fmt->sizeimage[1], fmt->bytesperline[1],
+			fmt->sizeimage[2], fmt->bytesperline[2],
+			q->num_buffers);
+	call_vop(inst, start, q->type);
+	vb2_clear_last_buffer_dequeued(q);
+
+	return 0;
+}
+
+static void vpu_vb2_stop_streaming(struct vb2_queue *q)
+{
+	struct vpu_inst *inst = vb2_get_drv_priv(q);
+
+	vpu_trace(inst->dev, "[%d] %s\n", inst->id, vpu_type_name(q->type));
+
+	call_vop(inst, stop, q->type);
+	vpu_vb2_buffers_return(inst, q->type, VB2_BUF_STATE_ERROR);
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		inst->sequence = 0;
+}
+
+static void vpu_vb2_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return;
+	if (V4L2_TYPE_IS_OUTPUT(vb->type)) {
+		vbuf->sequence = inst->sequence++;
+		if ((s64)vb->timestamp < 0)
+			vb->timestamp = VPU_INVALID_TIMESTAMP;
+	}
+
+	v4l2_m2m_buf_queue(inst->fh.m2m_ctx, vbuf);
+	vpu_process_output_buffer(inst);
+	vpu_process_capture_buffer(inst);
+}
+
+static struct vb2_ops vpu_vb2_ops = {
+	.queue_setup        = vpu_vb2_queue_setup,
+	.buf_init           = vpu_vb2_buf_init,
+	.buf_out_validate   = vpu_vb2_buf_out_validate,
+	.buf_prepare        = vpu_vb2_buf_prepare,
+	.buf_finish         = vpu_vb2_buf_finish,
+	.start_streaming    = vpu_vb2_start_streaming,
+	.stop_streaming     = vpu_vb2_stop_streaming,
+	.buf_queue          = vpu_vb2_buf_queue,
+	.wait_prepare       = vb2_ops_wait_prepare,
+	.wait_finish        = vb2_ops_wait_finish,
+};
+
+static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq,
+			  struct vb2_queue *dst_vq)
+{
+	struct vpu_inst *inst = priv;
+	int ret;
+
+	inst->out_format.type = src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	src_vq->ops = &vpu_vb2_ops;
+	src_vq->mem_ops = &vb2_dma_contig_memops;
+	if (inst->type == VPU_CORE_TYPE_DEC && inst->use_stream_buffer)
+		src_vq->mem_ops = &vb2_vmalloc_memops;
+	src_vq->drv_priv = inst;
+	src_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
+	src_vq->min_buffers_needed = 1;
+	src_vq->dev = inst->vpu->dev;
+	src_vq->lock = &inst->lock;
+	ret = vb2_queue_init(src_vq);
+	if (ret)
+		return ret;
+
+	inst->cap_format.type = dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	dst_vq->ops = &vpu_vb2_ops;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	if (inst->type == VPU_CORE_TYPE_ENC && inst->use_stream_buffer)
+		dst_vq->mem_ops = &vb2_vmalloc_memops;
+	dst_vq->drv_priv = inst;
+	dst_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
+	dst_vq->min_buffers_needed = 1;
+	dst_vq->dev = inst->vpu->dev;
+	dst_vq->lock = &inst->lock;
+	ret = vb2_queue_init(dst_vq);
+	if (ret) {
+		vb2_queue_release(src_vq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vpu_v4l2_release(struct vpu_inst *inst)
+{
+	vpu_trace(inst->vpu->dev, "%p\n", inst);
+
+	vpu_release_core(inst->core);
+	put_device(inst->dev);
+
+	if (inst->workqueue) {
+		cancel_work_sync(&inst->msg_work);
+		destroy_workqueue(inst->workqueue);
+		inst->workqueue = NULL;
+	}
+
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
+	mutex_destroy(&inst->lock);
+	v4l2_fh_del(&inst->fh);
+	v4l2_fh_exit(&inst->fh);
+
+	call_vop(inst, cleanup);
+
+	return 0;
+}
+
+int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
+{
+	struct vpu_dev *vpu = video_drvdata(file);
+	struct vpu_func *func;
+	int ret = 0;
+
+	if (!file || !inst || !inst->ops)
+		return -EINVAL;
+
+	if (inst->type == VPU_CORE_TYPE_ENC)
+		func = &vpu->encoder;
+	else
+		func = &vpu->decoder;
+
+	atomic_set(&inst->ref_count, 0);
+	vpu_inst_get(inst);
+	inst->vpu = vpu;
+	inst->core = vpu_request_core(vpu, inst->type);
+	if (inst->core)
+		inst->dev = get_device(inst->core->dev);
+	mutex_init(&inst->lock);
+	INIT_LIST_HEAD(&inst->cmd_q);
+	inst->id = VPU_INST_NULL_ID;
+	inst->release = vpu_v4l2_release;
+	inst->pid = current->pid;
+	inst->tgid = current->tgid;
+	inst->min_buffer_cap = 2;
+	inst->min_buffer_out = 2;
+	v4l2_fh_init(&inst->fh, func->vfd);
+	v4l2_fh_add(&inst->fh);
+
+	ret = call_vop(inst, ctrl_init);
+	if (ret)
+		goto error;
+
+	inst->fh.m2m_ctx = v4l2_m2m_ctx_init(func->m2m_dev,
+					inst, vpu_m2m_queue_init);
+	if (IS_ERR(inst->fh.m2m_ctx)) {
+		dev_err(vpu->dev, "v4l2_m2m_ctx_init fail\n");
+		ret = PTR_ERR(func->m2m_dev);
+		goto error;
+	}
+
+	inst->fh.ctrl_handler = &inst->ctrl_handler;
+	file->private_data = &inst->fh;
+	inst->state = VPU_CODEC_STATE_DEINIT;
+	inst->workqueue = alloc_workqueue("vpu_inst", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	if (inst->workqueue) {
+		INIT_WORK(&inst->msg_work, vpu_inst_run_work);
+		ret = kfifo_init(&inst->msg_fifo,
+				inst->msg_buffer,
+				roundup_pow_of_two(sizeof(inst->msg_buffer)));
+		if (ret) {
+			destroy_workqueue(inst->workqueue);
+			inst->workqueue = NULL;
+		}
+	}
+	vpu_trace(vpu->dev, "tgid = %d, pid = %d, type = %s, inst = %p\n",
+			inst->tgid, inst->pid, vpu_core_type_desc(inst->type), inst);
+
+	return 0;
+error:
+	vpu_inst_put(inst);
+	return ret;
+}
+
+int vpu_v4l2_close(struct file *file)
+{
+	struct vpu_dev *vpu = video_drvdata(file);
+	struct vpu_inst *inst = to_inst(file);
+
+	vpu_trace(vpu->dev, "tgid = %d, pid = %d, inst = %p\n",
+			inst->tgid, inst->pid, inst);
+
+	vpu_inst_lock(inst);
+	if (inst->fh.m2m_ctx) {
+		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
+		inst->fh.m2m_ctx = NULL;
+	}
+	vpu_inst_unlock(inst);
+
+	call_vop(inst, release);
+	vpu_inst_unregister(inst);
+	vpu_inst_put(inst);
+
+	return 0;
+}
+
+int vpu_add_func(struct vpu_dev *vpu, struct vpu_func *func)
+{
+	struct video_device *vfd;
+	int ret;
+
+	if (!vpu || !func)
+		return -EINVAL;
+
+	if (func->vfd)
+		return 0;
+
+	func->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
+	if (IS_ERR(func->m2m_dev)) {
+		dev_err(vpu->dev, "v4l2_m2m_init fail\n");
+		func->vfd = NULL;
+		return PTR_ERR(func->m2m_dev);
+	}
+
+	vfd = video_device_alloc();
+	if (!vfd) {
+		v4l2_m2m_release(func->m2m_dev);
+		dev_err(vpu->dev, "alloc vpu decoder video device fail\n");
+		return -ENOMEM;
+	}
+	vfd->release = video_device_release;
+	vfd->vfl_dir = VFL_DIR_M2M;
+	vfd->v4l2_dev = &vpu->v4l2_dev;
+	vfd->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
+	if (func->type == VPU_CORE_TYPE_ENC) {
+		strscpy(vfd->name, "amphion-vpu-encoder", sizeof(vfd->name));
+		vfd->fops = venc_get_fops();
+		vfd->ioctl_ops = venc_get_ioctl_ops();
+	} else {
+		strscpy(vfd->name, "amphion-vpu-decoder", sizeof(vfd->name));
+		vfd->fops = vdec_get_fops();
+		vfd->ioctl_ops = vdec_get_ioctl_ops();
+	}
+
+	ret = video_register_device(vfd, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		video_device_release(vfd);
+		v4l2_m2m_release(func->m2m_dev);
+		return ret;
+	}
+	video_set_drvdata(vfd, vpu);
+	func->vfd = vfd;
+
+	ret = v4l2_m2m_register_media_controller(func->m2m_dev, func->vfd, func->function);
+	if (ret) {
+		v4l2_m2m_release(func->m2m_dev);
+		func->m2m_dev = NULL;
+		video_unregister_device(func->vfd);
+		func->vfd = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+void vpu_remove_func(struct vpu_func *func)
+{
+	if (!func)
+		return;
+
+	if (func->m2m_dev) {
+		v4l2_m2m_unregister_media_controller(func->m2m_dev);
+		v4l2_m2m_release(func->m2m_dev);
+		func->m2m_dev = NULL;
+	}
+	if (func->vfd) {
+		video_unregister_device(func->vfd);
+		func->vfd = NULL;
+	}
+}
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
new file mode 100644
index 000000000000..17aa36603f82
--- /dev/null
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#ifndef _AMPHION_VPU_V4L2_H
+#define _AMPHION_VPU_V4L2_H
+
+#include <linux/videodev2.h>
+
+void vpu_inst_lock(struct vpu_inst *inst);
+void vpu_inst_unlock(struct vpu_inst *inst);
+void vpu_set_buffer_state(struct vb2_v4l2_buffer *vbuf, unsigned int state);
+unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf);
+
+int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
+int vpu_v4l2_close(struct file *file);
+
+const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f);
+int vpu_process_output_buffer(struct vpu_inst *inst);
+int vpu_process_capture_buffer(struct vpu_inst *inst);
+struct vb2_v4l2_buffer *vpu_find_buf_by_sequence(struct vpu_inst *inst, u32 type, u32 sequence);
+struct vb2_v4l2_buffer *vpu_find_buf_by_idx(struct vpu_inst *inst, u32 type, u32 idx);
+void vpu_v4l2_set_error(struct vpu_inst *inst);
+int vpu_notify_eos(struct vpu_inst *inst);
+int vpu_notify_source_change(struct vpu_inst *inst);
+int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
+void vpu_vb2_buffers_return(struct vpu_inst *inst,
+		unsigned int type, enum vb2_buffer_state state);
+int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
+
+dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
+unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
+static inline struct vpu_format *vpu_get_format(struct vpu_inst *inst, u32 type)
+{
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return &inst->out_format;
+	else
+		return &inst->cap_format;
+}
+
+static inline char *vpu_type_name(u32 type)
+{
+	return V4L2_TYPE_IS_OUTPUT(type) ? "output" : "capture";
+}
+
+static inline int vpu_vb_is_codecconfig(struct vb2_v4l2_buffer *vbuf)
+{
+#ifdef V4L2_BUF_FLAG_CODECCONFIG
+	return (vbuf->flags & V4L2_BUF_FLAG_CODECCONFIG) ? 1 : 0;
+#else
+	return 0;
+#endif
+}
+
+#endif
-- 
2.33.0

