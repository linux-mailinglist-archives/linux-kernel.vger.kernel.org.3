Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC515AEDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiIFOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiIFOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:34:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D3201A8;
        Tue,  6 Sep 2022 06:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsHx7aNxg8+Cm0GpGcRSataQikgwKvh6et5PXJWUHdTnfBFy9H8UdAzyXd2u6itiZxAHVp7kGeBPtvxqc6Egie65oojlmqQUjqN/pTzWDNuVY/pEjfFcDwisTpuMYpyHqRBOjEFxRk1giiZOGgRmeeNDhSAu1uKs9pGlgSXisEhheQWu9H9OiYSqxysMlbCvb9bZy75xdCwsQZM3jM9S1sN5yvOuAmDG00+N3RWZs0Ufr49XDI2Sx5Mvl42rZi65/cv+BqF++7kmyswqabIQcrcN1XsuQoxAN2v46jjkSV4GdUuFXf7P17zz+lpo3aAtU3Iy26b6ZQsC8+ouhUewLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=YAf0pinBm8RnLfT00VVcsyZqqf6px9t1jlaDb8LCH4XB6hehnTvOF7Y5r6hoRPeLWXoLZYbL8rwB15LrB9qdylg1gjeMhq5zWkJFdueB8goqNZaerohOQkB+E6hsgXykT1HlJzctSwv8Cb15CWbrGkThskNx7U4IpeD1o8N2G7Ib2v+dxccrWPOIUNN33rasjipzzjXxz0w9BXHdVems8M68oT7hWxh1GnigMwhJwg7ar3y3lJsyAeB/sYovZXubGhGjjrClAkBKX2DjTdp8Lg0MhjOIQ6s2bFgoaHyw8Dl35CVJokjSO+wCsa57syUyVNJHmY8MnBiZPUCAh9zYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8yNQEMDS57YPUNAPjCr6HikpMj0/J2qH5ayn9MzK2g=;
 b=WIe92tmbg9jcfndv5pl7rEMM4E6iBmF5DwUfYgSPTMtoc9gX010hSmx3H6O68bscx0QYO1miElckhcUMDU2LQW4j3Thj2Zm1/SUDritJQAkph0fX5AkmWX9fzm6FB4dAzKSIoIR+3ldQXt4Sfa57mdBLeL9WwKaJp3kJ4G3M/u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:55:25 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:25 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 2/5] dt-bindings: arm: imx: update fsl.yaml for imx8dxl
