Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56179551EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiFTOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245112AbiFTOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:32:04 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81104DF45
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpziheHGr9jiTLJM0EbVpCnKsOGQ+Qnlwcub0E+lCPRfFc1CcC2C9HvY+sNDFbjMim4q106qlTlyUaYqb0RQkhiFVAcW9wvj1mJAGvXqELuCr6Jur/IcUUe5zIaaZNClUDYaWOf8JRjMAz5N1Tko2uMIrzarM32X3CF/k6cX0uyyP66Kh5ylVxg/zEYObO03aCAzRGb2LafdAsSmt0qTjLTTD+aWBjMjkjLzc620xGMtqDmm+88sNnLB/eIUbQRyMltxratwuba7dFRuifBpl+gLOc0ypIDiJx+jkYZS+ijyxFTT37/7AhE0JQR0weOn5AhdhspcHlCNsPsp1l8FZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYPsw/KMJMSgiEjxopxQjcGlXw0Z7cS5onPZRmnAP6E=;
 b=K0RadnPo5dmGYUyuKVQRMh9f3H7hU/FEvlB46B2ImyfGYyAhwPtjSs+oLlKqW5AVj7Rv0p6UlvN/v2ABnrbgHu+IIJ8Y9K/Ry/1WIdZ76WY9HPzVzKiOZujkGKRggWI8wiwTc0+Gq8hAaIinePR8+EXvBAk/NcpYCOndkFAFFS0m7oPt97aoJ/AVo32i4+hpuR6zrjHDzXRr6SAY/FsLFREKKlt6mJpn8EfG8G3DKGbDpplEpg/PAknL+ui19YsqWUlAuGMOX4PGtVORtNdCrioRl2m0zAxggaB/eqV4TRrCzT1ovcx2Yyo6lB6wmmL0+9JkZSVMI+CFpgpJw4FyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYPsw/KMJMSgiEjxopxQjcGlXw0Z7cS5onPZRmnAP6E=;
 b=TLF6dBcH2HbPKC3+rSzF78wYJFmrsdPZfeZq/cCWntr+BQT8IJP57+wx5jSH5fWYITSj00uX3/e2tFjNr9sKLNmDPoJaBx7E/E/P8Gwhp+O7e1oCMyh+dEYMH1A8lLufiw9wg/FMEmIUSWZo8DP0bYIGhKDQwPfDsGm7zY6Pnrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by VI1PR04MB6190.eurprd04.prod.outlook.com (2603:10a6:803:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 13:46:22 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 13:46:22 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        l.stach@pengutronix.de, peng.fan@nxp.com, shawnguo@kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RFC 0/2] regmap: option to disable debugfs
