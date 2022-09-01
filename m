Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1835A8B38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIACH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIACH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:07:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45699EC4F0;
        Wed, 31 Aug 2022 19:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ/BVyOINvraHHGJ2JYACSI+ktbp1kxv90lZl6JDXRPBc6Lf4mGTzaN3C/1J2jK0gK7xO5HPJS3oTkxMtU/X9tJaAJtsXKZ3epB0GKMpFdoQvhTVIo4awuqqqXLsQ5cPvGVxJCCVmhd9LnvZk2n4Jckb8wocD1v0+6z/hzg6fAQTHI3x/p66TU0Dqq1lZ7ihndylfJxUvGUqWFbMk6EgpGl/Qcp3siFZYGsEEgSWg6vBzsVZ08jhcmDoCRZrE7ZPh6NH0AhkAheMmbsSSRplM/pWRNnn6Vjz61mGwC3/LI88tGOb3AgpeyP68YVF0BksLz7tm58j9A/dwwEHW+3T8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SWEablSH9OldUQ826cJb97/PiZwyJuRCBFuLVqyHZ0=;
 b=QQea4yhobSFG5n01ozcfKcrhEgBHv32JOSARXcRup87k6GN6tXbxYL9aA44zNuU0a9Cf3co3XrOULTN7qOSPR0xkogRyiQdccuExuivuAEh+meMpVuvztWFhvPk78sTG6yFcR/U4Ja8zWu5S5ccJbxk9uZ0ICutq0bEMEaZZAjnd5NOAHPZ0piNFwybOsQvxqvaNBHXb5rO26Nr2kgv0+/uhJ+l5SB/X5ee3zOa2wB7r7zTWT5Jq/XQbZ3gkUe+e6a/VvJpE9JvLfyFSI5CqQp3gocdzRNFcUY+MxF1q1GD2Xr+w6gqQDvIgbK5njVlKgTHtg6uUVIw4uxSc4tuMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SWEablSH9OldUQ826cJb97/PiZwyJuRCBFuLVqyHZ0=;
 b=pMsKpbaX3hkal50h0Mr+6kRg+M9Pj4czPtlOzo+FWS1POjfZSD46h0H0mTlcA8p/L4+Lo5zCGs9VvIkPAfwb8kc4P4AD5h4PzAhv7OFurPvkTUveoKPOe1/7rqAY3JV0CWYd1D/uHfNqQRMIbdvL1pHLpum/O1zfaA2r99/QXZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 02:07:52 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:07:50 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, dev@lynxeye.de, martink@posteo.de,
        peng.fan@nxp.com, Markus.Niebel@ew.tq-group.com,
        qiangqing.zhang@nxp.com, david@ixit.cz, aford173@gmail.com,
        hongxing.zhu@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] arm64: dts: imx8mq: update sdma node name format
