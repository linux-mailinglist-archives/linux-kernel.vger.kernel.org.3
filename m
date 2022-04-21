Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB50F50A789
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391054AbiDUSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391017AbiDUSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B354665E;
        Thu, 21 Apr 2022 10:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldv57zGrvGskWiVRv/ZUTdX5zbdcMZxPRvKvEVdJRCrvaieG7Re5qAh5BlPqXPi3rXuIcBXjkOi7nQojkN444NAKQZQIbbgd+NOqbI9sx9av+IRE56bcV3BZoxnDgS9fTCiL/xvrLGXfUdP1baXLHie9N/AowzPnTnGnju24nqfPrLjYLbScWENGwiRtrOnXQcmTRB55227P8MC3WQ/kdH2GUWYBqLumVbhQF1VUomU9jmKVt/SWc0SMFPDB9+ElbiNnMazrOJISFE3TY91R6B7Q9l/69KpelCg/erUdhFlTokwIW7hHMR6xTYtR1S4DlxaWMxXMf9W/G6dJuYrSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5/7UaEysX5/rTLMhKoKFqO2Zg+Suz0YTv0tK7vxX5E=;
 b=l3fjh5c6z6g/px99NnfW+TIlCgrZsp2XV49/biP8onw3USDN7e0XHzh5WB132L+6aZDzUfuyLPJCnQwV9fdRbWXOa7rXqOY+9yXwH1xOD1Bsgt1QnA8vFk22lZQfXMO+dqcE5owR1O11lFagt5dsTXXP+jypUmN331DS+iOYrcdeWVJMcbg/N/1d1LQ2nu8lhVdnOO2hIIeRTI/wn4uygq5HaMBgXcH1Ra0m6Te09e0FcoWjNAxk3AE+EvbyVaGyrYN2eKF2i3hTm3k+C/vpuFy/iMWSWxY9Ubmq31RMN4tkkZEyQDF82HxiUHIGK9/h+Qa7cfH+XpgOP4qTTqvLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5/7UaEysX5/rTLMhKoKFqO2Zg+Suz0YTv0tK7vxX5E=;
 b=eeG2eNQLxNEqNLZ9kzwhvcUB8uh6woRMrdA1vvSg66bLEq56XrjhJCJLt2psKs2giG0k5po++JaKpPlRq9GkPOMdZxZyg2Kysb294O01QwZN/mET8cfy6LbnHlZ7UHaLcEsUOVC0w7xBuAsB697PNPHiixcnU/GrcFZ2SqCDX4DXOe2iEP8X1Zx2edrOejjANznqHdPrFH50ZdTZKcNbdU4St5Q7qQMwweG9LgP/v+SK+kdZOGihbFhC3FkCldsVhNdrfbhHPVml4DE649T6zJ/T0gY57WDPf8hcp4FmJxTzHKB2Z/kVugATWCyUq5vyQ+h4S7R4JA8P9Drb3oV1TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:14 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:14 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 3/8] dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
