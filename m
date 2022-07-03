Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25088564633
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiGCJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiGCJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:11:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5364F6;
        Sun,  3 Jul 2022 02:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es7T1RqXDqTMROOcpVsjt5WrhxjYUkiOAITDbcEp2yxfdgxGUNiYug5twtZtXjFjH2kv2kFhIxLnnH8833ZHW9gu/uF5UclbI0Q5xOclPIgzz/JX2jwnH0RdjPNxmjARXbLMjj84Czirzn7siHQJnaX+yAiTniri/3OhVkwzsMpX5bF5sXcUK3UgWLUqbws3JeCM6RWWQPTxvJRgI1BkeAN9Jo3rD6PBjgmCOpRiSnih0zI6+tvEC2WWmYOvykksDNAnce1Ld/Nuq2RtcjCWpaghyREe8436/GSI8XbqcTve7REaRdlxSbdcTAyf6zq8/UBiMk4TgWfBmkm9/+hvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+pLJ9cZ7TpcfkfgYkVBDnv0jlnVX+PnPWhI+VDC9i8=;
 b=h0pek6eNt/QpJtsrUltUtkMQlEJXdEWZzhSi5D5Dh9FdCTut79VsM2TqMN2B4l+RpEWkk98q5ylXmeN1iolFWID78gj/htaM5JlzqBG0ACRDUCOw9b8ebfpTXmfdh0PHMkvFqBNmRvKGwy2jju+VXOsPirlpSC0LQb6+eWcDZGyFoQCqktpv13c2tPal3DWv/4CS3N2ZFBupqWxDDCLsaS20qPk9DMquCiyhnFygYZabdQFuJhKz+IYo33V+b2GZKTg+RYyB/iObNctIOvGSUO5pcv3vJ89ebKuh33R9ZcH82I8FylYESw6HfI8Mpd+gjPPRtbeMCb14n8/RQTPBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+pLJ9cZ7TpcfkfgYkVBDnv0jlnVX+PnPWhI+VDC9i8=;
 b=dKq7GyZCXlEqOZASTWMYVKQ3srs5JdRdQNJUdP6CuTtP7ylgFAc8Dr1upLPlPY2jyszVG5g6NpE3G9fs45cAUaH0BHWNATymGJrLC7zzxPf7pwGMjxKUh37V8L60DkmQdEG8NUL9bUBCBML8xyJn7lbrIcyyWNUFMmxGL8zKiSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:11:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:11:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 09/10] PM / devfreq: imx: Register i.MX8MP interconnect device
