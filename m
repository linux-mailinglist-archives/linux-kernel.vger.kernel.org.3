Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737CE5A7AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiHaJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHaJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:05 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E95D1270;
        Wed, 31 Aug 2022 02:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQprwhT4EO1pDTOEynwwbFOLHBZJh0QjmSIXeBOdj7UpnBQ/FO4hlcSw3H54GF2oaz3dYWFivgnK0yMmZyuSh1ehZs1rsXmEQvZ4C7K6GRpZNDPNvKv4ifRng80OSEPQYDwliOFlgCsnpNCR2uorFTx9ztaUvrW6tD3yGHEjCiR/7wlvUmNJJF85Pod4PW2/ZtrRN410ZKUsbY2f9uvG3cOtPkCpLvSesSNZdu1SGI9II9iuQmoV1JHi4qpVu0v/MQnJe7SCy+bSP9gZdPdzTz2HWveEMM5uQ/YoqQCJ/wcc8o0pLszB9XsH3lohhsPI4yF2Z0vOWHoZwciGUJ9q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ht+jdLcaiThRpwQqbPY9CibXoZCxxog9z0D85gTEs=;
 b=hC1hd3SZ6sgzRQCwlI/mttAnjKb0P2V1Wf1voEMWv39bZinsgqbigEeUxRHbLH1Iqr0kEjxvUcewJLqvePqyK811ddKu9EcLjNEHIvKKZ/2S9dghZ7iJ8pKHXsTpgOdrgkYjtXiOBqTMYIGd/F5KijJ+Y2mH9te1WUJXLY3aeQAJdp0ktIH83fcJSB8BsE5NClk++0S/CFZH60rliqQk6EXp8iu0J9aE+Lv9OBENGVofal5oDo/JW7eGC2clAQeC7a6OYO/YtSjGauBdo6g+TmZ3t0Lg1EaGYHwDGunrQuWgFi995yusWyqvPoTOZDUnwCP1+IZOqRF9Pr4jg9gVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ht+jdLcaiThRpwQqbPY9CibXoZCxxog9z0D85gTEs=;
 b=WfN8mXvNgSfYT9qjwRNNrEpu5K/PlzvBX0hmY9Y+MjXJmmxlU3T0pSK5UvXbbLdavEFT70tiFTMoQV2PQlQkcnWTaxVLMiwckGqwJen9aO/tA5KaRnqCVCqP3BPZAV5Tlxv8lZXhyJxmgiaxBiWsm+12TTd1iYUs6SD4d3DGPpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:58:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:58:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/6] arm64: dts: imx8ulp: add #reset-cells for pcc
