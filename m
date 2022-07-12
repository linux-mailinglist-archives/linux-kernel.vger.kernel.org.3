Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736C3571452
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiGLIUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiGLIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:17 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A257A2748;
        Tue, 12 Jul 2022 01:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ+Lkeh3LFONLZC4kpA7oHmhjYclq4wYCxgteMV3RFxZqerPkyiTZvHvA8v1xpV1Kv+VSz8ZulB+MmXAw1jMA+TYY8R8DWvTpvr7P7azwrGwXM6gm9fcRcIGOdcofC92eZv5GVRvlBQMLNgwCBUcy5yJFurJQp0DLnkwoz4qbLlH8AuHwBbz2pPm+4OKAwIsrU7IPfxd52grCAMxa7JPJ5IJCpO7xq37JzgpBgJZIQRmVRg6u5X94nHc7cl2ZoUH6JnUV75irEX8sm2WLefoafipc5GG+8S3KuP9tr46kb98YR+clSwycp9EKPr+B2mkaLExarCwdzBQryf9Hj+jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoOmRkczCbXyLzvt7FDJu+x8DTPmatNXpDM7HbLn2A4=;
 b=krbYk4fFkjcBzdkSHj0ZokM1rnIwYznhvVebxypPYCI2mJGEJEA2g5QBJkLsE3Gwxe3Pyl9AFYFy7BXZmRmDb9XvpC3OPJmX2IpD2QnqSeH/hfLS3ZItodrct9qq1mljJkLHrsFQgvbL/9nL7bugHtQdn6ifT7DZVTn7R2xcu2JGWQh0f0UTPGOw+vIiaVuXWygVeAppXLBYUHcOQnmhLYy6/YgxoV7uAGHLZWPouUjG4DuBdza3ak/sryUcaLtiaYZGa2XAPGeCaJLQpsCLPEBXnJrLAAoDkTp6wCg3wzcUkBhrRFqI8zEYY68LEzTeKju+OA3p1WoEJPPnDXRj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoOmRkczCbXyLzvt7FDJu+x8DTPmatNXpDM7HbLn2A4=;
 b=JWq1n57J8NvKjjFF3IOPK6AJD78x0uZMRUG2iugNTunQzvoC849yJWfIMNuFR7kQ2fTAFZ3ZLWPBl8bdpVimTDyDoPCGCmCC7Yrn4vaqgnt6+Dw8nheKx3jN4jfILjIimVYTXFouZxWe+3xbjZK5LiSoM5LOW9MvVC2srW0PjNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/6] dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
