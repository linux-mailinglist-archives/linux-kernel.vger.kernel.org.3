Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE92551915
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiFTMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiFTMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:37:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BA15FE7;
        Mon, 20 Jun 2022 05:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVriPHsmThzkJA4TE2fuJZaoqbujLqu5GsblZXxAwHO/qPWsKltbPfvUZBe+O/UXu36/tmXtVsKDofSNSs9UMvrE4o+76pGla3SCWhCMrKudrttpQGVlqt8MGH0iLupv/HRO4p5Omnpz5aZhJQr8DI39pXPOisAJIDD1aeZJXNpGVpHaxRIzfDSU3kcSSRr9SanHYymIR4CwTQrpRDqaJsmZZVi59BZnh9cnJGyeJ7zUE51QjtHODVwyXLL7nRU9oHYlC/cBAarpAq0Pq0Z7QoMUrRUQRuaMwjzWyuA52SVE9TK6gJaawm19oQ5mqcOS0+NZb9A3UFDaaFXpANFfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg8jKT9xv+wYpvOnKROuqs4nIVHyK8TlHMIw5Sg0jhI=;
 b=WMAB9vp9CflLuAqo+JheD5CutyH3Rihm0wwNLZow+57JPUbg/kYmyq1wwv4mwDycAI7yvrI1ZvYKlcC/EvpgYxZSYlCToGQjpWq4g4Wy62ikQ1teWRKTiGAo9NBI2JMXETSaGOaAHYrnizBWIxUyfhbM0O++JCjWJGB3v4QefLI+THKszsn3GbPQJyfo5M7MpqhoKjJUGggcYdJ7mFGgnwPcrl37BCQ/7SaRcN43MAYY6/K/OADj8P036rO19EoN8KMlLWTHuZtPVLoIMcJOCRCZKpzhfeEhwkYVohfdkgnGxXINtEFJ+236Nczbh4ZF8Btp7ck4SRjBZDIgkiltvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg8jKT9xv+wYpvOnKROuqs4nIVHyK8TlHMIw5Sg0jhI=;
 b=lM04ZVF9c2viCYQ6JlcvmfFO+X1noUqP46AovW63Wgj/F+RApcG9NmYxPf69qNadNRnUCEppnTtNqKRAqrpf+p9lErDtjeGzORsL1tayntUPKoLViW98o6uNN1nFqKzz0dHhmbeppC8Ap3YwZo8bRV3XJzBN+snL66LLYRq3nnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 12:37:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:37:28 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
