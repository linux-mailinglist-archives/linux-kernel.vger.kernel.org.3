Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58D4D1006
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiCHGSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCHGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:18:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9A1D30A;
        Mon,  7 Mar 2022 22:17:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhoZO+SC5vDnXITbS99OvwaLqBGhMkAz/r6feAdvmDUps0gOjH8KmBikCctTFW++/1lWErqUoO02Stauzixc7dfOCI35U2lPphqQQBvKyplWckPQh5m5QXBQyXURVic6NJsISplzgEtNxFujBb5IVMDA35ao+e6LonI6Hingltf2y6XbZmsptAEzFkcWjhIBCYkOgXNZF9u56IRjR+FXzOJsyCzTzku2ZCVCOYyoH6erNEqGkrU+e+1V9RDlxgosQzNAU/q2o8wGDQbwjIt041G1owLEJJkkv5vApL2ulBPlqpYR4G8RoPEHaq35LQh1NaqWyQd6hdd4Y7rrk/r4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwPn2dF8VI8vvmwy8Xext5YlnO8ZnE6EA0YrSzcuiUs=;
 b=PQSa3wKBznLEugoyYgryCUV9KKpthLDlKrYxy6fwc2zDxIB/VBWUxI3QRn/xmvsthhkwAh1ayD7vpepaqjwQSGMbbehA/2Q2lu23x4yYJcJkqn02vBZCGFOxdpqS63aQy5NJgtzaAZEJY31dTzptQ6Vsv3AgDrpFj8xfdvKMSaK1b3fjuX6p96mLWR6yw6JKQAUrlclDIaSLosMtIk60inYMRjpMaK+ZLgn5GZvU3c3WUBa0+F7h3YwsUz9ov9oiSmmFolUt91RQrt8/lgxAyXGaOHCYSyvMC/YNY4tpnnRA5ltqqcSeOk7Snv9Is6F59qrfCit66sxmGapI6fD05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwPn2dF8VI8vvmwy8Xext5YlnO8ZnE6EA0YrSzcuiUs=;
 b=HU+FAHDkDsSXNQIyyoC7ZNCYPJGwwN7j6LQLdbhXykbSOUF2UfwJF7LjK4/l7MgZMQTKLpZOzTk4Jz/qXE5In7DTbJHfgi3SAOEcPPB3czFomwcRsEZNP2zIwFibV++66SXp+yEIhmlWNAu0Pugjo62JqSkdMwARk1RQ4GknD9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4186.eurprd04.prod.outlook.com (2603:10a6:5:22::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Tue, 8 Mar
 2022 06:17:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:17:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] remoteproc: imx_rproc: Ignore create mem entry for resource table
