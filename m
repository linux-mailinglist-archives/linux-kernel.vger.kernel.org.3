Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36218511506
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiD0KuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiD0KuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:50:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E8369DCE;
        Wed, 27 Apr 2022 03:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWboxjih9uyil/VDcBLedrxjoHs8OKJmpDXygqwudXjh79hf1cojKckCMoj4gFxjLgmuB3Nfda5TEx3+qeEPsjhCbfXGVg6PFXbJJ0DX+1RnO6MggiWV6WxyTvjOnTgtZ718sfKJ1kSMQtw7C7lVin/FgwVWVgqfpwiEcSPFsfx2g9rFkFPz125otE0OZR7SJhWJ4LYmclKGjel9S5YSbzWVVZpRimqMN/KESGIBSl7QAuYPBMIvTB3hMCn9nMwlI/bhS+StY4PEq9/gNXhg6Ios1pAR1z1HwKutxn1BRkReDwpt+dwYPtRTHQ5r6dipm23kUuWSYOl3PD3cNpmeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whH2ubc5nkHKvSb3YnUJM7XY7bRQbe7ooYlsvkFYDEA=;
 b=geMgr0+BhABrJf34SnzFGUWhX6CUfVRZEay/ap2j2CLXVRQAwPVWrtkhMWWj2HUCtbCmfU1ksR5H0H5NT0lrkc9FV/NO7hmsb+Jlvs0OpQzgsEaAo5WOFOEMDyVV6PeLECGfMmTOruGLgr35HlmkaolbAZGTW0awdiKaUGrMndu5VQ0SqURJxhXMnoDo+gfq2xMvDS8gw3ug0vPDMPU5aKpNmws2KSNOILLGeRUSVP8yltr7fon2F3wVuCn+r/Sv97HwwNNmGlhGFhN/qdcY88VMULnuPsw5SdejgOFZobl5+Zm6u5b67XazYv5o6J261GN8/8hij6zuepyZ/5SjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whH2ubc5nkHKvSb3YnUJM7XY7bRQbe7ooYlsvkFYDEA=;
 b=jIHUE4NoWVwGQ2L6Mjx8n0KV4eiklS5EFrIbJNsElEv2ega9M3JDOSg/D/5BWKnWTTKVtDuJ6ZfhMk4zvRda0pxMtA05ehXKI54x4nFIQzkR0tHeqdr8Ra03IM5K93T8vwIZzfoQass7b8RVQ2yOYMiuKHG7u9z/dwBonTwGpf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR0402MB3366.eurprd04.prod.outlook.com (2603:10a6:209:5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 09:19:17 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:19:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] remoteproc: add i.MX93 support
