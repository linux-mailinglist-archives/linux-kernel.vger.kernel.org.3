Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B5587795
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiHBHME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiHBHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:11:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AB21E17;
        Tue,  2 Aug 2022 00:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhr1w+2bk8FhRJoukBGz13tRPt99yKnoTDjz+hNd+GPrjtugNa5cpn2NE1dkvwuwx/2pwvvrPzXZMh813ZYV7IjBtJDkDO9wO50fdlVet28DCdSVbZAxYtoDZIZv/iglO04f8JT/YjSJJNr4IkcIcIvdtO03rfzZbnF2r66CfLAZWBu4O9KDZzjn9qKyHbvP1o/XI3Wl+wAkQjpH/tq/FPNa3WJp0pS5u5qwwuM2eF0WZyXiwX6ReaM8hrtM7IixCs5D2C4xGpvZ7KFpcgof+Si4DFTT5clq4/M/iJlGStbKUvq1wgU61IWZND8VhoKj1ffytSfkryEuaNpJqV6D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6CfC8qK5KHiAqGJD7X8iI/+pRhZkzafg65odsgCneo=;
 b=KJPToPDgpzhT4lQy7eguSaG84+IvgpLm2Byvg5vcEA9XdnQqyI3BkyUpyNiwmUmiuX1x1JK1bxQfWZ4qhJOdy180i2IhKg5yzvR3OeWt90Jd9SYwgkLfjv1hUAw2dThz5HvGYMwvqctB90sUGSMoD4k0sMw/XcvzI+2N5ef+s5YgmKQDsiYLhQc/sqTa7LxJp5EtZwe4aqgRKapRefnBNSp9R4mSgGPjhi79Z152rrp1NcfXq4lbzQ+OMUE40CoAmiEJFjhDFp7HI17anMyOTMU5SNFvtE+SE/Xbfu++KIt+CxvGxL5M0vj6e5LNt4zJMtaA7RjJm2KzHjSstV6Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6CfC8qK5KHiAqGJD7X8iI/+pRhZkzafg65odsgCneo=;
 b=d2xQHvQf0mhsDMGNccqSf8X82oj+59NSMne9ZuV0S/VXmbFMTq2MAgcG01JNb347ULRlDYo/Zf7XNFahPU8C2xoUQecA6sBJZHCRVrcC0aP3O4G3KOPnrGnFsWLU+ACEaOBUhWyI6RjEcSZFjGwm5PE0u63gecmrJYz813XpDgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4719.eurprd04.prod.outlook.com (2603:10a6:803:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 07:11:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:11:56 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
Subject: [PATCH 1/3] drivers: bus: simple-pm-bus: Populate simple MFD child devices
Date:   Tue,  2 Aug 2022 15:13:08 +0800
Message-Id: <20220802071310.2650864-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802071310.2650864-1-victor.liu@nxp.com>
References: <20220802071310.2650864-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb6ef2e2-602e-498a-5fa8-08da745648d9
X-MS-TrafficTypeDiagnostic: VI1PR04MB4719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhzZr0effVryjGB2kE8lrkuKWoZkQJtXgy1Pu1HtHslvEE/2K0iG+Lc6R3Cm+UTXGHRk64JsHTN2VGJNCO4oZ7V6/fykdFceWpRtJAEF3/egij+sCV9l/MQZux0E/j6xlZ1s3iGs7+OgRaK52f25janWVOwh4CEO9Q1l1j6YzZz3LcsWs7mDgtC+qBtmQ+YZc5x4bo6uTaCPvDu1Hzb1kk671zLrs99rOBKdqRDjcDtr5vyRD8U5cybxE1Bl+gkS+aQ1Y2mHyahw0OxNP1OhwYwnO3i9iuPednCE9WS64Rv/y1F9Vy3+tHRXzTpKQxBnWEoUUa18rMKtjh3015ArSmCOOzXyf02c50nQ9rDph3vy+AiDARXooFuMDE9rYHAmTtz7OSwxQGrygQEZuElxMMz5vVIrbMFNI1T6heudrYQOj0llNJcIbEuHn0IectX1YdCg9h/lHYtu6EUpMEoOxj3U6fQtcG1+a+tJ0GAinUiRxsMPFrwBWzd+j1GJGq9Co10HJennq2wVsbnTgCA8yW4WvQlDDyf92cQeId6hEJpIQf3b9ozA+L+63WZaxNpc6rl6gZmHtXwCK18LrRxEwi1iYEMNq8g8B4cDJECRFIS7wLwxWVq2NB1EfHcXHCKlLCj5B6hDb/QllN4ky+WEiz0ech47HcK7lvpJwOBjOsf5sokFy1gmwFB0aTnsa+aB36twELEMmomF7Wt/OVz/y5/l9NfbZXefk7wAlOTPLuskE4uO46SzOG3gE+MBnpIThJeaJAuBAlAuir5Tt3dSchjmis/bDGIR3GHxyu1fHYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(2616005)(66476007)(6512007)(8676002)(66556008)(4326008)(5660300002)(1076003)(6506007)(6486002)(7416002)(86362001)(66946007)(478600001)(36756003)(52116002)(186003)(38350700002)(83380400001)(316002)(38100700002)(26005)(6666004)(2906002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FkK/izLFbSdacPyhqNXYhWel1fkbVrxDk4/awHTvchz/7k31rGTXf/ZIlDFA?=
 =?us-ascii?Q?92RZXfKow7PUn8NkitdLJyw2WV8NNDNZZmWkJaBiLqbnGzSUn+cEcdc85Y85?=
 =?us-ascii?Q?X+6yjSUUBUTyFSMXF6gEDpQc2/mDGUqZhOonnYisRuR5YYg7ZZVpk4WO/6Hm?=
 =?us-ascii?Q?5SxivWcyQcrE3Y7bUmqVPuSbH3cY0MjH2FL5uHNg4ZZKslOyD5eiUrUbYyax?=
 =?us-ascii?Q?EpJ2pRQa6MSRdcIPzoRN2ASfr65vtYQ1TYPkWD0/LFxjwgOhhzzHj0DhckXD?=
 =?us-ascii?Q?4f8D2S0kzI6tsL7HZDCQovFiy7R6KUw6l9AVqo7kWVr7tcSiPrI5HBCcrx1e?=
 =?us-ascii?Q?x3yIkDNedqn0bmPTXFaVciGsW7vXrbICyKUiPPKdxaFE3CBhMYLxjntpArRa?=
 =?us-ascii?Q?aNghxrNVpjoY24vaTwaMzs15AZ/H6TSWX0Ef8OrkNJsNdJ+RM3lFrgMnrYPj?=
 =?us-ascii?Q?RTX0bgleL820OP6Jh9mY0SM6RZaRJP4vtPIue+bDZ4ss9BRDMSwzXEtjTDJD?=
 =?us-ascii?Q?K5Uz8ZDs0EOlUBSDNUL/Kodn3dU7/OFrEUdvnphvQ9RffM/DltPHnWpvTx6i?=
 =?us-ascii?Q?C1FDcyGtZMUAhF57zuniToLx4sdfvusFQedcLf9Ub69zI1qunJq/ZTLD/NvA?=
 =?us-ascii?Q?sf0oAHLtfikBuJn/nOO+lG3WC3PfEToAbpSzawp0Q+syXpfIcmANDsNMtM88?=
 =?us-ascii?Q?ajYSiBQT6d2sDGNQG1r4vrsoWAJGCt/EhnBFiCwTQHRGulILsgRjNcVLXqYF?=
 =?us-ascii?Q?MjHpOLXP/fvpC9OrvLqRLK8tWgeDo54jrJ5qJoTRZhiVbo7QBpLckyO/fN8e?=
 =?us-ascii?Q?1sm56Pl0mt7qxHLRT/uTzxFcjOLIe5OhXJrB0MXWAEU52gMSQ/ED90hFpsqq?=
 =?us-ascii?Q?cC53oUTnDz29aJlMJ4wBzraGjXgifYPbbsBqqIO5WRKEqiL0w4Y8sBnKy6az?=
 =?us-ascii?Q?qTDTBH47M4xzbJcoKVEmdhNV7+EeQQTVvjMW1+3BVRJjfEOylqo5oQBrSiHw?=
 =?us-ascii?Q?WExGy+nUolles+fzdr80YsINYsSv7jEv1ttD1u04sJTG4pC2J/iZYjgao/ZM?=
 =?us-ascii?Q?oqG4pkUkQcqBzk3mgjYIL64gPHvVLOSt/qQy+19gzV6cEk2fJbwtTV3BDt7s?=
 =?us-ascii?Q?V7NpCbu090rkvzJbB4qa1+Mz4caG7L7UNZIJlqz9z2crzAab5QRhIKAsTYmq?=
 =?us-ascii?Q?Zg8aSF6X8ICaB3Fhr67IUtMjyrZ3xbi9sH9dr2KFs/0Q40x5duHxRFD9PTtt?=
 =?us-ascii?Q?R5gmQDnli08fqct1acrYVERXtA5w1WTXgGtwvro8tn1VKMU0p+LO/XySjw3K?=
 =?us-ascii?Q?dA0PNVbFvjTQG356zWc/SBY84UAlq2LyTtZf1/IMPnSkTjMksHBq8PRcFats?=
 =?us-ascii?Q?77yT3qLXJhoqEar0PMaT5fgmYvV5UeetjeACOKS3a7qVhQkrTQbfOkPOPy5N?=
 =?us-ascii?Q?qY+eRvWir39Db/jRZk1tF0EW9uPQCnNO0TOD34qdhqB70NhQapn5CgN058N2?=
 =?us-ascii?Q?v3rvHyjO4Kgwz2CzFl03cZXviFJh6KLzj8cpE0B3dBqj85N8T65eX9smpocH?=
 =?us-ascii?Q?xj1VIdJMUnsHw/tUmAKUaRGYNHzEPqqORSmcQ2xZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6ef2e2-602e-498a-5fa8-08da745648d9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:11:56.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7rJtj1ChKByfTgv/dY3yV/Y+WQXkKRFAI+i7heCbQNGq1ujOAYZP2M5h4sbd18Fa0BY66Uh+NX7k3IR9bYOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be simple MFD device(s) connected to a simple PM bus as child
node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child match
table as an argument to of_platform_populate() function call to specify
the simple MFD devices so that they can be populated.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/bus/simple-pm-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..ff5f8ca5c024 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -13,6 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+static const struct of_device_id simple_pm_bus_child_matches[] = {
+	{ .compatible = "simple-mfd", },
+	{}
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
@@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (np)
-		of_platform_populate(np, NULL, lookup, &pdev->dev);
+		of_platform_populate(np, simple_pm_bus_child_matches, lookup, &pdev->dev);
 
 	return 0;
 }
-- 
2.25.1

