Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF9254DBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiFPHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFPHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:12 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30066.outbound.protection.outlook.com [40.107.3.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329764756F;
        Thu, 16 Jun 2022 00:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPGTpXMeL1RCOMqsMC1aW6P3S/oKVlwiW9vgIJQ+nC53xDZjFAh4pjQo8sK1uzuVwLYD7DMj1uQSb/7wVO14U/y138NFdNmu/2aZdLB9qgNr+qIcSFckzpdlmQvYl+wOpwbcgjrqKi2pHevdLVwYPOcM9XMGXJThjHYkC3wAs+hW3axTvSXoYxsbPbuG0Uxz6yINVJF+y3h+k5Lt1OCS8kRKwaLM2ZG54uVIrWtMXdcgJGbWtRvszPr2jfp+51OOI+lb+sRvOBUdeS4by68tL5njBfLeQ77yB2Lu1d7hcPbkFESxD82ffe3dkRU+HJSJpRp5nCkZZXUyB6AGrdwlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvKjcmrOX71dXk3Wkv4H6kcAWeZ7ZTJ3px3sgWlSb5Q=;
 b=NIQU+1MTNAR+ErKzZxTfEpkaZrSwNZ762/4OILqtyoCpEKK3fKmR0P4QibErkCa1h8aLBghGjaqPhIpNuFW/rxdxXJODhjkD0tEUgTYQa7A0xV88l3XRvIuf2VbqMIjsDSjOaE/5jDkpfFS5Kvn7fVhYMf9GPrdmNXXWO58MYiFjRmDQLUE5SpfGbNhYwKguIzCzitayvFtBFls9/MYCtjHQfyrYvJ1ZkpPABXF2xpw5gFLRQTrmkaFKk5kq7wBXdSSBDMVfJh8Cryel7cNxGofS13oqGrqu1vomNghRqG0qCjGywXZ218dLz2yr5BAPyHGOnFbQZWYt+sjrtgHBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvKjcmrOX71dXk3Wkv4H6kcAWeZ7ZTJ3px3sgWlSb5Q=;
 b=IA60HCM6EDR1Ah+IJzoXJeRGz0rcm6EJcvuaqFMEfT+xDcQOtULfoyddGPFlCWIHQQn7ZE4lxdWtQxBcTbSxGlNV/f7SbJI2bQ+Dk+gQT/7R9xPkCHH16XURp3K8H3LovV45Fx3cxNwZgT2EAnY7KPtPASSbH9/nWtWjw70QWFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 07:38:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/8] Add interconnect for i.MX8MP blk ctrl
