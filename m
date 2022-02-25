Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267D4C40CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiBYI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiBYI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:58:49 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0611F03A4;
        Fri, 25 Feb 2022 00:58:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GThQV/Y7ws9iAyCEaseQmj9pgm+U2eNZmVRGGwn5w9aIlywqAxPzj57BIDiJBfY1cZx8ORrWZ+3Ra/LMJtj3JCJcR5VPg+ZlnU3J1WGeiHf8wEczeya4VK67etbZH9pCl8kQCvK4IMTh65fm1xRQznmzyJNa9AiKKoJlMeVQ8vJtzUjqgLh+XAnnxJRYGqX32UTGudqucqfMVKea5FJSJnJ48OvYBe6FriW8ilHpIUEOq6JQUKMbFvcH/G/b7qIfCb+krIgfwcHpgoiIlolyiVIDoucDvYyuvHZvCl6gFLto+5dEOXVfQ8ourwTUErYQMcxeB1shV7LPog5QdS3TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz5htI758Pax/MXo9XJA8ZM9kWw43GdftJ9pHWQPbcs=;
 b=Do2UNMXkqKRjZhNPA3JzEqpZcOi2zC06abpYKDAdzsxcSxgCKx1bU3xlTBErLyNQXOEADix7o29d8cdx2jAPzYVrUYLxj7rSBq2rkW/jfE2icQCkUGZEoIM0ELJhK15KNFYIbYkPQoRk8FFZBq2bc+/pKOt42lpdWUnffEtB5TWMtxj4oOTDLldS8d8on5qHenHM5j4H2S5p9aJEJopO4jXuguF96t96tjPtlW/bEm2RfMJQHQa4MzZTfMNQikMKJbJBQkuwWovAs421S8iqn+qiRQdYSsxoOlUGdadAoxpU2a/FyQn7KqecAY6aazKdoaPPirApDIsLLI73UxCxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz5htI758Pax/MXo9XJA8ZM9kWw43GdftJ9pHWQPbcs=;
 b=Rbs53cV7b5zSuEj3bKrQbeMiq1p3dngjp0erh0N1ZAr6iBoHddPhaFCuUcOvAHuRJGHxEPh/GeVlmQ8QgkMvEAwamO8V9gmtAKWEDEeWiH8IGz+YDpryFfXG2OnE/9RovgTHhXWsj5nt7c5FUIswFNiwU4pxiM4LWdVH9e57j9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0401MB2662.eurprd04.prod.outlook.com (2603:10a6:4:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:58:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:58:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] imx: add hdmi 27m phy clk
