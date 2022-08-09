Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0919658DA56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiHIObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHIOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:31:29 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00072.outbound.protection.outlook.com [40.107.0.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CC117ABF;
        Tue,  9 Aug 2022 07:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5vJiPjUUIyPR6jQ93/SPTAHMmOVAIaOvkqUlUx6YYxZscURiXcaPpoTGq5e44ekHRU8yJC+PB4HjqsjcoA9MpcvFEZmNGxy6azhymAIx28SS2xYpe0MTa4mfLmzXEqemjSfUb48nAK/jforiLV14EOHKCKG83JskwRCPBj5Oz8MoNfJvaBCC0QTh695oxpKn0sLg5a3EU+DOrWX1suwwatN/ZXa3O0ih68BPrIkcsvSnyLg/XizYjcaWJAXWYNAUblQBIr7uVQoz4cgVb/8z1q+OuGDRIxzrFtnRiiHimljEs2B9zHR1Ir8l/dZQDqmJf4lphkumc0axbrzDkEYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQvc2ULQJcVGYro4aQFHNI8CzrreUaMcRrqg6lorug0=;
 b=Kk4qS36LNocA8WDMHnM0mR6GxulTXpJMnPQ70gdYaZjCyOk8lqHKQCpbjBkFUVZ2/w3zdfGco7qkB1E0uhFYYNkQhgeXKPywa1H1AdkByaKb91aHb4wk7FTeDsxttKWGjuvOw+DvsPVzxxTDyYu+wonvh9zmDClPwHZMxylKk/yLPL7bBhbbMb3Y4RbfPbS73qQ4kAzVvpGCXJIlcIbYJsStnV6Sy1F9n3ea8LfJXbRaVQADkFckeiEP69lCtUJT5AcgCqyiChmbzu2MGYsSYzrp0sKmevQXy1tJlL0F0QqynLs7ToGspxbhcWhXTRSnizcLlhiRwXlyj6llVtqYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQvc2ULQJcVGYro4aQFHNI8CzrreUaMcRrqg6lorug0=;
 b=XDH3wrevLrrYRUehM8OXkTFC+hwj1UAgK/Q/x3N0P0FiM/Dum54VexjVFRo/KO6oQKFSiH1u/Hp8o1bf7KWjH20vpSgAZ4ut7EYt6gwaUvM8sZFLP8Bi3VnUVl1BoOgjkC4YGJaC3IRK5BUesdHnqj+NSo/TT8NNb7kBlNtx9EQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5226.eurprd04.prod.outlook.com (2603:10a6:10:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 14:31:25 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 14:31:25 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 0/3] Add IMX8 SCU GPIO support
Date:   Tue,  9 Aug 2022 09:31:02 -0500
Message-Id: <20220809143105.17967-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1138401b-19f8-476e-eafb-08da7a13d6d3
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpXwdkigEkjXL+MQVtoT+Pwi9KjRtRJgoDBWZ5ogHwPnHaeL1vKzsTRIy8j7NDCBSZW4o41emwhrIyAfQwI3Lf/MXJKnNthKk9Sb+isOIA8qfTV9TEJvDCbcNC+koODxPZC67quKixC+hwZGZRHbQm3yQfk/v67Cv1T5qra+PiKXzZqG1XRbu6X8lAk189XxU1efhSTMcB7rd3sCsRJiTo9dc3a+Y6d+UrX6DkYozrEDxWUp2Q69nc4uGp1NwWU/YSbSq0IVFw8PnaMEAwj4vETDV03zszw2TXpt8OslhVSLK9ymuJN62yjfblsEvLhIttmhHlZyLUqHGfeLO2xsrnZaWH1x1HIAb1GR7AePbkZif7MhjCsAksdzlCHDYkXu5a4CKMKxRNny93jZyipVyIKNOF/+2cqU/M8Hhy5tPY6Lm2y2qqBkuvPjRdquBSVmKzuGGaWEWJlHbh0xLkmdSLDPzYnPVnXdrVOwKimFkdsLiz1A0wstauzQPSDJPi2HpU7CRM0od2NRXOQeQMYNyCznwns031mKwY/WkSUFHgIJ4pLO8lz2yu83QmcMQD1WMh6ghjbFZqWzPi+8OhCIYlEh96vaQUo3/ImkFNTdVd3XvkBJwvox0aCVNHutSWH2IXGXlj+aaCWMbZ9dKnwfyeJVKOPDPztgRb2EZyuz7XgPtPMsFoAmsmTan2BFB8U1h6NIbo+oDg472cysJvpoDfvO0CR+dDXnihNZt14t97Aq0/mCENPfbEGRQAec27fzK7pFbeOAhMfnVtryM+kNgZXG7LoTXHnKFL9UdIPs+Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(55236004)(2906002)(52116002)(26005)(6512007)(7416002)(6506007)(44832011)(8936002)(6486002)(41300700001)(478600001)(36756003)(86362001)(1076003)(2616005)(186003)(83380400001)(66946007)(5660300002)(6636002)(316002)(66556008)(66476007)(38350700002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBASzTJH/niyHkUEBbNdlCpfQzBkOrEy8rmKEa2J0MCpVKXE3u/aYRLZJMPl?=
 =?us-ascii?Q?gDpGjNrCt/gZkd001XRBX/2xOuq5ZnX328XazdX5KToJIf9rErPkNo5OejnN?=
 =?us-ascii?Q?fh703wDM7g4vcgW42C/+sQ021vGl4pCd9PeKsGnwAjiiRFNLryoCspsFvpYa?=
 =?us-ascii?Q?DEC5LhLHc637JwWkTwpa4qGrb5fd3/leUBo/tGqAeHQMHI3ca2AjZHfujBcF?=
 =?us-ascii?Q?TmikL5qVHyWlj1o6gcBJDPT16UmzTn+HnGxTE8SPoDv9NxD3SWH3+rrnZu0B?=
 =?us-ascii?Q?9pNU9Atq0YIR49w4Ie5Lj44ABKpG25yu1urlgiID5MwqZ/Pvy74y7F5dacO8?=
 =?us-ascii?Q?6rkyIAu5R/8MRkCtMYWFLJBOupM2QUr51qksIL5UfVs7H6hjwZyHYIUY8ufV?=
 =?us-ascii?Q?RcaFVqph38Vw/WZWx5lfCxflappMJaDiOoiC3kbu0tac6roYr8fTtx7C0PDs?=
 =?us-ascii?Q?tv71UOj0TgdxOg4htcGx2s5kqL/zRyvwiCit3GC1fo1aiLDJ+5qBFhyfGsnO?=
 =?us-ascii?Q?UT09YNh8xfQe+lTI8tDV3VxXSqUsV2pcOB6jPnhtNJbVcZ2kvaVpVA0jym/t?=
 =?us-ascii?Q?oZawcTcTM/MOmdT1O1Rl68b4yPxJPLu/T3YWzDQUYlga2xjE0BJYhQf+vxET?=
 =?us-ascii?Q?ZqNN6MPN5kYWxKx4jzBDE+b3Rn+kFGjBEobu92wXPmxJX+voRPtxhUx9MFUl?=
 =?us-ascii?Q?uLNbPZJwCLm2QJzcoXTqjXDx39zdl4Fe12ijtut3vvrcsVMJdU9UELkLyKTF?=
 =?us-ascii?Q?XSolZcodcNXu8MGwprEAkpdbyZRXvPzISAl7YUD7t4B/w9ypHASwkmecZMxc?=
 =?us-ascii?Q?9l0UsEc0D/IXMtaVH1C8NPAv+9bIv4Xyll2qvoE5EpsStPxsoJCY6BWdmTZ0?=
 =?us-ascii?Q?VbASmaTU9oVHYumoFNy1Q2XYAXU1wr/Kn9UvF9y7HCQzQK+abUcNlM7mK+ce?=
 =?us-ascii?Q?LZZNYftvBoUj7EaP55Y8eYgzuY6aNdi2htqluiF0ybYQ4HbImDmhOf4etaxd?=
 =?us-ascii?Q?5R02uAa+KXUOlZSeXrQSsWqsjjugk9aptT0xq6qrDBIllN1/TPR5H5fpmi9s?=
 =?us-ascii?Q?UIatoKG/XdSTfTcqkZCicYubtz0V3DUWHL2QCb20ZbruBqKFlfmeJ/ylewrQ?=
 =?us-ascii?Q?BvTEnk2tqwPDxqckTfgGnmTn25qn/CJ/2OWHGktq6htn95m0S+ZIEDPOxXPz?=
 =?us-ascii?Q?Qc3aGPo8xeXRHF1HKCTz68GgiHnoA7smQCeEjeBoYIkzJ148E76PnGL57kC/?=
 =?us-ascii?Q?a5NglL3x2LMkM5f+XRFbwq/KNuQbfs4RiD+aLPhXPKi9n34v56tn3VTTv28V?=
 =?us-ascii?Q?Fyu3VXCtDiqJBVDjsjKJ6weC+r/VEcMiFn1Dt8kD9m7SXbYtoZ83H8Mn2YHm?=
 =?us-ascii?Q?mSzPY1ha3BU5KggMVTEZogWZoBo1ij3e8/Yxzh2Eq2vxOQK7lRyB7cdSGmfG?=
 =?us-ascii?Q?K5Q8A8QWIKlP+uYZ/ALcWnp/6jty44QJ6kKBLd+1EhOT62ZQlpDMhEZiLdc7?=
 =?us-ascii?Q?vQvTJ/wJ3ECmezDUeXO/AV7MkIOz1kBV+B/f7w1xAx6uvCMJv1Z/9PWVbWmG?=
 =?us-ascii?Q?c5ecLfUM0yHBr/K5oG0oS5BIc00+53OA2MNqWEjv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1138401b-19f8-476e-eafb-08da7a13d6d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:31:25.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0L/Xzjj0ernuPV08ye/LjG1RNZAfS9VcvjG4VK6S3sv38zjGL6i7NgO0fx29/Y1DrNKKSbo925ONrTmHd2+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller (SCU) is the central unit to manage the resources
on i.MX8 platforms. The SCU firmware provides a set of APIs to access
the GPIO PINs on the SCU domain.

This patch series implements the standard GPIO driver over the SCU
firmware APIs, so that the GPIOs on the SCU domain could be accessed
like a local GPIO PINs.

Changes in V2:
 - move the driver into the gpio directory per Krzysztof's feedback
 - change the subnode description in file fsl,scu.yaml
 - fix the dt_binding_check error

Shenwei Wang (3):
  dt-bindings: gpio: Add imx-scu gpio driver bindings
  dt-bindings: firmware: imx: Add imx-scu gpio node
  firmware: imx: add imx-scu GPIO driver

 .../devicetree/bindings/firmware/fsl,scu.yaml |   5 +
 .../bindings/gpio/fsl,imx8-scu-gpio.yaml      |  39 +++++
 drivers/gpio/Kconfig                          |   4 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-imx-scu.c                   | 139 ++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml
 create mode 100644 drivers/gpio/gpio-imx-scu.c

--
2.25.1

