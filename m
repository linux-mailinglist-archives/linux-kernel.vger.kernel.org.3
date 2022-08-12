Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEAB591165
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiHLNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbiHLNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:30:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405A1D31B;
        Fri, 12 Aug 2022 06:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htl7JjqY7zFt/cTCJMp0uT41+lUvtby3FFWzeRedZbGckjLgOGTw7BOf1xkH7La5yXkmceGwIeB61M9cFfiC9igH9U6hHO6yPutb5sVoTPHiQWIjaWBK7DhZ4L3fnlJbskmEN7mIIAO+V8fOlzTgIF8LoGJV3H0gF2EmNcOIAZF3aXNjqTyhbpNP+SpZQIU7hD7+7RDOVUwSv06zvk0OqecUukkNnbQhUszaghvuTo2SvbHWUysh7HLF8wXr+gX8+DHWfrhHwyhmrC7c5YETEWO9xQbOVJeEZN7FGe7IQG6HkPKWQAiDhqWX+C61r455CIP5wSdkfHFvHYExiWWhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iv8x2kktq4XYF9qnAv998l4Na3wkTJ0sc5TcPP4M78=;
 b=hEnapq5GMiN5xF6CvBXtvcK1HtAky/cgjMdtiKaes+KMbrF3F8gafXNEWzRtDoUyEsaYiaYB1nmO5bjfOuaTvgiYcCnNUewqsMEa36zJKq2ePIiwlrti65rjXuNO6OxjnuAQsF9gllhbXCzaee62oMsglETrpjL2K7nQOx+4mtFqBEUlNAt5DCBx1GAG1duLZ9ud+RirCK/FmMxwocgPRL6cfNDiufYhVgYW+DoMSo/WTdb+517/c+07U/04r01rPy4Lm9462HLvFJZN6nSzD8ZNaONGn0jUKUJgoPAE1+QdIKWW5Gi7kDofHVx3q25x2t1evmWbBgCV79tW4Ubg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iv8x2kktq4XYF9qnAv998l4Na3wkTJ0sc5TcPP4M78=;
 b=GU71FuUKV+celsJJQ9MktTjRfWTZIHHsCYsB94cowqAuCvDmJ2Po3okN03HSNpr7GB7sVq8M1deA0tU6vpzNtm9A36I8YakM0R/zVeY/2C7vRhVqwP7q92u5brIsG4THiO76MA+XcqBpoLqYqFN51K4qkg/YtGHS8Pjg9CAJs2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by HE1PR0401MB2601.eurprd04.prod.outlook.com (2603:10a6:3:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Fri, 12 Aug
 2022 13:30:37 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 13:30:37 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v5 0/3] Add IMX8 SCU GPIO support
