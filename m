Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6451E4E4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383517AbiEGGzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiEGGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:55:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212D140B7;
        Fri,  6 May 2022 23:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1xffNis0VaTqdED3Y1H5Y8SP7GFuiSxAfS7UwZL/G5MygdYPuxLC2g7xttqUSls9qVJDo6BAolWJWZ7Fwg1MHX+Mjr+ln0Xf1JnLiDZcAk/P7yMW7UlSqMzj20ziOvu3v6DAeaU0QczVvxPqRCnSHw76LgvBUTWMQiRTdXvJkld02f7Yq6tYsQ5QDT/dC6GSM+6WCCFM8hsNW1306T3YMXONNnRik6yeRVCAUW8yU891Ibgm2nCRoyePRk4HokGLwjJhn+VNlXKiDMTXKHVqfOwIaMeWJi0103NRgOPNMKNCj2GWerZUm8QXvrfqJtmeIX4CPC2cMyTGWuDqEPO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enrywbuFIQVjtYg3gegCDz9DcFv5Y2vImb4lwdCY8hM=;
 b=KKtsFhP6yW6jYhDIphbpwfvMS4rqSTAbIX1WxnuoFgeMnh0q/FaKSjq/5JZw4+uBN0yWS1qF3/RNGbOatwPYmsN6xTp2K4O/S95rTNGkpYLXhn9SjdheljjrY/NDijKUx5bIhh0Tomw/Jy+/KAX1kAPsFqKny4U5qN3UynQCfQLbtP11lURXrxRF34UnvilmaX6j6LtC/tNQWkatWnVvf5Ck46c0vVVFbTvMxHq/Xr8vpl4knMSts15rc9kb1hmQpEStOEY8fewVxySaZCllcCjXQ4npB+JNw9ciRUX2/XtT++QIdUvE7uClR05XHrzWnEYnR3q2Y3t/jTKPVipw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enrywbuFIQVjtYg3gegCDz9DcFv5Y2vImb4lwdCY8hM=;
 b=erTodWk4tJOhPrOplAi4SWafvdrLRWbhARlfkEHXss84wX2jKvBlrZITtd+zyXOBxxJ0papMh6g4Zmt4IYoSVAZVxM7xheTgrAFnWmXSwCxcJlIWJQ9jCYH06Zmt1enyaGipSUICkOOtQKl5mg+pkyobxFereM2kX2r7TazShQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:51:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:51:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/4]  arm64: add i.MX93 support
