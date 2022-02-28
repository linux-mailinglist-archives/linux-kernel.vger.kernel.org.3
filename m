Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7C4C613A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiB1Cjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiB1Cj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:26 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA4A60CD1;
        Sun, 27 Feb 2022 18:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuP2J4yBTW8eJpPL3b1NEp73Ayp8E7Czcdra1NJvIVCHFVZdWMrMaVH3qln3CmQS1PrTJJtBuKS+EGMfcjzlKh01hqIr7lAtNMZqwDUeQf+b/T43ZYsYaymeHF0ac2Zb1Uyjo1pLdBmjpt43m8U8ZmIGsqfF6kasCLtoKsoLFT6r2b+Jhiz20u6NSwC7DMHZ06V3wksS0zfGUefKzdBgY1+S0Z2m95ea8WEgU81TaYnNw6Eg3bHfm25ZwZstEygGo5V8mrfAsW+fBXiJVGnv1MblO3oYW/7Pc/mBiNM1l+w1UYY1dZWn+JLW5HmTneGsStrZf6C5EwcrDhPn235u3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=PEmCWwny8c1NLO2QhTAoLjFxJW+Wo071QqmS+zX2aeRJKnanUmsaYRDi7B3snNrdQ0fKKlAXX16GQST8Yh1UWmMRxKPU4NrsWTCa91Ft4V/x1NUmjV23ihNtJFmLZ37I9N89zEkoj3Yhx38btisk6qxpNuw3ybZy8GFcuL9FIJsSxLvg1kKGs3eO/KzKHPBtMVafUYWV6VSEC9cZ8PlqUuRzqfMV8GXgztrXbLys6gNN31C8HtqnW0mtjSbrS2SCPDNu3N9ELx9HrEFBQlvPlzQlf8ENNWisUn8TXpjlMQLnucTLq3vPFrOtGXw0h+nrfFF6gHl/WunvL1DdjsBxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=QqynmDcYDWnIQtVq2SOmN5anJh4TKf9IUfZ385KY6Imwo3B/NK+dmLGM89oNEleZDRZk0BAiPtQlDiNwqqqlDA+XvCjSjhJCwXmF7BQS6YiDvzbjHtuOFrIvQl2cuPkBL+zLbi5kTUf/197NJkUMH3nf+ZdrfAr6WC3DE1J91mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/5] mailbox: imx: support i.MX93 S401 MU