Date:   Mon, 20 Jun 2022 21:47:56 +0800
Message-Id: <20220620134758.1286480-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f3147c-06ba-480d-004e-08da52c342c8
X-MS-TrafficTypeDiagnostic: VI1PR04MB6190:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6190771304F6BBE6803A2E3C80B09@VI1PR04MB6190.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdNWPFlbTNbLRkuJHxMjDeCAHSnvbGTZhWdYlEeLVFtIV4XbNKvjwphQUfVbs9S4RBcY2+G2LygYfvPDjwt4L7xvZZ/LRERmBinWKE2Oet9JBU7h0LSpnL0QaHnomYqWuwEjch+9YA5xCuFvOuwuuOA9U9qkdgU6OLAezYVSpAB7JFPy112VQEGm60KsF1WXGDACIeL8W1V2z+5MY0QuxbllM233RbsqPlfqxjN0bw2jCQkfMZ7cOW8ZQwdzWOunL3LEn3dQx3O4bSX+JdVJmbDO1NZ4nrABdgDmq+YU3AU1yMGUA6Sphm0kJvf/PdB4oGnb/Ng0d9u4OFahoZwuxkSHgZEQBBF+twVMSa408FolxA8TFx6ENVmm5Ch+tdjfAZVC25rJ6QW2FapsY0V3Ph78xICZb6IDpnSkwN5+B7qIDaCnXY6ERVmvAU2zkL0cJiu/nLYfJclqgrZZrY4uSTRkIVO9C4/sgd/tPH2QKBqKwXqHIIYLRiMgwftRwbB2RRQapGBRHb+jBeHCXmjQBdIqHKILrSbZhnmNwyATn9teIEuY4Nhak2VaLJ7j2+I0ODTwcZJfF9haviteA4YGdYxuCTUA2U/DVJQzNGh/SPiP8BgnbCLIz2/snSTa8+hu8OvpLuYoygIRW83S+KnWpwPp4h5wg4RTbTc0jECOiN7KijUaorV9qEftIkSAiWkfIHZpMyTbsAnKdLGAqVhhGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(66556008)(36756003)(66946007)(8676002)(66476007)(83380400001)(4326008)(6506007)(8936002)(186003)(478600001)(316002)(1076003)(6486002)(2906002)(41300700001)(38100700002)(4744005)(6916009)(6512007)(2616005)(5660300002)(52116002)(26005)(86362001)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TrimzwI2Y70M96DxdK8EQKOGHgBW2l1OY0rsyTB4VjadlGwCx1iZ7NPH2PTA?=
 =?us-ascii?Q?UgxA45W4m78OA6vdROz3hiS9xPhwq6deMCSxt0JqeACm2GIEKnhEnHP7FqTT?=
 =?us-ascii?Q?sq0irCas6a1m6SjyJQ0VvQEyw2tdYdDjczrt7XwOJYzZoLFRwy96zv6MRggv?=
 =?us-ascii?Q?86Ub3Ok+H5owUEcO5I1FgyZ2lB6kGQ6DZS1c1R/ErBZKCLU7mWp7mMNN8b2h?=
 =?us-ascii?Q?drvATVNTRObMBIE/LSicEK6F0P3aEaI2mXhMlGDS9rt9S9TvLg4o2xBLgnJt?=
 =?us-ascii?Q?SKyJZsq282KlbmxNfKSE7lvlu4Bv9vf10elISFronDLKS3Y2oU9DfhAah56M?=
 =?us-ascii?Q?NnUJzrWJQyXB9y+BsNnuyFFFH/K4Q23qrpiLcfMW0kxrmxxPqO4FpKJemLRN?=
 =?us-ascii?Q?FddXRi75/BzUFnfuoHAoxKAZOQN66udqu+PaJUoCgtWbggzj0HjMs/aSwj0m?=
 =?us-ascii?Q?AuZFblOD0Bp61Rs63ZiR+wYQ7E40QJ36NbiFuzsr4iOTo3tz72KEHld5XZi6?=
 =?us-ascii?Q?hA37TEUzfWEtgIKwNAHXyNrn8GAXv91T3aKRMBViX3U4Hs+kInYqt6mxUAjm?=
 =?us-ascii?Q?DAZiSixfsc8yoah/piNg6lTZrbHvcRaMt21AaZEXxslpcbLwyda9SMNIPZHT?=
 =?us-ascii?Q?80Div4cwwGpwyIpdwZipL2avbHUIC+Fi9bRnEihzR5/S1cZbR1EuN4jS/7i/?=
 =?us-ascii?Q?bvHXXE0/TrCNUm3h9tlkJ6aGuli+khySPGEtF+pE8v1ob5RRLogV7zXVFgqn?=
 =?us-ascii?Q?Ia9h1dyi4k/bKuWyoFgI6sHoAtvuSfxZ/wPbBslOFro8D7FWu/ujp78hqZSh?=
 =?us-ascii?Q?V1p72Q62LGqDkEX0/zq2U7Ougv+nCkSdWI14OpAdS/Aqniit6hexWvzAEFeF?=
 =?us-ascii?Q?+OvQUlgQitPpt4Ebcgcw/I+l9IiVteks+jlp4srz4w4AowgPhvVaWNcdSeql?=
 =?us-ascii?Q?9wOGJpn2rkid6jK1Ct2/s/7sq7MZvBJjyaW6s+jQlT+hF0bMjs908a5Znmbj?=
 =?us-ascii?Q?Skm1sDvnWH4lOilTSHRvob12SIOLvxAk0YOgNFBXRq1U6BlllSJWU2VebwnC?=
 =?us-ascii?Q?7ti6Gz85WkCiBLrg3GxNy9cTbBAY3aQkCywMMQOeNkxWARAFnGqLZQ1R07bV?=
 =?us-ascii?Q?m4gdEf5EBkpCCovQJdO8/kmq5WjIQlwNOpGFnkzSzgyKz7CsnHqI+THE4Ceq?=
 =?us-ascii?Q?HyGk4SCyErcU7qUp244uiXrk9c27A1IKpM0q+a9zTlVH+aUbib+/8hx7wMQi?=
 =?us-ascii?Q?hsPDju2VB5HnNR5XB9NnR4bjobTiUjH4SzNGJN369O/DgeCm8YT+eL1+OfQt?=
 =?us-ascii?Q?gZ9LbJmJJXp+0BT0FkPEsWsy0Jb7wLBLW5JDGbvWrvoUSDKZfOXziwnPMkWV?=
 =?us-ascii?Q?gA2zaXw0qFwSA2ijWzvxoiTVnYqiGhL3LhvUIVnfyMOX1KSlcr1iQ5FP2Gtt?=
 =?us-ascii?Q?lBgnFMepwsLcG4DX/0yS/edciN9af/xRH7ryZ+vN0CnM1WUkRs9qSTyPRzP9?=
 =?us-ascii?Q?f/8bwu5S/zeaO8wjYo7qiUVymGnhnb2O8TIGx1dRhmQqfZB8Mi0w011V/41L?=
 =?us-ascii?Q?QGpZJkv39vmfT5Kl1sD7Q0Q7DRUnPkLlB47pl97NG0w/O6jfcaviRZsoL2dp?=
 =?us-ascii?Q?sepoDnDuIkpfAww+mH0FusPGtfOfB94AmQwLjIxZWa6+GtNva7qQTs6gqocw?=
 =?us-ascii?Q?1A8d9MBb5f8WQnkWjzYsjHxBxymRU+ZP8q77vCTLf9qYGkLAVtSRwkBynbOw?=
 =?us-ascii?Q?hHMbwijMbJWTLuTgkZIuFq6GgoVdrRg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f3147c-06ba-480d-004e-08da52c342c8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:46:22.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrhV4P/8YKOgVwYy9V7BCLtXHLeu+8oNWq6ez5YzOBtsbBZK8ymCErmZtL0c3mYocc2TEuOKs9FvKkIXEJZcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current regmap core will create debugfs by default for each instance.
However, it's fairly possible that some devices may not work properly
with regmap registers dump via debugfs due to it may be in suspend
state (e.g. Power domain is off).

This patchset allows user to claim no debugfs support due to platform
limitations.

Dong Aisheng (2):
  regmap: add option to disable debugfs
  soc: imx8m-blk-ctrl: do not export debugfs

 drivers/base/regmap/regmap-debugfs.c | 3 ++-
 drivers/base/regmap/regmap.c         | 3 +++
 drivers/soc/imx/imx8m-blk-ctrl.c     | 1 +
 include/linux/regmap.h               | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

