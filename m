Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2943648F312
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiANXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:25 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbiANXjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T308MYlyD4z5J3rgbi9oj2jQufJWLLBLsGULQSClCMPmdzUs0NaKOJioKJ0M4UVjc7TAYO8CREypVj/3oBQRy+7N0/oMxoF9xWewjw3IopJUsMXn1yt2yAQ2Kv74D1nRexY1X6/d+bM0/qc/b+gh6sd6M+59rBf9bR1FIIzwZ+JrjRiADWMULVHVVmH8UUS60AWixVas7fxcT1hGvf4PLmOaB2utMevkdzW/CBhG7J5ET/bjww9aRQCFAsUnM55zPlhAmU7CRgy/j53TWlAlZ+GkRYUOSKFzBdE/59+jYS/S7KQmY6YyqFKSfLHzVxplqi3BNx9j4xiC5+ZYue+Fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdvaL7BHS+jv/RRWwIgFK9LUgTiCLAJamu2L3zdpV1I=;
 b=PGROzZOi5X84gmQZfnNh11HhGVavwVwc4/ASEjYpGSNZhSmx0W+dnroSB8N0PqtpK/z9zglRDFohD4Q3T5xdbffX++FXUwok7bIVGb11Tu7Whj3eHvwfc6/0paGoVWxJ8JTtgaaBlApfi76b0mVHocrBA6V470nIPX7m+7XoCWwOf8GhfHXD/J5AZy3SK3vSoJslW9k6WYOZo4GnDYo0Kd0rVMkfauKiPNnEoXTn/LEIeWk17RYUG5USCcv3nUiRQegOdmPCIl+tRQr9Gt5zirgZWfqbtwy2G9Q8NvsRiVvN5jwFZq6hUnvxHDZohTanZD01EwBFcwhkglxQeHCkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdvaL7BHS+jv/RRWwIgFK9LUgTiCLAJamu2L3zdpV1I=;
 b=aeNegaXqv9wqTWBN8ka+ZCDm9gXGgwj6jqsQc1zQNGh8S9LgjLIzqMCVq3xyCwpFf12j85hR6aKrncDPolaFI1h8NHQi5vbJwcFo4edSpDvgD4fZ+uST4+gKv6D64ha8OXjLo+g6YS+ACDaUlVh4QWJ/KqUrVRnlTuKbs9oq4hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:18 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference clock