Date:   Tue, 12 Jul 2022 16:21:41 +0800
Message-Id: <20220712082146.1192215-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 128ad061-7bb8-4a57-a81d-08da63df5852
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdv8BGqX2hx4poueouQ/Ez3Bu7EY2uLbhyimDrFavN7GG5KqhtlTCyKSRkK2UywcXs/7yLwnm3YllnpvCAj3cezRk/uet3Z8F7CAWHbzJ8lScHJVZr3O4bLSZK4RZCtnoYJyygAH9Dy3m5KXBMFdtMHAjQPZ0M4NYYUoXp3eEbAcnIk5t6u2QnzjAMu2/C6EioCT1IiJUtQTlKyivS9UxM7U1aIj8pVJleKUGrNNIIlEMt1ucge3VEEGnBcyrjU9X1W9Coq3C+7J2MB09CjvNLqqcub0lF1mHh2tC/0On0VpjMXspbtYYwsjddJZcLeuun2aXO0Rsl1p0G+OwsTm1F3LKTyFtxlkF/RlKoLdzf6dtbO2nyx79HeaazNOqu2p2zuvPaJgV3K4rLM7gwVQhSTaUDBIu1Y38RyfAiQQyI8ICTNL9CnIqnOv+TRoyHS/tMF6l2mDBsy6auqX3scRXmk7B1jQ3UP/toJqPo9E0pyL79uoteUoXJy2HBJfsFMWdWqv/7xtst4UbcQU3964ZHbzU7CajT4RL5EzXyRaLHMOD+q2/vBfAbBjlCMNPd2hF8S9YHvJAEUKxRZWc3AWcrP5s5351V5E73oLuk6KGFIm9HMPeiTxTSxAGk/FmgLfH8Yzxv+Y40eI9eJGVEyIO/b2XAHoUUlmXMOtWzu/FLXE1/2bKdM3qmobNYnjN2b6qBDCFZ8JYrQaHGUS0Y5X0yq1f96kx0ZYqpSqaIbDd3GmBb6cCTglOuKDmU90J6ZNo8Nc7ZQUbbLKVgL8hvEZWQ/LM2aVaG8MLEjEfl1fl3XL746GwpptSENYK7w168WGIwqdbEfxBoJ4Z4EssOXy6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(4744005)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvDYg9HBLCo7H2TezHBzQDvFlifO+xapUbEJ9H7jWtj6SwLOTtq1nyOuzgcn?=
 =?us-ascii?Q?CsAwr/CFbrT5heHFE87X7yoQSTi0MX2DjiGfphQ4LSKfXf+RTuUYZicshkPf?=
 =?us-ascii?Q?jHjYjv3UxDzfURC2UenJBQ+H/hFIiooXZZKZZB28DJeOovtXhiTQLUmFy/CS?=
 =?us-ascii?Q?cd+BgxZsw5nX8wIRamqOTOVMaQy2FlYVLtKI5Vc0AaMfsuaXvQkAgXz1CJSk?=
 =?us-ascii?Q?VuGmeiDB4o0/dDjpdcj6koQJ5dpqm4E+E7NpCFTwkz/FercN+Gk5cmxSZ1bl?=
 =?us-ascii?Q?3iqxNpB7wr/UataVl13tVz+JaRrVX2V3Et1JAA5U8KGkvtmS+FLMSEydCTGM?=
 =?us-ascii?Q?52QVD7vFwm8EJE9nmRrjA6/kBiKw4Zid+decVcvZubRuMnUTYxezjUg0/nig?=
 =?us-ascii?Q?Nq8r/oHJcoY4ZcvEKC9UVpny8fbqA/uiHobQ5isDh2R8EGit0ZshEtka937K?=
 =?us-ascii?Q?wIEPdyGD+9klGQuXZkuCYAzyVdB/oLP+u0nilJteXkCdspO3F56WNZr5LWT0?=
 =?us-ascii?Q?sixMRBHND7IwywXyAL9nnrzcqibAZviRI+fSEmI6O1hey9MJ/Lf0astlTrCE?=
 =?us-ascii?Q?RiTAqgF6fEK8NT0v7jXfe6DfauzPwax1JnctRt2w4M5EqtZe8IYxtaY2Xc+r?=
 =?us-ascii?Q?ZSnSrBcS3KiJs1hD4pkgh02gE6RYkDdiIlo51+b6acaCD9zkRV/uyzgpwPsW?=
 =?us-ascii?Q?Gm/6atWcEOuutGuMlx1ANkSW+oSJ6v8XCU4TDz1IAuNlyjrLH36uOBFJRWwA?=
 =?us-ascii?Q?r0227/sXc4NrETgR0snYfhxAZkWjmlP5EtcQzUCl6Hq8MRVSvzEdydGGfABR?=
 =?us-ascii?Q?mqikGNKIGt+Hr+pC9I38IQNpSh26KvHamAca/iElv8RRy/7f54y4QWsbMBn1?=
 =?us-ascii?Q?rnwzPcbYBeesp3/qpaunzv/sr7ARVCJ4dYrhQLd2tc/GYruj4fA6FKA/+0Zj?=
 =?us-ascii?Q?BsRjR0KlCukDbm3vkwhT6cMpoIVbkbXMJuc0HtQyHd7PbXl9qdjdo5mQTrsU?=
 =?us-ascii?Q?jnOjwS6esp2G62OF3XrfYdugOm85TfAVnDpCt4mVpDiiFFfJMMtXTZFOYTPb?=
 =?us-ascii?Q?5gtByGEsP60z0MIe8SiNmvKSxAhqG7ClFVBfQjtL1x5dzKihz3am1xrLlXDh?=
 =?us-ascii?Q?8gOYxmIRVAnPGxdcAYPNWWwO9xZhoC4DOg8OptGdMZXqXJQiItnpEafKmHDn?=
 =?us-ascii?Q?91x3iu2tRpyBNhxu1Ft4RkfJry3k8w1YGHd96b4pdDNNHcAh/Uljt4WnzY7U?=
 =?us-ascii?Q?NcI54Kj+h7BEt80+0J9V6M3X2tHoDr1QzeyB1LqHoTNmxCoxXrTtVSk8CIq/?=
 =?us-ascii?Q?rQz9i+OR7tP3eAA7vDpjhgJ03qosh1gJJwdLJmbPiD3/ECEemqEoucGU1i3n?=
 =?us-ascii?Q?odFi4QK9h0OVOXHj0rp2t2yJotfY767R+skD76orVLQhs+JHuJmeL51qdpVm?=
 =?us-ascii?Q?nnH1UJ3uJvnad7yNEK1Wt2ocUwdTcaz1bpqyUfrLRtuUDn2EWmdDj3PIH1qF?=
 =?us-ascii?Q?UknKQEhFghpnfGIqPE95kWdxZ+otbmMQ2xlYjAetjwFwwXRFAR2Y+D6JdlqG?=
 =?us-ascii?Q?TOTrr/ZxS1rXkRPTnAbJ7F+w4rLsJ4SjymleXc9y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128ad061-7bb8-4a57-a81d-08da63df5852
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:14.0295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDRt0oC9oaG4wG4vdIQELTNSDox8E/1B3VEvFPXVY1S7DylPjVFms5b/LyJ2yI/z9evJ6CADifDDnHkMYL9y1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP HDMI HDCP and HRV entries.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/power/imx8mp-power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 7789bcca3223..14b9c5ac9c82 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -49,5 +49,7 @@
 #define IMX8MP_HDMIBLK_PD_TRNG				4
 #define IMX8MP_HDMIBLK_PD_HDMI_TX			5
 #define IMX8MP_HDMIBLK_PD_HDMI_TX_PHY			6
+#define IMX8MP_HDMIBLK_PD_HDCP				7
+#define IMX8MP_HDMIBLK_PD_HRV				8
 
 #endif
-- 
2.25.1

