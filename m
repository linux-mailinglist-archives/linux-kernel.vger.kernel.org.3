Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344E45A8015
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiHaOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiHaOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10805CB5E3;
        Wed, 31 Aug 2022 07:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U78ScE7PS0SUgwML+BMqCHSthHSmlwWOHuYFHrJDSrpKhiqNJqbJ9LfHMdt5VXYuif9VkmsC2ZZpu997+aMohDeD04vq8Lw05WOYf1BjSJTvT+Kv4VfNunUl5xSDThb8fbpI5nWKYjhZmpqN9F804FEp0uwGnTWwxz86DVKd5h4rUUBUbNcx7jJhuARcDYFJa5BT7BgcGGfGCkcD7IU+hsntHh+SlCZkFlg/ZjgXGeR17g0guaiQcFDH+Oze4XzGwYMnC2ziCAdcpmLAUpkLi8sHaSXX/cxjJglWSvHsEy+UCRmTor4ZEYqI19WQLsUZ7hPT70HsMHdEHWYyjoUBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zGt+66yfzfLcSDaLoDxdZloPslIZIuwAc6zNa7eWNY=;
 b=bYFuTBbz/Cyw66gaJe0l7w7EHM2RvAIuWZmO/kYHM5Ni74m/Rtm6w75EBiRwGVkOdHo5fccv4l6+s5LQRAPfxo+iSHFepTlCNKzFrC/Sg4wqiacT3Md9EBNsnIBvysAvwv5hDtMFAtwVz1IHE+9j8HCmRR1662bmiZIbOAQoHg8AJDhE4IUpSMIGQbIYedatHPk4vsyK/hEc4k7HsX19pkgGSdmV96/j13J1Ll8UwD35hH9+CbwPRxdxzwnDsA8lgv5p25MeA+OpoGN7PHSp1W7Pyq6N4gx96K1CtAQwz9oMkTH8WTb4MsWsQx7umcmHAAOrEEc6j0BaQfbdgQor7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zGt+66yfzfLcSDaLoDxdZloPslIZIuwAc6zNa7eWNY=;
 b=BVYN7j+V/eD0JGYZe48H+98h7h0mEdV7HcF/ynSl9WB8Izt05zynKIvat6GI0YBTVslNVNO+ZQyW6fhRb/gJfklmSJV0X+6Cq2Rfs0c8glhw8x5/x8X6hYStK5exmEqkK0WhVzj1PXbUShDdyo9Ge/T5dHiAGNWCdja8fSi9O50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:24:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] arm64: dts: imx8ulp: correct the scmi sram node name
