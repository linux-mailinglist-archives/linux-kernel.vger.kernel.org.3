Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40544927E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiAROA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:00:29 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:64646
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243935AbiAROA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8zxPHkPb+H216jDDBXlhDi2ySbHMFiJkLjchueoWyHhHb/Rf3usCYCJ2ZLZzF3RE7iRPgkVkWsVR1awROZPTZtv3PpnlpQfAIPx1jX2ZPrOuCWCKXAKuwvb6NByh2BwEWONe/jWM4Goo3aFNoyNV2vjbvrbU7JZjivhgCXvB5lyjZExPoIISrtVI9Mus07IyGj8XhnzR1UxRcQnEcS9T44SOM8VXAp7qP7CWtXVsVXmKcFrpClCptuCJZ38+KNPO2QtkH92zWVmC1bgVEvKaIIK2kDVrmzXEMdfXOogAzYsuNn5hOoCTi4gtNEI0E+uJk+xHKrWq6lBri1jX/clsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgc6Gfs5rzqDaF3EzRWROCvWWkq4H/Bri9xuWXcMFbI=;
 b=EBZutCMcrksD/lOFRnwihrxEZ4N49bh7NbE+VjxZoYYGwZ9MSrshQ406Kq0Q/gcTi+eEtFufJTryIZJ67JyJd/sOW/YlsX6uiLYAmGH2h/OJYbuLyhWyduW1jdUevhndIhfUlwTjZyAPUtIkJSYHzUDbB6AgNIsgshLcqZrT7xmYCikBkGfxsp03V2cWRvNGvBIRl6qfRnMczR5GuwjIpUla0F3aGAF+MgYo6U771JBL926LEA9QzH8EG0vrh0GeL1Hd6aUJVyAcOhqYSSfgijKbMesm1Gu7/oB4WCLQZCnREeizDpbKfdHBsKADN9FUNJ/Wiohu7UlUjONSYIHh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgc6Gfs5rzqDaF3EzRWROCvWWkq4H/Bri9xuWXcMFbI=;
 b=PBeXWrakHgijHKoXhLaHjT7n7gXAFbiPO5Bx2oHfRCnv8r78D83imiHOAH3jVAbZAemspNjCI8ixEuVy9cL1Dx8/q3EdUBtMYSq3MtmsfJDHus/rhAPC5HuaDSzBqUvXwKpsN5OVtXbqDPmVr1fQKSfiie6jMKBApNQnWsj1IoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB5288.eurprd04.prod.outlook.com (2603:10a6:20b:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 14:00:24 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 14:00:24 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP backwards compatibility
Date:   Tue, 18 Jan 2022 15:59:17 +0200
Message-Id: <20220118135918.2126010-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d4f130f-fd73-4095-4aa9-08d9da8adfce
X-MS-TrafficTypeDiagnostic: AM6PR04MB5288:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB528844A018D03A43F36C07F5F6589@AM6PR04MB5288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oS354rkGPGJEJLRJquwfCKqEpHSmIx0g0YP6D5JA3t68BaeUt88/tpu0ZR1tU46YDg/Za4BJ+ROzns3jWukrQgpV6QIr3WA7bZ571LVVLRVga5nKMtKenjmSYsLTO8IE+sjUj/2HgOQpTAUl50J2GxmxDpMHuMtuPq9OJUdbnW8naPaOMYCGame8xIoJkwdnNwyM7PYciGTt3DmmgexNM5pUi+z5UoFmnnwiKg+ESTId/l5InUajgEoWyXLFYvTIwl1FS7AsFEROKkJd3MWuHgU/LYUhGnsWu9uKO8NmWfNvVmy9cw6UO5mNFgpzIuiJYFvH+ApuaqFFkeisCFAdafyAoJ7FMHPKdWPRF/XJWQQMdf1XK8o4L0MS9p0dRan2zNFqA16ZOpsM2udu7xSqOR2O9iBb5kerARNUHWvjnSktUMIdG43yCPolA07CQ9X8nnk703GKfH4Xmpr1IcxTXQDcmeCJFZb3nwIGESSMd3Jpdmy4rk+1YZpZB0QriTIeAQr3myFAXyD6rUbS3gQyT8MaZJZoHNSklZQufKBNuYy/8xOZKGrXtxdtf0qMn3xzCgp/PWkf7obgCFSs+zM3aN0SS9PCXNRSZrd+dvrfieBsmEUOmPfj07j/Q52OlBObRZGyv9pEqC0twHu4HRA5Vfg/weQzpbAnz6yLZctwpgM5IY8g+PEB/VC6TFeNi2mvGNhC+pE2zWBmoLcaQi33bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(7416002)(4326008)(508600001)(44832011)(86362001)(6486002)(6636002)(6666004)(1076003)(4744005)(8676002)(6512007)(66556008)(66946007)(66476007)(8936002)(110136005)(38100700002)(38350700002)(6506007)(36756003)(2906002)(316002)(54906003)(26005)(52116002)(83380400001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZZaqbjXA/c5kuZ+Q7GXkZmKJh3Xf2lwfnTO44Lil+t8WByP/0LhqAk/MXFO?=
 =?us-ascii?Q?Jrle/BAjpMM4nhg57rnPvFE3/5v4rcpb6nWFcVFfHZow4txPSou0KE8MTrdM?=
 =?us-ascii?Q?I/uncc+CS7t7JHe1YIJqwB8a3kD1o/ub3zAgz6NnOssjExf1NEyHkxyXhTIq?=
 =?us-ascii?Q?iFYn6bKbM6crzd1/WHtWPFh87CFCA54aaDxrkVrPGdEnq7iQIpc4EBxa7bYi?=
 =?us-ascii?Q?nnSoS4oZl51NyhE5W81VNcrMql5mahFJlZ05LYLC/BZC40Sijupq+w+n66II?=
 =?us-ascii?Q?/ZmO64BMzPDvhtwJYrA4cnBqtL9y6uAlfsfmgIfXr8+vFw+ZL98ZkLbKS4pV?=
 =?us-ascii?Q?9AqDj8dEpXk/wP3C998xGmRd8cWErbKGmexAb9pJEwJQV7+ptzmr/AhXdEKs?=
 =?us-ascii?Q?1NVa8sHSLKGLNDj/0PuPtozY13Biq6AjkhAHmuDasARCLGzq+X/0pEM5kQOR?=
 =?us-ascii?Q?RCHSz+ZyAgFhCm8W75V+boxWiGZYIUBXFd8nG6QDCUsPHBLXGpU4E6whetaz?=
 =?us-ascii?Q?LR/FMcykdw5V5Jjh6CkglEEeI0+XL8vumwrHf58WzsyV1mG5yV6tEmY3DnVx?=
 =?us-ascii?Q?sdB1rtnAHkeKt5cRUiodfuQHSymYv57/MxSfddwO64IY7OpVUwG1k/8l2ygm?=
 =?us-ascii?Q?VhA7rXGAxg7TNfDzoLygsocellntaf47+JKD3VFBvkXVlygSR1ASPe0kdQoo?=
 =?us-ascii?Q?o6KOZRnkCh3E+n8ZYiOGF1ZpBaCGP7ePBFTroIwk/cPPZxYYzUAoXiSaxsge?=
 =?us-ascii?Q?RFY3UquosSiXgIOvVC6brLHaD2RFaSdAGXxbGILMaWTLxXRtrZDRc3/1/UaX?=
 =?us-ascii?Q?ApUHn+OqgJ+t/kWX4wRGU/fFeLTAAmgWLUY0wwb2zy2nfRyXq9u7Dan2KYM1?=
 =?us-ascii?Q?GuBhoqPgdTuTbxdCAwJaSOH0qJ/u0kpYrvCK4BFPoL4v8g0R0D8mfqSH0XfG?=
 =?us-ascii?Q?stWKtauMfOdxTCUGtirYGROoeCM6Qs6DTbToEUjedb/kav7qtJRzu8xYF/Sa?=
 =?us-ascii?Q?8GvEmHXCeWWbwffJJ/IrfzXZnaBvEpNpqpPJMOtbwJ5J6GsOXmWgh8fTviWt?=
 =?us-ascii?Q?r3iq4E1S3wPlFH0pWAlIIJWUSBPlLto3yn+DiMWW6hEzQQLaC0oYkFmw8E9V?=
 =?us-ascii?Q?l5++6ZzVgtswrOnjpPZ+Pc9xINpUbP9y9Jyq4Tuay1MbkrqDDqQTancrWe8P?=
 =?us-ascii?Q?Uc64YiDBkZ2BI1YrWXO5XaSk5AgA+q+FpqugTMx9rx4Ld6K8iZT1Af4GLlU0?=
 =?us-ascii?Q?tRtjeUqnrc8SvN34p6Mp0Mb2B4o6CxfyrfQ9Nylytr1W8KRMABoer4dQnKqm?=
 =?us-ascii?Q?dpOj46yt4ctkXQWkmAi0wjVZT0Ov9nh93W9MLMS1I9q73Urdh8zxfzn0FOdN?=
 =?us-ascii?Q?SDYJ8eS+/XTokGWRuGDMv/RkkoCDb/PFV1U25DORybmhfJ9eZPaZfVrceS6m?=
 =?us-ascii?Q?ccy8GKNsx+SF0sFu4aulJSiWUt68H2LwNKXNeoqEXtCVQ5s2UWzR2lcz3g+G?=
 =?us-ascii?Q?q5By9p1TKCLj+NXmItPufgIEeCO0vQGNDemkKV/xISeWA57JURfyjZulIWkY?=
 =?us-ascii?Q?z1ciqtzBSkAg/xPLT1wj1B6KU2eLPrDh3WXbH58L95pauIu/hHaSs61jARx0?=
 =?us-ascii?Q?wPTBLCpWAnzTjDE+r0QEsK4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4f130f-fd73-4095-4aa9-08d9da8adfce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:00:24.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRx8itviH2BfiVYfSQW5QEdlCDeMG67H4a0YXqc8L6d+EMbhXwuxa6rIni7D5SdoytmIs0LVnx64GYELCL+/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index aa83cbf56d59..ff364bd0fbac 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -20,11 +20,10 @@ properties:
           - fsl,ls1021a-lpuart
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
+          - fsl,imx8qxp-lpuart
           - fsl,imxrt1050-lpuart
       - items:
-          - enum:
-              - fsl,imx8qxp-lpuart
-              - fsl,imx8ulp-lpuart
+          - const: fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
       - items:
           - enum:
-- 
2.31.1

