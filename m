Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E614D2C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiCIJmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiCIJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:36 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325C142369;
        Wed,  9 Mar 2022 01:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goDxrlfcfBdPhyQUyNkappXyvDuUHv6qBb1fV6xiAm11OiT0QgNRf4QbAWkUAfgYzRjfT3JPRQL3Yt0+XfkolVbmamcA6buV5z+TfLnOpISCwdq9uvFurfGVNnrdPdDeTxjtiQmamj6Z2RoSSM7lPXVfsrobPERTfEQ9zIqp6DmxO9YtNxAs/TCWoxfE9EPSOyhWyP3/HEIcktGKKgnlXAo5ANH3l0d1tKhs1bIpeSg30z5l1mQ82e2PZMkYFd+goY0dDqKOW3fOZXIBZLJZNAQpQVwooWnapwgRkGdFpN5SXYUlo/Bsl4VpAvWuhBDMmnScKZrM4hLwjuE5/O19WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xioL4ep15kU0QQQj2Mfe14IIU1YzM1sFNj3HBLeHwmc=;
 b=EnjZ8RGw8gOVfJkCabCOIOJkXVlXbJCHFLK0H+JNZwJz9i+gP7MjgKOOdjhZJWSj05IWzEQAjpKK9UqAKDt2qST9qw4tLRBXZhlVUTMQCLmC7lNsUcGMBTUor4S6WrTJFqYWekVMtk9aNXynMxNs4a3CcJMxNXhnFmAyGDR3VB4Gp6Bo/xJGclwplhLQKB5zcdWBYFjSI49yghSN1QI4vACGt3BhOKz30x1BpoG7w7kEFiQaJKqqKwVpwNxrvdD2jdkCK0UV5pvWptMJV+E+00JYabvMsnnNGCLQ5qPvALFEpA3OsMQZtCpQoZQvoeMr/XqfsgJE5CETF6vtCNJ9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xioL4ep15kU0QQQj2Mfe14IIU1YzM1sFNj3HBLeHwmc=;
 b=iILnQVm4PoKuxq9svqw+coYnEAcqMjGiSzCA6UdU15phOoJHRbLzrKI5RkUgfToE5oZXWEUV1lpncucMHnijuOnhZ0akgdoq7X5nSxHx181rvNGlbct0XZlMFJu1uIJyNP7gy8QzF9i6y69eMS1AhBdCO/lG711kgIPOCaAivkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] remoteproc: imx_rproc: support i.MX8QM
