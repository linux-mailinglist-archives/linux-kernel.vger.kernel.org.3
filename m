Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9853FCD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiFGLDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbiFGLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2611C0C;
        Tue,  7 Jun 2022 04:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfUI34jQgAG+Q5NINg/SWj0xDLqCNVTXlRlovDEXw8E97DF21QcfwxUENxPRjOI08JoQI1oGBJHWyejVzfgQD7P9YFEWZDSomJmfT6JfdR5BVjyqgLE30Zpn2N840sHjK4sMHot8Qvcn+YyLPqiSZ7bMQDGZZrNeOYxI7VQVaxZA8jd6SXYPvwgvcoglXu0GOaQFCb4TC6AMDr6lv1tH4RtZlPcfY/XJED1UtBsmaibDLRntBzn3eAIypObzEqVEOVGwd8Zui9GpYanr1viirQUJ+jfABwmorsh0GTuDlg57mCQPGOkZOm2CUe5uIGvi1XVI9GVp8Ecmbfapv6qAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u8RcU0Wc0+puXVZMXAX2EL+jVxNuSmLW3FrcunKEwk=;
 b=Lt+4YhHne4QT+vCiUGx4e4dn0hspbcb0LmXyc0QIZPBo6BLMg4V6bHBZ9ns5+X8+Q5uhpKScwy4tVDm05Ql8qtbXUV+7pM0aEstCmc9xOl/xbBNqaK9UREJvXfmsflh14YBBG6a5xkJ5fXXYdzOOLsne6aVIuBUCUC5tZJ8Y+FEDZK7t83JFZhKVkpVxsP1lOFloRyM8HTujLepCwPYBQPqyTw91z9Na3+vQ5VkPNpLsHJFu2VUDCm6nFrzhQwH7FPAFN5DjtFxkTyQ6ZSI9yb8lYJWCBQNGyxvXR+NR3k1U0pGQnCQ/sWmK+TOcnMyN8NsxT82qYj9sWuI7WhWsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u8RcU0Wc0+puXVZMXAX2EL+jVxNuSmLW3FrcunKEwk=;
 b=fY8SaxsLcEPKD45sbJruaGG4r/Lhf8DZoYuAta6prQkGjWNT40IGMvjxbgqLXQ6oI7MgSrKmXPu90q7x8ji1BGlPH28AhgD1f0Vwf6BfstRAZhNioFhMK6dxAx/8qDWfWbi3kTqjDMNXqA7nvOsciqYhN7WxYt4VrppaYKOPfJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:19 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] dt-bindings: arm: freescale: Add fsl,scu-wdt yaml file
