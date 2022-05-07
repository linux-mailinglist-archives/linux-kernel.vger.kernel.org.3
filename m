Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9A51E4DD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444584AbiEGGzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiEGGzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:55:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD29826573;
        Fri,  6 May 2022 23:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8l7mtJrXlyUxa8Jg7lqBJ/un9tFtlL0eO2MgJXGTkx+pbrwble5HCRYgsqOX5bWteuRrl3VjEMGu6Zgj7iOpV44FDHXFP92JRZ6RVlgZpgAudGLfb2JHbXHaAq0L7TihSA1IUI9gsSjP4mThOJgTyygQ1ixiapv2kDUPpUQGtm8PJ9RpF+I1R+VdpK+OvA3bDJ6RF4SVsTKOuQYFdl1a8bDtCLII9In9FAiW6dEGPmIDlt9sxdfFdMzid0/8dWAFL17wgknJ3K7xDYq7mtrt/uVO2y+39jjVmf2A30sIl277Y+2wBRs5q9i2zeb6EYfPSWw5ZpNnk2cqzswdiLbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FttWrM9V8ZhNXrjs79ggIXDjvcbd2X+GU4ayIj96KYg=;
 b=S4iikzdwZSAmlJlON3nJNunE5xH5sM3uAngH4kq43Gx1d1bKIuvMmz7MktZ6Gu5GaAB2NypfEsuzmLxJvMXROAShKooXYoOiQo2d5O/oCM+NNB8KllTqFxlO5BgXNqcwyi6M7JjAfjtEF7GSCZ06gjFlRNHmUVKC/HxkFfCHQiAIg5gkemNCKpYDBKpCpGr4bsBSjNdcmO9jvv+ZJqxTtFUMABWn8Mawrarr9EX16sliW2ZIBXc+NnXjYIpl7xjkNoslt4+6q5QhyhzQ8TR7YpmMaPkvS8DhkXYPDIkZCgE84X1CkxCD/5VuI25mI9V7eBa1jUS3t9glT+PV3qFg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FttWrM9V8ZhNXrjs79ggIXDjvcbd2X+GU4ayIj96KYg=;
 b=SGNC8FLl7f3pqaIXhTaLEIa2It03+A2ACBYnop0SK2KoT+97JhUNfaidg4oQKigtGSXc4PQkq4dSZGoGPJcEAlU5iMZ/wLsJfBtFZ1NHhqnkOowj/Ml7gDD6Z/H0U4vv+AiSpS3kqqfDebA0fQjCAB1X9Bh95lc4xYxH3CLSkFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:51:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:51:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/4] dt-bindings: arm: fsl: add imx93 11x11 evk board
