Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBFB4931D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350475AbiASAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:11 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350450AbiASAZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:25:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVjU+nfHxNqzIExzRKsItBIck3Pac8Lugn1yxviRqtnB+G7AJVYA6swEJO0ASS1+XxBKp0MXYw0lrmJcCX8k1iV1ZX96BxwgD0bJpQJJ2FHBnYkXonjvDLpBlCe1IGcKgTbkAQ1oZDgqfklSmKcOVlUsqHtYoPHuFeDayD3gVkeXTGo3dWmq8SWXT/eH3L8iwADuVHozxrQk+R88xfAM8rb5DLvsQXakK+JYOISIqhmrXTQOPpeaOrMpx1tNxnJawdFuDGtNIPgfEdy9Ey6AXk8zIA3WqZmURl2avtHMiqqRtpLvCIXNJscelaG5BMnexlYSwgieMQFscac+xnjIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE241Yshef72O6Pj1+srVoD9tf2ZCPrsGlJHpsR5UFI=;
 b=Lj13yyqUvjjHgWNJrwqrZzODTb2xO6YFAU9OyYM2MTntvMOEnvdp8iPm5pfjx4Mv2wqctXId+3j5rRt1nyKmjvZCx/4KtwGmGUpFpSmp//v5DVPOMUOjsorJ1dYAxJT1V3LOhQsiCsiQoGBKBBMGJeBZaQGkKyoVRPBEBIsbkv9crfhIPWdDIERIsBwucYm9O9draiIVf5cVHle2CRmQbdJK3GyEuxVPeQ+kanvxUr6FcUl10H2+a5U5SQEsiKewIYyiBbw0ZYtO6UiRRY2XVyy4RQX/cveGfjAnIUqfN90ra7PGJAZGoSbcZrW91W4f6o/ie9lBSGO+UFpMzTwkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE241Yshef72O6Pj1+srVoD9tf2ZCPrsGlJHpsR5UFI=;
 b=COCh3nFhVLfULGpVYHeH1ecnpG8SZziSZlpU5DLhTxlfqAb0sazGOuq5K/RqFkQDpQLx2QtpdGv8Dv07gwyo479EU2HskvCrZhPQWh2Sr68kiuq2+WfzcuF4rmZ3IHyCOKRoX3rPlwSmMvWTH280GvAFmAS2sSLf8m8q/f5d/NhGQuVCx/FVptV5Src9Apa813UEnkc19hRJlopw8/DQ9mSnFgA1Dz7B6LIpZrQko9dJP9yRH95X6ACYt1CSMWIf70pfeYEw1U59IzVDKOm7PFQLaLUjduBjlPiwYUeVYB+zK+K86VOLQyXzaygvHWkkwVWqLGDnteQdPRmxx4Bq+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:58 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:58 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Date:   Tue, 18 Jan 2022 19:24:34 -0500
