Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93B657E1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiGVM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiGVM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7773CBD4;
        Fri, 22 Jul 2022 05:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAokvWcMJneKQqNJHG1vJTbKO9/6ZY2RUH2SAAvnuQkh7X5xwriT+B6Cdt2rqjf0M1sn125aGFFhME5gu47CWmJEDCBDrMypgImaD+E1eatblm+isvLg4YsVjoaUe2LEkXsHCqGGy8Xnh0yESndSaocffevwiiSeJ5sSuORym/iM1YTrrIPPBOQJaziNL4noveudaIl9CLH6wZ5/hwv0hFElVCV7llWlSqmhyfxotoby0SaiaZQIDJ0vMCq7/QsK8Kp0T5720EysvqUG7puYCZJ3/+TNve9DQecYwh8nhphhnp2aFVq0BfN1rSHsorbd/vn+0cs8GBLHnaS0DIwenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f77LvFnHuEDLpu39Wyg6gl3cytTb7OfhayJX0CMNYI=;
 b=NRHXfEWDdUQVuNg/9mPyFmJcQkYmauwiY1u5KSr2Jc9XD774fXwLpNEbpycPTsCwIkpMlgP7Vgtn48d1GNOEohunRoSdOhnuf9tizCXWPdInFs8TFtPN32jITN81F8KHi7eNwQ9t7fC0KRJVu1iFlEY7JE1I334drd0lATUnQVLalLVCdwkXYOYtEmjVrMDFihVdONnvDq8vYgEGldiBWcix5Dpk3vhW3E6LbsvPpKWecrZYb/6FwKGeyoM4U/neAoYHZJA8qs11+Ra9wZ3RIfa1015ZW2NFPU4iWAjadG21/PRGBjuBKxANJYC0m9RAcnqBjmAOat/EsMxYaWQfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f77LvFnHuEDLpu39Wyg6gl3cytTb7OfhayJX0CMNYI=;
 b=PFpOp1r2aP8bHgqK/AuD2fQwqm545GzOCev1szPib17i151GH6N6nC3+VY/M+ZPZ43kBflIARXqO4SEgzjZlcZdK+1+caK2/uMDHDeRnGNpC+8ZNSHFS224rMkS4yRsTtAzpXU/ZX1CJiuyctuGa2oyPmogXJWb39VkfpATMrSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 12:56:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/8] dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
