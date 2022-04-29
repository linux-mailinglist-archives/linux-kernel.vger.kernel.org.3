Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF068513FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353587AbiD2Azg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353264AbiD2Azc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:55:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE3BB93F;
        Thu, 28 Apr 2022 17:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKKp2UNiU8xvjUm4pQdYV946LGGQ1GJ9ldKQ/zX35/svd/L5SQYTKk0jLDOM0YaVPHAsIJ4pMKKlD/xc+o1Vz3YpUpj6lIgQsha6QFH2eQa6K65cdfjyFasUIKfagrN7KxOrxtJODyh4yy9hTHFQbDypmCZPB0+8nCzYfjdsTuB66eTljOYFmBj0rvYv5Ny1zR+c2WkKWZqH4wvnJr/mPYsVbPxnZpSgrbT2EPmAwGUaDjzUIvxaA2cY8/0v4/PG5uedoWij+mAv/39xA/SaiLsHlmt7WRTo6u5DZ/MZ3dESVnt0ZfgF45J0IRxrKQFbNWljoHiqsMUjNOTxEPP4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo1WQQctowffgi3T2KDx9YRoKcASexJj1dvj1cv6/XY=;
 b=RY6ygXOA+USd9JH7QpUp1F/sixPrD6PFN849rqxzxPLyj6ROtHoEvJl6Y6Wwld5pFbqCEljWXYr9ikHakrYsJVJ08j4yoDl1F2gmzNjGto3FNnQ8MpE9YhD/uVnCGfLfMv0MbVq6B5WaGyVyzKc2zXp6UEb5ckKQNzWe+BuxJYzMXMjkj4QFLGLzQhfP6nI9aMk8XLaS8ec3i5tdhRasv6j22uD2btjs+gEQRl23ghGVzK5yLsG5lC5txbv3TI/wiiaUw7zKlerRAqwwoF9fG+KwKmIMDlUimRzIcvx6/jcwDBwaBGamw2e1RFS6Zh48wFa4WcKBvbK89KUa+kPJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo1WQQctowffgi3T2KDx9YRoKcASexJj1dvj1cv6/XY=;
 b=TdvTGLSksP1babj1Y0esqeAU51o7G7a5idZnZ1ZjacpWVRi31SHUPssNzstfpHyyFmNNkkbNJx+1FrFOrTkpnmyU4uAWHAu4661SmLsXS0rUm2L5W5BcUuSMV82VnQb0KtNKeY5LjFqMDo85olbKcUSUuecVx4vHOuJcdwwcC8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6619.eurprd04.prod.outlook.com (2603:10a6:10:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 00:52:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Fri, 29 Apr 2022
 00:52:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: remoteproc: imx_rproc: support i.MX93
Date:   Fri, 29 Apr 2022 08:53:45 +0800
Message-Id: <20220429005346.2108279-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
References: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68c6f9a6-60c1-450a-25bf-08da297a7fc5
X-MS-TrafficTypeDiagnostic: DB8PR04MB6619:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6619C224727BDF8DEDF13C18C9FC9@DB8PR04MB6619.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HmoRg4GW9xIUZRshq1NSqOkQYw9U1WUWhkW4MVPC7oG0hahy82nlr6uJ6TBad0nZqNZ+h8NOzO3j5hht6dA1o80/9x+bIgmtraWqpUzPhNeOTu9km12zxlia8Q53Vf9jwlivu0vWLxjHsjYcDCgKwH8RY4g6GNkB5+a5uAV+2kBDANelWf/EWkgG4QsBUS+aXkpnpgR3OSGViCGNj4FcVcS6mkM6+H+gmlHtFs6AnvfkvfGvSILoKGmCcTj+wa5gLOf4jpG92rcP+uJaamvQY7dnNbJv3fvyzn2HR32kpuGuqbhRUn6PoFVNrnIjMxrPOW1kgsDnH8ovLdSSgKqlOClEPX4jkq4ul60oHQ+Q9PwfON79WlWFq8XvcvAJpe+XIco+iYJJfkTTYKJMR736zD9pKZ1hV2B4+0sGDiaIgi7mavW63JzvTFT4gc/UpJF5I+ww5YfhOS495qvCJISnQreBKL8nstMPxc5Z0j3uhCPSEZndhkAobVHz51pnmemed+Mj7j3fzdPuIefFMnvAkAgRIztoSGNkJY1b5GREJGIChvFyiRqMtH8EhAgODktkrs32kQ1X0ZMP+WPSEerAQ3YfBcw8oPur8LmQkgXjxsG/x1aVNRnz3HGQiAayRsyMEkm6jZw5JouN1N+HIci1rUgQNRQd9gxIhbG/NAMc0712xZtTUZw2XwtXg48E0TupGJNMKyRQVo4tG/oqab4dIRBrQAh7XTUZGCfrRhMYrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(4744005)(6512007)(2616005)(5660300002)(86362001)(316002)(6486002)(7416002)(508600001)(38100700002)(38350700002)(8936002)(4326008)(6506007)(52116002)(6666004)(186003)(66946007)(66556008)(66476007)(83380400001)(8676002)(2906002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWhJnaxUW7cR1oPjgXECUmdE32RdOafnWuuoIoW8UGeSj3znAnd8D6BLZRVt?=
 =?us-ascii?Q?sHw6ObmR72wzZFouIxo9ZD9yrJO/6cYH6F/iivks0A2JVl4YTU/qMoNaAvgH?=
 =?us-ascii?Q?Is7f+18/JcXlSf4ANj6WIuge55K9rbYq5kUozkNaDWtBGnxtk8lKn4nHCAPD?=
 =?us-ascii?Q?lORmids6KGQ00Mv392nNbkPQdAvAK6lfmuZhD1EH+doDT2pyU6lfzkYTWztp?=
 =?us-ascii?Q?kDSfgO5PkEB4RLT+H5iWXOlnXdl5sX6A/z0xag9F1ldcFKKKLoJp61i8MFrI?=
 =?us-ascii?Q?RwCDa8ICfdQkQs3gEYjElmPOVYAJlyMkuMFuocQpe4XcDUxI8e/M8f8h9A9T?=
 =?us-ascii?Q?SU8dFkd1zwyZx5vSTTmTrjSlTqgM1pDrCMnGe5dVolNdi0nz/yyMPDNOfURs?=
 =?us-ascii?Q?8Kldc1D9MIOQiV2PqUoAjUp6gtdYs883bOIL8sZ1kf9mRZn+Fyi4aWpMMIBx?=
 =?us-ascii?Q?oa0V3Ku5JFZgxwkqofIn1LwHIuU7mnu/4ig7hnpfPtm9klFTqNlVKpmqDh6g?=
 =?us-ascii?Q?UBJ3rZ61ti8XfFO3yrwcjU35uOBAdj5cap4rIdPhBPC/di5G9oEckOuvU+yK?=
 =?us-ascii?Q?Ia2tSbHAu6pJGbybRlmRJA3d0cTZYqnBOPHHdgRviw8VhB0BptNrzPogy1eK?=
 =?us-ascii?Q?a+HkJOzQn/1/kRqC2q9wkd0qsemJXd1M2E5YI9EvLgDenuR7aa6wXvYZ/0Pm?=
 =?us-ascii?Q?HRJ2EibG/r1jtJYj+Jy1yRQTQWn8HzD6k/LUwh+DZxU7ZM+DVCADkjxC3Scg?=
 =?us-ascii?Q?cj+pz0KES4HP3JFPZ+npuou+gMHZrrEtjKV3emOUm8DdaxFGUIt7Erd4RhPC?=
 =?us-ascii?Q?JMebA4mGJOe0EFqWPcx1r5NVOMUgozx/iW6JPew/hQTcUilicORFl81nlL97?=
 =?us-ascii?Q?NfN83kvQs539DdvXnhzgcoZnkPDxMlWnMAgvXn5bmHC9VBZSnaCnW7zlc/20?=
 =?us-ascii?Q?5091/qcw1hGzJhzftWKQhD5ZMB2LYVdV7B4qDcopG2uglYjLvAKxsz5HvDfK?=
 =?us-ascii?Q?f7PrJyINS1uJhC8j1wCGkU0rnstWy8V+hJLqgl35YuJyxopljm+XPYBBL2bZ?=
 =?us-ascii?Q?8xtroJDPP4zPL9QvzjaA+LIjDhXZcnMLPIyky1Dy2AD7MIS6uexTChoyAnRQ?=
 =?us-ascii?Q?nIIUk099/j2+X1Oe+amzY+XAFPoXrolVW/4Uem/gczExUjV2HRNbPGG1sX8t?=
 =?us-ascii?Q?xA8tpvtXQUQQH2CZsLq6iw4ljdbVF8xqyxEpBtd3W68DaZi2SB4F5JESwTwv?=
 =?us-ascii?Q?6hcT7aKhRrlQHi4SsM/M15VH/bJM8in5rSv4o2t7WU0REfSCzhmeZKHBrMna?=
 =?us-ascii?Q?Ax5gVF3Ji1KuB+QzObCKmzD+uwcIUjt/iAmyWqxwX2oOmFFsCD38QFurdN1J?=
 =?us-ascii?Q?7BLh287UBKX6Yo+2k0d8SN6xHpezD3UcIgKr+3NbGfmUkM7BR4BBJ+B3O+NT?=
 =?us-ascii?Q?8Nzo5HK9xJgFVUNUTwwEoCube3gmc+ucq61Htft3ND4PUwL/2MZYnxpuqCjA?=
 =?us-ascii?Q?MkYdTg4AIrNMUfqUw9dVuFPeY8Z889+vHAIOhAwySU99ZC24PnL84OBhHopU?=
 =?us-ascii?Q?MELx5of4B2UuNcwo6zK+0yzsJu418LfVaGecAr6D38uynDKDL3M78J/KjSB/?=
 =?us-ascii?Q?XzUoh3TJcVfCyk9GjxtBcy1G3YpHaS33lk8WpJF/FUYI/zIszEXIJswViLSF?=
 =?us-ascii?Q?2W3XsypzDxH00qVmYBjeRq+LAGf0mepC/ED5FboZh/bnDeOrgt9+4qRPxhZO?=
 =?us-ascii?Q?XXCArbCeWg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c6f9a6-60c1-450a-25bf-08da297a7fc5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 00:52:13.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sopy9jokUTJihTFj/0PYRf14ILVIh6A05omrxZHMaUYvWMGQbq5pZ8P+yE2f1j6uC1vfwgLFLRdktxferIcEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 remote processor(Cortex-M33) compatible string, and
reorder the strings in alphabetical order

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index fc16d903353e..3a1f59ad79e2 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -15,14 +15,15 @@ maintainers:
 properties:
   compatible:
     enum:
-      - fsl,imx8mq-cm4
+      - fsl,imx6sx-cm4
+      - fsl,imx7d-cm4
+      - fsl,imx7ulp-cm4
       - fsl,imx8mm-cm4
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
+      - fsl,imx8mq-cm4
       - fsl,imx8ulp-cm33
-      - fsl,imx7d-cm4
-      - fsl,imx7ulp-cm4
-      - fsl,imx6sx-cm4
+      - fsl,imx93-cm33
 
   clocks:
     maxItems: 1
-- 
2.25.1

