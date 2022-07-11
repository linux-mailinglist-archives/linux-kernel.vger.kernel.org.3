Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF56756D497
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiGKGXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKGXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C7167FC;
        Sun, 10 Jul 2022 23:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ47CiflohcQUCfr04YeXmz4uvo/qbzgjqAuBDxgaraxlzhNmXwjPSQz1p3bZL9HH21zs27sz+ctkVhAiEEKSbIhQnDhfOqe8S/bG1QML3lm40aTOqUGsbncNNhRb18x4VTZmduyxoxrfVPgpioQHs+qX1TnqcaqePcPLcd2VtNIe+XRIrNEXwNqNusjYDOauOgMyCjO+lAWDTgK6XsKoRB+1hAvGGkxy/GXyg0EM2ffo79V3MVl4VgqD1eXJcdixm/9EPc9BUXys+J3qUYoAjUzIEGVmb34YY3kfj8tGDQ/+3oWlVk6gMShaGuepAWJPxN+DwcDj5E0Jto8MfbzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbpSy2oEj6wk9uCrZt1zIfUpTgXOE+2XYPgRIL2pgt0=;
 b=h5AWsu0EdNTLMlPAuRUvxvOe+0OQlvXJ6ChxD7jVd+ibtpflrjPN72ROOXxz1cdqXsMbB5zLhlB9S1ghrxD+ejsnVaFkU81wyA9jA+L3Fp+n671T9IMMYhsi+uiwpdEQLIz/jhPdfWCjUH3XhdpJn1yCie3ZvUdrUAA2YgODLWHssaO60Q5cUBzd7Wl5xzeAX5islthzzwAlMGLrRNqvO8eivoW4n4TN2sdMBkZkYriMdfZsjrXuuOSbwxHrzzUbN5dyXuuE8DxvOtjwkyPN7c6yFIkESBuPitTJDgilSNQleRj1Lj0sdrWU+725djcDShBTqpQqv3d461OzMXzxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbpSy2oEj6wk9uCrZt1zIfUpTgXOE+2XYPgRIL2pgt0=;
 b=URUZjiwPYTFLiLyg4dx7MlOM6oHutF1QkHQhLpV2nf8rrzUJh6zUFWBuC3C+1ZUwSBb+4xM4uLoiCXhTHLWGBAZLXd6YqqJbhdB4MxR84fEMvAT1GEXJxtpicov2WqxWYw99HsbInoNsPVWVfLRVJ0+9rZ47Hm05yIiLrMhMLQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/6] imx: support i.MX93 SRC and mediamix blk ctrl
