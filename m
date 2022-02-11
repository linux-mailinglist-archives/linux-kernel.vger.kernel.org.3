Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25E4B1B80
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiBKBoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:44:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346976AbiBKBoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:44:19 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D85F93;
        Thu, 10 Feb 2022 17:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipv3mScO0DgXjrdEf3FdOUwxUjZTxA+LcrwiBepDgWksIoHskdAGR7965q2U8wTZpBZIMUgzmNVuqk/3q20bEyb6qbNAkvs0DVYKssDdmLnzIBIeKErt+RdpxI+YsEqIwR9WwW6AlEOi3Qxvtocd1krofDBan8+P9sJrS4B4fz8GtlNIHwEhD2jj2cEOgUBXiaBnTXwgSBhyk4XIVAlaH8Oh6QkZRNfawlZQuFSjHQlp7cyAj1Ej1Kaa11muTa+OIxEVIjhEzIOe9wEkdU4B5HLMCP/yaemvw5zZ0ljImcihhDrofzRTDRMjfAcUkkB9BM9d1vo70w1Vj20b5vQP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USuiXqwkT2aalpWAZYhGx9np6+iRUOMUCiv1gY0IuMk=;
 b=oSINlx1h2tyBP4jFDC4aR952MzYcfGpj9vNv29vxd3GAxPYOH47rc6CpTFVVedTeZcHLpPsOmGAI9LNeW/eR2P1tl6IBSBeaNc46S9L1bYwttkTl+n+/9GhHQ2RIOFafSCPOEehyC9a0VO62bWd4dE1AatQaCIOTBz7urrU2uC1WnzlvIyPLw2Yjm3jGE+zB/2XB2ASV4GtmbuMv5A5Zbow2YrBIGBOvXpE2jom8wcsBwGFKjkbKGl0ljFxBEgutEqND59lUZ7zei+caCq7PfHyhpZtjLTE4Yo2KXlwPCsAXC1mpglvK949RJtX6AeS2BiVPqGJZ+vwp+eJh8d7zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USuiXqwkT2aalpWAZYhGx9np6+iRUOMUCiv1gY0IuMk=;
 b=WN57OIqF/ol1NBX6johva/JvVx9DzfE/cfTkI3HJoCdzleYOfGkMHFVAowqCl+sWoeyzgAQ08iTRiz84IhEpwLXVntweiLOf9bWkTtXKWU2xfyIC0GvFFfoXreVIwkF0kc2rZW5DQK7kjoJ0Vl/fyjIgq5S+N11ftrfQdQsRE5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SG2PR04MB3577.apcprd04.prod.outlook.com (2603:1096:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 01:44:13 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 01:44:12 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 00/10] arch: arm: dts: update Facebook Bletchley BMC