Date:   Fri, 12 Aug 2022 08:30:09 -0500
Message-Id: <20220812133012.7283-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::8) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca14bc63-8981-4cf4-23dd-08da7c66d6dc
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pq7pKX0VSDBCXK0JTqtFsIPLY3s9YsMgW2x/TnkIUPhDrW9CTvx21SxARwQvWSw306B8Gkf4Uw1qQbXEHz+pEZxSYpXa/2ThZmWia1NElx1ax5/fD8sKqzGTB0NrHZzd2qVboMweabKG9wdiTvqTdreT3KbafT0QMbtWM+G9BRzMM+aAHZqq6GI5XDdeFZZarnIlV6gPt9xTLTOrCSyxjMVU6JjxZV7oZg4NZ9v9nU6/8k5O9CpaR/pr3q9lqc65xI58hP5wELAXInsRebUEHrF7oxohjaGrvREH5Qrx6OCdV7ev1ntKW2iEYCUDA/Dq6biFkmFvCq7bc9NV1XpJyrfecB99ezzqFR8oaBCR8UGP15puRrxor887H7DH2DksqupFuMoZcTPJ/xH/0Tr217PUF+tPDO/CFo5FCQa20X+D6+gRTvcqsS8XVph45Fxm7YM6bSdrH57666vPIxGMMtpyBJfwWteMrrxEXpVirTuJSK1UhfX5x7vG598E/aEMfRbPfzXs6+kIGybuisfgxcrSIO8xbBkj/zZYKy8DqNtFNjPU4T90egyn8TeHloWosfd0xmtBQpJmr2xp1hgnPyapy1zmq1srKEQA28r5LqOb5UwTLxR1xBLc86Q2m8qmf5DmYKYsVBovCfNGk18vx8WC8/YPZ4swQnoMQe3hEE9HEQHwPK08yLhdcHTDqarBJRGHjvIGagQ8xDmga65ym7Iq+2YRbiro8Dth16mmMfUtRVErPhPLnuiPJbzKYcvc1a6Aeyhef8RnjNjx0VskvScCJXsGfmhvlAj7j6bpDD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(478600001)(2906002)(26005)(55236004)(38100700002)(41300700001)(6666004)(38350700002)(52116002)(44832011)(6506007)(2616005)(6512007)(1076003)(186003)(66476007)(36756003)(66946007)(4326008)(6636002)(83380400001)(316002)(86362001)(66556008)(6486002)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgHubtRD2zA6eYbHKLYfzZyYM6crR83GCoRqNkFUCepcKVlhFxeD45JgEhjR?=
 =?us-ascii?Q?iZxoWwDZCvalBL9jl+fO/Sf1SABY6i5MHUjIpnLZExKe1kHV3/yZO+v5Pf+8?=
 =?us-ascii?Q?gUzbcTygBeqfcRdCVfEf2ttZAgK3z2zomY0I6uCNFBWkWZId/HE8MzgnPzvj?=
 =?us-ascii?Q?adfQzpsDbTRUD+oe78iBTU9xPfBwnTiktRLTfWEj23J4Atq84B3LEHqdwJ+q?=
 =?us-ascii?Q?2hEHhKhoLJ/JXaoTao1NM1nr46kRPXdMNeoOmDWkIA0AwuyV2xiqp+Hz5yA8?=
 =?us-ascii?Q?KmTSXXYLyg/eP8q44CMI3t9zuBA2pDj2G0WZU2RYud/5fIe9fMZUJ84JnNG6?=
 =?us-ascii?Q?V2y9Bmh03uc4yAzIZg3HiDpoADtyey9j5tqkjUpVOmYwg55t83OOULcRe8jM?=
 =?us-ascii?Q?A5HRqfBVJuo5H4qfDU9nrFwvNHG84ZCf4Q+0jubImESOirKTLa0tTE37zdbk?=
 =?us-ascii?Q?8jFXS5qconKuV+3yswVF1ujr9+Kjai4ARJrsiWga+4rfviMTg1M2cXcN+4us?=
 =?us-ascii?Q?AVKHDdZI6M4w+4T0b8fLmWaRm4qHAgHsnwhJ16idbRR/wNypMl4mAynlduOk?=
 =?us-ascii?Q?SbaDIM171a3zgjDFYWzXFK8wlHnBZeR9x8sUa8aQ97MKoHAMTcYa3SZhceyt?=
 =?us-ascii?Q?Lai4V2UxPTwUflnfjJ1xqrOc6uoxyGzGD1+qVLfS4sVdW859eXuYclb1Hn8B?=
 =?us-ascii?Q?2F8utmx7Bw3meUwszIONzC7cszqgIuYObYMITod/wi9uutsGvDpaqJhE69Pr?=
 =?us-ascii?Q?DVzOzzcv/m00mJmUSRu1qx9clIqRJac9EXTK3INhjJIskPcH7GMizNg31D9/?=
 =?us-ascii?Q?+FStmQdZ5ml2aWxTbG1bTRIRNzTfAs5VK5D6QsqnrVTswNxYFomcQ/4/YLbS?=
 =?us-ascii?Q?R0TzSSa3hkWHf6grqHIRqtAGBkcOBvCeydjfsjk3NfjhBH8n1npCU+m9/d0Y?=
 =?us-ascii?Q?+Cku4AxbNzvfcEKxEgeZFVr79CX4cENEq0eaXV8pMIovONBRE2dj/ZIvVdo0?=
 =?us-ascii?Q?zHMDUF8cfu3XrptB2AkE9nVmaieJpT5H/vpTD4IpqRrJekREfcXdGJGQwyLV?=
 =?us-ascii?Q?RTXd+uGlJNo3YnhJpdOgp1Vx1d9QV1H+TdLGacyaSi8wxHBHLqrYb8iIuX/x?=
 =?us-ascii?Q?F8/xmtcriZgldT0a2eFmqVsDGgr7RQn/KmU4bqQP2z7D0Jro219PQKo4PNgt?=
 =?us-ascii?Q?pwKIKupZWZdqERNVI37V0O87gl5iq9o0bJtj8UlhJXgGberK7kIwL4Zvxn6d?=
 =?us-ascii?Q?rXtm/kc1Gm8BHLrvy/NelQN3nGW9csZmdtqu2s9GNeRwr+rJKrbiDw2yoocW?=
 =?us-ascii?Q?5d9Fui+rLIm/p9V5kYlU4JAWAzBulZqkggoIZjzNrcgRyiAcZJdzKbxfAvDW?=
 =?us-ascii?Q?SD79Kq/7cg7xVVdssBjOxhJzj1X0z7cHOURRxSi42C8BWBHqghMEm3OugdMT?=
 =?us-ascii?Q?Jx6mb/eMdK5eUbvUWwq9RBqwqT8LDnnxzxan/rZrC4OPMABo3vIBZfFKVLiI?=
 =?us-ascii?Q?vduXNwUyfPc1FEwBBQET213msn/9X7d7zKgmcqiohs8s/sGvWd2JJysJ+fYY?=
 =?us-ascii?Q?pr6jTxuzZ0BO4ytJqgoamgVMFSiJmbbPzbtKw1rf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca14bc63-8981-4cf4-23dd-08da7c66d6dc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 13:30:36.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XKxZw/4JcvkClThHg7c6kMXyr8NACNyv9pgSE9Kkif60SCzuzdt5ITLAiVrbBvj5qfLPcliEMXlT7CqtKGKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2601
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

