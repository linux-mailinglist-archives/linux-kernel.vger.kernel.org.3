Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F058677F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiHAK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHAK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:29:48 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41D19C37;
        Mon,  1 Aug 2022 03:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyCij7DBkmqQbjvz0kpFghqi/LK63R/Vi6DMDXBXndg87NV6zdUUQ6/GWQ6hKzcSiA2w/oSWDlypExWWBUnC3Amct0ArZ6ZpAftJzzfP4tY6whfTx41pBLD2oJMiJybFXNAvT2Ko8v5W8QO8lMRPbasRm+AUmDAEfX29tTnRxDNlmaSRxx3b4WM5oDwUkRAIw2mV8bl4Z59Gn38YsOzkbANbVFzPwLg0oWzKdBtFH8PjMPakdfulVVD5IF+pmeLtMo05jenHWUTHbaookDGk7tuD2isT4XYyaEqcalaACxTbKSbK4ZFrf1zRj3xE01jGwP908zgm1mnTuNvLCN9kLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfw7ZsJWG9cjhpCNkRVmi2nyrRd9TpEyQ/NS/9tUNrI=;
 b=fwc+b4OamJ1W0zQsJp6oKd/E/00qxjD6KuAsKfVlCeGWTslbk27eAoR8orW7vvJEeuRpHVGNYGD15qx35rZF6tZl+7VBHWbpFheHsmNYEem9PSRxCLqnk0Uclh84HYBNTAqyFQlGIVCNDWcPafe8RP0F0r+ihFwfGtHU1tPfQ1I6IIlICZhdWf/uqZ3RDLPbqkWCrfZJ1r6MD/8qVQ9hoZGmoipMnsXxFE36N0nm31QeGbsAlJXv3e4QOLxUb5tBUtGN4afRwfqOuMAcuVc0lF8SqoyyjQgxW3OiS6vas5GXpK3kDKgdam1+EzO5W0Db5pn8TjKdhuFSW8zNRUHbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfw7ZsJWG9cjhpCNkRVmi2nyrRd9TpEyQ/NS/9tUNrI=;
 b=YXQhqqq8zqZ3/U5lB+HwmmNLzbelqrKOTLcVnswc6mZ2lzoUsgYn6k8BorpYceQN/Pa6FP6cbQ10bwosbwYSKBu66l4s2CkSqy/rLhljCqMOF41mRVLFEGEmf9U9C7IoODUBaLFk0SI5wMKrypXjILar4QCV3i87uZNv+qRrkbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 10:29:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 10:29:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] media: imx-jpeg, Add support for contiguous NV12
