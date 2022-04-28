Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB9513B64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiD1SUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350907AbiD1SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FD60DBF;
        Thu, 28 Apr 2022 11:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4cRYBs7x302oIfmqwfCSo6z3Bya5ASdgvrim6SxeKkS5uWy44SizmB3hDwuW86RqzBjHiWEWBTRKxBThu2m9z0BjBv+uFE9sDpgW54ko98tLTI8yIv60I/YOFTsQc7hOmHiC2O2dKIYXR78xIfuqmWEVs4ai1oqJLvMl3TyYYxOvEAHGGvRLXNq35gOFtuV60LLVsFRgfg8o9RlEwlZDUQSoZc0Ka5TIyh6Gn4kzBzhq6gGFkJGK4rrAdbbZ/WUopiS9LvSCAowGVRLOnTTldimr86LCW9vb3OkJ+0mjL6EPdx0jafBwq0s9sjSu/JCCmAlRgcOihouFHlQoHSPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK1kfQIMX5OnOhthEIkqw3AB4wIJzlyKh97MrKqUG0Y=;
 b=c9Hy+WeLhOkNEoZsox1rdTBThZPDjq44HvjkqkejVNDH+PJkrLobt9/SWuErzeoDzbxpscnHFfcFnBwcmrJ/F4HiDThxL7JYanIFdfCOam3nDaE0RKa4AKA21snSHJL97Rx0A1HgGFg1kbKZu082xZ3/2ddvb2+fckVUI/6CHufjhMHzLGznrLAPmPbsWjKum5Ke5XCbeMOrZXvRScD+uxN6KuErhq7/W1HL9QiVnAL13chSDPnfW1HAjdeuEn5dP+FDY6jIEY+lrRC5Wv2s+Zgkz74elyZWHRJLfdSoCQLKLM4l4oHjKhxNHh5Se+yxJcirlgnNCj/QMRncqq5z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK1kfQIMX5OnOhthEIkqw3AB4wIJzlyKh97MrKqUG0Y=;
 b=jsnCUuYutdHK0aXbGY+qQL294Emr+nGeLLqYVpUcfaNib/Ix8ixGOHZmtO0cWUukKwvH4hH/VcGaKSxdfGai0cl9Mgn6u+JGBYsKuJgh8eBawBLfkPGirmNa8ufOSN021iqxyO5Ys1hxKwISD/7h0xuHk3Um1laPv+/RGFRq52gctjZCL10fOzpcf9yJQxQ23c4zfoMdG43xyDeK4bymQSljKdvsNUGK3ygRGRG4ZTdD9sPeqQXyQNT/3g4gDZhy/cqa/qLIzsAN+PBnfj2sDzxFzJ5I3xUStyk1PWn2VNo6V6NSnhOY8jQay2C8+dUBTJkWE6JE3CV4fbA5EyhB/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:21 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/9] dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
