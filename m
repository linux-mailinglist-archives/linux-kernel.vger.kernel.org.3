Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588A5631D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGAKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiGAKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:45:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F627BD39;
        Fri,  1 Jul 2022 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnSJyoUz3Pq0PGqObL4G5OLCwsigwWVlmHn7CWQ/1l78fz3EFBHIkviPJqaNkASUoQl9cqnGHvZ27QHRuaUr4fLQbdEhUimDp54dk7iFc+7/lbJ2w3c68/3G0EESY2rb+EYxEN2yHbNbX7XAn1kutM/QqL1aDzbclR9dM7B//CQfQSomx/sXUzBPaLlpTYX1ilzr6AT0msg7pQaJyUg5ODPnwzCXa+tj7CZkBnIoFW9PL/tJkx9L4nh30mGKyX3OtHfCrQR24ffPmfj975NHLzClpeuRnCA2/y3aWtJU+ChtclnuOJipFN3cazBbJ6IRB+O/+ffM8f/o4l/Y9pydYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGUA+yP1L7NkUSV3npgVQzouUiR4pfEI1f2e0J4XQtc=;
 b=mcgOQ4ksXQJ4POGy6NSx1sjMGqG5ErL7Yag5fUGQDEPtncnsVI0BJFKoOAN9382r2IoZK0/FelNxgFj1VqgO0DxD3ZGW7d3Irk+9VFnh5MDBTvs+cDD6Tgmvay1bXjAiCUFZLaXez4IaMay3ewjA0arx6nH/GJwVHnh3dbtkpl7h23jpQpD+54CuW/lh03ombRyifs2mn+MG6QUVcc9z/EnjdVIhjHAK9QitXG6HFWvZh/5ytnTAwRn/QsLV2b07Mg+EEzF4RlKcxkXoBsl6BuvrvpPOs8IzTD/POclXb/FWsGGtgPWjFZYrtaTWmjw61iee7ZrS2DyXgSHIUFVDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGUA+yP1L7NkUSV3npgVQzouUiR4pfEI1f2e0J4XQtc=;
 b=Esmn+d/GKDnbRAopMmY1esNZc3nhJF52Gctq7fJO/LO0MvKjjjrSbFDpP/kdEMjGWSuljoISfawmzHLZg7PPE/kDkLw2Db6YOGFdRIwwM3ChUm15FgYjyXGdONIWAgwVB2AUrFEcrQioTDGPGie5o37uCbW3gpc5cI+Tn9CLXXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:45:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:45:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 2/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Fri,  1 Jul 2022 18:47:21 +0800
