Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371C4F5FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiDFNTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiDFNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:26 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440D43B82A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBRot4lm/9CfnJ3vLX0OsQ2Jup1bcmjl/XBCJqodIHz24FgmKhZQY8ShYXbSTj16VjtiADmA9Yt1Re/j/lmH+qr8lEB/qyJJBKLtyW7HrU8bwwsSWET05ZfvOeV2xhzSIQvbWRkhKAzDKkfIxgdazMjtvMGHO7pW8cfBdnCyPjjHON5AiXpGcX0xrUPpwlsb7D6zZn1CkrxAjYHI85YTh78yQ6SwTxdtGvC/Pgo78B9V1wAkuUB1w5CYCHja3XuQ67fatPmlZd9EjkcnZYcPRo13Tu0Qo6MMrEUtygfEacrL/QsRDV0a+RMjrC9ienGmd0rskv9+7015+ruXgTAp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efwIcjEz0IsCRbZj6ijpxa6ZbM2lhPBAg9gQzGTPpt8=;
 b=SExEHzzQ1u960HeBW/k5qM6jvFOY3WHmQbROY+iMfUAOcb1IyjNEHzIYO1YWense5QquWUoOvax4I7dWlXhC91megbSYjW0uAgDgzXvryJZ6ov/RBicSiRsLAph8Idjrdu/kYRiR/EWgl4NwlJWVYs1uTEAD6ogUhNxC/EJRK4gs7xxorA73cc8daEAhnrprgcf+lYzEnxjk1VHZoR6++ihNkBQauzlBqVMMV8DUsnNppyNGFu4PTcTpMBv8ZtdglDkff57t4/5hv8Gpjsq8QKvWW6ba/HTwDsdZxI+Rju0rx9MOftLCyiQy/ODz7UIEcRp72gr0F9mayS6ItTZ2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efwIcjEz0IsCRbZj6ijpxa6ZbM2lhPBAg9gQzGTPpt8=;
 b=hvN58REdpZyKKRRkE9WdgrnsWHlvFpNlB1LtaE/mGFerMUYxAV69XDGLMBk2qHfUL5eS2O/RcUqxMMHeu+fBbE5A0U9qyJPHovYCJEU8YCxfC9P4z9bAX5Vy1h/4ZTX456DxyaecYmHfGz8ho832+xAUa3lAVx2mGNFebfnt1fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by AM0PR04MB5860.eurprd04.prod.outlook.com (2603:10a6:208:133::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:53:05 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::81be:ee44:be2a:727c]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::81be:ee44:be2a:727c%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:53:05 +0000
