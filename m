Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17059F088
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiHXBIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHXBIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:08:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A107E819;
        Tue, 23 Aug 2022 18:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSZdCwnYPvqHkGd5cGE0g79bZcBwKwqhBpDGLqERZ7dDTA3LjSWZye1f19i/BgNCLvNbOmdMwfMSLKmKJ6ArUImQ7cpYalrOr+nN7YajmzT09coeVH5CcOhM8a8TnNRrJCPykLBhtLyxuqRhn+jaF/OsGw+EnfM66ZhLaSFLYAT8+Uj3SUwhZkTWe0K0h4cNh/F2GbhjA7CrUTDg3P2qT5kThWRas3VdhkURiTvcKp9E9R5BKFREhbetr2DRtLhKVsGJn+xjcJRS6fZbu0uebOK1d8UWtNlsgH/2vD1r7zET3mBLW81PEPKV+iNr3HT7U+eDbf97SvNZNN6ZoaVALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr6otPP7X96FoGUR27f9AgOmzy7S1YfB4BJ+crTWnFk=;
 b=EEYkJ51aLxeugxqJeLblodWOcArlRYQ+TfGsCCnqydI8OlwayFLCQlhkYdTtJBZ01swokC5CCsChKzCzGKfJmAR9EOicLWdGE/n6jep+8HksEzblg2h2RjK1omnRvEBgZ7cv6bCPNxvDVH+DuyUAtt3YnIpMz7lKHQ8ET23iA5LvaWTAPxLqATwjYTgudetzf3NdyEh4PqV8H8lvcXcpWg9k5q208OanZkuBvtjGClzpNQpWbJCGuZUpbYmO1itzjoCIMChfTRWuE8iCD0QGp9Mb2vQIMjaUWGMTjNNTiIqHdD1/jj8aB1kb7f5oF8MDobwVPRbIFuDGGN4nG38vGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr6otPP7X96FoGUR27f9AgOmzy7S1YfB4BJ+crTWnFk=;
 b=lt4N2OKJy22PAbDPJsZWrf45ItI34AL+vipFtGfgkfuLftsDakeWJw6NCWDNk7nkAVULiFBWImwSI437Ix7lhOCpa+ozrq2bH1LQ6BqF+6eck9WVSE+SLOyKGL4yZHI7VzDc1mHMVYJm2j4DZ8s27s49AUV5NmpuZniQvMcaOIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:08:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:08:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Date:   Wed, 24 Aug 2022 09:10:17 +0800