Message-Id: <20220701104725.557314-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701104725.557314-1-peng.fan@oss.nxp.com>
References: <20220701104725.557314-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 426a341d-6627-4036-7421-08da5b4edd14
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCc2s3QJza9AFNp0bB7tPjYWoEJYCajlcx8z4drE7eEa0viL0yLmbh+KlkcNPr1JL3EzSs7XjGL6TtmleMyoSyg08RAfrTx2OMMMbYJPQeAsHfEGCXu7WhTC6oJXj3obXvVNJNGsD20KSYdgejq0ccuuSOEnnb+0IVRmdT5TaP7xNDCgPcZKHz1dalQ1oKXMBMVNrP7otY4ZDEmYsl9My70/fkiwT6oYulli9GLrntkyaaq2tvN2iWN7H6wJHtYifuNFCx+iGNBh0hdE1rUnWelBrmeHlqcWHorwGPBBVwKCxsP/O1KyeuG68bXrp71bQemoCrBT21xNdHvkyHaf4rJ0EQBQu29mIPhUscAIVKoBoF0rptltDPuq2DmIWx0Tz2OsPnEOJLa0VBz/Pq8xyk2ktGkKYRehx9UFYMbUADF6LaPY7DC5ZRLKWSQapOmszQG8mbu9nfyrCUDATrPDh2b599htl1h1sXvrwQqduBQk7/VKvyhGAX3wZrp26giP5lD8PfERY26+RcfhSM2UVVYErs4b3dksuu5DCZTICKRbJDPjibOyUTgXayTvgE3vhWtE/NUEO1LlwJ6ZsyfkGstxR4hQd/tQG5Oy9uwZ+/23Evkfs2KpmuPP0fpNaiPjkYSOonxqbnPbAnotDiJghnaOua/buc/2hxTGW8vyczVGOWuJFxvdHfGH6iyJBp1M2Z4BkbHYof5coa2flZDy+384qeXrBWdZGhdsjYWD1ChayCYHn5bZ4NAoJ13fFXYJdbyy3x4hCrpX06UNjrXvTZ+qtHtNyXTAiI6O0Y554RiL5C+CUq5zbHv4uwNY2/iF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(7416002)(6486002)(38100700002)(38350700002)(66556008)(26005)(52116002)(6512007)(4744005)(1076003)(6506007)(8936002)(86362001)(6666004)(2616005)(2906002)(186003)(41300700001)(5660300002)(4326008)(8676002)(316002)(54906003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnxks3vSE/Qe/ShEU7dD6I/uZpa3um9wLXzFu9F0dQLtZUop7zQA7vQT1H/I?=
 =?us-ascii?Q?IClamuxdDz7GrpHrYcol6O9qB9fSkxoGluIJNeros36WSCmBRZUVKBEZyA8Q?=
 =?us-ascii?Q?onlYdEonNYLCbN1VZfIeQoFRaYEEKrlBdDJnVFXMHTfvXgqQFkjLUNJGQk13?=
 =?us-ascii?Q?nfUa4w1PgxtO28A334ReoJs4fjdsXXbTl6cRrRiGKdpJ284osF1T0EwnEIxQ?=
 =?us-ascii?Q?PdHby/wO24s9MnAdW98qQugKDVPZZokgSHdfttqHFeN9ZaZTQKcBFQOFMv5g?=
 =?us-ascii?Q?B1e9yPEckKsI0ZyenLKzhBeq9/xr15U2OJ/FIpUul9mTvb/TDNxWkq7qecHd?=
 =?us-ascii?Q?ybTyh18uz5dZuJFjk/IMViVwkCXVD21jjojUp3rzntKRGwr6aWdVyQan17z2?=
 =?us-ascii?Q?huZuDUnzjZGPXcxRB8RMlaSLhbUul1ZwkJtoslfOVld8jPRd7yPGcbMLHuSw?=
 =?us-ascii?Q?wM6bk0PgdIt8t4dbHO0h9zOslC9JrldeuLQrX1KWduqxCpCjaQ5S9g+akV2Z?=
 =?us-ascii?Q?3I0+BvGaMIlzIXrAmnwc4BSTRHfhaSn5qN8zoN+boBiU1o2tS9r+IDlO0MNb?=
 =?us-ascii?Q?9UHSQFOgFv8PcDxRRGJrozdy3qysrvagKLc4M1zXKYQk0aAOgrOLdFDMcX/h?=
 =?us-ascii?Q?Q7ujnIPvIUb8O796lhlujlOUSNM1yXf/7SKPheZ4MaHj/Kb2BmyGz1NYjusG?=
 =?us-ascii?Q?CzRTj4M5q70yytk0kL+xFQ4dRmhxV8pUO/AGDYdRJoDrWSLljfVCDM2HXi/x?=
 =?us-ascii?Q?VZnVuFoPSyG3JGmV5p6JThTt/dQbhr/PLsX74MK8PPzexIzyKrcsCH6LdAi2?=
 =?us-ascii?Q?EnmLi4eTYGYDEHUn0KMjiOjOF/AaIP5yT4cf0P3fz4Cw5R44r6PDVKrEITO7?=
 =?us-ascii?Q?2vx4kafWDZO2a4XUUI5ckAAhrU69XdqgVTc/ctRKT6GRsFQ6nsxx0BrvsddP?=
 =?us-ascii?Q?zq+kdoxopDtOwUPk0FRcWHcXamtJd99KD1vrwMlvtF+Y03R7Gyc/zcWBnSK8?=
 =?us-ascii?Q?3HCxz+NQAZTJDn9yZLnF1yK38OiqJ1HYvWuTWAM3HQI5OlEgMmJOwNXEJxGo?=
 =?us-ascii?Q?NRQGIwKA2DD5a9hS5SmG5NZ/fS1jH/45oJOz114gy2jNNggpfjQ30YZjNwO4?=
 =?us-ascii?Q?dLNyhlAMdmBW92WpRtbXA4aDrCqUXxRrns7IlzzVaae9TCSzFe8wOCCCGw1q?=
 =?us-ascii?Q?N8BfRfHsLblRJRJCTgs9/dPzN5rT8y/114fNXw8DckojrjUTxetp/y3M/thA?=
 =?us-ascii?Q?8PJMOxuL4YeluPwfrUEfQcvIAeCqjLx2FlpsY2lla3WXDdfBOiEfwmAD6uT7?=
 =?us-ascii?Q?DZl/vKsmbChUUojP3DAPfbjC7QC6jWdVTmgOYoaUcUXI1qdxlH9ALotUYXwb?=
 =?us-ascii?Q?Y2Ah2Dqe3RX4T66hJCQKZQceXfzITf+4WKrKkbpMhUdBB/c1i+yFQ/B7JPJV?=
 =?us-ascii?Q?Qjn05knNvc+Pec8M1tfI+8sIKei4SroxfSRZClOAFr4/KAIaFZJHFsota5j8?=
 =?us-ascii?Q?2UhmWaxTsZwVRMUJF09pIXsxNFAAhs+/raBDRD6q6JMoXec+hIhzQ6+l/Zvn?=
 =?us-ascii?Q?s4d5mBBjeU2gQhgCf7t62yG/mxxCvDJyBdzTEn13?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426a341d-6627-4036-7421-08da5b4edd14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:45:50.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1ihP0PRT3rRTF6kxoWFRKTIhfKbt3MHXBACOOaWuZKwGq7vw1jvnHLqO9G8A/ieNi7KYyDOg9b6PC6VjE29Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 70322e57b6ff..64e783234e38 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
-- 
2.25.1

