Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701304C6132
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiB1CjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiB1CjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:10 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6B3617C;
        Sun, 27 Feb 2022 18:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKuN1rD+9gLtiasO7lbvEvDcJWXEicvULFg9EP/AmJbUPOw40MR6abyZ1QJRb1PccrdnBaxu67kiQHhLY2oKVdtTRbYsnMoLXEACKl2JDw9cZDT2LswDAcKketvI9tnjQqVWin/CAljvoiNUyYa98uWYjk1EbEf5N9m7Dqb/Uz9zu8EnRpUQaXyk5GGBDiO+M8g4m4Sc9Hx3sDtVNvkKQx8q3h2egSKb+jWvWq8iqjAXcylzuW5pbKLI2lBz6lKCTZYHXdGFCi98IXTYR7rkRWOyUKrxHFKgJiOpSOA3CvWgaehFLDLgojWH0ehFfFiq1CUxa2hT5ROqxUCSHVSeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=nPT+Ca1tfhVreaiOhi9PwVPyC4lpLo+7GKXEDjnki3Vx7nAxXdGN2xKxctyluwV6P1DICk2DNIFeVFGsXBXyTS2TUbT2bjE1HMUrpXRB2Us9mkVruPKQGtq1pGklLoFqkE/oWSwC95DPv1M//vJ1PsLuhH5FiXlhv7TIiFqI0ONZ7s83wEj5FKu5w9hSfvAVJfqQ0EFMkDEhhRHT/wqxqJtENQ/EbY+IDtEGpFJfJHkVT/0GiLRI1yIAx/fkAcOy0+zO3z0yOsfJExdlSEcYEnDBP0PQUs0xyd//T3xAJuo17dw91pQQ4rwHqXX5nO2matfaZfUbZdrHx7atC341Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNcEpdyvLTOUk68LLfw48fPizjghW3J1eutmmHQeUHA=;
 b=QoKbLG8M4hiwsdUZpkw3U2kw5HlXXlKva4lwmxhIgRfMBjLVAmeT/k6PRGe8zN8VD5HxEpJa/CUCneX/jM6Qnyg3owTlZjnTA3YqhaKp5tR0V0IJwppEWDwegy9goodXFIJ0VK0pl45zT0G+ENXayDqu2e/1nxFQNI+NJuhpTHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/5] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Date:   Mon, 28 Feb 2022 10:40:09 +0800