Date:   Thu,  1 Sep 2022 10:08:50 +0800
Message-Id: <20220901020851.50262-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2743f0aa-0e7e-471c-9026-08da8bbec572
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCUJW47c6EgqK5Yf8S6qj2cnCMh+Iv65boXM1DrzfdT4IbG502RDoWtq3p7BijbsuHZyInIGplIRy0hYr8jXMXEEKG5U+6aFxNZwZB48fJ+g1CDKcX82BCGwauWv7sWXS1nlZJIERiFniNDSo0Whj/yNsVHC1A6F4I4r2ciR2PQ+AK+4V0ivWgTX2E/2Jul5wHoto8BnuxDt7aeJ1IeZ7i0n8fTsA1tHq1LA1eKMSJa77KTI3BZyeNo7PesL1b4U9HQwzlwO8zApVX+gGTjqS5QFPYEaWAHcyC4afiqtXrCtYFr/aIGNvVLlWUZ6co/D7OJ+SdVLaV11pZPNNC5mEBKp2aySPuDaGJ8RnkAqfFd9Vxu3Xs2djDLqUwnuAgttCuJGSfikI6OJyE1fSEkOUlOZSo78AXTEtMDXbxIO0rH1G3T5a2FFYpTI4b7F2O0qKn7rA0He9bzKRh3X/gCUyzFd6uJIjqha7/OkKcS/ZUpCvHIYU7jS782bLdXHgY3QRQdwf+oW37At1ExL1Fq+QjV5joN4cQyS+fG8SYH2lUY9GmTqKQqtU1VQxhccynk5ndtSBKYiIn2h0DzUWwBo4J32pm/nVYsCV/kuuZqJJBU14V/AXaG5O9Q8lm3hYczAm2DyISE9RQUtdT82poXwE1zIuIlVn0vLiFjD6ALMIU8DvjgWRMjVRWu/WmbvYIw2eQSCzXwTjnxheBgp6ETLmixtCngnzUtFEDQmneGtPU4nsf5VRpKBYcodh4TGm7kM3hdiAuvJXQwfTXkLi7c/mfyxMYfAKQ39AXKVOhdRm0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(66556008)(66946007)(66476007)(6512007)(8936002)(6506007)(52116002)(26005)(86362001)(6486002)(2906002)(41300700001)(478600001)(8676002)(186003)(38100700002)(38350700002)(2616005)(4326008)(83380400001)(7416002)(36756003)(5660300002)(44832011)(316002)(1076003)(4744005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpxrDlx6KY8h4eF1bQUdvAwIsjNKUb567cRkypBPpAZEEDh8CFfG4TE8/LVD?=
 =?us-ascii?Q?/svMwcqYvyPwCesVx/KXG1OLF1UJXE2KMnsSB8JzHsaxeaSSHguS3ccZHddi?=
 =?us-ascii?Q?IpqmmaqxMnQbi+ReDCX3eqci/AK+D2Tz/AO4/nOQL4Jh+MWmRX/y2YsSaUB/?=
 =?us-ascii?Q?DtCEBah7m6vPMrdBTwy8oXWx/uQ2p3c+59lGwUNcWJlAt3c3L8b6vBuvgU9q?=
 =?us-ascii?Q?YgGKnsDTc3No1cPki2OKf5g8Q5We9foSBWJtRj9ssNBYcur6GAxknK2HHr9V?=
 =?us-ascii?Q?hPdMGeBakilV5A5edV553napMEM22uzZL8ESZKCLEeUMNHt+JW8isRTBBWnw?=
 =?us-ascii?Q?N2NjGe/eXcbs7DUzh3TuzYPLl0+XG7fZH3Dx4GP+8S8agjKw7/7Nk8BYHl3N?=
 =?us-ascii?Q?a7phAFW1IJBeyMDem53LtpFofENo1OqSBXGTcBxik++ywgPvx1nPRg7GlpDm?=
 =?us-ascii?Q?vGCHKhv6s5aF2hiuotMtZhaVtwy65H0IZV5WgKf4nHUCxqfETlDTWG6domCj?=
 =?us-ascii?Q?y0IXhRgMyLxdxQF4cJ04VG9UGkJGUydUnZiWZTxINHhDEPRS9CRhaZqyGC7Q?=
 =?us-ascii?Q?IYJP+fN5rVDC72wyLw2WUafCoihNlhUrZqJ+CzkWTr9N+ojBk7VPvLE4KaR3?=
 =?us-ascii?Q?SH703WE0V/ivRPUVIR5BDhfTLGOfYGPZXv6jg6zUfk2SnV0RGFhY8BUSkUCB?=
 =?us-ascii?Q?o4M9nzyjRDzouMFjBcC65K6v0eI37YEiZaOWHinlhDSLHUmD+VL3e/NzpdYp?=
 =?us-ascii?Q?kfFUUlKEI0D2ozkaygusIuW4M40cV3KP006le5cZRaWukAs5Tj8Ufxxlfj0o?=
 =?us-ascii?Q?BtpYncXxRc/c0Op/UPjqy08NJiVTEqzDriKpDgvu/EOT7xuQqHjSHRYeuRxr?=
 =?us-ascii?Q?6kF1GRT3FGuBH31MmVV0Xvg4DtibzTHpK85kHuw8wComlNpNmLk7C0wYHIce?=
 =?us-ascii?Q?hpMQX8VMcqePg/tdDZ1MULkguo4XWrTtdjhlvvKpG64Wa7gzPUKLzdvZgKqL?=
 =?us-ascii?Q?JaNIDxToE8BFJSKsFXGOVB1Vh+pM+ybDNRkrxCL9d15THYuX5i/zFozm8I3l?=
 =?us-ascii?Q?oe+WMX6YsQjZtceYqODNETcxWS3yJP/WUwB+vnhz+drCaAtrx1u/vMO57j0x?=
 =?us-ascii?Q?cyYUrJ4YPJ6Z+Z1HhiDMWzqfG/2/PaAbOheWOIIZem2Hkbvz/maTgTCcuF76?=
 =?us-ascii?Q?yUd8ZMRM+FhuiSNjEDjdw3Q+z2iTSe58a5K1OKWMjhNqw8Ep7J/9UmYHWGzc?=
 =?us-ascii?Q?YD3HmNfnHoeEs+QbmjIpncqh21aQp6+vM5XeUhjly4w+T+yCPOVbuc0YWrHq?=
 =?us-ascii?Q?BvX6e2a2OtduT+s5Vx1JHBTG8EuSv9+X3MGn2ce4+a2hDKaaAlUhHO+lk+2R?=
 =?us-ascii?Q?H73GxEShawm8DbPleXGiTcgZYRvcXs1jBn/DxM2lc8K6bvRC6JzoCrGwMdQ5?=
 =?us-ascii?Q?N8bo4Hjcpo4LyWhRogtbeLru6iJHfn431a7j41alXWujEBq8MlmhZvTdAUwh?=
 =?us-ascii?Q?Xlc1fM0kfMduHGfMEur6TTgTewbnpqPd15D3jAoQX2/TPqZ3sgLU2Oon+Rza?=
 =?us-ascii?Q?bLNcbp5cSfjn269mrbWjaJkgYfPrgUL/o8TmGCds?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2743f0aa-0e7e-471c-9026-08da8bbec572
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 02:07:50.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P0cyZWBwA8YfTd/wjqy9KgVuPY8H8J+K8UwEdDInb1hbyyY+fEA6t6KmI5pHXXi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the sdma node name format 'sdma' into 'dma-controller'.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e9f0cdd10ab6..19eaa523564d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -534,7 +534,7 @@ wdog3: watchdog@302a0000 {
 				status = "disabled";
 			};
 
-			sdma2: sdma@302c0000 {
+			sdma2: dma-controller@302c0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x302c0000 0x10000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -1302,7 +1302,7 @@ qspi0: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma1: sdma@30bd0000 {
+			sdma1: dma-controller@30bd0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

