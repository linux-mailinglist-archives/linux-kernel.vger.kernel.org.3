Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DA4AB867
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351837AbiBGKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352092AbiBGJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:49 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1BC043181;
        Mon,  7 Feb 2022 01:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzJxgS9GC38+nV9Aj+7M5qfkJueE8SeZTaImQpVDOouRngTqDqDeH5HYseMjTTKq+JxH/LaghuNkiX2eoBhtWcoqNXL8yo/Qbofw9YUD+f6ZME06LET1F0asi3S1cJHlA/+qik3snvBdjH7qIqCXwLN1NPVSuOKRv8d/HuMYQqqI28Q1pKu9qfejfFAtKp0Ctv8FVaCyWncgoBx/pqs5iLPgOPYNLE3lvWDaQJk0uXSl/jz57yNW8qxQ7Xsh9V7DlLgz+dFQ7+Vrc1DbnK+XFtCpc0bhpdqFa39JDAjkAmiXUtkPbs/3bWGRT3QQEs826gsuDXGaKMZvmk2D8oPAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spv7gkn7Uz4vxztShm5LNUQm/c4UtutJnTJKQUvE1ag=;
 b=LIEX5d1yedgcUAmxgzGbc0rL5k5LSW911sYjdNQUtcrKs4+94yhVpowC4JPlDYs7sr78Kc2/88CQ6kaU+W8ZcwORT/zW1GqGUBy/hpCJzKcI5Gi22ME8VO4Onhxu+me8BQcOBndidO2P9Du4Tyj6R1JzOg2Fo5g+2FUbrZhXpeNqyx5prFNb4BdcERlydhddKxoZAGmHnf69wktlTFoXk0+HoJHUernAOIu0NGaO8/sIEN/QBAUH4l0aAyJnf9/9yOTP5rbUT09oN+EbT3S29+mv4CVrJz2C7uu6yp3meN4PtUKZIMr2n1KvKoNSz6cgyL6b3wamJ12Sqk6Q50uRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spv7gkn7Uz4vxztShm5LNUQm/c4UtutJnTJKQUvE1ag=;
 b=OfSaf8sfqvfoHurXKGgapT/6MgcJjrI+rLTPO9lRtc7aDd3i9m4RCIj+F2aFP3HJ4JvthrUqpoXhU7My902EMb4Zic9KPw3Zgi112JDATaOcO8GedXUnLe2kkOkY9FBdrGv7bFUGlXRD2rokSux/cYkgUxvsnw8UNvzIXE6fzvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8464.eurprd04.prod.outlook.com (2603:10a6:10:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/5] mailbox: imx: update author and Copyright
