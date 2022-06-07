Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9053FCD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiFGLE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbiFGLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FBE9C;
        Tue,  7 Jun 2022 04:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6cFcgCURcEv6Sjkw3Xfz167Q3iRHt6d2DNBJuXUs5rUlMPDu8e7j7ZnOI9MTv7rTl1MX09dfIp/s/UUL2lYiNS2ye43yWDo2/1MaFYDEtD74/MQ9eBUzV4B76tk8QdpWMiJCfonThvV204mkuWYmryT8gq0v9pusEivgOrgSOJPar4iBRNS2rI2lJxyCGzaJZn8LRPKz8nMFa7Nomjh2zatXkStxMcj7SPNhDodqkRS8zBN3fPCtBAfdudfYcsQnplFVspLieCwvnaTBVRNvpx4Im9FEsnkqY8Bp/HwTRN+yV/labKJF/a5LZoOFMFV6X2UzJofrdQmmWT6SiBhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJf4EsoyodrX/XpcoxGBZCLLeHTIeFP2GkVtgZiAuH8=;
 b=ogyTVhQQGDkJYTRSWEwS/KppRCrVScdUNCKLilBESEu8O5SBE+MgXATDu/RM+tk1Tt+L9M49wv5SY09F+N9S7MJJhNgju/g0UPq28mRRyS9U/sFtb0oP+WyoBgemaIQwAiwHLlA0ZwpWIRaczsNuS6K+4nX6g8VM5KQ9SNWX/AfGcyhWpet6g/ZJZSXpPri6FWhyM3ilDF4ThuAJ976VxvOvn01AnkeggTybiN6JMJi/YRa0k9q9C0gkya/3T8RbcGqP6DvYXZrgwvCSVkfscDRJDRrXcC+B24y0ZTQieJclKs3bEmw6aV5mpKpcrzmxrkQW1xrPDPGIs2Agywx9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJf4EsoyodrX/XpcoxGBZCLLeHTIeFP2GkVtgZiAuH8=;
 b=lv2ItsAQiZBaoZNMSbAwFJNWpPQWWVxwQ662BJAU5h4X1dh5EFNqNFTnROw4LGK3SYmkoORnDnwHn+mYELF5+RxUTKn5VBEk4Q9ZNjE2FvECQ/nSnZj7H6bbqAkvtpQtQLBxfnJrVa5N0rBYE22oyAbZwYXrTQyAGCuMhwFjzw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:08 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Tue,  7 Jun 2022 13:59:41 +0300