Date:   Mon, 20 Jun 2022 20:38:52 +0800
Message-Id: <20220620123854.1138028-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620123854.1138028-1-victor.liu@nxp.com>
References: <20220620123854.1138028-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889789aa-364e-45e3-84d9-08da52b9a2f9
X-MS-TrafficTypeDiagnostic: AM8PR04MB7873:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB78730C34FB01EA7D257407EA98B09@AM8PR04MB7873.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET3AzdrmQ8aq/xHtPD9wGUP69gB0kalxLp1/ysTCFKoia1UML4DTurewLKBi/sBUpw2/dAXs+Uj6rJ7DZ2jO1afqcC3yL34ZoI1mmIUpZiDu00kkITluWHBZv7h3uP2BnKKs3qQzax20A6lcKL17eTSgG0I8u1O6H8MSmRKxvxRWCWfBli0eUy27ykkQkdsS+s4yNF7KANFnCL7DG+WKrn5pt3lIsTXXQf4B7XE04yWGgmAVTPqS/hqNR5PDqdf5g9RbC4nN7vl6Gw67MAulD3pwQSjI/aqRLgx+txzBGcitB6DS/eM+5pIQb2OD2APaoOnANnTTNAu6C+WB7LSUMX6a/8W1drYDtiJeYLgqUCx/QBmyGWzKoXp4yKLYkjM1DuR2RnkNsCFFpjrYEkPsyYDuO/C+4U3MnIYDViCBDFA1aSgjFIqr/DlrsGV8Xbw00hfyQderM9gzGBGb1MNF2lEM5QbKbVDuV3t0tvR2B/IF4VOHLNqNUfjRMFAz9fRubEEjP+SuSYWJbwf7S/nEj7k6/NujSoRpAAPWMht/yg+2CBG+5f73dIM+BD50m56T9CakRA/kK0laCLX0GkHcyq81DEXuRN1hEXwhjFiQnE5/nKLmuVyUo+23iTonxrNDkK0FBRrCDJM/fqaebRIJIAcVXcQ02p42ncemPrRhMcBsvFIIyOP7vPr7p+S4lUNm1kIo77+v1RSA7UXv6pRupY9wVyXRvO9pr7559YmqWv32Cy90R0DQczuvc2FPthWBStuPUdu3PaCUsOpnlCfmD30Wpfz2+x15Qo1DrlNFg8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(66946007)(36756003)(8676002)(4326008)(66476007)(6486002)(316002)(186003)(1076003)(478600001)(8936002)(2616005)(5660300002)(41300700001)(38100700002)(7416002)(6512007)(4744005)(26005)(38350700002)(52116002)(6666004)(6506007)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25e0j1QnfuDZPPoPEjtlns7lT6XBRK30UBx9f14YAEpVmTaqk6n/E8qfhKKc?=
 =?us-ascii?Q?+ISJALwYJmZQ/iohqUftzCLl/y90nkYkmZW66JHc9f9BtX7BQAcSFKoqErIk?=
 =?us-ascii?Q?00Mhmxcz1MgECHQVZdfbXDS+qLSBA6//WHL/sF9oYrU4ENPcyUF8xInBG1ef?=
 =?us-ascii?Q?f3EJaC7+KsYKY6HDfiZYTOwCNB8CG1LHq6WMq+nTeJJ19sIKutTDO72D1ZtD?=
 =?us-ascii?Q?Bd6Y7nBcfGaZTHsSkB+ZrUG+xOIOUI8Ixly8qEnoonKi96MEaX9QhI0pkdZN?=
 =?us-ascii?Q?rZx0j9dludYaI+Wq87FyH2Tlwx4qqk7quI6VNby6ZD5oXO2svzfs2XNZ7CXN?=
 =?us-ascii?Q?fQlVP/EBJyMBwrqDMQy3kp2P4YW3H6e/zncy1rPM5cDh0XJxbhSty/uF5dfY?=
 =?us-ascii?Q?Q622bfBTEUu5nQUFba5TjDtoktg2mB18nAdZ6L06hIP4tnO+wa47t6WXFKcO?=
 =?us-ascii?Q?2y+j4alsJJm56tvtuerAyWvUtzCE26DPuoSs/Jfm789slbMzf94Gvu4AInZZ?=
 =?us-ascii?Q?n4LGRSX74nlX+Zoie0nQke80RTRoSQc7CPEN652ACL+/J5e1aDKkayC8nMtE?=
 =?us-ascii?Q?ZS6h0bAGgtxBJeMntB+DF3rgApq8muwHwOyuIMeunKo3jSQRYL3bD/pLVz5P?=
 =?us-ascii?Q?SWkK42MXvrJPI0WWVK3jcaisFjjUsML8Uz9nY0w652lsa5RwjHNz8AHIyV1b?=
 =?us-ascii?Q?EsxnUVklAuKGUwGTgCo0PapKyod3NYylkuS1pfyQVsiNgNP1wEWAubZcH2FF?=
 =?us-ascii?Q?bRcTH7ISd+jYIe3ggi88p+dkmA/51h1LQyBqGe0yBpvuxRhHhdJIqtKRKMyS?=
 =?us-ascii?Q?2XzrgWqe5TXj4hSNM1tbKCulAm4KvcghEe5zlads8eq5yyolLBgWT6fVH1xR?=
 =?us-ascii?Q?RudArif/5CepxDYllVlomERjr9wVC3wNt5pK7Mn65FNbxLH/6LvBeVtFqGxw?=
 =?us-ascii?Q?m6dqkRMesK5J9VqMG8MIUy2bDhvfuGcUE/xbsu5uhD/Z+gmvpoCt9nD5O8KJ?=
 =?us-ascii?Q?Ujvfbngwx9e1rXbjyMDFuqIcTb6XE+ySH7vhy0rgzgWfcA91t+d+mleRHDwP?=
 =?us-ascii?Q?Zlv8vf1Qg4R9N9NEQdmeDwq47Z4cI5SLtLEiJqunXD72qYpmvwM1sfyjMnka?=
 =?us-ascii?Q?NO0OxKUhoOIKTol0YtH47/W273FuurJFByXc2kcATEVr2eNpM7pB7uakhQN3?=
 =?us-ascii?Q?dgh1IdFRKbidn+o10wTzFAJz0iocy4R07hcO4vKxeQC4Hd1bealD1dcUv4Vc?=
 =?us-ascii?Q?xvzUr7H3u5Xk7DXGDVM32qf6sRP9MW257TFxHCDj2ju1cHSBqtA3qUnOG+tJ?=
 =?us-ascii?Q?1jllCzI/98zauMooTRQJUSEZGwTb6ESENnPcTd/Sl6Jn/M8ZyQgg80pzObZE?=
 =?us-ascii?Q?1lZOa5JVbMvWpluH+7aG8Jc7TV8p0ANq0ZuBMSuL/1JXUJKtc9rcdeRN/HTS?=
 =?us-ascii?Q?a/jpDX/82vIzIF75vRkx53otVQ9/8nFhOf0IgR6cG3zK6uwj5JzgdNsb6fAk?=
 =?us-ascii?Q?/DQ8/WSKreYTAsqL5VKrKprUysvdTShCHHzLmZkIfDalRlBJ8CQ+LoHn2PXI?=
 =?us-ascii?Q?jqHEDqCaif1B1PGUNYDi0QQ+D87R1lKIbyJwt90T4muL/vQBeTZ+/5hGVUIR?=
 =?us-ascii?Q?H2vNknB0SUW/gXBcVB/8kAeDlqiIAAx2PJao4qUPJPbXVr72tHZ4TGcHVh5W?=
 =?us-ascii?Q?xq1/YnfcZhWNSlUKfIwgH4P8ODSpaAPYcgdo5cnBQeRAzBc55NtGdFDlibyb?=
 =?us-ascii?Q?NILI6nuehw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889789aa-364e-45e3-84d9-08da52b9a2f9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:37:28.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2OAxlU1mQIEWbvGlxP56dIb2pB3RLE4bEEjzVYLzpbJSyX89EU2gJxWdi3oqIvjWI5lBojaxapercCcOBvVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Mixel, Inc. (https://www.mixel.com).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* Add Krzysztof's A-b tag.

v1->v2:
* Newly introduced in v2. (Krzysztof)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6bb20b4554d7..bbce3b060710 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -792,6 +792,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mixel,.*":
+    description: Mixel, Inc.
   "^miyoo,.*":
     description: Miyoo
   "^mntre,.*":
-- 
2.25.1