Message-Id: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17835e73-445e-43e4-2128-08da856d325d
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1w9RY0QTpx5tOajfX2j1QflDzI9Gr7ktazWIvtabexdq24nJS9n2iJt/Zl0uSr9hDVgtPqhzcX+GMMqgeMocC0JPkqYk+gch+QeuBMw/ZALZhsl1mmrgoIwSVVN3TcpDG9LyC14Jy9dBUWQ4n8SWR3sjb0zdH1d9hgiVD9IkJrZEJMQGCbI5pnFL3yfp4MZQ6VIXJK47jlzwTdBJ8x3tuCloxfKAXwjj/MK0fJWGITZO/Ug3iBhmvSzUOX9/9Q25DeU3T1ILtJHscbUJ3eGMD7aMVQYaFKP5aRww6V12sLRbwJ2qbdKiA+jFbYYTJT6SjNp+tbWlRU1t1/Uqh/35JhH++2fBs+c0XujMo/0OgTVCWLHkT4BOQu8PMJjWFbCBdVPcul561aDpssp8W13nfgVkqitCadxbemoQFTlfQGlmDvpJp4UFE44crYODYYPkwmr4L/NRwngK3TcgZMndhumZ55KfjsTJ1qoax9Xln8+PdSrWeW/CANx6uJ6VI5/R3t7G2Fl6hsa1cSLhLctdQQ70/P6ITk7ZTqF7W4HUazf1wTYUynzr7IjWhhcXV0uMjPNm13OndIvEc1ZQPgI4c1EF8kNyHbEzX+JKjCaRLMHU/sW1evhDo2Y+g+j7MsgZFaj6LVG7SJc/1gMx6dXratPTLyqCVgdkpuBqRrlJleo0sSzIskcGPwkn7QF90hZxGhQv9d4FtBjZrNpBXd7QVE/KPQH/WhuPxlL0NWJT+pYk3qwilECvWzcYzvW0bpJqhasnsBvGqRuBx3tzi9BJUAb4hYsyhhFRXhM6nCGOuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(966005)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nE3+HpeWPLMou4nQ7b2rit7EcCM9WtanoI8PjQiiOOmAfsbzrL9x85jQa4D5?=
 =?us-ascii?Q?tgxvryRLyhKKUkjb5wVwxE6kpPy0JbMNAsY7JcNZyF7TddOAWBihpsAQKQTH?=
 =?us-ascii?Q?0rZzaE6SYYmGt4LVKZYn0UIjficAPPP63DwmRFdwt7wsMuZKTcsB2Nv4d+Do?=
 =?us-ascii?Q?ycrkxfuuFFmX9Lb1kwsFpT9y+684potxHPkBMg3SySIXZhaf9rvYgxf/w5VT?=
 =?us-ascii?Q?6YAlHu3h6qdp7LwfoA8NeLl3jtVyW9UpDU+ePgBbrdzTl3n4poL95EK8C7Cx?=
 =?us-ascii?Q?bZLEeOnFnX9vGby8/Vd4lEc/4ZQrHUTKIshQvaRXeUkua4QcUCJs/HPACctR?=
 =?us-ascii?Q?JzuIF3ZFspCmVtPgTd1jT0woTpoF1XtY7EtKs3XTe9HCtQf2v9XBT7EhQoFz?=
 =?us-ascii?Q?BFeNR+67DVJHzjs5pgLkX6UHC4p+lf4zVawANEZobgLFR2XSVJoVt/95dlEw?=
 =?us-ascii?Q?zJ8u4BuY4DXmGR1Yw20vaiXDjU3vlHlMC5175nXj3R2UDXqWmbYh4YkAu/yt?=
 =?us-ascii?Q?l6oYdEco2mhkS8+tpWg1DYThmcjnmcUA1FVnazRUfGdsf2D4FWtdGsk7r6XV?=
 =?us-ascii?Q?hsiWRiPgophkiIcnjoSj55bJr5reAXmRbQstcuiw8cdV+XkvH8ZhueIDpg3b?=
 =?us-ascii?Q?LmM7HiRRY6IpHXbYpW+sFk9Fe8R4K8lHFlOIz9/wCT5jeL+Vm1+5TSRDykzs?=
 =?us-ascii?Q?7Zt1+3sTCnt8aIJfSXmVSrQfiRfIptySzpDP6KX1cBuSKvIsoblgxWBjXNjw?=
 =?us-ascii?Q?UM9axds9GH7ycKHfl9oDcKbQtTzxdgKAkNPS3G73iMm0lg447au/KDGzALms?=
 =?us-ascii?Q?B8/yJn3eG8+zx7WZaHfFiPin1UnQs7TH4lsoIN5pVl1C8DvqqsrJNLhUmJ2r?=
 =?us-ascii?Q?3hpItjyCZXte/RdQs4JjbQiC9MA8dEpEYsnBV64vwgcIASu7ylOPPloA9KpZ?=
 =?us-ascii?Q?0aTT4/Dtvk+GQrftB1MGRfKaHIYj75GSZQpOPG/Yr8C94bcwNaa45lodT8W4?=
 =?us-ascii?Q?BfrQhqB0UUzR0DEN4BIDO/tKfgo9HcAh0yIyzMR+kKIuh/nCWaRykuisgKwm?=
 =?us-ascii?Q?o4Q2iJDv1+faxUvaid+e76LFTLZN5R3A/aMGPTCQgB/s+7MOBVOIehSqmkXa?=
 =?us-ascii?Q?xgV7gPJl8LZws8PAEmRuHtvKn7vt6FmCqTNyXWP15qn5v9YFL2Lv0J9ShkmD?=
 =?us-ascii?Q?WzGGLBkHDVZxPZhuZKlkVPQNC3MkltmoKtyyn+OBINcLsN9e/QPW78PyWEdQ?=
 =?us-ascii?Q?4bAl67VmCr1J9zsQJlwrmiZ2jsBH7hKrWSisVx/1iSNTs+LP5XH3sXv+qgQi?=
 =?us-ascii?Q?3cUf6fojlEbaADmCi29V5vFsxzRfeDhfi7z+GFwUyjl//K3tPDFUQWNvXnHo?=
 =?us-ascii?Q?uilE/cDc4I8DiOYvAZPKENMsTr6Jt/yWlm1mY40vxOjYrpyeufxMVN8DZpaz?=
 =?us-ascii?Q?4UnW5YP/OY1nUhGlxFhypJfWo6sL3g1Uop/XggcwP8WJ3IXZ8lqWPoLJIUdP?=
 =?us-ascii?Q?0zRcmsBR2q689YMiVvTZKPXZNNSgY8DYZ/s64lLSoO7Lo2IXoMrV8wyuVOEZ?=
 =?us-ascii?Q?EA66cbgXEqUzemvVm+IzH6pzpEuZntkg3ZsAl6k2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17835e73-445e-43e4-2128-08da856d325d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:08:47.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AZo2SVIOEgSFscRFlCD0SJ4Z2hjM00KgADYXmuyP5uWrsZ3Snn8XHVrAoMV+Mss1TH7toW2FatQfz3w05r9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 The patchset could not apply on latest remoteproc for-next branch,
 so rebased. Only patch 6 has a minor conflict, other patches are not
 changed.

V4:
 https://lore.kernel.org/all/20220701104725.557314-1-peng.fan@oss.nxp.com/
 Add R-b from DT maintainer
 Fix probe failure and driver remove path in patch 3, 4
 Add comments about i.MX8QM entries filter in patch 5

V3:
 Drop the dependency in V2.
 Tested on i.MX8QM/8MM
 Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer
 Drop 'reg' property Per remoteproc maintainer
 Drop mcore self recovery, until we land in common framework support.
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220517064937.4033441-1-peng.fan@oss.nxp.com/

V2:
 https://patchwork.kernel.org/project/linux-remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
 Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
 Tested on i.MX8QXP/QM/8MP
 Addressed Mathieu's comments
 Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
 Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
 Update commit log
 Drop magic number to get entry address from device tree in patch 4/6

The V1 patchset:
https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/

Peng Fan (6):
  dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
  dt-bindings: remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: support attaching to i.MX8QXP M4
  remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
  remoteproc: imx_rproc: support i.MX8QM
  remoteproc: imx_rproc: request mbox channel later

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
 drivers/remoteproc/imx_rproc.c                | 261 +++++++++++++++++-
 2 files changed, 270 insertions(+), 7 deletions(-)

-- 
2.37.1