Date:   Sat,  7 May 2022 14:53:05 +0800
Message-Id: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1423e6d6-e7df-4bc9-35c3-08da2ff60235
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2527:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25277D5959A3313386D5D366C9C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpQ01YQq+kbV8rr+AsDfrU2r7DweusYgLt/IMT7eMUDQKYl0rVBFvmC4NQ07ZrN1LER+kMCmR1aO/J7P2OuOOA/fAq+fwvZaVdvHjyhN7jmfiOhlX/q+kvkqybJ4jfOkQXZTy0b2cl4TriGHA55gsqvJeX/uLcR6+1WcVmfRofmwM+5ugNWx0fXD5hFTRaDr7WWazBdiqAhS4kIrwPLO/1Nng7oHdqzFbP0Fu3lcB22GXVUXzi82Wo6UuAcDGtsvwRCrx8yhUUTV21upgmICKwmSOF5pEFnre+8hoyI5WaBCtmBpHXdCcOIVAS4+afxJLqdXiykoQSkG+OnpjYdlO/kV/y4WoBFFWFmhP4B+FsGZTeMXAN5pho8e2T0700F3c6w2Dt1rCjY3NZPLc4+zrCpsYBl9HFWfh5BaAufOTRGGCBmHFI4Ms8SSwke7T2yfSP8yUzTRBZg+1MgpTOcyE+K2o6DiH0uhmjovU8Hc05uZRxVC+GopkqtZewSzkDmebTVYjv2uKrDVdnSyInu5TqxE1nfkilWnOdy9bfrNOfMSbT+P1v7ZepRIcWA19dZdt2v3mpnbd63OokADGW5svMzFw9vE+kKn1CIX/l/SavfIr1kL6lTu2RnBeaQfMm8++VPYmQKv2qDElIh48TGO548RRFPaf2b+Okx4b5g3r2XnPyYsRjTxxlEjp24aP1X/ALaYIfdSHmTIJTNMlZDlKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(186003)(38100700002)(66556008)(66946007)(38350700002)(66476007)(8676002)(4326008)(52116002)(6506007)(26005)(1076003)(2906002)(6666004)(6486002)(508600001)(83380400001)(5660300002)(8936002)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7I8KpAhisc9gFx5FW2gg8QhpQwMDyHzT8evuRBSo+cpY1Sj1My3OODjS8Z9?=
 =?us-ascii?Q?yzzIYnCRiJf+QaTTWD64tyMH5d46DX5GJLp+5WXxC12YQugvjzDAfk5wBV6X?=
 =?us-ascii?Q?iF9IlWeahjHgNgQCWvOPML+whxP6z8R9pfchibY9vLzq7gRDZ9o8YMuzGoQt?=
 =?us-ascii?Q?qcDt4Pe0z3r7OTw+/NMa2iHxu+vjVwqqZY6fHbPWk0D57M2XGEOGBmc9AO2z?=
 =?us-ascii?Q?GC2Og69o246mIzcTZyGDvgbCPb3c/k9JYQTjm4qGSfhxz6eKrDnELXxC0y3A?=
 =?us-ascii?Q?SKNuuNQzVcdscCZltxhw+S3gzIrbeze6TaczS/1quE4yDZo/9st11p6J6KMv?=
 =?us-ascii?Q?kveDpf+VBNTsWBcXB/cVjvamFDynik9iWW+Vv65e/B/ilt+6DrydmUB37Tg1?=
 =?us-ascii?Q?XcNH9jWOamqOIbzgSbuDRKPJvPya/dMjA08c+GWcdYBZJb99N898HdMzVcwi?=
 =?us-ascii?Q?vtkbCeAeixjWW177/oNh2bP/dFOyddYB5pIT4onAb/sCba7Cl4Aysdp5MYmI?=
 =?us-ascii?Q?lHJrHgHWJG7Mhy3CQx3mt4TpWl9+slJFp0sxSdGKZwRWVFF0FvrilHGjoAOm?=
 =?us-ascii?Q?LbqMOSF0p5GFldp5aMiNQhOWW6vJRWCFDlgctfy2i56gkR9hhO6iJxLScGww?=
 =?us-ascii?Q?8+6KRLa4apUG6EHTtyZQ3LLH8ckMnBY6kySSaMe4qA1hf1YYNXx+Iw8tZXCJ?=
 =?us-ascii?Q?shUg5c8Y3mHZGxY3HlZObnqdRxV53cASFm4nRe2P2E48EmP7yA2dBsxPUiGC?=
 =?us-ascii?Q?d4NAyGGTydRdDj+Ho/cUrYIpjIlolQA3sY8/RQRwK9QfXwlnY6emLwuJyiMU?=
 =?us-ascii?Q?3fRATVtXEeZBGmbBCRNf9F9QwHKniz2969bgO5NdKJy8o4EpSAzS49eycXFK?=
 =?us-ascii?Q?U7RSyK1SKWNWzlJZpavD7KBhEMhX5JW5ImURferhIhLeLL1ixnZWNp0QQqYl?=
 =?us-ascii?Q?zMbngEhI4//7o8jJxH076SSuqxvypwO6X0ox6MCrCyGN4aGr8qRkabPdTWha?=
 =?us-ascii?Q?zZTXqf5Qydl00dRlRwv8QJ5zsknFaNyaEkk3ye4nuPzHBodkWGMK3jkcYJId?=
 =?us-ascii?Q?3NwfKJ//MoXzaWomcXHQrvbq2mJUcmLcEKwsE5CPdg1bRBIm7h2DDnJgH2Pg?=
 =?us-ascii?Q?07fRMaYqVYQfe0seo8S8sNr1YzVkQsleV3bdTOkNo1IMbcURIFBNf65LS/I2?=
 =?us-ascii?Q?pDGEAH2mclMA4ve3CmQKJygAbJp89xM9lawtjyoFgS2fDmoiTN7+F5sYz7wJ?=
 =?us-ascii?Q?j4PZJTsUefOhqwGGFRb1Gze74eIydUJBJkGlehjGWfflA0Ca+fb8Tu4r3TsP?=
 =?us-ascii?Q?PdB6Z9wR3ykhTLSdnHRgPA/Bk01FUPfWQ4VVPXtXDyaKVW4IqpvsBVzTAtKR?=
 =?us-ascii?Q?2eX49do6s/NbDM26bsy+dSdyXkLtyWp3uCJ+aaHVkTQVSMaUpilA78WnOZGt?=
 =?us-ascii?Q?fluNIMHiKNbOkb/elE0IWplTxUpEo1LkrxF1G5qAHjQsG1wxPcNsO7cDFfLX?=
 =?us-ascii?Q?L/97A62ndAqtIYMgIwMY6wwqeAZ8hzAy87H6aMF6A9B3yOn9R/ondPD6FyIy?=
 =?us-ascii?Q?w0fjD+rtoiVbZflCoe+MMkMWqFIpLNvlT+jW0j+pAbpop6NLLxLxYYUC29oP?=
 =?us-ascii?Q?4caJyap5ocT9/zoKZWOZZdr0nNjHam2wj1vZUNK8YCB5UHcKizfIPSqjHF/b?=
 =?us-ascii?Q?zyEEu1SSwlC7bHkEBJLo15boXLl6IHAlq3tq5LwAG60Mu5Pi9hSxmC8BA4Se?=
 =?us-ascii?Q?DgaNHSB5Vg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1423e6d6-e7df-4bc9-35c3-08da2ff60235
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:51:27.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm8YThRfn/SWmW21c52ClQiIHlQbHuBB1yzjNzSWYPNJT9GdrtHcURcCy9MEyC7Mo3BUnjWBnxdmoU50FoP+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Add a new patch patch 1 for board binding doc
 Add A-b from Rob
 Fix dtb warnings.

V2:
 Update License

Add i.MX93 dtsi and 11x11 evk board support

The required bindings and drivers has already been in tree.
There arem checkpatch error for the pin header files as other i.MX pin
pin header files.



Peng Fan (4):
  dt-bindings: arm: fsl: add imx93 11x11 evk board
  arm64: dts: freescale: Add i.MX93 dtsi support
  arm64: dts: freescale: add i.MX93 11x11 EVK basic support
  arm64: defconfig: enable i.MX93 clk & pinctrl

 .../devicetree/bindings/arm/fsl.yaml          |   5 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 132 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 333 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 1096 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

