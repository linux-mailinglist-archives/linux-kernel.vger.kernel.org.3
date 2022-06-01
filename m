Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CD53A0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351229AbiFAJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350509AbiFAJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:43:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E02522C1;
        Wed,  1 Jun 2022 02:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVxsKxqiLlnRt9ur1fpLOsJ+gZH8IC+UsKgJQ/fX5nbyms3WJGg5uL34LgkjcaNcZGfgflLP0QeUSeR5xYhWkmtGknezRuxyIZj+Y7N4qTYfpe0cEANM2TT0t6MwKKNL4YKJh2+Q0/dgfCj0BErzYQz4Ewd4cWdUHDA2hwEfHB365Be4dUrhI1E+W8njS7QoYhbMkD80c2pVJ/TQhSJ66zAffnl8yXszuXkV1k++CYLI3dKuqVTjaUP4cX9QBA/K+1pAvCsH+Lu/U+lo45OqwFEBoqk9KeB/qboNfMMhJCvo/Crus/5C88ZJ4RW8+acTFEKI6Wc5RQgKhni7WAptfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iwu43QeBT2pf16kAv1VvU2gsLfBq6Rpik8E+Bqp/RY=;
 b=kQJ3uGXqsKDghcemszjgYvjxU+shYS6mqBX3xInsnWJzcQiMeaubEjZBpDW2YWAFVXS8NVpmPfoj/Yy6D8j73eoWc0OL7aRiLT3mPGpPn+cC0SwLbytAUceCNCpoebLQVAAcRI76L+IOkhz1hM9e2sxWJXiryVaJgp2XDnWe60fCo9mzC3Cr0w7h6ISX+/btUjV9k7NnBosgk85HPwdJ4/U+kFD4ldt3t8c+m+GWD5yt9gRHLRx+tgYC85A/ht018kLHLg1IKJrZN5T/W9sbooa/b49wBJ4uAYCe+/mE4si3YyJ/3pop3hE1+OMqUq02SuEq2jwvam2IiXDVfyauMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iwu43QeBT2pf16kAv1VvU2gsLfBq6Rpik8E+Bqp/RY=;
 b=fdQxdwt/RAFKVjdQdkqtudvEWwTELXmBXMgmr8MAkJgoAixRatmL5OnUkUopDRIMerQ6I766GrJC9yhs9ThK4Bil73XVb4B9Q7ehw2/BDPDZmzZwWhiyCPLRTVWsBE1+X7/ehN94vAKrrjpOlviXd7QKcLT4QPMGKoq4zti1qnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:43:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:43:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/8] Add interconnect for i.MX8MP blk ctrl
