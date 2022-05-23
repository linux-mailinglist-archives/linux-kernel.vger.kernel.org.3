Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34488531065
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiEWL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiEWL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:28:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2CB4D251;
        Mon, 23 May 2022 04:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqXtkfoir29OQBHFuqRWjZ2KJ4dImbZxBjt07F7XHbh1zV3zQu3o7rwoL8CQHBiE49678mXHZIXpPHsfZ8lp/atEXbbksprjN9vT37mSFJqs2GrZgRdREsoKe1KlVsyBDg/TBpUS2QFpaQuIL/4csBWFxnlbFvNaxaVNwGseJ/q9ZGgalHJrmcxpGL+fClinyfr62g5y0kq3rbkci4CsPQquGB6ZVFkQVpd8OwfOpjD6E+r23ZCpDYEorCyRINreROlpIUTerPdaz1ZNr/M+iYNhH8VzdLT46Be7V1A8Jyy5VxTuzlvJBnsVK4MC4UBLTSt2uGaVA3ZW+sKymeEBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZwImjOCqjHC02jp4G/HzBtKNYcrcKqYI+Fe5yxr60E=;
 b=EQcS6dj3EBtmsQSkuCEFLhUg1EFaxLKUCuxQW8xSCVtRzY+4d02Cumv2Ec51osdsJkGZ0tcz+nNXbmjRKxqgsFAQ+ThxZgOYw58gcv7pBCc1NMhjBzRZUhCg1uPtWPxi/ZV6wJrcBXxnJzHt8jAc8zAFYnO++1gsCHranH8hRpzSiKlaolMb+DcTn8bYO7N7mqNYg5WLMPqNigVglBBRWxCFYQblXlRonczp2QFPznQYBTC1N75rWkyewoI7hpMn5xSx4gvnNnr+fRRhdmemLPlFfRrfPD08edrYXxl1DDgZsn0LoEp7gWNgzcapoy5AIFXTf7k6hsRKOTwfmYUypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZwImjOCqjHC02jp4G/HzBtKNYcrcKqYI+Fe5yxr60E=;
 b=O6DZaJ6BA11dhve6AIYDwLH+YfLK9uozSnMda9BpobNl3uZWVGlGRgiflIf0lwQUH5jgMmayU9wkjw+vv3co7yiAqasN4WDFWJeluqqW1U8u3r8XoyYgK1f2KHDPkk6IQ/4qZqVYws/o8Zys0pxLc7DDMu5A+8UkAqWECZCGsXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6296.eurprd04.prod.outlook.com (2603:10a6:20b:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:28:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:28:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/7] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Mon, 23 May 2022 19:30:22 +0800
