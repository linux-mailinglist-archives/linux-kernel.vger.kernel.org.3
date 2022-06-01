Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3F53A0D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351188AbiFAJlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiFAJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0CD57B05;
        Wed,  1 Jun 2022 02:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4tDCTysRtwHf5b3b/iyehUN9D9GB8k6kUKU90dGMnJmS315YlsXM9gNzLpsXxkimUHBFIR3PAwrwwo2umtlHnFjzh3Qk/B21wkjeTiV8PIMuvsXK4dZNBlU/61h7wc0Q9fNjmOPYT3rA7ayO22pTE4Yt+eMGox/FWqKdX4fM5IR+55BPfhebM0Z8GwR9TuqX0ta0MWmkQvin5+SwZG6BDmGNP3NEt5MRCixkyBVb3Q0JLVBGz6oPES/l3VI8RzpSg9pO7AOv3BT7fEZOHuXNEOaMWvo8H+1nhU9g2KifB3PN2gBl6KK5pEZVUvch3ifDwo06WCqfBJ7eG99fXq5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEJQ3hiVlRkt2TrPMM7HRS3Smn5aBzLoiF12ew86Dp8=;
 b=YLsMdJSkkvFwUXf+b5VSk+1QnWW4YwpeM5aWhKNrLKxn2gr6wLjCG+Gh75YjxPVui/J4zXlijMGQYMkhF0p8PZLK7ULY8HdMUyUanIbW2yLD6ukF4rlzD7VcPNsY1JSRg6ppyF8g+Z/PrESE5M7+rcqV8OJVTOntN+aKRhL+T2yAPOX9zxKiA0v+o/M3jCTk2N53fPKv43WLLg3IYgAiWl0vl/pkbC1nlV5ly2TIDtfU/O65TWiJQ9dLgbmZSaL8cZbmpoLKIooNn318/uNw6mRYclJarujN1mvxYOxuG9YBREXAx8Xj7fXDXObw1f9UIdEr9RPp3rdZ1hCNApQLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJQ3hiVlRkt2TrPMM7HRS3Smn5aBzLoiF12ew86Dp8=;
 b=OoZuj4Fb4/KhlCKhCHEsJFbsuC2CQeyhhg/noQtwKrZkjx0C8HFS63GPkEXVuwTnDGucEWEvgeY7Eq1TYgM6eHpfchJ6Vrv2R/uYdQNa4oe7a5ARU72ehORW5Sc/wXRuO36sKyb1v5mFrfEnks4qg4Avdp2/JM/qSvc0A5O7jQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:38 +0000
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
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/8] interconnect: imx: set src node
Date:   Wed,  1 Jun 2022 17:41:52 +0800
Message-Id: <20220601094156.3388454-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29946437-943b-4d33-b4aa-08da43b2c8f3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB64987153EAF34CB1AA9BE3D4C9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOguCAD8hk4+rYCapKO31/fv64mDPDs2oFA43x7x3untpNUlZ2As7DaBsAAuO+bHBujeKR0++BgbdNIetRXTnV6nRvPVwdVi2swRALm0ygrFC+aavmnuov8e84vF189Tu2OZRiCh4ZV+jNJhcwtosBcHzAV9zs16ACU1TD7vVAZ+V86k43oRRWQpkhRfGPH8gEMeDPG0/1me4A1WJ2MIJEI5nbhUpBP/WNrnLpR+qbZFmhExtu3FbrPxlYjoBwBYlz8TACiUc9cfd+Q15s2IivWkEl8fs+95SrQbsn9pPex6NFnXfINc0t0asArT/bmUwjsHvrBUZ9grVlgREsBJUSJWKsOEga1ZjnE+xZtnlQoHyktFyCnlwsdLEJuuRMbrs8dhoJpFrIfSu1W5MFPLrJW1MPhiuPwEsxg6tFoq5oPHEXGDccX6CVqFMMxTFwiuunN/CRsTa1ae77/b/CZ6MB0HvumVXZA3B9AUYOy+EwXY12kMSL+03dD1dheSUjnFgQ4JtwuOmCmTwBI4IJBPKZg+nXAAB1t6oMO4E9Qtsyd69yqFLlcALSFpz/wMcu9sY7QlfWhvbYA5C/khO1Ccf09/FsrDc8316Rfqc0vzX1MTKPI7bXE1fyxsZdsX15P/pqfzWT/Vo9nYnd2AsGMVLT5vnbFEQ5mGitRooxkjA13cNfq1vVrWEqCAhgqVDYztyxy4whlF1vKeteZfITuPafsLqqghsfTOd5lc2BDkexA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(1076003)(7416002)(86362001)(26005)(186003)(38100700002)(38350700002)(6512007)(8676002)(8936002)(4326008)(66556008)(5660300002)(66946007)(66476007)(921005)(52116002)(6666004)(316002)(6486002)(2906002)(4744005)(508600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v40XVjZwlcIeaLUjXGO7R7gfQYX0IBJJiYCtwCKKI1b8nuYyOzUfBhcFqyez?=
 =?us-ascii?Q?h0Gk/YlRQc1Dmq5naiUJejWtxfHHBq9VfvqyCunyfYutpesfHoRj9cMfqcfh?=
 =?us-ascii?Q?A7Q0J4lVdZctCdMAxuUU07i5AgNOFUMtwO2aLLuoGZGwzg8OeA/aTdT+Xe3k?=
 =?us-ascii?Q?1I/2oppkvvVIkU8DdyiOgXxb4SPP+RHqFekdcY0daVJFiVclEEx0RBfqgd6/?=
 =?us-ascii?Q?yR4SoYNfj2eXZa0gz6SCU7SyovdK5rCozMnNNHKdHXTG9PM6h7GVNd/UNtVP?=
 =?us-ascii?Q?3g9sDfkwVolmrn5Gj1ZU7Jh8zia5l3FioW6Px1wQAmxuYHgW1wuLhuKmarEi?=
 =?us-ascii?Q?pEIytoma7W7ogCirznV3+/SXzdxxqstjCpEKFGjYWfK34ho5gNdWGaNJcN7s?=
 =?us-ascii?Q?mIUzgRVTUd/NiKcfRgIPpB9rh+H+6GpXZwtk3GHEqs4W7RfV4/GXg5/FAOBg?=
 =?us-ascii?Q?KVoRmgiLuPw5fIVrhw2lDbIYOFN3ovibKqJWTEGj9BPGMHS7ckbjv8RZHGTa?=
 =?us-ascii?Q?c3W6EDyWvRZNbv9rDOPSu6lm75EQUUukyg/M6eOM0cDWlSyyZsXV7CRdXpIs?=
 =?us-ascii?Q?pmwL9zpS7UJPMvvPL8xaw/Nxdmm+68GouQC6n2H3U6JQCPl54jRqkUzRHRGi?=
 =?us-ascii?Q?0fpDs7bBensJP4Qs4OvgO2mb3VGPEZDzbUcoFMAYAVDUbFq9V9JSJPAC3eVn?=
 =?us-ascii?Q?l6lhphX8Qzz98ATguxQ4ujYCqdOp12k7bVfoRsEmPYYUm/CoOe8BcqN312Pk?=
 =?us-ascii?Q?Am9b7/LmENepN2WRKUMed54vV2NNDQLNGIq6ttE0kchhCUJw9M4u+63o4jne?=
 =?us-ascii?Q?aOZn/uZF9ackCsdO+PBQ+8/Sq/PyaUYt+Kvs3VFEfDznAnvx2FKzZ4vD7IId?=
 =?us-ascii?Q?MWZHPZA0CE2/p5x+B671f09SbcgHHVjZckTuxjFk2bwWkoQoQ+gDleDrVBI2?=
 =?us-ascii?Q?A3Nu5aDIJDRgi3e0vmrMAevnE2ft2YjiXxUDu1bR/3EWBWAPXySrDex/WwtN?=
 =?us-ascii?Q?xEoTmObltDWwKl346hPQQ33uIOK2AIPyh0Qk/ckg61Hfr1rNC39UzxvvqZYL?=
 =?us-ascii?Q?fG8RtFWyH+fyeqAUcHIK7tOku7VMRzJCDv7ZFUevcbGwjlO5NftdbZfxkTra?=
 =?us-ascii?Q?d+6rPS8SIgPKtiZPEk66hqz5C0sGEJd4YAPfqWd7TX0bWR4TIgt068TOFRyS?=
 =?us-ascii?Q?bZ2xvNOKJdf25rRMeE6fqfOeNLHvkjI4dDSwxF4MtLakzKIgaFp1KArxissV?=
 =?us-ascii?Q?sEHF93wJHWXEZujbaYNae0Acd5E0683lA7rZth/j1wBHw5cppwQ6wC7chp1h?=
 =?us-ascii?Q?VDPrhXHk0jTq0c0fZBewgLVYnSBqBDo6j7UBvTifjMdMSEsrI/ep/CaEBPEP?=
 =?us-ascii?Q?9vztiD+EXn87VyzlEBCstWH4bkwF8rUT6A9R96LfjLxnFFpHEsnofhE7DIUN?=
 =?us-ascii?Q?prKOxfwlK9Dki+XBGnPgtoXI52OI0hnOQy8L11SnwsifPexUTzdLL5d5qWjs?=
 =?us-ascii?Q?lEJWb18UkDiddlbQfNkxXujFAdO4WcU5mZQDvNpb1PJwK47dnvQI6YpG2ovj?=
 =?us-ascii?Q?RJ4jRaYnD7QePhf6Bwe28l44yLT7C9Gf4p9wxKxMp+u12Tpop11/Iw6EmZwA?=
 =?us-ascii?Q?sYit7pxiizS26FaAaAX0uPDO3OgePKqkrsVIoJgU6+c2PtIDVeq4C9q2PN8b?=
 =?us-ascii?Q?np2cCPK7v384glb8NUAJWW9dm7DqWFNKmU0iR7zRrmOm+UwYBBdLRpvBMByB?=
 =?us-ascii?Q?Gs/fWt83BQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29946437-943b-4d33-b4aa-08da43b2c8f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:38.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTj8HkUCORVwJIfbL6GX3IxIMFqyOo9JQUy9EJsTnlgkWRXrX12ZNXh9Iug0auRvrU/gbLZz3K2ho7XndkZmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When set QoS for a icc path, only set dst icc node is not enough,
also need to set src icc node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 3c074933ed0c..1ba906822b7e 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -61,6 +61,12 @@ static int imx_icc_node_set(struct icc_node *node)
 
 static int imx_icc_set(struct icc_node *src, struct icc_node *dst)
 {
+	int ret;
+
+	ret = imx_icc_node_set(src);
+	if (ret)
+		return ret;
+
 	return imx_icc_node_set(dst);
 }
 
-- 
2.25.1