Date:   Wed,  1 Jun 2022 17:45:29 +0800
Message-Id: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d26dc4-be64-4c4f-2aad-08da43b33cb0
X-MS-TrafficTypeDiagnostic: AS4PR04MB9507:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS4PR04MB95077BAB008D57C4130914E2C9DF9@AS4PR04MB9507.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWs/FDhe+1i4COJmlxZ+5ZnszMIC3GztwPXAbBQ27f/4r3EjpFKGIazQgZ0UNRcPxplpJ4o8eUAzJvF7f4vfooSgRBzj5H9j/rW1D7huDpUgsJVEp+9dKHEMMBqqYbGNGJKT4K4MHYvAN2Xt9nqbawV6J/bDl4b7d6ZSINZ5I11FS/f855/2SETqfcOyexKqEAJfNwkO9M3VPfBRrbefQnGJBIwgkfg3qisapAZW5q6DNl7FK5E6mNvEB+8mNSJO7I+0PCglEuyntu+LLlCjJ/HaE69ea5Qg4P77/uxE0TajgNUaA2qRWGned5zQdZvbQy56dIHmy/qdybmLjmDD3xwXAUH3VHog6F9tLrP31+tRST7Hv5InZlZtC5BqJj3cMb/VQkZhQ+PQcQ8uaB8wYhm6xpZP0bwlPwEl19n6zKVMu74NCDevXLHfy8LJybZjQN5OGHboVd0g1Ikt6OVt3Q5EDgzHNffrG9gce+979ntz42tLsIfRASMbkoJKE+lgrhE50aYBWcBDAG5ljLl2tch+SqQgNKfQB419tnoUVSu8TXcFChFthGUMc0XLoGS3XYTEts6q+tcQs9Ck8gPglE0BeXMohmx3cz88SWX3tUHJVbxtNXnnalLWzoPvB94uLIpCdQWfRDvqz7vhK+BiI2NvG806Iyuzxc4BMuzKIv2HxMC53N/AnSSTuc8eRG2pkJbJNEWRHLZsnujonUOcpBfcbtbx1i+EndDIRvIi6ufuV7dUFGtlUK2HyzSo9Wm1Nve4gMf9TZqKTDSNvPobGLd73njELfi4OLrbpB6XyjeskdUvDi0nM4wOMKxMKzRk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(921005)(6512007)(6486002)(86362001)(966005)(5660300002)(52116002)(38350700002)(38100700002)(7416002)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(26005)(6506007)(316002)(186003)(1076003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ryOQC8YWE3x7n8J7CadoI2forCYcW69HSfk9x/FgJeE0WFpHutKlOCzgTJlg?=
 =?us-ascii?Q?bnOgdmMftxhjBd6ck1Ukc2yRBV+0vdIn7Lygq81V9hsuYCt5X4fVmaY45+Uq?=
 =?us-ascii?Q?QJ4Mv1nbI4qctLWUbFaJJcB2PXsj11AQe0qS+yvPLF4b/Znr8Wnc7RBtOiXr?=
 =?us-ascii?Q?ctEZewUBbL6BieHw+JjRx5CTbcAM7CVdP2a7JT36ayPUAwnxf9SNn9moSFpu?=
 =?us-ascii?Q?tlxI5BtkdH+y/UmqAPVCLm8qzdf7IeIB+P4D6j5RgLhFZtA+DuRGIEXdpiK6?=
 =?us-ascii?Q?qJBxH/iVr75BnzUV+z1mTX6S8zRV5nn02fgRQAQwqiw1998qlnAcuGnip1U3?=
 =?us-ascii?Q?EgrwDcu13GC23R/H6pCiNr3EMDfV+Xid5tLSZjrRVXqrHxCRG0GbVy2Y4BSn?=
 =?us-ascii?Q?pkj6lrgJmB8B1asa1eTAroV0ngOEgNF30/vZSjZfF8aQJmk2P12zhXSyRZ5K?=
 =?us-ascii?Q?CGUqtzL10lOLTBaMyzKqRouC5zxgQoRUV/esdchyec4l7e9515ItvCeUTbkH?=
 =?us-ascii?Q?dWeq4sciYCes03bODM8QjcvAe16cd1MQgIVnYxttejtIvFpqJMmOQpNU2e1r?=
 =?us-ascii?Q?hXbyrynB/vz9Ys4bBZwRklfhdrJLSHYWUxiZl9hSMe+va+11fOz7v3XxR3Ed?=
 =?us-ascii?Q?mvC/PQOpdrsnp/GesgVqIwr7L7OoFG1k1Fjk+cWz721jvSMFG3LRbR05Rp5z?=
 =?us-ascii?Q?ISeACXpsi5n5hSW1uNS8LQebZ1JbUtrXbo4d9CSl/YuVojz+u2GnjREUcNHR?=
 =?us-ascii?Q?CEGSZrqRUPQ30biNsoURqvgn4dAqmR33z1tCdU5v8doaPklGOQ6xXDyCX/r0?=
 =?us-ascii?Q?7xGlPyQD4gN9p3H/HWumgy74yPledBHWiA6InpkwbIy8+zTkTa4aMv+vd8hh?=
 =?us-ascii?Q?ibA2z8nvNgI7raQbxwlGHAxZxtVmJNbbAaH5kimJzUGoCBgRW9P+HHU87D9U?=
 =?us-ascii?Q?Mj0Jbeiz0K0vTJiTA/+Es0lAuXGzKyVOeuiOW/WrFWGTA1L3HCYeIUqFg4nq?=
 =?us-ascii?Q?giTVOCHcNCiTn9GMth3z+Amj5ViQGCqclPm/W+WhGqMcfeXXmnunzTfymnkN?=
 =?us-ascii?Q?JJFiFdG3IfNj6c8GOLT+Oq3hAqmddwtxdJqUz3XfE4ARSd3QNN8OOqKi7pYl?=
 =?us-ascii?Q?0qoscU5ANOfEw5MHTYTMcj2AMaVwwRt++Z4eshZQMLzD4vw5VN/Z602WqtS0?=
 =?us-ascii?Q?AfGlLBKo3KbYlyEc1GIpJChixwtXr+76/yxCgv5/8pu48r9IFBSX14+/q8Pv?=
 =?us-ascii?Q?9NuR3T/uOCTb5mWwpxdqsx+C657UupxI17Gm0yXO5VzeXCVMF15NPKlbG6Tc?=
 =?us-ascii?Q?YuZQIo29lqHEAds5fEGBXlu5b+A0AtXGVuiARV/zAi5HPjJCqiSgER9+ooZa?=
 =?us-ascii?Q?KnSTMnHFAIOVsaAnqLfEf205PXAoKz++kTPkRpKfRAgyZfRtd4GDWGPFEH3r?=
 =?us-ascii?Q?QrsQ9pkz2jHCeuqh/BJG3g9k2hl/gkp9YBodXCP9rigmLmYi6smoAtWohi1q?=
 =?us-ascii?Q?pB0TPBy+WAykhbg4ylrwjxRmLuvASgG0c8AFZjEk/QHL3L2c8TPtyo8Nid1/?=
 =?us-ascii?Q?l4b4wm26tmRK0gkMfHo4bK/Q0CGZM0GdkCF7oi7WdzoNy8oYzttSwQdw5Vpc?=
 =?us-ascii?Q?cwac3tkgg/ktCVqvKQUtYN4hB7srchNC9H2BMS2h3099M/5HUG0cKmHCTx08?=
 =?us-ascii?Q?9fd9URewA+pnS1ls0laTJE62asnDq8tuyX/mI7TG2pLRRTQmVI0pHXofBECi?=
 =?us-ascii?Q?UEJbhguJWg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d26dc4-be64-4c4f-2aad-08da43b33cb0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:43:53.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8e7J+qxyeolDgnCoo5dGRFKgV/fDEdyHwODJtNlXCoJ05o2Wxco+0dh1WNye6mrQAl2lcMJCheaaS33ysfGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP NoC settings is invalid after related power domain up. So
need to set valid values after power domain up.

This patchset is to bind interconnect for each entry in blk ctrl.

This patchset is not include DVFS DDRC feature.

A repo created here: https://github.com/MrVan/linux/tree/imx8mp-interconnect

Peng Fan (8):
  dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
    ctrl
  dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
    ctrl
  soc: imx: add icc paths for i.MX8MP media blk ctrl
  soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
  arm64: dts: imx8mp: add NoC node
  arm64: dts: imx8mp: add interconnects for media blk ctrl
  arm64: dts: imx8mp: add interconnect for hsio blk ctrl

 .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
 .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 39 +++++++++++++++++++
 drivers/soc/imx/imx8m-blk-ctrl.c              | 31 +++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 32 +++++++++++++++
 6 files changed, 135 insertions(+)

-- 
2.25.1