Date:   Thu, 28 Apr 2022 14:16:58 -0400
Message-Id: <20220428181703.2194171-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79de2ca-d69e-4105-a46f-08da29435605
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB67751859693DE4705AD12E2496FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BstQGYhCkLz4Y62S37H6EaDBMuq84c+REf900DYTCALNjIuvA1BCn2j/PmOMFBsUUv7IGsKA4q6geZ+t5pUKHA1LLK2qnyZP8vx/5hCmdMrWQIet0lMX+XeSfvcPFkcZ/6APo6pJOx36s+Ejoa3l6X+5FcsxLR+dvzb6evKLbOytrqLoFNkgV1vwV4TfVY7l4cNNxyssmp/cC/93n1l/CG2QpLumpd7A9Z9aknZK4/GArlw3WuiHur/zG1aUDMCQa8/AfczwRTe13/i6TR5AFKiG71IIMIcPPqdKauioTO4EeZ2OCkvv8NTGFgujjTi5Kmvg+3EOwpn4v73ZoaMyj4GIeXhGtLPCY9QDS0omt8D/+5u1dR3eeCM707yAXxW3tJFk6Mjs4sTxVt6N1OAYVJcgHV3RlFYg/0VeZ9UqjUWg8F4dI72IHp1j8zBcaO3BHa2Evwj7ecMOpxs0KtifJUo2WS4KwAyygp7dWVN/9FMfo4r3OFZn5ISdUY8bEUtVLfxrlciHqD51NY515sKov/QkHV//H9ShEqoqw3ZthLzeny3hkz5KlHVmLrSLzg4XI2IMCbw2+Mul95xYJit4ZzlgDRtcn4Gh6eoDIrCllQew3CRgKA0Xr4YSW9s89XgTfVaI/ioJ5l54RFOA66RV+/5DE5Y3NvX8gc4dQq8Zmi/VxGhT4zvwL1wtnttdY++Vsu2JIMA3JTu8t3q8mWdCjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62Ig0t1a40m3MIFlzf7sWlo9A3gX+5gxrxj5xZCqRRXWAmXnBrxMClDijWAK?=
 =?us-ascii?Q?lP9/VxxUJ3L6gYJ894EX4kZyLfvTan8TsabDfeOmjU/VSe+2crjAc/2i3zFT?=
 =?us-ascii?Q?8G0ZYIbWWUukv/KktwH4URYgjvgpbfIMMAleya+J7VmjuktzZD/DrLGMRc0S?=
 =?us-ascii?Q?46jYa93PUz99ZJ+NEjZWW9jNgZge+ITLJuf03TQYaCbrMJgIYcASpZ7KoJ6N?=
 =?us-ascii?Q?X5SODuFnm46Y6RYvAa2HfJ8h94QJUkIFZvjupxFLudwBXRvX/adI97wLOJu3?=
 =?us-ascii?Q?J+WsDEFYF2FQPh0JgekSj6ail6WIKIUlVvd7d5sZV04qHUHjSXytvUJ9np6n?=
 =?us-ascii?Q?5DZ9H8+wBE/e7LzV4jLL1XcNiXxR0aD9SaX0iIaOe3sq0e4rLtknamM7X8Bh?=
 =?us-ascii?Q?pGuAgcDHb5XdKOW8u1IwAN0oFhDQKVrylwn3O2bgXFXZdkCrPjpetu7YFLmG?=
 =?us-ascii?Q?Vn60PJ+WhgV9/vLvBiAXmBN6Xo7i3Xeb7/XYWa+V/pa6LK3ZA8TV2Winbt0p?=
 =?us-ascii?Q?tSPADEdNR7TrNAqCE4GE7HlJan1imptq1QK8LQcQ1vByqmW6cm6MJ+OdmBp+?=
 =?us-ascii?Q?g5EAsZdkZ9vgq5Zmp910QDx7pNGVANaQOO0XByp52wFSeH0XKO5x2lIYXR8P?=
 =?us-ascii?Q?roNM77vhw4DN0SUkNjC8+2GPk2Kkn4NMu2woEhIFkEWItSAOKHbO7CyFLCX2?=
 =?us-ascii?Q?h+YQcIhXtRJOOxY9z75GAWX72TQhLnaozj90iydIdMw8d83G/peAlT8kwE2t?=
 =?us-ascii?Q?x048sh4AQRFBfWg80/WaPpFUy9R9PetnpH5zDpbv9XxvbiARGQxOrBBNDTta?=
 =?us-ascii?Q?XgcQO5KAn96MfZ/j/cuHIbxl1kyb/eNOMEROdv6zCmNF0VNqZwEhF4VgHOiP?=
 =?us-ascii?Q?yRZNbx2f/haw/oyKBT8zsVtwHSUU1aM50i0iGddrgTCbhsX4s8LVfbTtxk90?=
 =?us-ascii?Q?CubDoVQ01IpCzcQgWJQ2Ye9XXbEZstql6IYlE3++UQn7RuG9TW1fKmUTq/pv?=
 =?us-ascii?Q?tR68RFVhrKLIdz94Vyj2vdS9hHaFKTMaj450AhrI3RqvRsSAIKo8+YQ8gD4l?=
 =?us-ascii?Q?etIq+V6QPdpxguVbFk99gP/ybPJitMTtIuuzZzpJU9ynkEl1F2U17nC5r8+G?=
 =?us-ascii?Q?nSGePP7c4yAebG/Z+ohJlSweMxiv//SWAfNRlFqnC71+6CVl9/40RoISPSkn?=
 =?us-ascii?Q?sq773rfSBOdE0DCVsn6utv5Yf39iQGQGQdo7yFANQdSbZphjQWpS7Cg0Y8AP?=
 =?us-ascii?Q?n2B6v1VykenvsdKZFnFQ6wUdYhkqXBcYubiVzMbKSoK+iog/GXefnSAiIClH?=
 =?us-ascii?Q?h4Kg6+fKbO8TghZlJtJT4LDtnfjyKksH49G/J5yForg0GFkmPGnQzH9Grvyo?=
 =?us-ascii?Q?c4A057yC62FvpTrsGKMVJxsYKXWYLgLMbScYMTvuVLLCJl9ajyWK5vkSjqKX?=
 =?us-ascii?Q?/AN3wpTPe1MwI3Guan3m8/01IXwLpEpVk/xY6wy2idkjqb4xWIbifytD6Eot?=
 =?us-ascii?Q?Bi5ehS2VkoSR5MJR2Fjms41NRIhIhHiNNfeC8V7nEjr684iDx89s3wFWzj5y?=
 =?us-ascii?Q?/kDdmHhiSZTAQ/G1Cla3IwZGKMWrDpWRXAstmUhYgdfVi+LSTIlHv6gorMeN?=
 =?us-ascii?Q?eUSeNovws/W7+sszqALUMutKMD/lWEZ87f9Z8hGZb6I68CeLKooSwq0nryNo?=
 =?us-ascii?Q?8//PIQhDHNaK8rh0xG73h1yrzzx+muS7OQgwvJKxHiS7oa8QSTNTshFJyX67?=
 =?us-ascii?Q?7wXwTNBj5CHCtBuNNwXfr0DfxoZKFjA=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79de2ca-d69e-4105-a46f-08da29435605
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:21.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7pWUVZ0KYyAESZnoGTUus9kJw9SLt0yeQOcwG5K2ImLJPf7wnc22xIkPU/AexxHkn9L1Cp2t6gWcyotdOWfXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trust Architecture (TA) 2.1 devices include the LS1012A, LS1021A,
LS1043A, and LS1046A. The SFP device on TA 2.1 devices is very similar
to the SFP on TA 3.0 devices. The primary difference is a few fields in
the control register. Add a compatible string.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index c5d7375b840a..3b4e6e94cb81 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1028a-sfp
+    oneOf:
+      - description: Trust architecture 2.1 SFP
+        items:
+          - const: fsl,ls1021a-sfp
+      - description: Trust architecture 3.0 SFP
+        items:
+          - const: fsl,ls1028a-sfp
 
   reg:
     maxItems: 1
-- 
2.35.1.1320.gc452695387.dirty

