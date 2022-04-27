Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0C51151D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiD0KqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiD0KqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:46:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A930D48B;
        Wed, 27 Apr 2022 03:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf9QefI+gQp5i/OrprvZ3kPkKts5Bskvz7R8Sz1mYzRLxJexXiEZ8rAAfsU7DG2G4eYIyaW2rfT3VU50w7/9jCZnXE81TL4lujerZlV/fJVnw6rJYolmuX0SLefE2AOgfBMwvaogsqivK4rdAfx/xQsG7N3wr4REvJZ3ITAK01Mt2Mxv5byvQoDBCe5UMsc0H7tetZBHJZDvUKldtBodWNrNb06QTS1LayJ9OuxJbWtS+ZC6tCXuqjRqP10/9jILKawZvgiz5xpLoOH+67WWHLMEqlgh2kDIi0/s+Aq452+R47GwfrH3HUdLGiugnxUVxuEopxcU61jt/v5rlrcBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RSdnDiSPbqqAZNDSi0sbe2T1tHx2wiJkhvp5GhLJIk=;
 b=a0bUCezeN+zJlaHX0lAvj/USuM7ylDHBpZmTUUAlEds/ydaAlt8S+jazC83eiQuiYWYo9ilLCq5phI1a1lVoTTxm7AL9ioIYlqPTctaS0dtoflokkpTSo4sO52wJIe4oAdl6UZM0bCwzMY14DZOQ6F9V1+1d89vZKqLULYFW1sjf39yKhKmtCwzMchZHCkThbeYf9xLRTrljyavLC0VQ2+qp+6FrBIaMt7ah/vWQnAoJfo/3XLao4QOlBLPi3CvJc6t8x6IXlHP/P0mNqli+v0zjmo8FFGCH8f3JEE5qaGma29AhwqmHM/nMRPupGp1ijYOLwj7ZgnAoyUhQ+jy+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RSdnDiSPbqqAZNDSi0sbe2T1tHx2wiJkhvp5GhLJIk=;
 b=cL7ivwRVtDKTGKGcpCY1VP9PmQ1+HjtVLVTHaXp8GyeRfqinw4FZRghzeNH89PwPZ6HmpARF4E5aJtMwCv3mBeTNaWGZAg31eRPdC+xTXamrw8sruDbV3zErvGO5N1theK0HZYSIgOplhkZmuH0rh/3RLH1xpFdFZ4El6R/tpyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 09:19:22 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::587c:b068:1987:da36%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:19:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: imx_rproc: support i.MX93