From:   Li Jun <jun.li@nxp.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com, krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
Subject: [PATCH] extcon: ptn5150: add usb role class support
Date:   Wed,  6 Apr 2022 17:42:22 +0800
Message-Id: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To VI1PR04MB4333.eurprd04.prod.outlook.com
 (2603:10a6:803:49::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76dacfe4-a770-44a2-20e5-08da17b33f12
X-MS-TrafficTypeDiagnostic: AM0PR04MB5860:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB58602C29E526CE8BABE55A3389E79@AM0PR04MB5860.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H55dtAKbMEmBZJ2ZsdKoVZcHSMMuPnPeGNB5N8b848FUqy4/VjESUhRXxsfOH9nHeA5aXl6zwgEGB+ljVOr7RY3U49IgaBjz4sed3l4UIwqMxYbMojl1Y+ch66+xdhg0FZz3Bt5X+GIKCfpwxHd2DN5jmbWi7YNilnbCsylb9WINXlw5fYxgIg3826GeFTjK90kieC2PX/1jrijGuSiE8B1ZqG8xFKB80xJ/yQcC9hzSZR5pmRV/NKXHdAq7dHR0R4w3beiRX9LFflg0GXK2baRhstU7FYRgpbbiiq9qdddBLO+gdA0IwQq8G7qXz4s1M8EY5c2s8020xAej4GzQZPUId04WRr9SjdhnqCWtnWGT+iEg4cmtKSsFkJ7kbNCUKJXCr2gZQ1yz6CEfQJklPXiWT4cIPKeTrxWjFZv/Upy58Q1LFoJY3oIQxB/06rQwZqUfLU//EPcr2hXdNc+CQ2iGqG9Sstji299vu6bPwsURsVoiXKH8CpZhisrik2AHIz3PUTgxF/7gNr9k/kxxnk/slrCEcQnwIUVg3BlQtKMEXLdHgqTr1xKgqRHrt45jYhTHo0aVvaWy9Wi12R3F2ETxy2CdPLmH645aIPplIzLlb2QXEH36m2Aiboate9qET4AlgxFZtOysvd/09t8f2Is6Axu/GaharoHXNM/2t4o7dMbHi+/QgzlelFNpfXMdlvcAACioSHfYlCfbLNPKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(316002)(8936002)(83380400001)(508600001)(26005)(36756003)(186003)(2616005)(6512007)(38100700002)(86362001)(66476007)(66946007)(2906002)(38350700002)(66556008)(4326008)(8676002)(6666004)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxKF7xhPP0uoSjiRxNge8t7D99gDMKwTXJhEcojdSPODC/7Ely1XS66qdqaC?=
 =?us-ascii?Q?ukZ/tX5+PUq+CGDi6tQniyX/htRVp5l9DdqqC9MNmgAnSJknQo7FkyH78OMN?=
 =?us-ascii?Q?Hq2lHTtu0PTaOxYuoevha1yW8mlx0wkd7Dtj2zqEWRh8NSr33mK6zBEYE2jw?=
 =?us-ascii?Q?IzSbKw53eGL0GL2ebObSv5jiZGSxXZqyXXFbecib1BgEqYWQMmUOIalQpypR?=
 =?us-ascii?Q?l6nUTbzge9ahpKp5IzIXpUzjGHJVt27QPLBR3idNk7Jl4PjGk+EoYiSGqAiU?=
 =?us-ascii?Q?u9LRZG+fLlZufqxkKPKY1ouAlffX3VLZdBuF4UDX4Ur8VLXHuWospdGLpGsL?=
 =?us-ascii?Q?0xt1cci9no3nhLjkazQpoRVloZNlZHg8FJYysWa8b5ICwbI7DE9aHSpSREFx?=
 =?us-ascii?Q?mqTNHDEgjaHiiIEmg5FHzRJj9tq6nYE48NF5lWosvN4i5LOp+/1L3j71KMZw?=
 =?us-ascii?Q?Rb2P+2hYC2FfsEZYktTlGF5XEjIJRPtaTpys3MroGXUgtqeZ56MCXn5eBvFx?=
 =?us-ascii?Q?NUdKZ4p+0gWx+/rRXzxB2jAMFFuouaxpZyd6jvk5MfFuh0hXTaeJqLtTXnHX?=
 =?us-ascii?Q?q6/hOyDtreRb+KlOYjCxlg/CT3b72HxgpqJ13GtTKVdMi7lnSeGIirJf03P0?=
 =?us-ascii?Q?8a151dHw+I/k12F8sPMvFuE3vcVuUyxJk1939AtmJBCNa5smDKu8KAW4f5KG?=
 =?us-ascii?Q?S7d7iDf1N49kLuGJCOIYVSU//VpI6uyGDvo2570BvngZWY3DtY2MhwuJ4SsA?=
 =?us-ascii?Q?ny2wLrmuljtTr14o0WHk97JWmyoYHgpBmTcqhipPjtrnw8gxg17fEVlVC9yb?=
 =?us-ascii?Q?Ci+wuUSfnopggX7XlsU3kmVbviJl8cx3okn6MGQ1M3REDXUj/P0yKw59KFPI?=
 =?us-ascii?Q?he1F88qvXJyEucRI4IjQZEveyuOp+yjgLHahQhEaNv9I1XWKNtFVMEm5gug6?=
 =?us-ascii?Q?p9t+J1aaXaTmdsMR5p/U+z/3bERv6j2DQ27K5+Qpze2gAT0VDDDJBFyVJR1p?=
 =?us-ascii?Q?wYE9heXGfHVSN7uXQKwJEdPb+34WmapAjUcpmRJrh1gS+zEVU8JrF4CEBZFU?=
 =?us-ascii?Q?RmsXMt0x/gJMMZTI/u6n/8iBBNIHG86WBUApFB2Bg8UvOOFt5dsH+2g8rLY8?=
 =?us-ascii?Q?mrxryFdOwqpRiU8uMitNSnsF7Ch46pyEHg103IWJ7Dey9nrzy16rFoVBK6nG?=
 =?us-ascii?Q?ve+XXz0Ei0oTgqFpIgkuu5VgzzhGCgYge+MZ59pwO6mV4QtG0HFsIS0w34JD?=
 =?us-ascii?Q?DEEX9Y+3ac17vVvgIykIuy4mvJ51rwH1ad1KOYLDghEwUYYhAJOIp71tTFMS?=
 =?us-ascii?Q?q4tL6wyh2huKTE04wRzH4egWEg5HYaKDpYHuWx23m3zyHOjZ6zuRIvHqfrUj?=
 =?us-ascii?Q?K90Tp6kkbCwKA4vNXzQyV4HBg2YSoZ6K/X8EgFPK5cIozBdwDXPhSac306fh?=
 =?us-ascii?Q?RjtQmgtNlJbTGOhQr/M0MtRfFap94R/IXc0A78lvdG0hvhZ9jva1hdVnK/VU?=
 =?us-ascii?Q?a3c5sBgwoeFQOQX3QeO6EEngY0QXPnlO7QOjYnZIcAtsdkJ4Z2UHh9FNqEQv?=
 =?us-ascii?Q?Py2+Sb4sWJqnlqOMpbQeZ8HO410Cc+hjMMNIUaH11J9b5bCqQLkdjCVUdRtI?=
 =?us-ascii?Q?uB0vMPYj4Iny9j8KMPtrEGhWmz/i+0uFqfZ9vCgLz+VkAQoEYgp4u0iWEdGU?=
 =?us-ascii?Q?S6f8ODpgUIiK17cJAqvE5GZ03q+7DiUxCgTuugdMif+q5t0TB0FbvM+5T87C?=
 =?us-ascii?Q?6SMZKxQBsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dacfe4-a770-44a2-20e5-08da17b33f12
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:53:05.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDvwgnYwYWqDnIvsNB12vpQ2TdMkjeV7dvIHlfT+wtrDn13pUd5gaPZ+HYkg4xri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of usb role class consumer to do role switch.

Signed-off-by: Li Jun <jun.li@nxp.com>
---
 drivers/extcon/Kconfig          |  1 +
 drivers/extcon/extcon-ptn5150.c | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 0d42e49105dd..9828ade787a8 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -132,6 +132,7 @@ config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
 	depends on I2C && (GPIOLIB || COMPILE_TEST)
 	select REGMAP_I2C
+	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral and USB host
 	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5b9a3cf8df26..821b0f390308 100644
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
@@ -85,6 +87,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, false);
 		gpiod_set_value_cansleep(info->vbus_gpiod, 0);
 		extcon_set_state_sync(info->edev, EXTCON_USB, true);
