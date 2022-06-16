Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41754DBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359607AbiFPHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359588AbiFPHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:48 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8F5C76E;
        Thu, 16 Jun 2022 00:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMUq2z7LYvb7Kprh+QDTJrri9c/GUt8p+2ivP356M+8Irhv4xqVaFhRhJbWVUa+rK8EowVpd/G7W9kgTFn8wV260pUxUFEvkn+PZIt6PimVylxe6CZENt6YyNtBHJKefFng6gHbRV07dOr/A3wcXV3QfXSFQ7RMpeARX3WeVDIjrfPcohAtdT3FvmS9LYUdFvwcQWdHPb8+KSoGBMhnDRAQCyOT4JRkukQd2v9fVfhhPrD/NiZBhNNrKES7LUPUlC5xcPBPlaJCs+EZG2EwJhfrv7Pk+q4O+AvOhYOagzR+w6eaNlDm1GUoxW8pRNtzCIKAi9pr7bH9u0tz7N6HxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymUGPRpz3OOaWpL2pCtzaVqk5IlZwDt+HVG4vReJvIg=;
 b=CZxh41ue+7+o/W1KkIwzjUlYZ8w4vIO9IVjyWZdm1tOe42YRF5UJznWzNZAkh34/2Bk5PVtMbkBBkaZ1k7a9CAx8nUxsAjMKRElVdV/kOvbjNej6fAvup4dMUm9KwBwvMSQTsCajMqMQyjz6yl3VcJN4F0FNeVj+VIcDPRrget2kNOQ6SKs+lyWEM61Hemn+Tw+68XzPvFlNreOou77HtofXDMVkrMC338ysLmrbJD/7DkkxIUm87RkvDMtDJAvx5wD4q9XYpsk+6gC+F//YuF08J1tBiCSFas/76/1wFetgdK+fKdZcVif8T4Yi4opQDlaEZSZEMRdT3HjF3xmztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymUGPRpz3OOaWpL2pCtzaVqk5IlZwDt+HVG4vReJvIg=;
 b=LOGAVyoB0vQipf1SDQqY1UiTrKCCVEFr6A4nX3p8QFRIKopfjcUYqvEahNHrQ5k71Q9NUBTn/wlCsvewhEkhvu8MGyw2PGTf0J/4XXmSOubIjHtjAhIjzl3s37gB/OdbguPTiIh+jSbumWawbdDPjgJWs2zQWeQepdOv5/pHnmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 07:38:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 8/8] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Thu, 16 Jun 2022 15:39:53 +0800