Date:   Tue,  6 Sep 2022 08:53:41 -0500
Message-Id: <20220906135345.38345-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42bc4382-e5fa-457d-ec5c-08da900f727b
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUhR99mxC1HQJD7A3iY+Z8LFBjd+LW13PSoCzxrR5Jfxdvl+R6TpLZS6X8mwfy/vvzfHiSc7AMOEySieVOZmsToAbH/Y6rBHRtAxAQ08TSJ48HHMovecbvEvLZLYLF8Z4V+QvqObJwulvlu0eD8vpnVbwW2un3iXEVbITMGH/I9DTwxvK7QUCpdHdtOXz/LM6vjCkmhpxsPn/p5nMI89AC1i/doPF7zPt+so1Buwmfkmqf2OPAjWdEK3QFWgxOgOcZgSoJ70gWkM/zeDPQ/mG54xe3zDp0AzoT9kxg3PxHQ7ZHpHSQ/mPd1tDtgD6nkPOZopRMG5C9yLrElYVn+nLdOhjaYzsFnezEF6HKdek13hj3+EjV7qlBf9xE3pG6dXZskhLIi19SPlPy7zuiztXD8qpcviV/VJ743DLZRYL8/4DaS+2wPdxwVHh27/orRw8OrNtsh+kkGGppPsCEPTA/YWpgKWRULyyuzxCakwm4pLVOwvxCF0vOsCUcQ3L9DGyp2cwOW0/3b9KiFfukfptZNh12s5YGbJE2iHdgGgB6wbYp+4nXC/mWbVdCGp6sGaf55i5w9VOfZfAkEgeeupVrkwMBpkcqiOkr2j/ATlTc+zUAQ8i4vebf9n1ORo9AZzhRhGnXw/CUsPrFxmEmD5NoaLy7bIIKAcsT4ZMyBwJlN8myfTp8okP/zU14atd2TAo7qc5s+DNw/BqHA9eGVhpjTfTtfQnkSW74bLxirI12rURo4W1HayIRz51yR+WzfveuPWDNmNQMm9Bex3YJA5SFKTVXA1hsdJeOSUJARKt2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(4744005)(2906002)(2616005)(7416002)(5660300002)(44832011)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVg+00563I65QVJXV9OBB2uPEdvwdKB82qboJcWykwqmtAvcXHngvfkCEG2G?=
 =?us-ascii?Q?znLoGE4/jogFoWBuAH7fm68V7hUrJXifbt/qs3hJ6hJQXAj5IXOhmeTqXkkf?=
 =?us-ascii?Q?yolfVlMp+2uSRVJVQd2o3eu1QYecuaamnTEE8+eYo6klfk57TG4nvpnIOJd3?=
 =?us-ascii?Q?wXeslsT1H92SnJplIiP4Zb8YmE3FTUHU3KurkKWEAygaRRpcFTQHXhR8Rkfi?=
 =?us-ascii?Q?Uf2b3WEtu+5ZEm9nWhEvLJ7fBleszzD+M1mfZdaj+IRvLJcoMk9+uhxg5khO?=
 =?us-ascii?Q?XoxriVAyCVMH/u2XMRHuMAKtjjndYYvvRMqDz7yBvg/i7h39UULcqzATJ6Tj?=
 =?us-ascii?Q?go68iDWkz++qrXG2tNJoWicgqMeuAoDh3R7C9xLSQm7TbCcqLhOVNPw1clmN?=
 =?us-ascii?Q?Ys/7SGBkuNuOzjCvQltNG+UvQwKu04MO2ZtRFZsFbWHdyz46Se8tq65JkaKo?=
 =?us-ascii?Q?5Y8bOdJJTOtV8ABwnoNUSTQ9XHIiVF2kHIBzz4Y7wGD0o+gfyUT7vFzDfG6q?=
 =?us-ascii?Q?xeeId4wW861kMlE3F73fLqYH+RsoeyopLq+G/ehoTo6dWDhoKX1KrqhrqhtW?=
 =?us-ascii?Q?MD+dHAxY6CAmDPqVGGq/dmL+A2akwor/BHdVyb/KicD3iAU97tZoirFEJk1B?=
 =?us-ascii?Q?Y78GLsdDhrLBfImv2kFXDE6WRBhaaGzqBYiSvK2IjGFKCt7xZR0Vr9qXH/2N?=
 =?us-ascii?Q?/h3k2K5crgQGV8n3FAossNcDPIiwj5rB7kheYZtzFGOrM75AbCOZdYuCz1Hk?=
 =?us-ascii?Q?ZejLAhKfWBptqqmYzE5QO67EoAby5WpBdAovTH+IpSayvhmBcOQ7gSlNgFWe?=
 =?us-ascii?Q?mR2W3fySWb4I+tWSQGHvL5p1/68/T1f2p96zukbRPsXkTwR23ucjXCNdoEtD?=
 =?us-ascii?Q?sOpPTeVkeOg57BP376K79CQd6D7N5jOqSWZMuVXn5xAIpiRThGP6Bfc6VkGX?=
 =?us-ascii?Q?ADVYUnpRYuDKuba5JIjARlXOsUJK05MQFypvGCKwPQ3MyZNCi8As+OpVXkqc?=
 =?us-ascii?Q?cs0nPqYeofUvPxrPtp0kwDaRbZetAuHgy/p9JSGsFEPm2mQVqrlAbDpeDQvY?=
 =?us-ascii?Q?2k5n0W93OXR75HMky712TZJYsqDlhpsfNVUUK0ZRHB5RX5F/6LWHgdnAGARR?=
 =?us-ascii?Q?lXYAnGTz3vo+LeWEp6j4BTAeguzFG14MAJWheoZJSNoZU55fseiRlsxNG5x2?=
 =?us-ascii?Q?+dIe+vxdOj/TsBJtoKW+ODVqtaJOVsraX9giVHQ5A5Vy/I3t8DNn3/iWEC24?=
 =?us-ascii?Q?g5/bIojxi3H56gTHDA61nnWLzJQyKHKFCYsEvAQ5GDdmT7hNjubKafh+zWkI?=
 =?us-ascii?Q?KPh+pt04XPe8MsaBBCElD3dqatyF9p/drmRp6IUnZUsYIFidV0lrQs0BM6Ds?=
 =?us-ascii?Q?4UCOlTardzJHG2X70a3lEVsAaXFVTcwZqOwWRK4hw9tpTRfaXGjbxlJXsyye?=
 =?us-ascii?Q?GCNt3/GUC9M6b9jeKyNTyyvTI10wV13tkrXSdmYI0IRUAz9dy8/OzhJSdJzz?=
 =?us-ascii?Q?ppwrh8hRUof601JwUrg5vc0PZjshdalf061551WPDygh1ighvu08OiF8xcGd?=
 =?us-ascii?Q?Pl9vYN7gIzkSBl7BrI/VZS62uRmXcJaZvIbSPJsz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bc4382-e5fa-457d-ec5c-08da900f727b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:24.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jM6/2m71LvxDSnrOQnu06stEx6Azl+IaWtpNT770k9Y6Ft4Yg+uWZnvgu7HppigHtB8XjplA7TmbRU79Ib9Tkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8DXL is a device targeting the automotive and industrial market
segments. The chip is designed to achieve both high performance and
low power consumption. It has a dual (2x) Cortex-A35 processor.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..4f4c9c0a1315 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1034,6 +1034,12 @@ properties:
               - toradex,colibri-imx8x     # Colibri iMX8X Modules
           - const: fsl,imx8qxp
 
+      - description: i.MX8DXL based Boards
+        items:
+          - enum:
+              - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
+          - const: fsl,imx8dxl
+
       - description: i.MX8QXP Boards with Toradex Coilbri iMX8X Modules
         items:
           - enum:
-- 
2.25.1

