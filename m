Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB454AECA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiBIIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:36:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiBIIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:35:56 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D128C050CE9;
        Wed,  9 Feb 2022 00:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCbHhzhksR1QPrLerf5fySiuJL0SX5EgrC4pMmlLwdqdnps1cEFSw8kRJqc+7GtRyh2+aCXB1UgusnnzcOLe8cnyhhYhtiI5HYq/XtSE6r0eD4Uxf2rvIJ+keJux9ubLGSSwUXa+jCNPKDr3H+TZwt7lXLgDAmZJptg0JW+/2CE2Z3Fx6ckoFTQTv0UIohhepNc2ugsNfjkNxSOP0KQ/l1gv0znhgd1QSUQpzmQksBJfDLgD7v8SA/lTTRq5880ux+G+vSiDFzlUmKLOVY8UITyskTa5H5MYaIKZiV5yhczIKpwOQo0mmkTo8+B4HpyU1Wv3U5h2HJI8GqSkH4LEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRLq3l/UChRj6Ip2BglHeTgR3z032PQ8qSEdN2ZxP/A=;
 b=T1EUAe+tTBjefzLi8inIPs2UGSNt11AqoVmIsab5eHXW+L0hZCh54XbebXqVmMFPaI5a1hJ00dUiVHwYkFFYv5noKF6PS9t/fq44uLFEYwQZbkTTAzXPmD+8kGitwEBX84fbSIC7ApT3CYSm4m1TkS3Jx7vtW8MVQyp6enJh97s8Y+ddvGXiXgHkIC9MFowDNrSo7w7QPEDGwlKbB+8CrvFfUzxq/Ee+p8IRXV3h86WuN8dhnKCYDu+TClv871SjLqwR7reTmV8f6qeELHVt0jQ6ckCABhU8nVWIDc4b04AMPsM4aYxOXItA/c67OBKszVIr2FKVmmV1lmq5mNhyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRLq3l/UChRj6Ip2BglHeTgR3z032PQ8qSEdN2ZxP/A=;
 b=atR7Xf7DaDFYH9tMSq0qpJpgnMgdI6fy/3pOnYr5sj72IyqEHmZGR2FroJO1Sa+0L+PdWKlMQhPf7/jXaD6qlORgjIHqj+fVvjULC3OKapAZ8SQsURV5aAvnnP6CmZaBGyGvUg2g8h+Wt5Zy704FArjzhgH1tghZZrAv7IW/HmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:35:47 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:35:47 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] clk: xgene: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:35:39 -0800