Date:   Fri, 11 Feb 2022 09:43:37 +0800
Message-Id: <20220211014347.24841-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96a2db37-119d-443c-8833-08d9ed000120
X-MS-TrafficTypeDiagnostic: SG2PR04MB3577:EE_
X-Microsoft-Antispam-PRVS: <SG2PR04MB3577C832ED8C5A109C8C5AC18E309@SG2PR04MB3577.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tpRFyT+/lBKMqg0m8zvvlL9epek3BbxJUOvdYm/rTWRKTEFDzwV4OQQAaBRtjPQWekhQr19DYt2Nu10EHP+O3AiSacUAlldH36yPDTGavvWKAxvphTycC0eRXNluqRZgKL7/HLG22pi9eJ5Ut0TAiadXB3weOO77H9Nob2+8xg7FVPK3CDEyGN8EmWB15oFz7ElGDs3AeE/kUTPDmGQgvBaGft1jxgVmXeGo+tvvLRsSn5wwJxFZMjiSMOKeWxmNiyCCkw20aovhRGdBrSAZjMmfklYqMJ0qwMPj8OndRQYU851bVNcB70SkOPIUcuMrrfx02GTbNi0W/wLwvRkuw6phKG8SIBu9Lkem+xGELA0PmGXjLpuuBuRSiQVyZEpBqfzN8mPuEe+j0/5v9fbhCTaESCGGBXyxqWZUHhLsVquu2OW1FykY6Wsl5vHLjwaoCEVWy9mPem4AJ+NaLI1zjBsIsEEUzH6mu8vNkKPAi8T2f4Ola5sSSSXfXwukWqjB9yd2+PfRudW8nIZSRU8qbQ8dNkZXuHDC6qfMrCxh3dSKiTfTk2xyCmTAcezd+Xe3S1ckxUSfKNunVEE7x7L33h7INIWBJ3SnGXtjkccvFWsTlfx+9iSLIBNvCmFY/l697urrsEbux/y4kEAFBYM/eHPhsGOIy28KgDORvLTVGbbhrULlxpC2LZc4S7jm1NQT4xFL856m+l/FXGrvfMY1Q/rXDuJi82KASB4Wn6DiEN0T4e3uAvDc47tkzmX4EuN1hrolFbrxE0NGmrRNTgGEciNVDvJE0Ycp2g+S0BZjRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47680400002)(5660300002)(110136005)(107886003)(86362001)(54906003)(8936002)(8676002)(66476007)(66556008)(316002)(66946007)(186003)(38350700002)(2906002)(2616005)(1076003)(38100700002)(966005)(6486002)(508600001)(26005)(6506007)(6512007)(52116002)(44832011)(15650500001)(4744005)(83380400001)(6666004)(36756003)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PefLYkE/tQLax0DJCbnjKplZq0RWHtIzMP3TZ7gYHOExXfTdlZfu6jblrIiT?=
 =?us-ascii?Q?icd/IGG74kibc3vbnnMZJqyFUISvrR+/7qVQjQbIlo70JhsQ6In7kcq4G/+c?=
 =?us-ascii?Q?j6Gmv2czSS8yn+t9aHbz4OKmxGxvolTbGKSVK5803TLx1VFaZMe+J1Us5srn?=
 =?us-ascii?Q?2Bwx7LMBqX+Y0fwoOmQi+Zc8jabRO3+3e0PZ8gOa+0MuNERS0gCrFDZ9cuTa?=
 =?us-ascii?Q?rvrSTOCXY1891rGp8AA0OPDhPv0TEaMD+XCjGQqc/FjZvp5+Iq1c5LECSps+?=
 =?us-ascii?Q?C1LKLu8J4Iw97PUyyCexvtewjgeK6+q6tjkWdRtT9u2BpunDJXZCL6wNFW7L?=
 =?us-ascii?Q?ZRl4yLVyIitZlT5bK96xIhHs2PqFiFrqTAjyRnoZng39n3DffcdOEE59RnMU?=
 =?us-ascii?Q?MSFW9tNLATrID9xAvfHDiWz13/KwLDwg2kTdoKawbWhkECUGGj8PCOs3SDYE?=
 =?us-ascii?Q?jMub/fML9RSU9rvrjXcrDDVJMzcYY2X+9ehqa8W29ChE5PB3po4jhkLX0SB3?=
 =?us-ascii?Q?4Xk7Z5o/gJVK2L8q0p820UIX4wu50ivhNv4ucYSNuy3HEzUfDOkRf8n5EmWB?=
 =?us-ascii?Q?Qq/WcbCEBFDsfbdox8Tk1/HXakJ2Ckubjg8/m3zVlpaFPU9Tstz2WWfsCsrR?=
 =?us-ascii?Q?dgFRsdMExIaiHEGFNSXA3fKYQMTP2BPIoxyngFqQ7jRT89tJEphlwgaHEkDP?=
 =?us-ascii?Q?m5BzOxD1u0A37iF79gYKu60iDLvs7HKDgYJ2GazcglJgr4u0MadLmHUX4KWy?=
 =?us-ascii?Q?gbgYpzU6ndgOPkrM61cpJEWcAu/Pv5PByHGfgJbElJn2PqwX/Tb7gzs55hvL?=
 =?us-ascii?Q?dl0ELSNA35BMMDHCwbbaxYNIiGrLlBFyihI8I1EYRAy0K8B8fi7JmSFcrR1I?=
 =?us-ascii?Q?Wi+b4Ac+OpNzRS3bvm2I+ZUfDPrXnmhIg9YSu2PcPHwhGDdxPi3Vy21L4wve?=
 =?us-ascii?Q?kXwwSsLhzzYikQG0ClrCRepB4VJncHenhFd6taPWsOVTFPCjUyH0d6PU+E38?=
 =?us-ascii?Q?clsjgcI8UcqKUaegsq94JyueveNu8eLxTRbBtw9a40tLr6n1TSvTpR2xHcgp?=
 =?us-ascii?Q?7NhRJMsGYQ/t4elLRLFFJP6G5hWcN3mCxWsZXEnpATxmVf29gtGGG2KXrx61?=
 =?us-ascii?Q?b8gIKvfIFXmLCZgqxfPX8FJlhQgaCcIpiNdR9K/imTY+P6mbji3Hy3Vl0baN?=
 =?us-ascii?Q?2pPXfB8f4h4m1xwU7xdOJUvwXipqekagqj0XIsHtiEcUlvHOIWJNb9M0CFW1?=
 =?us-ascii?Q?C4urm2lQG+FviQitWc2A2FQzhDK+He880VX9bRTrmH4KxdxMSrlowHkcMr0x?=
 =?us-ascii?Q?ujzr9HpgNWwx33R4JWODrFdWVvOLy/mIdGTAQCX6l5x4YYPpw6ycwbCvFW7I?=
 =?us-ascii?Q?3nHl64IUrtODCeYRoRynFnUROFe7Mh3RYmf+rqb0qwLziJXiu/IjfLxfxriu?=
 =?us-ascii?Q?ZX88q8ZIjGrLGHLnFgT+sHzjMG3nlEg6kyNF1dx3rdNADIgNGQQvsiB6addr?=
 =?us-ascii?Q?2AIn9DzgskfC+P4RktJKiZQk93hMVAEsw4LO8D60mcuDJskfiZj8LOZN/qUP?=
 =?us-ascii?Q?IN3XyJVgXv7hmMDfnNMlUH5GnKFtZ4gz2SHjXASFM8/LLr9F1WDUDqaFrCrP?=
 =?us-ascii?Q?WzR9ErM25LS5FaslTZSZymA=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a2db37-119d-443c-8833-08d9ed000120
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:44:12.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Etd9Gdtk843L/IjjjCYSJszQiEuc02ME6yk+usDQvhT/WmYYQSfZDxCmBraygzsU6OnzPeBsGrKsvUzCHzylXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3577
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Facebook Bletchley BMC devicetree base on EVT HW design and 
rebase sled numbering to 1-based for OpenBMC multi-host

This patch series are modified from
LINK: https://lore.kernel.org/all/20220209100413.23714-1-potin.lai@quantatw.com/

Potin Lai (10):
  arch: arm: dts: bletchley: switch sled numbering to 1-based
  arch: arm: dts: bletchley: separate leds into multiple groups
  arch: arm: dts: bletchley: update gpio-line-names
  arch: arm: dts: bletchley: update fmc configurations
  arch: arm: dts: bletchley: switch to spi-gpio for spi2
  arch: arm: dts: bletchley: add interrupt support for sled io expander
  arch: arm: dts: bletchley: add shunt-resistor for ADM1278
  arch: arm: dts: bletchley: add INA230 sensor on each sled
  arch: arm: dts: bletchley: enable mdio3 bus
  arch: arm: dts: bletchley: cleanup redundant node

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
 1 file changed, 194 insertions(+), 109 deletions(-)

-- 
2.17.1

