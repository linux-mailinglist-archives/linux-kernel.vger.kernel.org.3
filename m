Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AE5503DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiFRJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiFRJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:20:54 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130045.outbound.protection.outlook.com [40.107.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C026129;
        Sat, 18 Jun 2022 02:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ9r0WmX7C6rKVIFPHDA1nCi9X4KS6ttILDdp7luKus0ZtHSrSrv9Y7QvJs+Zo0J/FKNfSdJ1eriJpJynsgSC0VDqIDpQPoiInteIuCNRWbRN5h1xUocJt4ZHabJUqnn98PrdG2L0WWrxAXfn1PxebQfd9o05LkyOq0m3CAOU//EuRbdwRFzpqssP3vD/8QmU6uVWB6fGKicVMv4x1JdNLURiyiiRqN2R8h0+If8AKIPzMca8po/uFwToqtzmhvOmYmFO9sK6OlFhA4EWcE1uJlpmJv1B66aM7NyaZg7j3CI186/LXFw6+WVTX7oPWDH8MJEq1ezUwPotE0unxE3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orTU/AI00/zW9or4fIzCB3hq1E+BQbroMLUhVVLi4bk=;
 b=HdBRL2dL1kEzN0hgDHhx+WefQzwZhj3qLLaS4XcUudNTEjICRICqhumGqwyV6syZ4ITZry7lspSclzV7SlVlUCLzqaWbI20Uhaf+gt/SfGV62pX6vrnEzJC5gDSS+dE9noYuZruYr6I5cBTTSY6nJlctHFZLeUR8rWmBSLKW/hjqVkPN56c5Sb01jTLWFmQ0nOWjMMUspAjZJ3mbZ8wCCrZy/RtXskvYYGBee7sehEmaaPCpWwqrcbYj4Cps+8r7dM64EiCQqDKB6VKfZr1JemsQjXo+dJVzUW3dxdn6rePj66jb9quyrOon1ePjxMcLjI2gKNOCt9P6mRFVamkLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orTU/AI00/zW9or4fIzCB3hq1E+BQbroMLUhVVLi4bk=;
 b=anIYM3reGzp2xqU68fhzT2KfiRscxpaNkc17NQXjJwoKVJdPwXaB9B+jVavdPA4PWe7Rb+t8fjSWldqCU18ogDVTFleAGN4KnWRBSpY2zK9660urQAwI9JN2saEAypvz9oWI9Gy+a4oJHqwiCsUu5kv+tS/+bV4/SXJG36xrZ5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB4209.eurprd04.prod.outlook.com (2603:10a6:208:62::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Sat, 18 Jun
 2022 09:20:50 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 09:20:50 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: [PATCH 0/2] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Sat, 18 Jun 2022 17:21:59 +0800
Message-Id: <20220618092201.3837791-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9b5bb3-1034-4c17-61f6-08da510bd5c7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4209:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4209BD13F870113C38332F3D98AE9@AM0PR04MB4209.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxkNvX2C23v1Eqc80jV061fAUbKeOFyvxM1UdgGxezyXoqUAE9SzjUt6jJooTX8nGyCBaUSDZemXIPs7Mywr5zA0HSDy1WeC3dXHGwmTxT06+qWpm6f4i39Fo08nQw1rV2J9sQ56J3ldT/gFzksz6OrVRX76sq9onrkeX3BbB3OH6Oxs63AwzVGpR8vXXIobyu0sUcplLQz2nzZdswGZPM3n/iwFF3ad+O5sYvow0283Xh1Bf34S9eJfMaEmDPDENUW3VmJVMGbNwV8JDSW1qiFNXvTT7p1nYNiUQA1Jd1L466rZH0LUdNMFHC6oJEKdJAJEsL5uk8pI+sG2uOLegr0AIlpQxvvY7GoJH/GGxpvaEnJYLx/GXM1DDT1m/IlmzQRI9ivXq+zBGTMBejCZ3ZLugcFsoKevd8t5HErHMDURxRotlJwDA0JqSA9e+pvOCdtNNHoCn4XYoVzgv3VO5HTeZyCi8hiLyTekfmDKAyqvpc4qgWLXY2XOH5aRsiKD0eBs5hGy0EXRNoqML0rHfaQeI6sSy5kC8/FhHpfCJ1Xh9qo3mbJjCPEaT5yPNbajqXMpvPa9EbcKwIw8XweajCTf2Owe9mmKSnSxksBkQI08a9vGjpAoCKguJxOx0Wbg7MjRFaCr1Mzg9e3duz6dbQQSyJ55jXA4tHB3fWqsiebR8ZvF9jFlb30fq1r4jmiRPQlzQi0rEBUK1JzRDt4+Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(26005)(1076003)(38350700002)(7416002)(38100700002)(316002)(6512007)(83380400001)(6506007)(2616005)(36756003)(8676002)(52116002)(6486002)(86362001)(2906002)(8936002)(66946007)(4326008)(66556008)(66476007)(5660300002)(498600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qLdTEdHRXHnnVAG6+f+OVpBKAoTsnOP5yTRU7MQKC2D+qQ1yzZW2XYuQRQb?=
 =?us-ascii?Q?BR546dnekJKF+6YkhUYHeMB2GNM5MamNqwIer9EIgvZNYP+pnv28w8uO/ASh?=
 =?us-ascii?Q?Ks09Tcm8UYaUuHceU9h85GngDVpa1ARH6iM082dyp86ATX233Vo33KD+rtoB?=
 =?us-ascii?Q?CX3VjxurpuNFuH/BcOn7Mh/9qZVnzY3ySHEMAAz3uYEHIeXFUv+TgV+CKycd?=
 =?us-ascii?Q?hFMXjG6SnnKRAfRvJq6/LDAUax1DXAby0/WmVbqP5Qt12TKKCJAwoG3irnzD?=
 =?us-ascii?Q?sB094vVYTIld14kLI69qPSiOMeHahlrtfk6/PNNWfYJ0hAPnB2/YpDCVcK0v?=
 =?us-ascii?Q?2A4/ZlEx8aAzxyVVoAHRoNR+g0Yu2ay7P6Q2k/2iZNE9VK198nKurpkHLAR+?=
 =?us-ascii?Q?RBvmg/kHvXDZQlmwizRz3ovE/sMIfMSvbgTMNUgRjvVpZi2ReegkkqvynivK?=
 =?us-ascii?Q?m1Y1PeQ2AjG6mRvYSHZl4iIlT+cXZw5AiA9qFG2ygFitWp9Pjn3GNB/tWbnu?=
 =?us-ascii?Q?KBxWzy5Iou3UAnOLdHXJP8bTuYaS6xnrOR40lKO4IKiMFA6IPctnPssA8S4N?=
 =?us-ascii?Q?hQDHIR6/84kqLi73nLwY3vMiuQ29UOofVDziSPWG93pIIvwhRLlMDvfQZ2pa?=
 =?us-ascii?Q?VJkhl8z2Npgeu5XW8zcZVxQ1QWpymBWZCNzrb5PFiCpvATZdZpOPL85+Voqz?=
 =?us-ascii?Q?vYc1ynBNdDLcFIhsnIwKpdfeB4h3+azc45Px79lWt8yTkgt5Q8U9ESr3QEkD?=
 =?us-ascii?Q?WePlFwQ+uh0NB62fuCdegsPC6pxgVxZ4KY0RNTNI6ksw9wJdTpNn+IVaRluz?=
 =?us-ascii?Q?9mvAw8uy5R0yj7KiXScXb8kKJQTccvk5d5yFNoa/+7tJ/poqLx7IYOzbSObu?=
 =?us-ascii?Q?iMEtHuc+XxaMgwaWwPgeiSHLl2a23mumaC9W0CNqFo7Ug1uG0BjY9BgJQcbj?=
 =?us-ascii?Q?bqONP5529Y+P5yBRpKJFjem7nL2RvIQcI5zQM2VuhUhh5TZKKRWaUN3VIixi?=
 =?us-ascii?Q?C3R73IMukT4ylvxyh2bTHMmYHXnia0TvMeSUBJaSxvKGU8BHzECBrkYHeG+e?=
 =?us-ascii?Q?zVqIt+sMI4R1KRUlCgnt/dReHUgDrrN3ilMIkq3ERkzEt1g80f3hO1J+JtWZ?=
 =?us-ascii?Q?5d+jUbK/hyKse55KGAKnpZ1W80VsEh+9ESj/r+9c+gXdRfrFMrL2dC1OzDuW?=
 =?us-ascii?Q?2l5vwpDo9AQir8ULb+InT+XyrhdYpRj76dt9afFSwyjoEy2JhfyEl5Hc8Opv?=
 =?us-ascii?Q?ZdcrMmCD8WRpRsJdh1cDzHnLsGE98KF+xqtxBuS6Y4WQ/PXng3T3tDP2294Z?=
 =?us-ascii?Q?dS2TzkxPd+FXBTNC6RWwF/o8hb5m1K96cauy63Sbd5c6EW3mrU0Lub944Z5N?=
 =?us-ascii?Q?dWiq8Sqp4a1fJPxU8hNec3YEslNEJPZBYnxOCSn0P+TxKbFcMNSJi1vVsHzE?=
 =?us-ascii?Q?VbtKLgfWgl4is4ww1eybLwbmJhnQoTJuvHgTE3soSPdpXFw+jR7qo5stoh6U?=
 =?us-ascii?Q?7LEXzrnxznT2X8V5hjsxTL1FrNrIjbMtNSc9pB+kE2rgYwF/eyg/otUOOOED?=
 =?us-ascii?Q?bsOW+1uj56PqmaFb1QgY3KnduTEDjF5NplbvNblGMRGBIZlJDWDnCzMZhlYx?=
 =?us-ascii?Q?UHhn1Sal/RU+i7Df1MPqQgZrIZs4G0xM1xQWNXs/tFWFFKQQ27nH6GxPoJoI?=
 =?us-ascii?Q?TX+SKUMgGwxCW7EFzXp4HNk+j6fwi9v0/Yy+k2FV7Jsx83MWogTOqZM6sChb?=
 =?us-ascii?Q?SbF+99YPMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9b5bb3-1034-4c17-61f6-08da510bd5c7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 09:20:50.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09xV1yZQiDo/cMC9MAeiuQ80vhF8nTRG164VLF5bTYFN1KoebvPtj8rcC8E8N3R6jz3ZE1pfsgsmzx+tggGX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qm LVDS PHY driver andi dt-binding
support.

The PHY IP is from Mixel, Inc.
The PHY IP supports two LVDS PHYs, thus two LVDS channels.

Each LVDS PHY may work by itself to support a LVDS display device.

When two LVDS PHYs are enabled simultaneously, PHY configurations and reference
clock rate have to be the same since there is only one set of PHY registers.
In this case, the two LVDS PHYs are usually used to support a dual LVDS link
display device, one as master PHY and the other as slave PHY.

Patch 1/2 adds dt-binding for the PHY IP.
Patch 2/2 adds PHY driver support.

Liu Ying (2):
  dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
  phy: freescale: Add i.MX8qm Mixel LVDS PHY support

 .../bindings/phy/mixel,lvds-phy.yaml          |  64 +++
 drivers/phy/freescale/Kconfig                 |   9 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 448 ++++++++++++++++++
 4 files changed, 522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c

-- 
2.25.1

