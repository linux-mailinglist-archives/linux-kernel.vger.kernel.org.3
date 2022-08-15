Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E865592823
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiHODfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHODfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:35:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663CB11816;
        Sun, 14 Aug 2022 20:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyOi8zSkFsQ2nP8RyaBpUFYi+CpYvJxV7JX9TWJmzNhznypgcnRBw6QiGegmt2/w9M7pLWCnWaF/L4njU+njujToFLCEhFGFgwwFmKGIxbINR2j+1NtUH8LZantvzquhwkIlBK+23fprzAwBgDk3shl3JgrtezqprqNt19q5UP5BIzHdkUyyZuWgBNPjOjtlfUn7gCJzMvJb5ikebAgqelP0LxH4ENVooR2ifpY7CQv0oXsLZ9LfBLNrj17Qb0K654FmFGyCOW1akAJjdDCIVT0Pli8g3uNZol8pqwO/VlJcck+B1xQjUGeohhIsKOIilQsCCpDpA9Ai/n6f7Gk7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm5iH+ViK48xGguExpq0RBwtNLOIYs7Au5rm2vzNo1A=;
 b=RLDP+zcFJGzJRm/liuOe2wMhagcTFz23kYjSrrqqovYZ/z3O025twaynZa/h9N723K/nC2lpzkBWXWIP4WwiInsXOwXXFY07HmB9cpp4SxotqDZq0M5cEPES3AynC0osl2cYniB36MEq25LdHMSu3+E/pEyylBctFbPyt/9ltLx71QT0aB3afVBtKZ9oaKDaPmgtmFA3bVReTP1BMc1aC+D96x65xqovBtz/4rMtYilgQkfNES/hEUzin47NMtLE4zHwATR9nY8AxzQkNROUJXdR5Yrq9QIYh5UBE8KoMlF4VpD1M2H0X9rQHoJojvI6L/HT0fhyxZhRpnnVAAXHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm5iH+ViK48xGguExpq0RBwtNLOIYs7Au5rm2vzNo1A=;
 b=B4SKzvrrJGlZx9nvw6NGsq5+NCC6NGVgJY837ErRnQiXBlkf9Y6icqXSlYSlDiXXzw1uriZ9KNUXNnOhqbt/78yR8lwJVRXVjVL76Bx04bfH/yKbN/XxwGq7MXeqt43Ror0VgwderRh1mm0nwHxxrIP8n1qDNR3k5BOFruTy+2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 03:34:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 03:34:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] clk: imx: introduce fsl,protected-clocks