Message-Id: <20220616073953.2204978-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88137fc-45cb-4448-1179-08da4f6b3d84
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB57399F9E1B704739D6D5219CC9AC9@DB8PR04MB5739.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pfVd3MGZCru6Uv38HINIx//YqgAJofPlyZwgxEIbTydEG/UXsyupF8gPp8FbFs6UDmJIFmhkTImLi0NQeEffr2UHXqKGp42VWvhBuVx0yDHkoibU6sBjofmz4K+JqT5fd2l2Qyu/x27voFLfvBJINqtfi/UKSVAM3duw1C1YDFPw5i1/S5uprhL/oMeybptX2IFZIFTKwIdeZWCqZNYVnuOX8vWivlaaqe/ve3C9fuS94/gUqA8gxUcnB6+bo4JyhO3wZPjnq4d5wibwCjwuXviGhTcw3jsNybTWzIBGyXG7dXfIytYHmmFt0g4Slcg1L69POF8/zNSskYzh4R7Dr80ZtTb1ctopgeSzqzqDIDK4sSY/fVmKYE72Y8DosWjlOgRJzsE0Y0luqf/+1b+tz15nj+2/wf+lb9A1LPsTMY5udI+qfqLBZRngnib0OUO921cE1g85g4TJLVrmjQspFjyJHJGf1IGBNcNAQoLQ+NPbjI+HaHvUtMlD1aRdgnGhZ+tmjDkfrHV5NhoQz3lJD1iTJPws7zHg3AZCTAith/77V0R4bNEFiQXfrN8qhmeLBrwj1C262k9HDeNUtRygu/j6ac0DrMYqtaxJr+TVptRCScRyjGmLJ9JWYKCYuE8CLpkQwzh/vXcznGWh41NqhdPGXpqAAZpJrzmGNFrHNnxCyljAwdGqhmTqDS2lkJtPcy7SpS4cy5/En7iSPbdZk6xSQWG1xLoFTs6vGJDG6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(38350700002)(38100700002)(66946007)(316002)(8936002)(2616005)(86362001)(6666004)(186003)(26005)(66476007)(66556008)(4744005)(4326008)(8676002)(7416002)(6506007)(52116002)(5660300002)(2906002)(508600001)(6486002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzKnGU+QILEvH7mrpi7A6DvptmEWR6ClmUi8Zx120yznGl4mUGf663rRxSRG?=
 =?us-ascii?Q?DU518Q9iR+vyzJgd4nxN8YIRqt8IM11hukP3fwz9IQJNKtUHlBL+tEnWhHCh?=
 =?us-ascii?Q?OHXJfjFv7++taZaYK0wUPolTlx8h4vZlueVdTg49ufHLRYuASvgS0WLMC7hP?=
 =?us-ascii?Q?EKYkur/9opafQCxNMA2Oo7+nZLdhifkaK1YBadck2Q0iad/OJ7BFmZs2ZCHr?=
 =?us-ascii?Q?l0EILwxU/0LtSZ94RiAeWtHP96qyyQahbsN87l3+BZf+9q2r09QJpfgiPzu7?=
 =?us-ascii?Q?IJlECOIeAPZ3H+3b2nmigvnwryrAMkKeLxzbGShXdZThoE50cjbFn5LG26XY?=
 =?us-ascii?Q?S8a1pPLRCkuGvWECgLkaZ5bpAh3h037ssqy92Mx/yB7teDvOQiVq8VcUQl7q?=
 =?us-ascii?Q?XucABZDVm/yY/M1srY5NXvaCBi8/lClJkD5fnmJenTlW4IsdlKO4xVozR2MU?=
 =?us-ascii?Q?N9u8E+MV5cVvR1U40KNey/Kj/bggcjINt/JmR7J8RUBzeWsPC0+av6tiP2An?=
 =?us-ascii?Q?o34KneOffi2OUuLPr+hjMtz7vdglfoUjsaYBmtDE5Z7EgyHPmeMbH2QrdNEe?=
 =?us-ascii?Q?snEha9A0Y4vsEXck8EuC/1bWYP3H8knBMdP5qWNHA045/K55/d9kQSXyF4MR?=
 =?us-ascii?Q?gfm4nZ4nUQFQRf41TWuK2minm7Hg/Wirs+aWlqm/C5KmiCyRnQLe+/qPlKg2?=
 =?us-ascii?Q?2liB8w8i/HnZP7icJOyS5tDoxkEfXp3ZtdLfjxfRKcONMAXNqo7QLRhpKT8w?=
 =?us-ascii?Q?GO77LjEElfJa2PcRrjugTyKBlIzbVRRLshL0JcgcLSQPfE99Fjk3gcM4DOdR?=
 =?us-ascii?Q?m2gxThg2x/aYKn/It6N8UlJRqQrOJWsbbUe8cchh8Dmn9kY62OJXSeHUTNPu?=
 =?us-ascii?Q?ype6f1pr0l9Bc7Na7Q7gZzCJ9mrAXivLlLjK20uOWi/4HrmY08jIsMSZiNHL?=
 =?us-ascii?Q?zVwKeB1ax+SK6i7VNT78Pfl44JA0uBJHQSZYDO0aJ+rrk6x3Dx0/QntmeLsX?=
 =?us-ascii?Q?dkYG3buHkk06u9/LmNY4aNjCnuuI2OR6X/TUSVP6Aq4Ads3cwgFYzo3LQDpP?=
 =?us-ascii?Q?6fwlAfRdjrxtwhqqeLejDGnfiRCXtqny0it0+jOM4NyMnbQJ/QKsfn5/uq1H?=
 =?us-ascii?Q?Mb1lsKBSl8a+k1mIItKIN93hB80TC1zZZhbhI81rQBbXYSt1Y/clAOVJWXqA?=
 =?us-ascii?Q?PK8KdsVnA9+b5HeIZJBpK9XsE/Kvtgwbw7biYzDmCMb7JHdfvZYNkee+i0Ci?=
 =?us-ascii?Q?6Efy2J4QP0tZ8UBEUD42BCRP1qol1rdb60ISzwTQJ/yz6sGw/mpFJjnpI6LP?=
 =?us-ascii?Q?WSLcE4DoTXi6zN9Bnr8HkR7l4XOfksKJNhI/fZKdA7z9gro88KbsQ3FwJC+7?=
 =?us-ascii?Q?qXaL9dsiVWZWu+mPArLCyIFEViBHsW0Er3zbI/sk8zIftxKWifj2FcIZBsda?=
 =?us-ascii?Q?dprIaRvHkOK2qYmB0UvXlGMYPYNgXX2ug4OTnBpfcHG5qoAwA7+a5lUOTyOj?=
 =?us-ascii?Q?XtF3kai2UAyU5lTavdsgKDhw61M27qF3GnhCbNBLMo8vekvfPitmPoaLfNhO?=
 =?us-ascii?Q?TT7TLYJIatmIlVnMh7d78dZrslpy3yE+It1uvTUoWyp48Spx3EwRU9gz6+Gv?=
 =?us-ascii?Q?0OnHYBdZRanKsfKQemoy3H4E4PlKITWRSL9Ud2rqQUIA3VCfqzQq7inXG7cG?=
 =?us-ascii?Q?Qmay3W/rWCoB2gPKgEcrdVx44J8N2ojSaYdXZhovVfBJDMG1Azulv5tcI7xS?=
 =?us-ascii?Q?Ooboon+xGQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88137fc-45cb-4448-1179-08da4f6b3d84
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:44.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H70hCkFpnj3XLuNdSvpR64KnG/j+Y6PLIkBDDoJKYmJLYgUqLIQLE1rSRsZKFGiBMCnf+GAOLft/Ss0Gjv+AhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9bd2e502b26..751b5fafe203 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1108,6 +1108,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
 						<&pgc_hsiomix>, <&pgc_pcie_phy>;
 				power-domain-names = "bus", "usb", "usb-phy1",
 						     "usb-phy2", "pcie", "pcie-phy";
+				interconnects = <&noc IMX8MP_ICM_NOC_PCIE &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB1 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB2 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_PCIE &noc IMX8MP_ICN_HSIO>;
+				interconnect-names = "noc-pcie", "usb1", "usb2", "pcie";
 				#power-domain-cells = <1>;
 			};
 		};
-- 
2.25.1