Date:   Wed, 27 Apr 2022 17:20:53 +0800
Message-Id: <20220427092054.3765690-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
References: <20220427092054.3765690-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2929eb5-dcf7-48bb-dd26-08da282f03d9
X-MS-TrafficTypeDiagnostic: VI1PR04MB6848:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6848F89528D8440044E620B6C9FA9@VI1PR04MB6848.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbeTc1TSwGEHiIsdMK6pCnPRzu06G4Q6sOjdiSx/FWkJnrHC90rUAxpiTuNYtTCe2ETi+Z/xuknN03098Svy04YSG97Nc4rACpHSv5lZvBl1mUnwxRGkbw0DI0JWNOe/RGUXN9pajql8uzIfvSnmRID7Xx75dQscZsfqgxz1nBCLT6uNra0aLA4kWPckK9CKiWPfk10w17equGr2Icz0hFE9emP4qiRj6JtAHEcMfyrs9zJShYAG4hBGDDkLiPr/Ziut0EwmKEGYxSGrz67w2hs489wk4xxKlGUcSfuD10hCQQBWeqQ7vBORd5AKrsoF4mMnEPmSM5E2m5tbYro/XSZYe2+tY4wTufWkqwoR0kvHjtKWgNqbs59n+w+Xtu17f9nRsIbqzkPefL0A9Gq1A3u3y2VJllIouPmv//xVxDmqMypb1zwkgVhDA2TWCv544MVfqAZ9e0ndKgPkk8pmxotmgzT0c3W38t0xCqukA4/nYCfDOZVr0PY3JyfJtf88kyCjqUeKKkuef3dbkSF/Ig6LPZ1ikOuVjprJCHEWWSKl9+Ucz06EuQfmBjMgDbcQDed1VN+K5nGdywPoS+tW4qFeeDfIZzgqXkDoj7pijYxDhJ5ZGXzveoUeV97VEpwjSHG+wsCpiwv0ll+y/TOeKBXssxanMbv1GBQZSjrfw6D+uzTessMa8LQoB8sD9ejlAnTEFGhjTYxaDXL/gCYkygtbsLqqOq/uq8IqW38IqBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(921005)(2616005)(508600001)(6486002)(52116002)(316002)(6666004)(6512007)(5660300002)(4744005)(26005)(2906002)(6506007)(86362001)(186003)(66476007)(1076003)(66556008)(8676002)(66946007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jZFs8GDCPjgUSRZvlg+diz/Z6Pyr2eqzMCKU8PxZkLMnFUirp8xwJup2pY1s?=
 =?us-ascii?Q?KXg6XJA4J4IhIJm1PNRQ+9ZPBQuBaO5dRfPBS9CuOlr09P9oiqkJ6BaADDtc?=
 =?us-ascii?Q?huvvmhJ3wvKjKGB9kP3T05OjG1ZB5iLtzP+3xbj4aa3lCip9iAYw/rw3JKyw?=
 =?us-ascii?Q?CgHYHQoEQ05JmdElHE+ObLkYKzGTE+C5daRGrIgHxn0tBvAxZGGXnSHpNOqr?=
 =?us-ascii?Q?AXC3Rm9feSHDYhB+tKhu/BfL/uZQyy1ys/V2KJwOsM/EAO8B1nflIxn5uBKz?=
 =?us-ascii?Q?1p7NiMBWg48/BiqWyeHrhGARwgBUxGSnWZ3fspIKSDLkfuBLlwSgYPg4V2l7?=
 =?us-ascii?Q?yZ3o2ynDUVNPEknoEJ6TRZFCldRGSdutFLMTkUrHEptLud6PiozjRe/a38lJ?=
 =?us-ascii?Q?072Xzx3s+h+3fLj4FZYeWd1tcvUi+oKdPn/E4IQejsPjB9cBfBpnQmU/wxE+?=
 =?us-ascii?Q?DAImK5HwC5Mj4ZTcKKYBHgI0JHM3TE+8VYwtbQ+Om2QNI6KFGrNhE1n8wVMC?=
 =?us-ascii?Q?oOlAwtYG2TD68f4ky2vcpjkj1HYCg79ID1CpZcZ0HQwBn1yqarPdQhc5kSQW?=
 =?us-ascii?Q?QFZ2RfvSB9PPxBPSSPUfLqy77qA6VxNS/9IvQhOdSeGiEOZIilGHl6kutx4S?=
 =?us-ascii?Q?WIWaX+Siog3XcPPySX95YKjhZEkrxpt/LL+4vOePfTXIZM5GO0pHZ2ZLUuon?=
 =?us-ascii?Q?g3OANL38+513uosja95Lq7fwyCr9K++fXxDaxdX7itmWQMMuzArMYlPB0ycD?=
 =?us-ascii?Q?uHv0rW/T+kV9K40EPTRKeKjnTUGob1TphK1knbPbu0dlrmbQGK75F9fV9qag?=
 =?us-ascii?Q?riw6/RaWn1kINgiwoT1EzhXAPWSVe0ZhELMNnhkNF1P6StYf4oyoGvMTorQf?=
 =?us-ascii?Q?+IUKwqJ1V3SJaNxnNz7a9ZfMJci5EaAL2uHZHvkzgEMmFvL0FG2257gKKomm?=
 =?us-ascii?Q?jVnV/Jqdh6Q7aKyXgUn6ufW7l6AlmDo/9VFTUbjOCIq9t2jAP02A6nvC2qr1?=
 =?us-ascii?Q?SDRTGLS3ZihWJi1mTQrRnRQRNyYBfh6DKYMzlFnkZDFMdW6owDSrXvA/6jCj?=
 =?us-ascii?Q?hgd3yrZP0pWamMCIns2WWxepbOG/6QoR32yvcfWGaPv864bVDwT7UITGOVst?=
 =?us-ascii?Q?TNTlx2vH+3SniYGHeXojENEgD0liafP2+hF2+zbtZkxrj/m6V7VhNLOaLvbW?=
 =?us-ascii?Q?9WV0ujwyahpU29vupfFN0o9pNj38zKK/+jozo9SA26Oqjtl3nWsObTvx1HwZ?=
 =?us-ascii?Q?9vzCxRr19mde0ByaZfdhQsInRmWZQJvXkuSdkt2HBch79z9vgBkisT/I4wwb?=
 =?us-ascii?Q?MggSa5pg9+h3eipv16YRw2fq9mL0AHM1RjoKJ9mBF7NQgLXoiwdVyrBnyG46?=
 =?us-ascii?Q?AYv6QwHEhsWeytl5qVU5t3yRYkKzKl7VnlrxXUz2NYGTJzXrWAP1TR3m8R1Q?=
 =?us-ascii?Q?8FuiRvQG/tG5RXJ6ihp1ffeAg5u6YmIMuOmnbCN7xy4qvYh8+w1tVkedfstZ?=
 =?us-ascii?Q?7k4e0Jd7RncTPI5kTaEZepNSntQkjBvVsQvqGcsTUbYYcThh/ZoikkE/KbtX?=
 =?us-ascii?Q?opRMp+OcQK2YkrdqM1HsAlSLu6syIwOSQ9ngJ1QatlDD7DKHHajZ3/dHj9WQ?=
 =?us-ascii?Q?RbJjnL13qmUSg1gJdMdQGdAS27cyzVV8o/ia9BUUITMlJVT+W+cmhvC7ZWmg?=
 =?us-ascii?Q?mJ54amkXUyiPuF9wPGpTUg0jexL4Ub4nUWljWqZmp+fst5zb1/8emlkCEojy?=
 =?us-ascii?Q?QNQZObe3yw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2929eb5-dcf7-48bb-dd26-08da282f03d9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:19:22.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CgyRWJG0m4RiUi4gpbPX9vefzkw0MNoVtQClwNHQp9xUU8v/WszbZWDiloOhmsSqXgmgZVsjtHZ49qS3Ho3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 remote processor(Cortex-M33) compatible string

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index fc16d903353e..38ffb9ec3c69 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -15,6 +15,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - fsl,imx93-cm33
       - fsl,imx8mq-cm4
       - fsl,imx8mm-cm4
       - fsl,imx8mn-cm7
-- 
2.25.1

