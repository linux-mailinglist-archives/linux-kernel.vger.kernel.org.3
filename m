Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36AF592827
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiHODfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHODfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:35:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236D12ADA;
        Sun, 14 Aug 2022 20:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8JL8tpGXroztJvNYWzIedk3qqCuEARObbD/TGHzfBOnItBQ2nY9a4dca7CDAEduUQzev2td9C8bI6Tqre6QeSODwpHcTn6GnKjzQv8IJsi7Ni0MDTPNwf/XJ5/0RySAa3hIp4wwp5fKaxXJ7zx9gO0xCALdNpzCzEREtN+T1qiCdGrWsNCAMyUeKROLKJ9ky9aLwpGXOLPfHMu/7kpCHpAB6tpdcItsyabHFmFvBlChK4DeEsD/Fp11Gckr6jIdT+FjdDbz7ZZn8ZaEUbDGopqkihEh5+S8uRxveMu/ZSacmBAAGQp3oa8+szydJxDBubRr31ccL8zEoPnaT/PsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxEzEwYS3zL3BYod8je9GGsu82DzLb0rYgJ1FHglI2A=;
 b=YdxPhfO0JStq4wAkwg/uPxAwkW7mfYRsIckioEoTMnnHLi5/pfaDlxQe2KyYBMkr2XzYgbKmu9D3yFEgcVZRpHsjbQHieukNDvV/F13MjNuHYcackNdi75AQLGuxW9cRLLgyg8NR+9W0ZzYktWhiNdt9FRHBTvB0PRfI2dOt7wwA8LeeqAjep6zvRmoQiDN+mq6YXUUy+iarSjdoCKkITxtSsdWpUuoe3pfglXQHukL/RDXw2m05vwmthd8vyGl8wlM/+khmEwQ0r6vBF0QXwDMRxvF9k9nyo5qyBmp+tEoUWc0AjSj5LdEYlxVVyPrVOQ9b6NKJbbYKKPzH5tpmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxEzEwYS3zL3BYod8je9GGsu82DzLb0rYgJ1FHglI2A=;
 b=cl5QJIYNoNBDz1GRFRzX/u57wn1r8vNtGGv52LKFvO7B3VvJUl0BDzCf7I6AuYxXiHsFFx4LITY4ELMp+wQytMzvbbp6GY4MbmVfMyvUGFbvVJdwmbh0CKy2Ipa61gETi8BYzAYy9+jWr8Ay8iyFmQUP9INx2QTTrMU7ZvYr+uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 03:35:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 03:35:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: clock: imx8m: introduce fsl,protected-clocks property