Message-Id: <20220607105951.1821519-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c670be87-3f5b-405b-0dd9-08da4874e2cc
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB3008BDF8AD17941456B03E11F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUUReHNRvuMapiUsWtGxqPdeL1vd25yhk9S/rEbv7A7IYDC4TiCHTuZw3c4VQ6qJ3ZAkEqffnEQUvqRFvsfeKn7nUCjOCb5vps/gv+PD1NUnEe66QlA+n5CvjReN7X7/RyAEI2g+jBq02P+9C8CpBI1Ns3zD3mg9cWW+dUgu7xoG0w1ImKaW52Sfw1hd9CjZ2MtX84spTM8yRDdCOteGNBlJuoidSoN2Pko6sl1LPmjErkQZwisyINTwK8vWElJushpAbQmF05/7QPvtGPn8DHoy3DWRWqlQFMy4zTgTRoqvZXfT+x3/7CwnJc/Nu7Iif+Clqih71NO5WErgm8q4N91ebirZZV0k8wLUyi/vc28fMaQ9nvgjTS0NgVEwuv0wKE3mcBtJMqx3qOUBuf0SWH3iLzvo5avHrDIxcMB6aPAblUHVBQI3GsEZsXO3iljrTZx0jsM44D0xETsrqn4p6DmKFlt0PfsJgSfsTn99dvnkaoNrpHa6PWuCmQcek173JLdBdhd3+QL3FYx1qzwEioTcDHxfq6U3JVIsVDAWTPgbHKAEYw1KX9j9DaOQc3wqX6htwOibgaaDCaUHWH7pfS3/8F2PLJE9AeKtw2J3XbynydWdx3lpKH3HE4+giYT2kSNld4E/h5aD/ufDaoZaZf989TkyflaxNMxJLMFj1godFrp8+UrgZTRHI6Wsf+Nvmzv/FVsd4GX6PwFhtlepjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/GKpB+/YEmwHY3CQNhGzHqqQpu+2baFucvhxglwkjULU+b73FiixDKXx8F/?=
 =?us-ascii?Q?knAWGE4t+Zv6p3oX+60GxRIMdNCa0kcilTQvrDAdAQYx71Ou2cr8uj3wcpJD?=
 =?us-ascii?Q?NfZ/AvMuNYxcQcV7+6YmlN0ufCrTEdds16xUHKmrRZkdLflD1OCpWiZ/S1JA?=
 =?us-ascii?Q?Mic89ULWbzNLLP8dNGj5XQRION6b9AoGhUhW1O4IGBAoJJFe6cP4jC4ozx3c?=
 =?us-ascii?Q?G3ycNVxNAHdFolDNvBl4+Uhe4qcwsvb3y9qDtXAAQ63YlgO9AfV66Z30I6Fe?=
 =?us-ascii?Q?WxSvHH2NSEBR7OHb1izk6k9LaOWS58RsDNQ8JvAXbKpQMtxBg5vQ8JZer/je?=
 =?us-ascii?Q?A+44VPr3ig4zWBJvY4tQbsaPfy/G4/3FDn69JWPa8OgpVznb6gik6ybi49zT?=
 =?us-ascii?Q?YE/YPyCScIczFIr8Maze+G0ATsozvDsrY8jfezBy7AuZamsiijzPfDbni4d1?=
 =?us-ascii?Q?mtKtioD6tMy3ZEfmzWzfY1fZCC7BZdtedwhH5CLbcjdd5m8XmzswLqJhiFyv?=
 =?us-ascii?Q?D2FlMK9gxVW2U6ZN5Pmf1bCDkXKuCO1hB1zoCDx3AiV/k0EbK6f2xPHzMKP4?=
 =?us-ascii?Q?ySmWwFVgViIslvPcEINf1FT3s17HlYF6zbjtXbNPQhztNrA4J3V+hsE5mFPa?=
 =?us-ascii?Q?NAg/itEUSQfZt3It6q4nLYXBo4vLP3WLCgtglvc+ypj/WaSOvJDSUjlXmu25?=
 =?us-ascii?Q?6qaEMEHG1ftrvgLlzXMNqlkl/QcjuDTcn5gja8TSLSJSMsu5iPTJzaSFH6GJ?=
 =?us-ascii?Q?EOpbggVCc+x3Am2Xafit4rYQy25Ji8u7HQFLKkPdMzw8IqdCww88e7d7wwtd?=
 =?us-ascii?Q?vbulkb5jY+ap9KtUN+eVYxvWqXZ6SRwPdkjB5MVHQr7nRCTaNLaFEigwHu+4?=
 =?us-ascii?Q?vEAnZ0D5CbkMUwaXA009apoAUk+05XKa0d5BvwYbiGkVHy65tNUDUXIfVHQ4?=
 =?us-ascii?Q?ClLjarvxWQDkMIj+bd416N4qmM2VWdKoaw0MHATeyFuCiWyxH9lyznrBZ1rY?=
 =?us-ascii?Q?qdKZpe143aksAAhLxoy6n1TZOAPpDEXjPrIKuITDSI4k+4TadIb7Bgd9SBlA?=
 =?us-ascii?Q?ff6eUfC1Vq4x9Mw7758xP45rpfDNCIpBLE3Hj08CUNUCzuvXVAsA3wMKMHrd?=
 =?us-ascii?Q?c3wTdk4TKYgBLXR87MgfGRTCqRI/p4ghKSFBinR0gGTkjq1G3702SCNY0IHA?=
 =?us-ascii?Q?hWBqo7tWRuSskAszOdI5LOkLssECvVsBXokjgchR+Tg3mhM8+1guF+eiAlYo?=
 =?us-ascii?Q?pGixOKymdKqFNIaSCX9eTcaTT7l8fym3gVxxdkP9AzdHLti6/cpnQquGNffv?=
 =?us-ascii?Q?4gKmQOlqRynbQ2QuJn2WJDMWgWBxf6Rs08TMRKeUZRyUel1Eb4+chnQggCY9?=
 =?us-ascii?Q?doJLMnAvH7fwK0L7N63X7/WHHak5gMsi5Q9sIx89Tq2YGtqfcfQXwWDfzaoJ?=
 =?us-ascii?Q?qjh/p2xNsTzsQzB1ZTlGTJO5ZTqrpStQ5gEKSDby+IQWQ2hDHEJRh62tTUsQ?=
 =?us-ascii?Q?cPdwe51vnO9InHbEaCM9JihfzekxcD7scsT9z3y27Ubn3MFbJOl+/M2F3YfR?=
 =?us-ascii?Q?an8o4URWj6FkM/10JHlOpJYHWyOjwsRBTiq7URKYtNJpcpc1XS/eegrMXwtd?=
 =?us-ascii?Q?8I9A31Ols9MAu/sQT2tw+zYcTnp4shI6qbZRQRi2qifXSUVZdPH/GEwpaLrt?=
 =?us-ascii?Q?UZm8SxCT85lu0h+SS0kMKJwQ6oPz2kYi94f6xPW773FCGoaMjkYo0eYmnH+T?=
 =?us-ascii?Q?X8CapFwweA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c670be87-3f5b-405b-0dd9-08da4874e2cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:08.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPzY5uGz3kquAOapA2NiQEqlpUjod+eLi/G+w4im9lilsNSjW6FRkR8fjTQ+NcpAl8Fp01G2q3lI/5HqiM1TgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset splits the fsl,scu txt into multiple yaml files.
