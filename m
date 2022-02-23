Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6464C18DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiBWQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiBWQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:39:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C5B91CF;
        Wed, 23 Feb 2022 08:38:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwneHYOxWEscrZnO74JMiXlOaBVQhE7X/LI8kmLO60JA+JyYkY62liTG+mrt1DDGY7oOITxMAL9YRivYkmIAwyb4kt3OUR6oFN3NuPp47Lc9tF94UQKIgCpOjeUDrPo+UM59A2Q0UYi2G4DmvFwWQOslKg7G2VQX9u8ILkgdfBn3MVaPBbGDUrazsgHFZLkHWpp+VkkFdyD40yk3NBBBozguu6zlBEBbLuCaPPFBK6qjdtGsh5G0nWAmhhktc7RhCyoefG8BXUO0uu3NvE9Yan3lZo80RtZfSv4ups0hpdrzqjfvcFrgUsidnXdk9OIMLtq2QCcz8Pvbp11V74P6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYPCyHHGhzkPgAguB9Ijh46M0Ohx5QdEAkGKf8LlQ6c=;
 b=n66/3rOT3wvEmQEa1xrojVy9ysTZi/jmWEecCOZRKRtLXoBAC1rU/vVna2p0JvMeJ/lYcnchippEoxcoUyVXwax14ZbO+uMcvCfBiGTL2t7Or+nE8/o/WLSV1tcTq/nOg6jwoInXOZS/DskOLzSG0vyE+ZNblWWA+7Vwo+KmdWbUK6M14Tyv/EFLj5fRFBLitZ7IrIlJVxp09n5mvJ8/mEnHNxj1UrJsc+JibctxXL2zEqRlga4E7zJwgiOCYTOlCvxqrxqmx7W8g2TPqo52tGy/F7ypudqEz57p4FQAewv9GgoiCCc41+3c2QPjtXGCizagQ7vOXYlS7WLFeltuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYPCyHHGhzkPgAguB9Ijh46M0Ohx5QdEAkGKf8LlQ6c=;
 b=rpxDSbZghS3KQ8Jr2PcTDjC+jAKrVHcXIX64Y6J7iQO/clcE+j52neCvP6ljmYF1Nsi9joy4sBI+UQ22ne+zJwLQLgLcnMpjdKOq4b06PndQyEcvaJ04PVIYyGVIYHvxAUPG2+oac1cACauZ2ZnshvlAO+fxHuI6ZLyegk+XwYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3456.apcprd04.prod.outlook.com (2603:1096:404:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 16:38:32 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 16:38:32 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 1/2] hwmon: (adm1275) Allow setting sample averaging