Date:   Fri, 25 Feb 2022 17:00:00 +0800
Message-Id: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 059e10dd-71f2-498f-435f-08d9f83cf533
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2662:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2662B07B4F6711C97AE9AB34C93E9@DB6PR0401MB2662.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyQXFhMn7PZj/sPFwwdBnx9JONtP4dleh+2i7bFwiqczPcKnaXOBMR7JSZKvL3sk8iC/G+jk/qGJU4scWuXwOHOBO7CnngJXG+rcQ3Cz1e8a1SLWhwavSENvv9EhfGivYqiRLCn7RJ6TLSf+6XgHII1x2t6OKQ7L5H9+AjvsH/FDBD9VXh8R85UQ3M+ttGtuMWFq5CekmNPPz9oz7E+OahSIdHj/wWbEits5LkjDB1gzFE2E60RJeVzSmNuQ3++VZ+a3rAdw+82C5XPxaO47Vh6UBIxC8YitBTBiPP0yiaKW6OuoMUwkKBC7Yio1xXMUCb0vnhlfcmGfyfXMneJGDnNtI9lj7yBNEiXE2F+gygsNNTaVGxehQA8jGIvIrWif7e/gAkCFioujfHn8eZ/V6/88iB7BafHPjNV/sDRSavg2hwGVP1Go0NdUVMkMrrnRQQKOd0+3Zv33ul492d8kVLF9g5sBMGiP0lhabYoYsJ8A5FLcn05xs4ew5IKEB8u1t27OEJdWDfzTzi0a+jvL/RCzzzaaUBd7qb5QUeX5dWsg4k70asRrk7+tMLJmBB7GOgdZdkrgBBPsNkaGdE6j/YjAVBCxt0/42qvSBeI+4cFbF2/KtrtuUesm/pHYBCMXK8LUTo3g1YA5IpwjVCqg0r+iXf0bwAjjf2/jC5aWKVdE64YxnXboWPK6qb6UoJFuP0R3dpVI76Z0L+DwYK9Qrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2616005)(38100700002)(83380400001)(1076003)(186003)(86362001)(26005)(316002)(2906002)(66946007)(4326008)(7416002)(5660300002)(8936002)(66556008)(8676002)(4744005)(66476007)(6666004)(6506007)(52116002)(6512007)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3TQFbGFo/QSoVE2PiUxfeIL5QaOsHZSICJWq1gByfgJgaJZeO0EK/dY/6Yoy?=
 =?us-ascii?Q?JvMqByYfEj7sTLKN9VdCzGOzAMAHjZUwagrWOLLPsiewh2pf2UQdyEfedwV3?=
 =?us-ascii?Q?Il/+LRb4xTH4eHrLpoKdjfTNzSCl1CQDI3gYW0f/wKqwdnjMWWlT99wDLsUD?=
 =?us-ascii?Q?f216Y6vi00f0IGmplaNUjwMFXrNd+FbvQj9wSPwVG6OLyuxQDNhbGx4AtPh+?=
 =?us-ascii?Q?UftMpXQXagEqCUnojUeFGIqle4KRZ2Zfco8WmiomVo1NDhClUEn5B+6Pm+o0?=
 =?us-ascii?Q?V0R7Fo9ZWgB0HJsk1qsF1O1TzREvmr98M7tyNP/VgzH2DgYknBtn/RWuXs3c?=
 =?us-ascii?Q?G6T0/2Tt71XswWAgIvzTz2jD7OAb4PVHBDwBIBNIpg7nsbliqmZdrZvWi95q?=
 =?us-ascii?Q?ukB3kS/8qtF5bmBbUTqhvLY//hL1Q/tujizd5WTAmdFdTAgMzhS4i2jsVU8W?=
 =?us-ascii?Q?TfmvALh4+00Ijf7ZTknExuzbGV/NnIrxvAq67E3SQK2rtbOdn64DgH1jOxii?=
 =?us-ascii?Q?XuaLRvpLCcP0O3+4xIzaApN2SkCjj/z+9i2D/pK4/agT18p+nhqdQun8QHAO?=
 =?us-ascii?Q?TRy5Pc8ub1DIOO6Tek/PejWcIKrR8I3oCS70ZKHX+o6BIPh91hCoQFRew2b5?=
 =?us-ascii?Q?75l4RAakSGqTZ0YbPI3Rc2r4MmUopfNuTJDgYKfOMCzcP+0lAkHs2js5Ztq+?=
 =?us-ascii?Q?VX1OLEI6Da1nEjRr2olhqKCsu9mUisJUX77kJUYP9/ub9AJxtxCNo6v4vt7D?=
 =?us-ascii?Q?JxEt00s3fomqhqAxv4MGEdp0cKVCRA0pkjPYyx2WwY8Qy9eD79cktV1IMw+V?=
 =?us-ascii?Q?503Lwkqq0lXBghAzLB9jnfKNeC9CsICjzYQHVw7rXR1RdeFjyFICufF2mkz+?=
 =?us-ascii?Q?tpvWOjOf1ZjwCIRo2BdmL8LZ9Qdl7XqCydSpB7CArK2uxebLoyk+f5Rja6dY?=
 =?us-ascii?Q?avWH2nURF+uaaonGutqdi1gwr3C0QNHahZKgwz3C2oJ+9O8MlX6QqKltFP0M?=
 =?us-ascii?Q?1CtYee2rYDJC+CG9CbKJSISRgVm0uwzXNwy2D/QclNl69z9s5KWeivNulyts?=
 =?us-ascii?Q?sGL2UIf4rtdSSuWxfoi4LZghkkprD5mPyDnw+zgmZByrV2EyDs866ZhtsrOW?=
 =?us-ascii?Q?s3SxUYtWBPA64LLm2kl+FqbqxSSFK1mlkk04gwTHV+b+5wf48KzepfcWeszn?=
 =?us-ascii?Q?n0+h2hl6jyRSykrCRCcfzUlXWLj2PrmQImFVKA0gdw6tDAtpAikhJhj5fOCu?=
 =?us-ascii?Q?/oZM7FBGT3M0f5+ZY/gMf/Y2az34AIa1vJfgLt1EmJXEovYxIXcY7HTWr+xE?=
 =?us-ascii?Q?3Kj5slf++hymFDuF6KVB/RQlfH/olRCknlNdaEP/wsA1L/ZXvUyQvwQw5hBk?=
 =?us-ascii?Q?IHYwGw4X14L2IcfKzD0po1k4B8qNAU5GKxrFd9AfUZCz9qOU34grVm2QDUed?=
 =?us-ascii?Q?L7tOZzBgFO95OD/Xzqd0H5yZ8MdYXIEgt5iNs4VOE+xxZ7xQBjO8QsvR8o35?=
 =?us-ascii?Q?amA87pXtsYrKTCSOfZ6rCykbAhyWqoFzuFZwqUhkqCgJJ0M+Q6roEhFn+Tyq?=
 =?us-ascii?Q?3fMHTwthInMymIiSVAfkubm5ChGYlWJDYiNJV7Tx3faIxY1+cVJ3ko6w4O3E?=
 =?us-ascii?Q?91bUYIyGOdRW1DJFBI5/WV0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059e10dd-71f2-498f-435f-08d9f83cf533
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:58:14.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRtYEjHrWJQt2V/In0G9rqp2u6HmraS1XV4KUeQJh3EI+JPEnLQnw6D8nBo9WqG3M470kyUbW+2w7ShIxlC+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2662
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

add hdmi 27m phy clk, so pll could source from this clock

Peng Fan (2):
  arm64: dts: imx8mq: add hdmi phy 27m clock
  clk: imx8mq: add 27m phy pll ref clock

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 drivers/clk/imx/clk-imx8mq.c              | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

