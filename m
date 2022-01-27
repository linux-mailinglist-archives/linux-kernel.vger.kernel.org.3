Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707F49EC29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiA0UGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:06:52 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232984AbiA0UGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuPB2s00kTI+nKXc+5O024VcGHe2HFAzlAq1DLehIOWoSV7KLHNPVKyWF/heI0rqchCKxE7hAFDEDs5g/rcb47ylrCgj4KCnnwaCh1vHHGyqfRizEDfxa2ujNPQp+XFrubT6iFCkSRtm6j2MRa4g8xt+yQAtxBsOw6b9UfUTBmmtpkom5vaJsU/ROAPPotMBlm+MNUPpVohcHmPRv4w9lMf6WzYXkjZ6ON1VKL3p1lqo5AgLcgQL+B2/hAon5eaXzNeENhwuTy1Mekl2BBakIVcypPU+dGmHF9+COYWYN3x+sWfzSbF2U9LIl7ueTbmNONRjmJtKtmMK5Zl5RedjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgM57jY4PiUOiEp+JH9zskMJr+c7E2uX0D0+DE1SIlg=;
 b=cem+8mgvbU084KuyJQZelLtUmQd3jFOPsHOZStp0n62EAwMdMZprFv0PpvN/CGyuWSa23+UcPIEGftnVayphEd13KF88XVDGIrHzjStu/3NOYDcjP2ZVX2Gf6gpaOJ2NCUTGuH6Tg9m1FxwIKQz5cX5yaJlFa6GlhKD+IUK4+k9aA/YJCDh8TS0PqYzAgajlHVbEjb40cbXEM7bIGaL8L6hcGRrJzSpbpJw9lg5XODu4d4/D6gMqkFGvstdh9y7y/QvHNkP9hJMiUtgLoSbWRuAf8upO7DJB42PHbhcxthAN3pkZ7ULj+cc0no7px9WMIqnja1oxf6sSb0Ph42MmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgM57jY4PiUOiEp+JH9zskMJr+c7E2uX0D0+DE1SIlg=;
 b=mU7D6LqGr2bQCkxfDjLY1YnYP2ljiiaxbCaH+DuYGz4iZLa735C4MCKZfOdYpdFgYpmVkhIW8g7fdyTcqmxBT1448DtnazFYAV+lwgqq19ifv1us0Wz9mO1S3Ifrlmh71np2LJpLV3O9qMVigdrw3lUX6+ntcI5QRmwdhNDiwHKHXGOEZAbplgl91lbcOhsxSPILN+N0aih1+5Xtfyk25M56d02ktRwE2AYfhOlfMSA3sSB21plFBcVQZjNDOMmbbCXgZkwEw6Gpx7TLtlgwHwqea2fq0k5XRFsa/m66KuO/vK2H6s2G/urU6QynaBJ8SXAMjl1dLtL2fpg6TaJRgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:48 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:48 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/7] usb: dwc3: Calculate REFCLKPER et. al. from reference clock
