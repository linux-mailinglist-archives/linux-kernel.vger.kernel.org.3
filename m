Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264FE50DF14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiDYLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiDYLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:45:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF0B3E0D2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY+TN2Rk8DWWQJbeIRY1EO6OJ2pzpyut98KaKjX/A4zcinpRYt0OffBUG3ObkduR+YhNxFC7fFcfkNe89EFVwg2YKJ/LUQj4B9H7V4NQ331aovXtD2Upw0EBp1o2eQ8QSOibYnkk69hcX3mL2Zi0dmr0fXzPpSX1kajcxZ4FdD1QZ1WOw+w53Qj8G4GWzgBQuHyuirc+yywRVYX9D46b2qylcrCCCr+EhhLHo2vRpDC8H34I4xe+G0mWHkcrAwJ1CZU4cfUZN79UXjzr+YJYGAlS8QS+yAW/YA/dirirAgvJbIHZW2rZ+muPHYxkBuLa25YTCb/IMHub2ywtehEKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSN6mxqB1zBxd0efPQJA+4fzJTWbv+4V3CgTRrnek0k=;
 b=ntPD4BgK8sBLj042LMgAaOZN+Z0fdm/xqus2hVfGSzCd0Lb/kyLAuhlLQ0ur2EHtycobMYcA1aKmB3dAsoBwF8630vANfmvxc/7/lfsotWHRJX32Q7BcMTjs2h4aF9oAY5stCrmSclO/n7c41YRgzilIsycgMVKqeGZ5VbV2tO4tcsO9+UxZKg+cGOnVzYX3XJh30J/aEA6FlTwS3ih8yApmj5eJFdaqux85gqRODWLO/v0uGoDBLnGsdSAsic+G3zcHW75tWpe9N385+BXHTi+bzrWnEMubmub6G59oJjtOF0zWxuommK2uhN1IUule+LNWNtuXi/da9oNII9kGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSN6mxqB1zBxd0efPQJA+4fzJTWbv+4V3CgTRrnek0k=;
 b=iVE2zUV10ou7Uxto+ZjGsz0kVgam46D0xyc8V3D9Hl+uanSDFKKFsvc+nWLKUSjy24GlkfpcrLiMD45r8049hoalHoQaJjCX4h+sLVxoxVIocNzWA+sM5rIRbgjxXNUt5cQrRv7D37mIX47vLeWG9Rn6ggAUmACPoe1hrw2JPd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3129.apcprd06.prod.outlook.com (2603:1096:100:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:42:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:42:51 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: Introduce util_est boost
Date:   Mon, 25 Apr 2022 04:42:30 -0700
Message-Id: <1650886952-94620-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0239.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::35) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13ea3b4-1432-4d41-f4df-08da26b0baca
X-MS-TrafficTypeDiagnostic: SL2PR06MB3129:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB312921046132186A0661FF7EBDF89@SL2PR06MB3129.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ9MOeXdoz5NCsOqZ63T9viaXb/CBlHgfs2GpsDtNme3wX57mq+lueGdaQD7IhH2Qmf2D9zORGaobfqTtw+0hOJJL+kgLX9OlgWEQgUwEw0my/cWWTU8zePHi/Fp71IqM6us8MbsDAJuLX3hdlOkFFZDhxx9RCHo934wezmJQsQCIjB8H+zPW5GiK9R7ppCquWRuGCH8+SP98yN70rOWvcXWV1mAplzaHdPPuYKqe76k1pvJYK6+CxN33eqKYmdkvfe+PZShBOSU3auP+jQeMyvqh6fhkioIutU/8Obux5yiPuPssvbW2cBAmW8ZD+xTwzKTZi7IDnr4pmf7F7gojF5mhpQzBPk1DqIDvS8hEdgjW13KNpwz6s/tvCD01u7AiZdk9kOzrd3+wiFoh0kgX1yXpbWBTZh2b9Qtz4PcXtZnnY+f/rV0cHEkog6HIydmZsBbNsatLcDcTBarnAIoqt9aCr7o1au1HvF6dTQEHLCDZypXfT1IGFAVyMVBt13usK9B854oy+SM2WrDTHZMNWLwsF+krEiuU87z/13GAcyFCin0g31YkBYy8UcyfNUrBYpGsi4KKjZsPKagWGrRL+2v0Y56l68LSwMrn9O8T/Ru0tbbXoKIgQyJ4kcmTanDvGCzKI1J+TWrQNjL6dfmBcZp377c58GSOgPfK7m3RqTmILzF4o1uZLY/z58h2Clu1CDDX6DR2xrXIIJ5O3/oTAHwKWHU3CyR8F2wk/Sm9xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7416002)(38350700002)(508600001)(316002)(2616005)(36756003)(5660300002)(38100700002)(83380400001)(107886003)(110136005)(66476007)(8676002)(66556008)(186003)(4326008)(26005)(86362001)(66946007)(6486002)(6666004)(2906002)(921005)(6506007)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kz1Indf5OVTRYZPLZnGQZnqYzFVdc4gI8CQqQ5iovg/BilA8xFpleazA0lxZ?=
 =?us-ascii?Q?5WDj5cOOjRsnlWDuTAZc0msgOeTqEEKWuX71IDlP+O/ckOCM7hnwYLXvbc1m?=
 =?us-ascii?Q?idkcyIlTLxOe4ckeL6vmsQprdadmbLg+WcVCwNJBJJp1Jl/cL3uQKqBgx8RO?=
 =?us-ascii?Q?oae31c3oyOkp3O6Cg3W7DT8rhm6RgjLMy6RfUggiccyqo9gKufeEYlfzCVkI?=
 =?us-ascii?Q?YPZKW2NNwrla8Ehg0B5JbxyAHeVcJG/0TL4Fy3k9zwCAuAicljSqeosdhVdk?=
 =?us-ascii?Q?gKp/vBcNxkSHjzp2PIyu/t9lXo5/0vHk8/ruo13gt8D0+AIsZNczzQSODnVj?=
 =?us-ascii?Q?ApNYLXbDcs8ARIH4Z4PXJL6R2Z6nRFhbaLaWuyBrSdArz1Za4d7zOivnNjlX?=
 =?us-ascii?Q?U1YHM/BTdM+UzVm1HbgIvZF9uHYeRFgdQpRtbo6dtFW1UWJ9D/pCFUVd5uc+?=
 =?us-ascii?Q?Gj1Cf/e7+EErHUd7XESgpwOSM6bho59bsLU7mW/5lIDktmm/HHuaMjaxFRIa?=
 =?us-ascii?Q?qoDZUPwRwh3L5wfBEkQV7HuJp6xMzpVbnYbdV4q1R0KEzxzK1in9QEMS2Y+O?=
 =?us-ascii?Q?wGbtOzJLfUIET5/UhDt2IR1cBKevtDK+EXhbBB1KVyRm2MmjGwIT3ddLTV+r?=
 =?us-ascii?Q?rFUH9kL1hJN4g9JJKkRee/JeazgbhkaggSFeEBwUSJHYAcDSGSjxnpeIndNB?=
 =?us-ascii?Q?0UkiNIvKNerRcx8dsv7RyUUk2zd+MxqJ+9GdAT/VE85Bdu/dL6ZCFkIzuKVk?=
 =?us-ascii?Q?cmIRiknH9gwrzgJAZp3/R+FJ69CumhViM+1vd7fzytgAHUYvr92GKBRhbCu0?=
 =?us-ascii?Q?y5lWwKfsYErUlQZAXW9GQTpfyasUyQl0oCRz7GfXi8+5MSKcCKc3ZgvJDZmB?=
 =?us-ascii?Q?rywuIsxRSKW2NUE5YGRcX04m52JZArDEpL+ualq7i8W1bQwciVvD/nDuQu7r?=
 =?us-ascii?Q?ZQNO2DCa1YSFCqNM/oxRWuYMliQ13noycdYXopz0J1C93FJaiLsqnbQlPDGu?=
 =?us-ascii?Q?dFlwNHD+3e59/V3D0OajfmrdpeMXGiKwZ8bM9EoAkOIEKJe0Q4MGhJYlRCLJ?=
 =?us-ascii?Q?9sKWCemzI6pOakddXqSYlHkkKWmSUqetrjRQ8Fp5SBoRW9c/rkAoGgcUrY6v?=
 =?us-ascii?Q?6tN9HEaIaHzaPx3fdGshRaT6StfyCKsToB2zaR44VPz6FuiHMQhNnrHMotjH?=
 =?us-ascii?Q?w9BN7Y5V0I7QoJaCByM4qQCdjioT/T+mZkXNdENN5EmGl8kyedvKeNf3atkH?=
 =?us-ascii?Q?Hip7jVN6IJegd4lSsmygq3oOR50UE1/mXC6Z7818ZmxPVKeFL6UAGaQuIti+?=
 =?us-ascii?Q?mi408u3Qexbv2L+lDO4f1LCgl5+93SVSsjIB20w8F32JqRdoZunmzohXE/tn?=
 =?us-ascii?Q?3IkkgzmQLLJI1houItvacKXaQQkf0ALNYcUxusLU6ZK52eh+zn9eaU7IvXWT?=
 =?us-ascii?Q?NV43kvykSVo7V/ZbZNz6cu+zuRXk/pBQ537onFPHx5Tg4NvPwXKrU4BiXRLW?=
 =?us-ascii?Q?dT/oc1vOQ9Uh5DeuLq3t0XO99BLjhgKV2BX3z9rLC/FfTLXTOk3PBG9975Ub?=
 =?us-ascii?Q?iiclo6rDpaijvqRAVyYZdASXlc9z6KP378ohwkWets6Gi46OhcJP4N7N0fnW?=
 =?us-ascii?Q?dt1Ck8KWg2INkSz2msscIX7FH5YRxUvT0rXVV5QtEYAmsFbI650/9yRmRQx0?=
 =?us-ascii?Q?WAVYBOp2XcEG60vIiRRpO/clALvSVwR2VkjmNXSnATvl8v/pZS3QfgL3jrbr?=
 =?us-ascii?Q?tUd1FCzr8w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ea3b4-1432-4d41-f4df-08da26b0baca
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:42:51.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: babWjwvTw0JruGa4i+bFzTHrjWMKGz1AGKVc/lRpaQfUIh4yrUTAzzofbGyCkYiC1BbszLc52hrpSpBDIobkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Util_avg is greater than util_est means there is a sudden increase in
tasks at this time, we should give it an increment to make load balancing
faster.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/fair.c     | 8 +++++++-
 kernel/sched/features.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 265bf7a75a37..2fcda7972057 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4036,7 +4036,13 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 
 static inline unsigned long task_util_est(struct task_struct *p)
 {
-	return max(task_util(p), _task_util_est(p));
+	unsigned long util_avg = task_util(p);
+	unsigned long util_est = _task_util_est(p);
+
+	if (sched_feat(UTIL_EST_BOOST) && util_est && util_avg > util_est)
+		return util_avg + (util_avg - util_est)/2;
+	else
+		return util_est?util_est:util_avg;
 }
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1cf435bbcd9c..c73a898e7e38 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -95,6 +95,7 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+SCHED_FEAT(UTIL_EST_BOOST, false)
 
 SCHED_FEAT(LATENCY_WARN, false)
 
-- 
2.27.0.windows.1

