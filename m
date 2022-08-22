Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8D59B9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiHVGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiHVGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:34 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130045.outbound.protection.outlook.com [40.107.13.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE628708;
        Sun, 21 Aug 2022 23:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUbIRTOlij1QHOVzBtVjwxKB2HhbA5NZFvDQPFL0BCW/d50PmHhfsdX9G+Hm67I2YZX0+/vPUaM8+gNBqOHRHZ6LwMbMZyfqovOHRJEVzBph8+kbO5bQOjU+X7c8xY/O58znJ/PJwS6zpjREWyr/XcnI8CZ4+H+DYiXOYnO4V+bQUcW7hN4k3PcR6Y+JCBfe3+Dc1x6rOVKpSALYkKAU7Mmd7WQsFK0pQmmTq5scyeuZaqKgo7dOWZ5zkUsjMmF0+edOfA1hpdFsDt7Zo6EqzD0sIE7ThhbuaiCM3C0qniQUDASDfWbfpvHM6PJMQk4/EJ7TwTX+qiT0Zzk2uzuZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZvEB02MjNN8lmYGe6waFu3M0YhzBwVFtUpEnE+7Tjk=;
 b=BhE8EEmmJQPfSMrgTs3hkKaaaZzLYxZ7hkZKmMi3aMjuZ8hhOZHFV88/6hc2bmta++rva4yrRI5eUdZaVR21A/0vzZVPniqFJzMFppbfdhCx3FWCdocbJDSi7JdNma37wdtZkZQDRjQaterBN5ZtSgZTZ0QIQOuqHxsyQuXpzsQBlYuyapQPEJS2YBbEP+c9YneGgQA/9lKJa+akevu8mY2S3jEWYo8JU/6N57WqP/Mad5fuIhOGacYd3COsGVj/FPHb9qaZGoUUZNeEIF1AEGiLb1fQ58monpPQcPxMcriUhfYDZ80hgVbH0xwp6UFc9sBAqvaJUd5lLp8PWWjXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZvEB02MjNN8lmYGe6waFu3M0YhzBwVFtUpEnE+7Tjk=;
 b=cG95u8t2K4HGnBhAD6+CuWu4LTm1ZHxhiY52R8+Z4AcQAw2Fse3eSnmNZKT0b99FJGp8R5Us7swGwPtEMXR3JlDkT1jW0s0clltEQhBcI+Y7k8BDE1PNpAD7rWYZrFhPnsNLgQ8yBzJLdHn7SCFoSkoG71FdpD57hVQbu36uvYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Date:   Mon, 22 Aug 2022 14:45:33 +0800
Message-Id: <20220822064536.3947512-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a653b6a-5c62-4e5c-be2e-08da8409c22d
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1qu4zUjiIBPNutrzC736Yfs3x6/3TWGojZRwXCVtp7hHnMGLdvuHJLYjr8j6Gm/NhxO63N02O2d3cNkPcLfb+DZ5WaugSjOV4YuBT58uWNC8fYTPXoyq5e/+z/YVZhTtpJjdDzQ85l8cKFjupM0CaZDpDQzwbNlHLJxQKb6FqLa89LSsK97VC4GP8bPg4fMlS33HNTn60nwbiLjOoKWXVxGvu8f7aGELA3M2iInH0ulw9KP3ozIQnYAPljRhi9NdY6CLC3C+3PIuH6YRfmNJlLe3XG0DJTtZA2XuiphTEP5lVsNTS6B1/PraOxT4Vmp4qum2VBC6XlLJXNg1hg0uZLigJLEXiq3eYbKSDauG+LUbMqegUiDd8Z6cqAiyZY71hzUp8AbacmLpVtla6INMs3BVZbZli+9BnExVsfZJpyL58d17+V6QI82P7TobE/T+Ey2ePJHpPnnA8wDn575z6zUOQFEQ1qjQDNIq8GgwNpfSKjMohFs1sv5Qwu+hQxkLCK5TDYFgQsT54kUKkdwACP0b46bdr2Lq2AqUk6RflqCZZsWxy3WfjvSzsj6U2HtR1H9SdZHDWaNCg0o9JpXazrIDuFwa1ufjcmMYPdyljmwlVZitjl1MbjZiKx2M/1nET2Utavvq1i7P6XB1dYebxKqe5FrkPhRD13dLQ+vdKeaYXypUU+ljkQIdYfa4GBYAEUl4lgTgriOkqjpl99mvUyGV9PB4Vf6+BwNX8L3EiLougE+jx5AGYK7SGbhBB6gvXtvxs+OJDPsjVR9kMqNng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tek8M2CGq0E7taOeUbrMq2zZSbFWhybT9igZsMFGgM3JHKyyCPdpjT5jTr6t?=
 =?us-ascii?Q?WayGUf73GjuPl4pL5s3wyFlgxtdzYAwesxwTsX1CD0sELbFZ3Gg4bDAtDKl0?=
 =?us-ascii?Q?txZX0uEueb/FVWfgOsbWa6uAJz5st/GjOSkQ3SwfqyDSxNnXVie1QCSO+ZWl?=
 =?us-ascii?Q?7YSNsnhY8dbDYRvLlsZhjlpFpUx4O2hjNwpSa7zaRB3yNfBpdXnCxJEZIFyF?=
 =?us-ascii?Q?tIRD2ziD5cO5PIGKvg/CQIMXA2mdILRy9yIbstG/t+kZTKrjSuX+765sjPjE?=
 =?us-ascii?Q?piIllutoKAJ5PdGzv020YDppF7FYxPBnJpL+IO/H7f/8e5xJb8jb1PgGfjGY?=
 =?us-ascii?Q?0MIe7zmEmvLEs944Yk8UmK/QKgIlpJGZXqk3aVm+vtFlN+BogLAd6PqusZxr?=
 =?us-ascii?Q?egmzHORNA2StBY53OcdkGsdcYwoC4l/99xAIVoaZQWuLAgjP07O6Fhquru4Y?=
 =?us-ascii?Q?wbmUtGlZ/rmlrEW+cvKkelA6vk6XoxZKlhOoAFQM/VOwwVWDVBJr3lUip6s0?=
 =?us-ascii?Q?x434sWfr9yXDLUSCUJtUzUKQk+6xaeUjPsENA9f10+x5uVc3W8yffac/g2UY?=
 =?us-ascii?Q?h6hTGZTFTQGtABD0QPXjTHpDRnnD5zKoOxz2pFXij9ec87yYxx2rG5gEuZSj?=
 =?us-ascii?Q?7qweN2DnL3YOclRilFAJx+tDHG5IOTK1nLy/z8SeXU1KDGUwdzyi/P+Mlrx9?=
 =?us-ascii?Q?1hMNd1X4T7eOxCiSKE5CnrggQRMKyWzlaM+cqaJeeJFpuMZ4Ak5lnxOQsZtt?=
 =?us-ascii?Q?I4Cc+olu6dhv3ygq+boPbSJscyqgozw5xNzxfUjJkZ6q/BXCAfOZGWpIsgJ8?=
 =?us-ascii?Q?ShXhG8fSjvfBdLuPCjZLidsfHmq4Mw/ttoTYM1NBBU5tVYtR8w8m3BX1T3cD?=
 =?us-ascii?Q?VbBGYikLb/kqGA1GBMQTj9PR8XSf3748g5eRx9umbol9M5b3+qEVmvSdb0j2?=
 =?us-ascii?Q?xNanB9zsozuMky4JPJZ+ZsSWZkHQ/d1G1miJhWteZ/HRzacXJzUlstgOK35v?=
 =?us-ascii?Q?ZgXNGHH8W3U6X7+O1HcKmlY4oBZHnPPQeuiIdsGonJx+zChFz7pi/WWUAlp2?=
 =?us-ascii?Q?WwNitjMzt6erwH6FWKKwji1YIIkABXkITNbDb+8QSA3vkRlh3CL3s5+j/mG7?=
 =?us-ascii?Q?0dm9CTuk4e7WXoY7Dt873JesknjGFjqtqFrTc/cD714dYYKAsGsKu/01Ymay?=
 =?us-ascii?Q?6IfLo0rqrxcotWSUkb9pAxwaADzmlVy3dYJD4TBqahbwW28wNT+7eb9OwXXQ?=
 =?us-ascii?Q?Z4uJyhaVGs/2L/bX1fNWiscrJpfUQn1sKUmSNG2OpobTkv0dZzFSFzncDndb?=
 =?us-ascii?Q?fJSvveTioqKQTkqqdeXZlNh+67c5zlPNMq+DRJS7y9zR1C4drsMYwBk2EWyj?=
 =?us-ascii?Q?z5/gcRHZJDIlPvrzm7gh480lDypNmfzuRG2FwMY/DaQFnNH8iKAJ1vjw5ezb?=
 =?us-ascii?Q?aGTvdmGitZKtKJIAYKP3wyMkgOj32Hyfz4u7/aiUvz6wmpVHpj7dFRX6QV64?=
 =?us-ascii?Q?cLp9kEE3ZVeh6m2tL88NZ+1OnpLAoki5j2W4lt8I8609ypRP/azBrI5mpCz5?=
 =?us-ascii?Q?ByxAwtWbzTe8N9xmRWFOIhYUyf50xMe7DNMB/QVi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a653b6a-5c62-4e5c-be2e-08da8409c22d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:27.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNR3fIpq2LPCYX+d/sJ4f3hDwViQclN5VOQpkoarbcPfYXIzQuIgUSSpbkyB4cH1CHNcH1gr27qDQJsREHAmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video Memory Write Master
for RXRX validation), so add them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 6f983adcb47c..527d45d12a54 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		break;
 	default:
 		break;
 	}
@@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
 		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) | BIT(24));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		break;
 	default:
 		break;
 	}
@@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.num_clks = 2,
 		.gpc_name = "hdmi-tx-phy",
 	},
+	[IMX8MP_HDMIBLK_PD_HRV] = {
+		.name = "hdmiblk-hrv",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hrv",
+		.path_names = (const char *[]){"hrv"},
+		.num_paths = 1,
+	},
+	[IMX8MP_HDMIBLK_PD_HDCP] = {
+		.name = "hdmiblk-hdcp",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hdcp",
+		.path_names = (const char *[]){"hdcp"},
+		.num_paths = 1,
+	},
 };
 
 static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
-- 
2.37.1

