Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07E58A0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiHDSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiHDSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:50:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541710FE5;
        Thu,  4 Aug 2022 11:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSUFsRqmjus5h/Aq58nkui5y6MNMzZTBzVy5SkUoZGXn+D4cascQbIPyWi3bKdBMvU8dAvfYy8XW9gNqfw4wjCLr9UjZxII1hzbJLqShpuUc1yfZz7dPv1sFwh4sC7VG6Hz6fg9JxPJLDZZtzRPM4LI4RwdOwfnKBX58si9drI7UE4IX2awbuRTYx0GXS4utfW9UCallQaW3p07Kaq/X1JPyVyutAqqPcy1l31Er9mg3k8rQCje78GeeeTlJIDQ1BatFVW+I7yvJUWDgfSmi7Vxqbv8Z5BcosQF9t2xP+HE5htxgYuOQ2sVnDnusawJdn2dXEmGKWoxCbIczxtFBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcyJH5VjJJaCLpsMzeBUOPYRGjdZrSp3XIS0tPpGMyQ=;
 b=JfTAHcziPgmeaR2mVGxH3TET7oGJ3b2H53AfmKhBskSuX4IE1EEVVvLKlFu9zCXxvcbqKai4xv4MRSD3IUgfZ7sqit+/Rd8R1d4hC8tOGPQOqDYNRWp3m0n0AEKKtHY4d/+QQvF6CJ3xHgKHAwMMqmKSoUPKTumNYY8lGFB3QYGJqYCVmwDnpIIsTTx0hj0tpkglszJ2n6FvmarIaerTRBxNmUSRzHqdpZs+SuceP46G+FpobVrkt0nFidIPiNfkILTRp87NMGGudUtyuqGvw2y41Em7CIGoalRdKNLE385OHbhmIo8cawnTAFnBfQ2WFN66fmsu3pPtJ3LVkq1Rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcyJH5VjJJaCLpsMzeBUOPYRGjdZrSp3XIS0tPpGMyQ=;
 b=FQc0jYtfz1kFqhrIQqD0Xu5eJVVTH2C616OJ8uZ+vbYEuJi/GdNqkT7yNbagjNq/8/pt4XWkRwTND1Izyxg/aPNiUfS5hgbaBxJ+F4TqfwgeIFaeeLhAG0yOqtr3FgBaDFlTQeLz2YC6HajJfQWQi/Qdx6vmUSfsIU6YUf53ZHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB3992.eurprd04.prod.outlook.com (2603:10a6:209:50::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 4 Aug
 2022 18:50:18 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:50:18 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Date:   Thu,  4 Aug 2022 13:49:07 -0500
Message-Id: <20220804184908.470216-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184908.470216-1-shenwei.wang@nxp.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7986845f-a32b-47f2-342c-08da764a2cc1
X-MS-TrafficTypeDiagnostic: AM6PR04MB3992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffeNjrheK6Up99p4trbdYx1sk6ihHucC5TX3kqyQCV8tgnegC/Hs0UvKPL9mdQxjndYRJ09LZsNLPxFtPeE7XLoDCllsNqPeAeXhoK5vaUaBWQ39H0JGCT1/W8e0KvkdwYylD113NjbJTW8XxKVG1V1I/WQPAfvdu5xQFLhkhFupQzMiorAtHv6kR0LiG0T4TfUZSxs4E/CsdCnO5VffmjmyohDgW/feEEwTwezsmk3c2k2y8Ds3fNkjzSOKYJ+92odoBDXK2sloojH1I17+o5304VOJk8eqbzhKtkkCLZUdAWoosiLtqiJNpA+XoGXaFMRb7b14t0DbrwYboU1U36kGavtIevCcAzgUT0I+bNrGnDuqy47W5wSKBziyHiDs5LgCwRdbQIRFf0zhqKMBE7pq86aO4YfdyiRhzPwddFtL8ZnTrp89UjnDFvBSEV5Z1MzoE5udCzg378HcJ7rb+UJ5Y0Uck346tKKbYO0C0gKJzyN6Gf3X3gOJR7ueY1UXVqhs4Ax0y0AKdq1cU0E91umeG+eRIeCroXy/tq83vK/2trPNubk2rvfqTHOqHBYMTG20FfxGZfBXpT9ub5wnb5Yv36EnfuOvx7wChqNNkaWrNrFmDBtt9ajDp5mbg4Kz7SVD1sVtUOziE4zfYxhG9P6njZ7+FIWFitoEo0I9IZCvjWOcvXyprYeXBnZlnA6CwO3/cTGw8nM3ds6uQW/zznn3QTHYvN/EEUQXLxD+IZlPXlREXm+qaa1hwSbaVEQPv7tYirqet1U1gqI2ihOXcA1iKWmZwrXOXpqNE5YLtgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(2906002)(6636002)(36756003)(4326008)(8676002)(66946007)(38100700002)(66556008)(8936002)(316002)(66476007)(6486002)(38350700002)(6666004)(86362001)(52116002)(478600001)(6506007)(55236004)(26005)(6512007)(41300700001)(7416002)(5660300002)(44832011)(4744005)(2616005)(186003)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUKuFBLmBE316k2fTQ+l4UZ9b/NmzKoAlOrS15JYmRPZzS1ihiv//gX12XHy?=
 =?us-ascii?Q?aKRoFrly8YM6SOFWgNV4I7FJvdpe7r4XdmxSV3D3q7wf4hid9qnnlCO0Omnz?=
 =?us-ascii?Q?b9MahMRbmAmffwQQDzrhi4FRRzCrYcWJ6q1tIELnPcOP/OO9zVluIcdgVNlo?=
 =?us-ascii?Q?//nSbKEJyEQ4CquJKAxdnrjUIIqv4HWx+lVDRKG55raS2wU90HlwBEcCWiOo?=
 =?us-ascii?Q?oqSp8vby2L/jdD9Kp0sZp9dvuOptAXqWZDRV8zrwsEvAruiY7wWZ5QFAthtf?=
 =?us-ascii?Q?mXg3WdVu5c8dGhayAJChUe6GhrbDlqYLb+FrUr9uzNBrNFrnsjYeczGYhuZc?=
 =?us-ascii?Q?OSKBIOni/ytXkKhhgossYIVBmytpuy3UWiFjFtlH5CYpcXAYUNkIXqpJ5McN?=
 =?us-ascii?Q?QKQyPXIpeXk0FUUQ/GPmpxCKbIC14WTo0iGnTUBQLDf/9ISuHSHEptNcBmPb?=
 =?us-ascii?Q?dfKt79ebWM5RQEGK5RmPsRPHq00GxtYWY0zd2fwoGS7NLO/z6Kj9H0Rae2HU?=
 =?us-ascii?Q?gLJxIZKrkFR9rr6k0SbFFeK1Lmjgwce6a1FYthlN4PXilMliNo8kR9bFO7Ov?=
 =?us-ascii?Q?1XQAtk0TsSkLGCvS1172cNLBEtkPfnBKA9x3vYjjs1FW5H0EraNOkoPdoNsd?=
 =?us-ascii?Q?gVt8t51oLuLl3MKH4Kk8OdTWt4xzsd7udPBG/nZY7BqA5howJVZzaeibGMiZ?=
 =?us-ascii?Q?hq4LA7+kctzl3JIhr4Ad7iA76fM1aGlz7oYidABVqNsSz8qhmjrgk6TMLIdQ?=
 =?us-ascii?Q?AS5OYDgmwsFRspHHy1Hrjtb1IQjpLxgrweZ8Ts1a4VO4V/d0fJ5o26OLYcYu?=
 =?us-ascii?Q?HqoVRActRzkTKD+cMxppaPUTP3RxYiG9hqKnuVr7Yfwp7eeq6ZTdYczt1b1j?=
 =?us-ascii?Q?ycGy6JqK+ibPNRw4iw96waiy91iQ3yqhzhfiY3JJwfYfCD3aKL0L/5reUa4S?=
 =?us-ascii?Q?Gd58GMlu1gBOQuJWrCWAMbizvPE7IWLos/C31YcjAZIv4TL4QVg9w7u/3RoS?=
 =?us-ascii?Q?BK2iHmVtNmCXE/Y7nN+ibsMWm/TuXfT5JLRwZ+p0M+QZYrs6zqr/lH7r9cVS?=
 =?us-ascii?Q?dr+VaLW85ILNh6xx1F+51HikrbwzJjNL0ErS9fpQWtbRi4Fe9gWs/RUz2pVA?=
 =?us-ascii?Q?YRiG2UEiApm3j2SS/bpGTkf7hZdfBnERp0PeODz83fSOs9IiUmeSJgl2YHrK?=
 =?us-ascii?Q?eoGsPk+emjbbXbTQh+tp0hC95In7khYghvouo4P+jzW3Cuf3hI+8cza4unbG?=
 =?us-ascii?Q?ZWJKSU5fArxdxY+EscYMVsUJWr9xhlfMxfohMsq2HS0ohUj3h8CidNwwNMBS?=
 =?us-ascii?Q?XtJvWc8F4uyt2rvDD4OKKRHGwA45g9PI2+LTjUQNY5pdTrdAH8NK22a7ZNce?=
 =?us-ascii?Q?UH/CqK1+u7xQCMNdiY/RQIAO5Tt2a/OqFexmgQWaoNW3AFlGjc1zKdzJW2bD?=
 =?us-ascii?Q?FT2M08+rfQVpA4PUy06A/g2lT/4pq/PcfV56HfMhJp1P3+/ohsmP5KpmiWMw?=
 =?us-ascii?Q?tKyjwY/EAz4x9LlakR+pz1vSOFfFOmt9PpG/OuC/PgYVfXV1+IZGlWXFfA/c?=
 =?us-ascii?Q?7s5rOzQ/u69Npl+Shb5AcV1ty3iFKVa5WueuyEBd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7986845f-a32b-47f2-342c-08da764a2cc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:50:17.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5MV9XLlc/ty7h+jCA+HnzVxrUo+qx/3pr7bjEebVZdWEqsf1HcNUceiuYyDqgUByLoiC8+e2iBfRn1B7ONA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for imx-scu gpio subnode.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index b40b0ef56978..080955b6edd8 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -30,6 +30,11 @@ properties:
       Clock controller node that provides the clocks controlled by the SCU
     $ref: /schemas/clock/fsl,scu-clk.yaml
 
+  gpio:
+    description:
+      GPIO control over the SCU firmware APIs
+    $ref: /schemas/gpio/fsl,imx8-scu-gpio.yaml
+
   ocotp:
     description:
       OCOTP controller node provided by the SCU
-- 
2.25.1