Message-Id: <20220228024013.2866386-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c6ca19-45f3-4b4d-178a-08d9fa6366fe
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8720B2DC60B169E6DA326CEFC9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLWM2fKdE7mzqtyOfyamUUJhN9BC/DG80OUt9rT0l2oWT81iY6FlXFY5axDBg1QiQ9mpaL3VVviKkP5IzOE8V7dSHJam7KR8272Lb3pmctz9d8rWt/cb0UxpMizJ405e96xIEnxFW3NBkxifOsSCLeTHDtOc95H2OUfQpWkatzN1vTqjWByAIfSrhLcF3itdDRKUDlBDRWWi15zVr7mLEtSD2RcV8OMwRV4ANo/Bb551+MHKPDpoKnjzpcyUBNz3P+Oaz/HhkpAn/8ZwYigD816GaDPiaPEOAijWXN4JJ7nTj/K4AvMS17tVLXuW2+aUPSISYfMrba2mxG1bHy29kxhxFQmUh6T++h1Q2N51CNrnrpzwn8Zmn5Cmw12IUzRz9zRwV9PSkrzGRVUKR8GBx+QgpRdSv5HZ2ewh6YLlFvGK3wsROcZNNtsB7JZbBL+bG7a9gMnyRPHUtzmmfTdVwQgZ9mGuwyPRy9fui33JJD5Cqp/H+FgeqxxZ3hdy6IxnoR1mSzcTuM6It2IT0hB0DqAaSqzev6DJcP3QY2c+BbbIn9QA2Rs6Fvqc9aZ+fSK0R8qrCUwrTO5Tgxs4NoFQbAKOzD9GNccO5D7iQgwWIy/wy6YqYlw1ultiEkko/D2PQetUJ/QcEwI5P/wKi3w4uCfPMQ1KHHxhZzm980f5ViYuPW6o1V6WI8WOS3sYIxktAfRdDA2qzAC+pwvRVvgfbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(54906003)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(15650500001)(38350700002)(38100700002)(4744005)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGArxwVJ/MJR52pk+Hbme83mozQjDWuOwxPaYf4qDewEQfGdfFXEtULHKYTf?=
 =?us-ascii?Q?LlBcoiHl394Nfseryek9sEkdSPA67emFfTYP6J+iKp95uT8+xHzGeIGQPrje?=
 =?us-ascii?Q?pmcIomY12WuPBhNOwnoFJMYlft+CBPDoEaWK460o1rJKF8+DOR5fXHyRN94R?=
 =?us-ascii?Q?F7hgSuTGvE9lD+L2WI+BCDk4vY11J2N08V9oKAEZp1CVahalqubn/pB38iQ7?=
 =?us-ascii?Q?g9O8OSa1Lj4v58vBMH6zdV9XILO06IF4ax8f4jCvG4KbhFnYYz+sX/NBvRQr?=
 =?us-ascii?Q?lffJfPwMIRWExkAkC6rqq+BWlfNWz9nh1h3Xvg3bnB5UmRoZfWEh32j/K/qZ?=
 =?us-ascii?Q?pgpi9iLSh8z0M/r2WOtsvrhJtyl9NCHEZra051t9KpS58v+Pl41STpzSzk4T?=
 =?us-ascii?Q?NqTeVnBXx/748MpQDd8zQAmzz13G4BpakVu+XnyeX8tEwEyce8jNIwCQGn87?=
 =?us-ascii?Q?wNdRHpKVYdKACH6tzEueWdivWb6ItWe1G16vI/o/Q4AYbgi62Z7ZlL0H5BEl?=
 =?us-ascii?Q?RS6PMH9NRqyMpwY/iPZJlCf3wnveSLZ18gAKjpSNQ5tTJm4K4XnDgE2Ik0j5?=
 =?us-ascii?Q?ejiJDMy0Tma9R2bq98aKwa+Qoq1tQgwdQl924AcVZhcvIJ/YHL1/VCsme64H?=
 =?us-ascii?Q?fN9Qm6SHFHm0KV6/2+/NyNlsTcmxvr+kC6qBY22bObwhCF9OWl4n7aUzncvE?=
 =?us-ascii?Q?CpjfRN091YyArQjuCvOrENnhOahwIfWn83qum1HPE9umsb9BNNbK4Nh4NJHj?=
 =?us-ascii?Q?wEQbwnTvSW2SBE8S71gFaUTwKn5nlRO4fnxlYHuVbZITvQ/h37Zdj3UQhGZT?=
 =?us-ascii?Q?gLAIqweFuV4JOyPzhs+pSu/7vI2d85T1VEjkYmJGZjG+IAmupARc3gSf+hyM?=
 =?us-ascii?Q?FL8Bqtmzi5m+uK4Z5IsIcNdhVsm4rctndgdUXlE4plmVurFTDWo57r1aL8DC?=
 =?us-ascii?Q?zhyxCxz6Cg9thKnaM3pl5thqj82+71kiAYYkrvYNKJc7pnxYqLs11mVb/YE8?=
 =?us-ascii?Q?4ktl9x+bfNoL5tMnGiMxzhfpMhMig4TOtCACJsQbmaakFcH42OK8SiMxy2u9?=
 =?us-ascii?Q?ngexSOTzGQiYkfIT67TxJoJ1wz7upmIxlsOH7D61cr9l663LscuvyDaOXa0t?=
 =?us-ascii?Q?It7FpV+Im69K622C3I+1yYlmBFxozK8o6iKN8nKeKT9FFXUqPXwI/vuV1s4N?=
 =?us-ascii?Q?xtLgq318ik+pc32tGOr4vCzIIoYxX1YpxWQ3Io6rpn+4VbD+RYqqr31Kn9Un?=
 =?us-ascii?Q?SvfdzW1fmn7ISZ8U3WuLVUTSoOkF44l5LnXqUVgkuA1y6804VnjiNWCu36Xa?=
 =?us-ascii?Q?fQU+wHck+fn8vdVu4ONqaJ9ztuiqg82UFA80ORnbELPkqUYkObOKqt7tC9qE?=
 =?us-ascii?Q?ZhYRssA+yFVdff55khq6hBb6H+IIBT2Xy7DUU7R5LQnE24ytrx+Fsc4qY5dB?=
 =?us-ascii?Q?YRg2Ueci8N9Fqrqrwy1gqd61WalmEsW+0dYrwIVH6lOlfAEMWrrfS2+meI86?=
 =?us-ascii?Q?3fedlUetja1k3sfzsfMRoVip9UFX0Lq2rr0ZFU8R2ZVWGk88VCWjxbxtm/oy?=
 =?us-ascii?Q?pgLZ8+ZYg7erFcjjH6kh4DyLyd1+gRl9KPlyVn0YSy0ZBE9d9dnkeh9UbdLr?=
 =?us-ascii?Q?bJXjhofWgrHUHQL1ORYP+gI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c6ca19-45f3-4b4d-178a-08d9fa6366fe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:28.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Jg6F721CfnoxrFmzE6c2lfjGP/uy4S3NGrd5qLrzkcupfcm0nUzwuR+mqS/trJOA4pPIfpsF092zfMV84OD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
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

