Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE94AD190
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347393AbiBHGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiBHGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:31:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A44EC0401DC;
        Mon,  7 Feb 2022 22:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8ixZmUGDkRAyCYAv1Rl7S0nRmepL1JSius1ts5ByJq0HmlT8yzN7Cc/6NpLR8n2YSzXfJZrfGaZo1NiZ5DeqSl6xoYbKe4HmTt9Vn74A1AkUF8qUBWuuvnX7l975gk1NbWrTXAYXvA/kiyuihtcxA9vscw41TrIEARYeKYpveylTtK+tpvCHdzhiMrv9UwIpW4L9jHzNzpneQn+w2WK7yfj8sa7EjX5CHpkZX0JCYfQkd0d5nrbZLljHae0VfBWOSwIyqnq22RStmboLtLVwGl9FWSqHkfYtRwqzK6IUaHTy7oSIvAPPHiKf4xr8C10mo1mChZQbw9in+YBpRqvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPZp+s77Ve/6P3iOecjID7PqXBbIuMj9e9Gx1X0x3UU=;
 b=NdCXIcDp2dFN8EP+uTtQiUPA4iEOtni2J0Phpl9GvTfm6rHJ5TCRn3rzq/y06Yjh7v0LspwxxkrPwVlixSEUEP7RuRj36lS8m3koiUn/TYhsRlAVRV9XoEIZsQXT2xLXuaMchoG1MuHOpfCoJVsvuH5qPBajJ+FnIMOJpnlHU8MrOBH/96mpl56g+69mcHuyQXHFbRC/CSRJF5Mhp/Tj+gGCY0qOiucS4VdRHlVbCckszt8RQzNsfpOwvj4RggV5L2qaELqv7q9NxHc3oveKP7V/dC/T6UasT8AyFtKiUfgFadQB6hXPT3MivR/ecyM77tuHec2I4SJvc++2hWOLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPZp+s77Ve/6P3iOecjID7PqXBbIuMj9e9Gx1X0x3UU=;
 b=aQann9VyAWKZf8n/6t3ZX7XA87Qt37AC7dVKWzphbgKQ6+kE8rwt7FUlkqGKx3wtKgFalsyV8Kt0bUDOzGNE6/D3FyfObGOl6nnhFv2cz1bAC9+devEA/iMtHWqU9u2pAvVwRjjo3tJdodRHmTl8QWZDvh8zOGAczN0J6SBFDkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB3531.eurprd04.prod.outlook.com (2603:10a6:7:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 06:31:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:31:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Tue,  8 Feb 2022 14:30:43 +0800
Message-Id: <20220208063046.2265537-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9741e2-a8e7-4cfd-4508-08d9eaccafac
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3531:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB353147FD092C8C2642A79165C92D9@HE1PR0402MB3531.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEIOXs5jnysqxIUZc3bgsJ8BBpPqZdvZICF0rKPTQCPyQsImhMJWLygiEH+ekZTiauBLo65sQ2dqNh3D3oYvseXqBy7qlbdtp4dammr0s41/9BgqeGkv2hfNZ8t3L3HnZQqw7Vsdvr1YVmJl+CdNec+RestA/qkhCTr/9J0Fd9nT3ZxTfE/ViIlLvS3+wkH70vIiEurkXC0T/LDfr36/ARtMgZmZoMb3HvES/QbgoVMCfSS2RfcDd9BrS8F4JbfLk5LylzKOsf/5Atf5wDhLNYG0lfTvIdrx1LOj0tN1oEmkCLmvM96dPgt7qW+eTJJsm9ji2QEp7ECprTxZisvgxuXJUSz5tqJkP+XjT5RDmdSzEtwC5wcK/pNaIgFdmqvumAyn6bV1SOYfDyo/7zBuRTJQ7jZTOGUq2I2QwlwPRih+wMuz9s0I7hCwvczpZgE2aU9+N/f+PAB1dPMPWbN7yRDzfmvJfFxztLU9PvnuH6Rtkc5ILmxPUtoc8bYSV3OUBoEk+4K28jvpDAJ1oS1UnMpIYRhkB2/zLwPNsC9x9JcOhC/nL4mrXb8Ck7N0v0vnDD9dC8s06w+Rz0Ev7Tzw9JYPBFFTeJot74QaqWUUXTRpqEv8KmJqpCbSc0u+cb8553AvPkBMWs15+iwTZhFtgZDyFGYv+knOf0ggE29ZOeH5rj1ycKPlyM1b+eOjIqm1JU5BYAHY3cXZmJtkjBFS/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2906002)(8676002)(186003)(86362001)(15650500001)(4326008)(8936002)(508600001)(1076003)(38350700002)(4744005)(7416002)(38100700002)(2616005)(6506007)(6512007)(6666004)(6486002)(83380400001)(316002)(52116002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWfhpoeaOryHbecWiau5Sy0shqwOtssx0iefjvLNDiMU32ukeFc2jjISP8Uf?=
 =?us-ascii?Q?Ig5MTwWU/466kzSQetfahohov14Hwf5MFe+kXBrtVb51Qtg0IUgptTqE2IP+?=
 =?us-ascii?Q?dtntqVh5CUkl1vVpjHncqxRnaYjju4h37835180eQ61Z4skIA4QGyXoSBRNl?=
 =?us-ascii?Q?JcA0tsKyOhZMU08YI9e3SnqwuUmTZGFXieyhSMxg5PQ6s6Zf+ZT3CqG9wMHv?=
 =?us-ascii?Q?WSfsjKOovYunWKtn4fDquRiDTmb32NlCLp0GToHNI/h1Fp6vYVSTuyDwxmap?=
 =?us-ascii?Q?B/AA4J8iHgfox0jW5GldrQDP7GBgQf5t17G/H9fqNUcb9jk3f3XBn1qX9pP0?=
 =?us-ascii?Q?jGlurAchVyP/lzr/Na9xBXCwr9GY2EcHrusOXaDwg+SPI5IK2eNP3plVQZlU?=
 =?us-ascii?Q?oE0DeNpyguqePYUZj2bfMljK1tZxW53CK7ublhr906IVqQGkufzOYa9FzRSk?=
 =?us-ascii?Q?Kz7X+lKVMUZjJzOtJ035WyXbAioCqwNStiJ52CkitzeN35YRUvdNzP3ZbD9w?=
 =?us-ascii?Q?GZZat4h4zA9zB98kE0G+NlhJlTVFHteEh/h6KwdjutbMoC6VD1uFDi22uYVh?=
 =?us-ascii?Q?wU5pz9yIgDi9d5oaULIdOVjNAiNREF41FeqLizlRcQsewuGxuU6sLBj7PHEh?=
 =?us-ascii?Q?uJxnMjeY6gC7ynC+v9QPjrB3kB001i2v2c0Aj43J6N0oEspkqUc2FywTysYC?=
 =?us-ascii?Q?5pjqJRfVAQspmWVhyKGic1Df3uNKGRtcFMueVoKOtNdC2jVfqjA2uB+dLNta?=
 =?us-ascii?Q?TpgJ5p2V9Wm+jhwQ63kTws74ui1+l/wrpXw0nk2/sEwXf++XEtLFcPOC9p0O?=
 =?us-ascii?Q?yadEyS1x2dd4gMjE/tHNcaYQWUSTuTwO52zdxSiKkHnMKmNJ/LSJN5yM5Yhy?=
 =?us-ascii?Q?7UPk7OHU2TgR6edbuuIJJmgK4eQY+J08BgJhDDX4NTH3C+SdREub8pVeM5sA?=
 =?us-ascii?Q?a08NW1xekd0GaW8lxUhFZiCbp3sfBIgng2VWb+EUvf4l3KwvDqzVqNZlqZqG?=
 =?us-ascii?Q?5KSmy7b6AQ+MMWXL/n5nCi7chAxkCtbkbyGRwfRZh2iv2lSOD/ixFChjZxEp?=
 =?us-ascii?Q?J4iJbMgtiuaXLwAIr/6GCPs37ZozGU1EuOCagv8JrDFOgvIgbGaIY+4IBZKF?=
 =?us-ascii?Q?7QQLKBPOfX9x8bW+FOeLBp3MxfVutXnvCc42+1f+/itrfnCofPiNbfBTFtZG?=
 =?us-ascii?Q?oaHVQ1jfEdhJy5vJ3WCLrXMb30+aoazP62tr3pcUX2BGoo08v/SHaJSZmpPg?=
 =?us-ascii?Q?hG5NJ9nNFskE0DvtHtBJLCANgDJ9NI9EEBcMKTHbaQq+6qQQg/g+wHgMo6Ch?=
 =?us-ascii?Q?i42bcOlSg3zLSW77IkhS0NcMKmV2bZe5jt/y/c2NmcyRLJjAeYfKBn6E7ldE?=
 =?us-ascii?Q?dFL4X2UNjmTkIYuKGmS3Zg4MnV/1H/PPlEnS/P8TKMMWxiLnOnyQyr+9o4fT?=
 =?us-ascii?Q?LScrVv02HUOP0HWAlTZVEfpcdIZF2NKkHhRI7nfgZSh/TKMdeCeHzF5cTYmv?=
 =?us-ascii?Q?/1dD5/HUr7O6qw+bgEC9eDJl+ONhQKZLUCPgqCjmwia+mZBvQkbtd/0hUP9N?=
 =?us-ascii?Q?X+IFSGysvhE8CgEkcHFFs1A5oISB3m68/SQJzVHOVaIqgjoe6Gh04cTjKZs/?=
 =?us-ascii?Q?XcFsnKUk2N3+nTuXk4uBBl4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9741e2-a8e7-4cfd-4508-08d9eaccafac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:31:49.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz7Bq7xAO3OdKvIc/p7YlXCjiypwi/oOuUEs5RZecPbjMRqexBCC+f9N6YZDojxhlDctMWTLGLcWhOBzfqGaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3531
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 MU which derived from i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index f865b806ae6a..6d056d5e16bf 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -30,6 +30,9 @@ properties:
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
       - const: fsl,imx8ulp-mu-s4
+      - items:
+          - const: fsl,imx93-mu
+          - const: fsl,imx8ulp-mu
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.25.1