Date:   Wed, 31 Aug 2022 18:00:13 +0800
Message-Id: <20220831100016.3649852-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25ccffc7-bc95-4b0d-c4a2-08da8b376caa
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9I7tHoqWiYuQCNFPEpbVOme+5ogWDJLPMfpWRcz4tXe/qgM/AMYaqo4t1VhK86DxOPRtShKnCb18Rm0ancKg3vea890GsDZTxmQW05Yp4x2TPE+mbu89YZ+ya7k747RVT68RsQslz1aRBwuG2WgtCVTnv8vrmMYySqJg3uT/OVrJBWTUlriTr6Vfbel/FZ6PaTde48tRqBT4PqEISPA12gqpPhs5WRg8qVKz8y+6CmrSavfmv/Wffgnf0alGUjAtEFO5KlK4faSgOQjehX0Q3XQQit3m5rdvh0m714Q456LA8N9ECO9oBXOo+zMaHjovlobPQA3v5uS++t0/rP+wSWPBNqWqD8UnKhmx35wN6dob2137MDkXFEmzTro88xshZhtO83CG4RgNYEvkI/Os0LNI3cAyTtLkYmP0qAxd+0FR7zxhvKrRAwdGF+IzHn26KLG8v+wCDWNE1YJVy5uoY8HqhjPdO+Ny1EkQAMI37gD6jzPOiVMJX7xz28WlYbM2habZj02Okx+6LI/HB+rpfqHzi/POnU7CwQacxA7EpzTQyNkWD/HaPkZ0PpcOV8paroOGP2AC0jwfeHuDCo5wjzTVeK/wPdXHrUhT4Ypa9iQ5X+D6o40dWqhUHNSEHz0RVSEyzPqhGLA/F7if7W3s0LV2qIjF++0C9/HYr0O6d+cO5e2a4Duu4+To91AvWFPYr+KLMHpqN2bagh/g1vMlSYLuSdl5csk6MKAx3sDCZ2N4Lx8Hso9sDsyLiG2aBcOg1XRAPWJkBit98GF3EQRt6sPD9gWaWiH7V6saQIFIguQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(66946007)(8676002)(2616005)(1076003)(316002)(6486002)(41300700001)(6666004)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZq3F3ueo1EYrOIE+p4uHhYcHHI3Z/qntJAGjtxWJwTtXU7ree3OcqRduCZL?=
 =?us-ascii?Q?rSlO7ffcFmJsgygLoIyR0CxS3eLZ3OkcrcyirnTQNUo/+OtiZGv/gVC+cQ8+?=
 =?us-ascii?Q?++nNfh0lmA6e4vP2pLGgWbvcFPD0FL5ZHaT0k5UHu+lrtuK03csOZQfvPLdv?=
 =?us-ascii?Q?ohz7f2pi8+N6nyRsJDZGoEd1M3tzaErVcbP/d0og9sYTB1SGJUseOtNFK0eG?=
 =?us-ascii?Q?lPC6FR84aIdpuqizkLMnXcvOBZvlJxNYhegazO5G0DhY0OWmZv+PNjavLJCq?=
 =?us-ascii?Q?VZE7GzDTfiw7/9p3n7f62sSwgLhLXMVA4r1b/WOb1xIGOawHezP6SY2UPgD2?=
 =?us-ascii?Q?Swab1FPIbYSaQ/LyrJIocLWNsURRbjdJwtDv6seztC0BI/8ohpSKpMr8vzxI?=
 =?us-ascii?Q?xL+ubhnuQGTGTAuRIMXqmYh0kU2yY17UhK8HMSkxyYSjMFmebao6K9a5uHU5?=
 =?us-ascii?Q?sBfFdzihbIyDSUxGa3upEb+PdzdcmOvxVWh0WdaVlq+8VGYbwEFoTuZ/Tdb7?=
 =?us-ascii?Q?8sevbcqrEGZQrq5w+VKRMz3UmLWZSiljoSYinWlGx49knVKGbk2pEt5M6WGl?=
 =?us-ascii?Q?DKn9qsYEThLMcBHnOos2hf0EP6bbuEztAcvUh3ResF95kdE1B6jwQzoMC1Yk?=
 =?us-ascii?Q?yoB1FFLQ+Td8V/hzKPw3sZt9dudTaLwgNu3MtyDuOsXq1YGMn2WZwZxzMiLr?=
 =?us-ascii?Q?r0r4v3Q6bbalzSujfiFwe7dW9pCNJ+/HNxU2b8Xo+8+WoybqrYAJrQahdjD6?=
 =?us-ascii?Q?qNvOFa27jnZd0VOaUSz9S0badRGqCbD4yC6Mkdn0jXVh7svmQRxw+PoaNOSA?=
 =?us-ascii?Q?n16OpRDrzwn5z/XIHmKLhH1DbEOQXWuRql5ipOFpkNoYWIuHb5Co+Nro8Nii?=
 =?us-ascii?Q?fKxIJit/KWqnZ7e8Rpbpt+hJCb1I7lUfphyNd5XWnOm4qhyp9VsiSTJMObup?=
 =?us-ascii?Q?XW041sjPPx3YRkS0y2quwo+dSlJtncGlZ4kf6kApO/UjSGYUzp+FzigAhqte?=
 =?us-ascii?Q?xA4jbBqnqHZlOjKXMDwv35FNXScicm5deQV26Tkw4OEVBubP5nL9rMm5RFws?=
 =?us-ascii?Q?j9nhIzdLbNWbz34nXWgfANY2OH1tdWgsO/p041UyaO6FjY42A6Im7HJ4AUX9?=
 =?us-ascii?Q?JfZ36q8DWFFmNuEop1fqmVsSw7GNNrzsgk6TkwNMLulTwbESf2CP0MNWixRk?=
 =?us-ascii?Q?yscQweE93iwNiBVxOS9OZzI6KoGdeG+Jnky8BCPUH30LwOd5EdvQjX+WJdF9?=
 =?us-ascii?Q?M8pP8GwPRDsbXFF2LT6x5tl9ve97HkrGIk7Ji2P0XOGuaOFoNeA1ZYkQlY0M?=
 =?us-ascii?Q?QeBJu+6gEdYYH8uA+hf9rf568+UU10Fg3yNqNMiVpv4IcWH6OvUA/CFIZWwi?=
 =?us-ascii?Q?pYBziqU1CRI+oSsaXBR71w5kZQKjphxQd99n5ocYOwjLMvIQiHAK/CcWfd8Q?=
 =?us-ascii?Q?ZbLfIbn0RNZd2cu1mizbgGU8MF1GuvwcP/78dF2CqtHqr+wAFYFdYXZM4zWJ?=
 =?us-ascii?Q?RRO7OjnLt0hT0MPZA9sB8nIKwEXJLJOK8n6ogEUuWXfqz463OHCswsoLvY3n?=
 =?us-ascii?Q?t5pfw3sKfoMzc4mZYaj2tFzdTyaevbvg/8OGiPGL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ccffc7-bc95-4b0d-c4a2-08da8b376caa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:58:59.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UJSou+Vh9/zNfSyKO2cwBH40SHrV+zsIWsHar4S6W0zqnER++GSNVMVjidWYLGRmfGxVHTisUeblI9DDIJ5RQ==
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

The binding file clock/imx8ulp-pcc-clock.yaml indicates '#reset-cells'
is a required property, add it.

Fixes: fe6291e96313 ("arm64: dts: imx8ulp: Add the basic dtsi file for imx8ulp")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 7a88d7016b49..88bb30384024 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -171,6 +171,7 @@ pcc3: clock-controller@292d0000 {
 				compatible = "fsl,imx8ulp-pcc3";
 				reg = <0x292d0000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 
 			tpm5: tpm@29340000 {
@@ -269,6 +270,7 @@ pcc4: clock-controller@29800000 {
 				compatible = "fsl,imx8ulp-pcc4";
 				reg = <0x29800000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 
 			lpi2c6: i2c@29840000 {
@@ -421,6 +423,7 @@ pcc5: clock-controller@2da70000 {
 				compatible = "fsl,imx8ulp-pcc5";
 				reg = <0x2da70000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 			};
 		};
 
-- 
2.37.1