Message-Id: <1644395739-3640-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e6f099-48e7-4969-1e31-08d9eba72b89
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB355968EB2E6178F0E4791E42BD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRwntCHh46rnGphAG4yQ6WVzDJ/nPapGOsRQcV9/ZIGq2Ug12GR5E3i+xtQ+JSOO/ItjP+nKWWq1RzgtVdBB5iihC+6saJKpgqlUVYek9TjmEftlkPed639l38GxXFbA567mYrJNTTljMKUGGLoii+aCJOn9bhFQ5wyVBwF2/WGZjIggB49lbruUf1+Ida3TK53VhnW9GwuMU6OCGTfnylwMFO+FF6dbkX2auwIXHHRFykbUYQkZF8fy9O/LfrSZjXF9/xy6xktlMantCjTE9OJLSHpCzQmub+VasoNjyW9QXMUJx9wbDZaRN+2qRkXKe8K0QKqgLEL7yR3K0uDRrfyedJxwQqoe7slgMhHynPud5Yghmu2lTa41w1j89+wdBZsEqOJSmfLJYH3+KUpnt4sgZF2b2vTCk3jc2rEuxmmWdIhAMscnXef4HrNgAOenfIOolLVM1su3WSKyEnTLwSnOKl93Q9y+pUZYSf7FvsAjNNFdZJNDmcwy4exeifmeI3kslU1QmENIoTcm/dWoyw/LNLlA5UOlvqChispUijBfJbI5rOwzZjMBIbDK6FriW5caNSCjUTQTZqDU7VaxkR7CDQRYhf20cv2RY5D89f6XTxyYY69bSDYSCm1MNuQ5CDUWDEqtMhwodGTw7+xrkvELu02Lq4RQyWw7H/Y0CQW1wcgVH4/qUKfmcmmsh7jKxUDRvZoyeVMtXWrNcfvGFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xk98eVnQ01qdmS2/hX52qY1FoSzMbspYLIYFFl+PhzLv+UpvCdPS8neuHXhx?=
 =?us-ascii?Q?QyeKwKijtD2cqLXXKj3ZBdOog0bbI6B8bfdFmdXgatiFW3ebIsGQHfVLneqA?=
 =?us-ascii?Q?GeVeYz8rphWljoaq7u+xwJ/TDxv4d1t8CBOuuSGOnmWFI6dtR2q6JCovKu3h?=
 =?us-ascii?Q?sufIx+O8a3nWJ2cKjwq6RaJPUu7+uCHJBrP/cyCl7pQY3EXdXyXZsJeTqGbM?=
 =?us-ascii?Q?PWlOnNxUpYq26j9N88jqxL2LPQpBXG01hzC+fTpa9TgUSFA8msfKmlskSWXQ?=
 =?us-ascii?Q?3ucuH6+9nz9E1dU8E1gAanF9LlzBoCoG65jMo/qMOKExnVvQE2GuU0Q0I4sX?=
 =?us-ascii?Q?Vj1faAtcSgUCIAYF79mWLZSPMawXzApOlu0qjLqmBTzU7KvcxI4/n/C9owqZ?=
 =?us-ascii?Q?eIFTgeMiNJqQQxrnp/T9a3kSDEEFWa3rFVsURoNE2jOeyZNlTcReCYP2GBMe?=
 =?us-ascii?Q?/n1ngkm43VV833n0bdQ6MXslvf1EBKv6fS5FYeRj7pYJVpvlkCr+Iagcw2s1?=
 =?us-ascii?Q?PamJdGnATWplTlET1DrI560s3pwdhPQebKDMU8fjrLd2CF4bCJtCMVE74/Oh?=
 =?us-ascii?Q?CFv/3Q8rAc3f8rTQ9Sy5NkxUXQs11m4f0ivCJqMR/ba6lRnJ7oOGz7VOly4J?=
 =?us-ascii?Q?FH7jn+enW9kTBQ32H8UeRykal6Wp+HIr2lGell7ChmUEsDXpi4WRpj8moOjb?=
 =?us-ascii?Q?qa+EzpLpAGbCrtyrMbs3xUhW/DkJukZZtUQvM5/vw9w6E5l8t8rzSatwg7LR?=
 =?us-ascii?Q?cHSAlAFMN6oIE3s6PHf91FBeFPUJa6NFP85kBGYxrASDvo9Jo8bCl/EDTbrQ?=
 =?us-ascii?Q?UwhxkLE+EnzG9ILGK36rXKD+uVUUVVvd56cVqFhOi56SOp+dF5gUQExJSxOM?=
 =?us-ascii?Q?a33oK/qK2/leaI9183CWSdXO1SX6Sdebq62pNhziIH1tP3msodHy8umxxdmF?=
 =?us-ascii?Q?WKmISM/vftJyK79HTe365Vn66NQYp18TJ2bLThSQlCGXRd9SFEiyl4c4yMIC?=
 =?us-ascii?Q?CXOuTGCf0r+6WF4nlC3FxNuCVQ0ewxXa6Tlvdp1GC5De2As1OBPgtkKtb4lm?=
 =?us-ascii?Q?ynwP9eyYyUqISs88sB7/rWct8VL7JbA+QdXAlRcWQKwAmdrJvwCPKH3t0Vm/?=
 =?us-ascii?Q?h+mx1mjMFN00XNAhe/XQFONqwOek2xyf/7a+gzHcEkCAvUQxVifnncnzSF7T?=
 =?us-ascii?Q?Xp2dilZMoypJcNJZcOSlbWTKUtMEgC2HgyP5FmYZ92F8kimPh8ShOCqFjAdw?=
 =?us-ascii?Q?QxoThYhuL0IamNcpdJqopZcNEr5RHLx3rMR6HbmUaivnjAalc9jMS/7AJElv?=
 =?us-ascii?Q?k5cQakZSGRQWbj7BzxJrJX7J5iG2BmGHk4aNSsoiMKunPLIRt0YQU8YDTTM4?=
 =?us-ascii?Q?LVOYcsUgZa8zw3DmqwO/W8gMufdzctTGOSfuNeou5NqJ5/ty799ztZYeb/Se?=
 =?us-ascii?Q?8xJErR4iJAfTelgjrSxRBQED7/H3bWQbJxOjZ3bWkbWS50ccYLfigfFDatrC?=
 =?us-ascii?Q?POrBcnSjCD+9SFs28EYGUqTfxEiDG6wfyLEx3EbTCZipiPqy17fTp7nevQ3V?=
 =?us-ascii?Q?Z0j+MBZaWuEQczUEjSGZlu/PZBJtdLt+vMaxYKrAulQO+Uj8cyB2Ym7Rx56Z?=
 =?us-ascii?Q?+SuAHTRTF5ldf/A/rjAqqII=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e6f099-48e7-4969-1e31-08d9eba72b89
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:35:47.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01/cnPfPwLrDPuEFbe1rIMVjeb5XyB8Ppj7NzDBFImlZau9QtCoU+jiSHmnAGFKSkbbNZTcTgbChtuDRvjPZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/clk/clk-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 857217c..6c40821
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -262,7 +262,7 @@ static unsigned long xgene_clk_pmd_recalc_rate(struct clk_hw *hw,
 		scale++;
 
 	/* freq = parent_rate * scaler / denom */
-	do_div(ret, fd->denom);
+	div64_u64(ret, fd->denom);
 	ret *= scale;
 	if (ret == 0)
 		ret = (u64)parent_rate;
@@ -284,7 +284,7 @@ static long xgene_clk_pmd_round_rate(struct clk_hw *hw, unsigned long rate,
 	scale = DIV_ROUND_UP_ULL(ret, *parent_rate);
 
 	ret = (u64)*parent_rate * scale;
-	do_div(ret, fd->denom);
+	div64_u64(ret, fd->denom);
 
 	return ret;
 }
-- 
2.7.4

