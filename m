Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8396B4D2CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiCIKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiCIKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:06 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDF16F970;
        Wed,  9 Mar 2022 02:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfSlblHWtXUdKL5Klnul6BkcaKSnvBYP0i9xhgzMIp0z902kB70sZz5e7FzuntsbtZswTm0TTSk8tseDM1kBbnr+2X9/e7s37+sqU03r/IOh6Mj0Dhf2/bex1ffJdbJI4uID8z3fsqibq9+xsKTfe8f8vTyKxVKmY+P/uW+POOXRt+L1IhvNyZg8JPWNk/0Y1m55fJZKlxnu2nZUhfCK0n15eidlUE0LNGnSWpXvh4Ux6Xp1K+qaC3JWOZDzSgjEBvaRefc+uvAu/EGYXXH0IktrAj2K5/PiLGCDp854udMHJ6HI+U6vDTgALB890u86ZGD9SVJdk4UUCWgZ36RV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYq1mJTT54ZvXojXX6Pdv0a8WLHKRubphEpbj3qcCys=;
 b=Sj7Qry9Y6Bx+evLPNpXRVo1iIV8nJ0E0/nVgt+7JKcyKNkRtlN6ERpn+XiQ6xHP6lFWI+y9GcxashepIh9L+1fPDWyiAN1ERMRKM1X/8eMZpP3M/6kbhwOy67AzEG5SLSAnpxTDiJGfgH3lZb2NIonlfujgcQaoVYK2YCmPT3USqqAoZ70ofREppgazzkgU/z/WGcbNa1cxb8W5BR+tAZ7lRZYSG5u6rZLSVvzvxYHG7FHKD+ETs9bwGk61woQGsRbtDhZ2ksRXv74ImymsZFszOX0iyDNABIr2iC0jtTwOTOvgSHUe2yYkgtscN8/9PELEiCbBiJSlbeijYJh7dHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYq1mJTT54ZvXojXX6Pdv0a8WLHKRubphEpbj3qcCys=;
 b=hdlFHcuhAP29XBz7J71+2CwLEsI5WMQuWhuxeGt7E+LOkVK9LPv5eToMk63WvtjnmGQ/DB0az6IwbDGxTJom1PyL/Fj7Ttj55sRhAbZr/0t9sRGAuQLw/1V3+waZJ89JqlHfo3uqaZUHiDxWmDjdYSkSG0M3swmxdYn0Fc8xrWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6724.eurprd04.prod.outlook.com (2603:10a6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 10:02:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:02:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V7 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Wed,  9 Mar 2022 18:03:42 +0800
Message-Id: <20220309100345.2633862-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
References: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0bfb8c-f931-44b7-f08e-08da01b3dc4b
X-MS-TrafficTypeDiagnostic: AM0PR04MB6724:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6724FC34AEFB67B3D62F78D1C90A9@AM0PR04MB6724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va89enekfr0YgRa7IOTxO5PuerPXXMyJgz7NL3ibcGCTjFwpCU8km+qqZj+FWvlqMdjvlRkdNFOJsPovnoNoiuzwSw2ypctbB0hMn7y2NYnVY3AaHuJgNhJXXAewsrIizzLtW1sGiAhRsPl3Zcitkm1eGy0bGuvtJSkYUFvGUhqkQhOn5+7kL5udwSZ5O+7Iod1ZSDmIjim6gQH97Nmg3Fmga52ZylyvbmdItjSroG/ls51T0KPiYatCRPAKOsO10sUDe50BY6Zv5PIqZDoYFkpvfxdTilomZvwm9feYgyK2+eqwlHdLU9zH8dRx7xI2+CZEmGE8fPGhYaOGe7ONI1TBAXtN9W5mBSccRfKb0mrqiPM1IpS3j7W5CEp2TGp/sj4208xyoBFq3aBlkgtu9UGsu56u8o25lJSj8JXqQlM0IlCVtboSh8GgwLMfQw7IV2I+TB3B+kXvkjXFLkrkXPySjpsqtZ7dJjWmjnE1jAnW/i11xzX1WjvVzVjdNCHyl/XVcdaChXsUBLh1sBButmdcyWAO20yiR9fbUb73suXijEcr2A4avMZ9K0oGCuyxUYiDh/++0JaM2ehC6E4Q0Ku5fuwsacD6PD3aUFcyzjuQZbNqpN0+WX81Y2ARRWfwWIF5fOwGJZfzlDSzaWQtccXhXc73dhDsnh/kdyLDMocI39MmfA3Lh5v8xUd92+JEAteOps4Y+WVfvFcaRP9Pxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(54906003)(316002)(66556008)(4326008)(6666004)(8676002)(66476007)(38350700002)(86362001)(66946007)(6512007)(8936002)(52116002)(6506007)(2906002)(508600001)(26005)(15650500001)(186003)(1076003)(5660300002)(83380400001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkmRjLNDzNUSdLoR5DcZdTyNmpLDExgwPqSDbImQvbPwbAS0HMtDicNK7uE2?=
 =?us-ascii?Q?g90wfKx9TI9PyLw/sSGHasG35XezT6eWXWUGx/oeX9a6QxknVeUgHohakkuL?=
 =?us-ascii?Q?f3LSK4HkRRk5LcM6WNbRpolLZwS/OLBu4VmjE14b/QYhbI+82lkEsqhZznZA?=
 =?us-ascii?Q?84TEf1NG/AYcdZFrDDk1JPqdL6J2xxa5KQZ/IYBGaW1+obYorNrbb2rymXik?=
 =?us-ascii?Q?j1RMpfrfk7DH7XJXlGgLuM2eWOBIy2s4BdUFu++Ja1ZfNrcT7yoNkrWDazAM?=
 =?us-ascii?Q?xl88vQyU0QprzxGN5L5ZPALdYYov6L5NKYwjiduFO+NRH3Qzx04hgIGxIaRq?=
 =?us-ascii?Q?MJqpfYqhES4srSIOgIW9jKdQw6SGyPWkc+hQwdMShXSI8F5MSz7/tSt2i3rr?=
 =?us-ascii?Q?pgZuap0UtU7kDjJVZyT3GZUDap2SleuPShZG6e9rYXDLgKhu3dF3j/YYfmsp?=
 =?us-ascii?Q?b81haNnkVTmb+9CgryjAOfzqerHxKkj0WfHNcFsItS8hsTs1Npa9s0I3S0TI?=
 =?us-ascii?Q?MLdRcLNYhrao2S9NSyrSyb9vfT4SSm3Q2cxRnpxAU0SLtrNk74UwUnHw5Lrs?=
 =?us-ascii?Q?sdR5vDScvIR+mOMQTQL4TqGW0SNtoKA+epbVlKKIE81kO6j/RTsr9831WKuk?=
 =?us-ascii?Q?8syMa7RtbF8rLg0UuFGmNnSIyURJEZaW7Z/Ld9CPqrsZkcjGE69epGxHJWqU?=
 =?us-ascii?Q?FomUNE5wbe/KFWIs7JBhDSLWfE1ptAW6zFsIpRLn7t9gCc5vfsZuPLQetohj?=
 =?us-ascii?Q?yGPnkosarTEHEUvEqdQwbvl2oWezz9DP/gHv2Gwi2NWKdi+QzA/YxQCIHCUr?=
 =?us-ascii?Q?wkwZ5JgSUCaqpMKLb0FMdwfhA4rgWekv8YrjfRtId/urQUMEKdw8qVxgh02j?=
 =?us-ascii?Q?O2TwgL2a4tJ9Qt+/We8aFSrE7TBrmdzoqosO1lTit/PsWxsd6u2KpTLMxgWY?=
 =?us-ascii?Q?uTlYdP//tXR3hQ87vjIVOtyR/32ccg7T3aU86vMXDKloLNp2pfA3jyB8TR7K?=
 =?us-ascii?Q?lZCHw32yvPXnvhyO3LzIMZCS6LxWs17HakFXkhDZ3Gmpfvfv6mxJm0ZE7Sf6?=
 =?us-ascii?Q?CiQSKoDDdMWD1pLy71MtJ4bSqiuMAMZb/Fi20Sfli2+o5I8pHb0yt+oTLs82?=
 =?us-ascii?Q?cxNE7vVXNBcK2ow9FfIa6SUfcvFXvMNkUFl/lpv3LTnhil1CFaruFna49VaG?=
 =?us-ascii?Q?wzcJGx2tFXgtHK9+ScLmjQYMiWwx0O7i7DQzJBNnw1Lo55LTTVrGo1wiQoIe?=
 =?us-ascii?Q?gpgqskE4j+SfF3LikAjigQvMWfQMtxUkmP29rbfyojl2arPj4SPxVg635BQ/?=
 =?us-ascii?Q?3oLEqj52nHuSly18L4X4bz99hlDl9M/uXHxyr0hARd9dY3JirKQDbTPMWmcy?=
 =?us-ascii?Q?Z3iOGyAz1sbV2HzG0Bj9ZFg+uMlXqe9yqdS6UVG8yQYMD8p4oPW7Z4feroUc?=
 =?us-ascii?Q?e0fnAoHU2oe9S9DMjLqNtdmp1sZR2MFaziAEHVBVtyMj6KvPU5DR9AhMLwvN?=
 =?us-ascii?Q?7n6xqLlUFLsnIHBD7Cv047sfdhQT86cysGWY2OSckhTFgDyTBa7FXSKMnQ9A?=
 =?us-ascii?Q?aBlGon1lkG6Kmz6k57YGDxncBotq6s98JKLzGgnIYmHVXC0jBl+HQOM4HDAN?=
 =?us-ascii?Q?F6wkVXcr9Y4O+k2xQJhtMW8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0bfb8c-f931-44b7-f08e-08da01b3dc4b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:02:03.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDmuiqko4dPyN+npWC+dyenlZ5SS0/bPNY+0oSy6lx36CFuKNoWcK1R3VQYgu/bAoAF7kJKOTwXl6MAquCkJAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
between Sentinel and Cortex-A cores from hardware design, it could not be
reused for other purpose.

However i.MX93 S4 MU use separate tx/rx interrupt, so update
interrupts and add interrupt-names property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..7a86e7926dd2 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,6 +29,7 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
+      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
       - items:
           - const: fsl,imx93-mu
@@ -55,7 +56,14 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
 
   "#mbox-cells":
     description: |
@@ -90,6 +98,27 @@ required:
   - interrupts
   - "#mbox-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx93-mu-s4
+    then:
+      properties:
+        interrupt-names:
+          minItems: 2
+        interrupts:
+          minItems: 2
+
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+      not:
+        required:
+          - interrupt-names
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