Date:   Thu, 27 Jan 2022 15:06:29 -0500
Message-Id: <20220127200636.1456175-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b40ee6d-100a-40f8-9943-08d9e1d08ca8
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB3747BDF8F395DF310A8D44C496219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhV0aHSQuO65yVPlbJFN9Iabnf9GRaI1Y6qC8fTbQHHbjaA6IqzJGUxtVu3jarcWfvGac2hxtYnHIRuc4TLmA3oZEHAE3EigUGbNLDywWaPo4BvHkixicVgTTZ9DdAWUOuo4jVe4Wr0bi0daNjDQ+qVKVAl6tiAdm5iabEfryTWdUymrzU3eYgNpUpeen1Fr5pmwwrXtQUax1QA6c8i/ez6GBQsTVwlwp3/OWHeHAGjO8Sp6Eth1kcF1THICOlCroFVE06MbqjwrQcKowO+VTPqswaEEdbOrI8dqOLMNsAMBXJ4DoTAWGVtd9YJ9dYQk1Rdf3NsGRKSW2tDI+q8Z20fXybFcgdJffcsT/cfO7fPaStW3fGd5ii6bEy5FZ9Ki7YXO0ZByDMCIQWaMvr9e12LfbqUN4MJH6Zyv4iU6uOz+wY+WxuQa/vwDJvLm4QwcA6haXWvMI918Qdy1Pe4mZ8Gsv+kBVGHHqGalFvtugagKtSIkOhxd5IvBTDyUlOzDhAFBrZ8dScv/lY0OJU9XS6eLf6sqBWWQkgJt29xdInYT8mTr+IZaqpxSf4GOdbDP/OU0Ztn2W37Nrb02RqbSXViPQ1KUgDUMKCYbfKbGAP+nMabRAMCYuH6Ce1/66MZEMwWohxgYTUNDUB7NCPPUKZkzhYW4lC3DP6IfrhhP0OEYD2ASksYvbPS+ivyqutbiethz/5VWhTOmVbPMUvHrEkoIAIH/pKxqZ/0H/9LpZq0n1b3+KYoydqGFxoko6cR0RITSGpwsuGXKd6RYWoTsNCXKBE0lLpPJvtg8vz3cEJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(7416002)(54906003)(86362001)(966005)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5IjkQowUNQxk6TUBaSNRbSYP0Moml7D2Sz5Anx9ujS8Bm+u1rVPmW+lhBOD9?=
 =?us-ascii?Q?EwBpgBxviWowZoWt9kmJg9P3la+BhLTJkEGUM0uPuAKFGtPMEUTbUshJrQ1Q?=
 =?us-ascii?Q?8szqe/fmBLbH+mhVdxfgWQ29nDeqo+X2MzFdmWYszXXmjcpDj2yInk7zcDQD?=
 =?us-ascii?Q?yiqYZWQXyJbcZfB57UxR1ipTbIkfqYL170Q8SuqWo8td5hkqtpp5rdgnJpK0?=
 =?us-ascii?Q?XL5fqIfU5SQAsxnQB8FBkr0qDXFo8NrHCnziaaq4p85uBN+9UaSkYYusFepa?=
 =?us-ascii?Q?BUa5/A98k7Tupx/2MJqIlxhe8WWNnYyAzLkIbBRsb4GYWo2zedn3I+5dDov+?=
 =?us-ascii?Q?0Mu/9Oi2Shq6bwbeoRi7YzzYiMs2mWqihl9OjONTb8THPp90nyqV8OUqt+cM?=
 =?us-ascii?Q?ZZrrmREboamvXewRNsr3EIiW2AB1Agw3hNG2M86K/ZKFhnrGyG0Jb5aDgw9z?=
 =?us-ascii?Q?1YiA3mOj+Z25cIRjO4k1bE2Y1nLR6rk2kG/g635+YAkGi/iWXUIjhy4V7opQ?=
 =?us-ascii?Q?lOEjWiFCFFl0a8gLzc2uDZp+GfCr8beC9JYfFuqfT7/S3I9X2bQnuXmce6dO?=
 =?us-ascii?Q?/xk1eqUJlHTEdLeopFWwoET/yI/yBSjGYOeHWvRL1w3o0kUo3vmKsQPIVENO?=
 =?us-ascii?Q?JCOp2KuVXozpfyQbziw5Ma8pm110aE1EvBSTlYjxoQ/2xMzqstiG8IeHSuqr?=
 =?us-ascii?Q?wVmX+uO4MDo9tnFnWUK65uUVJi5BbAkY3M8Ali5FAjan9HpCv0/UaxhrxGtn?=
 =?us-ascii?Q?N+T+BzMUmZyrGh79lixPf71d0zeGzLcaG4v9wKsSvJ341Ch+5AoMmD6zdDGW?=
 =?us-ascii?Q?ZQvz3g410UWBbvLZsLpOvIPG1mmoffz2gpig7YU/D6BTSRmYX6al4XBxFbVz?=
 =?us-ascii?Q?QPf7oy6dP+sDwfdu7NrWh5LkTIlfB/vMRnXavRiUhSvI1OLVsW7TBud+hDZd?=
 =?us-ascii?Q?DSpGacxl/PDY7CWE2XRNCUcBubIkJRmkvM3TaaReTOUvXHyC64/izIceAb21?=
 =?us-ascii?Q?f+JtMf0fcy8p0D5EXSelxgtOEMvVW21klu/RZnu/KmgYWGVJr9wntyjgUR2t?=
 =?us-ascii?Q?u659eAFGIBqMbAynH2zXaKUy5bS1ux4px8CJaGPPtzjnaV+94+q4PVVx5Ahv?=
 =?us-ascii?Q?LSCQK6tHnw4k/4aQto2qhkkHGqflG9S5qZ3LT4VkXFbq0JhoIfYzQ3mXlYiY?=
 =?us-ascii?Q?RBK058WDWfKXlYtTkSwAWKEf/hOju5/7ral60DRta8+p4PzREka1zb1vtU8d?=
 =?us-ascii?Q?Hot0tnk/9PtM7f/dhAfMtvX+XVOMf941E4MW6JyQPOcQzdSfNLNIozvKcFFi?=
 =?us-ascii?Q?I6SJAA5Nd86Mj0ouDawU3Svi1xyFg2it3vSAlyp9B+s+fBKu1SM63iku6fR9?=
 =?us-ascii?Q?LcaaXajVzjQqPLZb/J+p9lEfa05IbGXsIGHQAGs9yP6CdnfMlRikSU/SxzE5?=
 =?us-ascii?Q?s027QG6THqZa8xazYNGJLp8D3YCMHcGYJhQrAI7JfQac9Uiq0wPyvw3i1E7f?=
 =?us-ascii?Q?FvZVcORtuhgam1Aghpqt8RLZlvykPOA5aaaH3tdEieymOGmaxnDDwDltmuN1?=
 =?us-ascii?Q?byVIkVtlVLcoo1guHHF9OcTDkyR+oJ3At8BG8KOi4UUNtFJx/nvOghFoYaEn?=
 =?us-ascii?Q?DCbp8PaGPsYFgN4EfbkilnI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b40ee6d-100a-40f8-9943-08d9e1d08ca8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:48.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvMTQysk8Sj6CQT0G3eQLWzKNBLgt5uB072ue6IxMXoASSqq4+Kvd3kuNIBCz2uer5dk2/ndJgLOjfK50/6IfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
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

Changes in v3:
- Define each variable on its own line
- Rebase onto linux/master
- Update comment to notes some things mentioned during review

Changes in v2:
- Add snps,ref-clock-frequency-hz property for ACPI
- Also program GFLADJ.240MHZDECR
- Document clock members
- Don't program GFLADJ if the version is < 2.50a

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
 drivers/usb/dwc3/core.c                       | 117 +++++++++++++++---
 drivers/usb/dwc3/core.h                       |  17 ++-
 6 files changed, 125 insertions(+), 27 deletions(-)

-- 
2.25.1