Date:   Mon, 11 Jul 2022 14:24:46 +0800
Message-Id: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e1bb34-6fe2-44ab-05ef-08da6305d52e
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oAZzwuSp6VuBdNtd/El07cfVVrxER+f+3WRQiq4yYGCc4skvaP15y4KA0nu42CProhxD8Veu33f+kVgObOgzPptQU3Uw4Xbo2S2HKqZLXh1hNw03EWPa8y5SuZhRIKgNG5XlOiQNkp/QUSfTvDnFLOS+RAFgz6+u8J87iqVvClYtR/Pn7RPp4dkfXPO9sOFZC9XICI6a+wn/EHOCqMstbm0sLta4n+9rdDKg/WOTN5D4ZnvhlXewmFR/S2fOLA2Zeyk8/jsQsG0MWu0dwMJ4VaDuap1IBHwyxzZGE+rJla2iABc0OC/NrJTbwYMS05OODu4z/Pq7UcGAxxpOQsBGTUhg/IzZ007VICVTWWoENYgant0ocSOBASGhdAULpnIDE+gUcYKItMPDjdG44Ihxy6Sia6OYaJOoX8OrNof7ToOPBUNifbfwwuJ1IT6B6C1kib5WIYEYmN/gDc5m6nIBllewMZXcuhAtxxIi26jmD0yGLeBcIWOR1VYVyN8Od+RPZsAPPLDuRRWTKDfgXABdL5jX25e7onNzBdfwmIQztHdPNWqE6MRu3dbSNDR4jZvpJ5G3oS+xRzGVC4aLEWfdHST/XFWESIyqhNow/MMOTz5hG5fGAHNjfzSMvOUMT7dv6ORd4e2KVIAjJpsWy70L+ln4MpiZjRLxFD+YYiOZjOwHVxiM4ptiqSQHY+wiUaYW3MDZvzlm74sMS8P8aTSENgKsJTj9m5BLkpXgI6jXE3LSMGh3MVh8hOXd5pWCa+pGiQMyqAIHcnE83VxtZw1K4IH8pw1sZvsLrrHNPhxZDC3OBi6GWu5aKS/iB14mI/F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUXLKrRBiJp3Wx4T+GFomHqyeiDHeX0fjGUvhk81wSBM6iK9C+5IC8FNMI7q?=
 =?us-ascii?Q?E+AToxNAKWUEthg/MPSKeh2s+NBWYg75SqEHUlvaeAF0iAtPO59nR/xTCK0Y?=
 =?us-ascii?Q?+CfdH6JPlN0RbaN0eYWT/zxShFrJVBfJ0Fjuv/UznaVSlLMv02PKdF8w5YGQ?=
 =?us-ascii?Q?Q2dcV3YZOIZfaaGMtNO7sAdUKKxqh70q4ap/XuVOWkaMRvttEihO5rzAokRO?=
 =?us-ascii?Q?tsT9SeywJ3JzE3GhK8cM+2o12m5vb/TKdC0+AMFdLNjgl/bZVJ0XroIjbSo8?=
 =?us-ascii?Q?qBlbVVJQ7HFUQoa9K353p7z1uQ2b1mwTa1c9dkYbzI17eIYV1uyA+W11N1bl?=
 =?us-ascii?Q?TyoOkIHdg47rilB0sl850Qw9VRRoFWIaWmrg2IAmrukAkT00+0EhtWzVD/ni?=
 =?us-ascii?Q?oz583kzqSjsKtGsIaLYCqW+tPkDjOQnbu1qNMf95QYz1FUyAeG1zfc0PYz9+?=
 =?us-ascii?Q?Fwt4hajns2EqA9MoCZ7jdL7jYdMZ6N6vcmqdeBPtznm0XlLAph53nIcA+bH2?=
 =?us-ascii?Q?nzkXVPf+LDYF+P1hGqTkfBSMX/1ZJ60ihWZ5ocDXmgdubYHsFXamKONKFk1e?=
 =?us-ascii?Q?CNOc2PUO4EUTF2DVe0ELL52cjfa4C3i/2+DqXxe0UKLoONccR4sy9GAGInIJ?=
 =?us-ascii?Q?J5UiqtPPLSrhzbZA69xqW6hvgQ5k77jvUkp4zzkMWOTvq5fa2wx3fHhEr3r0?=
 =?us-ascii?Q?jpC+bv7zw/uPeYu1FXrEFCp11w17MRjAvM4TCpTTYFX7dpWzhYZ/VaxVQoHV?=
 =?us-ascii?Q?7XY8WhWVITv2znRYL139/Gi+NTFt+BX3qBlCHArIQry++K1ozsTUhmMm7ebW?=
 =?us-ascii?Q?sM7e1bBHk79i9USWHgPSWf3yeRst6nIViW29QsrwH4VlJoB1MX0knQJ4DoB2?=
 =?us-ascii?Q?J71Qyt2VZVc2F0unLA9IOeXa1UVAV6RO3VZa9z3kS5+i1PGsWbzRjjajuIA9?=
 =?us-ascii?Q?cmA8vy6cSBHaWjGAkBuOC+n08nxp9AJxDB3MJrmz35tG9hlJ+tDGPyxN+soP?=
 =?us-ascii?Q?QMtH1H6BAdxA/NvV1KFxGoc488yaC7m2pLsf38KP4CtR/lGGyBXzgWJIQmi7?=
 =?us-ascii?Q?cHx0eIsJeZ/wNfgg/oeYLXnbwm00b+daE2Cdc+FptXmkYrI4Jrr2abYwc74w?=
 =?us-ascii?Q?dEsAOVjui9xTAGmh0xQ4diojWgfs5tUDormiTPVelfHlU+sgsZWVEdMxjEoA?=
 =?us-ascii?Q?sW468Z9GTTE5aD6Bv5pPcbqaBMZjiAjE9NvLC5wDWPg0lbrh2TC1GqQKh4Tn?=
 =?us-ascii?Q?4QFmPDKlPg/8Uw5qh6++hOdIvfq696Cg8hrRaQm4B7/gnVcPPAtRJGlDzET7?=
 =?us-ascii?Q?mkj/1cJaqiwz/yMuDh9PxRzzNV2rkr8p8ziKFQVYrNAvika4iwCDWd5NT/DR?=
 =?us-ascii?Q?C0QM6IoTxcQ/PpVd1sULIn+wGLv8Fb9Ry3eobaxKjGLRxx/+yl/vX/j3MLka?=
 =?us-ascii?Q?OQv1UpRFQ7meIa3MnxLmD2emchyVcYwZ7ewNeVRZOjGfsNnOahDP96TZ0U/U?=
 =?us-ascii?Q?lb7cgtjMPE5WAHEfUEcuvimtNv0dDHsNrh7JcfFyiI725BL6Cfm0eSxnqiDl?=
 =?us-ascii?Q?+KGzGv+2DQ43Q5MDuzl0Xt5Fb6LLupq8W/XSw5kX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e1bb34-6fe2-44ab-05ef-08da6305d52e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:13.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifbZCm3KV09GRml9zSyJexnqM4H7KoMVXQgoFQ2i/LXZsdcMAHlQdGVCd4bIzi0CzitnUQeaqevisz62arnbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Update bindings for SRC, remove the slices node
   Although there are several mix-slices, mem-slices, but actually
   they should work together, so I use one node to group a mix/mem with
   dual reg entries.
 Add SRC driver to include a driver to populate subnodes of SRC node
 Restructure SRC-PD driver, because slices node dropped.
 Drop the patch to export of_clk_bulk_get_all, which is not needed.

