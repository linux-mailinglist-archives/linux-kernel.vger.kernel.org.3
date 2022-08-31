Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E55A8010
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiHaOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHaOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDEC5797;
        Wed, 31 Aug 2022 07:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCFAKrlkl84a/NQ7Mi0vxTlyCFTW8J6J2owXp+ewalwtShyKIr1aUJ0UkWhhx3cS4iN5bDjhP49vLDvkDLnjOkhWr/8GoirV2QNvGXo5ykwtr11/H4Tajh1rWrh1fKlKt6udEaAFUj5NtcJISDgMoIbG5nOSoRihXDMMYqfSPMcL1apb7OJtVFYS5N/HyjQv//ALq2W4Ob9F2UdA6OlgTNj6nhPZ3WUfm8dV6f50CLpWzrCQajQI/YCCsIR4WaKAUVRYpeGl9f/F5SE42hbVtaIayeI6KpaF3a5qIE4/ENFZSHbAc8OiOFhZ4EFvs+zrzr7uEt3NIx7IZja9DycZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGltKoHbMRksYhYAvYy/pNPR3l4gMSct8IIReUuL698=;
 b=GW69SjY+N2ibElFdSbWkqKpnddf7IRly2nUn0JTEsHTWzrBdQpWKxde+efcak+X9npVP0GoUzpTociR8qgHpdZbNt2AFYiN6WeRvrd99xOYrdhBTZXOsJ+sl//T7Kclov0Tm03m8URO4CADQjqcAzN2OqlEZ5qi5DOsqAZwjU5ZH7CtMyLwTzZz2BArJrZkHI6N9ZhV31HV06n5buBTdgHOzBv6xoLV7Mq0z9wZiWfy2QnWg2iCmrpDfxhVpjEoy5IouEmy0rWx2IFu65ktx5vIHo5huKdUfp1fKAA00wA7q59p0s/cLo8kihp6KGESB8Bs4bLosGyOfxneHYMVEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGltKoHbMRksYhYAvYy/pNPR3l4gMSct8IIReUuL698=;
 b=LfXOnVBcmZrd8rwZl5DBGySaHAJ2oKnF85ESk5PorruFJLLsamOxqDehhDqLh6env9cJVcRFmXjtudP+QcJmjuzdTyjZ0yAbefKsPCDqi2wtNFK9LDIlb9Q33CIvleV1852gL3fuli2cZKuewckaZ7sfAFihTHVi7NS0nJQ+GaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 14:24:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] arm64: dts: imx8ulp: several updates
