Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BBC4C40CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiBYI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiBYI67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:58:59 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA622BEAC;
        Fri, 25 Feb 2022 00:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5CsrI9KuSn5tRgybS3aDvl5TAHPQspZo2uTkgNlrfUFawgMXcdYlpK4rL09lsz+JRbsmtvH2i3VlDxC0NZXRCuTPSd7pDhxPw8KWasv7OHVJ7QKBKk8/xOzGG57LnQAV0xXa0BtylEfz7tGWNmrrldENBdK13JdfDofUkA6AOSQT6AbmzVf4mx9kYfIjNdSF1EjFp8TzJgEmojSBC6FSjw1LHcv/9iun0jlpjVeGEISKA8vVICzo0Bv0NWdrAiLsLHqw0F04KpNn/uTtMvoRJ+DkdAjy2m+tvhCLePGbxw2dMpZJ0Q4NRyJTMOUAkYe+VwUqAThFYV8jGgyDDyg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24K9xcPzJj5bbcG43nMEq/zi76uXUgWQF8+bdH/uoI4=;
 b=JaHdodCQeWFONyYGvPpyC+SPlX3gclXRbMqeE0HrpTLlPSfiBMTET9JrsDPAGK066cDHIGwOBeHWRuLBPN1FQEPKNTfnTHOpUgLixdtfDa5DLfeJQTZMV+sIciaQFgJeMrHOZxjgncQiFAKN3Nqof46aUY5+eYQsvRffTdtqsPH5+jFm+ewPGXgxZfjC2OM2mxu+DJsRI2ozTOQ/BujHi607GzPSIigDnWS/5MExOKCEA2Cxd0pYWqHec84gkWAOa+SumtxiE7kxeEZyBhGORWJTCyD3OTfMf/rGADFTGpwMBya7e8Hpc2TPhANcdBXOH+/auaIRWTSpIM3QEabv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24K9xcPzJj5bbcG43nMEq/zi76uXUgWQF8+bdH/uoI4=;
 b=DpzsQKlOVbBGXzyQVGG8yZuie+oYl8MBbpuk41XZUG1/OS+0D8p2zr7mGCRemzLm94prhALzfbqPrLQ63IUzlptxyB8rgnOJDTQ1eGjvbBmN9M7cBl7Y7+nB/zD/WnD86InXf2sA5cZQYhoPIpsWpo62RQgjGvLqgn/WYqSf/sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6472.eurprd04.prod.outlook.com (2603:10a6:20b:f8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:58:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:58:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx8mq: add 27m phy pll ref clock
Date:   Fri, 25 Feb 2022 17:00:02 +0800
Message-Id: <20220225090002.2497057-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3060d6f-7098-4f3b-fcb9-08d9f83cfad3
X-MS-TrafficTypeDiagnostic: AM6PR04MB6472:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6472BE22C6C308BB5A263F7AC93E9@AM6PR04MB6472.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1uERk6SVpGGtELra5URhplw2vd+Iw0r3KTEwl8kJ3U2Dvqa16pxu8GXte9W8IFfhxIB7sn0Msw4/Sk9QtR2en3Itw49XKPTI89XzlKYLkh9FWP/fg+m9fp1i1YoxdTQgB/td7nbpuK40kIRSLKvqe/UO1iFtfL99zbfWlSa9z6FF3UnOP8LdvL5TqLHxFQZvLlANWugm+/O02IqR2aqbDut/An1Azh/oNpiJfyhhVgMVPgKZK+qVvy3bet4Ipct2VlTvG9RbXJw9BSgjM24Y7qN5u7KX6uUv/WcrdxL9oMd3Psyrq+Ls5asmsCwnSDs3KhqsEc74t9V+vf8b2jl5TUOUCvFsLA1OdTnuxsJQnSs9Q59d9Wt+ytNBLw5jBkszO44a+dVUJ74boHf480UCv14LCbEHPha4Tc/80WkhaLKOUBydVSAFHHRrP9ivRtohgcC9KeUYnjJtqgx3s5vbYHGoGTqV95WHViSF7lMhbIjjehrF4OF2yXYMQSDEOj7/Pvn0VTiSa0LmbQ0huY8EKOZQkDoBHVyKQ2mODFNi+ghB9Mu7N/91kaoLiCnELUnHE7K/2W/ql//LywMex01YAmUw6t3quIq1lhS3PV1y/SBlbu6SZcWAelQoh6DGSJNZD4XYpTn/coeacPrKtG+0NhuUXTHVCi/VRCZ52DZDhfkcLw4XXmRk1eZdU9hKVnS9DXZU33Wsu2MUEoGgqw3xQkkrNibK/SFuN1viBvjOPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(6486002)(26005)(8936002)(86362001)(6506007)(6512007)(4744005)(52116002)(6666004)(2906002)(7416002)(5660300002)(2616005)(186003)(1076003)(38100700002)(38350700002)(66946007)(66476007)(66556008)(316002)(4326008)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uKXv6FJhDqXGsd0M8Mio0NTzES7BkHInotshJE1pbivvGiwf5kd/ryJVasi?=
 =?us-ascii?Q?e7ukcofT1ovLhor+nt7FoUV6ulsoMTHwHHbfzIzvfO5x+7mm3AjlsDwEMjEH?=
 =?us-ascii?Q?cBp90gK1Yl2wE++ZhAm1fmkdgtZJYSAN2JneM13NlB8WjO+RpFgQgkMndiGq?=
 =?us-ascii?Q?Baqq61YixTG2fIOsho0Nm4MAwIwAUx/E4GL77ZsaVEILdcEjN/YDKTejlfnu?=
 =?us-ascii?Q?V7n/7TCrR7e49GhINAtnlb3lwzts40aL4KIBcWN1cZRlChHOhwJgcI1mDIoW?=
 =?us-ascii?Q?UlpyvjywmeGVfJKQK1XeEwg1VtdmiHcI3b6jm730QNKxpH4TAHcu+YaAfQJg?=
 =?us-ascii?Q?Tjme2pNDbnkfEg0E8SAA2ojV59raMRwyQ6h0a4wESeA9UrPF2teCnVvLe3G2?=
 =?us-ascii?Q?T4BeJuizzJDmzcLzewoS7MBVW+XThyuspn5d1VjYXsLzR3S0LjuRAdNZD1As?=
 =?us-ascii?Q?HuiTtXP6/P4I7ujmGVHHZ9QeeNmoikUJwemlZSb7/epbcf5mGaQOQ49Z23Ci?=
 =?us-ascii?Q?e02aJHoytl75+zQjOrp3VMJlas1g4dK2e/FP2G18BMYJwHpBmVnDSNqJKJgr?=
 =?us-ascii?Q?rgD6hYPh2j9EJmKerf3dKyv7VH2J5UDulMiDjJkOly8BDXkLh9mj+uIInCIt?=
 =?us-ascii?Q?ib0n/1NLmmMDgVlxTtrge9fA0QHMh9pvCMmdc5v/GWCxvQl7eMykDnNnMYro?=
 =?us-ascii?Q?1WTDcxgzTVrC4PpZFiIvrvXkERGhedXGFehhA8VHjcth5n2dQnv2uPIhlJsN?=
 =?us-ascii?Q?7IiKMipPhWPB45mU8IEVRANSt9QeQbMZYk2d9Ee1YCdgcJRG4lFdOqxeYJCY?=
 =?us-ascii?Q?Cmir+2i92eIXChCwu4wEskbZ+biTmAUZB3ehJrKZEJVLCqreZVBLYwALu/Y4?=
 =?us-ascii?Q?jxM7lA59Cn8QMJYGxJhxJ++g/iAa9eeHGfoOnTW43fY1Eilw7e4fpRCYlS7i?=
 =?us-ascii?Q?mvm90fi6GaDjdVMIVQJk5bQvN3M2W5ONEFqTxZqNoD/RLkkck/ci6o0guLoP?=
 =?us-ascii?Q?6MblX8OFncr45v1R+KqVEbShi9C8tp+wwWQbHAIKBaCnaSX8lj0n44LMsMvj?=
 =?us-ascii?Q?bkVow8YU+3SuEIFAY4PkzM/bC79R+k7z0T9CfPDigLsYKcBtZAnm+F0qjx+5?=
 =?us-ascii?Q?ARDBssU9Bq9nonMGE5ZCWTeJMC3oaK5/MYnWlNzOYtlT2dlN3jTHCWHvf71P?=
 =?us-ascii?Q?G1k56DlLqmQu1+AFhrhk8Cqb5XpzQiO4qo5Lkat4ItjNKlsVLRa/1DS04mfy?=
 =?us-ascii?Q?ZRGG+C7gg5Kf/d863o+e1SjyqfnF2I9L+35IqhD2O9iBs8Cs5jXM3tsaNeMc?=
 =?us-ascii?Q?kb+6Gd0cu+t/vshI5kHR622FlehsgQQPV/4Et9QFDgxxjqcdbKOhAWsJWgLT?=
 =?us-ascii?Q?SGCL6yR4CG41k4YGVcJZzlbDVBtKGBHF8Gm//mE2fIgYV8RDSl49KTj/wuoz?=
 =?us-ascii?Q?emTJ1bjP6M3/LTO203RfsNQdeXlB1274yV7sy6FWSz4q3r+Qo4Cg234FN6Mc?=
 =?us-ascii?Q?YGbcbJ4CcuGNRJ1/gFu9BB9ep0bJMI7yrWSSJRVbiCZuP3/foeW3KEOim+Mx?=
 =?us-ascii?Q?a1mlAwKfcUEG8uWD13ZDApXzVZtx26Wv7UCc5JECfflk7Iv/8pk+5bFOrbOZ?=
 =?us-ascii?Q?o04n3clc+FvSQIqhlO5a39c=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3060d6f-7098-4f3b-fcb9-08d9f83cfad3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:58:24.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIu71gMQ8KJemBhK2purk+6tKnUBMTcDeSyyp3moKa05O6+nGG9l4gKhE2MFF41f9KF0NZpJLESuTST8UJ8fZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6472
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to pll documentation, the 3rd pll ref clock should be
hdmi phy 27m clock, not dummy clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 83cc2b1c3294..a9e69b6355ed 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -25,7 +25,7 @@ static u32 share_count_sai6;
 static u32 share_count_dcss;
 static u32 share_count_nand;
 
-static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "dummy", "dummy", };
+static const char * const pll_ref_sels[] = { "osc_25m", "osc_27m", "hdmi_phy_27m", "dummy", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
 static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
-- 
2.25.1

