Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00D54DBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359435AbiFPHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359519AbiFPHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:34 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D7A5D185;
        Thu, 16 Jun 2022 00:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0cuCTma/9ClFPXv/IwOl2ei6ng/tpLBlzOEGpL136d2elMjMCViF45ITSZP8vCj5GCaAbTc3dc27le/dTkTmZRObRArSjbSgwTgDgeGvDtAFQ1ssocklyDJKSiQykWjUgtDD9sa9xoTd58KUk+/wd1Pw6qnnCgOtNFghFxdSA4W2t7ZqKOAvTj1maUkGLSU0XIrwCBR/0vI1vcN/Z1by4Y/xEFXTPzJaHgf2JiQWJqdVWh+DLOrVmLlpzKmRyQ06socIHmusdo/xVcbcp0FmTlZ3rUFsW4aljNEaiO3zHIpNeUqKyIbPy3uAxDcvre4QpqWnYwa5XTf2ilFNHkWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gBh5hNdCaK3zsbVMpem/fXhBZmMLr6ujYSrRdFmXck=;
 b=MrxGvUqIhhJzXOaO5a0495r7jUpHCU8SfQBklpxdq/wynUAv3T2yXPzJNNMaYo79HgD7FXubIvxIlft/AokoY5VLchHHLr9KVvPCuapau4QUo2iev1zy8dYZyPPKlHEwcIE7K3fhA1Fx6dYIIexpAykh7MRpvs+YGDcaXMEDmxwEWZW9iXQI2wTqVrD4NzTEX2Xj7M8KI10X9HNIC7WcPQPNit0NpPWSr5VJcsA2qNy3k7PBLuDvo3788HjZC/kE/0151Th0z5T36+jSgztZeyPZ/rEhik0hs+UjaWCqkmOK15g3ZrdYeCPYGMmayHuNuiOi2CUZqSOtGJVmccC0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gBh5hNdCaK3zsbVMpem/fXhBZmMLr6ujYSrRdFmXck=;
 b=TSuzA3HyLgXYAYYpNoNW5QQ/eT+M73gGXssfWSghdPkWzuOfjl7pPcQtk1/c2zpkZ53hu1LizHhysnGDI+aFYsI2/yzipDcMVrx7IPPViXm8NbDZratbIOjDm3TCruk519lyBd4Lixhd86QGSAha9x9oBuUUdE1bKudlwqvrj5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:32:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/9] interconnect: imx: set of_node for interconnect provider