V4:
 Correct including fsl,imx93-power.h, not imx93-power.h in driver

V3:
  Move src yaml to power directory.
  Update slice name to slices

V2:
  yaml fix

This patchset is to support i.MX93 SRC and mediamix blk ctrl.
SRC functions as power domain provider as i.MX8M GPC.
mediamix blk ctrl is similar with i.MX8M blk ctrl, but much simplier from
software view.

Export of_clk_bulk_get_all for driver usage.

Add bindings and dts node

Peng Fan (6):
  dt-bindings: soc: add i.MX93 SRC
  dt-bindings: soc: add i.MX93 mediamix blk ctrl
  soc: imx: add i.MX93 SRC power domain driver
  soc: imx: add i.MX93 media blk ctrl driver
  arm64: dts: imx93: add src node
  arm64: dts: imx93: add mediamix blk ctrl node

 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |  80 +++++
 .../bindings/soc/imx/fsl,imx93-src.yaml       |  95 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  37 ++
 drivers/soc/imx/Kconfig                       |  10 +
 drivers/soc/imx/Makefile                      |   1 +
 drivers/soc/imx/imx93-blk-ctrl.c              | 333 ++++++++++++++++++
 drivers/soc/imx/imx93-pd.c                    | 163 +++++++++
 drivers/soc/imx/imx93-src.c                   |  32 ++
 include/dt-bindings/power/fsl,imx93-power.h   |  15 +
 9 files changed, 766 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

-- 
2.25.1

