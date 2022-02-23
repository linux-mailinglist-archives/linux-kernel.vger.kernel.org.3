Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077924C0CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiBWGmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiBWGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:42:40 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C554FA2;
        Tue, 22 Feb 2022 22:42:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG2iZO00I4xRgyOiPuU1fVDEGIImrNqwVx6H8lrmGOJHiqWRZv7FRqnq8Tr+KUmZx2344cT6V6Uwr3ErwCQNdYwpOXW5aO6z3VX8iNiHLg2ioE8Sw56tFTFENvKGRc2SzH2lF9eybRfFsv/+8p0lB87DehNNiwRKIZSN0Z+tBUTOLgKoSjw6VS09hY1eDTOxvBwngyXUJ81p1KhJHmLwniCbnkkPLymiqYpjD343hHacyl5ujxp+gA7kVPH51j45sa7HmKZQeuactZPq9C/Jw1Tc/d2R8QYIni7yvhaW8yFCrDZtE6jD57yZ/yWplhVId8yt73l8MrniZ9daOhquZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A98P0eJI5w72A+zXt7RRjfdp9VuaomVNE4mXjUg5B2o=;
 b=hypxmLzLpqwe7YLHmReOpljRvFrJdNlFQZ851fEO3X5JYa3A0BfT3rgk3E6fDFaqoL7R8MpJuleiPS3/JU+wZgXdCRXnzewuCpHyowLl8dgci2t5hbtoxycTnXTCL3tdUgO+CBnvUGl7E09vMWcElxubhbiopygFKite2cSW6jjYNASaHcSmBV28IXeqYD59YfSW4MfwVasRKyX/DrAj7sguVoFF5hz8D0SXoEraouMmDzv/WNQI+cwMxEbg44IxbEQhAXWQkR/1Fhv19DLydVWrenujED+WIszGBZ+hafV/NAGq3tX+5IMD8L28TTsNUC5ghjrTskAJopIt7+J7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A98P0eJI5w72A+zXt7RRjfdp9VuaomVNE4mXjUg5B2o=;
 b=UzYqX+PeosEvedGR0pecP4R3n/Fbk3DvLg7JgF7xyUSk269pRd+/BaZDQi0mT3XxIVdxjt/yfmUlzuIXnF5jc+Jnt3aN7YK4cSz2Lfi0/uYbXLMMid5NyaUR0GBpSPPqkvCZaw4gUVret7bl/7e8v6bWOIwChlAubTO9bZctahg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 06:42:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 06:42:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/5] imx: add i.MX93 clk bindings and driver
