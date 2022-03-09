Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C34D2CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiCIKDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiCIKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E21704C6;
        Wed,  9 Mar 2022 02:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCvV8gsX23iALyoL2H3fGo1gzqJuBa2W/uGmQfEW+QHywsfax49Wnfheiqz3kDreAluC1bKkWo9DzvS7ad4I6aO+apUMNrxeCNIZcF9pZcOLnXH7weUweL4pYfyrxmSoMLEIq1BBaoUuBGuM66dcJ2+K8Ef9UYuACe4DUr4ecLjixk7GwG8BEcTCPekCbitZtvXo9LrqoQMApmoTUnjRzboeJHc8dJSr0YQLL98obUS/XZ6Vbi59d40YAV77nyfkzf4CMdXBWy0YsGDMgzBeJSZeGbAy0nKJUXYkKfKkoioY5898+Pu95X2uFTzFNvE/7DU5IIE3+9QZNJtngkg2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJg3WU2tQ2/iPm9cEDJqrLODA4JiJmlWXv1mIeB8bWM=;
 b=FgcIbx4epkvBZCSr2BhHLfTVUMXVyYyZfkvn67N4tLvk/c2Nw70fbVnm54KkoDuXBugaMhO6pSzsY/buAabmhS2Spwi5JRBRaa9aJsT3gTSfaxM0tPryThs/yGnXZGP7A68wnXsaRKsjlUNybxmcByETIeAoQeqo9GqRu2Oh5Z0I+c7T3UD0300i0DSR18jnSuH/LxPDx6mx7dg2tsvwyrtXyq10rvPfQffj29KniRq4OgKj+5Wo0BOwKMHmraV5SH+uhnIXiUfwj2AbsDICHV6IRB3xuA8eBZVf/l8+FC/DUqZvVLbwhPnfLAsYSEl8hQA/yJavPkslpPvFcuh8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJg3WU2tQ2/iPm9cEDJqrLODA4JiJmlWXv1mIeB8bWM=;
 b=M6UNUv7aWhM7iT+SsHHPA4hIYPJN6VDSGNqJJZ8eYuX2Rd8eUvJ5s+q5gwQN4VFRFesFr4HV/qHfA5z8sGgalpB7SJgO/ZLeCDVka2C4JFd05E1OFUqVIsCFAxRZ9kMu3HsR0PN0NoWgmc5eMKRNQ61d+5gPCvhFzQgvKcKKkDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6724.eurprd04.prod.outlook.com (2603:10a6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 10:02:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:02:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 5/5] mailbox: imx: support i.MX93 S401 MU
