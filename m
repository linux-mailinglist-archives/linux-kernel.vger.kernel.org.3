Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA64931CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbiASAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:24:57 -0500
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:57574
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244782AbiASAYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFnl5GIB8PBb3jflwKo1U+eCZULFFX2XuEMgTERsED7avpzA9RsZ1XMzKMkeEJzpdCSO54d3X4VgkRU3MCrsm9onsKb6+WsriSv40L4/hk7DPUuysgvntQ0JUT63A4u1tUwXU0NVuwQvtFac7u/sjqrtUiBRQhG9QOtLQYJWvdQFMK4S4UnWI4tTpz0GzPMMtt2sa7XOx/gNM7vA3PgvfEKssI2i8pF7sZ698Y+CXr5so3yC2wer5vm6GMkLkeXK7/aCJrJ1a48aXQTgJSXXqOY+n3RK2agylesuT88rCey4I/GlRR3vC60v+ocY69nctzVEzoXsD6EfEegTfk4udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk13060R6pePb4QUyWSQ3wG9LNZqe9CwVWqRDbKs3HI=;
 b=kbwdb4Glkz7fomFMYgQvCwhvNsyI4/5vcwMtoR1iVyHoHb6ZyggW8tJumFl4ItADdATmCFcf3kUa1Rp4rfbGB8nDLP+axJcLraqLc5jQH5LnwGAsfRKPf9J65TiFU56zHCuNmlaE4cYIFGLMt1u3KaUqWDwvEiytDvLzPgNwvaTZwsomb7t5F9rFHvX9Y2Sk1vct/C7wPh7OPSe8gOW5qGb+n6D20ES+gkEql5heGqNN/hVFPVQy/8XNxVw8HgUaSSbjigAXD6Dt3vmEEtB5q5mBV1toosSb+BcBepG1ZlNzhqITSHWA6VDKVAJHGbVcPjXrmKEneEGnq4ZTGkPpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk13060R6pePb4QUyWSQ3wG9LNZqe9CwVWqRDbKs3HI=;
 b=BFCyRQj3azrnvCI+7WqZCqL76KMXy4x46NakuEZkwaWJy8eh0JoFSY4BZB2rlWTEOQ05M+uy/Et9IzqEJE4AVtY+Bx69syLxd9+XuBBe4+SJpuQ990NvAKmbEtBHoq9dtNa0wSGs4t0Lg1APY/q4wtYhBC+2UgPyQqOG2L8qFoekTfOBTD5lpFZhS3tgeiIiWq2oxnHDQvm5RHY35Valn92ufm+7CwABPbUmqlRGrFGrAwYrY2oGGBCwvuP3S3o/TwduuCdtdiEbutP0o5H8zAlyZoYFPnT4hOPNKWbLwXHZPQltKNaPL/XnmsNoAdf3M7zBytIs4WtJHLeJu/82ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AS8PR03MB7304.eurprd03.prod.outlook.com (2603:10a6:20b:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:52 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:52 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from reference clock
Date:   Tue, 18 Jan 2022 19:24:30 -0500
Message-Id: <20220119002438.106079-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 867bb4a1-06f1-442a-aa08-08d9dae21c58
X-MS-TrafficTypeDiagnostic: AS8PR03MB7304:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7304146F75801B70CDE6E97E96599@AS8PR03MB7304.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gP3jJJHtXB7JhkWtB0E1gp770jTKkRvUTAJbKyGzsw9TO/fN/4vcwbRKc6S2jvV0FLaksOewC2BkQcE9DiHp/XTz4t355y7FGBFrxDumxrc9/fP3AHHMLi+32HFMlU8/nDrYvU+Vx7F7j0HEuBpH8zJ7tPGyTOymQwNsXR9nzIUCOnJKvp9IymDYaEW9RMhw/stZRfE7I9w6QMzS8D1MzYX/WMy1VUH0bGIdWqBdDjll/sAjEKpUObr5PKu+FQkoTTuZpCsPpvnkFmKeqmqgJ8cl+0ygXDdO/B72tmWq8bmQ64ulNO7S/kZad0QwNGfrud4bqp2sd/NlctUVhDdTp02Igd+2IZDkuFEEJ+fvNha1p3GZ8YP9+n0WJ0IklYjYyYFV9RABfRDakxjlVucrs131pDahlvavxzX5do0GO6EYBFsES0Q2fLZRlrhoKC1LaFQtY5hhFg1NjM7ctzJUvggeLowzMzRmrXXKM3TPZp7kEqwkF8RX9K5TOWz+JgGuaCHfoNnQ5bOiriMbz8nceINwCm0CmnSUq0QgZ1qDwFqXwv/c2f1mop9KpIKmQv0fDEI68TVmJd5D8m3iCIi9iIbbqOyZHvJogzpmZWipOhyV+3pNEjQFrS4uGw/aIiL+Qq7ppp11AJAMzFWLvgM1i8/mT5H+2cmJYKYOZA6sMf6vExGp3AYRTKzt0j6+OE4dYsfxNb23dYaP4rrdJktEKWrRpz4hTrYmA/reZRBNCHlao17OP/3F0Ojuj1k3hfrl4duC1I+pa3Q4yEzBJ/nD0f5vLgf1ovwKc17F4yiTQWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(86362001)(36756003)(44832011)(8676002)(8936002)(6512007)(6666004)(2616005)(38100700002)(66946007)(2906002)(6486002)(966005)(66556008)(186003)(38350700002)(54906003)(7416002)(52116002)(5660300002)(26005)(4326008)(508600001)(83380400001)(1076003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UvcfiIXToNpqkM/7Xpa8ijjzepRJfBPpNgusuXiBYz3f/o/TWUFtS9jvAs6?=
 =?us-ascii?Q?uywe+w0y/j+Ag4DtV+sGVDc5KkBcYJoNTMTFlDpPu2om8Lyr+yvMHSB7sTlS?=
 =?us-ascii?Q?2qmgfd3e6A3AbD0s5mjHbdwqPpEDmpHVIIV1rcG7FdPubeIjMFtqUsYrkVrZ?=
 =?us-ascii?Q?scY/qnaTC16K8MhHozBRRfW784/mNRtsUI6Tfb04K5Otl8Zn6wdOBuZoxoRL?=
 =?us-ascii?Q?5rj+mQ6AcmXdDLcqQScQXI2QcmObScnHKBsXl8VFlN0NU3OZQX4NqTTyipdP?=
 =?us-ascii?Q?bhUogpeefCZoBAdAwgi1zAOeTfPGKizmM0TNqXvBnasHeMWGzGEp+RBFcSIf?=
 =?us-ascii?Q?D622nrM0Tn30hgvdpngpWJMac1EQshx0d6hIW9eDfojU+5IFPqsRahyiknOo?=
 =?us-ascii?Q?6FS9x4x5Hox4Th+kMch6cROkqVMlw6ATsErT8uGTxzK4xAuk46bme3N8FAfI?=
 =?us-ascii?Q?l6lfTunzNpxhEEguYreNIxm2jsHS1n09TszuhyDSqwUSPck1YBoVG/qh64r/?=
 =?us-ascii?Q?6wviWLGRozZfDzZ7DonuFw1Y+0/fB31k0qZqzA6fbqOCRLz/izgfHyYIP84c?=
 =?us-ascii?Q?VipJV61uhtvDxLrwv0wFtAGdt1HDXBj3dwRGK+xY5d9wn6W9PxTHaicOBc58?=
 =?us-ascii?Q?8ufccRfqCEgzBqXK13X04sG53RuZlT9FT6S6wuYCigD2IGb4cm7xTpieCJtk?=
 =?us-ascii?Q?EJbWZRvr30ZMIelFbNKgEPGaQAr6rQ6iFYe0t26psLCu3upn1VWD7FjHrMkB?=
 =?us-ascii?Q?iXk9NyIXUp+ZB+f4K0unr9Fw4atRUPSexw0wUiHOvOiBMUXe2csZhg7et8yS?=
 =?us-ascii?Q?SS379Xfk2rC7p5xyB+NGenvsoNemolrRYDYJ6duC8OvUlt2tFxa3HcvhyMhZ?=
 =?us-ascii?Q?nXoFCAXE7tsjt/YgDnMgT1j3eejRCMzbHNnJn/hrtm2LrQYRHwJBEU6pAyqW?=
 =?us-ascii?Q?Ga5MQjFwEQiHdm33Uw07/X/UyCUpgnP1doswX8N6k7XhmgDJZIr92WIIyJ5c?=
 =?us-ascii?Q?/wzIVOjGPqm4Ko+Jk6FvMnN6hRTOIXgkA2f/Y8RblLUd7ZSWG0o5Kl5un59H?=
 =?us-ascii?Q?X0VwGvtfel6ZePv5escLWcNdKgYZkag4UDdUugznVPtgd4euPNcSTjB85oLh?=
 =?us-ascii?Q?EYt7bXQ5vJBgSSEOWGoeRXt9ZvZkKqOZyUQYdqt6h1GC8k1HaA57RKlaRJlh?=
 =?us-ascii?Q?LKFKQksOyyl/f7RZCb409ZpsSWObHDkBSV/3VLbQtsR43BMJwvp+jqTkcHVO?=
 =?us-ascii?Q?3+qzW/f6WaroUSMcDoCGpNa/ceVJFeOVt1Zf4hyO7dWnr8SuZAh//85qZ70G?=
 =?us-ascii?Q?JmGcDgUJwBNx0uGPb44lRXcv/SggT9060UPb8tKyWgfdok762cx1U26b7rkq?=
 =?us-ascii?Q?Aac9EHvIVoqKEYFQORwX5h2k0YqDRxTOnxYtQbhgGxVI3c59X2Au+dnCuZIj?=
 =?us-ascii?Q?UOiC9Ielik1+KIeJrmfwhY5tArQUhUnpPk0kRGwYOO71vh8fxi2srweDbOqy?=
 =?us-ascii?Q?P3YXsK5HcQxp0nto5xnXy+Al3BvbZD1/ESe+cRNKUhj/1t8tzpilEeYG89Dz?=
 =?us-ascii?Q?oQrxVHyfP8jexJYbbrBxtBnCKEHH1bX7y4mWpcLmxUmW9ZM8hmsgTAN+YYKG?=
 =?us-ascii?Q?HeebcKJdTMW81zos9pTBPcc=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867bb4a1-06f1-442a-aa08-08d9dae21c58
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:52.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZU4RcmjfJqWQ8OCrhp+OjJAte39jCu40Njh0c0G158+2P3z5OFNgOe6IlWP8xFcSaNTeRuPPpQ0NPUX8YvkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7304
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

Changes in v2:
- Document clock members
- Also program GFLADJ.240MHZDECR
- Don't program GFLADJ if the version is < 2.50a
- Add snps,ref-clock-frequency-hz property for ACPI

Sean Anderson (7):
  dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
  usb: dwc3: Get clocks individually
  usb: dwc3: Calculate REFCLKPER based on reference clock
  usb: dwc3: Program GFLADJ
  usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
  arm64: dts: zynqmp: Move USB clocks to dwc3 node
  arm64: dts: ipq6018: Use reference clock to set dwc3 period

 .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   3 +-
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   4 +-
 drivers/usb/dwc3/core.c                       | 112 +++++++++++++++---
 drivers/usb/dwc3/core.h                       |  17 ++-
 6 files changed, 120 insertions(+), 27 deletions(-)

-- 
2.25.1