Date:   Wed, 23 Feb 2022 14:43:53 +0800
Message-Id: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5f16bf-9b84-4bc0-eec6-08d9f6979d3e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB55426EA21FF25F8EBC52BD0CC93C9@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F754qtDsydNipFryjmTcqaIoUcjEua00FEX195rwf/GvZ2RZX9Wt/KSL+KNTdNOamj1ODLZZ2VkHcLz0xoT3WvoYD9Nk9pELyA10UA/AiUT5JKU1SFzqfwxPZPYK902dXnVf7Yf2LVII2sP2EVuPikcqhSL2q2fYpPsAvJ0UfLy8N1lR2W93F+igxxWNcaE+UP3Av/FsmHm/abQWmQAEQ9OAeksXXhtH0N4kcO6qs2NEoRdScybgvr57h8r15mMIi8QKHohPlHrW3gEB0uR885vnjLT1gPDjOx68OtGK7EmIeHR/EIB06Q8XZQfrNO36pcSGuJvrb4mUq52vtCDUNTs34z8tO+lfq+y7vuN06D18KYGBamMo8uB2LYYsTSY0+fv5aOMfE3+spnLQH3v9g93gJPrFAEsDSA5w1uiwNOVT57M5fDiTlx59TYRMZxsr1F7AZMhhC9WOs5VFDOzpIf40wyLoXnsW191UNAusSklmIpt9jgGwe6+VBha2hZrgOlfawRd1G9wbZ2GCRYKnv5s2wawwuotG8SLeCVZeEYjvVReiNs7vt52/u4aX0gHVVfi4yJBCTIpdW6hu5lvh5TPNThvZNtt9wICS+d1fu2LYGa86yOpNhf/s6mEagsxaeO9Ycbx2D9imRU1btWpwPh2EkjKBAFvhhgDOhRbTGcdj6SLcHa5vNzka7SKzF0Hme+PPuYaNpu30YE3AITConA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(52116002)(4326008)(6666004)(66476007)(66556008)(1076003)(6506007)(66946007)(38350700002)(8676002)(186003)(2616005)(26005)(6512007)(508600001)(316002)(83380400001)(86362001)(8936002)(7416002)(6486002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mbca5aJ4nFyos52snXq2arL+4ilZrrBfMaoI2VSJEb65/6ni9tXm04CQXFQj?=
 =?us-ascii?Q?MZ9H6ipBEPnj83U7IRMri3uVHh+7rXuRuyYchbD4esM+QnQBM+E1bXs7y8jD?=
 =?us-ascii?Q?KqkxP6L1xi1FGuXeCsu4tSXkHyn26nuLXgyKKov3KOrbfa+giniomIlNNxYv?=
 =?us-ascii?Q?BsG3zGWa7xURZ59ipA/kci7vZ8/T3SMNBGM/AsgiJaEq4g9EwCJjNdnVzrhh?=
 =?us-ascii?Q?T77t12FEyafi3NcDeuc6TpeVkEgeXg3ZuKxpGtm/v1tAy6ErE0sSG8Qn1WAA?=
 =?us-ascii?Q?xf5xI1OF4ScpFa4LbPA287x49npKVlDDMTDQep1n66L518r+rSsuF7i/47v5?=
 =?us-ascii?Q?9upvO7weMRYIM6IYRcZVFKh9Jvc88VY2TbYe3sCpDNDayBEaicauDd1u4Mhd?=
 =?us-ascii?Q?4PvM5lYrHL4iFPOTCeHi1rLkNd6fsHgrvjycjx+kbbpsv9Jm9rRRW3Szu7eA?=
 =?us-ascii?Q?LBKEm7g0JyzHpueTxRCCpaJtlP05z4uXyX6OjzF0o/VZRK93Zv6m3FCOD5rN?=
 =?us-ascii?Q?eNm4HTQ1rwVaDt6ctfbkLrR+t5X4kVv/XQkzIchMZ0GCnuc8uat3phJac0hq?=
 =?us-ascii?Q?ShuIH6tw1aUCXpg5Q+ReZqI3z8SyEWne0KQgtrqJNlGdhaEnisu6ZBRZGUqB?=
 =?us-ascii?Q?eJj0+AUOVjziYyapZ5Xvuf0Xuku7kc500sPEfi5tu5PngUOBa5kTpl0R2S+z?=
 =?us-ascii?Q?5UBOIYuhjQEEeMSVeC6M8N7J/ckPGdTqlkpDQtMFdxvtnSq1kgik7JPykhzs?=
 =?us-ascii?Q?z3lEqxelnMfJkTUJRxN2ZhyhZlt37lQQ/75llIZDfOG7ZSgM4wogcGpcBYZp?=
 =?us-ascii?Q?cgk8Bl0/36mux0ZkFB9xNV+3Ugjb///tx6GPe6X5I+eE78h1FRpbO6gdCsmv?=
 =?us-ascii?Q?rM40TstsC700YNuJz8mdSYvUuG2pSo8Qu0bWuAQOeU7mYYfN7ZkbG/xW24s4?=
 =?us-ascii?Q?ylwUJG4Ji2Qtl/53xnUAtMdcbxLZPAI43c7S5ioeRzAQ7UugILei7SbHgb1/?=
 =?us-ascii?Q?rVwY/1lPDwkENGY4k2jN9Ak3P5Y+wt8p1X//8vDIpUVEUo/IzTZ34HBYc0p/?=
 =?us-ascii?Q?y0qC0OeShQYL+tnOZJ3ucrjrO2uX4XtUPWUXyAjIMQlnjHwmKcZ+pzg83wig?=
 =?us-ascii?Q?zjJ9+YFPFXALbYbWu5CK6CV0JsOD8Wk43YOCzIwX4TpKkvZLHFGZib06/Yai?=
 =?us-ascii?Q?SEe1W2osQfwf9f2f190BYpzNEnJIs2NLxspGdxxcTgUkHdoVpHbqVtu4Nq5D?=
 =?us-ascii?Q?IZo9qYLLlCmXFwK1rdonxy5568Cfdkr77Ci5fa3+qvv7cX+vv4hHooGjb0aO?=
 =?us-ascii?Q?sD8q2FzqqP0ZHJPWhDELFFaYSa4hP5owRxi75vlHgEksV4bT1TMw7nfXe3Z9?=
 =?us-ascii?Q?CAYiukcbtFXEyfoXQ9+YvGOLPbZYDXAf5Hl/NC1Grc9yNLbNOUs+LrNLorUX?=
 =?us-ascii?Q?KH7VCqlQSqI+fIwyPjhmMvpblDQoe2tydNQG9/k9tU925V0qjQ8y0CzB+CGX?=
 =?us-ascii?Q?yZvSIp21KGPxRso1wMpyDZesQrdSP+pcrwFHPg/Ho5CwjQd5d36uS0tKd2Ly?=
 =?us-ascii?Q?3J7v2h9MHI/pDRwuPpy6Uw+gTOXLGGaOEsUtjUL2SqUcWwzbwOs71u367N5D?=
 =?us-ascii?Q?POnssvx/loxRfNYCcBpD3Ic=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5f16bf-9b84-4bc0-eec6-08d9f6979d3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:42:09.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuBLYZbil7isLHn+XC38k/rQPE7MO7dyQndfPbGee4aThJgi0phy4ffrwTTZuYz031Q9C/dgqIrc8Uu6AMLgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
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
 Drop an error included header file in 5/5
V2:
 Split yaml binding and clock header
 apply to Abel's tree

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
 drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 200 +++++++++++
 8 files changed, 1062 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