Date:   Mon, 15 Aug 2022 11:36:30 +0800
Message-Id: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b303d87-8e6e-4d89-04c3-08da7e6f1f34
X-MS-TrafficTypeDiagnostic: DBAPR04MB7480:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZccLKbedSHbykD5ZswC6Qb0dm6FlJ+ElJTo4+Kh7dnErNhHFPT3Dw9bE8Z8vktrWQWeu36WIuJ4T9QhXOtlxBP4n4rgeWWk3LnT9SVrDRPMm/7C1W2sHIgn+KnXt3cl846+mgR5eNy7ua+C+p+iFBKTDFi4H2XDqWNWGo/TyIBoB7ktVDg8RKe407NWSpWKBoejVPQb6WDQR1j7/FMcclj0P/WRLi8mUynM1HFXrrqD/xYcn57MPmnBqg9OLAhhGXr4paKNpzmrKHUS8FzAdhz6/ubgVFAggFYiHEIbZ/njdDgqpOixd1eka7pUUKmAXNF1UtrJRZTk3PYzDMcgVxAWojNMU/9dDAo6Q0UFiWG6lh4D6kEYIyhfDEpWvHaHXxfC7PBurt4HRRzwdNF0Oo3NZOtS/DfZdOcOGTysglHGbQY5kaolNQ7SIJ7J8zktOW9BGO+eknAAUoMh7WskkbpdH+7IpIy4EHVktgZ5B7l/x/zz2rsVVzLaNWCPedCmYMq2IQQV4kCKxivJRFvSU29IeQZO8mWR0TYbZItrKT+asuXowLTe9c62g8aGvsvzldt+95GRpED2HQaLb4VEV3LxGTGgD6PEIeb9vz5DEKa3yBaOPBUEJipStkD7o+J3hqhtQTPRQhhv3rtS7CUdRQuCEHNXMxqk4MRh0GRGfbjVIfcWkMQERyz3fZte7hZW3UJ5wi5DBnJgDT9/5qOnNo5mTodk1Kz/xc7NdH1iZwbdn8fRbEVbDkBXSBaE9RMtzZZWzuJTQmfxrdJ8cxVr/K719G7Uy3qtXpbmf1fijiPY1ZiMKtxUYZt8T0UK08/OugA5qTi8QgPo4/qVkjVPSbWGGUXuP3BVNsi4N3dHDo+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(52116002)(26005)(6666004)(6512007)(6506007)(316002)(86362001)(966005)(6486002)(478600001)(186003)(41300700001)(2616005)(921005)(38350700002)(38100700002)(83380400001)(1076003)(8936002)(7416002)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOJviEfgrBsOJ17JMoHCVcr4r0zF0uZugRJwiVCjoGdbeaTuABadfLEkQ38j?=
 =?us-ascii?Q?NhBsQz2aL1mv5myajWU4YnlFyRoZOYxwfX0QDIKgZHqn5+nKkLvTtXAe15MR?=
 =?us-ascii?Q?GFY0oXZvl5Mm1qjkIqeDssv6RzCaaxTmzBl6YGQiIGQIvCiEBPtGp3WzGeXH?=
 =?us-ascii?Q?1TCOiEERsi8sDjM+uvK8cM6Qa7LQuOcpRar6GCa6RD/iew2TG94k98QrrJGg?=
 =?us-ascii?Q?Dfh0fR6/F2dJgytDHtzT0iK1ejWKHJd4tI0RclCqcr4em8JjzGc+9ZfPLqmE?=
 =?us-ascii?Q?9ztoWCalurYtkdqRwwHloH4sPgpN6467Ad0IjZKMLh3bBhjEsN0fkXCiI9jq?=
 =?us-ascii?Q?4grUPRst2tKHaq1ffHCI7dGzNHpeYjVnh4ofJ4tpZCZjygPuzSKE4RRfJH0L?=
 =?us-ascii?Q?/Fi6FIwoE8Wgu+rW4UptqpSdAPQ7+H8seOsywJf+t3lzsJDGTQ72vDY2MwTm?=
 =?us-ascii?Q?Acq7Y2B8YVHcbjRXKXQI+m+J/E2oBUcTxcFD5hMoVCjkLr4adFbs8jnSvdJN?=
 =?us-ascii?Q?blui+/jUa255UbepTsW+dc9+m/dqrLol3wll5Cj+uF490yWcCug+DsD9mvEL?=
 =?us-ascii?Q?7W1Y7HlyyZKBb8heMkYSyZ26TWz81O7mSFQV2527yEbfc97PpsutCzxhunJz?=
 =?us-ascii?Q?iv3Trvm1oYqJ32YIXWzWbOA7oeQSpQBZmaZV6Ae4p9VLuq9b1DP0kvUQhJsZ?=
 =?us-ascii?Q?Y8s2vj9L7NEqfsMcGOMrNondIR+HWjVDLXt1zbaciaxzKhLSNTHjjUM7aKit?=
 =?us-ascii?Q?3rwkw7QSVdxbcHRprj0bmGQ9GO2APe/SHrrpntrf1tnHd+YsMaLJqU3+ilVv?=
 =?us-ascii?Q?Ybho40trUByQJ8tIjnnIIXETswcXbKk6qewldS4ujVirHAmpGWmW31Pywpqt?=
 =?us-ascii?Q?7VVNuAW0zTDvK2eKnBl169UFf6tHnZATvl0WiIRiqedgprhfTguoyprp/x/3?=
 =?us-ascii?Q?LzKkQFvab+aneiYYcdb/LAAqoX/3RLaZBK8j7uFWIFMs+ol9cWUrjcRsrIv3?=
 =?us-ascii?Q?iADCQWMAyz89u2FKldhAvxXfcOdYWuzThGAqtU9maGg6j1LBsPAnOD3tCu4B?=
 =?us-ascii?Q?hqXYzzw7KPGzkiXARYkNevc+omJObyOKavdj4zrQB2q1y1hiZUm5MQLEtNmG?=
 =?us-ascii?Q?sKUze3WSOqOAlU1Jt9P8wMBTAGWyoPUXgZJQtLCDNJ7jQsndUmttu+m5LnRZ?=
 =?us-ascii?Q?nsA+bTxiOM3+MwtKy+K4u/SykebtLua+alH7LkR/QyXTHTv6YpXUi2P8+1K1?=
 =?us-ascii?Q?w3CIPUlpTe1+Gh/SyVplmh5pl5IpO5W5nCOKfK0ZaNvNJtD/8IBHI3UZkACO?=
 =?us-ascii?Q?i4qxBRUz9tBhjrKQC/oRhwTDjzXS2RylX7pbr5P9DXuTaHPmLzATWJEvtg8F?=
 =?us-ascii?Q?hyZbpeMPp7AeJglBn9RLThX4SEdLXgi0f7QeDDqgcA1ec3gLagvRcR/1nT8U?=
 =?us-ascii?Q?NoO/JDde3vAPPfFWf0Of9/CrKMG6byEGDMOek1h74tYbV6bAc4hMfd95af9c?=
 =?us-ascii?Q?J2ipr9c395Gi/fZ/vCesc7eMc/36NP0G7EYPnAbH81vKM8qx6fsQTDVJrFbg?=
 =?us-ascii?Q?L8PT+8rTzcc6BapEObxGI8DKcT8qrA6HhjzMDfu6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b303d87-8e6e-4d89-04c3-08da7e6f1f34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 03:34:55.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKw3FNKChYQNDOUJ3zdDa4RnBxxDbZSFIbg6vZrrU2kKa3o/MNzA5O1TACvMXX/g0yC9Bb5MU4G53QujNr7pHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are two cases that I wanna this property could serve:
Virtualization: root cell linux run in parallel with inmate cell
AMP: M7/4 runs in parallel with A53

The major case is:
Jailhouse hypervisor only support partition, so devices are partitioned.
But there is only CCM module that provides clock, the CCM is handled by
root cell linux, need make sure the root cell linux not shutdown the
clocks using by inmate cell.

I was thinking whether need to provide a rate entry to ask root cell
configure the clk rate for inmate cell. But NXP downstream not have it,
see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
So just leave the property as uint32-array.

This patchset could also benifit AMP case, check the two commits
commit 19565ea12d61 ("clk: imx: add mcore_booted module paratemter")
commit d097cc045b64 ("clk: imx8mp: remove SYS PLL 1/2 clock gates")
Although I not plan to drop the upper two patches, this patchset
exposes opportunity for better power consumption.

Peng Fan (2):
  dt-bindings: clock: imx8m: introduce fsl,protected-clocks property
  clk: imx: support fsl,protected-clocks

 .../bindings/clock/imx8m-clock.yaml           |  4 ++++
 drivers/clk/imx/clk-imx8mm.c                  |  2 ++
 drivers/clk/imx/clk-imx8mn.c                  |  2 ++
 drivers/clk/imx/clk-imx8mp.c                  |  2 ++
 drivers/clk/imx/clk-imx8mq.c                  |  2 ++
 drivers/clk/imx/clk.c                         | 21 +++++++++++++++++++
 drivers/clk/imx/clk.h                         |  2 ++
 7 files changed, 35 insertions(+)

-- 
2.37.1