Date:   Mon, 15 Aug 2022 11:36:31 +0800
Message-Id: <20220815033632.1687854-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f696c615-228b-4524-85a8-08da7e6f227b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7480:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhCNx8Lbye63YeEtv4MWpYG3rt0OFe6wNcZcQUmtHXfuFRTnCJM2297DnfKGPrM2zj7H3XCPSma6gOiN5fbQ98+sfWM9l7p/Syca7TdfZaKRFxv8pLB1BpR+/cvZy/25ui/zAHPOyQmI2Yn1fZYHNkGIwz52ROj2bOAOinZaREqOo9Bq3drIfnRVuNzDoyJOG9ioqn4cby9DdJy9HSrhPAez9U5x6BcymKxfcqeLvlqOin2Uau8g0KCCyvFSnorL5hVSBO5RPHc3R0Mm8nemZpcoo1+uhKR5Mp3eoDTTBewQ6F7qmYmoJULLj07WTUn2VWcGGD57vtqVRs08CjtbJwiRiw1BdShbMYrdy8a7HThjOVNNHW2n3KRjPJAHY/+jt1ynwN0WFcg1f8TPEv2pfKCmHmbrVbsz2JYD+jQ6rV1YRGV8XInASopORjiZmVh/S/ABnUHq9ANG3TGnOF1iwN3QIyxIhb0pP9O5U11do06hfO94bKjhksHaXDrC7yst+HyCTAjzQe++LzHnV+gRe6nEEHmjBr5FluJtaz9p3E4rVj7od2u5q0jH+PVRm5X7q/lS1OXKzLn8f7m9PHgLzciAa6JcunP8UNGl71y3xbfKFEKkNpBrvVdK77ZSU82emVTkweJeRrSGF9Z0u4BSv0t06Rdy9gYWCQkZBCUtDl4QammTJaBqxDVRw5FfXlC7yjGl7sJfIelQyGn6KvBubkpycc8R4ZNf27ZgcY0zWlAJzY96Bx4JhHsH2PeqbEP5XwumgUUEulDgEE024Ku+tFp8glJUFZMOlBSkgo4IDFr+oM6vj7bW9RmAdKidcxn/8IveSz8AJI9BcD+nu4WUg1HiOvsjmYNN6XuN5EgOnP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(52116002)(26005)(6666004)(6512007)(6506007)(316002)(86362001)(6486002)(478600001)(186003)(41300700001)(2616005)(921005)(38350700002)(38100700002)(83380400001)(1076003)(8936002)(7416002)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdKDXEo55Jydu6oQejJOJmtpsvwGmEf8yZ+9dzc5qBQUL7fn+yV9fQMQJfFQ?=
 =?us-ascii?Q?hfTkl6h5yS47K7OoLpx0A/XoaMGpkc/dzw1jdA54xhUe8OJ7C95L0O8Tlg65?=
 =?us-ascii?Q?XEaKeNLGCz0pyitzLIYcpPQ0lEWZlrK1Z6QnxTGhL+uSHjy+NXZBgGiG3TDp?=
 =?us-ascii?Q?vX/iM+B/NP1X3pYFfJdKE0hV0bVXa4SU6Rop1tvABhDzDTYOSOBXkx7DJHy2?=
 =?us-ascii?Q?vLmzgiQO2syaFVqx2SenM7man6uGf+y4atV2P8ccVV/aWM3g22w3g6qDF65P?=
 =?us-ascii?Q?eX5S4BcbUjj7PnowSIzKn/FdW39XblGAWDQV1LNcxfpw1pyQeBnJBK0rCQ7J?=
 =?us-ascii?Q?5oqHPUMW4EV10tG8gUsav1h8RRpkIsY9KsashzAx9yPHpUmCBTCiAgb7tye6?=
 =?us-ascii?Q?1pogvCqSN3R12dWQICf5eAVcnU1akGaUkAk0w1J26o2joVqMgXdinu48ZfEQ?=
 =?us-ascii?Q?fxQpds07CzZxm7+5R3znZOchcVpL/8iHqhOUIiyUpx5YScI8GD9GWCQ4ewQd?=
 =?us-ascii?Q?w31yBG+hztqHC5U01skxE3wtFsQCK/ke6Nck8t1EabEpTtoq4fyxrv/zalZf?=
 =?us-ascii?Q?AUi9uLfz6etq/e3iHfKSUz8RhX7IkwmtQsUstyjzrGx1ZhCrAOmhGsfxNjUw?=
 =?us-ascii?Q?qWR0egDbSb0dTFtu7Q9g7KxIVyhKHjX7p3M0N6JupqKZ6h9tgLxXESsp4Uk6?=
 =?us-ascii?Q?d2D8TPYQx7FLcz1Aw2qM4IPyHfvjp4VfHva10p8le2OftmNChm7usNR/372p?=
 =?us-ascii?Q?8zOD6S+NgsjbBun8IR9PVlxhmVTlk8GYmMWpSrK1uSrQz2u9q/Hz2Dk51WSM?=
 =?us-ascii?Q?mBiFeNKE6+/qciSiQD6zKnWJZC1Cdp4EtwGHoK7dL5FAJRjBhySubX2yJIMB?=
 =?us-ascii?Q?7NZQH/8z6wPGifjmVobJHq424j7UoAd8rSQslXr0i0DBz2yLRtGOAIvUmTgk?=
 =?us-ascii?Q?JBC/oihO7RypHqt6RsusE0Ug8uT7ygoOhgichPlGnyZJeT8DjjRys3Wg9Ume?=
 =?us-ascii?Q?0mfgc6pLNsCsqVT+uWR2DGp21BYOqMTYb7yMmXvV3d8jtR+LbAnIk7t/QuTH?=
 =?us-ascii?Q?i+lY//1/FCqOh40lwBSVU6e2xmrypXDtfjbjyMQkBTc15aRBVJi/Md+f9OHr?=
 =?us-ascii?Q?zibL4DRKYHAoti6At2WRplKtBjRndfF2Sp5jnRUB9l81f4nd3t712lFRL7sl?=
 =?us-ascii?Q?SYP6rCRt6RKRs1O5nraakmI424jf/0c3UKCG7FTERXQudA0AEWRhL2B+nXVq?=
 =?us-ascii?Q?kzu5IPGUywQSzeSX6Yal3SE5R3DXh5mtuW9UkBLAh37aw5MJUigxeZHrk6kZ?=
 =?us-ascii?Q?RROaFdQhGZQPaMmGdvLGapVxtvlFAO6fWYt73g3mRmuPsRYebB577jRkHr51?=
 =?us-ascii?Q?GRSHZwJYgQnP7gVLtoZbCkgmwxXlydezMCaHFGMBAs4LnN2cf7YEP0QZ9RkO?=
 =?us-ascii?Q?sVZ54DGaug9hlRY3+ZkC7092VGLWvV/UzvIHRKtMROq2Aghd2Xi4tjSdcHIt?=
 =?us-ascii?Q?bmDt/5VJCBz9k7h3OBnW/1HaRxzQvy4KTd1GGpGFKXpOsIvnbBQqz8azxPiN?=
 =?us-ascii?Q?vYYhxUURe+qNxCwPZ/zPxAy6DHgn2q6SG00QBomP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f696c615-228b-4524-85a8-08da7e6f227b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 03:35:01.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cujlY5JkS0G1NHxlFqImA/ChFSTqA2gn91mIbGXgQahDJTmImdXpjq0Kl/wL+upyPMA7qUn/wM6j6YtxSz+VXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M Linux run on top of Jailhouse hypervisor, the root cell Linux
should not disable clocks used by inmate. This would also benifit
AMP to avoid Linux disable clocks used by Cortex-M4/M7.

So introduce fsl,protected-clocks for above case.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index 458c7645ee68..0ec490ff9a09 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -39,6 +39,10 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
       for the full list of i.MX8M clock IDs.
 
+  fsl,protected-clocks:
+    description: List of the Protected clock.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
 required:
   - compatible
   - reg
-- 
2.37.1