There is one yaml for the main SCU node and then each possible child
nodes has its own yaml file. Last patch of the series removes the txt
file.

Abel Vesa (10):
  dt-bindings: arm: freescale: Switch fsl,scu to yaml
  dt-bindings: arm: freescale: Add fsl,scu-clk yaml file
  dt-bindings: arm: freescale: Add fsl,scu-iomux yaml file
  dt-bindings: arm: freescale: Add fsl,scu-key yaml file
  dt-bindings: arm: freescale: Add fsl,scu-ocotp yaml file
  dt-bindings: arm: freescale: Add fsl,scu-pd yaml file
  dt-bindings: arm: freescale: Add fsl,scu-rtc yaml file
  dt-bindings: arm: freescale: Add fsl,scu-thermal yaml file
  dt-bindings: arm: freescale: Add fsl,scu-wdt yaml file
  dt-bindings: arm: freescale: Remove fsl,scu txt file

 .../bindings/arm/freescale/fsl,scu-clk.yaml   |  45 +++
 .../bindings/arm/freescale/fsl,scu-iomux.yaml |  32 +++
 .../bindings/arm/freescale/fsl,scu-key.yaml   |  27 ++
 .../bindings/arm/freescale/fsl,scu-ocotp.yaml |  40 +++
 .../bindings/arm/freescale/fsl,scu-pd.yaml    |  32 +++
 .../bindings/arm/freescale/fsl,scu-rtc.yaml   |  23 ++
 .../arm/freescale/fsl,scu-thermal.yaml        |  31 ++
 .../bindings/arm/freescale/fsl,scu-wdt.yaml   |  29 ++
 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/arm/freescale/fsl,scu.yaml       | 185 ++++++++++++
 10 files changed, 444 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-iomux.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-ocotp.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-pd.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml

--
2.34.3