Date:   Thu, 21 Apr 2022 13:56:52 -0400
Message-Id: <20220421175657.1259024-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f15e9b-d6aa-430f-6299-08da23c05db2
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB8101FC756465BBB5E30D095596F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faSlNl+dMV3d4EIa4FtmlbM0iJrEASI89fM54r50wxhUTVsmf8bhG0JGj3bqN9miGGCQGYqv0swQZ9obntps0NgWLGux9Pq/FQlBx1/Y5DF7ybn+r3Ba3Ee36Gz5RYRaKwlBroH+vDjheOBrxs9FaOL1rDB8MxYfUGZB9OmQZVolsk9adTlNdMNrHmkUW+2EWNqYdXIKfMEWFyBw8iNbMu9SHZCZf+qpUbJ1mT4xppnFsto37Fj2U3SeNry15dLwGEnkgbr6wYBtGxdP2l1Iq/38ZW29vIvIYqdH2ZiyZf5FKK8DFA9Hgyi30tsB3XwDVJVJIyG7Yizg1RLSSkHk79Pt0XWpydShiDzl+450S8xm4cs1RgJ55mFs7VN5yRBjxriv/625zMbPrdHDIprh/FgvZY0EPZyEI2oT9C/+NgvRteuOcICqV/2vVGhoUSR3qjdt0uc0khbgC5qiYpmdqqCvGFGG+0qHluoY4CDajNWZm6gr8WcptjnC5jRSxiixmxd6KcxwXPy1pJ3nvLX5mInknHc4kSOMN0yPAbOOSWyNfzOoEjUMjCYY5gQ2zMJq3Yb+0c1HnZKFN2QmEW8hoaJHwQoCNXUiiYTkzSIp7rNFHr1LRl/9Ric0HBkvdlF5DWEQtcNEYXWbO/emsyzX5q2QofsC6z9sB8wrzNQYgGm5m8EVvh1KdShI6Dhymt5UXJQtTwTo7FFWdj5l1PSpgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sRilml/cJkaJevMc8mdoEOmpC7dhaoPU/5r6v+EJS0EgL3nArNgEHhLThZla?=
 =?us-ascii?Q?UG0DF4TRfzZXQNlFdh7F3QXGyMwQvcdvFXFLsDi7Ntfv3uP/ZiKAYDYOBiap?=
 =?us-ascii?Q?UJ+9gdaygKrptwlH/s6+SQ65zFy9ciXXqP6RTWsHEmNoycW0B156tG2SBIFk?=
 =?us-ascii?Q?6dy5D6oaMZZIZBZYneWG8zILKKFha9PplABM0SubLSt8tjZiaVj19v4a6ZH3?=
 =?us-ascii?Q?ky4IWdguDNzK63M7IpXBsoku0hAMNXGB8XDzKWmBRJR3Pn08xLmBJTCF9cnK?=
 =?us-ascii?Q?UYEjkDVAl1fk03+ZGwGGEieHDMtx4WJcP8caamU3Mbs0tl6TDYXqFjEihoDF?=
 =?us-ascii?Q?8cynSmdoP1OU57WZr2upPn+8x0/Hh8bvz/Ric7Iuc20HYEB8vOYVEYawbg8L?=
 =?us-ascii?Q?1sm1wVALmmT2wtU0Bw6qmjCixsyx+7fHyZsYXnRMZ8J0KmeGSMo4ho2ydd5D?=
 =?us-ascii?Q?TSM9ABOoOOTt/sph/UF9SGeRujv0oOaPfd6NggXMIy9g8doerffnPSh8S/0g?=
 =?us-ascii?Q?t9U0rb8wxAWQCQMtMotAzhKWjQckbUFeivWiaPMIrwSi32T3Rl5ZjZrQjogS?=
 =?us-ascii?Q?oKIu5gtqapbBzFHjZPTLzg0aVDT24uxQo53117F3DFnKule07Sh2zMGsnEBn?=
 =?us-ascii?Q?QB+sbgMmX7LjKvThb4zSj+GdJ8AIMO8Sl0jegR0XANgyBumVxK7l5n/QaFWS?=
 =?us-ascii?Q?B0zte+2hdPLDBb7kkBQTybSLI2ZBiAXm8COnLC4KC2qjh8rvxMGmrcqaJ9h2?=
 =?us-ascii?Q?PgwR01Vt1aickR1ToAUAeF0qW4Itcs5szcD2XrqfNSFlcX64Z/nPVTC2VQ9a?=
 =?us-ascii?Q?GbF2Vfy2KjlAsQHuMSVRVvLmm8ax8kTRa9WVI39ytchO5UjICjqVbPHjW8mI?=
 =?us-ascii?Q?RXpXp/N4qFBeulSsyso8yLW+eQB10yannDDl5nFFpUK9J0YxHuw6sON9pHnG?=
 =?us-ascii?Q?6Vmwwq7MPomffWhirUGxCGFPpdyzBfZz/anyBdojqIQtFSTen/yIJfTttvtX?=
 =?us-ascii?Q?FzB1mpjaEn8oM+mTQo9VUSmu+S+U2ix1GlcEI/ivm/kl2FEDosdEgvL/DHog?=
 =?us-ascii?Q?r3uRRixJdEdBgA2uxSNjIiHBt5oH+FB2G0C80XF1hGxA9sB/bxxQVkJwO6HY?=
 =?us-ascii?Q?jW3wdzM+rpOdxiQw7bRrBhJq3CqdElGT8AaZl95EZpyqWTmtO0kUipF1oeSw?=
 =?us-ascii?Q?uLJgab1gnStdVIIjhc7VJ7IpQR7zr0A/Za1GUL5gjnwen4+nyEyZLGoydSiR?=
 =?us-ascii?Q?JeFl17LefUuHsD6CLY4ZrRQ0x32GLEwV+QoAoFbKPFbYyknBeIcabUtLPX3X?=
 =?us-ascii?Q?9Qnhjz6iiGVWS7bncWIFQnTX4HjLo6F94k1u5ZLZHOU2SmdyybV+EdLstxDh?=
 =?us-ascii?Q?MNwEt+/9N36tVH6f4iEYIDc/sZmzi4dM5pPMqy5r7ASkV9pxpF+r7wbMAogv?=
 =?us-ascii?Q?VltRvvQE/ZnhmBfmC05Ifuh0rPMfvCc0dP5ESagt5NALlyetqdbRq+rFniH+?=
 =?us-ascii?Q?Z54WXnhgWhhb/mPSypTyx5ENklfeEfFIWtlp9y5NfbEVwIrt87p4P2cN7pfN?=
 =?us-ascii?Q?K7MjDAeNAPAeBtplhCZFnv89mETdJlzDtCGgo2Op2COvpR4uuzYsw/+q4GhM?=
 =?us-ascii?Q?t0/F//XoAj7+47+b3kUE4mVgNJ2gGBvTK99KhV/Wr36968o+GG05/3t0HRRF?=
 =?us-ascii?Q?Pz3LbSvL91c/xEdipCHTXsNm7aZIYudIz1RSAC4slDSYVa8E0E7cfEwKq8I5?=
 =?us-ascii?Q?+Z0momyeJrr5kYteej0pSZ0WJcc+M7g=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f15e9b-d6aa-430f-6299-08da23c05db2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:14.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuzVyDNq5PUSgSJ1jGK8VLksDjDKGfCWdtBuLipL1I12rBedSdsFTPyKeLmpe2NcJ5C9oBAUNpYzE59ZzszEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TA_PROG_SFP supply must be enabled to program the fuses, and
disabled to read the fuses (such as at power-on-reset). On many boards,
this supply is controlled by a jumper. The user must manually insert or
remove it at the appropriate time in the programming process. However,
on other boards this supply is controlled by and FPGA or a GPIO. In
these cases, the driver can automatically enabled and disable it as
necessary.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 .../devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 54086f50157d..e7d1232fcd41 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -32,6 +32,11 @@ properties:
   clock-names:
     const: sfp
 
+  ta-prog-sfp-supply:
+    description:
+      The TA_PROG_SFP supply. It will be enabled for programming and disabled
+      for reading.
+
 required:
   - compatible
   - reg
-- 
2.35.1.1320.gc452695387.dirty