Date:   Thu, 16 Jun 2022 15:33:18 +0800
Message-Id: <20220616073320.2203000-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90f3c8cd-6940-47a1-d1e0-08da4f6a5b84
X-MS-TrafficTypeDiagnostic: AS8PR04MB8435:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB843511A8AEA9EECA9A515956C9AC9@AS8PR04MB8435.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oAwzbDoNsEknJVAbyamaTeF/aN336XHP2c6Jjk54b7rzuXcVepINtpnAsBjIPAq8LT+UQ9LG2uF3hEFfTs21ss6mNlwTskD/ZvgpgjYx9czm4MFLkxIFVl1pO4WFH3xgyhyY6VizrGMmo0a4HyCq9b3UBBS7JBW0ded14Y1LpN4b0kG2I0PJX4h2UjlzHZGzbrYDXacPLSg9a2Tg7h1hqz7ZUdYlnssNn3N4lhomFR87A05ecdU+M19QhhXpmnhzhBD0XKxs9s8hR1OCYxTnMXhkUbgNYfluyuhVNzR/t6mwwbZSgpKbs7SoDXcx+dTNsCS6Xir2/Nc5rF+QUzfXAf85kDtLvK8VohwYtATKGnrXCK8Sj2oFDIOTi9nbG43asKPZI9Q9ENFysCtSnqVNvhPyoPn6g3k9sI2flVO1FCOyagC15pYMqrsgGD2ndFo49JJOAviskno+5uJIAlMGKYGwFeWHmpcJynAIDQ0tfYKF7ti+q2xC4dBbWq8+3BXJ60v18diH3FDTxhSvbBNDX7baCfd5an27/WJ6+aw8kN4knRgPs7JjE74AkDRA8QmWPeJdqIRnSryJIrGhR5NLhwvU0P2thsqsQfPatXPrXnArWL/sgpj69Fgk1iJV1uAsWkkRwUIEKFugcyQ68PR1tp8/o+93GMmYLE1gxQrSnAWKjeHvdEraZQwtexDt/3Vmz0RFNWCq0f8N2Bx62Jgl9ZYAowIjhk0hFqoZAqVHJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(316002)(6666004)(6512007)(52116002)(66946007)(66476007)(4326008)(66556008)(8676002)(2616005)(86362001)(6506007)(921005)(5660300002)(7416002)(4744005)(38350700002)(38100700002)(508600001)(2906002)(6486002)(1076003)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0lM28ErNOAZ9HVNVa0bv+WHQ/WQijc4Xvb2lFk/I5pMtOyqBz/mtRrlEBFF?=
 =?us-ascii?Q?LEemzSeqw8+OCFsm6RmEVwOx7HLpOIxlFcuc7p/izeM970wacDbJtoudEH2b?=
 =?us-ascii?Q?+cRvuvusbmtCT5uw6mbNXIOGMK0PMH9pa3mXGycb4Iy1hYXiHXlR1l6B8KJZ?=
 =?us-ascii?Q?DJc6vbbyZP8G5VMjDo/BGytOQXIa4bbG5y5VMEqP0llvkTHlh4p7++QhKjUe?=
 =?us-ascii?Q?hvBDNYuDQKaJGdf1/ciCyN+1VQUsLj82PfkME/u5/GZNxkHOQ2LJY3/9D3fA?=
 =?us-ascii?Q?Bad+sIl0rEv5G9ox0Rc38ShX6+O27p7bUJxmWJaodyBUfI8Fg0OJ9rLpL/C2?=
 =?us-ascii?Q?vCyLAguZkbolnKib7b5XXbgles/VSMARBUYhLgLZDPq0LOJuQKg4YcRA2zM/?=
 =?us-ascii?Q?j7Apm5SeWhDERYxRASlqNAkld5iHfglEpJYqpjQihDWsVsCr2Moxp5IYcILK?=
 =?us-ascii?Q?NPSkq+uH5ghPQXBpKI8PbTcC3EEBz+6B0O/uoVFQo/kmSdVSn5vqpU4oteaj?=
 =?us-ascii?Q?0Ryb0/DYiuvPR4uROUZXZZn2mJtw7NiupPvMvMmRRBIKBhAkOkKWoA5JHRRY?=
 =?us-ascii?Q?g5itK22EbxQsWtIpkBmMSRg8/tP7Q0e3rf+51Wr9YkBcz9NXqyh0vk/HZvnc?=
 =?us-ascii?Q?iitPvdYjE2eDRCOAp3UEaKVLmw9BPCYQz4WEzemGvOMlLiWrv55HRBRkq2VV?=
 =?us-ascii?Q?HjyLEzn9OAoQ58IaaAR7l99qGZH1Scg3FTB9Ei8ono3cxiac6cU1WLe0MLj7?=
 =?us-ascii?Q?GPJjKmkkYzrfnKrvGOkoAZ8AzCQJpSFB9ubhKYog92OGFmUmTpqFIWtRtg/t?=
 =?us-ascii?Q?K76TPfmKgqnE2pdTC8KUgoeTvuRe25vcqKZnX6OOMYviglERjWAK/fnStS8q?=
 =?us-ascii?Q?0AIaEY5u4Sg+thmoFtLmbE7hW7g3KlKrVkYA2/I0gVD3jTLDE0pMXhYvV/qb?=
 =?us-ascii?Q?BelnApJrPwj7PDLl62EbAbTDRBCQMWMezg1B45ogx1a81tEkheSHt/dHz9Ml?=
 =?us-ascii?Q?HxOGxGyT97Fvz1VPCDDCjFJpJp5OA1N4YoB8Cq2NB1lO0j3Sx0jeDTUi9bN9?=
 =?us-ascii?Q?1mpqP0uSM1l/QdCIc3NwQk3F/JDc1GCaNdB0XXfDm9mWcjI3217T+w8w6xDq?=
 =?us-ascii?Q?ef/S48Y0iIIE9ORy58RAtXC6zNCVb/oUPAe0Ho+pfGu2udTrKAjjMEXJrGQ4?=
 =?us-ascii?Q?JkoIE6w+HqSxArXtgtz4+UU3whsTYn5ry9urEvOHuiRcbHjDyIpLsrdQ8r+h?=
 =?us-ascii?Q?1WX2OshO/40hioOn9SrD/++5nGGZmtOAw9CTtiELRRhG+rqcZFa6nd2UlTuY?=
 =?us-ascii?Q?WhfR+VCn390rEWfGxeXssxrEX//BaDOfUCGPHP0CLPhewuxWxaP5MsCJ+TEp?=
 =?us-ascii?Q?f/BDuSeeshGMWj1R7ZfiG6YHACmndky6EerIKewnYhafBVc1JXx7gnY4crpw?=
 =?us-ascii?Q?kxTjl1mk3HNpLrSg6A0SIJTIRmeL68DzBjWuTyzC9WvPJ6MZJIrWcmQPP7HH?=
 =?us-ascii?Q?Ea1WKOZQjV2zlC9x8nRYFYJdNTr7HkaDDbOhrYu1w/lAHXqiBNGPhvNSJ8YY?=
 =?us-ascii?Q?4E4KaxN4zqiCX834uQY5pw7M8xh6eLwzGgTOBPO329cP4Mz+S0QG1oQnNcMZ?=
 =?us-ascii?Q?anxwJ8IqXAbxMQDAqUmQzhGP/zCzbLZ1Mo3Vf4aSzVWRQUBMQsHMdYoSkTTf?=
 =?us-ascii?Q?pzd7ypiR41OuKrsqFreqyyPI0ffQCwovsKyjMp+q/9551fFtJ/U7pAcglPMA?=
 =?us-ascii?Q?TOmL5W5AdA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f3c8cd-6940-47a1-d1e0-08da4f6a5b84
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:25.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clarECdKULdmlRfmdYn5uctdiUfWqumk72paDwfCHIk1LIAdKy+DLi9R0fLsvf8WE1kLBLkzJD0FkCoAPzYQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The provider device is created using platform_device_register_data in
imx-bus driver, which not has of_node. With of_node set, it will be
easy to support QoS settings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 1f16eedea21c..78557fe6da2c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -264,6 +264,7 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev->parent;
+	provider->dev->of_node = dev->parent->of_node;
 	platform_set_drvdata(pdev, imx_provider);
 
 	ret = icc_provider_add(provider);
-- 
2.25.1