Message-Id: <20220523113029.842753-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024296cf-a7d7-4373-1447-08da3caf63cb
X-MS-TrafficTypeDiagnostic: AM6PR04MB6296:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB62966F41D7BFD02E256B87B6C9D49@AM6PR04MB6296.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlMjPRg8VRNad2x63cLn4+vkwD2JU1n+79lDwFr7ik7GFeVqXUEUxJql5xJ6+Dmf3tUH131RMH6eONOSCMMPz8xDSeA5KpaD8apQcjgTNK8lmxRRzdYPilhN++W4rrDZWV3/MgWUIEHYhbLudI2vXSKGl9zeDISx7SlWLrfr2P3E8JSq6cDOudnDRNqJigHPjfAcpTBNfJWgEG1sNhjl6CIBpAATBuocq/NH2/oohdT5ZcxcE86+vx8SC9CxuCMI5Aq/ZkyvwE57z6itVLXXPkcsG2OQEdlJ9EILXlYGeM4URoeQ8f0EEUfPX83iJJQdBAyNKaZJoTgaRnLsw1qkhPvBZuaWjbSPnWsJ5S6GVmI9ILcvX6B2+3e5OLQ3IbOydkuDcpn6xKSrZHWwt9WNRsLejUkXy3iN0fMaraSsJ/+OGdRDolEERPjv/KaCyeN3xJIZSoWKQt08Bvop33Swq1qns+QsKFkQQAMxu/AyJO6FLYH9yXxYG8bwkhIF9+fJ4gtYclrifgolvZzDL9XsyzerMpNLrFMYURAFPMqWh1qhKftkoyMsiiMhhHZkULOsmyXKhXGWydgKs4j9D7GowjGYxiL+LSF3aFvM4Y9C2NZ3GDYpmfiHyHPwUH0y9KQbNiTFN7WK/iIAkmnrIFKTEtNuaQyIrJnjzzoUYdk0L3xlErHQhpyMBYqjDWLMi8Qem3Tp5QSTi17VL99PTku+nA09J7jxa7w0CiLLCqG5LT39z6/I2IajVE9bjaJjiTi73L6CBwun4CrF9zzHyV03oTZLiMQ1WyTBztMTHro2Qag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6512007)(6506007)(66946007)(6666004)(38100700002)(52116002)(8936002)(7416002)(26005)(66476007)(66556008)(186003)(316002)(2616005)(2906002)(1076003)(4326008)(8676002)(6486002)(966005)(83380400001)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQFWBl89Dsc0fMYlvWhNmD/adtI58BR78RrR64xHvR21HAzV4xOV9UfIaPf4?=
 =?us-ascii?Q?NhUTCnGcBtDT38c3NRQ/c32BDKP7hPVbcjVOSJPh74UMYGDfVvHdff8EuGUG?=
 =?us-ascii?Q?CqGQjAu6lLRDlUOGrVjrphadLs625haFcyWx2XBtkMi+DHLTWQcgBYuVD1tV?=
 =?us-ascii?Q?RsKcymzGSBZYFaMj2o6Q3tyvRj9263KfWPp+tw6ZRvqlr1NaJqTa6oNd/8rC?=
 =?us-ascii?Q?5B19V6WsrimnmH4y7byK+yUQQ22BRK9g/b4K2kBDK9aBogjnnDQw1A7eVMad?=
 =?us-ascii?Q?geNOwTQ7HMbKAfqhluiayVCB5DPk9StWhpUCSvdioCLWHZxOk2ufFbfCPdNf?=
 =?us-ascii?Q?4+tdXEkgSSMG9dHDIV/Kwiop+BxHvjRCOOigLsXK/THa0Bm5W96i6BxNTMuN?=
 =?us-ascii?Q?SAoc+5JFdeZ1VNu99Tlus/LshZnDVlhS+5JBMj5WSIYXr2fKoP1rBsHzq94H?=
 =?us-ascii?Q?k8cq7NU04JfcM9gSn/Ly97YjFfizNjuWGnqJ+sJTa3ox4si54ME6B1eFH7Lp?=
 =?us-ascii?Q?qdJlJEyeVfX9Anj/Rtnqogj06fxiT37FEgi4ij2fbywbkrx1Oq8sKMQAwpPF?=
 =?us-ascii?Q?3NQ2xMHq7XOTJHvmbW4+tERJLe5VZTWazFalMwDt66sokHZOXT1fCCC0SaG2?=
 =?us-ascii?Q?Bq0j37rQqT0ZmcYUT9tESbVJ0sycA8yjtHfLSzqkK1mSZgOV3cS+p/xRlljA?=
 =?us-ascii?Q?GqRLxB661BP7aVNyjCeSZjhc4Fk1mUir9SQRGtFU6dvYinT64liv7hbbt4uA?=
 =?us-ascii?Q?Hf15IZlQmjp5FgVfwwNIyguXqQ8YQllbZzexY9J3d0xnWlKmawxkXO9yzRex?=
 =?us-ascii?Q?+OLgyyCUAjs4GnWWcmE2/gbH8OG+r8oFJxI3ftRHTK8N6af8r9bMfFfld8uk?=
 =?us-ascii?Q?mks3Ul/G7VjoaFYrhNE33bjFmDJRZGLUiSM7VAj2xO4mdrgTpUYQzI2Q4xYJ?=
 =?us-ascii?Q?ZF4bE5dO9BWz/E2sJ2ZdCn4EPHoXCDjm+mNewDNOnRI7JrSK1Yfosr3JdMF2?=
 =?us-ascii?Q?KTeMVvAPWNl1/YayKZ3VJc+EZ681P7Yl4WELNUZEVHcLfAr1NmmlMtPDNSwv?=
 =?us-ascii?Q?V9ANb/vjN0a+aQjYHB9GGAFKPcMWiwOieLqxEEbRAWA2wQRQjFGVFTVU7B+5?=
 =?us-ascii?Q?lfC6qZeavw+3J+42TcSTRIXTwLERJ+QgkM4uWahDblpp7r+ZHuxUY/cARqTr?=
 =?us-ascii?Q?n8C+evjKgL18U53gg+KXUkK3kA320EkEtmLDKJxRerWcvdj/UbBrVv2W4Boc?=
 =?us-ascii?Q?WVw7qrAJim2Rr90c/DKXsARmz9+SJOCNhQpreceXLEiZyRCWbNQrfKN97kAu?=
 =?us-ascii?Q?U+dRAa74OigPk1uTK+NNix71Ph1xg9OoFF1JwiuJqrNQqB+VjZE9hBTVSxR/?=
 =?us-ascii?Q?jGfCxnKF9fFMKTSmPi5ghDKmMZahHITy4mBOLcaWj+EfOArLstVFcg0OstgP?=
 =?us-ascii?Q?8PnpO8MU9tVdI7jG9XridPN/r1nakljPiCZL84iuwhp8OI8NhwVSNSStHP8X?=
 =?us-ascii?Q?uTP0BrkCRl/jkI3/fpLppCBD1V8ApXgWWHknwtn+ErnaohBQx5tVSRc4q/Bv?=
 =?us-ascii?Q?6zKK6hCKvRq3TxR3XIGUeTyBAHgK9w3mBOkoHLYR88/3HpbmUejxpEY6dGrk?=
 =?us-ascii?Q?m2iOkBZ1d6E004GR3l8mPuABPoc4PpG7xQz3jL0psubtOhopwlVX1QsYCZJ/?=
 =?us-ascii?Q?mVMMqBMP0Wk74V+nd+WQ+nAIAqgu/rJ8NWU2kXOztXHUfH0eenWemm/BQHOh?=
 =?us-ascii?Q?ZdO7wBNYVw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024296cf-a7d7-4373-1447-08da3caf63cb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:28:42.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TeRJtSR3V0TvkNbp4NX0dS66kyR9eQNTFTvSblhf57hB/NIvp7fztdAqCxhEFqT1vdqDpqvBnasBOmcFVri3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6296
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to support i.MX93 SRC and mediamix blk ctrl.
SRC functions as power domain provider as i.MX8M GPC.
mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
software view.

Export of_clk_bulk_get_all for driver usage.

Add bindings and dts node

Based on:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220510124050.398891-1-peng.fan@oss.nxp.com/

Peng Fan (7):
  dt-bindings: soc: add bindings for i.MX93 SRC
  dt-bindings: soc: add bindings for i.MX93 mediamix blk ctrl
  clk: export of_clk_bulk_get_all
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  81 +++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  88 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  38 ++
 drivers/clk/clk-bulk.c                        |   3 +-
 drivers/soc/imx/Kconfig                       |  10 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 333 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 271 ++++++++++++++
 include/dt-bindings/power/imx93-power.h       |  17 +
 include/linux/clk.h                           |   2 +
 10 files changed, 843 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 include/dt-bindings/power/imx93-power.h

-- 
2.25.1