+
+		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_DEVICE);
+		if (ret)
+			dev_err(info->dev, "failed to set device role: %d\n",
+				ret);
+
 		break;
 	case PTN5150_UFP_ATTACHED:
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
@@ -95,6 +103,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 			gpiod_set_value_cansleep(info->vbus_gpiod, 1);
 
 		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
+
+		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_HOST);
+		if (ret)
+			dev_err(info->dev, "failed to set host role: %d\n",
+				ret);
+
 		break;
 	default:
 		break;
@@ -133,6 +147,13 @@ static void ptn5150_irq_work(struct work_struct *work)
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
 
@@ -194,6 +215,14 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	return 0;
 }
 
+static void ptn5150_put_role_sw(void *data)
+{
+	struct ptn5150_info *info = data;
+
+	cancel_work_sync(&info->irq_work);
+	usb_role_switch_put(info->role_sw);
+}
+
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -284,6 +313,16 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	info->role_sw = usb_role_switch_get(info->dev);
+	if (IS_ERR(info->role_sw))
+		return PTR_ERR(info->role_sw);
+
+	if (info->role_sw) {
+		ret = devm_add_action_or_reset(dev, ptn5150_put_role_sw, info);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Update current extcon state if for example OTG connection was there
 	 * before the probe
-- 
2.25.1

