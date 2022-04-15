Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2D5020C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348947AbiDOC62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiDOC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:58:26 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20089.outbound.protection.outlook.com [40.107.2.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D460ABF4D;
        Thu, 14 Apr 2022 19:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVbkSQGDT5gq4XyTAX1X1DATuSbPJ2EJ+mmRzQiuEzqmuqXyt74G0GcluKfN1FZlFZnPfORJYens3q3zHYB0v/LvX8ahtVmZaMzXcdRze+ibsv3jXHf/OBX7+bzAN5e+BmWOIxEeBuTAVsd8KYcZuBmA16FWTKn3dSQGBSH3Yfb28vaUOXmcl8SsxzbNHhJ/hOcZzMiTPDFqbo1SduxWXLRlgZvNAIw09ViZQXe/3x5ZTaRP6en627KlSmq5mcGt3zYxZI1VywmTHYMxd5MW7NIWJ1GGJfAdQ0+zt1gVxOXWPLAHjl06kdCB/7bIuP/HmosPwjTdZU48kayd+nSQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPyAaVg9yxKBVGBVgfUuTnvqfUEJukWEwsKxvsu9FEs=;
 b=ZE87wXzeSIDJHjaSCLIiYqnGnkLnRK4hKAI0DPWymlGTy34S+ZiXAHk64SZUHUyS39aHmMOmojesNL2DB2K0mkqqf8arOI9YK3MaDBTEc/DKoPK9D7XiDulSvly8uikA4X5k0mJTjobzAkWX8Pv8/81DInKFE1Ygun0UPBkhTxSu5+T6oesYbOAp3UojWFxuIbgbgr/oEl4QL2OcwQhO34OtO+TScPCJLFAFJU9AU0q93ti1FvmCVihyWtsGwoKA0Ls7TTsmLtG6OF+/RqMipwHKv0JGJrSqI/K7qLs0w4jqsC3Vzn7iADN2iPjtjJrSS2Io6DZOQncibfOVymCQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPyAaVg9yxKBVGBVgfUuTnvqfUEJukWEwsKxvsu9FEs=;
 b=IZZ1vr8UzDIL8BeF0Lyz/tulYuI/ADgcG0Wuw08ny1FtppFbqx5nHaQCrbIANFIUEFJTj/dODeiRC257dlJzcO8bpip0kuVy2+d6lYkL1ouy5NFEsSoK2Py54ZaQgR/QcSLET3HpYGtJXR3p4qOD0Vh+kYLdI7XlV3m6KDuwsJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 02:55:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Fri, 15 Apr 2022
 02:55:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4] remoteproc: imx_rproc: Ignore create mem entry for resource table