Changes in V5:
 - rename the file name from fsl,imx-sc-gpio to fsl,imx8qxp-sc-gpio
   to match the compatible string

Changes in V4:
 - remove the generic compatible of "fsl,imx-sc-gpio"
 - update the gpio $ref in "fsl,scu.yaml" as the file name is changed
 - update the commit comment for 0003 because the driver is moved to the
   directory of "drivers/gpio"

Changes in V3:
 - follow the other imx8 SCU binding rule and rename the compatible string
   from fsl,imx8-scu-gpio to fsl,imx8qxp-sc-gpio
 - rename the doc file from fsl,imx8-scu-gpio.yaml to fsl,imx-sc-gpio.yaml

Changes in V2:
 - move the driver into the gpio directory per Krzysztof's feedback
 - change the subnode description in file fsl,scu.yaml
 - fix the dt_binding_check error

Shenwei Wang (3):
  dt-bindings: gpio: Add imx scu gpio driver bindings
  dt-bindings: firmware: imx: Add imx-scu gpio node
  gpio: imx-scu: add imx-scu GPIO driver

 .../devicetree/bindings/firmware/fsl,scu.yaml |   5 +
 .../bindings/gpio/fsl,imx8qxp-sc-gpio.yaml    |  39 +++++
 drivers/gpio/Kconfig                          |   4 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-imx-scu.c                   | 139 ++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml
 create mode 100644 drivers/gpio/gpio-imx-scu.c

--
2.25.1

