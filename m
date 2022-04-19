Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E537B506664
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349707AbiDSH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349653AbiDSH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:57:22 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10041.outbound.protection.outlook.com [40.107.1.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2232ED2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntaR8ScBCpBcMDuZGbmBB8urFkotXlBoV2jvdSDONO0prtwBR/kJqgpIK9smUnFcNS620unUE0Yyn+ucoGmSilNHw9syEN0Kcon31XvI1LxtYl5ZW3ejaZHjxI42BPWYd4wp7nMoeS0+7+d/tCA3z2Ts/pWbX+I1IVQyL3Ob9AHLZKUgInRgu24q+aStAcvZQH8IOKMgN49E61tcYwBH272dx+3j9HfNiag/vxqnZXzZsMo/6aI0kXrn9oSRjN3weUL+hI3aceyfYyTj1QVqGP8vB40AbdCiHu8RxziZqD6vghcUa5TAesnRKcDRiiClK/KXGERk1cWx6STgYm83BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46tFRZVyPSFnaNNBt79jpaTI59gUs9AOZn1Bm1ji2F0=;
 b=H5lRN7/2cl38uiDakNNYn8BuhYaMTBorX79VBWmVtYqvq4sf0kD0ERP+V1vRbceNI2fRJ6MDimqXWrDY/1wRt1zQLy7OsdP/GvoAe6T9S/7L8/P6ZyN/7cyaiZM/pLIkOVmDZh/WctX8fqy8/uRjMWIWN9O6WrpsJgGotQBgdx8Q/eTh3eTR42DnzHWliN2viHcHVTMShAyYMisAMGxEZXblG1q6ZPN3rTnY0MNsj2MnXpO4OibQsWus2OQXe1LopsHzl9f0/gO8EMcHMxMtLGNvMujYRQBZSuOMdkGyVcU8UxB8q1as0UDr23XKqsGcGjy4frh024xe4k4l4BVITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46tFRZVyPSFnaNNBt79jpaTI59gUs9AOZn1Bm1ji2F0=;
 b=HeYUzLZcz/LkRoBw0ky+l/NQEaLnxNgWEY/tFzLNdtWTfTWYjjSYrU2TOb5v5dm3Hueuj6DitJOLZifEx0FwgJbb/DqUehVI+dgqrMn+3zpOSVMeA/IIjp7W4HQTcjwxqxTqU3VBXG97AjiaPpM+6f8J6XCJvR0gL+Rz7uW4C/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by VI1PR04MB5952.eurprd04.prod.outlook.com (2603:10a6:803:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:54:37 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:54:37 +0000
From:   Li Jun <jun.li@nxp.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
Subject: [PATCH v2 2/2] extcon: ptn5150: Add usb role class support
Date:   Tue, 19 Apr 2022 15:43:22 +0800
Message-Id: <1650354202-10445-2-git-send-email-jun.li@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
References: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To VI1PR04MB4333.eurprd04.prod.outlook.com
 (2603:10a6:803:49::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc0a2d8-bfc8-40a7-4ca5-08da21d9da12
X-MS-TrafficTypeDiagnostic: VI1PR04MB5952:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB59523A45831A8243515C72A689F29@VI1PR04MB5952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0k9Tle3R+9926QF8Qj2S4nRsHP3tOm/pboCiiTRSWMTzoENhz6CITUC24AulUvtK1i99A4BMXJ72If3J6zB2t86X4RV16CYMMzTF6jwkmidNAdQWdV4Lk37NqDPKSOy0KugzV4eIBOYcm3IuM2USxvR6Qp4XvstWY5cJ3gZKZy9B201bNAxXL0encEnCT2BZ75gt+6pvz6QA2BLX+C79RaqJ7PDinTd5/vzpl/3+iVWi+6eXlkEujds9nawo2WpsbE9pLEXLLeSWaKApGvnlYLljSRnOqASynKrc667HukXwCa8QzdIakfnJ+wCbBg9VElWuulcksba6KbJWX8wHoHFYt/HY7f3Q4qdF39dsry9nxq54l6fasFmwwJOgpAJ1j3Zm8R3XKHr68Y4MS8Bp7qASh6hpRK0Vw9MCsdGrsvN4rLOlm8ragrjdmxjixtav+2aQoD/Jsiw1owWBim5U+wn4VFPbR7PWBNEtaS3dUqqkRtgnUQqZSR6CwsnHpdq0SWQGUWAK6K2rKy2ol5aVqu/Q9QUs9BoO+v43UEj5B0lPnpXyiy5eeykwIMl3Tj6e7V8Pfh1RSIvf26OzjmgTSZOLsFVVykyi76njshG5KD7cbccDY8TE9B5b3ItudwOWV3lRHWTmbft1DKB0Vu0stV1yiVLFwQjTlcawe51RiJ5bmLPcBwAd+EFS777OBbNIlkJirKq6nyhzwKOeeYLzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38350700002)(5660300002)(4326008)(83380400001)(2906002)(6512007)(6486002)(6666004)(52116002)(36756003)(508600001)(26005)(8676002)(186003)(38100700002)(66556008)(316002)(66476007)(86362001)(66946007)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULLiHCB6ILgv2m0mgime3buxrVcDndnscHBwRi5Qhjle8OrzZhlGXb5vzHAg?=
 =?us-ascii?Q?cUclMmdNMjy02Sf2AA1jnyQUue+RQdO1+yi+PT6HRZnujwVEgJFyGdmR+C3s?=
 =?us-ascii?Q?DDjYXh1DbLpChrSemf/3Y0u+gjjl09uY2utac+Vkboghq/p0ZV6h4A0Gr/YV?=
 =?us-ascii?Q?cAq9JxxlXb7vDngsGXUWkN3NyFc57mb+Sd5xweQ2bmsd6DwUGv9fCalhtCFP?=
 =?us-ascii?Q?RM/pnmNZL+rELVPkiXYPscPuLTmkB4bQ1U+CyUpVUVdQdS8IkQjFIDDRpzAZ?=
 =?us-ascii?Q?dVe3OBAPqroNJmHxp6OAydSKIADLs4hZCk3SlJycCouMLrytdOQV5z+Pz8Yu?=
 =?us-ascii?Q?UpicSZShbyhaORz+pw5HQJCsVHhCLHi8PGb3r5m4Qu7RJmSUDK4yqtEuChfg?=
 =?us-ascii?Q?TL5QBXheDrb9lXMiN4CgoUbWk+NnpYIdC5exrVXomo9FNzx+ipA4JyJd6M/8?=
 =?us-ascii?Q?wgslWRp22eT+5WqIxo8VcOpO38OAFIgLVgP/ycvE/ti9l8ahiUVd3/svJ27t?=
 =?us-ascii?Q?nnRLrUG8+pzfDLkXC4A6wzAKNBgJU3PYZSZ0T9Saf9raPqGzFX7hd+QBP4hv?=
 =?us-ascii?Q?87uebhpk7zZxFxEnbW4aTNKlvvKLEO2SMROQaRzRUBv/A7QNZY4pnV+koMNR?=
 =?us-ascii?Q?uF34hM4AHYaHcoyN2MtO22MvZllblSmy2zGdTb8vBozWpXpVZZz48pRQPJFP?=
 =?us-ascii?Q?5Em8654Sfw2pYho6Rmy3nVxM4lpidZEx6Ew5qcIP8zJmNFB+v5Yz68IePYC1?=
 =?us-ascii?Q?egYpY8AZNii4I39TJGEnqsEZj/x2SlegHzsJvj6iIrgOtJNfZmJ/Y5aZbBJD?=
 =?us-ascii?Q?o/NxbqpvuQWn2wcUpfSSf83JD4BFL3cTqB3+N6GifRn2YgmWyoHhsesH3ebf?=
 =?us-ascii?Q?b3ZItPtzmttv0V6+LEapfsU5VIXcT/A2OzjyhPo/bdFzhJ7XaGFZmHk1hela?=
 =?us-ascii?Q?TycMncO5LgOPpYDHgrwuyQ23xT88AhsNKbHxkERFOz2sA02WlRcVYVa+NRje?=
 =?us-ascii?Q?KE1e6xIvh50cmtKd+v3goP+4zYg0NSBARAy9o++vTRIYUlX52t7sJuDaZOUK?=
 =?us-ascii?Q?5uX0sBP1Ywn0OX/omGLxNpjnHYhE7tqN+3v8ZTLIyP/1N9IcmoJ2j5Jr1tXe?=
 =?us-ascii?Q?79ZrrrbKoTXTOkW4qJojG+vNl4fVprNpkEgHed3muwwsD7LtF/1gOMGKp5W5?=
 =?us-ascii?Q?BuOXfEvH0fyI0O4x7gtGk9T+DrTZ/SrA0sotrWkNkGnh64C5gF4e4p3pN6sE?=
 =?us-ascii?Q?iOT8ciLSCsubIIDSRtMwCdkWWvg2nyhSLCgyjVnlMCmDW7gmO9G5jeajvWem?=
 =?us-ascii?Q?9KfB11FGBkupsL7+B+X25aUwucSFgA8mgzyG2ASIa+7+blKfIF7swKwGWz05?=
 =?us-ascii?Q?Lx2xBOehql7e6IkvQQdO/Q16S5TkCXD+yBk8DQtyzuHXZbN/mD9BKl2xOwPk?=
 =?us-ascii?Q?TMdUXn/NrnyUm4ndFZIke49QOEtPltY4Y+XkNJ9zVsobTEgDDPIueqer7XB+?=
 =?us-ascii?Q?wJO7gtgLZzHfcoym5+RPEs6k8Vo33+GdL0BvWS+3uADlrL+gtH/9b3X1Y7NL?=
 =?us-ascii?Q?3Q0y5NjWo6Dk0TTgviazGmpV7RiV7yaW75I1oXIcYQR1fg7oxg9HX3yNHUdP?=
 =?us-ascii?Q?cXFUHO2LuACEJgTOAy7MMrGH05IZCdNdfAuXNbMffxEcB7hjj9SPMZBWB7qN?=
 =?us-ascii?Q?Eh5sOrWvNiUgY1PSomGJM2xfMD9Z3GPlFriejur8Z+LBpRl+1ikGLR4paZWo?=
 =?us-ascii?Q?uYC0ecNC/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc0a2d8-bfc8-40a7-4ca5-08da21d9da12
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 07:54:37.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gy61AYqvv+jW+xI0NDt55NEFfMSSXwqgYvBqCXr3lGRC27U+0mCbPwh98j8dfp8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some usb controller drivers may not support extcon but use
usb role class as it's the preferred approach, so to support
usb dual role switch with usb role class, add usb role class
consumer support.

Signed-off-by: Li Jun <jun.li@nxp.com>
---
change for v2:
- Add one patch to sync queue work before driver remove.
- improve git commit log
- use a variable of usb_role to set target role in
  ptn5150_check_state() to simplify code.
- use dev_err_probe for usb_role_switch_get() return value.

 drivers/extcon/Kconfig          |  1 +
 drivers/extcon/extcon-ptn5150.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index c69d40ae5619..f3352a81ee7c 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -130,6 +130,7 @@ config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
 	depends on I2C && (GPIOLIB || COMPILE_TEST)
 	select REGMAP_I2C
+	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral and USB host
 	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 2a7874108df8..017a07197f38 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/extcon-provider.h>
 #include <linux/gpio/consumer.h>
+#include <linux/usb/role.h>
 
 /* PTN5150 registers */
 #define PTN5150_REG_DEVICE_ID			0x01
@@ -52,6 +53,7 @@ struct ptn5150_info {
 	int irq;
 	struct work_struct irq_work;
 	struct mutex mutex;
+	struct usb_role_switch *role_sw;
 };
 
 /* List of detectable cables */
@@ -70,6 +72,7 @@ static const struct regmap_config ptn5150_regmap_config = {
 static void ptn5150_check_state(struct ptn5150_info *info)
 {
 	unsigned int port_status, reg_data, vbus;
+	enum usb_role usb_role = USB_ROLE_NONE;
 	int ret;
 
 	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
@@ -85,6 +88,7 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, false);
 		gpiod_set_value_cansleep(info->vbus_gpiod, 0);
 		extcon_set_state_sync(info->edev, EXTCON_USB, true);
+		usb_role = USB_ROLE_DEVICE;
 		break;
 	case PTN5150_UFP_ATTACHED:
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
@@ -95,10 +99,18 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 			gpiod_set_value_cansleep(info->vbus_gpiod, 1);
 
 		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
+		usb_role = USB_ROLE_HOST;
 		break;
 	default:
 		break;
 	}
+
+	if (usb_role) {
+		ret = usb_role_switch_set_role(info->role_sw, usb_role);
+		if (ret)
+			dev_err(info->dev, "failed to set %s role: %d\n",
+				usb_role_string(usb_role), ret);
+	}
 }
 
 static void ptn5150_irq_work(struct work_struct *work)
@@ -133,6 +145,13 @@ static void ptn5150_irq_work(struct work_struct *work)
 			extcon_set_state_sync(info->edev,
 					EXTCON_USB, false);
 			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
+
+			ret = usb_role_switch_set_role(info->role_sw,
+						       USB_ROLE_NONE);
+			if (ret)
+				dev_err(info->dev,
+					"failed to set none role: %d\n",
+					ret);
 		}
 	}
 
@@ -199,6 +218,7 @@ static void ptn5150_work_sync_and_put(void *data)
 	struct ptn5150_info *info = data;
 
 	cancel_work_sync(&info->irq_work);
+	usb_role_switch_put(info->role_sw);
 }
 
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
@@ -291,6 +311,11 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	info->role_sw = usb_role_switch_get(info->dev);
+	if (IS_ERR(info->role_sw))
+		return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
+				     "failed to get role switch\n");
+
 	ret = devm_add_action_or_reset(dev, ptn5150_work_sync_and_put, info);
 	if (ret)
 		return ret;
-- 
2.25.1

