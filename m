Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76659B9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiHVGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiHVGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:11 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DA26AED;
        Sun, 21 Aug 2022 23:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGL1w/xhsgGwJu0hrNtoatdnAPrdX4eleGm9Y37lkrIxJJFjH4JAehWPvN+zssTxKIhuN6I2R48pZlMxWHxlwpoKx9YanZKrW2bJYhFapLPG9STnXwnwd/o6+q/8ShbrK5x2uMMRGAZJmK1XnhLGao/L1WuqpEwEnJ+65mZce2VhcgC9Q1LhlaMR5iKefHHgLwfShI0Rn2MfL3W1Qa1dI+OYrZwt/RBfnnK27nYLsx1kyHaXfbT4gzrKiFbtELt+GLaPxAfzdge8B3Yct1hG7Obk2RymU2wq+Sdj6js7mTmqVNMdCkHJ3u2lleYiZp9AFs6wacFfa1q23by6K7fr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSdC7xaqeGPe/q8v5lxWOpyJpApL6dQQgn65HQPj198=;
 b=bCWAbrjHdyA1tue8HfYRxM3KH4p0B03Hpiq38Ka9vabVB4gQoR8y4RKoEkVeUDuQE7lbMAQcuVwZY2nxyWciR+deg/F7RRSdOAHnr7PAcPCtqMoX9VUb+74Y6lw5X6fdBt8bQw4RC8pLvZhJPMOoxixGqFv3MkjwScwPSiRapi5TR4gAr3gXE1PtGy1a9ZIQanqv/aQrA9iNfsv6V+bvweFhXNQIionDiDNRxMe6y0bOScruD9KBH7pYdgkZVPiMTkiHPYo1RFVTA+dyglVRDXRE/CCsWLD2MSA1CStpLmD55nTRhosVwIbFztAzk75xoFv4e+0/+giPPe3Q49ew3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSdC7xaqeGPe/q8v5lxWOpyJpApL6dQQgn65HQPj198=;
 b=jnp+7zS7TglOoh2aKSweGgkP1+JDi8WIhgXkLz+XVesvu066Yq22eaZ5y6pfLDOmzIL2jGxjMNrIzJnHLiYPH15S5X2RZHNW3H+bSbk6SFAwPCBiKcyZ5KEX8aKmtHcPGTbRS4ME3H3XFKyWGpYa5aMdoKJXkH9tW9kXxjr1Cq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 1/8] dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
