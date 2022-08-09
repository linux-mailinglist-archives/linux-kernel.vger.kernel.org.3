Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3D58DA5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiHIObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243189AbiHIObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:31:41 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00065.outbound.protection.outlook.com [40.107.0.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3209183B0;
        Tue,  9 Aug 2022 07:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjOkpzoYaUT8lNzMGnfwEgAX1SiMAhpVLCMrMk9Av5qUiCocvSQ45u42lqZ2UW2J8UFp+dwzqLdScEES5q4vkVGdXXylGf8zwfRr5MYNzD+0Js8EMVpXgeG9+g44AEIy9o9/52Hi9h4Zk62kMuKAn9T4kiH9DvL8QZ9SjGXAnphS6saTic2GxeXPm5wuznSHf/8ndIolQkBxLFA6xBuSr8HPDPbbYd3Khk89g3MPGWbGHfnBlIP6TpVb4W5pBCmahIZALeGNLzLPqWcvaMprVGtUUYljL2jGhOMx0m6G35eDekZdnN/bO7LAsUwdu1TgFP16ibR95LP34584pZ1GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjGpXQf3WAyf5x6Wkop2P/00oqe3APvKmpWS/rTr8CM=;
 b=Y18wp79NiEsEhcX7qXqG8GGDYxpKrmtto2pVj+33iOIYc1VC/Pj8Oht6D9ZosPUWRdEbfUJZrC+WdE1jsc1cEdj2aygRoLMMg5zJpHcvxpwcySHbZ81UmC6+Zd6G/NI3jpOae3TLWJVrV7mkaZmiGHvq4vxfrjWAvTY3FxL/Rpe86i+z3nxISk//dQto6qH0MMIF3TK73bXhIjVNGVFDyQmZ3BlhOpjTDhPASwsLvmSe6Z3uodgROKEyQ03GgldMCyYRO6UJGQHMMpEOUc4Z468fiklH65/miaM8yhl/9q+xcSO+ICTPaZ19tDY8M0L56nbDy0/MgQy8eZZSPfuvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjGpXQf3WAyf5x6Wkop2P/00oqe3APvKmpWS/rTr8CM=;
 b=A+qyOCmsK7S/BHaZ8WIbQslnzsbsdywDabo6YDNrbikizdUJtM21vsAahYOj1OH/pH3Kzvjs1Run+bFfKy1UJkd8mmWuDQsvMeheiSJZg7oRFQAbwUiBEs5N7wQZD8OycdkQ40S1kn+JM/MvvdX5UATovo7IioJvQK3ofePfMD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5226.eurprd04.prod.outlook.com (2603:10a6:10:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 14:31:38 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 14:31:38 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Date:   Tue,  9 Aug 2022 09:31:04 -0500
Message-Id: <20220809143105.17967-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809143105.17967-1-shenwei.wang@nxp.com>
References: <20220809143105.17967-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2489b595-e46e-4afd-3d3a-08da7a13de30
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbDu0H5xIPIaCER1KxkEBdB8/J/bR4a2sWxVx6LRBn3q38i0rVEmaznQbFKzonPYcAW0scGBe3ssVoLlDaNmwxBkI31fBL6JcEUuoJBtNa8ZcuemNPKJoLeqY3jMvFFeITRxAW4Qa4PDpA91OGfzosgYwze2GaC6eFzsAMUlHzQNUvd/bRBImlbOTAezVhTnllbGedXaROgjyqQIBiubtVlEPLNuCk8Ra5EApOyR8JSPBI/Eqf8ttr9QZf9xUlRJjS5o+GnZF4ZrqXPseRICGLO2l3/adZqSALkdEPfbXDPxG5nARdINJfYkiB2BrryawQz5ricM6DloWrjSMH/xuwIq/5LP3GqxsCbGQzNFD60R9wX18aevfGWGbdHlaGW6X3WeGKnf34Idw0wcO9FY5KlFXx7udz35rXyOz2XTsyapQkYsiKNL4dFXCAsr0v70MDTRDuBxSKG6cxAkqmBLpX7qkbKy0nSrp+xl7Uv15woOOdeM7mvsXW3RygEdmXRIyRdPtJ11WtZdtab5GFB8We/3kqiIn5pjASkulv+mKzzjBTs+SWDct207TkuVSJmMWheP7c/W8x66SBhhVUMz8MbI9fYupGwQWaukwsIfz/maTZ9qI4S0M+PQPgOv68ub+NzeOaHKqF+Lrs+qdOlMhEAqMYnLOtFLRpbGLga4QD/RxEYJKxOQDKLYllM7kNfDa89c4FvMdUZuVoKZN0Y202Bq8+ojW/uiVfArV1nE1kQz91mjz0T112hlULOaJQERfFQP0MEpsfEd2lhhX8nozz2hc6JyVnLed+Lhkm43cgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(55236004)(2906002)(52116002)(26005)(6512007)(7416002)(6506007)(4744005)(44832011)(8936002)(6486002)(41300700001)(478600001)(36756003)(86362001)(1076003)(2616005)(186003)(83380400001)(66946007)(5660300002)(6636002)(316002)(66556008)(66476007)(38350700002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arvmG4y2YDAiNbabUFr0qB8yL6RK1gHJq+d8DQnzOH5w8gllB5ypNF3uBvfB?=
 =?us-ascii?Q?JAOTtjO/X5agU0WCBLEKhARrRieURAxYSoYUh+Bk37zIkjIHV912ucZt1LEh?=
 =?us-ascii?Q?7bRz8YYspCDyNVelF13RyUXs5HCAlSr57aRcWTT1KnQDN1uzHmJHURh9ubR7?=
 =?us-ascii?Q?TeNnShOxc9dgjk/ZSK3mTJOntIwZWuKoqObVVaIW9alOcr7wCqHo9qPKU5Oa?=
 =?us-ascii?Q?F8bp6pgEZwKNn8LSZckU/uwu1a8huCe2+Ciz6U8i0qEgSR5WTMHpgSVRumEy?=
 =?us-ascii?Q?j3yMsBUUTjeU1NDwDgYDWVvkAd4y7Ku85iEaQcfUzxhkSUJcmvvUL13wKHFh?=
 =?us-ascii?Q?TdZLEpFA/rbrRh/85GP4icu90rPtTZgJUVdF5X/dC+eB9ICm4yp0bM7cbTQd?=
 =?us-ascii?Q?hy8sbnqVfJBNt1+x2tEWF/IZ/JIj8JxBAzgpDpJ73mv/vSKU6g55fFklG4oL?=
 =?us-ascii?Q?OySPALS4CNrMrIN+TEUnWTIRBmpuex+Bxni5ZGsvJ9BAH7yy4h2ZOY2SrMO+?=
 =?us-ascii?Q?dTuT7o0L87dC5fv+WG1XqO43aK/4BRHDxqO62oFrnn/eJVKo24B1ZYySPJEo?=
 =?us-ascii?Q?68+YqmjbtU/gwvLYtB2CtzO0A/nniA1w+GO3l854VWxf3XRQ9icbu4aHq/5U?=
 =?us-ascii?Q?64qRnZEHrUs9aGYqoT+owp2wYJ/wWtlZrpjeoPGJYAS/W5/DVzj7qT8Eq0Mg?=
 =?us-ascii?Q?R1JwYFM8qK5F2ZckmoC/KzERXtdQkrydxBuu43sQZoK6XW0b8NsFylVxgscP?=
 =?us-ascii?Q?ynOmQ2w3i/Hs3ZioXpid6L3vsuZXAjIPE1aayvTX4nsPsdG0FHihw1Tk7xzc?=
 =?us-ascii?Q?V0qq1gwOxwupVfvdG37Bj7+sQtiDYxb0CXZiAt2wT4pt4RvK4SVgP3mlWQu9?=
 =?us-ascii?Q?wkQm/cvH2Bt3iP9H7Cpo6/CoS8Vm5Vft7Cr1wFgzQcbNwDXXwNCGtatWFPDP?=
 =?us-ascii?Q?H9XTBAoC9ki5pIoti8gVdt5LPoCOgVS9adFLA7JEbXscTfSez7N4/jyUThWe?=
 =?us-ascii?Q?suK5K0wHCOgUppcMnVJbzYPJcrryeqyQ6yh6vPrzei5lVatfZ3WxQzZbSBDp?=
 =?us-ascii?Q?Hy24rW4qs8E08CRt3SZ4frDMQAzJBD+UdElugFpMkAv81yNqkKpG6ET3SgyY?=
 =?us-ascii?Q?3ivUA1DS5Z6e50N28ufNa9XX6vSwAs3Eg3yz2BNwMoJ5rr4MYYxaSj8+6YCL?=
 =?us-ascii?Q?luM21NTIkP3wRkxWDrD8MjrAj7DMDFNP/tKjb1wgMBwbwVdJ0mzMlDrCltTL?=
 =?us-ascii?Q?S334MHUVqRjSaZbnO0cP/d8stl4GekBkOVZkrDOykNzLs7METfRy6ESe9BeM?=
 =?us-ascii?Q?3rHAc9PK0phdSXfS0CJgJ9nUsnFqof9mnm7WuVOdQT6YttH7gpEiOCOGnvCp?=
 =?us-ascii?Q?EOhbBDWbfcI2w0twfcOjWy8j18gLSb6j0Qn8OJBd38Y/nVa+tOT+Rx94Bv3C?=
 =?us-ascii?Q?Syj7jw5nAVhCwKdieJJNQfmurqvaK+kp15W3vyB5/f9GRsao0mLC3fE30t8z?=
 =?us-ascii?Q?/Z+5wcDPnuxx2rvx89MSG+Gp25kSaROUMwRXHmuCZNjMsJ3WqPclDSffP5dE?=
 =?us-ascii?Q?1h+Vxi7RV3scbAxZZz53i8hBBk0O1nHk+Frfe4mf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2489b595-e46e-4afd-3d3a-08da7a13de30
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:31:38.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUA4W7vnSGgJawC0P3iTGEPe+aEF64tN3CB5gdbtglqmMisjRTE3goLI5/VjKyWY6BMeFZHRq6CzU+S5zbeUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index b40b0ef56978..afcfc8ea90c4 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -30,6 +30,11 @@ properties:
       Clock controller node that provides the clocks controlled by the SCU
     $ref: /schemas/clock/fsl,scu-clk.yaml
 
+  gpio:
+    description:
+      Control the GPIO PINs on SCU domain over the firmware APIs
+    $ref: /schemas/gpio/fsl,imx8-scu-gpio.yaml
+
   ocotp:
     description:
       OCOTP controller node provided by the SCU
-- 
2.25.1