Message-Id: <20220119002438.106079-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274f3359-2ded-481c-ab68-08d9dae21ff5
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB43738B7382678AF78C6A10ED96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p58fd8NyE7vIj0crbA0V+qPuqz8gNJytfczIMtqmJld1HYypy1wFID1x9UbqS6odWvZIGJTKclCaGCB4akCYiEuf+4kEKHiRztIYXtoWT82ZtyZRj/Kb85yOgUrUaUBGzSNDx+gFs8eLsX4YMgbkzoMxrDB+0QS6LLIYYCQc1AOJpN9ESkeb7DAyYgPSDGySYJYx53WhQ17mycQzXObu8lGdIUom/Rsb5xspB4pRHzw/JzmLEFJ3FUNCpQogUXB1wkj8d1255nYu6bH1G2uq7+BCVsSZtyxUvDIxnklsyR0jwoPuZ81rHuNeKYqCR8n5N6QBeSsqxMUpE5PyOiEpQtBmH8caANJ2FudqKXg4UFeJB7S2sJdLH8v6KMNfeJy3rZOE+NTtwvsAEAvRlCV/Zws5h9lisYdHPLewPBSx0tACfkWOWE1ngvrNjnbOX5LahEvFngEu4qaNK5GzCW9+mBuRtmEpTjFKe0x2J1TrYbshN9BxtjjTlQ1Ivz2aJwMhm4984bqWsYTA6W96EohWEd2wYSfjjlrv2H1E1OL+QLS5z97r+9OnSt5mo/exA4ux2LgV6j5+9rROvuO7JEkXdzdiHBo27iL3mW7aPGGb2y5DkW93p0g4UColY1AEScy98aSbtRZrLctB3TgyZDU0mP35G2J1hKP2iDNSuE7Iqc13Yt11hN62lLFzEmQ039K9pd/4FWunp3dAdB541bHYXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQUsAobo9SHPtt4jG6ScIZR5VSNTt89VwE2AhopE5Sxk0hyhwZqDkfRFS69I?=
 =?us-ascii?Q?2o5T3lm5JGtOrAMl64zizYdI4DzegsCjOKN5iUnUYPHXq3XM1TzgW9MP7tCp?=
 =?us-ascii?Q?FnIramVJADeb1K/QkshsKpR5P0kvMFJA61Ks9naAOgRdsaiy6dEQz8HAxhYp?=
 =?us-ascii?Q?SCUUQaGJ8WkrWIbZoQa9QiDKnMtTgHzjjFazgQTGYI8v3Qasdg25o3LTXWRU?=
 =?us-ascii?Q?NAt9zEb+rBPQy9eAlLdf0evD8A7NwFii/Tv8Q5FEVIPdFyKJrj2RHTrJJo2F?=
 =?us-ascii?Q?LGMR02kfo4jNQSRpdHFYx4llGEaWCkhJ1z4c1WgwreMKF8gMtH6UZK4VNunW?=
 =?us-ascii?Q?cmVZ0AlK/pOMLV+aj5TPDwHNYOdMNOWDBX5ECMf+7MjGsACMJbGu3ARea5zc?=
 =?us-ascii?Q?aJC5yTkGrc8NV6nlSk08ZqGHxTHaVo8L+6+BFIfmXD6C+vuFGIrf5rrZu8sP?=
 =?us-ascii?Q?jvTETMcd7DPEizjUVarFFwuNgIXha7vMnBq870KvbpZ/ngW8ExRilx/5vBbW?=
 =?us-ascii?Q?1PEQ+7wk30WrforZh4SKf6RMDIK14U1vr378zBxG+ryiIaDl8vdARXDdBPtg?=
 =?us-ascii?Q?SzKD2+QzwajKnzmEdlmtFQU/WsRNwJ4gQ1EvG9G+vdCKRxcdV89YRjqXprz1?=
 =?us-ascii?Q?4FqozaZ1zMCllAOnVJJhsnW0lXu5vRvvkvd3Vu8uzMHOnY8raW1PHErjgkM/?=
 =?us-ascii?Q?KnJzoUH1OJdL1viwHQUU/vHhycOEN0z8HsF7LeMBYyq0I+uuAzyXlsvTNw+o?=
 =?us-ascii?Q?4BDXYZdwrOqqcBGRkwUme25NhavLyj5Y75sl5VR0fdihufFJ9UEnsOxNmUf7?=
 =?us-ascii?Q?L5N1Ake9DKCmaKdVu79279hPCQ7N+d93rxD4UO3Nw3bmvGZEX4KJBrB4REd9?=
 =?us-ascii?Q?1/WMtNKZPDWWsxJkzfA+ejfxTQ4tEKPvKapAQaDmrg3X1T0nEaXJeyks+FIj?=
 =?us-ascii?Q?/+zup0xZK1pAQHAb6sdFXy1N6WXTzAI4tPmsV+8HAu0d2IqYkNtvQWG9STj1?=
 =?us-ascii?Q?kxXYE6uBGQmM5aSDO0y7RuTDcHnMmlHMjBK/ZVa5WT54wzSAD6StW3x2k0qZ?=
 =?us-ascii?Q?YIU/Auk8UG7ttGUli91esGF56R2Bp0wamzkhSW+MnpuAavvZVhz9t+A/UXRm?=
 =?us-ascii?Q?V9ADPNNVcqFpfPn9r7QNjqBPo3cFnC3lYyhwHZJbznp1NusmXO1gw3K01cZq?=
 =?us-ascii?Q?5DcfRU91dZVeS9B7pzHOQZePceUIzcj2WrS/zNqKj0L8nhZSXdH+KGmg4QA9?=
 =?us-ascii?Q?WhnnkbrI8WYvg9Fbz5B5kkVnBvPaItRxOfLdOwCymfzU87HxUbMFCN364Izd?=
 =?us-ascii?Q?u6ysowFjy7NTUQ9e/fOAG4XbqS40GWWFgjYacFAFNbzcF3p83h7LQZ4LMsFd?=
 =?us-ascii?Q?iRMZbV9pJNJuUGNjVLyNjRa1bbpwV5WlIpDRtMmuMWps88KmMTfQhrIlJZhs?=
 =?us-ascii?Q?517NJ/slLfaUILROqpjY0djrilRdi3dTMtOrVX3VEqojeAqEq5Jq58MCsvSp?=
 =?us-ascii?Q?R/AVUxWkdhCoxIa+ac7pGh1VRURolw52p8tYBK3PQ4KMi17/cErUq61BiuK1?=
 =?us-ascii?Q?yQAq/47vd0Mx+LJ1qo0n/dkZ34baxfK6efSqJQoXS2JPIdgiciXqOf4tO+fB?=
 =?us-ascii?Q?CAnq4bpl8Em+2jVzlBpXjt8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274f3359-2ded-481c-ab68-08d9dae21ff5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:58.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onBhUn08DcrWGpHrO1qB2aLcpyoXjvuu41+avzRgatsUyihqfmKYEuukHnMFsHZAq3zEJ8kRCg2Hauf+xGKWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GUCTL.REFCLKPER can only account for clock frequencies with integer
periods. To address this, program REFCLK_FLADJ with the relative error
caused by period truncation. The formula given in the register reference
has been rearranged to allow calculation based on rate (instead of
period), and to allow for fixed-point arithmetic.

Additionally, calculate a value for 240MHZDECR. This configures a
simulated 240Mhz clock using a counter with one fractional bit (PLS1).

This register is programmed only for versions >= 2.50a, since this is
the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
adjustment quirk").

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Also program GFLADJ.240MHZDECR
- Don't program GFLADJ if the version is < 2.50a

 drivers/usb/dwc3/core.c | 37 +++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5214daceda86..883e119377f0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
 	u32 reg;
-	unsigned long rate, period;
+	unsigned long decr, fladj, rate, period;
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
@@ -357,6 +357,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 		period = NSEC_PER_SEC / rate;
 	} else if (dwc->ref_clk_per) {
 		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
 	} else {
 		return;
 	}
@@ -365,9 +366,41 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
 	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic.
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 0.08%.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
+	/*
+	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
+	 */
+	decr = 480000000 / rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
+	    &  ~DWC3_GFLADJ_240MHZDECR
+	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
-
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 45cfa7d9f27a..eb9c1efced05 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -388,6 +388,9 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
+#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
-- 
2.25.1

