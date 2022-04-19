Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8832A506CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiDSM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDSM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:58:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE02B183
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJBLoUkqxqWw5K9wBgQfuDWovW4Ku+8DC0TYyfO6i6RdKSpFMx19XherwK6n/SBlXEvlZwzN+toL47RMEV9O3AMaIw5jlCgfmxlOles7825NWLjUM7/cLL8x4VO7ll24tq9OiVcat9Q0ZrSdkSjorQ1C6BSMQL0p9ruTfGXUli72MEWAfj1XpqOP7yyfrC8ZxTn/6u5WHvslmtwc5kTg1462ij5Fv3lEqvsF/00o4hYX2I6SW+hW/syHQu5CYt3t3eSjJ6Y7FWv8IdSxIqWkETdnM3lgF2kD9L5RgV4E3rXIUyRP3NPw6dAGR5SdiBQq2QPiXmqW+AvwNZKyXLYRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEA5YWkBPd/nP1uElPs+buvgP96YOQF+9pwcPCJ6qWM=;
 b=TQafPljp/T+iN43Ht07Ik/RtyitUq1tb9uBPI0bhF5Tbl6i4IUEhMDJCzBDlieRvKPg2WmKzQB3aBzDAtPNSScVH5XMozuiotSVNHohs5b7dD0SYk5SZJoafc2H+NgovY+AuaPugZFURGjTB9S2puqN0gEWp0jIPi/3kL7q7Ge3vxOLXq6sjsfl2xsEfWpd1NrYCEp6kiOxoalk+mbHIYiXKoE2UfQuTdqcAqshbzA7waPEeykPq1bDE3QXzaAUpheC683/0eQGknuKUewbcchgAi2TG0PpswKRRRXexNJ4DpUOPnccQi2nFVrEuE/XmyTaabtUAhAk7ROdK/aemxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEA5YWkBPd/nP1uElPs+buvgP96YOQF+9pwcPCJ6qWM=;
 b=PWo7RQm2cGeOqH14EeCtFl5G1z66AhtoWCGm7XM5Eowm9kUOP35YzupH5+IrwVd65tfcbDrNVSFxaQaBWNGE7yaK4mmYr8UrgutSKEnZ+AmkBmJXXhEfVIwj+FBn7cYai8V6+RVwHpTXDQbAowCEGR9SpoZwrTLmLvYrndJmVo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by AM6PR04MB5624.eurprd04.prod.outlook.com (2603:10a6:20b:a1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:55:25 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 12:55:25 +0000
From:   Li Jun <jun.li@nxp.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
Subject: [PATCH v3 2/2] extcon: ptn5150: Add usb role class support
Date:   Tue, 19 Apr 2022 20:44:09 +0800
Message-Id: <1650372249-10787-2-git-send-email-jun.li@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
References: <1650372249-10787-1-git-send-email-jun.li@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613fa3a2-615d-4b96-3ef8-08da2203df2e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5624:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5624FD400A02DA3BFD46BC8E89F29@AM6PR04MB5624.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eRwcWMw9IRtZ+LGCAsm/mDphU8cWC2zW1MC9mfK2O6W5u3VND0omBC43XKPMrpmbVbX9WBL0oBVmdldfnr8Q+SDQz+8PTGqKVBUVUa16OfwEJ4rY7K/BtOUf9Tfk54Fa0GnETbDZ0OpBbE/5QvJpmPsRImcd6Epjbtbw6EIxcDWuWHo4VQu2b3ppIHYxq4Nhnz9VZPc0UxagB0S7OK0X4f3yPRz7eDaq7k8JQBmrE8GbdhEwf9VPlcVdU2esJ/jXE4pSWvME6/PCAdSAyGopeJtH+wgWD2oogbXOQ3CTp8mgfuluUbzSkKe1wTn/796kAcSKaxs47n7t6lpe2eW5tgslub/wjVDtCJ8Jizuc6TQpWrG6A5UYAElH06XjDRzOFJBgSHlbahTbSHG+AIHCPVVQNjn0DCfzfS21/QvUtbPJhErrta4S48YiOdnE0ffqhfCVz8vKB1a7AB84QsCrgXKkv5AMW2/w9UPwXBMFfAD366v5hRWjGzr7QxMP8pL3oidBkIoflgW9rMjLDhXo4iSpFT7sQkUnjQOQGeZtPPYzsoeLUIalwWLLgczbS6yOfhShnCdasBaZjk0vcbBfB30UHrutLEwXlHQ8f6t/PKE6DVyTCUCRQ0vrJzc2ykcJWTorqpFIyR2DG4VTMeqrdFbMOsBYfXBKO0jh6lqVjyx1ivVlkH4nW+dUKztOoGiQKZSTc75ODF6rWWZt2u6ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(8936002)(2906002)(4326008)(508600001)(8676002)(5660300002)(83380400001)(66476007)(66946007)(66556008)(6486002)(6506007)(26005)(52116002)(86362001)(316002)(36756003)(38350700002)(38100700002)(186003)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epN/bxXazQBPQu8WPn2cK2/fgqFipuXBU29zUf+yRkMh1oAU5Xn7urt7n4wd?=
 =?us-ascii?Q?3ZTW3AI7OWf5c/Cp0q1OocLeZKGvTAGeoBur0r8PVHSXD7quUiEX30tBzahi?=
 =?us-ascii?Q?PWAYjdPAShVpwTwmrTCP9wF+p+Errs/36npp08t4DxdJiN+0IT4nC8bi4aWU?=
 =?us-ascii?Q?5l614gnJ6EYlPdBj4Nv643KiGPl8DZ738cEZJ4q/rprxJeJWXrTHf7THqUzZ?=
 =?us-ascii?Q?jbXyLPiF21ia0Lq1yJ4zUsI79zuGvf66Fy2ZjIDI7leJVXMNbcWxKmYsgj8x?=
 =?us-ascii?Q?tqByvfZ3FdLL4R9YbJVPSrBGSahXQxZpfjDMPrJT1N2R1PIeW9c1dGHLX4zo?=
 =?us-ascii?Q?ONc3kAemnT/SZ7IY4nxuMHlpDV1AJpWfzB5AyJi9k4ipb4PPKIiNIs95U14o?=
 =?us-ascii?Q?gznX3n2RUK2001RNZhJaODdx59tp7sdcUEntUmvPMEBteT9jzL6C56Z5ilDi?=
 =?us-ascii?Q?ffBy52qzAsQESSD7Uyqq7Jt7LzJfwmtXlHmduSC0Esf6/Tvl5QbBrll9IqTx?=
 =?us-ascii?Q?NmC3MwOjfLbNBexOFbqLOmRUvvMzJGRRhkoMnc0ZzIDkBApwEqljScdfSKWp?=
 =?us-ascii?Q?8ZPfoSsxUEIklIw5caynKu+MsTcd+3fUZy305L6INJe9q8J7XfbmAFq/H5Pj?=
 =?us-ascii?Q?sis14+84yRyfA4ImgfOhk61xnncPQ+ndjR0HoAaeaqYPH6DrOCEUKUJxrUGE?=
 =?us-ascii?Q?Px7wRXr05L9tdHc669p1gV3UZ99h0Cvx8Hmarwhj8tRn/0mFiNXeRI1XYpG9?=
 =?us-ascii?Q?0Ueb01Ja7S/Zzkgtf41o6U+BY7yr+T1puJhFY4XjV/xLUca5XF+x/MA3LJsv?=
 =?us-ascii?Q?hqMPd+rVeRK3CoiAb7rL4Jekbf2i+7DqwPOwTkR2RcJ5Qr7p9d6zozbj4okg?=
 =?us-ascii?Q?e/NA1GTnSFX6KiRjW+QC0xLVHx0KGhLOqE3xwMKqY3nwP8xT36spePQJe2Wv?=
 =?us-ascii?Q?YwUK6EPk9MH4bKDwCNz9K+7uqhLfQjPp9dphtOnmNCx5Dqxld7/y2ljgSelj?=
 =?us-ascii?Q?ovCUxDGYe9EMB72nQGenI7PwE6a5qPln+12bCr8CZ6SJ2AyI0T7+JLxf724z?=
 =?us-ascii?Q?YyBL6ne6jV8yNTavJYFMgd4+0k21JnOqBufCaUkquCE2bDUT9uDh62CFL0OG?=
 =?us-ascii?Q?XZM43wPi+J+QrUJUhctE3fIKZcv7iEDA0qMTZ9gHEw9jEXJG/dkc9Q0lIaDg?=
 =?us-ascii?Q?TKxUFBWv0PTXxRhTKK1ON4ZC0+CFbOsvCrAI1LG+w48JBrhO37EfBkG7v/vw?=
 =?us-ascii?Q?ByojyzdSJD7Jtmyqa0TSkBDlOltsULSiAefFg9HX98vULjPaCtYA9ez6JkI4?=
 =?us-ascii?Q?TspDwzA1ryjQEI9HW3gf3l0YIZPEP0ZRgaBAh7c9bczeSn6amUyWDjDVGcSn?=
 =?us-ascii?Q?wbi2EMIqy28gec860q5CLEBn9xrxAlUnDuTdeDOpRkDbeilzMMAh++Zs6s22?=
 =?us-ascii?Q?QBEjpxYN6eYENMk6XeOw8CHaPFvLSidzH3m8TRosovKUT7CKEUIcg6Do7lgM?=
 =?us-ascii?Q?oqAwhBCBihxzNlzvojgNUyUoiJKh5r2dfeP2kVHN+6FQhONsYNt683qZVFsS?=
 =?us-ascii?Q?GErO3xuecQy0AJTBEmV2qnGUkDpOVK9ocDWIAM+Uk15De8zGelRpT206Y8FJ?=
 =?us-ascii?Q?4h7i0U1C17pd7OfTYW5+J09rMwsSeEyELiN2YdWYjoejefyyFvMAipdkZHrE?=
 =?us-ascii?Q?WKbdXeDMvyooAt+cjuUFKb7ABaMXnz4Vpxl5MQMfuIpXnnhJh9IEGMTaTSNW?=
 =?us-ascii?Q?RpWKbVVg8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613fa3a2-615d-4b96-3ef8-08da2203df2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 12:55:25.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7lK1EmjvPxGj9esK5nILaOcUZBFuyEKWCaFeCIZGSLjbhV9FSD6M97aXqicV1Wm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5624
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
Change for v3:
- Use 'depends on' intead of select USB_ROLE_SWITCH in Kconfig.

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
index 88a8b3d7d78a..dca7cecb37e3 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -131,6 +131,7 @@ config EXTCON_PALMAS
 config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
 	depends on I2C && (GPIOLIB || COMPILE_TEST)
+	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host
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