Date:   Tue,  8 Mar 2022 14:57:54 +0800
Message-Id: <20220308065754.3355-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87de867c-31b8-4b79-3063-08da00cb59a8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4186:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB41860446B88353ACB90404D5C9099@DB7PR04MB4186.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WB1GbI6bHEHTQPMv0oDvKic4YpQQGvy/6hjg3sWOgZjQjMEYv4dMzalsJs8MQkcN6Ks0ihp82pBtj/XxLpUOVTmkXecQgJqCTsY5uXrSaDEeYMOz0JZ36SHegy0aG1Vq9LKlRQZmdUjwiTaeUbSql3jHehUWA3bec5E1B5kEgWcZkODQw3BZncfHXBG6bZJEATzJyDk85tKEXjQsjshgeleactwGkM79fT3NKO8mnLFXGGmwlRzZt7kZzdsiCtgWxdNTwY8Rh9974IckcRG9QnOF2+mlM/Nf/HbO3yWzIctZWlpyvEg5fk7UFyMLaGRsxrEF9z9b2Azmpd1LkXeKiJpwY8BG6voaRoq/WssgdBXO2Ucb0RsjAY0T5pTuuoTI47CNH2M2LD3rrkvjljRUOdVq/urjQzxWf95143FSjIQP1KcRjdL8zEL4y7pXXkN6D44VI9UBU5DaTzdylQhxMuqueZkv6MYon8kYfZWemRt+Op51FyuALseJ6XpdP4nYiZ1j8ggJ268cKigpkvYSLlIFgzn0jmXX7mzIFzlUGn+t8F2sd8c7yvemJ5zmM303XXiyotGuJNuVe2HWAlH5FydmpsDiqkNwij2AkQi3AqblkG0ovC0wGRh7PDbFY/w49QHcHJ5yEHHf8Z97Tz8y8Nze/rbLnsq687QIHEj0sCmKJayJk2hOS299puJ5c8Q9cDsB68/QUfa8JxUZqWzfuc0TFqqWAz+L6F6fHte/Ssm/sAgEM2YIKLRg/KYohned11s5TNnmK94ReVUqZ2KDpH3HveqK2mW80UxsRWsWn/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(6666004)(6506007)(5660300002)(8936002)(86362001)(6512007)(52116002)(2906002)(508600001)(966005)(6486002)(38100700002)(38350700002)(316002)(4326008)(66946007)(66476007)(8676002)(1076003)(66556008)(186003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RY+6UaL0bfV3br9hiJSZm+WcX17MkZ8CrZUMmBd52NdfOQqc1Kl6G7DAQUV?=
 =?us-ascii?Q?UIcvi4LzcI1XEvQL+CwQ0BZdJDrDwo2/qSJLfpaZSug4WnJAeK42xw9qiNe+?=
 =?us-ascii?Q?gagDZaWrgFkFg6TM7I0+U8xgaOCZ9ceWKUpmEQJLeXaZUOXSFnwbQNjZ2LEq?=
 =?us-ascii?Q?cAkrEI4mT2afm9iY7ZFgx4ROgLCAqSL5DIYO/1rcZEf//nyiTcjDHz6/eflb?=
 =?us-ascii?Q?MDfd1BCUiep+VoEEGNxhvPijE00yFgNimwXG5gQ9eHZwtCGaPb0obTnKHOX6?=
 =?us-ascii?Q?y94vSM79hizC2qcoI8M5SAXQa9jFdBq3Z28YgYmBDDWfe+Lkd6F4+BakO5Et?=
 =?us-ascii?Q?ihIg3LkT6fZ49tkLtt/gi6ICucSM7FnxWOFmxKhU89KlhMHScKbgjZxRifZR?=
 =?us-ascii?Q?hEB8BoQ1ksHdCA0UPPFkSVdzWiuGj/D97egMto1dT1qtb6Uo3JMMWoGC/AiK?=
 =?us-ascii?Q?cVquYKDVVxv7ywO9xUaI7ufTqbHdwQW8Lq3p8oF+UufECeinNdfM1+zrmdbB?=
 =?us-ascii?Q?Lk0rmRwz4MN9fNXOvH7sjD3DkcBcxGa6JIwsub4254RAQPpFjOEeXm0jubOw?=
 =?us-ascii?Q?07P+NFovdHsbYPPF/tAgzs3+kOb/Su03ei1ygX/cOuWeUwtWWzAQyOTk3Cmg?=
 =?us-ascii?Q?cKoyDH2I8G0ife8fcaK+RgQsiKR/KUQ5/krZi+Z22jacTgeIMMLg9o7YtdnN?=
 =?us-ascii?Q?3Bf/w2COz6NPVQ9hEqkx8E+6gXYQdiZkGm6aA60ZObkHOkvsUxgrqiAqNPZM?=
 =?us-ascii?Q?VmJEYM/mzB6Yj4NctupOLtPkYbcs0emjbIXoyuSM6elOS015TIxTV32XOmaH?=
 =?us-ascii?Q?To0admymgTf8LE6UdTB8vfnPU5oo9sglGHmVSmqFu0tcBGRj4qpYdf49hC1A?=
 =?us-ascii?Q?PHXRBafHjMSJ3Bq03ZtvNMr0iyB13JkW+G/HwNVpUiYkgM9rZRJDtLYWbsq0?=
 =?us-ascii?Q?/WAMjsE7BeR9AyOK3IZPu2EiKF/zfINYNkx5GqbkPtZ3A9dpYpdXr4FrCett?=
 =?us-ascii?Q?LpV6DxoK9hi5qTiGwjsmYbR5EIDB4GP5xN/GkLKp6X7jsj1apkJYoOmyQ4Iy?=
 =?us-ascii?Q?bxqVmUnD9fKKe3Yah52Ltgfy3cJUCd+wjbgRK/RaghQm6sgUeJrrHSKYyLxG?=
 =?us-ascii?Q?1o5Vbu8FpUSpx3ZQX+XrkhkiOQXgrjJMcbril81Y7pfNDx1ysw6uG9DGibBC?=
 =?us-ascii?Q?NXo8J7EeiQ8cZHfjbvYo3+4mDzbgR8mHKyvjHrZPexWjNe7/ggTmYIt/WO8Y?=
 =?us-ascii?Q?ZhriEADE3DxOQx/sqnG3okH+cMz8SgGK+VxjpzTU3j3iJ6pEW2gWCWgexK+t?=
 =?us-ascii?Q?8dtDjSSesQQq+PHLj/eiiL+Qt5KsAVvGD8K4IiWQv98PfOsY3MtpghBaawg5?=
 =?us-ascii?Q?S18E3rRWLpT71j0PXAS+vQjCMcIEEJaH+3yl1kBmqOc/IW2g/opLYc0RoDSp?=
 =?us-ascii?Q?ujs9oU+lsrNO9/egN7OXX6LbKh1j0/j5sqrJdllRCAQSfn5cd/20HK+5yJhA?=
 =?us-ascii?Q?oHcY5i2SDz8xlpUMwTtNUJdUw901Fng+A5DnYC4oOByecba2snEMuW6HpXJZ?=
 =?us-ascii?Q?Ex6PqUv9DGfDbv2QuLKhrn1DiDqXSz5IA5QzDVen36WvGc6x/BqgY1y2HOjh?=
 =?us-ascii?Q?/XYnmw8YRrIDvhJihaK7eZg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de867c-31b8-4b79-3063-08da00cb59a8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:17:41.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuE23wX+K7uKGdIEO4CyXqxxYN+w0f18tK1s9XIHrvq3nSNMK5jn+9enDWx0WrZrfJXDEAkJhjZEHYoIBwF35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Resource table will not be used for memory allocation, no need to create
rproc mem entry.

Fixes: b29b4249f8f0c ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add Fixes tag
 Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
 Address typo

 drivers/remoteproc/imx_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7a096f1891e6..f2bfc9077c19 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
 		if (!strcmp(it.node->name, "vdev0buffer"))
 			continue;
 
+		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
+			continue;
+
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
 			dev_err(priv->dev, "unable to acquire memory-region\n");
-- 
2.30.0

