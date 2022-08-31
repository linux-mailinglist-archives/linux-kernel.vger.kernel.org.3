Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0035A7ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiHaJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiHaJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6DD11F3;
        Wed, 31 Aug 2022 02:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuMbswBR/fkHpud35AIMu6x3FxE0AzlLqOXrDlwgONssFXiz4aVstbYjaF90+1KGhIUUcmXOpaTEIyC//E+HuaRMXYJT/JtUzPvnpoR6DyA1vFhc/4O2OvB+/SsJSwvmwsmtVy0osqjG8ItZo639UYrc1O8J3qCJ0N7uZJO6Vh4sn6gkoL896U/uWusZZlIiho57lLCpTB5TqD/pgW6z4j0pV8UnWy6X+pWTD88UvPH9zhVUZYiz6A7lgXggASkkZEEWuZhnq0dInxijkDzXirR2u33Y5wvvlRlSM22I9+rUo5qW5/Ix1T9c236RixT/eTA/yPpfnLCnL100o1tKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zGt+66yfzfLcSDaLoDxdZloPslIZIuwAc6zNa7eWNY=;
 b=QniSkiMVPugSMOgzOW6S5GuIXhGokBsF7+Ak2Cx50kV+KR4ElaxUg+dOyVdT+IfUZvu36NPNAjF5U5fLag+x2JHMAbSpDC8qpdkIrufup6UGLcfrH3cG8ak5pz2d2AhT3/BYxA7u1hIbEun3u2/tytbibJ3xdg5w+NAn2eOGM8IfgZ88lHo6cWCaw6ONC3Nr4JRILkwJURG/erLQyUGSXvsSxCLkLjs/e0I90Gu82LEZAD8s/WY47Tj1742DYp4MB8X/i/uaMnPmy9FQTSC1xwf1vX14Aq17Uox8CGn44QRMlBcRyKsokrkr0P5v7k5BLXsuK9sCfEDVTvzhRzk+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zGt+66yfzfLcSDaLoDxdZloPslIZIuwAc6zNa7eWNY=;
 b=F0UM/iafgrZfQTc4Vhz1hOu9qrp+T6536zuVbaefUr63Yp25BYnSTeI3B8iRfwegVu0pnZvT0pB/gw7eZjwsoMK0vGfd97B0vQZ+H0nh7daTMFyBd6afXDwM8DmF5DLMHs+1Se60JzBqH5Xt2pOyRxY97sJCiWkJRTyswKQrXJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:58:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:58:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/6] arm64: dts: imx8ulp: correct the scmi sram node name