Date:   Mon, 22 Aug 2022 14:45:29 +0800
Message-Id: <20220822064536.3947512-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af69edee-d77e-42a9-0e64-08da8409b699
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm1yyHGTz88sbVpKrMJbNLdHAjGQkO16GcMiUkRlv0uu+Fx0uSPddgh+CEOAfS7QtdRlHcbePhzrOMLi9PYvhJZF6ndQl5jx9J0V0cFlpaoSODkjs8l5AmIjLvjdXUQxbHAURLa5PLdH13HkumVescD7sPTMTb+tgahLITlSmRvDit3k46AU0AUPgvDG4xW/Uh8Qbxn6+kK+2oDDXEJPBniuxoiW0YVvMygmSMigrICC+aoU+C9Dp/0Dfqd9WhFeCkb0Wacxw6wOoul3G16XjdSTSvGWz4ubHkl53O8NYaFy555j/gWcz0UXWWZ4ItMV6Ox1JK17nfG+yF3u2SppXMoKqzVKB3APK2ckxzCzpDbQyg/0W0OwlLsYRWpqUBBEirRXXL3G+fBXR18OF6PySq3i9LXB4n/nw0DgKLio4Wi5wqXhLgs3GkXeKOwYxODwK2fBJyfmrhuNCI2MqrU3J2ZmxzfDrfMyqditXsxa8lKDMTAsqm0l+zXzMaNMCixZN0N92JOdSJclU/A8ZTuVx0wwyPN0DpDrQs17AH6woJoJ33e0HIHLbsBaEhRV/jWmp/Haq9CpLCkzR6n5TM6SB3oTnMzyjRT5N45Kdrfnh6iMirGwjWZwLrr6BkrQCa1OFx/b03bVU8tovdh3rljl4nW4BSK8G6u9X4y6tbkd0Mi58zevVrYI2SKY1lfpiQjRP3mb9H6a6dsiEXoEdoAJ1cilaw7856orWNWxACSLuNVI92pTyuERLF2plU84SZlO/gp9kHLM5KB/D6GNh8uc0jEeywCUw0JLYAYXvJQaRG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(54906003)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(2616005)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8UyHiIiIMfXA9V0My95sgy5ruMiXCUfvDpmxTXo8VyTyAhnFtabjbL46yB0?=
 =?us-ascii?Q?OLFz6r2bZxqMfvNBFNfDRlMxxs4DxkVabu9JIWs2lzgO8Wc/LYyyob99Ymyv?=
 =?us-ascii?Q?DUNeG6yXyxVLN3QsEkCgF1QSr91r9TyyfvAXBZXqz7npfIGJHF9WF62SaLET?=
 =?us-ascii?Q?zFarnIrkRagsROVBIbJ64rQI6Lr3f8GNUIVJj7e5oVkmYMxeXIU+uU69elxs?=
 =?us-ascii?Q?pKfUWdOcLvAv6QVij3ZwT26wXGl2oIQtMNp0nXp0WQo37AXg4FJWcbrEhV39?=
 =?us-ascii?Q?Of99LSXQ7tBul5tFFASU8hLdhFqvMv+e7gkI1EWIxlwf9DTysbQvyR6V6ubB?=
 =?us-ascii?Q?zWkmSwsRKkNE/g8EkGCyGabCD5M45pN502u09rO92IxIgjaK9k00y9MEJ4ta?=
 =?us-ascii?Q?GBUzfOQJBYgJAbrxsFhS+aJJa/tRfQvup7qvuYY/0yiwWrdV+ml7rLhPmJe2?=
 =?us-ascii?Q?nO404NSe1BO2Pm9h+kgaAHbBbfhA/uoBvY6G1DCbdcU5Mi6Gi6pQvImlJJEj?=
 =?us-ascii?Q?aoLCqLIoS9BQBrkKP8GcWQ5s/A/jLOGGwzU3S/RcjNH+nl82jHF6vi2tS+I2?=
 =?us-ascii?Q?BHKOTgUOlj5Oepl5A2K+n9QqIA/bcRVYvc29rYgUEVtmgxGTnVcsJDs64ky5?=
 =?us-ascii?Q?5Ho+0YLOPn9AirbrW65+W6EjKw2Lhjsr9X+YeSEoaE1XrhhZ5tWtUvyKBjpz?=
 =?us-ascii?Q?3PEP55//L9g0hKPbkywGCUAo+xr9k2J+nckBSr5sfM3K/FsmyGirW45xPwoj?=
 =?us-ascii?Q?SYNG8n+mMlyJbGBwHIitWfUkGf8i7z604GbI/XnxOygBmR+ANAXf/0lLSyG2?=
 =?us-ascii?Q?lCw3iOPBP9HXfwzF42D0/TXPlrSK5CK0Kjs/+0LsKFgwWpyxciyLv6Fc6UrQ?=
 =?us-ascii?Q?zrGhIZedaI10tsdbbuAwAv1szXEfBYqzwVTO1iJrfg3tj9To9Dd1KcpsYH89?=
 =?us-ascii?Q?wzrcOCCTRmzuwml7l+uAd9uJyprX0SVzCJc/Raqv0rml9YkP7Iiv9B4lvzzJ?=
 =?us-ascii?Q?/mxGhI+zQ31fyP3eaeCkYbUKyHgiLaWYxdM2DXc5iFuF8h8AtAh+wzkur7xv?=
 =?us-ascii?Q?m8CMzKSN2Z+UNN4nKPudl7nLsK+CAjceGH3C/5O+vRWc7DGTI4xfRDMudCEo?=
 =?us-ascii?Q?HCWS25dYUtUK5RoY0Olme2lc9tn6xINwz4b6u+8H0g7Ss9DMy3BXVKPFL+7q?=
 =?us-ascii?Q?P4JvR69j6rxAZ3f3SgD6KCPGeNfqLRj4mCKUEv7d0aMIpBQVOYwn2wblwTwF?=
 =?us-ascii?Q?4pJdo9HeURzzuOIfs/w4SXizni/pYea+Bm+gA8QCkBdXkVNkSjkVyR6WPljg?=
 =?us-ascii?Q?8ne6IrJFU4n4C8nwke6Cmsh47babiySOVicQwtkeP0U74Zw6WfeSnJYN/+o2?=
 =?us-ascii?Q?Rna3MF1sKzVYrBBohCKsv04UqzdF6/npeBgEzKwTX5GkoKXZKCRf5uBNKy2E?=
 =?us-ascii?Q?U+bd0NijNueh25ri0/mCxuv+4pNW3pgeA5Ym9lj+S9B5jGrc9k4SXMfHPiAT?=
 =?us-ascii?Q?aVcV+4w/VGPQS3KpzlVr4hfPXlEhTzWyc3PX9h/mnp5ytzeoPuYCIK8HpIl9?=
 =?us-ascii?Q?6RJy4676IzQKbUD86cGgnwWjHmu0ehAxxxDq64hj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af69edee-d77e-42a9-0e64-08da8409b699
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:08.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjNpVmfqGTah4U6v/9ts+b7xaOlAWxcgxphqZchGJIsL11XT3IotaQr4Npyt9wFCflgcV4AN7Ahk8CdopyZ1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.37.1

