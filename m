Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA45F474213
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhLNMIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:08:32 -0500
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:12177
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229673AbhLNMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:08:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlJkbqN9OHcTxBpL3l3ooD0VKExTH/nX8fhn2QIspSBc+R5OQWlBqKCbA4FYXHkBqgJuEN+8XkZpA8r44PxsubHgpjnuUJxpYC1NyQcPyfwJdW9WbEhnsH8kNimfcCXgSg1fJiYe0h+HAgs5nX/beQxORd7tMUqBTo2026bR1VHIS8KwEuIM78cHfyrlniWsDoJ2abqwtCptZGCzZ5qoHBtct8mZ17+BPUN9gkxpjzM2a8fBX2x2N54dFOgNU7g2HbAyOVr/WqQewAZkt6o7+iBgkbZ9k7nxdgBRIcjx6oY+qIq655kCgA+AELeAvDUX5uQ4dk390iYc3161Zv0NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxjQmThq7pTVe8rysm9/gsbpDP25TLN/eJ/GXqPGxGg=;
 b=SxvWkt0VuwxiCKEo7aMF/FriNzc0TQwCVVB4Vq1LXr6K0Bd9Xbc1Uv5T6PT1XzZK3YXD98gio9J6YvXVhCnZUOEUfsGk6Vyop/26Cjvu6x0HDlI2m+ERm7z7PYJ0la/J3XdiNTHLbFDYBOxE3Kj1zO8fgb3YyUSD+yVPXV5K54CLgksxDmFh3ZTZu0er9VLPeKYZ7fPncDGUmCA6G1l8yj3NDK/VWmwbYMzVIazFgOi+QPsjyTVU8HaYhg1FxBFCnHq/SSpfLrF5IeAld6D+Pvb+gEyFc1tjW7CvWLowE80/Z1DraUZr0TY7We/jR2E8OGwmP1jGAz61pZ1ulkqmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxjQmThq7pTVe8rysm9/gsbpDP25TLN/eJ/GXqPGxGg=;
 b=XCn37jKb6T0MAleXMssy+bMS9YirxNN5WN+LfinVu6/a+0pcDpG5u6kvW/LetmKNjyNo6vAhenX0WXf1QcgSoEpe988udZd5igAIUIS9Iln+WhgU8DqxeFrTFJiSp8VBgl1LGtmL6o1hOHo+NmaEs8Bv5FXw+oqDOVppm4fbj9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:08:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 12:08:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] clocksource/drivers/imx: several updates
