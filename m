Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7253A0D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbiFAJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbiFAJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E649C82;
        Wed,  1 Jun 2022 02:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odSNXSCS4FO4JwzqnXgFwC49nqXRzmFZ8HVLqDKi+ssN5EwsKtV/0POdbPuGMA61s4W2D0P+To9kyep7kvjPqwjqMsZuNoh3uxB4vTROv5ULf9SpYx7LFYcqOC8zd9ExRF2n7iXn7cAIl55BKUtZLzXII1ytkmzkWM9640615Lt9N1h6BhcOS1LytUQ8U7i6WFvsok+293zafeJw46Vxo4wOgSFgkoH8sXLC9P7ajcceI7xD1kx1WcLxFJ6HueVLk6IlvavsBrM/a8xYlzpesU/iMJ0JoCvJYG/s0vhjGOGEG8/mCfd1OuVyDqOddsmaMKfOR8lrqpzcypBb8BykdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOMcRNEffFxSBUnYPX8jx/tMfn+0Mozs6rbBmZwQj04=;
 b=VNWecgmeARrIdbvjqfbNohRvjg58MVyfRKYxvxR+4RZEBWIutdUYte5rxxULKwvvrcCMLMxTtOd9OCHWSHntGgaeqgPunYChHg2TV4ZDu50SAF3gA4BBWF7/O/eV07HUr6Vaa0147FJzZu2lMY2GkwKWrY1Yvhf0v6YPybqoOBum6ds4wdKDw5XVHTdH45HuF6j7X4VHTtWGohk+yY4/bZ19vDui3UDE0b4Yq8OHqO8LJXQ6MpBv8YdR1P88+eQLP/U3wSRC7rzj9s1bNClOMxiADmEzwd1X505paR1FKHzxsh/A9vITI9RxSEJbj7eZFlzaygXWjTqdawK+gC420A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOMcRNEffFxSBUnYPX8jx/tMfn+0Mozs6rbBmZwQj04=;
 b=IPRTbOpea/v/HdgIpABgmYs6Ue7Jn5OU2wNQhR3ImbtCLwITFil++KQsRRPFJqkAQMtXnUfJNIazKZZLGXnHkurvSMX8kCDRp1/elrqzkqLloqGySGR1XsfGybTU+j454eFdqhTi19hoLsSX5GEE9Kdy/VhKIkQcGQqE4IN1J8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6498.eurprd04.prod.outlook.com (2603:10a6:208:16d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 09:40:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:12 +0000
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
Subject: [PATCH 0/8] interconnect: support i.MX8MP
Date:   Wed,  1 Jun 2022 17:41:48 +0800
Message-Id: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf3e6162-6c22-47af-7aa9-08da43b2b965
X-MS-TrafficTypeDiagnostic: AM0PR04MB6498:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6498421EBA3AB14813C75DE3C9DF9@AM0PR04MB6498.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5LyPpw+/TTqUsruTqqwEXWUROp40/JSwF5+kKqhEIJVgdzFz4MIac8cAHkdLDhXn+y1Jz9KqnM8sHcGDTJEFn168Xu9LOiJ+Z3ugXzgNeWu1wtki0b73W1KfjbCyF8c3dCMgg73tyTtDcsPYDjCHCbcjokTTo9QtGT1eEWbcpPIROJFMVjVedDgdMj1/ZNGh1CTNvgxA0CG08v/yo3ZYjUcNAuu4e5OYnrm/8OOAEM8TDQLkAwQ+2fTb/xotRWxmxdwGlf2WdNzN1QO4/EolSPliYAj4f77iX9ZjAGtaQ0BAAURPxXYTNV2kiYj9ufSRLKBNu79Hi7dh6+WYu4xGZISRywrkZMqEsQyTheR/ocRQWDcWt7e/izw5d4xQ8as+a1ljP3Bv6IZYj3gFApo0DxbKuDL81yuZ6Mu2GUAzDisvMaaTvAOK4I7vBQnzqQvbBL6CN+Dx3HVFbHH6wxRgvkMGggv36C8ulpFbygjPhkwVSmp7ZwzZzSPQfqVeW3QYzepRTx+t21S8LDbd1Uz+eeg4FBJMCOuJcT3kSILuaDp2dYCqn70+xAM+/cd0xFdK1n8X6x5iFNoDTt4/AJw2MHjCspODADU531tscmYFsyRB8QY4VrBk4rovanQuVkQ/6X4JN3g7QjW6nc0AhFPRfWAswfupmRH2Lkw9AsZucGhxefEkb80Ets2NH1hRFha5jVKfnZENul7vKkTB1snAJUdea8zfh8OVysZ4zvypNCR3JSDuUNf6ZIdDxl/368WoYaqT7/8wzcgPqxxCafIgQ5j6VFq+FDz7fsBpIVkVcNiE3aSOF0xQgYM/hA3wsX/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(52116002)(2906002)(6506007)(508600001)(316002)(6666004)(966005)(6486002)(1076003)(7416002)(86362001)(26005)(2616005)(8936002)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700002)(38350700002)(186003)(83380400001)(8676002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nu2/v2AlRaIe5iMEL1dKDnKWmnmtbrLt9qICGx6Kf2D6DCvHe/3FUMtWfwcU?=
 =?us-ascii?Q?dAhI5vBZXZB/eS6IIo3GZRRjVwhUPx9P4l9F/cz0mSY3BihFf/EK6L9fnknb?=
 =?us-ascii?Q?CWQfF+EUyNnfGukcjCxaLf+c0vca48X9NzjXStyTiXXOIgIth4cGTzcntT+N?=
 =?us-ascii?Q?viBm1lfeCIhHOFgxKOJ6THSTx9iNn3tDq3olp9eBEc38sKzS8l1HsVLc59bB?=
 =?us-ascii?Q?xETnKUdkFmRknqV7uMxkIJAT3UFxNXbMcjZ1Q2/fQ2EedGwLfNWMPZjKVaii?=
 =?us-ascii?Q?mSC+Ax/Y+asIZ06GsIDOYAmI+cMhtjU45a/QJTxyYCwTZE42mNgj5h2UjNX0?=
 =?us-ascii?Q?PB+/FpZn2skKVRfOj0hWXMSkTzRibgydG1hzUgckeoiYuLw3a87NCmTqI81S?=
 =?us-ascii?Q?sNZxCcM5cczYY4gjaDiQqRiHmyRqePTIZAgEjRIHhRECDMatJIl44ht0f8CG?=
 =?us-ascii?Q?84RMpkIWH+cySU3NT0hLq1kTPC9g6AMZWsvnP99/MyGZZ+k1C+zyYmbltFA6?=
 =?us-ascii?Q?nGnzvxUF22GPX5kzUrHyT+b5jD0YNKCntIEcSB5f6QDU2kcQ9Prb21OOXCB8?=
 =?us-ascii?Q?9KqQ+SOoHez/TxfSRdAzhK/X9BjP97LEFK8+bF2nCqpQyWQf+0dyAjyOcYbu?=
 =?us-ascii?Q?6XIxOfNU96egG8iojF4A3SJS6pzcoBic9UjlXRvxPDQk0ug482cQ2oekVaN7?=
 =?us-ascii?Q?3k1iVzv/5U/ewl+WSpMoSq1OHfdVZ+PFf/jHMVdp0OpCH7M/09vvYeXMoMVV?=
 =?us-ascii?Q?nwEE1JVQMSOrmXJvTTRGtrJ7QBFqHcms10H6AC31EdsdfvNKmbL8YV4DwJNo?=
 =?us-ascii?Q?FthRBpe37sYjH7IGyXzxBoLZW+0oVDFMXQu7yM/X/30sFbp9J9ifSIDtKZuc?=
 =?us-ascii?Q?ggTyDbgUIh0lyIl0GMmLVS/wCWELQZv+Pq6RxFBsmCKPPytcrEE8waFOQ07x?=
 =?us-ascii?Q?SaTOE0odwn5PC0O72TdIZYtn8qbyjpbPA9eAxe3awCJyRn+ClmyuqgWp7IzU?=
 =?us-ascii?Q?M2eC3cRPMEeHZBX3ZWxFMIHOKCya6WMI836cMgM+5fUHN2WKXE1iBi0UVsl4?=
 =?us-ascii?Q?ME3nbJfQ/K5FQBisUq0q6hzbemPHj0ACzmYG18oA2lScSjmKZc05lR5r0vY6?=
 =?us-ascii?Q?qjIyoY6tjF4+qk2UwRwmgSHeMYJQD0iavlcxYoszwo0/S2ixEUahWBlL/Suo?=
 =?us-ascii?Q?k6O+ushR4lBjl7926/URRox5z0PWuiQ4C9GtPYuihhLO/XWFwamicFRyt/ic?=
 =?us-ascii?Q?PG/ouYB2tIJEQci6Me/k4VgzfWSUAVr3IJoD/MLFrEKOlYPuVcl15BpOg7BH?=
 =?us-ascii?Q?HAROF/Poja6QvQx5xXC8UkCBKiJeZ/3LGfWstyWsegp39f1oZS4ADGWu9zX7?=
 =?us-ascii?Q?1S3xl8aawjvw7asDpZAxYz+ept2MEzFVQ+4sievJwrCPMH6jb6NHXKlKtjI3?=
 =?us-ascii?Q?40VveqL7YjwEGNK7B6YTyLI9ABx7UWA6JaCajkzX6IoOyQgE8xTjfny8Usvj?=
 =?us-ascii?Q?eScgtGrbh5LXmmIWcwZtyUAtc4HwCR6C/LP8mLdKKxgRTQQnrk0C3CqowktD?=
 =?us-ascii?Q?rfZOKQea1U+Y7tdmagKHtq2Wg+i/kb1Ypvd5zZJ5fTmbtNHjVPCw4/JY2yyX?=
 =?us-ascii?Q?+3/+n3K0PvzV9GceLfpNbaZilR88fRPsDvr6xMp8e4hWHDgG3feBEr4Y0EAU?=
 =?us-ascii?Q?fUFhUKzt8SXEPsQdY/Kmkc35XBqhry1Kfq33oFVvO0D3srQ/ZukkrlXa+Zvo?=
 =?us-ascii?Q?UDPgWjN20g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e6162-6c22-47af-7aa9-08da43b2b965
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:12.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8nE1eQTwgb4i/1Fx3Gj5GQBqCIoyItcjX3NIpcLWKfdaPYO+eeEThidrCmzAayH1Dpk08Tqt+Vs5HFUS7Dx+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC initial
value after power up is invalid, need set a valid value after related
power domain up.

This patchset also includes two patch[1,2] during my development to enable
the ICC feature for i.MX8MP.

I not include ddrc DVFS in this patchset, ths patchset is only to
support NoC value mode/priority/ext_control being set to a valid value
that suggested by i.MX Chip Design Team. The value is same as NXP
downstream one inside Arm Trusted Firmware:
https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx8mp/gpc.c?h=lf_v2.4#n97

A repo created here: https://github.com/MrVan/linux/tree/imx8mp-interconnect

Peng Fan (8):
  dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
  interconnect: add device managed bulk API
  interconnect: imx: fix max_node_id
  interconnect: imx: set src node
  interconnect: imx: introduce imx_icc_provider
  interconnect: imx: set of_node for interconnect provider
  interconnect: imx: configure NoC mode/prioriry/ext_control
  interconnect: imx: Add platform driver for imx8mp

 .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
 drivers/interconnect/bulk.c                   |  34 +++
 drivers/interconnect/imx/Kconfig              |   4 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx.c                |  68 +++--
 drivers/interconnect/imx/imx.h                |  25 +-
 drivers/interconnect/imx/imx8mm.c             |   2 +-
 drivers/interconnect/imx/imx8mn.c             |   2 +-
 drivers/interconnect/imx/imx8mp.c             | 232 ++++++++++++++++++
 drivers/interconnect/imx/imx8mq.c             |   2 +-
 include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
 include/linux/interconnect.h                  |   6 +
 12 files changed, 424 insertions(+), 18 deletions(-)
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h

-- 
2.25.1

