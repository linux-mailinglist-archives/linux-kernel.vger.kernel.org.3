Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62BC4AEC9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbiBIIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:36:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiBIIgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:36:09 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7EC050CE9;
        Wed,  9 Feb 2022 00:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTPXSNTPOOprjywmzNEPAFBesL08QTfx+XrPLiF6Ii7dvUWjVKUUB0Zj9CRVbShDSoskeaHzN5yTur94DJk+N1FP6H+T8oIbnoCRIeZCFZaG1C4x3hm8wtSzAVVkR5J8/68wAAmwfZZ/Eev3IxR1YhW8P75l//rRRJHglgJ+a6iNqnBbt2vPdBkAzMxRbJIzPvp63aAOZVLTY18KQZSwArViMGvVXaj2Nas1UVuMyH8Q1wS9krbLPDj79VeIbk/LC5frtRBqB6DsOaegkZkeC4LV72msTarpAK1jkW5E4i5fvuWoTZpzfM/SMwbMgudaE+TOGTs3J46XFoWsgdmYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw8ZJQ4GJyqnTZc7G6OhScAdbSG6Cw9/tq2pyru63Pw=;
 b=Jqc8Q3cox3bEAjJSMju2jiOZChYHsXmak7Ya+qbw2VIpt/0l/k6bNiol4yOuZ8VqzJxJIw5iDMn2D3CgomBVMIg+HPDiLusxMP0yyebIX9FaSasjr+T9cLo9OOxiYErsgpgIC9BcUQ8Q5njPyxP/mVvDi2QZmytMJ0ElVKRzEkzZEkwNmJhwmOMfBL2GKMqoBAaS5fdvDasvUWYmFFUMeNd8iq4dVJRhH5SjUMiN62/RzP+Fh/Loxmng4EPbFZcyxrhmmzi0zj7xO/Qm40QmVv1iDxF1rdOWutikL32DHq/3YmyUNV9i4TSDcC/j2Hpy+uFWT6PrAemZ/Uqr9ZSgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw8ZJQ4GJyqnTZc7G6OhScAdbSG6Cw9/tq2pyru63Pw=;
 b=DSURjKHpqfQQ0rjTNSqfK78G7pwqQTfbVhMwlZGOjPHTyvneCQOB+5Fh5GERnh0yzSe4HiaAC5jcVCwsBA3a3EyiUvdrSLJZoEegjbte76ihy+XNwrSmB2z8UQXzrbLBDh6wYs7YXSmOiCI/OHE5POQjk4ohw2vdZ5wC8E+eJF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:36:01 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:36:01 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] clk: hisilicon: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:35:53 -0800