Date:   Wed, 31 Aug 2022 22:25:48 +0800
Message-Id: <20220831142552.43393-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e00fb0a-e316-43a9-c196-08da8b5c8109
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PH8P0nP1u3RmH0m3Ua3QP7DmDAbPYSD+iKQmxRhC0Tfzt70Ak3VAO1UFfuvKZLgjrC9N6EkyWSJn1qfr5lWMhB15huvNszeMW80KMcnROxOP/2gTpsQK82ABEzxBHtsjx3NUuG1lWuLFW7JbjBbzqvx8recldORnzxItiW7OSNB38VHflSsUdLtDmqkY2zpAf30JB3XF/D8sSYxgS0y4kQmZHyms/nIWffmXtiVcZ/1YKBc6Wt+0cJwmyPSISGp3VpnLlvbCrl5Y+f9IzklleSIBHyqYVdpDC1rDkT9Kak+kBHlBkakqyqoTF+0i2as3nTSTYWP2EJXNmuPwRAl7uIxoo/oWomgnm58kdoqhAaNbAiNb5ygQxBhFvf4olOUcRkjIUVNh3ZtMKcqrwpKSk4F/MrjNFbJ8ydn/hR0/xcAnnoEIKe3ZALWGgmmeJWV5pL3okFTZS0l4rLpJhwpW8IgrP5sqQkRLXL5aDMHp4kthOUQAygD44tuda8JhraI6zrRxQEUfknE2vaNLpJOMdyQaFhheawNGs8RKI1dwsg6mrcu5Jx+tkAbYT9+l3Edt22/w0Ex9Dro27bmNzqiZla0zGXbC1LB71ffnSAoMFlB2DnEg2XZz5z0yFTh8SnPRP4crkbMCoOYIDF5PT+C8h5B6xx+yrpo9b3beaEe9RbKpXbPWZvfD96wv0LxncTCYK3kGm2h7ylOz3dJzCHLAQhhUZ1uPaYXcrq6gVV4NcsQUxxRCaOmI8p1c99mTOJC2mag8suDBgvDugp5DqWlVppYuO1UrWyLjIumlGcOXfIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(5660300002)(2906002)(66946007)(66556008)(4744005)(66476007)(38100700002)(38350700002)(8936002)(316002)(8676002)(4326008)(83380400001)(26005)(52116002)(1076003)(6512007)(2616005)(6666004)(6486002)(186003)(478600001)(41300700001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HjcjKortpLqbfiDrRouG5pBIh2rkdsBYC4wNdjjuxBB+LFcvGANnxef6QRX?=
 =?us-ascii?Q?t9gPLAsmO8Xr76XO+50fX2WIzMQdo/FUJAGIK/Y49H/FT6PJLhyRav5tnFH4?=
 =?us-ascii?Q?3pTiPeHE4qd9+nzxFsOCKPmmwhTk2C1FBn8fgs2nbqQpctJm5fgbuoqPfeAt?=
 =?us-ascii?Q?ewoym+oZi+D/uY21AnZUzIhGkfQetyJvyKQjuuB5YL59fs4bIpr+YWWHBPDT?=
 =?us-ascii?Q?xia4Dbidji49RUNbuaXhOVkrQ2oPlsPOfN6nX/kDmT/kOO8Tf2e5VWCrlRDW?=
 =?us-ascii?Q?WKuQH66NMaVPrdZDSQSXxveJAauueMNDLzIJIGMtovQQBgnlQXA58JYGEjhB?=
 =?us-ascii?Q?7jedK+YVoAJueJlE7xYziTDHe9iTWbeLDXE8+IvR9JQt+1Qe31uNSoa4cCOL?=
 =?us-ascii?Q?/QDE/NwC3WCBbAf4eEA1cAgDi+y1TSmDR2YkHfgL069Gi5hjngf/WVVox8vu?=
 =?us-ascii?Q?uSyiLu7p4rFEVVfIKZHQWfpN5tM5QSv2eJpsKx82z6D51H8MGybUocr1G+3e?=
 =?us-ascii?Q?EQqaNGSftAHP3Z0Cc3hUWi4xODn/XRjyE603gPihyT1PC3fvrnyLofGicqkV?=
 =?us-ascii?Q?qCdYOQAxKvSwm6zqM4VCiyTCANQTn3kohW3Dpoekxa2UwsHZSJ9IBMs8rS9c?=
 =?us-ascii?Q?6EdqUUbnaGzzOMxWKW9pSbZwIPJ4Bq2KqTsG2L49Pj4imvQ1vqG7/yqZ1b0s?=
 =?us-ascii?Q?Ss8FZ+bM9MtMspuev+Xh2XEDyL3moIg4D1Gi0B8Ic7ZEren+sftQSYT9+9Yi?=
 =?us-ascii?Q?hDSOxsmBv1/UktEkKhd6tdZ+v6pcgV81loI8F9xEI44Fv+7/P90B5Ku13wHP?=
 =?us-ascii?Q?W2IGSvA+rj2Sbx/MuVR+sWYeW9cWYXsTGHBlb9nKtYrdqcDLx8eAuyzTbK7U?=
 =?us-ascii?Q?n6hP88RqJAZfuEfwhm+06iAMnldmAukXJsSqxaFGwd92jdKjPPcWNpIlEoC2?=
 =?us-ascii?Q?yIlCp18AWeNj2XdqTKXzAkYK7iz3oHUg28ULfle5Uah53irciHGzG9lz7LW6?=
 =?us-ascii?Q?Kk5QI4jr5pc1gt3rYt9yZ5z6On8KB/A6V4SQZPczL3KDmpenET+ixdWu2bF0?=
 =?us-ascii?Q?ejn/TlEJUZv3uxeP/p+Dgd0g9rOn4/9X93hfTqC1vtQglLw4wQLmLwmB7I63?=
 =?us-ascii?Q?afAV1cIeLCBqAKi3pi2ASV0FRjinWlY0QS9qxqOwtqvZOJTeXYTFQxAlqLMB?=
 =?us-ascii?Q?pnPiPJGrukQDHYjmEMKkhoyHAMAYUDrY/W2cs0Gm2KDRqIUZBmWKLQ1gkE0i?=
 =?us-ascii?Q?91zo76youxSn3cAEIcAGoBqtZ4uaTgadyasO3dZBLjt5JSf+tgilg8forcqR?=
 =?us-ascii?Q?XXkwm9VnEqUG/ZN5qWQefHVLSrsuRnlv+Ol1c2Io+A3/ibrCbEEGYLqhMtGN?=
 =?us-ascii?Q?u43d7lOaNzZofFnxbK5CN+5llED0uJdOwolmbs7APvzQKKMGiQ04s9vqpbwP?=
 =?us-ascii?Q?GznQAKOsRmu2qpi59csX7saM8HUbzpaYp5zY0lUaxsUYdeboj9U8irIEe8BM?=
 =?us-ascii?Q?g3G/gwz20KD/Dwh01J2EIE3V90XJOk+oPUSUYOO2dWCx8PMpfXmNsNSmunXa?=
 =?us-ascii?Q?0n5Iljly7/b3J7JtbxTZw4r1m2WcQ+k+DDI2E8Ct?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e00fb0a-e316-43a9-c196-08da8b5c8109
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:24.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r/Dmg9jlI+LNH/Mjp69vdKRQ0J3rS3xmX7tfvl4AbZfNfH72NaszFiAE3qHD9zjs7bmz+ZJ36q+zhMur2myXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
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