Date:   Wed,  9 Mar 2022 18:21:17 +0800
Message-Id: <20220309102118.8131-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309102118.8131-1-peng.fan@oss.nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2465fbef-2daa-4736-8d72-08da01b0fad5
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB6043293939AF138B2DFA87FBC90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqUZryUwZJWRfimX3n4hXKtcL+s1yMWZnTI8n5R64iINxBoGi8dMQ1Xm/NiJ7X6nOkT2yQXGQMFYv5t7PzNZjI4cpz0IEWE07UMqb248pgzUOyibXBP2dcWLsM0fEKsDTnmd5rQEOI3ye+TQYT5n9pg8zdsCXGVOpb5DVwXVQhod4c+njGU+JjdTXkXkCaYyGrL00dcZi+k067iix0XqvA8PcS7Q4Obz2QB2GHOdKfxHcV6HaVcJeLUG98M8t4pvKzMEtZOHU5C9cIXarGzk1kYglY8NP5XYGI678txqyWOdK/vRcNcuGfgpHfVgLo6lA71j6QYgKFxf8VQP7TcTLEESquIx+7KVOEj32EiTVzQFG6KOM0Pp6mtgJakOKA4Kxcn2Tewa6xszB0CG0Aa9ZEnePbRAKpX6COq60E9Lwr0hcuC1m3f0R4aQ1EHLjf3XhB+ZVyg+ZzhlHzurBCJ1uOCbvyN9MvQYn5wtlEiimbLLpv+p0hd6qeeow/kljo32GJNxLOqwrxwTRUqYqaTVXu15/KldAA7Jl9EWNSrHmwpNpV6FNpY0xTqjp2/PT22bd43Im+hyFNFEm9eu3EOZvWd30ZitrKKfxLrq9o2+iVX5vy+EeONaZE54YIDMDMdoPtHFlXqALX4HIqSQfj5MPgueHBUJaU9rhjN5QIgoEycMuG7j9e/1EMTUb8PlNOBVw1eLBPEs/GeSnQKFvFUdPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6666004)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mgk4sII+n0s/z04s051iTphRFLR9JVXdhXA8OLixfVIfU+5TT1OagR//5Dm+?=
 =?us-ascii?Q?F2oXkl8R1w+VzvV+KaPTaxKJ2DPphzAuYeYzZ+vcoiIyB9jyQt9fFlGBUtn2?=
 =?us-ascii?Q?kkCaaOJx+a3p+3SyJfNyyOzZ7sZ6sAbLAg6DpIOyIM781pfCxN2wy7YK0S/o?=
 =?us-ascii?Q?pL56bWnNSwq3aXk6uq+ZV+2hWBsZXj7FBDCXShfbcos4JYOBYxFX3BQl9zz0?=
 =?us-ascii?Q?J8x/hIgix9rrCVvZlGM1eTvD2o0UyoKXAaoWfwioWSEQaGrL8U73AtQrybcr?=
 =?us-ascii?Q?95wqm0AdJqthxB5ZFy8AQAuexN7hwXUnYlCJy96J9/KJI15b8mFr0iZEi3J1?=
 =?us-ascii?Q?bDmKssvPfg7fHm1bIVW7ZCFtkjnU65AJHKPeMpTAfcd4Nkc25hTjoICkKMm+?=
 =?us-ascii?Q?ZN91M4dNelcdJP/PA6e11B/O5+q3roaz9c89UqSphil/PGKdgU/7jDh7JVrw?=
 =?us-ascii?Q?PQoinOCMI3LVfZiSxJch9spdJUzc8M4zLthVZPSG5xiVhKFMT4G62Dkczcze?=
 =?us-ascii?Q?6C/xt5BZggUN1UUR+WTN9d8MxAmJCME9TE6o/1DOueZ8W+ddMmBvnI3TzgHM?=
 =?us-ascii?Q?ILxkWAP0vgVUdSCv86Ths3zLxDsEaBJsTj7mmQXibxMD3LGDUQbcfiqzix+c?=
 =?us-ascii?Q?f3Fl3W2EUv40lBPAX58JkfgLBgs7Gs2f2DWh4tWJ4VMMLPWuAv5Fl2xckvjC?=
 =?us-ascii?Q?9iDlwXOchRuEpE9vmlSETAXJObfwlMIcZ6TFBOwd2lb8va2EQz4iHY+IGr+6?=
 =?us-ascii?Q?PvPdK3lvvdoN+SG+5ALZh1OnNgvK6kPEMZ/ZBMzqlIZBRYtW9CgA+UCDovrp?=
 =?us-ascii?Q?4W1pxpOgNlKpZe/G7ofJm7r7LprelZVDXbomd/8vzTXYTptSdsQ7J4FGtsRI?=
 =?us-ascii?Q?L+Ocy3eZLjGW2KZyOAtDz+LvpM2eDTGfOjo9F2Tp9KVXojBUZtnWwTlG3uOP?=
 =?us-ascii?Q?bpPx1nhHlDdLyEiG3tceHHSDEu0xeEr+Qjhc1RxkjpY2eGjftp+ccmIp6mEc?=
 =?us-ascii?Q?xNMO7agx8iX/jEhPlrt3XILqf+fQ12/QVyfMJPgeAnPVqjezz8JwNMUa0p25?=
 =?us-ascii?Q?cyHE+D7lZ6F7tHp3zGC+c3AmWnGkA9fhUbx+9Z7UEnCGCE4qx8JO1vMieGkr?=
 =?us-ascii?Q?RvCFALD7alpghjimoVVtxzDL/2JZrnKN0fIsDEKVLO6BkoQu6y5E4mF0kg9W?=
 =?us-ascii?Q?IDcNpDYCPVlPaOESokmv6HrD6l3HH8zQA7gAz+NcUnlYtj3h/wpJqWrsmZO/?=
 =?us-ascii?Q?ew2m2wi+WVOjYi1QeuO9+dn/F63dTvqrG0QHPV+6P5iUX346mEuaDl4GGfDB?=
 =?us-ascii?Q?ZzoM4Ffs5k1kwGDn8sJikQ1fNxMuBsSvl4AkWWVb7Sa4O6MyeMirpPbIzmxb?=
 =?us-ascii?Q?aOHxyCjKA+ms0bWNtxmZRfQIlhv/pNq79EDW3X13XxZGjwV39n+75MQ4ZHe3?=
 =?us-ascii?Q?weHITTJQyryEard+hMSG02F3N1GY14s/WBMY7ggJX/8IpztPoemBsafjxg31?=
 =?us-ascii?Q?2e8qH0RP6XxXzaTBhfKhO7RI9IvMD461x7IGkf/YDYAimdHRCCXKO2mxnlMx?=
 =?us-ascii?Q?LS/XaDjyjpsD6jvSBVSemSsKgHByz+/xxzm7RzdC74ozL8gX3VVKsWp5AlXn?=
 =?us-ascii?Q?bDGIcUTsbVqGN5j3jBSIuFA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2465fbef-2daa-4736-8d72-08da01b0fad5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:26.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3SFcx33JJUECfJbFm+b/uJNYiOSolSkbsdqgxigPha+BQlEXBcn+pskEJ9nP4Dsy+Zea+0YYd2F3CZ1t71bfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