Date:   Mon, 28 Feb 2022 10:40:13 +0800
Message-Id: <20220228024013.2866386-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd7b0051-81f1-4a12-4691-08d9fa6370ba
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB87207FE256BCCCF89D46B9D9C9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U15WiBbO//ghXtoCKUHuuX40Ialirh2xqIUzkyvzmzFEmuz1psYvLORwaLhidDOfNloo33k/jpLR8+uwp3quiuoSrjiXpNXFr8FDvQd+m/uRNelKCgEMx9POuUubwgzvGw8akp1LTDhNPOPM2xzGemQRqEaOxz6TGDL5/4Zp0+/psoO/ut9/oyPKl1PvQRIAs3ivEFlRJ6QMrl0QLqqXYZQHI+VCq+rUpXTFLA237kQ2hiySIlwsKbFn0SGdI/0nm2vmqhwrEo+Ca7ZTEw6v4s6n/yL6rGwgnt+8++QHgZ1U3m0P0LtmzeHKMR09z8oFo4qQwuebtovl+OHnZLyMb8xAIyKdqPjnu85orT9bGkB/9d6RyAzWckJOKXkiv6w/VzkzT2vQU4rOtavKsaS3VC6Jz88U6KpXyYSOAxneop1GqesPpYcCjRPEHsedTZR6MX/HQppqqZczvu94IPlkhqEqRE42hxLtpvtzio7O2yXLjRYxUvNlD40J9o8LyTy5gI2fJ9M1Qm5nwspvbKkjsUBvz4Hc+g8cUpzt2nykhpOClbotCr3biz1CnDXTQALiZO1fIfQg07ULQvWjiAmuB51sFcFotWOSPfdAlj0UDMBNqUYLWyTt3uUrchDhNGOn47MYolQIdOZ3FDGDxzMszSY2zGPrH55eDG4IU1eEsI1etApNaZPM3YYO/O6BBDpwpdA+W/Vb1PNEAIfI8Z+y3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(15650500001)(38350700002)(38100700002)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+XTAmUbUOx1piGJSOl8bgiBIsRIQWmSrhLzi6ZZ1RU8LmGUS/KcijksuzGrD?=
 =?us-ascii?Q?PKQd/GmqdbdKAuEVsvmyxc+KWP1lLyWOS7DBFTS7X2W2zYG3Y3+h16TzukxK?=
 =?us-ascii?Q?qmMPqfbQXfv7FEOMGSad9UxBNAxsw5W+eLrtea6YB0NdksPqJbOYnk/F65Zd?=
 =?us-ascii?Q?MjMczTnD3rOmkBHnMJzJKbJgvZPvGlpYDir2qsCz78F9G8ZBC5amH/biLDeO?=
 =?us-ascii?Q?0jtUXvWPgW1aWToRth7G5Nx1m5h3J4ce36Pz+t706Yozue4A+4gZy0dTTFrg?=
 =?us-ascii?Q?501jdrxYJVJVfuDdtlpSZWwn4GYfTrtIjhLkax+N+I/PEi3T19h0dpMkJxea?=
 =?us-ascii?Q?UwRHAkEy1/PHaxjo/G4Ma21SzdEOc+8Q5Nl82IpX1+hJFXCAjZxiuFhyxWE/?=
 =?us-ascii?Q?6Wco3he7NcrRz7TsjSJ+DB3i5v7eO++ASMyOz/FKCMRUcsZOgpPSjpEh5cGb?=
 =?us-ascii?Q?6STC3VEkwdo85nYGmKgtHwJMEoRnC3Xic/bBM+dGvQlaYC3hrCHAWkNy8dQw?=
 =?us-ascii?Q?zr24l5h409c1XJ4AP9xRMu3JjQVAnZnWy4S9CFMOfZWOXzo99dQEivaG6Vnu?=
 =?us-ascii?Q?nQnanf8DSwjiscqbNTfJb0DFW0oV+niOMbLnYDWQ94BdDkKuWOgTej7HpBk4?=
 =?us-ascii?Q?scFN90ga/HWsClsbYzEVL7Y9tNLcHZvpq9xv0d6DMCYx3up6CEesHZ/qnGJ3?=
 =?us-ascii?Q?bAgD67JWmKMz3cHMDw9rVDRCHK62/8ihw2J2HhkDxDm9W3oddZ4gRfhBqEVu?=
 =?us-ascii?Q?IGI2vSyO7eecAC17PpbvrTwB/vmn80WadGeSZCXkIIznlPZ+48OWns4kYqjT?=
 =?us-ascii?Q?7LxyE7L9EU65YL7eyhECMFJesVIAHPOI8MUtFm4aWw1KsI9Ei+yB/pt+QhSS?=
 =?us-ascii?Q?zzmGRINaQ3CWLrMMRdDw2MM1yNl7u+m/bezUbG02cgRnnY6PF9GkTEo2+zb9?=
 =?us-ascii?Q?Yq9aGLjgp9tG2gJcjuOYTp9VEjLe/bU4RyqYZkoOTYoK8pAv22G+SW3CybfY?=
 =?us-ascii?Q?P6bNm8NG52M/70TJWEoXjrxggDjkrGMh61NmrxXUNFtDkAFX2juLmuU8Ct5V?=
 =?us-ascii?Q?9LUslf3bqoTCtRgjogPG4ySN/ii8ra+zdo1mBx2aQBYUgxZu0T146D/uVoSy?=
 =?us-ascii?Q?AE1f6566lzmdUEHZGffqW0k29y+GhB3/hDdYAGuVCwTD/yu0+z8C9dgf8T55?=
 =?us-ascii?Q?A3liiToFxdH4OdAEa/6AcEz9HudKRdUHfBQ1gP1G22XKXAyOsLRgeJwyVig+?=
 =?us-ascii?Q?6TRYz312D1rCXnn4WELb71X2GxrfXrcIAfYn27G1bHWF60pIWoVxYJVqmkk8?=
 =?us-ascii?Q?0X5ocRNZOt81AYmPtmPgiQGGmQGeh0gYlw110NdkyZ6wm1XJN+62WOq5jehc?=
 =?us-ascii?Q?Y6UOwnrOxdhIhXVVxyiaC8ip0xF7Pd5pkQBaCXgMr2m3eNFJ0xQDCPXzoBcr?=
 =?us-ascii?Q?3DrPjazOsvQ8wnJN3BpNynjVprr1v5Z2UYIY1R6K3XNS+tU2t7uG6UOJE9BK?=
 =?us-ascii?Q?7XvU5Bjvb2i9Ey0JbCpc65AUQtI3MGXjzRnx0h5u0Cse5UEf01y+NYhppxr9?=
 =?us-ascii?Q?k0WNCr6tl2hpIvaAJd+J9xLtx8S4f7Y67+o+Mc9JbZvDicwwYnLZ+Zo6C1hw?=
 =?us-ascii?Q?F9Xa4x8LoYONDQBR03+/wmw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7b0051-81f1-4a12-4691-08d9fa6370ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:45.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGSN9sIo54qQvF9cKMumGNTScMFXr1AXnizijtRYlgC2emsBTjhFku647nb8qG7RWsTtgnH+J+RNSMD7iIsQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 S401 MU cfg

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 4bc59a6cad20..dcbf554aa96a 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -908,6 +908,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
@@ -935,6 +946,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
-- 
2.25.1