Message-Id: <1644395754-3698-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a63025-872b-40ff-707b-08d9eba733fb
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB35597B7D3F585A0BE7823526BD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhGuFsE+WJMRInnvpamGlEYS5EKYeKLzvuTkwxODyJCo9f3gBw3nVdum9m8/7ariXXwWyZ4QK+nxgnB497b7OWStzzIvwG3YtKSJdHyR9sPclSLNUh6arBnajpkoZ9X7VYSt/Y8rClb58oqQo88MEhfO9QLRIF8vgAKbfZNeyUg+Xz9qDVQCXGvvTgEr1bp1ovkKdqMVlHdoALzaqCUCET5SxxcQJU8jfZu0H2x45W+8UO68bcV48JYRbIPMnnnbijwtcXWGd94emCdURmWqfGqIf6gCbQt758UpkLEU7itJx3kCEXya2C9JFLKG91eXi22wxoynzRzJBpvX50Fj6MnafWLxJvn3Mi8q4jw7krT2vgUWHh3sPfOzcXWodU5oU4Gk1TuHeUkTfhOLiZ+xkKv1LgkSeOyHZHlDtz1g91Wb9HqFvVCBxMonUXb4pDmqO2szKCluhdr/+LLITjNvYr/76uzIuoek9NKHe4WGiO9Y15EYNI0s0hj93AfwlD0aqDei6gcASCfNntinggkYBJGglBZlrzemJvWNUuEfSJXLlEt9Lk0E2dqApjg1mglRS+A3Y8wPEEc6t990tnScYSFHLuCdmzyCsqdXSQhV/ZvKlOM3KEPWaYi4bFggb5cD/sjCdOcYN4iSSK6ESO9QETNIUI142zx7x56wJgzCnvu8Vv1C+TL+G9ceG0i7vqn4RecpyKDOspfrTwLhj0CwDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(4744005)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/bj5K3yPz5V9WgexXzPWisrgWluHg2rXAq+gQtchLQiS0vOEs7U73vrr4SH?=
 =?us-ascii?Q?LeQFXunvEtvRaMNBAhyyECfv+popkFzecB1rqskiAUQNurxLSdrQ9s8hi5i1?=
 =?us-ascii?Q?OBr6UQvXhT7ZzDAx4LDNRP7GY3vBh1uUs2wJTDrIlSR9lQyJZvUTyWeoHy5J?=
 =?us-ascii?Q?lnYVfj5laqwFsdt0d0wt2YTqsEJMcPcfqUt3OO23SXyKW2UmBlvuP8JB7iMX?=
 =?us-ascii?Q?cmIFFE6Xp16t/v7zWMyMKMj5dZ+ESK9vDTtJk3r9pp9omhKrAiyZK6hx65RQ?=
 =?us-ascii?Q?SJ5V1WyD5agXWcpnbflTzqXNmbrXT7zdAgetzGggzDH8QgQm2dMlg/Oe3DJX?=
 =?us-ascii?Q?WeZ3pgTUw2WYBXD8DAxeiGRMCC3JDsGF42NYbOXVgELRNiZ14eEZYXGQhsoL?=
 =?us-ascii?Q?PYifuI8f3gkHiHnuDHjkegD6NEJgVp0MCSw+ZQUVZaYWVBSztzqNCeh2ZbQH?=
 =?us-ascii?Q?DS8eZBmK4/foViD37tKEUSGuXq3zm3jLHmgNmeWuHXErdSKnnGsG/LP6u/6P?=
 =?us-ascii?Q?DgJd3+GAU2Q2YDrYQ1Z+F2pDmzvXiOi6uGad+1zh95SQSKlWDZNXY0R6aqWN?=
 =?us-ascii?Q?Aquzh7wCfv6Imxy3f4Nlgp/x6FxDDC6aSqPY2Zy6UEi9X257zSvv7svoSqkZ?=
 =?us-ascii?Q?PfYXaNtpfaGzdpSuq7JD3Jg9kome5nF9vD9G8N7HrSOt72GjB8YQPLcPcHxq?=
 =?us-ascii?Q?ZnsCKjPNk4KqpISh0S+n2YppfU6vifi6R9zDrDpgDMH5ndK2ePhynT+YcK5i?=
 =?us-ascii?Q?IJPidPa1LQ96g7waTr4l1gCpAXFCkQnZ5cyHBY/c6vbp+nH4ylxRwPTj2hR9?=
 =?us-ascii?Q?KfHF+MRsNuDrsgqKTeDBcg87UQGbbAoruPMPgJc1HTVwbndODZCu8lZbkkPz?=
 =?us-ascii?Q?xG/cs8ZK67oakDuI0oNihI8kuxvFMK3HYx12Yo0Y5yvUQpcBzdcYInKcOX6F?=
 =?us-ascii?Q?J5BFu64vzvInY9dCrpQCq6Xhu2qZGyCQIQKs+DrNx7NWXXO2Q7onf2515nJP?=
 =?us-ascii?Q?wGbNNndF3v0nkEoO/FpVOXJPP6eSqoovZG3jkbzMtHmhP86s+5XyZSqhfbGu?=
 =?us-ascii?Q?eGKQbvKPMGw8IeVolt8w6BskbJ7DgN+DQgnr7JSTg4ooacLMC3RhcI+ok44s?=
 =?us-ascii?Q?92asomWsHT9L4bJqOx32OV7VZDtpKRqldAV57uTeAOw2cDa/KjBhpuveWCqC?=
 =?us-ascii?Q?543tjbaLQG5Boypz/aV+WoHxRp7ta2v65SD/RYQkoBpFBC6OrvbHWRMZPapF?=
 =?us-ascii?Q?DJ8joUEFMkU1d+JweZUpOHbPcPYX42HoW/+Tdj8d2hT/InzYjUuYzlPMJG4j?=
 =?us-ascii?Q?CQO/s84x4ol2JkI4C3LLGd0Z04bqJUJgGST5m/M2AIj2F5fo4FIks0e8JJkJ?=
 =?us-ascii?Q?7riM/ClcIgM/uPcRRvc9JFOUYPE71DICGWGr154rxayCvAZKs7ClfWLbJcRQ?=
 =?us-ascii?Q?RsPGT46BX3CKhzmHAdyOpP82L/VF6kC1zX9w49vI1hUfLA7t1rf6hMu1dAIx?=
 =?us-ascii?Q?u8IhEYl6KcRBUlV7UPF0g6D3XC8lbw1zkRcphzKwu0TZoTt3nisVCCYkGIdA?=
 =?us-ascii?Q?l/nKJ/N3V7RjFrJThQkm1U/nSIn7Ke6UD45Mnixp6tpoEhXelrhmn3GT0Ken?=
 =?us-ascii?Q?5Pv2UO85A4PJ6rqTx5n4xbA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a63025-872b-40ff-707b-08d9eba733fb
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:36:01.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBEPVjYJPr/lo1gTWZ3S+AfYztQKvzwttLlR0cpMCW3RdbQFTWbAwYkuffbrW/7AtWXDco5H+PNJTFn6YANecg==
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
 drivers/clk/hisilicon/clk-hi3559a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 56012a3d..8e90598
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -441,8 +441,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 	rate = 0;
 	tmp = 24000000 * fbdiv_val + (24000000 * frac_val) / (1 << 24);
 	rate += tmp;
-	do_div(rate, refdiv_val);
-	do_div(rate, postdiv1_val * postdiv2_val);
+	div64_u64(rate, refdiv_val);
+	div64_u64(rate, postdiv1_val * postdiv2_val);
 
 	return rate;
 }
-- 
2.7.4