M4 cores, the two cores runs independently and they has different resource
id, different start address from SCFW view.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7b84fb6d168f..adedecf8def6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -75,10 +75,13 @@ struct imx_rproc_mem {
 	size_t size;
 };
 
-/* att flags */
+/* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
 /* M4 own area. Can be mapped at probe */
-#define ATT_OWN		BIT(1)
-#define ATT_IOMEM	BIT(2)
+#define ATT_OWN         BIT(31)
+#define ATT_IOMEM       BIT(30)
+
+#define ATT_CORE_MASK   0xffff
+#define ATT_CORE(I)     BIT((I))
 
 struct imx_rproc {
 	struct device			*dev;
@@ -98,11 +101,25 @@ struct imx_rproc {
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc;		/* resource id */
 	u32				entry;		/* cpu start address */
+	u32				reg;
 	int                             num_pd;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
+	/* dev addr , sys addr  , size      , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML */
+	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_CORE(0)},
+	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_CORE(1)},
+	/* TCMU */
+	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_CORE(0)},
+	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_CORE(1)},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	{ 0x08000000, 0x08000000, 0x10000000, 0},
@@ -260,6 +277,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.method		= IMX_RPROC_NONE,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
+	.att            = imx_rproc_att_imx8qm,
+	.att_size       = ARRAY_SIZE(imx_rproc_att_imx8qm),
+	.method         = IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
 	.att		= imx_rproc_att_imx8qxp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
@@ -364,6 +387,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
 
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (da >= att->da && da + len < att->da + att->size) {
 			unsigned int offset = da - att->da;
 
@@ -579,6 +607,11 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		if (!(att->flags & ATT_OWN))
 			continue;
 
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (b >= IMX_RPROC_MEM_MAX)
 			break;
 
@@ -794,6 +827,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			return ret;
 		}
 
+		priv->reg = of_get_cpu_hwid(dev->of_node, 0);
+		if (priv->reg == ~0U)
+			priv->reg = 0;
+
+		if (priv->reg > 1)
+			return -EINVAL;
+
 		/*
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
@@ -987,6 +1027,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{},
 };
-- 
2.30.0