Date:   Fri, 22 Jul 2022 20:57:23 +0800
Message-Id: <20220722125730.3428017-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed9f41b-2bd6-4291-b886-08da6be18767
X-MS-TrafficTypeDiagnostic: AM9PR04MB7633:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8NwfBfFv9r0PZieppH3IKR3Nq3i42ckbUDKNZiEsnGJW+GwrMqNfdkyXurBxqVPqkF795mkURJkU1EYmKfipmUBGl/mG6wbpDIJwHnddoRF+0MzcZTH7XOMveqy+Jbs6+OGX5kIcj4voTlfmD/xgoPk9pFSSjAXUCf2RSi2N9H6qFa//5NGkej9RNe5Wb2kpyr/baQYGpjzbikIRaiG3CB+1gB+5E72TaUSlxIe+GTArijkR/ejPkuwyPxLnamsL9RzCNHg1qsS0JqwfvWzx+xx9D7V5FJfO6WHIp+Ta1/aigLofCZtPRnEQkPE8giW+ABqjxOOpGKJRU3Aedlt77PA2GcOinoSVO5mxS6nxA1IfMLx4Gh8PL9+46p7O/Vge1X0fAjW37HAkLVnvfDxM+PLf2V0IdXosz426VWU94amO99yV04R+9xY87tcQ9qlngFT/45VZeE5Y0GUbntB+SJT7DX6G5Ne7bn58VeiDHCy5OQLmTtNq+z17/I4ifMyfy2LyM+RddzGEMg76jRwKPEeUE3N7rMD87wLh8vtWV36Op/NFdlOyO/V9fYVztoLcrnixHskBIwuT+t82p37xeLxqnVRGt3wnD50SwiV7QekaDcoziMu49LaGOhmye78DTRvgWzIXlR7GW5fx4xK3PsYGQUxxLQ+vijs9fm0JKjacN7hSi4IWNKk/CWiby+xtpJYzToRcVSjEfNRmDm8XYYOpqGYQwVhtNHStDpdQHbZ260POo/HewXeaFFOWZD4Xngr0kGrCS9trNYJOIy2bK+1UhviODdOPvf5s/W/wGQ8AgzStLKpWd9TLEsnlmYrs+EWiy+7K/CYw/RqQ1VS81ORqaBEwyxEAgDikaiHtzW//9BQrmjVoPfE1OA2Ztqy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(66556008)(5660300002)(8676002)(66946007)(66476007)(6506007)(26005)(4326008)(8936002)(52116002)(186003)(7416002)(41300700001)(86362001)(6666004)(4744005)(2906002)(54906003)(6512007)(38350700002)(6486002)(38100700002)(478600001)(316002)(2616005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SThjtvAnWmJLItiFXx83dXwahSHJ29jM7hOvZ2Ln5yi4RxfC+cwdSUt3OSN?=
 =?us-ascii?Q?dtWDBSDdk/VsD/zSdeLbldNJtHaa5lWKGAqCUdiWii2tRhRBVVKW8F0Dizef?=
 =?us-ascii?Q?uGlDGD0HZ7ugxUN8OGIFAatSCg4hqkUOKT1UqCeWhrX6XNqo7/noHCcNmgsk?=
 =?us-ascii?Q?eFRZOFRS7GhR8DYQUH+t26g+2LuCDCpFB3m8q0Unu91oGgojvQs6xaw3HLUm?=
 =?us-ascii?Q?BDx3NjGlHtLx6cVEQOmr+G8iQL38IsFmsZnL+93lqnmqtC/W7PagqblNTgb5?=
 =?us-ascii?Q?e+mWnHfgod2iULQ35cUOSgQb3IlMwwOVq8kZet1I7O+PSzdqV01i7jO3LcHH?=
 =?us-ascii?Q?y/7IdWNt2r7x0g0yDM3lKsj9XEliU6qCzGQawb39AKGOUNo6kEI47SmrQzXh?=
 =?us-ascii?Q?h79zivaFvaBqkyXzlzMSsqZcl3R0hOh6HGQBKYC92QLLer5u/JJafnlu4vf4?=
 =?us-ascii?Q?S9QsK3Q/tYNZTG842jsc8PpMu/b4aKVtedQp9lzwSGelmShPVvqVqtm3wonW?=
 =?us-ascii?Q?QJey4j0c/MytBJPg38kWzl6Gk9LfN9K6M9nOSu3ATDwxIZ+fpApMVJ8OPNk3?=
 =?us-ascii?Q?2V3deO9jGfpGj2L3xhhLL7gpBfqxx7mcA4DtDgcaN36jVI+7I0/s/FUiRjRu?=
 =?us-ascii?Q?y+xhZhbOga9tXVXdVQWUJfKxy3NHHI+HA5+1+HnnPrQQnbx0ZhuNXJEYp0Lm?=
 =?us-ascii?Q?Xg/6Zta94/j8CN7hn1FOWNXIRQ0TRbpCHPTB6sCeC4UYhz3rwCgNrItvKBjg?=
 =?us-ascii?Q?mG+Ty8cFpSbpsn0BQM6S98jUArcgF+ApTkbCYQIv8RawFCjSb2Y0HyXsdm7A?=
 =?us-ascii?Q?V+aLfSiCnVVJGnnKdgZQnhSvorOhvsQs+E4ILJ2kARMgoazDmAiSnJJIiJOH?=
 =?us-ascii?Q?C44fgUFEkJ+AHSjSi+dOJPwyGbeLAaisKhgCv5Pv149SpeUsw+cjJTrDe8ay?=
 =?us-ascii?Q?4Zi82jOq6WjfCXAhGfJrOPo9l0w/KMsATHp2twzBvETcZmVHR+KkwMF2TQbp?=
 =?us-ascii?Q?reuareL5gKvNFXqxi1Xq3s8h2Z4PwbsmuaZhEmsOAlIzwdcJkEMDScphgaS5?=
 =?us-ascii?Q?hUAD64GTnIGl57hPwdp9keJQrnSCGQOyWyyFQtsEYkWK9AlKSWGeqSv67rTR?=
 =?us-ascii?Q?oD5wrHPRRnUrnosnIO2fyljhKBpHJqWeUzpx8BX64Xeis7col1RXuqz6oS4/?=
 =?us-ascii?Q?84MOoSCkpv2gFTkYPec06EWy+A4v3rYm8eCbk2bTb8jqzXygS/2Yedi52X+1?=
 =?us-ascii?Q?PrnR7sm+WVWZqP1DVHqyZ0PlZQou++3OhphYp1B2ETDHOvHSjp/GIxijdwic?=
 =?us-ascii?Q?8aY5dAoqgeyGhxHfn64IA4HA/7yMh5mj6cd5J1zZZQSRD2b1vfkin3nxCnHB?=
 =?us-ascii?Q?6aDlX3V5Q+8xaTRH/b9f6tZOd6TuqZaP02Yoje70OpRchTLRXI43e7SwzSNs?=
 =?us-ascii?Q?/9McFSEoKRuZ0fA/CsaD0tJaDxJFF63yDEzPmkU4/qLghSL4JLXnA2ZfxnUl?=
 =?us-ascii?Q?IDjFzYYYbh2cSLm6pNZ7lWz/v3UYXIN0ZYxqsRZY45VitxIHyNlUCGzglrwM?=
 =?us-ascii?Q?vHra4a7OiLoJ/DMLJiMvmv6T7oqX3jAcC4bSZ9mX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed9f41b-2bd6-4291-b886-08da6be18767
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:01.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scxzq2vlAwWblg0enazca4VDOkhwYZUOWFzKtrFojxgJy1A8KQmITRb6TQ1jtrGhR7beZL0wkylOpjjlDLplGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP HDMI HDCP and HRV entries.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