Date:   Wed, 31 Aug 2022 18:00:12 +0800
Message-Id: <20220831100016.3649852-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
References: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36db6bd9-0df5-4cb4-99dd-08da8b376a51
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYVkh/o4l2o6ll4HhUk1203IoGw5cM0ZE4Vy4l2UdPyfvMTJOnJ8YQ22UBnAeGofxaqflDji71M+hHFjvTle+kSYDcK1Kfdy+XIj+OKK2dtF/j73Ib8DpjiFAIB/oqALuYr85detnuFheWEy4fLQFdMkA+0aXblJxc7POra23CZsOp1KcIuN5UDnpw8Bet+fROPf4qSWpdI4suD2GZCFzHqDwbke6+f7wQ3gW3uf4evRs6yK9C4gYc88uq5fIdIe4i/pIoXo/pCggMCUjQb5Aj0lS8Baztr1gY5fxDk/ANRHzCjCC5PhPa4bL39kZoRBxDbzXvW4bEeeQpF9ixlPk2jX7lwXm7w8/YgRJR53FzIWrq1BQ08bB5U16TEQxlpGbYz0Uq/H/8l9omCk/RD5wRar0FIqx1NbOPRkrAUOjlL85tIx8IEWSjnMyLdSoxTTjn1N7hgaJpXaxJ9RJ5nPBy6+K/Pc9bkeLZ5cPDJhrnUyge2jPyWawMnQSvI6OixlQn3REiP2lAXBnjAC1AonWGsy5EiKfpRV7bAIRmtt0TIzTf6uwHSOv6ti4O+EHYOsAchNv8Z4Iy9JQMcXbIHUv15+nP9OfAasv6FpIdKwI5uLkyKWYme1INqgSewTgJq+0m51q7gfAFFpEPd0XWCYSD2UXZEntLlFcUmKs1WlHdTHE2SXu/EimNdrkbt6Xc4AQMCTzU+hMCKBMClvDD1+BGtRY6+P9N4L4pl70B6pa2Aw/PHPwmKwBsD7OTnUgkMV6f63EY7nYxdiH0emxCwB3JPGNH6PlUKhOSZ0jvQKgJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(66946007)(8676002)(2616005)(1076003)(316002)(4744005)(6486002)(41300700001)(6666004)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKQ49w2mwsFiTrS+1ZBlgsNAJd53W6mPEKAohIBjhLz2rzUX8Z3LIJ5vyj+1?=
 =?us-ascii?Q?nNSanx+COUF1vcvfufqZylwJFSG2TBoEiSN1BhUFLiCAHO4Q+wOl+obtmk65?=
 =?us-ascii?Q?SvXyXBjU/GCVH0S7EbHUOC8jSKS0B3+C9b+Bf4SoKPwA22ZdrUxejvXmXfht?=
 =?us-ascii?Q?21Y3MwCeEVUezLhGzC4gcRk54foJS6+u6sehzxxqBzZ5LD//dEP46fmBViQm?=
 =?us-ascii?Q?6eGTVj8rYeoFCGMczNblRtCkGgNmTECmOW4hGqBi9d9LIGuyv3lR6iz518Hb?=
 =?us-ascii?Q?9+BiAbrZixgXLh03pj9zEVOrKTWf2Sii9Nvqs6S8C+NE9sJ2S+ksd4T0xT6a?=
 =?us-ascii?Q?9Fwqa3Ygf/5zGdX8SAk/Ipc7PqJJQWQO2ARAuezX1Zp2/h01zi9ZvFL0u7fi?=
 =?us-ascii?Q?XR+yERvBo0Wz4XgptBA5yDaZUYiM/p5zIvy1CA7x2/zOHRmTYd8Ay+HRxMtz?=
 =?us-ascii?Q?lE8FFPu2x8mtiEIMqjz3nqije3E4+BdyDlDJl06B/6LgfqJ4v0GMxNupZIJI?=
 =?us-ascii?Q?NmC0x/kYTekoGqBZwBUe83oSmVKdWH5b3p8OErloGpMnwk5OqF/kXRYqI8RH?=
 =?us-ascii?Q?rfKuO7ksK0xPZQRvMrzGFbbnJD+G/gJPmTI9AK7hUrMH4JyMwEqIL4IRv7Tn?=
 =?us-ascii?Q?Uny3jA6kM4fGep/UenztFa0SL230cYQaCH305B8aQBFj4m/EfkdJoUfznKC+?=
 =?us-ascii?Q?/Kz7w74XDt8v54gYozAmH7jEYjNBeIm3An4CkH59uIwGUMY9uUHqlF8iteOr?=
 =?us-ascii?Q?OFLqFDfDFxH9hz7ylDz5m7ZoeAJxPhjm+CnGrUVajlc9SLV4i4dL+vJhbHey?=
 =?us-ascii?Q?GoD63Ln50IyWkmviGQqr60ljGjhYrzn+mNG7LoqNWAZSbgKBSSDK1DhChMYH?=
 =?us-ascii?Q?k24zWd+Mo0WYhqlwxR2jDbP6/5stWY07gU1mAkvkeArR4xKi3jHhoeYmlhOe?=
 =?us-ascii?Q?DWQN1G13rMK29d5x1uuSPFUzJ2CPYu7vWR9jb6d4jIwGshqOWjJAY0SvZa4y?=
 =?us-ascii?Q?NodJQsdTqct7ZHIxk7XR+bMluCYgRs3JBKIRQWGqrrDyfu7p2NnwP9bLGs14?=
 =?us-ascii?Q?f5Zzs/Af11Xa+LDXJMKCd7P59N/XNxxyoHNc0XbQEQAp1Dcojbfda5p08Rn9?=
 =?us-ascii?Q?kf+SaUdF98pxy+mEPWMRYlCh4Y4raOWhcu8iZLPKNQ4RNbdYu3yRi5xvkSts?=
 =?us-ascii?Q?sMlUZ07tungjzb4UC4VyIfU583hNdw1EcktuuCaXJ/5bAHKwVVq0LM0t7TOD?=
 =?us-ascii?Q?y9TZaBAGZokHK8g4XkqMvKaDhSFWCpQA5kTuk4JCJQ5AiFH/ohEN4Ibh0kJP?=
 =?us-ascii?Q?S9QJWvmhABzjj7LSHpRToxmvyNKTYVHNzrrL0m935MbdzlUPyAnJ7sRljPqN?=
 =?us-ascii?Q?/jIDiB2PjBRXBQyUtEHLMqcG5yKPf7x68ZKooJrJEOcOQBhnnIQDWDeH92fT?=
 =?us-ascii?Q?FZ9SzvKSfg9evkpzlkMUEtsg2VUUn+FWSNRFkbezoQZz4pALHCcUxIQSPCCB?=
 =?us-ascii?Q?oxD6/5mQP3wT/5bnC0/Eot/UgpCUAyqdwu3vk2t2J8pd+Oh3VYZRSAOd7mdO?=
 =?us-ascii?Q?xVRqvD+xlPrhhstDDQKEmSehMsynqQ7Zi3FRxPNz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db6bd9-0df5-4cb4-99dd-08da8b376a51
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:58:55.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hymA9aFxMbVFmaq5vX8IXEJqslaDSv09rx/7GxC5i7zGPIZf9QYpkKaopCwVQlXalthCLjDQ2p3xvrIR55kWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Follow sram/sram.yaml to update the sram node name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 8460a3cba107..7a88d7016b49 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -112,7 +112,7 @@ sram@2201f000 {
 		#size-cells = <1>;
 		ranges = <0 0x0 0x2201f000 0x1000>;
 
-		scmi_buf: scmi-buf@0 {
+		scmi_buf: scmi-sram-section@0 {
 			compatible = "arm,scmi-shmem";
 			reg = <0x0 0x400>;
 		};
-- 
2.37.1

