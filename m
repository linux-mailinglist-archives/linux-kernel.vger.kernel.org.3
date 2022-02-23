Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC384C06B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiBWBOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBWBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:14:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79552A9;
        Tue, 22 Feb 2022 17:14:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxOt68QZZU2PanXChmiYJJbHLotFmTMXfC/F2EChEkYnlLM7k0Ui0jAeZ72bXJhropHkFD4xAucSCnciyRxbqllE7IIiTSHf6lS3mzDzRtKShDwrJqCwuTyjl3n35bvRR/1aDu89AKR7iGpT4bRLrWFlSrAe13yebYELvwMlbztnDv7g+b6hSs025wU5yxmYhx51Y1cLqbDMf68uAdTqMGdcbI5OBlnlfPG9qC+WgpS8RJ54UAuzITX+98BZBxesf8xIsE06Qc35sow4rjUjEr+x9FfBvmlIk1poO8qz8VbJ+ZjTN2xUIuaqm6/7Du5/4O3jKRqjVVOdi0OrKR5Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JMkJUUimfLSnsmt2pWt9/XrnDp2OfLOhRFtijpc7Cs=;
 b=DryYqI17vnWS8dyI8gZdcsKQOv/AduwnGUJ3ayRzxOma8laIjQrBL42Yc2AgO3JXDZUDH0DL3MGH9zi3O99t9ypPTNmFafj/yVRD6IhWXuQ/E8bO4h0VcI30hDPE/htjWTZi1NbpuwUnoOEXG7R6fclBH6UUrwfEgowSP4QhsbGTXft7yJTSRewp5XQqP6/k6S3fYls4l59XeSaqL6D+gd00AktwbpDA84T0ZU0k7F29u03KxQ+qCVpPocOxqF2+5szso4o76ig7Cq3QuAF37SWMYNK0amh7rD2uD++izRkJmQCZRGXVG8aRzZ70uJorTxAyq6z+l+il/+fc8g5eVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JMkJUUimfLSnsmt2pWt9/XrnDp2OfLOhRFtijpc7Cs=;
 b=YzFF0jbEYL5lcPtCBr7XrB3XMa8wzpjIJP1Zu9F8eXeQ1+7Xcb6n07ZQty9OlnIwO+un7tEz8wK5y4R9SY3MdoxSQ8zBB999d3oCOYQG33mCEnyDrgL2uaOdFCM+ZF9769qX9h8AHPMtujE4+p4OTVjxJAqDUuIo5xv+mCNF+90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 01:14:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 01:14:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/5] imx: add i.MX93 clk bindings and driver
