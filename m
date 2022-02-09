Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A904AECB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiBIIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:39:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiBIIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:39:26 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20718.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::718])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A39C03BFE5;
        Wed,  9 Feb 2022 00:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+V7vyt1YyfLST49InkHnIlX1MKmIJWgLv4GJ1myoW98b7xEzbOzpoQ1EkAdnXWcp0SyYa2mKsJ79tj0/Ve7RcKO2B2gi1mIK/gzDMB2p4vyeLQttkhQwSEqlgKPEdUdzE02o6I48JI9tCHKbdw5ZDAzBY5T3QlKgDfDr3gdeb9ZCx9h4l2aNATguvsqCQOIax/OWpBxOyV6xXV1ymnQ2p6fTXxQ3SHBWh0r6hLuu7LsuGAdrO16OiAsy7zPKcBO70iIFAUsCaukO4CXp5M4k2EMbVYOVfHGqf20zZSE6pFq8V4xduc/82YQAtOpjtE5KeB3bVzOro02/8+NYguCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcofcH7oWcl9gYQuZKn7nBKawRC06+c5Al1uGbhWqHc=;
 b=KXDDd8uPtl13Lk70jPOXV0mtfkDrKLgbDvY+IkSQOq/W3eUrhUdcfbY/Eh/y4hQTZZ2oEk1Re0m4tLuySj5Q+Oz9nHE0ChNJjfS3GhdXe/h+bj9Rvh+LGovtuPQSH2xOb6AhXR+rNcQpJ3rXL6WF+lSygI0D7BgXvRmxd/aaSvTH4MrGvhAkp9m8Q3PS4cyguwaunM3YALY3rV+gDitcgTjl1PnQSeK37o95XvK+Kk/+NllTG21PHdj5nTmZIQWtCl2IprErAkHjUtlF3k58lTVD+6u495YGJrS5z8VF/GWVYCWzqYvI6vo+aOXgh0Ll7IokUPPFgglIt+mTP+mlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcofcH7oWcl9gYQuZKn7nBKawRC06+c5Al1uGbhWqHc=;
 b=H/HmmzFFG2/z0Z/t8SDHiow3Hn67pqE8/I+V1YAV8DBegF94yguD0Hi+22UES6L+AUiuEMsPj3ZduxZAgdaYNMk9kSBy6/h5ay27vCcVDHEfNHVCERB7bA79SbMofP6gYAg3Cqi4Szi4YPabDW4XsoWCSxbWBwzsMXRaqkJT2cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:38:26 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:38:26 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: dvb-frontends: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:38:16 -0800
