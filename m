Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25154C950
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353779AbiFOM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbiFOM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:58:32 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A342A3C;
        Wed, 15 Jun 2022 05:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhIWc3UW3eDozCULlAKb3X83EajZ43CEkQKEMjUHT7w6y+NRuvuhL8L8fpaJ0ASYLpF8wjmgKwVQYqKRxfnf8SNgsuVCA4h9wkTzo4+1da2quZG/J1mlffiZ5p2EZjEu60m1dETD0eUwx4k+oAalNnvEFUOjf/1eiriMv4VgzNHgqcfHS4/b5FPySbH+0R22jSX35y3g19a3+uDUG58FPVaWU5TDRfG5xKVzQQ5RySP6MKkO9qWcsYNN2EfAIh/ToG7MxPlaprdoRobaI6b2ofzErgkrAncAhdyUYLwPRNENISdTWLnhZSGFDK/28mxU1rENF7hCNJWl8p9+o9tGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33CSAiJwrANhWWc1/mZJ88f1WC724IXOdBoJuaDMZyI=;
 b=DtdEF5UKC0HMewlAmMaDib33eBtFicUprZHfHywMZqZFhpg20tY/QJz0byQBsvyTRRSrHLFL0vMmH/CKrKxFTpmHkyP6Mv8b2eC/4jXXANzxymeWUt73WX0/Uf8BFwttdSYFKQvlKsi9fFvx/BwwEnk7GFPYKxb3HVJFGUd7RQqkgeWjkxtOJYSJ0Fij/h5G7Tug56OuGFdOROArAw0QPUfBejj2CEeFG+GvCKP5pJUmDTz62HSAMctzPa4g/tYTuBXMUASozgZa5nXwvZdzsf3tSnJqmErN402ruUNr6QF0mGWNV9SirvDOjBdwyi8oTrQpFSNI+fH5kmYXAT7dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33CSAiJwrANhWWc1/mZJ88f1WC724IXOdBoJuaDMZyI=;
 b=KAI75/4rzbjeGDDFT3AW0Ac7cDC4K/OoNZkfhBla1cZPxGwmqv9JOEAbx5ja7jOSKoyqKhtP71IO026ij7ew7kltdFpqf3hU29SAWaQ6b6MJZ9QnLJcRahfbKnR1E0ufNESqhBXG+l16t0L7ZI0p8QGk4IuPNUVJ8r2Pcen1vCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 12:58:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 12:58:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] mailbox: imx: support RST channel