Date:   Thu, 16 Jun 2022 15:39:45 +0800
Message-Id: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e00823b-3e73-489b-d3ba-08da4f6b2771
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293B4A198E2B450D4CFD8F8C9AC9@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrQsnyhC49q0q2yEPaXtMSZ9HgkxqM1rgHOU159sA/wwy79rdFByOu+KNXPf6VtjOPupOME7+YDhQAt/gUAmDdv7J9csumyEhBZAAkZAf2dsIael7T7r+mhrG62LY0ly/hp5mazmglKPVIbt5bj3EgnrO4u4YO6uWJ6aU5eAeauZlm5QeP6p2o870NhDgQ17nCH4wuIyXjq1kDeHKhN2qWA1DqXz4QumsR5T+B9FlWeo6k0XfOddmoLzZB7qFHjXHjknwvgNdQUCpO6oHxdN8bcfAPaz17olBtc9a1A519Q/l6B2adtOzWLmsTezCiXqHKd5B0bQz0rEF4Hev5YoPunVnU7Ll5MfF6izHvaVZRpNBbgU35HU3MCbXt5K0PnAaWU3yGeZZpqIHUlJo7nHCLPmNzdS+DPb4YuagMR5E39fdd2mQuCdG88Dbh95mpqSyfUqt2UfgN/6JgeZyaupLjTAAc3QYTdkgc22lfQdIIyRQsxUNxsEC3pvgTfoBC9cWW6i9G0vhYDoEmym/ZDU5C0CQlB4Epjr1UO348M4TywQN22jTbXzhaeGiklxt8UVHZ6aaImGR5bYPEVsbHzCj3sSFk2NDc1piGMkZvlVXTsUhAgRVG+eCr7xfXkdbNbPSekItIEI5hBswYviGogfD+Sw/M7rqHnMZ1eOG4WOuA6x3qdlD7pHRs6HfdYocl2dtT/wmZvimZMeG0lwfkdIOJSOQxoYkcNqxcLRcYuDdlN+rtpkyKfHquq3pEOhia9qp5+CCs4jrCscEgHtsTDuhJ5TnJmfn9LCCdsFT2Flxvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(6512007)(4326008)(2616005)(5660300002)(66946007)(8676002)(2906002)(7416002)(86362001)(6506007)(966005)(66556008)(508600001)(6486002)(8936002)(66476007)(52116002)(26005)(316002)(6666004)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YU4VhSKhJQs8Fl2FUF5sk9zaFV0QAz9ytHhFuWfohceVqkECU2ChFB+usSH1?=
 =?us-ascii?Q?sVaSLD8qQsKDsfUveK7LdoKHRx2+uUOdB4MF70FDZA2ZHjdDSzsfILhxVPVH?=
 =?us-ascii?Q?1vvtj/bXmEuL/KEK6b0Z6DpPcNFpr0Ggq+gPwTleLIkgs6ZEkQcZy6pb+E5o?=
 =?us-ascii?Q?SPKiuIrfTa7pgDq4wPW2mX2nl+oEBNYEQy4pKU/bcbkMfKQ388gTaB3F2DDn?=
 =?us-ascii?Q?9wojrFsAKXK96w4D+ndSHkzJiB55P1cby8gCvRB6p8KlucNYDOv7tCEp4o3T?=
 =?us-ascii?Q?CMBSfh0AxxS8UGgYrpueDevRVEXVPVW4KnNufnOe7HZXECSo66CXzi4A35JM?=
 =?us-ascii?Q?D7APmuaXc5n+FTJzixmF0QH7ZKrCKc0TQ9TGm3X2eHQgehpJ43BntQxUfTXR?=
 =?us-ascii?Q?+G59Ll9DEnQf58uSZvlqcBC/1NDa841uD2/V6vVPgivZt5/Uz517KGdKQ+T/?=
 =?us-ascii?Q?vOltPgwlQk/O/B7P3WmFig1FPQR4SWtrv11dy1BMa0m8JTZIi8TxUth299Km?=
 =?us-ascii?Q?FvifUL4iI29zYV795eTHBuyaYh9gQFACuBD/vnBxKmN9NkxZtIU2Ta4jXa6F?=
 =?us-ascii?Q?Nf/5DpJv49/ZJ6+33XHk3wZbfwQz8ihbyJ25qbfnAAW0/dMPTH4Zr+lyyn7F?=
 =?us-ascii?Q?3lH/iuBkmq/wwSoWCXi2ZJZFETEZh8Gud+ygtLHK9qlqBVFXS9gQQqRln52i?=
 =?us-ascii?Q?DINBt430IbWvRUL8FVRrhsca6CamByQhflHkcI0cng+edujoNclh32+xmpUj?=
 =?us-ascii?Q?XeKj255E0uR/b9EDSOtFQ6TkLt44jIhaLxaNQwnXmVcVuu1XbBhvG61mS3rF?=
 =?us-ascii?Q?i8bCIt5OCJemCDQ/prMp8+TRKc3oSIhIB26/UfVPkCVazO62cIG+yDSyfK/8?=
 =?us-ascii?Q?5pbntXmm+z9mbvY0HrkYCvoQxNBTRNLtrWys2m3LEn/QAOrS66NRx8lJ5PXF?=
 =?us-ascii?Q?QjA4VhpamPLH1za/JupUckuderSMwAgUldzN12Xzph/qIWmq++CjEgXxjumf?=
 =?us-ascii?Q?xcoaO9N+rbzDLpwsJdAkBH3cdfA+gpA8lIex2NuS50raGDcamv25pnWYAU5U?=
 =?us-ascii?Q?xEgf603YstqP3Lk1u2jPxg4cyE5RGmsbSO1l/u9SaV/9hEk/j54MZrzAOvfn?=
 =?us-ascii?Q?nWOoZVior2muS4l7VAMwpqNF3EVSlZV1MpkDhGKYC0P5fIFjYJ/HNKZF6snM?=
 =?us-ascii?Q?CFCEUa1MFhvYJuF/D1etMshnu92DRS8h5s3Krogys/5Zr7BTz6rm0IPwdzBn?=
 =?us-ascii?Q?ImHUn8FUnIZvT8zgwpdFwBppF+ImSyhECtueY811oP49HdwQmSUQd7h1heAo?=
 =?us-ascii?Q?LtyuAMrce8lxwDSPg4uWv45E1apsGcXyWf8HobqYm/vidzdHxYQBNmZPhMRt?=
 =?us-ascii?Q?bCeAbw7dbNBPcKJLIuDYL/q0orDWYRp1Lml1NRH4VwHwlWo9eVPCPMvPOIhr?=
 =?us-ascii?Q?E3bnjSPSx6eMgtN7CTKvkp7S+lrUIvywyCz4Y/A/v/LpNJOKeVcfGRGXhhoX?=
 =?us-ascii?Q?vXJisPtN11hQGVFTYVtdd7d5OGzKkFW2AE2fG8OWm1Ln4jsoHPyPzeQnW5AE?=
 =?us-ascii?Q?IFxuNcyxHvIjSeyTLYLJC3MiYQNlqv/KT7Tygeg8QknRrgWQZpUAMgxlIO0V?=
 =?us-ascii?Q?qC/9iBKYTZmoFTdaML63Wsbk+WHDGMmUI85lBjM2cTpk+JEs7YSys1lsAO/e?=
 =?us-ascii?Q?KNjK6m0Dvjev+VAgzDAwFDsSAU2qF0evk1YFsoMCwLSaRl7JBaW6v9BHz0PL?=
 =?us-ascii?Q?fHecShJYbg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e00823b-3e73-489b-d3ba-08da4f6b2771
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:07.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Tz+qSlSYcbXFZDdsFYrSsvJOexz8oxBwMxvOMlqECZYl6XN8LQJ9P9E/1EVhTSS7e+O+yv0hQxpVx9U4f6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 Use a low bandwidth value instead INT_MAX
 Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
 Add A-b tag from DT maintainer

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
 drivers/soc/imx/imx8m-blk-ctrl.c              | 32 +++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             | 29 ++++++++++++++
 6 files changed, 133 insertions(+)

-- 
2.25.1