Message-Id: <1644395896-4036-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c0df24a-1643-4ce0-eebb-08d9eba78a07
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB35594531FC3B1AA9EC60422EBD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdGSQQ2ije4BDtt9jyU3+ajz7FXzWKownGXw3+BryXPwu8Ll3iL5URh1mytOdUGg/J07pqx1FJJGXPcbjRtqFrMXlVJHWMHy8oOCjlXqcGgj1/+Vx0DfS1/3vwQBCwcw9dO6dXOi3mGsH87HvQfnBczuN6VYQnkXJTOM6U8gxAY6pOdOT1aN77JADdiBnK/k68OdnhyuifPhA/GXWwHA/Jq/We/6kxiGFDSegu4SSfZuF27tCtwNINwsKcuc2dAXvX3hStVVtsH6yF6kUimkKuI35BZXTDxkubBPin2xyo6BFLA5MVI1FLOsJBN/2LEAsGRrKGecgsqoGa3cErGpiVsDdS2GAjo/1+7o0o9cHNHdr9f4SJOaQncA7O9IwJY8mNt7VeKNuXeJocbjM33SBweUA/SIKrib+boGFaDRFnNa6PaEgQvRU9teAFypOHkLumj2YxrUnRTfHhkJVGJOMffB25AB2sDPwvIzDTdRMzfzbrh1WcKXNUNYDVbWtyEc4VGKfAk8PKwWRWd4Nhskyd6QZI3lpJMJkGfHF/+bYOSp7Ss102mnSYoVokEdBJUscYzFPZdJvlcHy0timCfj3WuHE1cCjhF8gQ0bR4uNMP7PYcbp2tmKz191t74X9cONuaGg0vDzEFNUMuHc/IgZ8xhwPYg54vVMHc+mkzKWOHXTEQ2HDEK7olG7KjmD8+sRoylWXo8IoxZpUkc38yu1Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(8936002)(52116002)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/zy6WlRIzoAl9PvZA2o5+dZPC9On/eOR83pkPqBhhkM8EwqV/8YTXkVptq/?=
 =?us-ascii?Q?CH6qQxraj2YZz3m/N2ECqPOJ+Q77mRikY0yh//Gg9qKxdzTUGrht2dZNxl6d?=
 =?us-ascii?Q?xou11ueR7lexMgX1hHyRn5o3hMsX6iO6ECLuy37mbYqJKtVGNoNjY0AYzR54?=
 =?us-ascii?Q?cxUS/ZMz0enmJlGv1vgl51Ryf9bQPYLoTS/+FzBu6ilD5W3cfOpbmzcAVEvi?=
 =?us-ascii?Q?5C2dcZ2+PZmVGCMjilmNEE7E4Rftn8wX3DBLBxEUJ6gGiXah98NK/3/+krJw?=
 =?us-ascii?Q?GK1/R2/p1I+yHOsVBwIDGT6XUitIULJx0TpOlJd81k9IIZsMmJTbL39QV7yZ?=
 =?us-ascii?Q?xE93nEnmFtfSHEzzYaqKFLL+FFEXj363TQ1gEFbAN4NxB3jLUNlnOxl5wOKQ?=
 =?us-ascii?Q?b5A+fvvXemLR8RUabSStPlJMKxuQg7BQsqDXhFQvW8GecPJDNay3hnO2MevN?=
 =?us-ascii?Q?sE/aiQFw0qpDwsEXmjESkBGIAUSHFgNQS70QCM+qF65EHYd4sYw3qy2PLH27?=
 =?us-ascii?Q?zgRwzazrRMGIxriTMPeUVmn7yD8u/z/bg3y3xzyDVv0ZGGDDQiA3ce/Nx2j2?=
 =?us-ascii?Q?F2aK3SYN5k9wvo2pS9XkLJwBsXetC0o3IQL37DAjHmFakhd6bGKgwtgFP9K6?=
 =?us-ascii?Q?C2eq+WEjYaRLO68yW3DbHSy0tePC9oFCPmweuJOCTV8Ai2SCeJsy9NzBtmnt?=
 =?us-ascii?Q?kfSFGC0zdfQJL5HH97TS7nrCVAna9LXt5LiEi8iV1LEfaLvB5VBeVyqe7Apo?=
 =?us-ascii?Q?IaFRXNmCyzjDmW365J0hMvgC0+BwyYXmx6DAnEctVfG3uTvH/j9OTzxzmZHJ?=
 =?us-ascii?Q?OWbD7PI0nMedHWxHIUUZcNLCqU+MAOqCdy2vjdSL5ZG1WKrEhXXEhqttG6M4?=
 =?us-ascii?Q?xarN61o1vGG2Y54YyHp1tqvNdfrpKMxQZ3PUm9zI9Jx/zkccC/5ah4mhCucx?=
 =?us-ascii?Q?u0SGtJO7hGdfp89icdWELhZ/KZ3c08V3aoJT2geLCID8GK3vG8ynnE424f+k?=
 =?us-ascii?Q?bQGmW7ZN8Ff6lYtFE6TKRJeTkVrQsJGyFyTXOliydhlb9gqVwPnm/fvahW3B?=
 =?us-ascii?Q?7Qb+vRL9ZkEsMKgOfLHpr8ReQcik1/GZTHzSAAwqiURRKd1lftBkp7mkvqVv?=
 =?us-ascii?Q?KLeQgRf8LCqFfy3yX+0MpFBUMM8oDuZXCc3VRqoURmaRr59P23Banm/zZTf5?=
 =?us-ascii?Q?x5Ot83EYK5YhvXON1jkKdobPNjJsW7mSAbzmhw3UH1gasq06icgNNaODy5Dq?=
 =?us-ascii?Q?BomQUrL1Mrz+xg3ZlPECuXEcRb0J4Bu88ABo7W7K06XfpwcFP+/3LZUhh2mx?=
 =?us-ascii?Q?Nv4lEpnHOlSNAozkwqxHvurtzipDNp37oOOAFdHf7/MHbMySXKN7NHfIGSwc?=
 =?us-ascii?Q?NKc6/AxOFG1M5jt5AnSo4cACUZLpvhukg9rDBMnRPOCPgath7xaft42U0nE8?=
 =?us-ascii?Q?PJsM+7ovbuNYjqJqoBDD1P8H+xFXDL40C9hodq4QJbvdePABMxuPmmbSLcQ0?=
 =?us-ascii?Q?UUgv23iaB7h1mSGuHCilSAqzcy4x3P+AED4r39TpKdAv1lt8VpbmvP5Q/DqM?=
 =?us-ascii?Q?PFGhRq+QOG6RtOReTe4u8WWokKHW+gRsjliSnagafhroQNndO2a6XDuCgDwi?=
 =?us-ascii?Q?cT62WDY+/JHtN+4DUetyD2Q=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0df24a-1643-4ce0-eebb-08d9eba78a07
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:38:26.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awQKXEhdgbb+DZKJfWXnyPeNSaR4QHVrFgHUh2gCd22xuQjofCkOH2pPooBpsVyit7bMH4uVCJQRfKVsW4BGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/media/dvb-frontends/tda10048.c     | 2 +-
 drivers/media/dvb-frontends/tda18271c2dd.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index d1d206e..1ce2e67
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -344,7 +344,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
 	z = 7 * sample_freq_hz;
 	do_div(t, z);
 	t += 5;
-	do_div(t, 10);
+	div64_u64(t, 10);
 
 	tda10048_writereg(state, TDA10048_TIME_WREF_LSB, (u8)t);
 	tda10048_writereg(state, TDA10048_TIME_WREF_MID1, (u8)(t >> 8));
diff --git a/drivers/media/dvb-frontends/tda18271c2dd.c b/drivers/media/dvb-frontends/tda18271c2dd.c
index a3483448..fd92878
--- a/drivers/media/dvb-frontends/tda18271c2dd.c
+++ b/drivers/media/dvb-frontends/tda18271c2dd.c
@@ -328,7 +328,7 @@ static int CalcMainPLL(struct tda_state *state, u32 freq)
 
 	OscFreq = (u64) freq * (u64) Div;
 	OscFreq *= (u64) 16384;
-	do_div(OscFreq, (u64)16000000);
+	do_div(OscFreq, 16000000);
 	MainDiv = OscFreq;
 
 	state->m_Regs[MPD] = PostDiv & 0x77;
@@ -352,7 +352,7 @@ static int CalcCalPLL(struct tda_state *state, u32 freq)
 	OscFreq = (u64)freq * (u64)Div;
 	/* CalDiv = u32( OscFreq * 16384 / 16000000 ); */
 	OscFreq *= (u64)16384;
-	do_div(OscFreq, (u64)16000000);
+	do_div(OscFreq, 16000000);
 	CalDiv = OscFreq;
 
 	state->m_Regs[CPD] = PostDiv;
-- 
2.7.4