Date:   Wed, 31 Aug 2022 22:25:46 +0800
Message-Id: <20220831142552.43393-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb32df42-1358-4695-b2c8-08da8b5c7bd0
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4CCckIVk1IwbTxx4oPuXB9vevm/EtzH+Li5/dJb2J3/OP8SykIkImSsfbaE12mNsPLFIvW/E8c/40tQlHegqoUD3pfdc8XtCAFFH2Ve38DfCk8cCAVog8pLJ85jiUdm5faXguc0SteuHd3TZnXXOa7x1y78icH9AJAWuJSc6SjxxGYarop3U5PTOeZ8fwWuTzOB5T3ifjnxwNpq285NPEGjmrItvbrkwCuHUgppv9w4xkgEWPruXcoLdbIvf3v6C1g5xlyDajehuUnOt3KFZZaIDKQu7qXB89mTxuXuOF58sXUKhs3p1eHwTXQgrpmaAmf3DEX5uCOBs/6ldhUrM4O7kqqqnK2fCVcJwglPB/ESQyd2DVAYKrH6BmgsqpoZXlw6lHIFnK0XKen4LrxKtttVmRG8JuAm/DQpDZGeQKGSBweiCqEVYr2Cw+SDCgTXJNZYumdHkX0zGoLdRO5oJduX39Iq6jsXyIH/byR8M1zKQGvPTXfUtzJ/jW3BT16toAdma9z1lOpLtR1YpyzBPFHRXYSpJsTpj//r43IptYjG1kXYFPOaimzMBSdzYpRMdMGIWLjizFF+5deomaoGrBDp1YPy917CYdTRON5exPKRno81Bg6mOyjV6VxX0ML5hlT3jchm4JZMksYtOL+/3sqHryhGUEfTQhyhr+U54NHUc+39wg8lEkTGQlQXvsu5EMIW+u4CdFLN+X7s65rcr1xKyRnEUhhAgaB3Byld2MvVSsVKFfj6DjPQBQSlPiprgFmS1bTGT9OQU102RbM44kFReTMdLZXtRgKhRhbKzE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(5660300002)(2906002)(66946007)(66556008)(4744005)(66476007)(15650500001)(38100700002)(38350700002)(8936002)(316002)(8676002)(4326008)(83380400001)(26005)(52116002)(1076003)(6512007)(2616005)(6666004)(6486002)(186003)(478600001)(41300700001)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7Ek/C7R0M9Xo2z2rkcsYH8jAdu1xqXkUjIpKFwaEdqBum/R44JBVswphCN7?=
 =?us-ascii?Q?AXEv98bFeexGiTZbxkMKqWVXwWk3XKCJairTA65JIgBJdiHKbaNOR+l9AuQJ?=
 =?us-ascii?Q?n5lIHUum30MzgSUk+kKQ2ncB0AY7bFHm4CuHkROLFJqSRn2f4LtsaAgn76+6?=
 =?us-ascii?Q?XVeIiDNEtxE50CXCA7Xv2xKUEcW9/9kt3BUvHbgUji46A6SMcWBg+JhGhimL?=
 =?us-ascii?Q?zs0rnE9tt7m6gtipzmnMhQAQFeX8AMTp/OpfXKM9p1lLCxuEVpNAIiEfzDEQ?=
 =?us-ascii?Q?ZHb1PbzQ7IHG6BRkjs3YTRQSL9DnjPoR8QMni1HF3fKPK8pu5v8f4BVR2wcS?=
 =?us-ascii?Q?4o1QV8M6cdJH2WCbxWVnwARfG0RPhdjH/E0tLPF9yKDcwHqVw2J8YdJoSerm?=
 =?us-ascii?Q?uZCo89+FNXLR65+9uYyfO+TiNg78LrM6P0nol4n4xYY3TFggtMINu8w8WPzA?=
 =?us-ascii?Q?3u5t4f220IdJ6+NVwIMQ+X1ou5JPC3OTn0Pczjd4gCUztFS5XWZ8xRzz2ory?=
 =?us-ascii?Q?Xz9t+vCIZHUO370frMSG+AOKzAKgfGKk2AnMUwJ01Fi5BEPWS71etq/M2YRY?=
 =?us-ascii?Q?yGITOCKCUW8q5mCVWWcyzg3ILEMP4RcLUFh963BadFXxSNkZBD56iOTd6xPB?=
 =?us-ascii?Q?xFagleobBVuABk2blNu5SOqJgh/r/7Vs4rVKrKhzRNPsxaYHjL4PpPMfeqv0?=
 =?us-ascii?Q?Zv2429TSPjhGi3ov/CcSaGBipiwkMlG/iq/vQQ511NtyAWDNkWSDP7RVH9jk?=
 =?us-ascii?Q?b1iRsG491OBB61ZRFIqOCbXcFKBhaykSO4YMpNAF7fyo2sBxZ5wE0BBppnDG?=
 =?us-ascii?Q?wo8ooa599jaoZ8jblDV6Q1DDQSx4zXfnko0i5Au6T8nd6P5F0jhrxe8eKGtw?=
 =?us-ascii?Q?DYZvz3G/yJsGOu7owSxsOVOHWhKMCpuUKP2OhmUmuuDcjmhXxhHbTbebRPqd?=
 =?us-ascii?Q?h8qzH0bDZp/QkIwj9RsDem2wy4iHgrk9wW28JGwtypxoIBd1VOmqiWu9pCRG?=
 =?us-ascii?Q?vS/zibOciYaWTEaarCiKzPCvma1OB5lFFof6JkHPmHGkOjtLGRSIl7vp1jck?=
 =?us-ascii?Q?4iZTaVKW3MorLaLKzWXWxCBXZ7kCbCBOCMCLn9MPYeTp/Huwv0LawX+guIIh?=
 =?us-ascii?Q?/8GDCk+simq1mhNPs59F1wkpLnqxXDxJEtB8OVk4Sl3t4bRwCsd/8fpjvvJ4?=
 =?us-ascii?Q?dazP1emgOKE5NlCjMpUFUdA+CcDYNrLv+0mrR7xPLJznOIWNfSI7+T8mU0pC?=
 =?us-ascii?Q?uEjevtZKPhqqJCBiueM6uQ/2qUv6LUkRW/9mpWHf3IcLk8pAXmqz20EafneI?=
 =?us-ascii?Q?x4khJ7yGeKDmZ+Yh3QGFPWq0YEh9+6RVMrsr9GvWunTx1+m29slMu7LWUrKZ?=
 =?us-ascii?Q?VXrUt9NQmlzgiHS2KhXDzGnKf0Z4mxBmCIrPfx9VZHLFIhBtP0RxYPqWewuU?=
 =?us-ascii?Q?7r63rpSE3gN+DP8wi0FeG/CCo/bYYhonF8X0886yJwmJzvoUZqQ8IbIrqgxs?=
 =?us-ascii?Q?HB33EGPZryl+0PuToGyjXF5jIWcM2bWrC1y7/GPpPqMhH1z30CLkSC1VFvbu?=
 =?us-ascii?Q?p7Nv0xeCvBcGzDTWxRsR6dxN6J1dToPmkDZMZMi4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb32df42-1358-4695-b2c8-08da8b5c7bd0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:16.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Fl5gmOs2lp8WEWhw9KYv2AXsOor9a7lshI+m6VPwpZ45FxVs1WRUhWj52NcNZXB/yAn0nJI2qt+vNCGdpJafQ==
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

V2:
 Drop 'status = "okay"' and blank line in patch 5

Update cgc/sram/pcc node to match binding doc
Add pmu/mailbox node
Increase lpspi clock

Clark Wang (1):
  arm64: dts: imx8ulp: increase the clock speed of LPSPI

Peng Fan (5):
  arm64: dts: imx8ulp: drop undocumented property in cgc
  arm64: dts: imx8ulp: correct the scmi sram node name
  arm64: dts: imx8ulp: add #reset-cells for pcc
  arm64: dts: imx8ulp: add pmu node
  arm64: dts: imx8ulp: add mailbox node

 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 57 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
2.37.1

