Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218055B641
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiF0Enp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0Enm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:43:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2135.outbound.protection.outlook.com [40.107.244.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8312185;
        Sun, 26 Jun 2022 21:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg+GaX0/o5Pv/+sdt9k9nmFks3ulUKcMyfMbA8gfDCcVvto+SOJeuEUBsbdjbApUDgBqm9ej0StNrizWFTLXd4YMixXFa8dpCwZ0jozDw/DPcbufuQUINhN44Hxg+Y4D+OqG3DJve8q8nMv3wMSRppTmnhpBSyhtmCghmHR6nEv0y1TNqxEfpTgNid4bnGRtC5w3y0bGGPIWEUo3DpCOIWE0lIaPNTVlbXxUSPHFXUq13I/c4YmVJGts3lXYsTCU9K+pjuQ51tAeg/xtgOPvlga687G7k//bYVy7B31Pmb3/AuyvngkdZ6j660RyYGQ44VVM5cgKcp35bWu/AN+J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNx1TNd02XU5nWbvCJwS79wPQDHEkqOQKTYwqrHRfuY=;
 b=ImdVZYglIMvOmNTU6fj87eCRTT6cuf5augAMHctaVVcsccs8tPSx9kJdptvb04BMpNpBqQm3s3+BqrroBkw9H2reKuzDac7seAxwi1y7iktrFdFSfFijO4tJuqsfy81oJF2zhhAw1OmTbbKE57JrXbQWNhgXDtIp+IEopeGMvcjochUf+lLyn8nvrjutXG44QghLrZJCt8MyIJywaWabaPEw6uY6AfV8+ItN515ckTGeyTAFE/QydSjEmBGAWdByFyZOafqx3fuIhxl5d7O8x3neZ8iD0JJmGr0FKDSmi1HTu82fcFODxKiqa9UNDrRM1RyqlcU5Rh5ejYVeJtY//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNx1TNd02XU5nWbvCJwS79wPQDHEkqOQKTYwqrHRfuY=;
 b=rR3Eauz/qmz7bk6zwRs4IzyK0RyOU3HhlvpNZxS8KEBKCP/YPPtH4dydWxTH4lwKjCxY1zSs0VwiOXZedQoUAAFmbCqONVD/EsHmNXXQ/NPI9KwX9Dv6kPQMuHW+7e0e92sknx80VffHJVb+ukrpwyhQITkqyeNdhmFzKx/zQPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by CY4PR04MB0630.namprd04.prod.outlook.com (2603:10b6:903:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 04:43:39 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 04:43:38 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v11 1/3] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Mon, 27 Jun 2022 12:43:29 +0800
Message-Id: <20220627044331.2180641-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::15) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b8c7aa-76b8-4134-3d5b-08da57f79a5c
X-MS-TrafficTypeDiagnostic: CY4PR04MB0630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBYihBaaTfA9p2v2wEbZSbQYyH8gR9eDknx4GEFNMAhPHF1aF2c+SK84Dj7PQr3DtKIS11+ABl+ZrijppYP3uiZzu31n/v0Ca3Fk7GEOzpjRpY2SWZosKlgy68DamPLGlhEko14TiWUMDeyvsL84YdgFnIVgARXPjpktUeCdDAE/uzDJG5bmUz7mOG/pA1Mz4WuM/o1XZXEgrg4n9YI9WYoJJ+BifZq0veDBgkPtc/tssLLUnQBAfA9Bs4LG33IJrrz9supws64LVuMXix3aqGhqXG+5oHx0dI7NhMdYmETLAZjl3jcFHhhiCqfxQIZlOVoijgCb/1YLPF3Tq70VoYe3b+eoZRX7netGUiaTTfTzJp9qgaNIUSATKjCfjr3o1N3Buwk8M1Up9XNJlMLXSF8kyKEwsKGPo4smG6xp/79CIIL9Z+cG6LA7n41uK3rlm4bJ2bYrLbFfykt8dKi5CF05bzg8Cj6Hsarjzn5N/Th0KMQ+5M68B8RbUMWpetPwpMZ92WBhAM4/1H2lFsJtE6bRNjbO5DW20yEyMptYkYm9vR4nHyKKv5ez33Q5V1qNGBWaf9aPQxGcyRaP9gvsGmR7RF1mTG9q/2UU9Tr7Fl6yzh37sOy026PelspKnezPhbSxhHAPpu6YCn9lMpunJbgOsnCbDQEWWN8IWQdotrUPNn9dfqrxDq1U6xQcdjYtvsrWklyAsE83Zph3XRjipLNXOlPAfFb/iQdhoa91aMGsIUfrJGtmDiL13yXhR/fMzNvaMxRhozgBGLazrX69x7DZlG+q0LX7w1ZZf+9gjsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39840400004)(2906002)(478600001)(38100700002)(8936002)(6486002)(36756003)(83380400001)(316002)(6512007)(26005)(66556008)(6506007)(2616005)(38350700002)(41300700001)(186003)(4326008)(66946007)(1076003)(6666004)(66476007)(110136005)(86362001)(5660300002)(8676002)(55236004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NkY1WK8waCZ5ssqEYtHHxdJX+kIiJS3lRWgOEVml/6O8A2KJT18R20ikBT7X?=
 =?us-ascii?Q?Ao7Lm09BOyErkHjkHmHMgY8KbtZMpZ7+JqIlXEKnqcUxvgiBwaOu/IYDI3Bx?=
 =?us-ascii?Q?m4lAa5NzmvaMmDn/pvFQT/v7tKfh/I3iPjaqEY5ZPnEo9RClngiyxnJFbSTW?=
 =?us-ascii?Q?/qqwUm/HI/JZOparZIm1MF+UAuSqCyQaOO0j0huUALzBvRxzRCP/a54a71du?=
 =?us-ascii?Q?moG4aIATIEX/Ynmsr7lqxpKligyskmnuikyvfZCF6f0b00IXD2KC0pj/Sl+M?=
 =?us-ascii?Q?yb63T1XcF6Hz4QqR4WNlfTXeyMCIfi0rqQHFrly3mV4kwYctC2MzU51GD/Jw?=
 =?us-ascii?Q?Yfny3BiHOewLiYXBsoqRCcIAwndqk1B0RYRwgTVZb8q5ztCo7VkjgRO6e/ga?=
 =?us-ascii?Q?GiKL7I0Orlv9kf1poSvLlJSyYYwjZGDdqbBA7Oszm0gVI8rOeg05T/AQPskE?=
 =?us-ascii?Q?DHaPwoa7kg2xt46qXh17Mya5Lw1QdaAdZypBFZILZGs9jJ/zPXPT/71TpG6H?=
 =?us-ascii?Q?32GZFzUFXOhwhdz5SQq1V0doiOVyZPloJdcMlP3yYrlDMPsJv1USlmslxoup?=
 =?us-ascii?Q?bobw6jKoLbKgKn0Gsee/jEJXbdbfi4e3r+8W59TvnZk2D6UgbTkWHnV7OeFl?=
 =?us-ascii?Q?93ycbyNvOh4WVcZOiVRHOl2f8aS+pRPyR6MR4ludul8mQ6u4N7vQuiRtkMZl?=
 =?us-ascii?Q?rjSInNaqcfrKF8LT/0qxmSo7jxQ9OQHJcNxz24+FX4trnyXUOhq8WuYYmFXJ?=
 =?us-ascii?Q?TD93fhAIYbreRP2xM4J9BPd/nz26d8vGq0cXjvO3Ip5HKat+klDy7Y3X3Hji?=
 =?us-ascii?Q?U7bId4QKAz0jhyd+/WB6qI8MPpp9lTvT7ObT+eMLzfxTwa21fJ09C9AjwX9b?=
 =?us-ascii?Q?yScyvAlhNnay4QDEuMqsDC/SlEMWm24kt+RqznNUqafJdp0q9pM4gtZ/czCJ?=
 =?us-ascii?Q?YhDAhhK4crk/3lNBO1nykO/letaJAD5/p3sftb8LxzoXx5tk8gB2Z8T8QYR+?=
 =?us-ascii?Q?qgC27lOtg37VlxVOqg5KDgyO8rwTXFGKbG+jVu93CrCZbTgD0wShFQRuaU7K?=
 =?us-ascii?Q?mZnyJzYyFmpbcQSErRLTRwT+hTsgzeR0BMY71qnoWA4A8kPyI1XkI6vM3Qrv?=
 =?us-ascii?Q?LX/pW1X/5SIaPDzy38z27MT8gCOqHiLsm7tdK9mL8qttmYuqGXUyRYsHgbRM?=
 =?us-ascii?Q?d3SHyQfcTCtIUTpG+kAqabhgizWHSLFdEyOoERf/noUsSbcSPscVHHjNAlP5?=
 =?us-ascii?Q?4lMeWjAWwKX7ansa+UiUs9EnwYZ3/nYCX/eZaz3koi7Aqa77CF2WJ+cfSvzF?=
 =?us-ascii?Q?tMPk2fqSU+vWsoRt68a4+YghQgLM81pEq+cLfXcuC1DWx82Lh0WXd5rFxhml?=
 =?us-ascii?Q?WbVDMK2J9dZijECmLBkMO0sr8xdEig6qZ0TmtndN7ogSQb3CC00PIwgJ8XLl?=
 =?us-ascii?Q?aSZ97FeTd6OMCHXP6EWyeFIVRgjK6NC5t01+bHtcXh7XM4dMGbOVIlaRBBl+?=
 =?us-ascii?Q?C+zhMQNYnk8Tm5aPVqMC0fpmvMqNwhNaWulgKqBIpn1poKAxps9B7rKiyLog?=
 =?us-ascii?Q?UtgC3P6WsDEwJcen1Ca6xQta7V+pJ9lIEAa4eAx5?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b8c7aa-76b8-4134-3d5b-08da57f79a5c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 04:43:38.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue6apeRhRwkA9LWxhS2u6qUVdgDJF2SvXQ9spcwxG6OqF2WA6x8pFg6BNkkGS8kshaK3t6P/UwaZXUrxT/TVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0630
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PD controllers which consisting of a microcontroller (acting as the TCPM)
and a port controller (TCPC) - may require that the driver for the PD
controller accesses directly also the on-chip port controller in some cases.

Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.

Signed-off-by: Xin Ji <xji@analogixsemi.com>

---
V9 -> V10: Rebase on the latest code
V8 -> V9 : Add more commit message
V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
---
 drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
 drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
 {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
 5 files changed, 5 insertions(+), 7 deletions(-)
 rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f33e08eb7670..812784702d53 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -13,11 +13,10 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define	PD_RETRY_COUNT_DEFAULT			3
 #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
 #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index df2505570f07..4b6705f3d7b7 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -11,11 +11,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 8a952eaf9016..1b7c31278ebb 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -11,10 +11,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 
-#include "tcpci.h"
-
 #define MT6360_REG_PHYCTRL1	0x80
 #define MT6360_REG_PHYCTRL3	0x82
 #define MT6360_REG_PHYCTRL7	0x86
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..3291ca4948da 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,9 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
-#include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
similarity index 99%
rename from drivers/usb/typec/tcpm/tcpci.h
rename to include/linux/usb/tcpci.h
index b2edd45f13c6..20c0bedb8ec8 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -9,6 +9,7 @@
 #define __LINUX_USB_TCPCI_H
 
 #include <linux/usb/typec.h>
+#include <linux/usb/tcpm.h>
 
 #define TCPC_VENDOR_ID			0x0
 #define TCPC_PRODUCT_ID			0x2
-- 
2.25.1