Date:   Wed, 27 Apr 2022 17:20:52 +0800
Message-Id: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 604a9273-6dba-4a28-6d09-08da282f0120
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3366:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB33669C2964119911190C0FCFC9FA9@AM6PR0402MB3366.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFv6Spg0XcQlfQdhojdNuLPZvQjQgJLZXkfxG4Z5ZjeaS0YE0h7cHCgXFrQu7+MpEgePRPL9uT6xteAiSVHbCekzsQRD4tTl0MOo5TzH0EgosfvyzG+fZSG8H3clJtIrAdFqNM8szwNJrrbSVmGB8wItNvZTDULBFP9ebnJXjwvne/NvsiK0ouUzB7TSc53Q2IRuvAlq7cNcbrENQw/nKoTCLClvhli/l42cE5FP+fc8Oz3FwB0uhya14HikQnk2OxyKXH7FC8GMOuTzQBJrQPFGqr7X91Y99zYoCqxUd3Sl6WGopp7VJWVZSYI1Vd087z8MmQpjnPLDcSY89EzM4fzjaCGsfjPMkWmILKsugGmRQ6zyH4h38j38+BNu/1nP+POouqM2nT64x+0r/oUnriy9BMiTI51Rq5ZnkuBlJXTq9L8Bu7qU1zkJZTQt4bF9cWlcqO/PacPWQNn+bMqqsIoYFsHlykZTo/g9G4g9CT7hoebPzPsl3zGLVmjy5Uc433h8SajwQREESv1Vf6Poj1nSndCU0S1CJjRYmOTYOsPxzWiX59I1dVz/3bLAfxcvAcUJofbsbloEuvqTVS0gqggmgubrgoxQgD2CPVAa71UgS8xP/y5008ZM29csr8hQVJbwlw5CanNc/WdR5uKQHj74tFCbSNBJrj4w0SpK0TvnQK1M/lgQqkXrmcP3kgn9m/OpXBpo7l3cw1GT7e5s5qhwjr4jo98v95h3v9WfkTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(66556008)(8676002)(6506007)(26005)(52116002)(66476007)(4326008)(2616005)(316002)(6486002)(6666004)(921005)(1076003)(186003)(86362001)(508600001)(38100700002)(38350700002)(4744005)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7igAC4dSQMBVCo/ndyTBEJ0nfg4etQPvy3agidtSrt1s2DNymcqa+7ZZgmRa?=
 =?us-ascii?Q?q5xP4sU34cdNmq9DMD4kPcTn6hHqgccU/yzRRCDtLgTsknh2igaUcGl9O+rJ?=
 =?us-ascii?Q?J9Ffb7OApAkfYuo/dKH+agxJOcSGY/3EUm8UA41F8zlLEXeMDNDbgTPocemH?=
 =?us-ascii?Q?k12CQvKJiXj6DZspUaDVWzU71laQkR1G5JIdIb4gDrx9s306ev/X6LoPZS/Q?=
 =?us-ascii?Q?/TnWXwOHEe79R6a/MbwCbXYcngRZfFT9bppPfBMtut1yDU/hqnhFLfc8TW4R?=
 =?us-ascii?Q?VFesLYAtz3TiixWM6m9nf2Vhl2jARfAUafb9NurJ+khF2Vgdp+mrwoQ52nC6?=
 =?us-ascii?Q?wH2ixj527aNlQoxXlKxVo2Wpct4hlf5fuqo4SPe3JAmRaCK/TH+djk+Uv1F1?=
 =?us-ascii?Q?Oz8fxg4nPTQwnLnbiZMjeeKa+aC/Z3vHdjLSX7dDrYTFD54nv5IsiyWelx8S?=
 =?us-ascii?Q?6G3awtm+wQ5pDXne6+d5WFfgf0PrgVOgxMlDN+/03k3op9awb5g3oJ0XhWZF?=
 =?us-ascii?Q?VSnEqavy3WVWsyD/E2tnKOoBgsdtIl8PpzmhKTb9jOx5lq9SHCsKsIjlbG48?=
 =?us-ascii?Q?+TmTI76KsmpEoP9skflvElgDJU1SHed7L5KawcKlT8AyTkbegS8EaM0e5MdB?=
 =?us-ascii?Q?VnZjLy+XW+IN67QwHgDjIRhV+I/r94Vez+xkx1s4RfuCLNL1JdIfyTGTCxb4?=
 =?us-ascii?Q?1G2F8b1hco/lO+D95FKGlNsMZy8ODDVKab6n4CghHCuXz7nMenAkyEC2CYse?=
 =?us-ascii?Q?OF4Mn3YD4dIyXMHe4HW0hmlV+2+ksh6Wo+cnJ3Buw1KryYGEQfoCrBb1Kl1+?=
 =?us-ascii?Q?iOSZ8i+8+LTi1gd723fpd/TwVmPnOqfUsx30VnruQXV5jTpY81U5N5xKciXj?=
 =?us-ascii?Q?I8BCPrvUNnh5ToL0A0HCoksNO/dO9QTU0IA6Ax+N4dz5FnCMh9/ZDHH8+Yfh?=
 =?us-ascii?Q?MXdIBlc4PyNfs7tHIejrqMfT92XqpxxqmiaSqSKrI40JqhIB1o6XXpBESW4D?=
 =?us-ascii?Q?RyQFONyp6HVcpWj5NCrJaK3fWaOmTOVYyuwwjtjs3L3tfSilT/w6ylKDI/jq?=
 =?us-ascii?Q?ob4VjB9SZ28p4ZpE2N+6RWdlJT6uqX1jDmJ80in3VYB6TB7fRROsAPJ0cBNh?=
 =?us-ascii?Q?DslDY3xFcdODVbOg7wJJMgptwKgKeONndKv5zXyF0MSUXJV6ed7pURKNCSBc?=
 =?us-ascii?Q?NPqR8DbOeZ8DxbXqQgRTweRZkoO8Dv8XffNnkdLiY8Z3ZF7ifDwNNgYC+4zu?=
 =?us-ascii?Q?oLaxPdrdAO7BZYiYh/geUo3cgIJgSPDlWV6fHOFljH0Avpntz6shVsd3pAtY?=
 =?us-ascii?Q?7LU2XPiwVRZvLlDlDIeBsqBsTeeSeiCkeySKRDaDxc9epqKnMuZjgXkFyWmw?=
 =?us-ascii?Q?hZSb2VOkBFzdFq1d0GMsfoN3Fs+jRs4Ysmk9mRLyttYRk7cC2fdKvcZwLgXL?=
 =?us-ascii?Q?ZZPRpIVvKtPjI8LSRPP5qjKZGMlcU9qa6COld7h0QLm3CTQcV+nI/pCGi1sX?=
 =?us-ascii?Q?uFx4g5NJwNyacFwQmVOyV/ZPRB0MaPVpHBsdDdz58CBUcu6e4ZiWmm+hMu6/?=
 =?us-ascii?Q?fiRqKwCc7VAiP6EV8LlVnzzyrxX6lnUnzRMVkO3q+OKzIPbvXJkpZgcaqRvP?=
 =?us-ascii?Q?cU+W0lbuvbS7ritA1ejEtIxuYcky+ixl/QXkSszKTDXq20KDQ9+C39MnY05s?=
 =?us-ascii?Q?C11RX2+t8QjioamOPLMqpxkzzgtTBtuD7iimY7oZkZdqILyjD6H8ywGIKvuW?=
 =?us-ascii?Q?OdgPuJyFLw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604a9273-6dba-4a28-6d09-08da282f0120
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:19:17.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6drX3AQztW9paXDj+Uc02qdcvwrxhbnDLL5rsnDNZEAY5ww5JL/jzrB0t0cJ343gb7F3ljhtauJgwgLCM++2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3366
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 features a general purpose M33 core, support in with this patchset.

Peng Fan (2):
  dt-bindings: remoteproc: imx_rproc: support i.MX93
  remoteproc: imx_rproc: support i.MX93

 .../bindings/remoteproc/fsl,imx-rproc.yaml    |  1 +
 drivers/remoteproc/imx_rproc.c                | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.25.1