Date:   Mon,  7 Feb 2022 17:58:32 +0800
Message-Id: <20220207095832.1590225-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d87ceded-f57c-402a-ef77-08d9ea2090eb
X-MS-TrafficTypeDiagnostic: DB9PR04MB8464:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8464714D26634680351B7CFCC92C9@DB9PR04MB8464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4F4ZYphL85xFEuAIJMcYXtpBs15K4x98ZxT8MyJDflekKw5dxfJBCOSqvvNlJO+GrHl4EYMLePMMb8ZhI9wlsViTka/OvbjGB0pGs9XiJCeYPiDwFV4kEQmjF4s2KOjUb9ZI6CSPzQk/r6X2YY0T6jNz2KFyf0HnXwG9X+p0RoFMD2ep9cZtq/s5xzVaMOKJG6+EaLvZeySybg3y5WIb9q2G8Je48gDK2UwZpyYjBpOY5lA/z1hG0E/O5bgApWQ84GOkfGoAmbmD5Zol4UviXkVAQMwERM4aGwbis6wNxa23V1jbGoCLyeonGkVgmjxU1alkYyD9pDml3vM9ykkkOTgmUgO6WqEaY1jzhSWfSeJOgMEJqr1V+xo3cLoVU+vUN25otv/tkbKuslx7EOh9fOqazFXAVJRNWcB1hivlNQoYgJBrJZlwqCiDcYqi8R2DrFXEwEcPmb1CDKqDfgho3E65hXeopDyoqkD8qRlC2zzwesnXMY6T+c8R8MqI7o5WiEtc/MZ/ZCDgw5l/HbqYFkzbMPhb5Azq77JbRvUu09IogofZDUL/P+MMI1Wp/S4nc3YTGpUtLQ9zoOGx0RrR2s+v2YEd90bc6Re/zbPuiRv0zyZpKTqarhPNinkqdjWeZDEIajYCm2r9iEA5rIHt6QzkCX7EUUvrsSGZuxCazBcqCnz5ZcKyTY42rAbqVsX+Ny2AFcUMY4M38tPxlOeI7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8936002)(8676002)(2616005)(66556008)(38100700002)(66946007)(86362001)(4744005)(5660300002)(15650500001)(66476007)(2906002)(38350700002)(186003)(1076003)(26005)(316002)(83380400001)(52116002)(6512007)(6666004)(6506007)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avGglQukIHfzEpc8dv/dXXxy7IHwCnwo0wz/s6dQcm7gUljMUNyjLJE7Ms4l?=
 =?us-ascii?Q?NkZ+nu4SVJ2BzAG62TtZlxdOY2WcaY5nu0ffeRvky2TsjZHzXEJuiXkO4xHB?=
 =?us-ascii?Q?D8FRlXCdBQkCpQkjvJa+QT1yruojkJP3a4zocmadCRUIzv9rGzIWy+pwZz46?=
 =?us-ascii?Q?NbTF6WspfBhR2RBfCPIzhQGzfE55rZGQ0lrlhUDe6cGogGETparSDfnBUMYA?=
 =?us-ascii?Q?hvMo2yzqly+EiQt4Rp/hn1F1M/EHTw1t+1T3ZUqCtNMvDXJZottPh49Y76VN?=
 =?us-ascii?Q?4vGVlBNQsG4XTk1kc1Hj/YMvvk0pBx6U/Z4taWuVKiMcvWtgSD21DRA7ZZ/O?=
 =?us-ascii?Q?0jFeXeZA7ZgElQQNS/O8Hxlos8hzL/xHGoNj13jWpJxOSI7hf24QzYBJkeFs?=
 =?us-ascii?Q?/gx7QFUbRc0orbq7py4SaA8T18K46dxDN0m3gmrOLQW1j/QciV7uKmhq1LSi?=
 =?us-ascii?Q?vpcszJCl7c0XFffzOmxzmRbEybi8cllcY0zWGqbSb6/6s916lWkXCi55ju2K?=
 =?us-ascii?Q?4z0M9eKT/LCYpv5FkH5kepxOC0qKIb9BUnCzihbT+KncJCO4vD7gi3z8xIq6?=
 =?us-ascii?Q?O5paAhAx7o9e6wf6zj3tVix4vE45tuOT0oeLed6VCUxeq0n5O84lCJtCrmWX?=
 =?us-ascii?Q?dseLyjXQfQ5c0az2KYuES17s6qM8B8nfbvC1HjzYLoz3Xvtjg42VmkttHP9w?=
 =?us-ascii?Q?nYClr+EuryYKo9njjjHvPgiOaCfyFlibSqmYXoK6SOQ5NmdkxeWSmkzaWjNU?=
 =?us-ascii?Q?ijtdwn6pz3g/6pDZ0kRMtciPZ35y38c98dRlW1PrdEwdmrLdHmnDh0RU83AL?=
 =?us-ascii?Q?93VP0ZF2AXKrJLc32mCPfpvZBhUlYSPdVtOV73RPa1bMwqL+5JDGNYCfcYIw?=
 =?us-ascii?Q?/kYZ1CNhdQUTz1TH+QmY5sQmfzYiUYN5ei3WWFKYagPllSKSqHOyKrYj0ms/?=
 =?us-ascii?Q?YEDd5Y/9pQmc3pINNC05S+MJXedj8ZlefMnQmbDs6VLQM/H1m5cSQr2d0103?=
 =?us-ascii?Q?KIDvYNn9X3M3tY6zXPntIDJQlJ2kBC4k9hnkt0enJbDVogLs+0dx/JwpLeVB?=
 =?us-ascii?Q?IiUr6WpxW6EqC0UOJqGmFvOc/p4taO4lBLJ3wAPnAUmFdRshQnz1SZ487uVB?=
 =?us-ascii?Q?tPD8Wlx/ckS9KCZQfj2pUX98bh1YZFykOZyzP37p22HzgGXADUFb41wt5zuA?=
 =?us-ascii?Q?cy4CDsmhGOudnhfbxJ8JGjxEWkzTPPc52DssGMFEpgrhEUSCA4YKjuhT+7eS?=
 =?us-ascii?Q?rO+WKFNCh/6rG1ddhAAgb07IWoEYVHyU9lzb9s5EU8LL1WFDYHRsWHy8VbKD?=
 =?us-ascii?Q?pYtcNHjYE+SlZ3ArZF6EVmrCLs+vsrvGFv+Wh9cYdn8O8UxjAGzhoizZ6lie?=
 =?us-ascii?Q?t2wXFr9INWLt5b/HvI5ifB6ycy+t3PRtR25RqmcmHPfZRNghTepWD5JFvJNw?=
 =?us-ascii?Q?jg3OPA6niBSz+3TYdbcOgmlbQ6/Q5kXlmxz7rF5gw83IYamkTTLWRQjK2CFU?=
 =?us-ascii?Q?KCkv+90556ViW0HFBnR9/r/gm0IpjjxmTXtNWzlR1SOcAaoNM4va5ie8UW6r?=
 =?us-ascii?Q?Gb6e/ZR3na85s0HTf6ftP9dTYysCEYNwPh7Sw49MlizNKdTrNFgRdD30T1V+?=
 =?us-ascii?Q?AWFL9DWjiHdyXtRJbUEpY6s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87ceded-f57c-402a-ef77-08d9ea2090eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:44.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgzjO3Qi0cwN3K+Y4Cm9l+AwX6zlTBYlTXh5kswEuYvpw4uGNzEPQC4qDFRUXBMNdaV10SvbfaRMU0jo0GCRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8464
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add NXP Copyright
Add myself as author

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index da1c6ca8bee2..094dc84291fc 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
  */
 
 #include <linux/clk.h>
@@ -1030,5 +1031,6 @@ static struct platform_driver imx_mu_driver = {
 module_platform_driver(imx_mu_driver);
 
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
 MODULE_DESCRIPTION("Message Unit driver for i.MX");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