Date:   Sun,  3 Jul 2022 17:11:31 +0800
Message-Id: <20220703091132.1412063-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b2b8ee-ba55-46ac-9e7f-08da5cd3f38f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvhD0Mp/hXW3RrAV9ATvuUGUKXM8KWEfJvUU6ICB+9wWREQKnK/Z6QLm2SnAF6WieTFA/JIziSvvzpumS+rEuDYPwoWdKAoR2t3dwAYA1uFfaOhepesAcWZt1VWbbckB7gT/ZCAHshMJbb31Nq8FN2ZAampNpqV08mLh/Qp6/39mBiyUVmqFm14Ke+3qIh2SH5I3Hak+ut3iN5EgRAeJ+D6v+qHZf7tiiBbR6inv3TSV8rODfsMm7Mw2QKM6d1iFU0MLu0EgeHuNoTmAFRBTBbFByvuXChkaqkdHN1LExaROXpb9EM5WEjYa1oDqzfG2hSt42IOZaMmDzYKKZ234u4sMJMNV6F75XRDTwQpSQ5OmgBBUlLVgBm1pKL/6ezQ3x51qArCj/dF5mFoI5XOJykkV9aKy50c4jWVORVZtEqQb3KkALi5ch1cFTP/SC+Ciq1oopPm2DVCTirmMe469ICSw6A5LcwE3RQroPZa3/TCHuTRg/9D8vCnvRubaoaCjTWp4pcs4MLai8YYqSIx88ztxVjajg4RHH79hMqpqtoNPmJj4Njieq/VXv9ATW7Tlk/blg0ZHPvQG5wMmrGwhLhJ4gvfYguZPQ/34xTmb0B9fgsOJDLCTJw5Ht2VnpANGcTEdTn4Jzr71ChyWwvF0gz7UwFAvNfRbMUHbqM7YyDlyGOqKULEXTlpu6waS9hqKRoxWLu77bijgqX5h9MXEzLzQ+avcOHRoxSUnxfExy2why9DwAbCB62WOxUy9cf1D8TbVUL89bSOlKICSj/bk/gaUMR+LjoEkmxsInklwRvwQNzXaUSpeYt8+5UqiZsfxB3xBXZoKTO3A20rYAtelCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(4744005)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uAVHLILQN14VCSpNaef3U7sRUN3ud6olBh6Z637xvQ33noUMoUq/WMlEXdwh?=
 =?us-ascii?Q?8jpJK/r/2LOxcp56j5L3qlvoz4abEneUQzdWUtIPc5y3Om4engl5hC7DA9Xi?=
 =?us-ascii?Q?njFiRI3mw8qOSByfJzZ4cVdl8ngZ0bhcBBTTAsxNiUMU9EezHmrgRMGIocUt?=
 =?us-ascii?Q?JTd984PX7nwFKhnWwv8VzL8RDk9nG6A/ua2JUsdnk2AEYpXr3IfMcTpA23AU?=
 =?us-ascii?Q?Pv1QX5xFvhotPJv9BowOwNDuz8q8Hn+sg6WORD2dnO5NBSjH4iy+V3Qmx46R?=
 =?us-ascii?Q?t0P5wV7/ORRAwfAOXt5g8wQDNnX4CoKkRVfqDmlpASqVotdStoqcsoEMldCp?=
 =?us-ascii?Q?UshUKjCQ8p1IISQtY9B6hCET+b+KmNqVwTu4F3MYa1WeEvd0So/k5GzZuxGj?=
 =?us-ascii?Q?QnUERIwT+k1KHf0y/CR2c+Abt71VPskO5oiTXz5ClHQa+OlKOMRMOzQNtLO0?=
 =?us-ascii?Q?RO9ckr1Rx8UKMsoVlFIhJBy+OTVszeyaYuchdMEmaU1+slqm5VhnZcf3StzR?=
 =?us-ascii?Q?UVNvvPRhhCgV2oHRU6Mwo7N+gtGWg7ly43yhuYS2S9ZIfvciAwAhUN8n5M3e?=
 =?us-ascii?Q?as8OaWNs6FAP5CZZST+PgFopqi5IVncrrMGibXLd7tvTKx09ygfDjDrzLdQA?=
 =?us-ascii?Q?PhN4/GbyvL4oZ8Ifz8p0Ppkt7L7qOlIIl+lKZSFtfVAGLP1oWjiv337Mc7BB?=
 =?us-ascii?Q?ykJlKYlREbS7shGUYZ5uZbqqSVC3cVcob2d8mP1a7yzvQnBIcQPDqVvaS27K?=
 =?us-ascii?Q?M31o5zdG6dbaCX+PH/rpAIK+Acrq9GmbfO+kpyzTegbe2jvZs0bpOxWW4Tje?=
 =?us-ascii?Q?CWoqA9awQ3Nb348dyDF7Sjx44jmZjNX62VNOsK+FXFHMiYDC/SOl1mQiuRlK?=
 =?us-ascii?Q?B/6mgytwIcWKvmLKFiNrqVOs9gqZLTV3BobMHpLxD9h40OqgKGSPPO2nWzUG?=
 =?us-ascii?Q?KTrJOnsjiJABiCHXxKlPdpjKRNhN4MkKU9LHWl+5YD5Icll9kiIXUeYWUX/j?=
 =?us-ascii?Q?5RoukMxaxz/2kFoeRREb2AOM2AwWEqzZodfG/s00unvKyL+6LBsNss/tY5dB?=
 =?us-ascii?Q?DAYixDMYlHop6xSs51GjnfGE8SFfIo6a8lTiN7SNhgpaoSF6EPVCIrtp+8Wz?=
 =?us-ascii?Q?Cl46+ImCuJZrpvcYA0jNtbeSunmrSmOqSel1itev0rDaHNshIz0e7+9yglMy?=
 =?us-ascii?Q?c3A21HrzyyDsswElHUkFeQnJpZYDx3ip+qxK8Zcwo/vJHoM1kE3PMK19FHUS?=
 =?us-ascii?Q?nRB/7OZ/NKdFl5GcVM8oe6qvkLYiSkDFE3n67YcAgCiw5LHRjya3NQqtquBe?=
 =?us-ascii?Q?Jz0hU8+Xr3GZWXvEuG4zQVoET2LSyyMFIub7wd7RuGx3ESafZUFwVGHveu/F?=
 =?us-ascii?Q?6OhlZGV55afJ98+3RjE3XHFw0s9xuVHBdJiUDEyapfmKic0zSM6r7t+4GqLt?=
 =?us-ascii?Q?AaMZ5VWbjdaPQO7FRrFwRrq1wZDzZxGGZqG9zCs73dPIH3UXVtokD8tuuSvr?=
 =?us-ascii?Q?7BwVGcTN801wRcSfzVFLzbWOJUhZsIkl4lbzyEVzU6PP7/L2RCAehmStiwSa?=
 =?us-ascii?Q?rsmVRSkGV9S2+y6UPIKYsRC7RQLzkT3RkP+5eQdo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b2b8ee-ba55-46ac-9e7f-08da5cd3f38f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:11:02.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPrelIPbtVxUYl2yvloGLiczmC80i191MccjG7MNABYjStVtXFbonHTJgNpIqljn9O2T2/G8dFUeb3Lvqz+v/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same to i.MX8MM/N/Q, register i.MX8MP interconnect device to make
i.MX8MP Interconnect driver work.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/devfreq/imx-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index f87067fc574d..a727067980fb 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -145,6 +145,7 @@ static const struct of_device_id imx_bus_of_match[] = {
 	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
 	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
 	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
+	{ .compatible = "fsl,imx8mp-noc", .data = "imx8mp-interconnect", },
 	{ .compatible = "fsl,imx8m-noc", },
 	{ .compatible = "fsl,imx8m-nic", },
 	{ /* sentinel */ },
-- 
2.25.1