Date:   Fri, 15 Apr 2022 10:57:37 +0800
Message-Id: <20220415025737.1561976-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11fd42ad-29cb-4bd6-7307-08da1e8b755b
X-MS-TrafficTypeDiagnostic: AM7PR04MB7109:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB710968ECD5C0647C0C6D89B3C9EE9@AM7PR04MB7109.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iVDSs3nwCoY28Eu6WzK/4bdk3jef4GXSyyuLZRNbOsIaEk1jP53vPKquikarO3jv94k8PqWtOB/56F4v3eJhBpiTn8HY5vCsbJRXKLJ76ZwrglYiwXHtgZrKVzZX0KwlbFVxKqbIWMkPZWFuNNH5SCWIyyhZhGJrbrjFS0C8o8b5tKXUG0MatDeZO6QzLRn0ItwzqiXBEb+Xc6jTjdw5K8kYuV4JPqzafrLeyspQTv6ZIDVe0NIy8EbS7BWvp3S9JChste1vHkY1w40Y8BN17MgoDbcXRhSR276RZ8xPcNwmtP+LOPqNJeKo5nf1W5+B/LlaRYraqUu+NlYLI/Bj9ue1pPmsvIITS8AHNMIwW5+oPNSZbsfhd7XTVY6bH8WDEZAoyNAMyC/6CHSsv2rAg/2DL6TzWD4N4kL95PhMM52yLPSU4CgkU9hjzG+uSrQPf0QH8mNCEVUoPgrrWC6xUsPf/Y2cCiJXDrCdBJzUmYXUwjnGJfO3rcgNJCTilXwOgT5nPoy6vc8PvSFQzmJcSOsfKrz+8HUiybMTYvm/pdNQTMDZfQeqa9ZevSgsZGJR8tGjPnpTWWuXP9Bq8CYUgi8XAAFTMFgoD9neKDQiwm7IgQmV33I7CSY+Fm6Mz+P5YLFt5a3pTwp9JZ0zQTJyBLLujDMKAHv3tECVa+/cZS+zX7c9H7MkmQ1WifizuyPy1x6cy3l5d/aoWjqV6TGXOPtaDW3ay2qJYZc88wR2IyusC6KnOmjuEp53ouSl/1XjP+e0AlUcqPK0XpkKFDpFw9BRu9Zti2IxqsXFkqW8AuwAjh6+qdTqB0u9Q/IUugd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(186003)(26005)(66556008)(83380400001)(38350700002)(316002)(2906002)(6666004)(4326008)(508600001)(1076003)(8936002)(52116002)(86362001)(6506007)(66476007)(66946007)(2616005)(8676002)(6486002)(6512007)(921005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwDf3gD/jah/J2ls4ekhjC9CpDlvkSAkYRpOdkkeU2Zm3wiOpym1qn43hrzz?=
 =?us-ascii?Q?+7ngSMhveDNM2yHth7ExWLA/dYXvm2e15kCtwFmyVEGQ8Uxd9/9tIq1HSGpp?=
 =?us-ascii?Q?pdX87H8SpTw3tMsH9sNjDErBjZgyoDFz48nsbyRDKNCt89OCsMp77fXQi8PR?=
 =?us-ascii?Q?nV9mZDVH/orBvftkYKxIXnosHjHfSNDnHTX9Dk9/ZnN94xqFs2LsUinrNAP9?=
 =?us-ascii?Q?5dvyIle9svQHLDZ3i12WO4aj9Cm0rh3swpW0qyYkihtKGcII7WSDeFxhruLQ?=
 =?us-ascii?Q?SX7PO+jzBbCA+zziSw77s9KDJSKc13AmCmCftEKvCXDD5TJoXdvdxokiy7m/?=
 =?us-ascii?Q?QPFQKtpqm+DArFV4ShAAMxU+ZL3oZS1fI5IxL4qjIy715DskIj3nbuPEsr0n?=
 =?us-ascii?Q?kcK4A6r2/Ra69cAlt53ePC7FoE9nxLBD50UiLpqOlbmE/QJtuNVhc/gRmANd?=
 =?us-ascii?Q?hBHWCoxaCDnjrRadfmBfUptnh3jzGCvx0fTLA0uR2Z+JnGpXZabKDet5ZOIG?=
 =?us-ascii?Q?eZ0YcCMQyigoA60B2/Miu+xAaXM+tvvIdQnO6TO+gkaQvW/DAjJq2eO5CbYu?=
 =?us-ascii?Q?gQO+HpZryxCX2uCDGKCN7RJ57dfwibD47Cn1T2nkoHAXnNjyJGdaMK89yWa7?=
 =?us-ascii?Q?/ECOMqmctvjXW8ZlM3yOrkWFZbYt16HeuQvsn52eM+AyNR9GmQ3Iw7k3Qi9P?=
 =?us-ascii?Q?T4lehu0+eAYvhCCG8XuNJNuQj7g9wqZn1kL/Ky551DF1g47VaCfaGLBJCohz?=
 =?us-ascii?Q?vd+P2rDOoW2t0A6/d3ST48wuBNDqMWpFYAN5Q7lD0Bh4bzuINaUYtAu3/11G?=
 =?us-ascii?Q?yLtAJk9quR5ZBYS7sQbEnTBKfpkw0vxNBKLzrcKni1r0UVQ39/4QE6pSL8gd?=
 =?us-ascii?Q?iRG4YNzj5gq+F8Qa3dCP+4S3/1YWEoZWsJvWSfjT9+eER+/+WLge3n/lRe4f?=
 =?us-ascii?Q?bPkB+3FRkRroQvEyt3yKYqn8MftFOn97b42RPvqGViqetjPQHYho2r7G1lkC?=
 =?us-ascii?Q?DXqO9SHcklFmWLMxAJM11edUha6XNuAD5k5znmmDUS7lvRBNk4RiYpunEV0d?=
 =?us-ascii?Q?DIAoNsFDP5eNp8aPxN68xrdhN+xPxFIAqNK4JPL8FUPWN0EeViRn+mLPRKM/?=
 =?us-ascii?Q?chfitTyBIbfC+dGr7vSFN2tmGgMqn/ThcjUBiRS98ZBm1xy5b5T1Z5nLYg93?=
 =?us-ascii?Q?tnub0LZ7Tnyc+gX2u5sWJG4vudAyo5966rp6hHqP8kbAWmX8LJIG9JEtyfT8?=
 =?us-ascii?Q?9y0+uCztsbvyJGIc77IpCjA0GeRT8RoYnowe+YK77QnFbuG/PveaH34OUpOm?=
 =?us-ascii?Q?Omgo7nAQSrLO34j9iAYlanWqku6etX/qbi7Hq8pj1kSxm5u7dB0XetGCsnEl?=
 =?us-ascii?Q?7XNQj5kSSrrxtKAjyVtBM2z8SZLk7VAvsPR7GYB4rBGw0s8ezurA3kLdN9h5?=
 =?us-ascii?Q?iVeM/waWAINteSh7fVaChhueGIy2/c/g++4KUYMMMPnR7KwED1eFEO+LRYon?=
 =?us-ascii?Q?PEHkMzZVO87LF85UVwYof7xsks+ugDC1h3oOV/FiQlwNlYaw96gXCnirjkox?=
 =?us-ascii?Q?PK+ptKeyTekkaaWVTWeCO72bOiktcd4prwKQ5CNQ1mLUlp8Sm9NW9umg6N62?=
 =?us-ascii?Q?pQ+7vIcAhASJc2SQXdkqXSm4kIY/Cogy2zOIQdasEAm8HCKUOuWLjU392wt7?=
 =?us-ascii?Q?X42w776jvaI4FeCC3yujc6cEx0e/1273jP95l1VR2CbkhMpTIXCCxJXpgdNe?=
 =?us-ascii?Q?rF9ypUPhyw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fd42ad-29cb-4bd6-7307-08da1e8b755b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 02:55:54.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rJdfNgEgj1e/vjHcREpfL8wYGFhTgvwI1B5OGoVsvEbiY6QU/LvQATzwW+VGEmd9SuQ8L2Kwp0zSCnonaMkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Resource table is used by Linux to get information published by
remote processor. It should be not be used for memory allocation, so
not create rproc mem entry.

Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Typo fix
 use strcmp, not strncmp

V3:
 Update commit log
 Update Fixes tag

V2:
 Add Fixes tag
 Separate the patch from https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-7-peng.fan@oss.nxp.com/
 Address typo


 drivers/remoteproc/imx_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7a096f1891e6..91eb037089ef 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
 		if (!strcmp(it.node->name, "vdev0buffer"))
 			continue;
 
+		if (!strcmp(it.node->name, "rsc-table"))
+			continue;
+
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
 			dev_err(priv->dev, "unable to acquire memory-region\n");
-- 
2.25.1

