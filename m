Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16E572E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiGMGf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGMGf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87154CC01F;
        Tue, 12 Jul 2022 23:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgs4O3OEx+xbhqULbgkCmos0WUG3u1smIbADdpPAekJv/KRqeX3zB390irOLLvkzSuvhBbcP3j/exRDInTt2+VFZojQK0pPh0Uq6rgmpb++fhqsRELz2h020vU3Xh52Y1AZI4vYgm/dp4tHMVDAIxtOHhGs6YmTKciZv5g6pwHpn8MdQgN0c9RRg/1ShcsFY1nsww8NzZs9rHZA86WNqMipG4HI176uG3o4GXlAXJDXXgWeu4HvXuCG9ODbIqnquDbbAdWExZ3uxGCvWplSOFM/i4bN7M+AOJyWpGJopH86Ogu6ORE9qG6qGW38nroD1VotTloWowP56oImflSWCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM+ZaLI3fv1Zw07BhD0LJzoDr6CVTQyF5HC1FefrlgU=;
 b=QPd7VB1FZ+B/hLSHi1EeAQrx++ZIMAGBccXc4JFwx2KCYEGCyrV+GtzvdZOEF+LUrQUlFf/IbcKQnRBXOANOktTvIa2Gc/I2Mz1OhoS81SnK/LDmc7QD+E86JkFGaaGwqye0qJA8WShzNBMNLC8Aa6T12pFYNUo023bwiTIoFAVmOEgg30oII6DNTAAKA3wQG/Eq/GZ8MwP9GC/MgrwmvOE39uUUQYq6tfNhQoREvtNMp4Esbs/xS4V8eDACwEziFHbz007ItBUdydxRvZQAlvHi0CuZwNtM47JHqae+ZAqzYgMV2ueWVv3sO+QkEWBljZaqcvyBWtVZBQohxfyBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM+ZaLI3fv1Zw07BhD0LJzoDr6CVTQyF5HC1FefrlgU=;
 b=GIVritlwE67i28Fj6RFY5G0wGMSi49MCBhAXrfgsJ25wu60ShOKsQogfxEeVXiOsEcOg8EDQy22CHUymYr9YSJcbMdXOaO+lPgYrVkcNQj30SDb+2WfytvrECJ7TESL8YRkvX7RcmH2zRUNaw5ntQyzz3DBsadK5hNXMwEJcbmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:35:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:22 +0000
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
Subject: [PATCH V2 1/6] dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
Date:   Wed, 13 Jul 2022 14:36:48 +0800
Message-Id: <20220713063653.2584488-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d95981b-5de4-4993-4595-08da6499dc90
X-MS-TrafficTypeDiagnostic: DBBPR04MB6026:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUAu2Y5+oW5bIpWF+riSg/pdZG93TMc5TU2Xv8YKMA1QxEbF/gCojOfo9BO6/vCPLxHEpZrSa0SfEqRqegbk37x75+zcmMFpfZgZCKUlnGh9GGX1SMcsXthXvQyJ/YIhJT3Jdm+DxIOt9uPiaQ0pHVpRUBhhh+6i5i6cHtrs8WxGhmTU/PekHnWO4ca/ZrRjpVhgCdkUBI0ALbCEuO261udHEQQ9MC/nmtjm1z2IrrdwajPUujv8u2U8QWVYBv0NZkwKcz6Xsu2YsSR415wrTC0tZwAixcYCpG9TFXZmtzTS5i+Z1DR+E0aI0z8W23KIaCEEekeZHKU2Ja1p++oyvVGqdQmsRJhJIOUhiomzD3liK890pJreYaaW36nRwBYPZE+muM7SLapUvNB6hpdTovEghFlUAqFScesV1CnbcS0i/IxhzpBL/QLGkqQvDY8iwu2NchnfEKxVjTVfVlwaj4EG2jU+J835APT0fBWAmHBAS6O9CWWDRVWC5ZgJzv1b2XSie75eY2NuFnWA95VYJnOA/xT4cDLQYGC/DtYkH2rzfM7RbKN7lnajJgKrZpCJ2pUv/icSBTc1eDc4/YsJzmXa8Ocngw5zzDIqjyKzIeaOL2w09iONWu2CBAb8YpW96J8bUemgiQvJ4bkkFYy9tBmjlu0F8U9v6sIW4XRCCbVHNQF8lQjKzyvO7skC4iQj/L7SqD22Ga5B7nFQRjH/K0u3cywXyLmWSv7mowgBhCCXv7vTr0VFSEsaGDpBMhamQDge2KFhZuF4+GakDO6mCjw4k7TXH0PGxpcPB2yxOKKGPm4TaZra7KJiO0f0Y4jU7d21ZqJa6qecODqne+hV2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(6486002)(2906002)(4744005)(186003)(6506007)(1076003)(41300700001)(38350700002)(4326008)(8936002)(86362001)(52116002)(8676002)(66476007)(66556008)(26005)(6512007)(66946007)(316002)(478600001)(5660300002)(7416002)(2616005)(6666004)(54906003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kdauzDvroijXhz3x7gEDPMV+Oys0gy9KCWohRvlbjvuaxgR7hBXc6KytAKA+?=
 =?us-ascii?Q?Byy7Gj+UikSMVea3ms3V38buUi0MrtZRzYyRVECMQFdWIkKQ82b9QpPBMyD9?=
 =?us-ascii?Q?GWLT2YVPQ6GcXyLCP9wJhEMmJ6+xAfXVr4GVe0N54izfyXMZA0Dxj+PlmLbR?=
 =?us-ascii?Q?+yiZHGATfQhC+U3GqCbpbFHD3l8PydSJ9gAbfr8y4d54WKlDrgHTumqBF9GH?=
 =?us-ascii?Q?pGnmbyhHdp48Toyxr4MCtaHWPhiC/6KZqP3xQE94BYmemJsjM3buTE9xYKpm?=
 =?us-ascii?Q?ngA3lcH8g8SXVaA9AIyQ+XFfFVUbylTPxvF7baSehU+G8Ezh+9ht5ZQEIcZm?=
 =?us-ascii?Q?TE1RydHrlolb2odVvpU1E6Zn7S4/unCfEazAtxZIQ48Fse4lqezvKhrQm8QI?=
 =?us-ascii?Q?n3SipQqOZgqf220NAjB5Z+Oi1NtXXMA44lHUICBeMBvRGwvCYBB9evN/noQZ?=
 =?us-ascii?Q?VipJsaJbnR4b0UMWuxpcZv/h/SExKzusyS0JIZtjc5Ku/5JlvmzbiXasllhF?=
 =?us-ascii?Q?if1N+eFspDHbpu0G1bs6I3RBXnXU2rEY1lhFwMlttf/tgl5RVIKamfsojrVE?=
 =?us-ascii?Q?0+6su9OJen/eVLvQzmJzMZhOpNQEanvRUpsR2RXnCwp98s5/yGN9UNq+Fzxh?=
 =?us-ascii?Q?lp9+4LjlKABdQ0OXfhj8CYBS5PRJQcekZSAvCelSJ9VR7n/D8qI+MTj2PvxR?=
 =?us-ascii?Q?2GNdkAMK5/N27rYqWiplyP3ZhJQSygb1DDiw8xuwnI9MLC1BJmKic+k1bLx5?=
 =?us-ascii?Q?rmZWVoMYh18UtU/4UohqebWBqGXH+VWcAvHGQ3aa3QsOXbrM2t5Gj+Sb5LKS?=
 =?us-ascii?Q?BGySathSoAWYO+S9/GtItoWZGpJT1X5den8CsJ9aOLIa8EtU0Djz9lszpspO?=
 =?us-ascii?Q?5MoW4nsc9KgEfUMmVPS/r8IeF/8Hh77qpXb8voL9C0VBaek2Rw8ziY2LnEfG?=
 =?us-ascii?Q?nQkgltSGBHjAryI2hoNd5XkdHbGS55jlLSiLo9f27nhxAig0ZEbOhuH/cWle?=
 =?us-ascii?Q?e+faVB8TtBi4gfinnKNnqzS1sj2vd7ONDObyIcBNgXbZOhRpS32o1pB6Ug12?=
 =?us-ascii?Q?oXMn/EZZe5iPC6ubawwBjDe1OwzW3Hv6rMfp70Y8wTHmdIlvmIGrmNNkG9ax?=
 =?us-ascii?Q?NCXr00/q+UlA9hhBhHTHiiya/jk5060YhNjKcRfK5bS/N/yS3pReg0DJ+HFV?=
 =?us-ascii?Q?gYuYi9x8Yj8YqBqzj7NQ2bdBfkqD2lAWAz6bBvn8gjLqweppJnFVPi9PSVhN?=
 =?us-ascii?Q?zBuB20kjrps9DIH/vcmg7U+9WPRiyxK5urNJaJjo28nmHgMGl47duEZnnOzW?=
 =?us-ascii?Q?IN8Xxm203NiD0qj8uCjwYTu/dE7T5CG+wCSFLVhDNo9MQlOFFXqAVRCAzrtN?=
 =?us-ascii?Q?DriybRYA6w2kGKtN7006pAz26QNanjvDmpfwBqEdR3WjuQdEWmlKLdDQ4ynx?=
 =?us-ascii?Q?aaDrGJTMbQC6BbSbWg/3rdI6NnpzjHJFcz0Cd7LX8qJXx2+wTuUDDwI5DRu8?=
 =?us-ascii?Q?1VNIFkgB66nv4HKfVepP4WwwgTDVFVEcHnQxyNbk2WsS+laJRpSO0hr49nd1?=
 =?us-ascii?Q?/ov8ekO9JWIVlbQMaKwKxfsJpH3KoAaRPhaJVyAV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d95981b-5de4-4993-4595-08da6499dc90
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:22.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fHysWJsClauY7lw3nQoIjXwpqx4nQuNdZO4f15jIrpDpDoALnXAY8PCj6URYHP/2u9nQlpmOytXuXhEEToL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP HDMI HDCP and HRV entries.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