Date:   Thu, 24 Feb 2022 00:38:16 +0800
Message-Id: <20220223163817.30583-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163817.30583-1-potin.lai@quantatw.com>
References: <20220223163817.30583-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf4437f-9d8f-4585-4718-08d9f6eaedae
X-MS-TrafficTypeDiagnostic: TY2PR04MB3456:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB34569AC3D4A076582D4221328E3C9@TY2PR04MB3456.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMWRb8Hob/mbdYqAJ9ch8sqXob2iF+FqoIwTmvtahwtgWgsLAZTcIr1vUP2xaNX/tkTDHPJPJwyCxGlfd52/ZYxXCC1SOuWLFNh3owmbLQGQR9yMhdEpoqUNs9oCxLfrDr8K6EOsXWrs2SsKoc6DKJSrvXkclmCWXhUss09LVP8f/wXIAxGrhb5xBAzAgugrOlshUnotAUyffGYrR4YZm4d9gJ7NjM6k306ct4sXPbIEJTG4DloSldErwlmyhY+8kv5LYxhw0LIkyNji0kmdm/ji8oENuJca+q54t+WZwJ7Gfu+MuxP3g45z524mQLFWvuwx5vSGSu6N9kvQthDFt8ynE8MNrwx5YXse+dr0tpKlZQUJyUZ3jWNF7/pHrOukomLOoDbQjarCMLMJphROYZg60AFhU6GKFSUK2/h7PcMnuzYzs7GJmMBmKNAi2tWL131AC/xTo5OxQy8m5fQk/jid8My/OBeopavFQfINviXeLCVQHmLBS2cVdnP57+a6GNryPAg1tL2IQ4mXtqUtPpJBSWdALQC34HbVf33J/tXIbxabTLBHdkFxaF2JBcMQaxHduAfIkDaEP2VAeiF2wwtsMqyTScfQe3ZiazsvWe6ZgVKqhJ6+LbudITlBbeMn8hfq57otV7cZTRFgRDp6S2amBpxgQjRbt08x61evb8FFrJSCWqn88C+caazFaD+JWPcwJ51PU36ETYfoiPvf3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(38350700002)(86362001)(52116002)(54906003)(36756003)(6666004)(4326008)(6486002)(2616005)(8676002)(508600001)(5660300002)(26005)(1076003)(44832011)(8936002)(186003)(6506007)(316002)(66946007)(66556008)(66476007)(6512007)(110136005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ciiS+Iy3SjWgNR7Aqt5mysGEqslThpUWiGfObsZ4R0N+rR6YD/o3oc65ilYK?=
 =?us-ascii?Q?RyBRJY/k1wyDEJJF1jT4IYAYIf2Wj8jJur6ZlVcEbEEhAUPAWTGx5M7if0h2?=
 =?us-ascii?Q?Cy9ITFinxqtNXpVbcOclJVzKibcDcgLM+Ohszv7DDeKQ/V5UuLV6cGNCbXZU?=
 =?us-ascii?Q?DKkBa3KAa5yysa6a2fMFlxqFn1BMB54CgknYlbHh9lY5R/45v5bq6v01VCxp?=
 =?us-ascii?Q?vTl4HwLq/M95VYoMCH5Weg3yCl8dhGy5K7uqUy2jXP3EnvmWiWVXSd0LmCh7?=
 =?us-ascii?Q?s3Y6EUboXtBz2HrXT4aCPym8k3HaQ7xT8qn9tDn5mwti981VN/3i0RLQ5Fu9?=
 =?us-ascii?Q?iST70egWT1qpa9xKFiof1+/r/SO4DGFvnCNPdew/SMt7eiBudleoRdqC1Sjs?=
 =?us-ascii?Q?1po4SZZTWQ6xQfdu8UrVebawy8w+bu8+V9wgnWywuepRxVDnxawNGENOWaCw?=
 =?us-ascii?Q?ntkcfaGvwPjbIJRx5Sdzd3WIOSG4lrSBO3wSx5B53EfeAYp7KSDhIQEDtEdC?=
 =?us-ascii?Q?lOdyPbsciTbgusCQqvYv/qdwE7vJu83T8HHEW5iTj8mtxxCFfJYhTtiPs/wQ?=
 =?us-ascii?Q?7mbeKc4uyPv94kopD2LPcF9Rn9cPmbTdVUpO0x8i/8HbPBUJjCRdGJbXZDX+?=
 =?us-ascii?Q?w22Jm5cejygdt7s7gwXl/wQLwOGyCqwl6u4oOcPaYfgdi7Z8PFCUjJ/63hrw?=
 =?us-ascii?Q?sKwXkAsPD6/obK2y/q4EqDNayMKDUP6dS6NuoVWGYOe5maraU09TAbMvRzER?=
 =?us-ascii?Q?6Rb8RJN66RR79EXr13Dd3CG6hdhA9E5ZNTbfrW+GtfGVNbJ0zboUyzgcio9O?=
 =?us-ascii?Q?zTMfWrb0dlbIuASVtP5CsTwXaztfqPwVyM/wwJUp1V3xFPhMBjuhN69PkrcO?=
 =?us-ascii?Q?3orJuCNRgnVLUM2A40txyXdfHI0hXs4Fvq4h2anEKGAziXXFLvj+9a6+MmGt?=
 =?us-ascii?Q?+wnT75bSnIr4tETlEkhIVpHRpzBd1pB3vimp8zPCfONVei2jG2EV4g+u++8l?=
 =?us-ascii?Q?fKdS2C3zly5Mm9Sh4SRNko6HnakRv0q8XH+1xOX+6nKCcZ66yuQbaYH6edsq?=
 =?us-ascii?Q?SJbXWB6nSIhdBX8Jzu7Sq9rmMuEOgMJ6C1/0Vl2FIKTqwGTD9v/IjDyD/vDm?=
 =?us-ascii?Q?6N4/EY3clRR8oH+U8epciRw2cS8o9uDWGHte8nogITeyQF6swO/E06lzOWsL?=
 =?us-ascii?Q?tHDBEdvHCgs1snMt3His0ZnKSYb3QBuqCW7lOwmzy5hoBqlO7Qw4SzmmjVGA?=
 =?us-ascii?Q?87SSV4NK1f42HZ4vkbEK7napvgDD68Vzic6DX7aOf9suriugNP/E4zG3nWe6?=
 =?us-ascii?Q?tbiMvBS7bBOjRQyD4tKTeaSAlDCcDh2Q1uNJ7OTgSDcRIDqTWKzD4qMyW+ry?=
 =?us-ascii?Q?7gOzN+7g0z4GACzm22avi50y1s3nQybGTYc3okplFhjp7n8myyLN0bhdgIhh?=
 =?us-ascii?Q?ygt8XK01vKOQ1v1sWVUDY3pUpXYTSVj+Ji+4dEMtBKDPSkC9TStofdPATuVo?=
 =?us-ascii?Q?SypsEZ+fMyu/nkuXYjcRagkqCr/VtIklzWeE+coc7U2gYzPgheCX7iqg2Kb6?=
 =?us-ascii?Q?3bRv5ye7wl16gF9bOYePyFstNHCE5kvwTQzlPH0BPv7sWV6kgEn2xoU5Z+FV?=
 =?us-ascii?Q?zGBpIXiWmFZH2mLa14b9nHY=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf4437f-9d8f-4585-4718-08d9f6eaedae
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 16:38:32.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYGckQ8HzF8R+n3OvGMddW9b9BsCihmnOFTLqBn4BhHTafbfPVBWfEu5dJzC3CUqkOmhcnm8U88agSgTJi7QbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs to
set sample averaging via sysfs manually.

This patch parses "pwr-avg" and "vi-avg" from device tree, and setting
sample averaging during probe.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/hwmon/pmbus/adm1275.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index d311e0557401..97faff4e3111 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
 	u32 shunt;
+	u32 avg;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -756,6 +757,30 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
+	if (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				"pwr-avg", &avg) == 0) {
+		avg = clamp_val(avg, 1, ADM1275_SAMPLES_AVG_MAX);
+		ret = adm1275_write_pmon_config(data, client,
+						true, ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev, "set pwr-avg failed, ret = %d",
+				ret);
+			return ret;
+		}
+	}
+
+	if (of_property_read_u32(client->dev.of_node, "vi-avg", &avg) == 0) {
+		avg = clamp_val(avg, 1, ADM1275_SAMPLES_AVG_MAX);
+		ret = adm1275_write_pmon_config(data, client,
+						false, ilog2(avg));
+		if (ret < 0) {
+			dev_err(&client->dev, "set vi-avg failed, ret = %d",
+				ret);
+			return ret;
+		}
+	}
+
 	if (voindex < 0)
 		voindex = vindex;
 	if (vindex >= 0) {
-- 
2.17.1