Date:   Mon,  1 Aug 2022 18:29:08 +0800
Message-Id: <cover.1659349092.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ffe82fa-ff67-4373-f767-08da73a8bff3
X-MS-TrafficTypeDiagnostic: DB8PR04MB6715:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3K+JzmEXaUUs3FmR5rnOjiQFJQY2G9NPydyDjzXim5WdQWwoPeK7AfP5Dlg+W5q+i7sJJjYuQMA/1rlazw3C3uUgeKGhTT2dgQY0hPOWtLcrWkPwxFvDHNTEU/vjFe1pdid+1akypuJdtkOJUqTkPmb/tf3nAFexdeNPHDBVxPTRwe5dOof7HjGhC6b1i+FAm4UFhdhP/gUqMzmIqsBLNefHrcrSfxh5Bo4hpCyBVlMcfkj2bCD7ZjYsMl3LW3zbyzfwdFZCQjL99V82+bOd5gD1OaTZz/eGa8sQbwXBuDIC+DPcPib96YxDeMc0Xrrbngm7sEt3giJb0l+QtK7AE7DuEVCcHl8Ns8fG97rhgWrSWYQ2v6HnVyFFsShZ+3rdVAjH+TMXt1ndLp/XrthBuKmj9L5cjqQpYrWqKStplO3JbYTW8puxhfgaKjgeuv5CYVb2SPY9sTLT3c47XKgcIdY7ru6LT9c4iE614KJFdnrT4eNfHz9RTNAzLb6+XDuqCPpu2XIij061pmCXF5uxmQC/2ycXsoHSwt8PrMytD/gcFfZzbsgA4BRb/G+bqbp5R5gmU9jmMznjqyCRew5gj7laHX6T29g8Vqb4mNYVDkoD2bbt74Z9Hj01PPSwjDmWIAFr5vmdqefKK9SUzn4huHGEGcBR4SJE9Td1PLlPWTcQl5IGtMlFLkyw9EmrcZiXG2807ulKKOlsr2XIjmgBICRi8imCEKREjnli85LLNOZnPRnEUrNYX/VzdCYN8CSCgvjNnmij6qyzTKfWwPvxmuMPFJOxqUyoED49hRvfUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4744005)(36756003)(2906002)(7416002)(44832011)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(316002)(478600001)(6506007)(6486002)(52116002)(6666004)(6512007)(26005)(38350700002)(86362001)(38100700002)(83380400001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3CB7oC0OBiJW6NvXzoqWTCRQts9CKC58+gQxGRw+nZp+9rqZPVCBupC/cxU?=
 =?us-ascii?Q?n18uZUJSrE2WL/InwcDmt3U9JT5IWfH8sDrW0WHmSW7xUVsWejwb+bwWvGYc?=
 =?us-ascii?Q?vMQCgk4IRU2eTsJNP/hjENeCXAmCUePL+fk4fiwkFgRnTq6y0foexvHe9b4l?=
 =?us-ascii?Q?JQ5Rof7OLWxEnE4tZjPHNr57ULRVlD36X5ccPGkZwcYNTt64pL3M15w4w24w?=
 =?us-ascii?Q?sCgCBv3VRz9jXsW8qFDYxvo4ECSJwOCfXE59VJnv1XCDLOsMGLdmFJYWyftL?=
 =?us-ascii?Q?5qFA0QjlrBwDjgns+cIqJwM1ni4x+cIwLPUbC6blxyQTUHy2Cxe45yM80F/K?=
 =?us-ascii?Q?t4GWRNdhkXhxVXkZ83ISALmYqZRAGaqckjHPgE1IbVB/HlKplSWhcKJRjq+1?=
 =?us-ascii?Q?GdooHfW8YNFP/UPG30KtWMPTTVkhbvnx/v9Jk6Mf98gk/AEps3WaqsY9+RX6?=
 =?us-ascii?Q?e/pCQow+59BFHDuApYNUnEonMK32v1s1ZE7x7PE1At904k8xjGIzFYL1D/05?=
 =?us-ascii?Q?Lhzxb7YOCCe+PL1FKMnx1284FZCkqBonu2gcwV8iT9wYU72deC+sRkMqffnY?=
 =?us-ascii?Q?ynElOr5O4CRNg28lUftKTEdCfv94HuLOgJZAkqJ0XFiX5g2CsRyqidwBrrTa?=
 =?us-ascii?Q?ZaAZS3AyFOSH2sO/n+a/0yLhhDg8Lb6oavkQgaDTT3uBMfxX3k1jo0Y7Dadg?=
 =?us-ascii?Q?IaPo+HYhdKHpElHWA5BoXwiK5UTjTlepAlDjnFMagz3T5J4wfYjjz0aTOy6M?=
 =?us-ascii?Q?dWOXcFA1GXWTiuR0DDqYAshKilLBszIDnV1rdxS59l04p+4hH5s5CNPcSzZb?=
 =?us-ascii?Q?ssVNZXi4sTl6vLTRk/GnwmHkdynvWQhgxUQZstHaOU00AZoE1DeKsmkTsTzU?=
 =?us-ascii?Q?5ZoxfBe23IVtDqLRNaiHbL462JBM4HlOXg2hz9FPOHwPmGn+1GalbkECME3Q?=
 =?us-ascii?Q?C5AMbTrmPGyc/QePkQOu0ZHE/nP86d6EpA0IPUlcIsV1jfZEkjMBWOMwF5Hi?=
 =?us-ascii?Q?RE7gqodgo6rYcM2QELRJh3SDYohSth94HA9hUm/KIoNtOVFkvPQDvOIZmDWe?=
 =?us-ascii?Q?hU6F7z4hmxLEgggyORg2taCrKqs4ZVFmqVajNFIfKbhXahkk3hSrmebi0Mm+?=
 =?us-ascii?Q?SW1fNearva7w5pBd7Ra7bGSERFsIe5m16mMbbZFCvRKva+X6MsGRwroG1cgS?=
 =?us-ascii?Q?ETFty0shhxjqp2D4wmAT1sMVv18gH1qXQ8NF/g/3z5c5YdTMR1w92iIF+CY9?=
 =?us-ascii?Q?SFwv0wxNQBOUGcK3n02sTYoL2lIQdO1GqIrp0ImoVqT7G+C0802MYyuBj+oZ?=
 =?us-ascii?Q?eNcX2k4aLUjPYgQ7AAZVTn4hIPPf99rPSaRSBW2D4wuvv8pUMKhsLM7bPE8o?=
 =?us-ascii?Q?VbP15UA2aOs6xtcTtzjRl/3MsN6viCvUBSWEU6FQXngEV5yZx85eng2a9Bp+?=
 =?us-ascii?Q?K5VWEk5nFtmb8xnAaJxhPn4A2NtPphZqF834ggzMSIBGLQ1x5xr5QRIx9/rO?=
 =?us-ascii?Q?ka0faBgXY445fIm/pbpTAAA9TEKlfIdDGE1Ff7Mt+zxCJel7Nq/YmkY0wsKZ?=
 =?us-ascii?Q?HrF0ZlU8vLhW+9V7OH/ArFDWv35bx/g9Gh8C7qTF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe82fa-ff67-4373-f767-08da73a8bff3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:29:44.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIShFhwJQ2zeyOGrvpV46hUPijIvtBDy2/97aJT07obuT0rQLs6sjPOjr+JRWLHv6EFxD8PkLI4B2S6Tguuxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxc-jpeg supports non contiguous format nv12m,
and in order to compatible with the devices
who only supports contiguous format nv12,
jpeg can support nv12 and nv12m in the same time.

And client needs to calculate plane size for format NV12.
driver needs to report the aligned resolution,
otherwise they can't the correct uv address.
So driver needs to implement g_selection to report
the actual picture size.

Ming Qian (2):
  media: imx-jpeg: Implement g_selection and s_selection
  media: imx-jpeg: Support contiguous and non contiguous format

 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 545 ++++++++++++------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   8 +-
 2 files changed, 389 insertions(+), 164 deletions(-)

-- 
2.37.1