Date:   Sat,  7 May 2022 14:53:06 +0800
Message-Id: <20220507065309.3964937-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
References: <20220507065309.3964937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0509384-be81-4c0f-eb68-08da2ff604c9
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2527:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25279982C37D66924E74A0A3C9C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umndESgIgGUJLiR1hczS1U4EWXwHVckCczu0FRSUqdXwUfSgddF4CD1Wi42iPImikBk4/+KvX3mPpy84gxyIdff1zM3QYUOrQ7I25zyBAtkF5ND15R8qLd0yhummGxKUbg6+hwKKZJz8BCqbXNg4H1mHvyyYdgxdRh/f0pI24H2pRIQAoqiZridt0whaGkQCU3vsPtVpjWDwDMW2NEHMaLoVL429xjJzxr90aRZinc0TmuoCXf3FnGE71LGc91SeLDoLyaPcEXMmC50ccFQMl33RykAJIJTZnxOmQYqTWFQYoVWuVn2/x1vxjfJ5BMlMnhiv0ITFkpdW1m+scIkcpkqb3uzQyjwH9Ju+dVXy1ZnBxxnadWNlnBCDIILkJ1TjwBLvzqQ3P/j0jl0/iErd730DhOho8JwTgyjv4t1EDqTIbEsBcsQgojfhqQKyS85PBtHYM4ZnIku28+hdeHbZhFIgJIKL6mfXmMlqFgNzCm0ZIW4Nv8E6s1jWZpjCemQxNqzmd5JFx6stCYJJ2NicWstt1qXpFE8PaCKS9Qk2duWr7qTaZwo1wkBz0Gb4akMNkgLBph+MEgectNowWFPffbUcfBqgTDyfBG7kp9jH4S0vl+uwrmzImTGNGW+FXxWbKbOELpkHh6R+3p1r2KA/HnOYx7pIWuClyw6+1DqqVlaOuF4zEgxluNZw53P5ID14oH9EqhbM7xxt8mmfGBJ2ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(186003)(38100700002)(66556008)(66946007)(38350700002)(66476007)(8676002)(4326008)(52116002)(6506007)(26005)(1076003)(2906002)(6666004)(6486002)(508600001)(5660300002)(8936002)(316002)(2616005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?799c+7oGRw9bZkgdh18y2CUBF8Oluv2zXdYk8QCiFYUSN0+LouRgwkqv3ymP?=
 =?us-ascii?Q?wxwjZEL+tKV2UrzSF6MTZ/TAlGaskwdNIubWrYQQA4FVq9Efsf+33ZGopdD3?=
 =?us-ascii?Q?Vaoo9hzsaP4jkWBKmCRohfXwAKaGtZhCZDOeIjpffKQbERSI7Z9dLFaQEKTM?=
 =?us-ascii?Q?BP2TtxUllGRwG1ZCQdk5JCigL1ylxJeFM6urvJ7gkA5cA1vXstYya7mGuUBL?=
 =?us-ascii?Q?YnAgoGrO/TXFl+IzkcyHKSUCCBxINEmL859apB0ydKRi2bFz7D7/sAHEtTi7?=
 =?us-ascii?Q?pzsLvlpGETKXeXmgu9sZu4I8JbkOimfpM4dPtH/MjMSXEKDm5MQkqlUoVxeA?=
 =?us-ascii?Q?S9xrcEvK2pzPhJtVbQaMgmWlsZrgqAC3P9POGBvtimKwuHl3AYHhrumS1qgy?=
 =?us-ascii?Q?u7t+B/dredtv19m4oXskvxU5OdV+xDMNDRe3iLZowv0/CAFsytVxapJ9qTnZ?=
 =?us-ascii?Q?5zQ1RufCeQCHZQwXE2/pKXf0zcxBMkEJc+B+KWDTe1FV7jrOBQdC9erszt3r?=
 =?us-ascii?Q?L+sX/JCHdqDhfe5RDKDqsYiB6febNMv9gePbr3wnEQ/Lj9Xrne/66q5ZK6dg?=
 =?us-ascii?Q?YZqnCR7FjM3i/aExDd6gmvTfBjSnSby4Z8kTEG1ZqQUa+NkznMZrwpHI4P4w?=
 =?us-ascii?Q?2hdiuH/YIt5XxCDmmjyDH/Bx4ZvMr8uCUcqbjYePGrvZ/eHpSmmbSR+oQP/k?=
 =?us-ascii?Q?7AA5kLVcQ1yy2LJwM0f64f93dcd66xRoqNb7jYI9CUrxJzkilZki0CSmiPUs?=
 =?us-ascii?Q?cFF/Qguh9HHdLBGTCp/AYMIzbVywl0gKNoCEjeNFDudO8bYpn2sGE53C3Ra6?=
 =?us-ascii?Q?Q4r50YfKVXP45Pn34DdeJ4MAlhbJXEh6cYP45T5tef6z+7P/4H11eOiP4G4s?=
 =?us-ascii?Q?mv/xdNFNBbCDpQ79LZ6mn7onl0ywIAClPPmhZgSYHHNRq2mKVxVz+wmyB+Yn?=
 =?us-ascii?Q?MbiCCF+AGiG/Q5QrH3osCU+iHnMHfaoSGRi+C1Xa2+SNRyB7I+tYuZN/nxoP?=
 =?us-ascii?Q?w7Tokjtf5xLz7g7+NapFj36DBhPrxApyPKfGjVsTLSHMkVtXAH4+0bDwgJSJ?=
 =?us-ascii?Q?kppVSB+nbdsXksOrJ5H43jxY9WfZS1DC4LwO1ekVRl0nAkbzhnxju3pyEAn2?=
 =?us-ascii?Q?cUcC4uvRZ8Z29++wKKb3Sn5dEQ/+M6/7KfZS+nfgVgMUFmch78Hg5qbKI0qC?=
 =?us-ascii?Q?LfGQrAAxDqhrEss4jO0XaEKrtkFH+I4cUPbdWoTQ0YoafA7QUWqEXxaBtH0W?=
 =?us-ascii?Q?kSUybG1XG1JW0HTjXwQITkiMblOZlEsamS1IOZIbOuBvjgpU8s7q1AYiYtU3?=
 =?us-ascii?Q?1RnqJxuRm6OThisuG4QMG1dqWFsbylrY2H2a+RGlTx9c2CI3c+J5RD6PfPCn?=
 =?us-ascii?Q?Zxg89C2cumKBOoZlPTQRXxGIK7yAYJmIdUgJ6JokW+w+azZBxz23aCnbv7N6?=
 =?us-ascii?Q?0KEJUccbLDRiqjVuV3iaT51LtIz32+wMWOjbCkPcZILZGLk6FepBxVF1S2LJ?=
 =?us-ascii?Q?ltWE75Bwccx9tGLpLndkHFXUG5SbqjfGg532EnBFZaIp/Q+gewXOxlrcBivF?=
 =?us-ascii?Q?j0F5T1lARqbFXW3flL5cCcLKdvxrhov+77IFn+arSLWZ0sIwhOhZzmgLMSua?=
 =?us-ascii?Q?vWsD+C+rhRhhZeRaPtk/HwTHzBIIu7oJgZb29kng6WWINGjPvroRUXms/Iiy?=
 =?us-ascii?Q?2frry515DFZoMhbnYV7nN0YEBUdbLOMrveYmBniV19uTVSdmjnvcL+HHxlWe?=
 =?us-ascii?Q?GB25QpEEfA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0509384-be81-4c0f-eb68-08da2ff604c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:51:31.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+zqwaEDzUAHXQGNfqDTYT+YwIquOxL9f2iB3cNEm3+iwmA4+0FAOyCgfU/BBqciH5cDaL4XPap6LgPDcUINHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the board imx93-11x11-evk in the binding docuemnt.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b8b0efa55339..391f92282453 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -910,6 +910,11 @@ properties:
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
+      - description: i.MX93 based Boards
+        items:
+          - const: fsl,imx93-11x11-evk    # i.MX93 11x11 EVK Board
+          - const: fsl,imx93
+
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
         items:
           - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK
-- 
2.25.1