Date:   Tue, 14 Dec 2021 20:07:32 +0800
Message-Id: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0249.apcprd06.prod.outlook.com (2603:1096:4:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 12:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b81bf6-2e6a-424a-dfaf-08d9befa6fc0
X-MS-TrafficTypeDiagnostic: DB9PR04MB8447:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8447058351AEDF9F1358D954C9759@DB9PR04MB8447.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjabntwnmmGYWGlVB15myZ3CxtP+MFXzGgWCysxIoMWrIc1XNufpMrNrETPEUrciLeaRrNv+NjJ2h4n0u5+qabISmgVxJV4npir+9mNh3l53FMLSLBphu1jJZ5om7+K4CL8q747SIEODPWRRCtv4kuPlzKC1NzyqovHnLP5mYaAhH5L4MTqJ0mpcGKhosD13wPrP+WND63yDHRN8NTafyCVy71dvPuPt2T5Z9eYWuW0n+mYa0Pp3yB/g5Jyp2+m+IraA/eK+Fr5yhfq6yeU5trFhBJ/FPUNpVqQ689QYQTWxhvoRZvLcrXD3gfHJ1Mrd66s99My3xPyZQYJcYnlJlmu15UcSSxUmkTaeqLWgUz+uuz/RvZIz5onwU1n9KuCUns5yWnlIPUgXHoPtyFQcl3ye/yskUDsl4s3yoTtWtQJH5w0SJcJdgQJcaNmr/IK92OgtW4JpdHKrGupf+D9AYnWN57FvDxuQmFXBBhYMbKNGTZsDy8k0om/Vhne5Y6Z4usxARUJxh9CcYuhJSUVmypRJogdyPz+IG5RCWLxGNUyZU7Yk4VIdcOs3K0vTKThW1jFOWAmricmYedr0pwBan5XYBl1uOl7eq0Eo81vyTp1ROzAbCenRKXyMigbVNCljOJNwWkB95KLjB/KKxMwU0+4YXdd3T1bedKuKtVZ2kc5rUQtVIjn+Vj6QoCb/ret24XbX6EH96oQT2r86YZrgsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(6506007)(66946007)(66556008)(8676002)(508600001)(66476007)(956004)(316002)(186003)(2616005)(38100700002)(83380400001)(86362001)(6512007)(2906002)(6486002)(5660300002)(26005)(1076003)(8936002)(52116002)(6666004)(4744005)(38350700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXeKJ6qeyQ6l3nwTsHE0jtacV0KjFU7G2rvw5fdUUjjWWaI6VjlTNQxahFcl?=
 =?us-ascii?Q?48VrTxkntp92+Jj0Qv2bfJLX8iFS6fcMk5ujZQYPsIPUfTZNy+pabRHP5HWx?=
 =?us-ascii?Q?sS5W7Bbp8Jx46dZXapAM8c6r0cHbB5lkTb3i/s5heQT1zaXFQ0VwZJeYSLIK?=
 =?us-ascii?Q?s7ywOzyAD9ECT6ZUPpnGwLNxVyxY+uofbzpWtX6E+c5ibTzgWKo9bV5MUHSG?=
 =?us-ascii?Q?+RBrqeaSPer2DZcP+FUlqmhCTlPZIkFqr1QXGdn1fclyWBjXJ3zFI8A3lATy?=
 =?us-ascii?Q?1+HBv/1E4xdt7X4HNgfYuHH06icmodYE58KVNrGhbKh4TKkSUbN9AV47MqKP?=
 =?us-ascii?Q?oNg2k0DFFYX1XsQvUeA08ghK17FyZM9EA7Pau2tDqGnUhZiRrBJms6+zxPhF?=
 =?us-ascii?Q?Ukv1E7L/Np5D5Me5Ik8laUbVpxm0lkPtbfejJ4c0sThvZORk/M1YsRNqNt4r?=
 =?us-ascii?Q?rySw7yOKOFGoG8KcfHBll14x4pObNp2y2iU2WWlxE13BCN3PMhOOAMSQyFVE?=
 =?us-ascii?Q?eBr027gIDAYZXIFPWalZ/VE/T0nM8qOELNB8xt0TVWYulu4ro0NadJ+55hev?=
 =?us-ascii?Q?xbBUhJG2Fm053G/+J09bMEetelEJO04Knop9rJ6zRQ1FO81t9TlkeqNWq+Ll?=
 =?us-ascii?Q?CNWqfrI0fz6h+0yPWeSpAFi8P7qqvP4Cw04k6mYTFVzvjMMCxIrcMWJPX648?=
 =?us-ascii?Q?mj4W+l1Xg/cmMHQLtNmhe02DEP2s5XkMW5OBKBHBgYO0383sQ7tVriGolpF0?=
 =?us-ascii?Q?6vwfTlBCPMZse7dgPemPWvDE043QBXa2zSQ0laT/w5VertNbIkN+YIec3hFA?=
 =?us-ascii?Q?h2SC25kxCbJMo1GE12TYtQmaNyNESCqlIUY47znISi0PSwzL4/fPMekXddjz?=
 =?us-ascii?Q?THpxSa1APvq4E5UYROHpGUGCxFYdw63JosgOG6MDYpMfM+VoSJmnwjK4A6Jb?=
 =?us-ascii?Q?YIc/MeTBOP9SYy8yX8LKZ20CaCSK+LBsGFCBMWtV7MHGofVBpiMrp+KPp2BL?=
 =?us-ascii?Q?3QjhQJVdDKSuAND+CbJQ7S7bHzYy95YTtlLMHrWA7z92tcrBGtE/B9pw3iO0?=
 =?us-ascii?Q?b5bIOwiGsti0XuGlQbFOHtrYik+Mv1UZGYzg5CGU/JxuOcmn9hwyJslzmJud?=
 =?us-ascii?Q?srizrg98OVBFEOsZfXQfJVhA2sds0vfbiHaL9shwpn0VHkyE9p0UAI7WaZIT?=
 =?us-ascii?Q?F42ymeTOneUidWKQBvLXMrTmwYWMXgFTdXyPHNVZf96CnXrNdw9NWldgZmnk?=
 =?us-ascii?Q?Q8blYbQN2zFtN5xm53oNLDkdXpa1cPiGT0X4/DfyDUxi3/GXV4i40zFVUU+u?=
 =?us-ascii?Q?w7LZbMbWH+VZV4xDVQYxnEyqZuJFf23hNUKeceCIBz5lWwqwtd7nXohQOHAl?=
 =?us-ascii?Q?61GrefJ4nEubOBW0ydgQoJ3rILzj0+ibQ0ZbAM4hP8o3/s35qVT9qRlXLSwR?=
 =?us-ascii?Q?PCH7ykbI4yFQACdhCoMrgiROqX0Ck3kTEE2mW+gnfoxPbkNGWC/Xx4ZcrAhs?=
 =?us-ascii?Q?OsNWKPlGX/9DQ6SXm00GaZg/PThpFrWMQFBfEc5kvRT+/pGWmMaZnHjDrB4a?=
 =?us-ascii?Q?FlOLOLsJMwooqyDokgA67dpOuwxywjRxa9dAoVj79uTCFprKfBa0yGApBbUz?=
 =?us-ascii?Q?BTm/dLp9RPLXDTvFJ7aPCYQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b81bf6-2e6a-424a-dfaf-08d9befa6fc0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:08:28.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt06/u2xP4LYBQog/7as8QLRVDQhj5qZSd7EDUdlWR7eTugwKyAS0knWaMpVQ6lHQTd2TT1MCUJ/oEM2YQi8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset includes several update of i.MX sysctr and tpm driver.

Peng Fan (5):
  clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
  clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
  clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
  clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
  clocksource/drivers/imx-tpm: update name of clkevt

 drivers/clocksource/timer-imx-sysctr.c |  2 +-
 drivers/clocksource/timer-imx-tpm.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