Date:   Wed,  9 Mar 2022 18:03:45 +0800
Message-Id: <20220309100345.2633862-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
References: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc1b000-f30d-413c-fb21-08da01b3e3f8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6724:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB67243BE17D8980E91BFDFE27C90A9@AM0PR04MB6724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWfmzEDkH9IJAhvdjFYYrBnTjulpL2hEgfEQ2vWKCUIc+NH6wIMJRJYQn1k4si87MoZCtNp0QXZ4jeEZQs6wmTr3pI1vaDgaPVHKoFHpxLeNJxVb2XUh/3TQficVicJ+6JRoSik4C3U5nacOqn8mOQzUm4i3QrYf5ltvedNm+4BAVoGwVcBuprJX87HDmcmNE+7iQGq2wt8YrB5AaeAAsT6SEhtYFG6/ok2Vn/EIZWNNS68G0CWU7ApmT0FN8Vmcdr6IaDWqKjxD73fcWqblL1bDTQfp1Jz7Z7LucgjVJwM7NzRRhfHlHi11pvmulLAGtjrpmcTgBG3I5MmRxPwxZMZP6IaXX5PAvslLXc5+hiOHMCbltwsWO4rjMUb/Yj9ow7OGEWx0daPYhJedh8KsY+9rBIgcxeexEDourQpHcH9bwE0DxMFHiacmRjLN+6MWZTWzhkHeL9jqNrarqcz2sXoseA3SPhH20YMQXGUBQTXxJfm/x4toA/NYJXsvRpe1JLteMBr9g4ZGXPjz4EFlxKY65lYc9mIhGoqhyRJqvX76vhsP/xVaqhTBUraao+iJHaSjL7Gvzu90P1gTJnzXkEtkiAPIMmZ11g5iiY4091vaVfUysvgX3VeNRq++smplSLa8EUIasZ/MLIAEtP7/rWffgVqnkmYzTKXqeiU1JiGyyM3kSJlsbgjQ0g/IJs1YWLkblEHuexGclpoF+CUMig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(316002)(66556008)(4326008)(6666004)(8676002)(66476007)(38350700002)(86362001)(66946007)(6512007)(8936002)(52116002)(6506007)(2906002)(508600001)(26005)(15650500001)(186003)(1076003)(5660300002)(83380400001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E3/AH2qzRdc5zLcmYyRG2LUoSV6JKxVDZpEIivmgLXVcgdlqWw3h9Yo2vOuF?=
 =?us-ascii?Q?6gwDklAcwzgG/53syh+ouNysFWOg2cUmlW7O6Agj1Ei3ahTsxmXwRpIIBLZp?=
 =?us-ascii?Q?hOx02UpiHkXnLC+8aWwhauF7SJZIH8XMmcATp6AV+WObwfuxSPvMgtaGzeD9?=
 =?us-ascii?Q?uqJeJSWYpHp7gDuuFJsGzdPEeWHajVB4yT0Eiu0NncT1MMbI7Awacfvk8LF3?=
 =?us-ascii?Q?zYejRwUaUFCqk9jOQVnSydDiAxOJ1tP/e5vZcco1T39E8cW+VaaPcUDmVdFe?=
 =?us-ascii?Q?KfLydB0LEd1YGB+D7/SwV/qpQJYc81EJVHInFJSWsb0HF46gWm7juxPE4S/D?=
 =?us-ascii?Q?4gwJjxOiEu1/44YsAtPCTeIgrNXDBDjnuO0GPq00vEzV4wC5jk86f36Shgno?=
 =?us-ascii?Q?NHM97me18nyzKKEDDeST3az5IhzR3VVGaQ7KzRuLiTlcQves11zh47OQMKr2?=
 =?us-ascii?Q?oX2O9bADCB9Ni0gPUE0eQZcwliALEF7Q+iborgDeqUOmVW8cgMgQpSkswABL?=
 =?us-ascii?Q?aNym/t7uq6h8RPm8JP6hsi5uzKRQ9cEV+sn0elfuVjmWMcApLjCkY7GuPAf+?=
 =?us-ascii?Q?wcH8kDHEHFNsAUmEC+zh/rFxY8C2ZRGtXdPNPktqtzNelZ5NOnd7FaMTV9jf?=
 =?us-ascii?Q?JmMss7zz7JxCfFFJuNaBBgQFb1ItcXtEO835yDqbfK2WGy1TKyGdL+6wNnRC?=
 =?us-ascii?Q?VUTxRgZsdpe+aGy3rCdUZuzsjbAJn7Ck79Lwj1LPp3DZesuLVmN4bfc9CWQz?=
 =?us-ascii?Q?hJ6DWKAEgl8cMAimQyu8BDTr+WzG+2KIGA8IT1bZ2fZRzFv7ryAUAqMmrd+o?=
 =?us-ascii?Q?usP5gTTnFjSHV+QJoiYnIcqp1kTin8Kq3XJ2vYkW7qDdV8dBztPi1js+UKSN?=
 =?us-ascii?Q?R+373T+CUYyh7+83rKRax8R7+ul+7SgciTpGKFObK1XsbGhyCJ3bgKRKkIvx?=
 =?us-ascii?Q?VMSHCOStbCJwHjr5FO3Ga4FBJkhA9jE8EMpIke1QKCrY6TJpJJOlVCN5NF2U?=
 =?us-ascii?Q?hdx6JbBGmLv+t9Tt/Izw4PKUAhC/2VcxTG/C4Th9q+Y20GPGvRqVAaZZHSCl?=
 =?us-ascii?Q?d8WPnMTXcyEQDDR4Bxg6i9Esk+VUf3zfaVBPbjiCQnfAnXwnCqZzcAGhpSzL?=
 =?us-ascii?Q?je78iIxxUw59gYkQhqetCc5GSYXEspTvNO+YuUeDneqMlXWD8zgVlTZQwamy?=
 =?us-ascii?Q?dAQMgnzRNdjvrs79vgl3dQQeBWr3RWTrTEvpF5xEQi/nmkpO51D2yeKKFNgJ?=
 =?us-ascii?Q?P7lI83YncIduTnxb+MRI0cjfTolH/2hXmge3qiN5YC50A/sbYY++P3Lsh8Ce?=
 =?us-ascii?Q?747/6lunFmWDWjA7MOePPUPmRFN6A63v7OmzuuRUu1W/xPk5ri/CXyEwd1W2?=
 =?us-ascii?Q?TtZXdBvotjGp9H7zNNiMJYjPfGKrv5TF11XGzza2CWGicgZY3Qyp7aM+c/oo?=
 =?us-ascii?Q?H1s/4GrU0fRm44LfZvHYqZxCEhrENU+Q7hbmnobmDdl+LBLqPST8X1OqzCR8?=
 =?us-ascii?Q?aR7o5+nXcGU8DnsY3/FZu481LzhHxV9LfWNj5MnyAK2VlexVDq0YkLFdPDJO?=
 =?us-ascii?Q?ccmg2mPG96yIwbLD6cig7zVtIVI233MIb4ZHo7OV3a9DGgasMm9sX9y2Q66v?=
 =?us-ascii?Q?T3Kc2+WwcgW8nJzUqtRSKFQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc1b000-f30d-413c-fb21-08da01b3e3f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:02:16.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l977N2phRsRy3gPU1I+UGKewkhNj+DIuZLf+I5aQ8WeIJgyvbuAcdcEJOLW0WQwaG2DOlZhfgQg3qa8gUQNpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 S401 MU cfg

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 24977d66bfb9..e88f544a1548 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -905,6 +905,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
@@ -932,6 +943,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
-- 
2.25.1