Date:   Wed, 23 Feb 2022 09:16:01 +0800
Message-Id: <20220223011606.3282165-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6944ce2-ef61-4c6d-cfbb-08d9f669cfca
X-MS-TrafficTypeDiagnostic: DU2PR04MB8533:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8533A1C9717C66B07AF52A1CC93C9@DU2PR04MB8533.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV0tqecIydUsF1VVi26qA2aWJEFqvRS2hvryN8uq/Yd3JR6DPLIRH0IbzEIjCfQVxLfC9E+bVL1Hn/WImR+yTCXFqNWsYbVLxAFpVV6+LKV3pOX3Ku0Aizvv/NmAvI9l/mgQzzeTVHpKTa6zjmbumJimIQDCnKe2TCmTq+5AQw8K9+lrJsGmzkfEsWiytYpsN9T0p7EnNO0TS68Mow8uqfT0M2pQZ5mwk73AIeNcjvlFcDfbtoAFvQwqLJLWW9VgpzeoudWkTHl20y8eou5mDkIOzXr9+Fw7w2PpBvlrPtEyFDSc+90NgIG+qjBFVrbGGzSntF0uOpm7qyJj4mL4Rac2+dcXaRhriYUmKqGZfVko2Y8ac0JHJ+S7Ay8/sZoVBNzkk7RZgNa2dkfynu3fXkgP8uh8UHeo9Q95g/a+ZunkEfI811fO1NUED81pUaYJwQfSIaFGqRSianIq4smEeu/+AuKrVk/ypTn1KlkKsidj5USpT5r24NY0OUirSVAcNG0mp9KRH+J0wrjfcII/7KKX/GC9CXODQDwVjKZ2oxXSeZcoAbdkcW8zQ1PsTqHUpaMHT8yYBT5AyNAOdB4wseZoiJEqC48FxJY11Gwy92msnEdrTWyf1PTzEAc7b3tXRQwiCv9Y0aRv+ypqXZI91kflkXZL3arTMu9Vjb2AGJ1ZkY6VNg4TzU6WKQqSy9D9jyXdJYRas0dKeebWiVhACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(4744005)(2616005)(8936002)(2906002)(6506007)(52116002)(6666004)(7416002)(6512007)(5660300002)(86362001)(38100700002)(38350700002)(83380400001)(66476007)(316002)(4326008)(508600001)(8676002)(6486002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnPIBTtL2BJVcORc4u0irQNiaSSrf2L68gk1IpOo5v8Om5Di5ZeIFqoQSu1i?=
 =?us-ascii?Q?rnuen9JMhuSPAuKXk7dl0690Lq6/d9FUiG45wZM4/I3gLxkn44G2nwpTO11v?=
 =?us-ascii?Q?dfdo4CmPzbt5OPOPBgvG31trn9Wi/WM8k5auUCOKpuRo/VwiyKyDGduCSEyJ?=
 =?us-ascii?Q?gQmOuCKFq1H7unqtES4vL6r/1qQM+FZ2Iic+xjCbFwX9VBQUwe7gGpIx3Tua?=
 =?us-ascii?Q?32SFejCyh6DIoOSPPQNIU2A8QDUzzg5GryjsygD4132jOxVGyLtVuPvStbMb?=
 =?us-ascii?Q?fkU6h6bE2lnft6gHlrWZjQE/OQn6RSQqcddlXRMT9UVxNHcnuLTKEg1bA2t8?=
 =?us-ascii?Q?ckODbra/nW0NEsAmxPY4GoIY28bhL4r11Hxm06g8lR7JuZmbYkWqxON7Ak4/?=
 =?us-ascii?Q?FYfl0yDKo2ZXBiCSrhqJD8ijDy/JDVNrxmJQsHuyuIuL8Jk9rKvyd06yZrZJ?=
 =?us-ascii?Q?+uVn3edmnG6pAjZZXRSrfuaV3dj8N2kT0fqKs7iDE5A6fv0b8dyTN8vZIhvP?=
 =?us-ascii?Q?zFR2NXNSWD1493HjzbawAWm35Vg9sWMCeIhMrB+K2CPvnuEFYiKFQRxLNsmF?=
 =?us-ascii?Q?gTakEct2Nq55jqF5s8WPPS0VMojohtTA9ca3AZBmQsV43907rIZiM+Igcud+?=
 =?us-ascii?Q?IBE84M//8/5OlW/677jUC8okOP8/TH1HKfTLSynnLXwlvemkr3QVOz64gbs0?=
 =?us-ascii?Q?dSeJQp+5euJzm8dCi2Vob5M9icf2j7Y7adAWxEQJ2mtdLGioeUZ6t7CL67TQ?=
 =?us-ascii?Q?ux5XO9i7Vy/vZPLwqF5wKkk6dF7csr6QyGDZNOH0twBi+oepGcamq2VFzqN2?=
 =?us-ascii?Q?9KrpnRKhUkPsZOGu/FHE4+78Aa2GQZQB0G0RhWN9xA5uFqFgalHYVE4z5UQr?=
 =?us-ascii?Q?yapWOJSmfFbiFj5ExH7/mkCEO42ubpWXiUMDQRarLxGvXKscAqia/FNTUK+A?=
 =?us-ascii?Q?JiNaGBbeSu1lwAJf9XXJAjlBAMplTdZDBs5K2ihD3wWDvdpfMIqXoemjzhmB?=
 =?us-ascii?Q?7O/bihDmw2ezffKPD+YnxTncm+9aHPqRuSxQTEW6GXj8g9tqZ4cjn84zwaOG?=
 =?us-ascii?Q?Nv5igh0LiZ125Uu+GMQi05vRzfzIkwCyPA5g56Va/u4ZmKfSHL5snFmFfmNT?=
 =?us-ascii?Q?zP1H/VZThc68i/x+AKOTAIC/9Ub2q9TNulFdvUWBailBVpMR4AIJdlnAkerb?=
 =?us-ascii?Q?oBAhLY5WrKXQ2a3Pob0csq282X833KvtdW65Ml6vCXzMWxSZ57kdNX1zn67N?=
 =?us-ascii?Q?gtWQGpco3fBTYJAi5aIl1YrHGuXzLzU0cBq4cXaNa6IfImI59Zs5mDyerT18?=
 =?us-ascii?Q?yF1eHnWqpSnBZqTFDeYjyTvalMbz2D1T0XAZz/A8HRs01y2vmc4EeJtv0Uyq?=
 =?us-ascii?Q?zzNrVI8KmxxhlRH4o50xjGgtmSHrYKrf2bPWeAIbfGIymej96StoK/FuhbDJ?=
 =?us-ascii?Q?+bq8BdWjxRFEwIqaBKHrtCuW/Ryf9M1a8NVVX2nhZC47Dr4qGTczAxCfGMov?=
 =?us-ascii?Q?uB1cRydTkcLQR5uq8wkv30uxVB4gbFOJF+nCVCe95eNZY7ab2Pxm4KACnmlv?=
 =?us-ascii?Q?j9hmzVytE6wHw2Iz8BlU9m/7EIP2D+c6qtIhxmliWfaguzGWVqAVk6z7T+nf?=
 =?us-ascii?Q?714dJRkb0gqUFE+FsC6ojf8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6944ce2-ef61-4c6d-cfbb-08d9f669cfca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 01:14:17.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ35qvrUZSpr4flJ/dfeaiQfyu4264yQ9DwEPcC6btgZ201Ind14c7wccrUXXdhcb7tS5s+SUdBrA1Nq/HnK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 clk bindings and clk.

Peng Fan (5):
  dt-bindings: clock: Add imx93 clock support
  dt-bindings: clock: add i.MX93 clock definition
  clk: imx: add i.MX93 composite clk
  clk: imx: support fracn gppll
  clk: imx: add i.MX93 clk

 .../bindings/clock/imx93-clock.yaml           |  63 ++++
 drivers/clk/imx/Kconfig                       |   6 +
 drivers/clk/imx/Makefile                      |   4 +
 drivers/clk/imx/clk-composite-93.c            |  93 +++++
 drivers/clk/imx/clk-fracn-gppll.c             | 328 +++++++++++++++++
 drivers/clk/imx/clk-imx93.c                   | 339 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 200 +++++++++++
 8 files changed, 1063 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