Date:   Tue,  7 Jun 2022 13:59:50 +0300
Message-Id: <20220607105951.1821519-10-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 541fc193-6b1f-4a25-4038-08da4874e80a
X-MS-TrafficTypeDiagnostic: DBAPR04MB7301:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7301E542E0CE60CFD3F22A41F6A59@DBAPR04MB7301.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+LP81rl22z3GDy87vGQvWlmkLc2j1kfZy+GHbT/Zj2eZi+y1HiOr9qCNW3e26foj7jDPuCpKpoCBUIqKHnjMk7fu0yLuIxjcGsiiiWtBqyzCPB9b9BH4N38rrFenbOhRNIU6RMgsru2r/Z/fWPz+4dTfv2LoYWq+acLxE9++gGwugTvsjdoQnpugvkvVlhx677/CLv0JvNpwA673xntFhHPwU9FELHRJTyyLH/az/E71AEHvJFXIzZoXgQHI+7JsSmizbZ3binaBJlNSWfdSfO1FED/2MLVjxht5Vi+kJSdSUN4sED5eEj7WNYMtpw8CFY0OOY275k9iLf6cbpNNpVnyUUYVk3AmuyLbm1gtsjBC+1014HIYjhiNGJ6cvZcbQXBOfhkbA5upe5jpjANCiwMHbP2MSrxwdAhB+V47nlI4nQwrgc+s8Da4VtRQ/Bc30Q+H/UbZFZLTH0Gdqp0/upFlnmNTiLsWrv7ws8gVIOKo0MRsCjvxwTzVtEyJD6RB4al5j+wcaFbONLH3S3zgED8CLv6KbpXPGXERlhJ9Hf83TVhf4ofMZU/3zefG9yBdWyHtfD9NyA3Bw2xXGgQzrKbvvRlIOJSkOyBkvVeX1ci6mg9ENp/OtDjArdmeSrJNjFNa4YveVX2IxDoJ1Runi3HGM5scSCSbnev+tzssflPHtm6xkhobk/P6U1LjEWbZHpt/xq+2lTpZIwXk8k41GvtCNBnLFgq6jB0y2gs18RFTo7coXoqPuzzK7V9FbZ/MsdoYgMcLSLRzjM/eRrGgUpNeBgoQFAWc0ddAo7WTZLliGbETS2FcOXAHVR4IDQHXFbCu+RSEBTvcVewI8Jg9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(83380400001)(6506007)(4326008)(66946007)(44832011)(1076003)(52116002)(6666004)(508600001)(38350700002)(86362001)(186003)(6486002)(966005)(2616005)(8676002)(2906002)(110136005)(36756003)(66476007)(38100700002)(8936002)(54906003)(26005)(6512007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQE9X6PBhiLh+ZvdOxl86Z2fTIhZIBTuOfSjkt7DC/vIkDHDU32adpicigaq?=
 =?us-ascii?Q?30EyqRHVZn9MGsdZWQ3i7zbfNK/k+Ipq9yXsPiKzlZiN2Gv0rf7gAjUsTItt?=
 =?us-ascii?Q?2R7LTzUV04JNfjGV/qLW2LBoCsCIq+0DRRuBz9J717WypcPulOBMTim2/yfm?=
 =?us-ascii?Q?x3O8yFarhLm4ELxFYzw6+TYhHveBN4aqR7pFO6MtiYUsOTzNc0NWbflZ49/O?=
 =?us-ascii?Q?KYAL3XHm7UopAvmqa/VoSHOyaT6A8N0xan2skbH2YCPQdp1IcNYQhMVwgsCQ?=
 =?us-ascii?Q?9+YMovhSIMZt3u6KMgXmTmawJdu451DfydPwlrV7lKkXBTJKDoS6/udY/hlD?=
 =?us-ascii?Q?suy1sddewCZ9cZU+NC79KNrvYYj6nOUK0rwdB06cJd3mroGy99A44TBK5hcb?=
 =?us-ascii?Q?/Et68IpnLJJ5s+kj1FmB91hfEDnCDthoOU1IE5wlWqNTRKvKuu3TETf6lv7E?=
 =?us-ascii?Q?Z3lwMEkXhTQLu/ez9aQvSeZ5LOXIYoEq1+AdOWATlYmWD/G2+nXDhuxGdg6G?=
 =?us-ascii?Q?AsihutuNhHD5dzbloH9P1PVj8U6PNw2f2siiLoAOp39eq8WuWgzsTzEKNfaA?=
 =?us-ascii?Q?OvgMSvf1qX/3lXUw6MoR7X0bBoyx+VbTS2Mmvej8BsbBqGsZWhw3YpcCMY8r?=
 =?us-ascii?Q?8Uo2cvf+U3czkGMJ2Y50SBz69Ku/S1rAI6v+vuKk+/PZXEE+9dtSU0m1DM7H?=
 =?us-ascii?Q?IEUePw6DyRIqUhWHX0HK78PEUGyLbuuoBtLhoFow5cBbqCRZORrDJf1U1/Bu?=
 =?us-ascii?Q?9mGm2MiZrk4VyBiCFRM/OG+USdN6aqgsIuvfPSB4ZVAKrkaIYqiyvp8cWhxl?=
 =?us-ascii?Q?YhoO8mO3NN5fKCtNi3yMa+nqjVJTtwcY5d7F3KqQf6gGGfp7+xShfuSN/9IM?=
 =?us-ascii?Q?XQOBx+2MF9eoJllQLqZFJusZ6+VP4zFoHzn6svsTYRnE3EUykQMjVu7HpcOY?=
 =?us-ascii?Q?xjgpNfaf8G+GeQ04bWorfro8IHNhn+/3qTf+JfndtulEScPf4hTYiuXy7Bf8?=
 =?us-ascii?Q?u0IhxXXjbXlfpV8im03fjVD0aKHXwtO6dFZArIm+OE1nLHrUb4AqGd5pODSA?=
 =?us-ascii?Q?PFQKsQcPEnuXBkFnusyGFJh909CgQI0UR4P9390MrAdldKTx7+a4ArvpnVCn?=
 =?us-ascii?Q?+vOzg4MR1CdYB44hvYLLJt3PEHYpEbPJRwNUfzpVoLYES5XSqdmazZ4mLYfz?=
 =?us-ascii?Q?vO/hVXLDjYQopIAKuUkfKbrLgUeW3BDqB7BmKdfOc2BFiiHDI47vIfwZcYyn?=
 =?us-ascii?Q?LBpPTTCdGBLCGOGUkvjPMQVnm8N1ZBZ6kVrX94l8vuAf2DcinAdVMel10buR?=
 =?us-ascii?Q?jIc5Vw+d8XmOVTzYY4Hj2xeq4kE0FmAcvWoYNudbPezhmose4rXG5N9Szenw?=
 =?us-ascii?Q?7VFCinMDPzGjbguAhcQH3wZ2z+Y9KejflcSNa+5wkMd4KGucG2Szz0P431yr?=
 =?us-ascii?Q?KUJUfLjjqdwUWo+ouoW3w44QcCfakcyagdZREmQSHbDM2RfOi8kh9v74ZUfO?=
 =?us-ascii?Q?j6d6ran6kZmPfEveip8cMHj/Jvl/k/D68/aVbaFuFoHBoswsB+u1tKTGFrif?=
 =?us-ascii?Q?8isxRXmzzc7OLzMPQzJ+vT1/tXr/zYhxcjgzjMjlMVya6Q9W9QLS7J7OD7Xm?=
 =?us-ascii?Q?znwdPTWFwkh8+sgjrENg/vvQQ/6IBATeTxHaHT2Qa9MOuP1shVjxBIfGVZyU?=
 =?us-ascii?Q?WZqEd+fJ+YhoJn1CSwqioZJPvhaOLXq3GU6fsFa99D6il8r3/3nU6vHm1mjJ?=
 =?us-ascii?Q?vZY7NBgyvA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541fc193-6b1f-4a25-4038-08da4874e80a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:17.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBt9g/GZIvkgYopm8bEMxahDLvZOKInZqcOOneQHIECI8hlEHyQd7/RzMJkG6zUJPLfbCwyPsv63otPBZweP8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the watchdog child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-wdt.yaml   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..c5d71ca83963
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-wdt.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8qxp-sc-wdt
+          - const: fsl,imx-sc-wdt
+      - items:
+          - const: fsl,imx-sc-wdt
+
+  timeout-sec: true
+
+additionalProperties: false
+
+required:
+  - compatible
-- 
2.34.3

