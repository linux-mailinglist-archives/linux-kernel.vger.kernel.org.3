Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C284AD18C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbiBHGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiBHGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:31:50 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF214C0401DC;
        Mon,  7 Feb 2022 22:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgiP6khAUtQQZpcrsIloJlFFpXz1OSt0dp+MOS5ZpztD8i2xM44vd8mzzPNyGED86aa4qNR3fZnmTYoEr01p/RiKNCCzQjvlSr+T0UXCM/mlsa3lH/XHyjGgAEChRgKyiUuHaw2g4VfMsvyTnNiFrtt4FTcZGBfXcRfUZKFH8DbG9J1ul0+IxhYTicGSLEFdhQ1B40D08PlxcvgtPpVXLNwDQR0xcvtjMfL9EhFOiH1a+ROlFL3xf1GO86Ke3GTXUBDqsmIkLtCzrN5tzUUrDuAcrxPnYdKqUnRkkhx1ffXhValhofcvBmr40vI0rO7dv45kLLml9CETrKLf9AioIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUzkB+y1LlgJXUmoWMGzX6hWlnCS9YXvBi46Ty8glkY=;
 b=Uh9v70c0FUGsMLjE5YX3PUdI28nuoAx8ClGmSS004jR6QvphaamwkWv1vuPNZQKx34+A6b6mEh3VnJUAiB5mU+tmkrjU85DC7r7tXNqpdPKh2iyhqqCcMT0Ea5qPBxtCcnOAj/5LLlxGYFedeBjzbdqAHvsV7Jni4JsfMPsRsy9VseAGveVhN51vPH/Abr2QbpKx4ZmLZw1Ib7YWTER1moBlOLuekqve4pehNy7fZMSe4rQusUHLwRrFegW2coGUvDyihWFEyQ65js/aavySCJLwkvudW0tMK+C+InIyAj1DJ/vg4JH8f7H5Bj25JEQhA0/gfFGfY7M2Qi6Q0ZEW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUzkB+y1LlgJXUmoWMGzX6hWlnCS9YXvBi46Ty8glkY=;
 b=J1A7xHJVVekA1+/XpvasHZENTy3XptivKCmebY6a8qg258hcZZgCklU63zCskPKQL4HRQ7OAd+trEnMxQeVZHOQGQXol9pfTdf5jQ6dH7ZmMflQ8qF+y8zSqJyNrsgfiYcQXznLkjFFd0VYBV2Xz4UzMRWdDSSxsKAUFIIG+OVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB3531.eurprd04.prod.outlook.com (2603:10a6:7:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 06:31:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:31:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] mailbox: imx: support i.MX93