Date:   Wed, 15 Jun 2022 21:00:07 +0800
Message-Id: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 180388c0-463a-4fa2-b939-08da4ecebd44
X-MS-TrafficTypeDiagnostic: DB8PR04MB7004:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7004F43285739876C666E317C9AD9@DB8PR04MB7004.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwzi6NWkt+0fMHQZGi8n/wxPH0YUeXjeZMLIg6lsjvAKEpOXQkBDEI7jXKUAmlodtaIyxHVDbw5PZs8ZB9ovdUrzRVkrLTXecNY6y9xyFLfLnUfhw6y9xe/3hiD4xX1quWJ0DIoVdOYqeIP4f4UiCzcrNgs9rSgImWSkxcBHVMQc50D5acT2mH7imMnYkH8/fz561808qgf0ysMR2OHY0Fp5zAfP2/wTmqjLtLE1sMJiYQVR+NUYJUEedSE4epQB8h8KaAUfwO6kAzVu5WWOK+DIPEqTZfsJWufCGBi7TC2yf/10pSGhLCyGjH78teC//uUeiLhX0r+2Lqvmnqzqxnwuzk5U+HNcvUtqwDB3A+YguSbKelJh8SgSYgyGQsi4T2DrqHlCgbUFna8sE/IBVxB+DnRylMl8m9bc5Gmony1xnXy+jZstJp4VDPd+hnS6c5+GqObn0nDhSCAQkAOpoRLIjw06KxAPMafzfkkgkIzt52Z6oI9zC2f/2TbCATvsnoXdnA/nQrYS/U8VZK7Uyq7pQkyspfELJbDbKSTwCOsBeYlpofO97IxQ2+7DxOHGgjA17kXMfI0TRbqjRsb0w/4348JouAxnRi5in0cxotQVwCZFhiYy+mnfuMZwPYc/TtFtitNl8YRtoWVJeeaYbzNfsxaMZnariyynUfd0Li5TrLV3Im+jBp0YliohuJA/zSEYcvOPZ89QzVJ9x70Uug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(15650500001)(2906002)(186003)(4744005)(83380400001)(316002)(508600001)(6666004)(6486002)(1076003)(2616005)(66946007)(8676002)(66476007)(6506007)(4326008)(52116002)(6512007)(26005)(5660300002)(86362001)(66556008)(38100700002)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HzgX4oEYZZ180WGm7JSUkreHUB8ihCnXWy61umo/YNw1Ca08euK3bu+1D9XO?=
 =?us-ascii?Q?LH2OSfx6108OfSZgplI3GLAS5zaZnvdV+iZofNJ1ThhJnd4ttBGC4U73a6Bl?=
 =?us-ascii?Q?zOGNeKqgPnAr4DF0iVpESv44JbFhKY8U5wiw7skjXu03FU+or/EbU7hEs9CH?=
 =?us-ascii?Q?V3/KkgfxqsorQYCDay6HOJcKBu04fu04W2lHa//Llz4iPlANsTv2YswlsGM2?=
 =?us-ascii?Q?4PQ/PfLMBWhsDThVISM4aWQOOKL5yFeJ7Q33eRaNmnq252Twc1SVxzn6McAo?=
 =?us-ascii?Q?XfJIaOkUCi86flHAYxu49FPmcQuxqywQ5N5H7qbKMU4ZlH1Sn5RRYlroXUMh?=
 =?us-ascii?Q?Mp5GLHechy/NFQtX5p5qdea603we6uytlt0M3i+eD07j0Tyd2tSgMH+Ez953?=
 =?us-ascii?Q?A41nt4U2ZoAIVmEC9wFQtIuMsLcqTedlzlDjE25YzJ5g7y57Cboc5RmDdhHH?=
 =?us-ascii?Q?tf9piFSq+CnjAsbL0fQIzS49qfSSRVccxaYeP5r51bW29FEa7XCaAvkUtOFM?=
 =?us-ascii?Q?isZKp2rgj1JBvCBELQIAlHjKDkXsN54/etQGu3Lcwwa2F7D2roviwtUSlAfv?=
 =?us-ascii?Q?z+DIwnpFZnXhLLIjf/lB7uWcuyWP+mQBRn4lFZuxeiFlpDd2lb1qatFEc4gu?=
 =?us-ascii?Q?zFnyT32l1cIisZjnBYO4Q0EBxfiCee7WPpbwcR8wb7LW9+kJTS8boh9Oxdj/?=
 =?us-ascii?Q?XdT9kaKfH2ifRJMMhMHqVsRtSqmErQLEo1BSjwGHjGZkIeSVpOZWmb24HyGj?=
 =?us-ascii?Q?rgo9HyUtxxUb9z9z1HHfS6+F5CoYdBVrwk4eHva59D74YuB/RmmVKJJd3BO7?=
 =?us-ascii?Q?4L+y2MFtOn68Ze97ei6/PWSKNJniwpUkSpprWboUo4SlFWwLds895zXgNkBS?=
 =?us-ascii?Q?TgiG8Lp/bhaah/g0YYEboKUSUUwUdNx0O+aJpZInp3LaJ08P0VwAJBnf+9kp?=
 =?us-ascii?Q?3bScfRa5cEMT6UmqRnDtQvoRZY1CK6raE/ROr53XcSzqlsW33M5FZKn1rJbo?=
 =?us-ascii?Q?3jylZvY3P1u2Rj4rUIjXeY/Xm9g49cV3rRzn6t9mU8oHnz7R5syV72Dr65xU?=
 =?us-ascii?Q?qZD5GW8rVMDF3EtmDvCpDqIGHGHVZy+9ktmKudBd605dmEHqMMjgzVEGclme?=
 =?us-ascii?Q?zfZnjbYm6lpCCIx3+LK4Ji+OU18TiLoXAwPesIC/lj1GVIginxHI4nV9Gz0m?=
 =?us-ascii?Q?UNmmpIjv8C25pDCF4GaqUbtq8eLQENJw5U2+53JZovAErPtldbXQ3QFIC+EA?=
 =?us-ascii?Q?NqTo7QZxjTYZus7071Wi3vBHeZqw2Ml01BV6y8iLrJDYLqWZw6nYWHSJRsBD?=
 =?us-ascii?Q?uD/sDFFoX8kkGjwtleq14MlpbpsTtqsW5TKauX8bHxM2FNTjvwebFcSG83lp?=
 =?us-ascii?Q?tIvCZky9N976xyzKNvrY99wBGWSdjvmZUj7DhLQpO9BX0Zu7uFXPorgTkt/g?=
 =?us-ascii?Q?Rsbtm3I6rPtRG4m46Cocm9vDMoFA5V2msbzklPTjmCrdh/FmlfpiXsdz/SLC?=
 =?us-ascii?Q?FP07Qg7bovKmW8THEQyv939RSi921n685lUfT30ZT+TJOKjxdN6mSP1GpjFa?=
 =?us-ascii?Q?R3TXr8k7FIm6fHDoXup3UsF9JHd4BOwu9cm+5fwPpExu76VLKdZT+wBJ7eJa?=
 =?us-ascii?Q?D29Es+C47C+WxlxvTv558pDF5ZdH6ZP1QXPBKvGVZ3JvDzjXlUs388qYDggA?=
 =?us-ascii?Q?WVTTAIY7o/qaoSEwsMH96DZiOEYg8NOLXlvbP7fDzXjKMixMuK6X1HFH2s0h?=
 =?us-ascii?Q?GEHuUeJGDA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180388c0-463a-4fa2-b939-08da4ecebd44
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 12:58:27.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxWV1FoIcVcMjLE4Rvd1AWsuOO66MBXKdFi/7vTS+ABzAc8Sn2qgYywirWcz6QZZtAc0qtO7feNTskRfJAd+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add R-b tag
 Missed to add mailbox maintainer in V1, add in V2

 To i.MX generic MU, when linux stop remote core, the MU-B side is not
 reset because of hardware design, so MU-B contains valid configuration
 when remote core stops. Then when linux start remote core again, linux
 may notify remote core before remote core is ready for incoming message.
 So we need make sure MU is in reset state before remote core start. So
 add a RST channel which is only to reset MU when shutdown the RST mbox
 channel.

Peng Fan (2):
  dt-bindings: mailbox: imx-mu: add RST channel
  mailbox: imx: support RST channel

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |  6 ++--
 drivers/mailbox/imx-mailbox.c                 | 29 +++++++++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.25.1

