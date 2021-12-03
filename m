Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA0467097
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhLCDRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:17:01 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:25706
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230402AbhLCDRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx2VwXhOKgMT7ctz6VNj8khb777+HoV3JyM4LO5+pjmCT9/YvsGtiHDpwNSSV9hsO8jPnztAg1Zena0U9OH+WcPnnx1InE0rlg8/xeOFsSzfmVLLarsKQvdaZj9AR8WEmyuhXhEn6WBau/jZJkQi4YCe+RY+2V1AkMfs8cpdGMBuXJlNsXNhLqnZ8bWfD6X/RxnfdNW0QynOOA5EnNeYSwWQqet8VfAj4wPArBWFckNzSqAj2mblQvrM+XA7wDo/z9UBlvsskI1dtnfwsbnNi3iVXcYSnsbT6jWMDF7zKVGo/lF1dsxl+4MDSn9fxbZA9ljY24gl5+ZjvIfu9meh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBktfGKQMpk9P4cPpaSUg/w0O6wpOTKbF0MJ7n1Dzs0=;
 b=FnJlWrILVI6Oenf0SxfkM3IYTTHhVDnxB3g0U9P20qh143YuEMYIf3ekrgkUtmB8LcyhoFFybpyzUL114/blgyk335PGVxVM2PYrU+nPiokLu5O3lQTBr8vlx2uQElSjCeC+rUGuTbdXmk3Q/EHGZ+MvOMbMGIotY8/7rg/8m7fm4o+aW1O0A6pah/zVrKPvewxvRKM9jTIXAEUeRpCcHmhnGdx+0JpjGtJrtl7z0wEXT/vUUPyvbqXPzpsFQ9dii26XauN4CmVCKyU9UMO63NV7wZPL8CaAsEVsbZPTVe4kU5+IvUsG2rScgwi1BoxB9zdl8wHiPqHWUbOKLXS0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBktfGKQMpk9P4cPpaSUg/w0O6wpOTKbF0MJ7n1Dzs0=;
 b=Nc3XSm6eu18SdZ+v5cCBlrRRquqKCw5lQcMeZqSvVsGj8KShLuhHXn9ZIRsUu8P8O8azKgiOEYfjiVVRP5fTC8PuXcjZD8m0X3m+ScVzhELsP8tIPvitdKqyOZQGsQYElLooHxFXSTloqE7F9IOXEbkZrx+2SuA7qhJZNxp5IXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB5328.eurprd04.prod.outlook.com (2603:10a6:803:59::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:13:34 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::556a:6dfd:dc0d:c407]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::556a:6dfd:dc0d:c407%4]) with mapi id 15.20.4755.014; Fri, 3 Dec 2021
 03:13:34 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, krzysztof.kozlowski@canonical.com,
        linux@rempel-privat.de, festevam@gmail.com, tharvey@gateworks.com,
        marcel.ziswiler@toradex.com, jagan@amarulasolutions.com,
        dev@lynxeye.de, cniedermaier@dh-electronics.com,
        sebastian.reichel@collabora.com
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add ls1021a-iot board
Date:   Fri,  3 Dec 2021 11:13:31 +0800
Message-Id: <20211203031332.902485-1-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0017.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::22) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
Received: from Ares.ap.freescale.net (119.31.174.73) by AM9P192CA0017.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Fri, 3 Dec 2021 03:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe6ad0e-5f9c-430c-464b-08d9b60ae42e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5328:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <VI1PR04MB5328EA20AF4160B8ABB77941FE6A9@VI1PR04MB5328.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R25uTIE+zXevZTGGH2P7lQIbsQt5cn7p4pY3Ohrf8gbidW/z7hu5AEIk25jwqWl5T0Ui//VDftMAHgIieBPSLuELiI2ooXvmUp1aiq/NBwn0RIt9rt3WprE7WGVF53wtdWbJHoxzMFB5Pj0qiKxf6LbLA11MKJgLlClQS7rvLJwXnfcY6hAHOlFhIhABB3jYvzDmUQaH/4eusF69yRRV9jEGXik53aLxCEnoob+YtmZzz5zR9PXrthezOLUIP5TFOevnSn+NgELszYzvs11BMgRMkp4f9a2gx/3aAclxkN5FcD5g/7hNsfldGja8ZipcQO86ddF0GZpMUoDLNY8CRYJ9FryAzNk7Rr0+2pEzik1uekwEiyJO1DYIBq+CDzS0A+e3l6XFGIRH91OIyi5M0qYk2D1MMXIvi9uXmUEV5DtdJfhLgauegCgEsuScd47+/0RmLr+44TYheAluLFqje6JBdwXhnS6OjI6japqpmJyU3dZ68cF4JXAlXZlaQVB5ZqlC6AKXpVUztEhNqktbr0i+0nF/RAh7ad8EAYIe7jYGwpE2NGvUWPIUf50HSAnToAyxfbWDSyTsHMwJXDTVaXbirOhLKF9hhk8K2hK0wXFMTWQmgaEeW3sM/48bDm+a5pAD2K1Awrm6B7A0qEIsUGNwZAia9kxtoKw0SD6uO15upgxNHSYlRBt0QIGh4FvKHdZ+o7BUHLRAWrBBv5hzt7KjkziGP2ZGnP2U1Eee0zE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(26005)(66476007)(7416002)(66946007)(4744005)(956004)(1076003)(6486002)(66556008)(6512007)(186003)(2616005)(8676002)(508600001)(921005)(2906002)(36756003)(4326008)(8936002)(316002)(6506007)(38350700002)(52116002)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpEgyjfwwMfm3sKbeiKSY3PVbBeI3mDxhs4afL0i6NWKSlS3WwAFucWmGzOp?=
 =?us-ascii?Q?hGgQTdnWvFRx575241TppwIoheMmb+uvq+Wd97s7SlbReTAia9Ol6NNnBmlt?=
 =?us-ascii?Q?O76mwbT6adcqUrk9tWZW1Z+nl0Oj/FXKx+SRRHWF+VCup4jh2u3KRwjiJerO?=
 =?us-ascii?Q?q8UE7JMHGMcwjvV/FDK7GRS1I+3DU8KofBQIewLZwVli0sxtrCRWElRUNAuD?=
 =?us-ascii?Q?84TqJL56OXNCvvNAnUjrjrMZag7S54zFOBtJ/fScvjBU3y9NmXqe/59ScZHS?=
 =?us-ascii?Q?uADrA5IL81q+TP3+O8Y7pCPcW7/Yeb0nDzcAmZX19Lji/DmAmfefwG1q/WCb?=
 =?us-ascii?Q?mB3EJmC8+pXC3hj/t7jLj+7rXnkEb16YHYebNqRP3d64aEVSEqF2DHgMxFZ5?=
 =?us-ascii?Q?RxkS/CO4Tns6g6FGEuJux612ez9skFpw2yEP2YthpjOAJljTw5qCgt0jGOEm?=
 =?us-ascii?Q?S75jwK2PRiQkm/orPNRt1WAFln58EQN4FGM0LekOCbxJKqNp3cyw3rFAjFWK?=
 =?us-ascii?Q?fbif4u6euzLMZMSkgG9Ll5qLwF6EL8xZfJBY8zyVqrgtogSIojfzjUTAcPeQ?=
 =?us-ascii?Q?X973Gb6MFn+pbKJJe3wdpQHe+EYUZw2iZqW5XAxa7f7wIwJA6ybNX7eoOTXO?=
 =?us-ascii?Q?jUMNdn5PHH6lPostOVgGzZQZYuAyhOIahPKR2Nv0o3/GficFthQOeQYYRGAi?=
 =?us-ascii?Q?bBWqYPJS3hFk2gKS0da/ucPix/s6vDvpXEgeFxkvsviV+bkq4SaguJ++wVfC?=
 =?us-ascii?Q?Lje8Q09Yf6IssuLOiQMCC7ISXj2suepJKw8ulaBHuSuvy84xRxbO1dIc5Seu?=
 =?us-ascii?Q?q4M2k49JmM0t+3yWVyXw4Zc2/z6nOSSObbmDkH+ZV33nB4sVrHkJSV1W4J2f?=
 =?us-ascii?Q?nfoJE7wLFT66/KJwule5SaZmgpobrG25fljOxIWOhIsGcOZaTxYrdS8uyqBK?=
 =?us-ascii?Q?gB40fh3nXL8o615Au40MjfLBA4ZC3FPDY2EpOe0b22g2fZMjlwZZZ+NxSb9z?=
 =?us-ascii?Q?Il16hnoUfl8oWVmjGYD06OFVyWJ7cHcdTABv0O2ln13NRCMCRctxg7iKTZLt?=
 =?us-ascii?Q?9z726WzdafWKbAlIwOEpjGRfNL9b1ftkvgVyk8t8WkWj8xsxF5cYaHnazygE?=
 =?us-ascii?Q?rkM6RFb00NotI0mSBHFlP3UjadhN+bGe4amh38FpX2Bj2n0vZRlmZSmsHExs?=
 =?us-ascii?Q?i9rKIFY06yXOpN9jEUaxFy0+Yo0uzXX6xHy8GF+XOOjHEX0VKCoYlBgctURF?=
 =?us-ascii?Q?PGxQ6/e6C/YTU8eHOmvU/20FJGC8vneSgqPqCUVhbg0+SOOH7j1DTlulesE4?=
 =?us-ascii?Q?qwjCtkZwGnzjRMk8lhcJMSbktckZaIJ9crigU+/njFkVyH5tWSQA8xuvoXF4?=
 =?us-ascii?Q?Z7GqrO+VRA3rl+UeE2GQALd8o91kUUHNs2TLeUi32IbGiPg0bAyfOGftDBXE?=
 =?us-ascii?Q?0A60cBOXnonyv1ZcSZWf4HYBMl1D1OkoWe6ys9EAzoB+b0dz2KRDopq6eqEK?=
 =?us-ascii?Q?JvpRrGQ2yF+g7p9zv/JTiUjGnV8m2DfXv3BmCMg3HY+7BJ2USug4WhmUpui1?=
 =?us-ascii?Q?bBzbOkl6TTjH34qolXe8KHjTvnJVhgT06HpA6rFsnt+whZnf82i9OElmk1gA?=
 =?us-ascii?Q?P+6mND/xBkI/2JPazanRkvs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6ad0e-5f9c-430c-464b-08d9b60ae42e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:13:34.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w23nqKrfXUHtAWrG95ynenKcZlZQim4cClw5c4dWMsLy9Rb2DVFaF2fw8ZCuXJYfGBlMhSOwg8OhgZfO8KGu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board ls1021a-iot in the binding docuemnt.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..8b3f5d598ae6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -901,6 +901,7 @@ properties:
               - fsl,ls1021a-qds
               - fsl,ls1021a-tsn
               - fsl,ls1021a-twr
+              - fsl,ls1021a-iot
           - const: fsl,ls1021a
 
       - description: LS1028A based Boards
-- 
2.25.1

