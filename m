Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4095215A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiEJMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbiEJMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:43:14 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A32B274B;
        Tue, 10 May 2022 05:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMqqClaQDS4c6DKI2NEQgvfVDSvdNCogXsGRX4ZhGNGVmhzihrbi2sifj5kwfOLWN3RivgJxvMgG3XNjrbgUBogoJByXJ0yZoHNV3D3QdhOmsf+0QDz1snFtz7a3Peeg1jLwQinPBGaISevqxDxn4LnEaMZP9xmD3F7YcRbxPsqjFMon1+zDjomrfO1VJzllgQ1Fxd1rnLL/LolGz/qIMWFhElkyFPWniC9l0F8sX5vdLk4Vz3DxPfYzkS59xRHlYWYniJbOFKyOttx+g8T8NYdFB8XG+tRLOtL3Rvk5AbMI6Xh7ognnxKb8PsCdwVplifPy3CTDZWD5iEk5hfLlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfQqfowH4cATdg5QQ3Gzb596kLpXJEVflCBCrw9fjMM=;
 b=Ljihekf0/w25fRDZ1W1Akjoq354MvCLmR4GSN4w/Tp9Gr+Ct48QeV5xFcXnVZQSqZoFHjdZ8MZxNxMdTFrN3XBCIPynJ5Mq4beNW5U3BnMVc/lBaLUU64NODSzdxNUBHrFfjIl4trvByI0ETIGOuR7LhTT8W6qWKXV6ei251+ltt63Xy5AQirfBZ4YVqoLMG/whjbKG9KaiSvQ0rTGxf7UBHZKlJZ0gVJa4YPFYrodOhHSWzXk+g7l31DgpXkc+zPEvEWNkmtpjEgvHUKoT++P6Zvuk9rT9gbdMfKsr56Y0WbQSePjTXnfM8GJgQ2Tu9dkGH2Q6MuXoC17aqJKgzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfQqfowH4cATdg5QQ3Gzb596kLpXJEVflCBCrw9fjMM=;
 b=lRHZRa+64UXQLYgqqhLRuhgouaRZd/NJZcmQYPC2byU670xjccy4WoJXQ9cjehMHPEBd9J7CiO4CKJvfoLXRqaYs6+dSj1yyFduc0V93zL3/HQhTD2kyeQ0cbR9JU86S1gbh32wqdz+HIf0HbGkQecrgogQH2c29PAckdnftdrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8937.eurprd04.prod.outlook.com (2603:10a6:20b:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 12:39:14 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:39:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V6 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Date:   Tue, 10 May 2022 20:40:47 +0800
Message-Id: <20220510124050.398891-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510124050.398891-1-peng.fan@oss.nxp.com>
References: <20220510124050.398891-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9290b0cf-b0a1-4d6a-fb80-08da328216e5
X-MS-TrafficTypeDiagnostic: AM9PR04MB8937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8937D815A4264A656F4CE904C9C99@AM9PR04MB8937.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0llb+vXQlZouyh4daMgc6b4Llpb7NK7R0Z90NUUAKLwVQs7i/N9qr7r7qEBK3a+BzqHCDQQWJEd3xTHeLB4p/1KO8vREdK983VCroFrm3d9SLqGwaQz9UUKPVXXr24ck4alZeUhHBf7/FwCgk9+iYVYH7AA0YR0M1CCIDlevw5VejJyveaiJNSdYsQz9BbnA9qGh/h/94b6YBM2xmx7mQPc0hvU41COK8l110CwKUeqaF2q9qGEscUy+BR01ZrpSIexmAsfQ3MfsP5KVDl2zR8JyIaNzD/61b8r34w1UBANFIBPNFn84iqP5h/kOm2waOTdL1Xv1ptxpysSjM26+bl0aCGFOJXfRDR8gP/ZFTU7WxQusOlJognQSgG53xX9OsZuLRjXuXyUSQGN8xooQVurZKAeuOQKtTXnSH2jE8vOWZe29RV6aH5E62rs2sqOvkXVTje9UkUxn1iIpsuoABdByeJunoygOBhP/1PHqz4p4RGZCFIrXM0QR1Ww8j96WC3XgZfCCNJhogiBsutTBWWtFlnvEmfcS8dVtocBuNcDlyCIiOtHmwvVQjK+8tTyoE55PsaNAAtkU0gNwDtEiR8r/7h3Qnim1zY/av9pjyN4Op9IXoaSs/BbmqIVBHB+Z0p56sp4o7KB+NvJunKrzNst1ME7Sv+8sm1S/XobQzoqgpGPRbb1reHRQb6o20LJRbQb9n8Zd5S0Mj9Wx/fEJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7416002)(4744005)(2906002)(38100700002)(38350700002)(5660300002)(6506007)(1076003)(4326008)(186003)(508600001)(66556008)(66946007)(2616005)(8676002)(66476007)(316002)(54906003)(52116002)(6512007)(26005)(86362001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ao6PvlulqW24JyDzkub5TZnC4mdZsq2sSRLmyfDOzis2w/mN3Ir1XfTSQRbP?=
 =?us-ascii?Q?MoEZ4teZzllAJfcHXjt4pw6hgHk4SV5wYhlUfLFuFA/ac0qSbx7EIUKcrOUJ?=
 =?us-ascii?Q?bhtkWd1xMRQu1EUEJRLE9CFKuikAHNitEDHMipAXQ4NoptNyVPQrTu+PgdIZ?=
 =?us-ascii?Q?VfBJ2nMfQ4mNioSC+Ahc3VCEO09iA73IDGJ67hYi0WCLcm6douZX5BH8RdtJ?=
 =?us-ascii?Q?pZgaai6hJcFUwGfLmMAaftKGDoXOmHutBmhIvYul/bVbuRd8uGFADa7i8qGv?=
 =?us-ascii?Q?YsNVZlV4yUTRWdRYaYsVrT/i14o7PbeV/NzyvqhX6UCb1/pNshRlw2QHauA4?=
 =?us-ascii?Q?NHLF96uM7Q6V3S33YfA8e/OK263MA374ftrTC+2LnRnVHImQZzMZykPCZvA/?=
 =?us-ascii?Q?epViE98WlT871N62vP/Q9sGRJoyURWpmTF0Bt6FP4/VZCHgoHSzXjkzpf/sW?=
 =?us-ascii?Q?t5q9ihjso4rdbyYPgLEJFSK223eGxM6Xzdy6bwTZMcci5nKHil7kCivOUiIv?=
 =?us-ascii?Q?14DNe9DNcAKR6k4uG2R1Lzmewkn5yPBq31a/5xy8dzC2gGtN92Lo8bZBhzqq?=
 =?us-ascii?Q?QSWqTolpu0p/nqwWm1thXNPl1HG6LUFdm6Ov4N3yby8Jktu0YUOdPrnhxoeP?=
 =?us-ascii?Q?KbCBdz/bgz08XAuqJHL43CviB4oXIk/in4DGNJuxn2RVdowbFgFdTNkBT/ML?=
 =?us-ascii?Q?H6HDpavLDHugn9GlF0e/3qMN11uX6kbKgKVzQEPv5eFFN5l0/vrFc9HTge3z?=
 =?us-ascii?Q?VeE57SrV0yE+BLulrWPI4e19NZWh54arzfzo1osAgDIdkEedb8dKVGEMgmQN?=
 =?us-ascii?Q?vZzuSv1nwTpPK1F5GDko8LhLaF72R/ZA6zvVzHacfIG4OoggAHnSP4ja2sGO?=
 =?us-ascii?Q?Un+5L3M3kLRx1fUXc0xkYmJCFEF39tsknmMj4UWLgNOf8vgZKVukygoAmVot?=
 =?us-ascii?Q?StV2n/Ptl3M/R4l+TPpf49ddr3uOGkDZjnfWZiYibLmexz8ovT29v/ZAToys?=
 =?us-ascii?Q?p0Xw0kIJWD/lqgMBVvzWVsZ8snbbdcZWUuicVA23muNVcWNhINyKOEvGxGv/?=
 =?us-ascii?Q?EuzHize1zoduoTjyWRxRGm4E7hRTudDXBpJx7qFjxnvkM5zmDJM6VnbkSbcS?=
 =?us-ascii?Q?yHfxT6zURgmNsdvLIPPr8vf5mDLeGdw4Ozh/dhO4yffwWbRgFIILUp4KuVDi?=
 =?us-ascii?Q?bxKX99V3eANRbfMKoAf7zhUA57i8aESnJBca2Bqm8ysTl742zcExSYz20rrn?=
 =?us-ascii?Q?ggx9utUnz0FjhNJaGB0bTQn7VWlKX3XZOtSus41Zy4OENhT9VZTTawVf/dSH?=
 =?us-ascii?Q?2I5sGefozTj2DjHVWwrmXaHYaaE/Tv2xJC+QQ3hqL+kxovJyaZJ2cZOXbxxN?=
 =?us-ascii?Q?NAY91VYnJ87Jsu4AzXQACD4EiNZuBMYbdSqZO4MDT53+e0lg9Ss22xuUCyyL?=
 =?us-ascii?Q?/Lu86ebR8yHKACEbomAdLq39FsedZ8tqFFAFWti9ScRbxFsi776xdKVv+wjt?=
 =?us-ascii?Q?4ZaDU2AW2h6JSRui8VUrsXOjx1fa68MeyLhVEI4ie3jAJLkiauDXXu9f2G9x?=
 =?us-ascii?Q?Dg/sEZC+RlQ8GM2PxesGlBsPBZxyeOtKyWeNUL7i54VXGXjd8W3Lmgh1204D?=
 =?us-ascii?Q?4pt/nDdTYuC0f2vpTxR3s5a/vmRv25pIsyS4tKyPGwpemBqptcg22Uq/4T7u?=
 =?us-ascii?Q?GJuQnKRyCyowvCmwPPJYkok0eMCVsWsJq+OM9/yLczb/YDlPQqMfdb3Mek+6?=
 =?us-ascii?Q?K0/wChrJxw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9290b0cf-b0a1-4d6a-fb80-08da328216e5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:39:14.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ub2cKpRFN2//tj3Zi55J5oFRmVzimeO/mvqX3hg6EsUd31CbcPJ8c8QNpbcD1nmmPMthJqfLt5GP6N8AuBdJyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the board imx93-11x11-evk in the binding docuemnt.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..9e5d5725df65 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1020,6 +1020,12 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
+      - description: i.MX93 based Boards
+        items:
+          - enum:
+              - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.25.1