Date:   Tue,  8 Feb 2022 14:30:42 +0800
Message-Id: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff634de-5307-4475-0f0e-08d9eaccac7a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3531:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3531F0BB1A9894E27F5360DCC92D9@HE1PR0402MB3531.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6nv7OhshF+sKfbqkdIjGdb/sOAC23ebnQSaz/xjscQtfpghSFMrbEajFkx1dmNkQvCixoI4RqH8H2+MyJkFDGerqr330f07jLFfxl3JWAZS2VW7GNGB5XyjzIjqsnzxJ4dEtUzCsCuNs0ymGPY0ZtwVgJHDyZx6N5mcKne4epdPmFph17WvncFqWL5/siGIiMFFWe7B+o8Ww9JnpsZQsyAtE/m6E1cviz3N/rGIydsGxYDPqpRvqUB6DsyKwSPFwGftK4gBFRJ/JyM7z+gQfkWvlfvEs3fEt45q1NeUGnj7I+YCZRdleCcD0GjR3SQX7dzbJC2/z2EnniXmiBvoRsU8qFv0n2vVlOhL8CQ0CgUHWVs1LSCGtQnpaeVOfXXl/h9EjMihJLwhDV9GfpKKXetra9FfVReZC6c1JdakFNA6a8pjKQMinJARnIjMyPidxUNMIaQlspSowdBMCTePcUdlo261GLX7YfyQiBpJ2nEOt0Va8QRzSa/jvlt12zkHwpVrP0NqYWsBGSpev85sCXeioCr0/mgjMzA6x5cXJvCDs04v2V5/ssUGBCSvjCcofzqELcxxik+yAUz3AOtih76PKHMXhJmrOLHMcPabiNeAzdkUmkEqJEs85Z5Rfhyy2FdpZSMSL13Sqp8qflU2q9lPNYU4Dse8GHAZ8+ynRIsVj0w1/KDK8PoWU2H7c2xDlMoQIbBAYaU2BBIZDrXqLQTeSmCKmn99j/4ph7tjLe+eG8kxkF7xmgvzOYHluRIc10o/oX7Gzyz3iaPSfC0FhhQWE5JM4A3IXQAtt/ljLWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(2906002)(8676002)(186003)(86362001)(15650500001)(4326008)(8936002)(508600001)(1076003)(38350700002)(4744005)(7416002)(38100700002)(2616005)(6506007)(6512007)(6486002)(966005)(83380400001)(316002)(52116002)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnyiyeavPp18iq13ffWDNQaJpiPf8nXFknrsVTXXIksMytBVQz8UXQpScHb2?=
 =?us-ascii?Q?Uk2jQRTZ6pNxUo99mg/V4u+WTRZPNBNjKRXfHHrixeoN6AtuB7Sro3qtyrel?=
 =?us-ascii?Q?f91B9tK02wqosX2REyjB5YnVuMRGvTbXvdo3TL98iCaR8TzCBWiweCeaA3ct?=
 =?us-ascii?Q?QXDcOk3qnEZysYo9khcA9CaBRj6YdUjDvYlJ5emSDrMclzNxurHGYSpIeBRK?=
 =?us-ascii?Q?dqKFNyRtN03/Y4bWJOn0PYPDYEOX3eaowlRcpaVkR66OZGgJoBJPGJFuK+yr?=
 =?us-ascii?Q?TMFcXivMnmd2Q+EnIgzLHSdvfAFa9SKAc9y62teA931njJvm+Chr7P7XeDrt?=
 =?us-ascii?Q?GInaWZvfRsi0Nqfcluum2BXHMsQ09jaW3vFDS5eglZZkbDbs2vmZfV1mcSxM?=
 =?us-ascii?Q?QA50qLMxsPn7tnY+fVkV6wEDjj+L5rBJ4/6aMYMJN1jaQ+hSGCJPVlFbkdOS?=
 =?us-ascii?Q?i5u5WQldVZOVR+ydnKRoJc88FhzGnAh6MrYBNY8H4aiiUEJiMXmZRSA5sstP?=
 =?us-ascii?Q?/uCdnp3uXiG1hwl4FmK9g+DbBn+xF4NG9AYZmrG5UpTx0+2nBlMwv7qsIEcN?=
 =?us-ascii?Q?canJ0OBL0AY42L8j3KF3bbhUHThrxgkDesCn4vFr5kSM44rJLgqaVCsY7+yF?=
 =?us-ascii?Q?jz01vH3CZRZ42G8NZU9X9NFCnGXLoC3uDglx5po8ZkD+VHr9MRRr4MZ+tVRP?=
 =?us-ascii?Q?asCiBiyIJ8dfmnY3Pc+2mLnsEN/p9NWAXQ5BXq2WoWKhkd/LvhZda8AdSUZt?=
 =?us-ascii?Q?PO4eBwDwb7WcMJd2nZw8u09B/2shYrijwmS66pKXNy4SXGJCErKhMnYJMM50?=
 =?us-ascii?Q?Ke4Zxbt3miEzXfk1ZL3Ktkj+WswXNBbZxIhqavYx8rCSYuNwq6MAVCdAoLmh?=
 =?us-ascii?Q?HfN7WErOKPCoo7PihvOTXeuNjCneTkHPEwJS1TPkYyHgcVT7EtCkMrh9lOXR?=
 =?us-ascii?Q?Xe4wlHuFpOLDgslmfZ3PDyOb/lcDISJcN6YK5Yze8OKVQ28p/O/d74IgNZ+S?=
 =?us-ascii?Q?KstfpAIdD+BzGzEEUIHDus+G5xsNDQ5pQ3wNslKykyPCo6NdAtTWWu+bEzSD?=
 =?us-ascii?Q?QenFRLKW4S/5HeajpTF2T/XQvY7QI0KiGxFElPkrhJrkK9V0/xtKQsAkbWxU?=
 =?us-ascii?Q?kjwdS667uS7SzRo7OPj0VRKZmnHZuLWV/YQjDuQ0ICNDhbzZuRHaSdVJT8mB?=
 =?us-ascii?Q?AiqiL7Su4SzgbAbt1Kp7qOle7hfmVbhLqwoc0KW014Om8zBlg6tJ1W5i2p6G?=
 =?us-ascii?Q?USeV9nIeibwKZ5LIG/31vy+Np4kkQ4RoxCva/5tbHOrQP6dh5A3jSoQBaeut?=
 =?us-ascii?Q?bhZu7hf5IeFukUUpxVFY7UCiShq7Xh3/tPE0NU9j92vZONNH8qo2XasGN/xx?=
 =?us-ascii?Q?++rnpMn+67hB+YP4T1R/5lqXopshm0CbOV1kc6B3ZCBAaeMqjWuHqrfNGXSs?=
 =?us-ascii?Q?wMokD4dSW3V5/1066OT0N2H2pt9mesoQ+3jZ0WUGiG34o1RlYglF+TZGZno1?=
 =?us-ascii?Q?UTBnlpoZZ83wrSrlaKorYGL+jq2dg/zwsO1JNpSfXBQxw8Y5C42JNXFO4oSY?=
 =?us-ascii?Q?iN83MKxplcEgrtxJ1ZHHJIjt+C+q8wDkbC89L2SlElw6Ouiq2Uq9BlQXZZD6?=
 =?us-ascii?Q?/uzBXB0Htmcam41wyze/Njs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff634de-5307-4475-0f0e-08d9eaccac7a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:31:44.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBGoXiuLuj+nSKbeMzi/fhmjVpzcoHdwkFFOJsFDPd+/l4GOPfrXarzYbBelRoIHt37DHpIwSgqHeYbk9qAj/Q==
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

V2:
 Fix dt bindings in patch 1/4 2/4
 Squash author/copyright patch into patch 4/4

Based on: https://lkml.org/lkml/2022/2/6/304
Add i.MX93 Generic MU and S4 MU support
i.MX93 S4 MU has some changes compared with i.MX8ULP S4 MU, it
has two interrupts, tx/rx, so also update dt binding doc.

Peng Fan (4):
  dt-bindings: mailbox: imx-mu: add i.MX93 MU
  dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
  mailbox: imx: extend irq to an array
  mailbox: imx: support i.MX93 S401 MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 24 +++++++++
 drivers/mailbox/imx-mailbox.c                 | 53 +++++++++++++++----
 2 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.25.1