Date:   Fri, 14 Jan 2022 18:38:58 -0500
Message-Id: <20220114233904.907918-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54eedfed-685d-4ef3-34b2-08d9d7b7141a
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB43366951F0A49371C5FAC3A596549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0IPHw4Z7fL0lRX6t1TPwaRVciNEwmYYHsj6hOtkoRUUdYD1pUUJ+WXMqSGKTNeGxLxrBe1SOMCGzJbSqMbkkKGervN1127ACs8rTOeKzAtCbhDVMkREYtl8jEF5ZQ03EkIRZ9yvInsCAY4uUZhTQy0SSx+T/LW0KIoXFWw8ys4nnSMan16I/Xxe5eauFSJmyYkQw4nI1wvWef6SjpcNDGduAKr+aC9hfmkkIt/D8DQJ8s24W24VDpEIy9vm0kIRG6+/TyRlSsRlnyH/NM++NRSemUkIyCzsTegVeYU+3zhTh8PeUCXWC1uI8WCXW11jzVYiP0Vr3tjUTt8fYlP4VyNxWm4rEzYKAMt6u/yTrppGv/yNDaaNhTiuy8QKScRyLpwNscCxBO0KPxD3l+Ml1yVc9o7hP1XjngENRkGw5UigK4f4EX2V0prtN/7X4X9Ra6wtf5tUngxe6SsbNrbEF8RMbcSyoPp9TSO9FraTFCA+ggKSei+xz9TNRgFULwJlR0DYUfRjvlMJ55yiL1UXpz8cZOU5V38ZPMxSRMT0pTnnOkmmxIY8VQya4f/JIF7Tp67pKSJ1jyLtijQw5DlBD+280LieGQ6O5fFw4vpyCWJeR3AsTpVGBfWP1sGIUI7bC16bow7eIvrl88Xh8YsqYFzjPKvuJJyS9dUdu+gOFRugtGJx4Q13hYrdJN76M86AaqOfi5MR607nyPyjuh90h670LMUvm/LOJM6UTWuD3JT4mwkhR3Hg1NtJprwRV2hI0YbaVE9YCfOSrouw77gDMg//15o64ydtM6IqQfD5siE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(7416002)(66946007)(6506007)(86362001)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(966005)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYYySQlE2pikfbJdxgVK2X9kpFkbg05+vh5F8A6X92f9k7KuUp+j8yCopnZZ?=
 =?us-ascii?Q?qraC8vYjSMOG3D/ltcyVvMHJOrbp6jExRRVNX7BmO66pr4fCJ2aLRU43mRXM?=
 =?us-ascii?Q?uRqgvJD6uxkSSy3MQlNbY79S3pLeYwo2RnKXNM6GTf+QdOeNvVXlimEauVP3?=
 =?us-ascii?Q?obU6zniEs7ETN/GZCjEfguPVUWxisblfjUK0qBbkATyp3j7Ek3W+tt9DF0fk?=
 =?us-ascii?Q?e9DiP7kSAIrcyLYWDhj9jl6REsbqi7s0Za2DjHfK9dj8Hh7YEQSYnKecJV9S?=
 =?us-ascii?Q?agjtMlQA2NOLjcnSvN7cVbLkCEmgi5kp0lhgFj4JEofKvztm1ezjE0LW6/LI?=
 =?us-ascii?Q?t4422LdSf5LtQ86E62rmaD/6g4SqDe0E2XvT81iBxH8cF78dvaIvDcgrbX2L?=
 =?us-ascii?Q?ZaRzTj41vABgPVd+2qsg+sPjeVwr5Pg3kf4WqzHP2yMiJarEnFPP/BCOZZu3?=
 =?us-ascii?Q?tiRSmSMJ5CUN0UrJtUA09XTfPGDWkLjQPmC8xrg/4L7+JcYK0XlZW8DA7Zby?=
 =?us-ascii?Q?5PUuqv6FjySDIKva4+uupPHLJYUR+CDx3Bs8ZQt1s0aRZkgENw1W42h4J0dw?=
 =?us-ascii?Q?b0WTlZYV7XHb8HySEpRXG7nBgBcZ9JbOVZ0ZmnkTepmsHkdsQZgx5UZt7O0P?=
 =?us-ascii?Q?yl75dm9yy49e+zqedbCpP9fSd3G9IqXYNLB94K0g+H5Nu4K1Scfiq1d7nU79?=
 =?us-ascii?Q?rWARBHx8+qci6GgXs3CKBvA9vFa/DvlBlXRcXGRPXZufYAGsxnae+pNH5oem?=
 =?us-ascii?Q?QJZet8RqIpOxgDUiWzK2Fx15zOZGiWRw9ejADKK2iA8OQs0dtTfUHkG1nXLv?=
 =?us-ascii?Q?d4wL20A/qnzAaLVgfl5YQd8ZEP7kbY+1mnk75sHolZJsPGFIuzp0XyadgP2B?=
 =?us-ascii?Q?k6v0SBLfQrdMXeJwGSvunf30WmkEX4z3Dm3B7NwZVmksZFzOevpBJFW9Rrhv?=
 =?us-ascii?Q?87CY6jhCiNmQjZlESo4df+tsWNwSrW+g6qTCGDB80OJFwHTdKYwgPYZDLimq?=
 =?us-ascii?Q?h27AFh4Hak821wUjDDKyR3q7PeF/2/e6kqUC0/aStmd1VtN3MwTnpo02YCct?=
 =?us-ascii?Q?wlqwKNAeMrgdI/Mf/ACF/Ag9UeLVzEyfGIdbLmWvBgF6l+Bk/e4Ez/MJ4S3s?=
 =?us-ascii?Q?BfrasP26V30sdH+CQssRrIeI3oC9jsnY4LyBbvEwU7dKiVa3p55JVm3B2LHW?=
 =?us-ascii?Q?o14ChJcucm7baUsDr28OL1JdKQV70isNebd+eYVVTxbN/K1c19L49tVal8gA?=
 =?us-ascii?Q?BWfaeMk4tqNtS6CSUwJWGEdwDvzvM7BMilAS/tHfzRirrv6xdTX5qp7zy7uc?=
 =?us-ascii?Q?N0RtTGw/GToBc3Vu84cA8pmcI0QlfnMDTFuBpAvAAearrRvkbD4UDyr+vjGm?=
 =?us-ascii?Q?ORufUjg70kJID7t85nHTXOm7GZhX2pAvtPBo6/Zq1m8jc9ARZzM3iMp6v0NZ?=
 =?us-ascii?Q?OT8iR6fGhLhH87pDElIsSfwpuzY03rOylut27kbpKKQur0tJQwrbxNLWBHn0?=
 =?us-ascii?Q?5XGYvNu15wlLmKdp11IgnvE3jkUDJq9BbSiX0/+lIIO9W/tp8h5WSzM/NfBO?=
 =?us-ascii?Q?kS9beKcnDAvIDxCAW0ptzeWzenmeAH7O+lKDlrWjthXhzPf2R8BHRyUpSbf0?=
 =?us-ascii?Q?ddEyP/Im8KqZ4Nt3fdqC3p4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eedfed-685d-4ef3-34b2-08d9d7b7141a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:17.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBvnxOZuGiX7ReLtOjaXgWjhol7XJ52bUYgQtVJIJaUvdF5E5jLVkUF8Ii9b0mgpL1oLCBxASK45EHxjRmwZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rework of patches 3-5 of [1]. It attempts to correctly program
REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
we no longer need a special property duplicating this configuration,
snps,ref-clock-period-ns is deprecated.

Please test this! Patches 3/4 in this series have the effect of
programming REFCLKPER and REFCLK_FLADJ on boards which already configure
the "ref" clock. I have build tested, but not much else.

[1] https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/


Sean Anderson (6):
  dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
  usb: dwc3: Get clocks individually
  usb: dwc3: Calculate REFCLKPER based on reference clock
  usb: dwc3: Handle fractional reference clocks
  arm64: dts: zynqmp: Move USB clocks to dwc3 node
  arm64: dts: ipq6018: Use reference clock to set dwc3 period

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  7 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  3 +-
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  4 +-
 drivers/usb/dwc3/core.c                       | 98 ++++++++++++++++---
 drivers/usb/dwc3/core.h                       |  6 +-
 6 files changed, 98 insertions(+), 24 deletions(-)

-- 
2.25.1

