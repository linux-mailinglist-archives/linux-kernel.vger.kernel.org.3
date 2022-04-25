Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468F50DF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiDYLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiDYLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:51:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB141302
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpZPhvpc2Axoz0+BXgwmXkel/P9Wu7zzwzENz0L2+Z+mb9uDR2TkL6XfL3bKOBaxOiHT/ckm+eY0B562aa5sRifkjE2weuJ0BhLadRYQkSHD24MZsiZV8Vd0p9i42LcvXlwm/JFY0a41+Gm7Y8646DlrpJm68oZ8ObGwR7sx9S+P3tXwmrk39pBMeTeGmMeIV6Yw9skkjifw94If6E9DRhId4l7Re1ygcEoMy1ednKIZvIPU3UgKiDRoRpl4+n8+J7bGK4fqF61dzhqfyJ7yqaxOS+68j6zaxIVL8Xax8trfXaquHKfxA56HVcTkg+HUd+rqXgcipSfHIdvEXjjMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI4yuKAM94jBhIOp+BLpCx97N5BrDLdYQTR8e7QqWp0=;
 b=EzF72tC1MqErkSSnn0sJHxbfTGovjxuHOkfdIGNk/GHfkyP/BMhz1GcjuWoDhyI4kJ0JMv1zYoAxDxOsBtRUeJ0czjUscRVQYI4VQZvyvszvchNi17NVBMXUbIUnU2q0b2CJriKsUjn7Bc/kRwsbaKPCSCjN+jX3jcNz/c54v9ChJC2Rbzr+lEcWhJU4faTNSHgKwdMWpKC1GncUcGeXu3tgR6lrmIS1gn8hEW9stTlSxjnTqLIUtOTm+eYQRnV1RINFUAqBuSFJ6Zp8+8fUA7MSln64xtKIhHw/ibJClXM89YCNXvOtmp4VF28v24JW4YkQ3c+Nc5q9TJnsBEawIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI4yuKAM94jBhIOp+BLpCx97N5BrDLdYQTR8e7QqWp0=;
 b=eqzLU9x9fqj+E7wDpVDehu7kU854pty+HsHu2bWVSGqfSNOjM0NYIYbmWGaaO+XmqlusRXglgK19Xn9OfeEOv/kq9fMKKDoPZAcnCUkdW+rFBZCtX74jpSqkDtdFrAxG13qGeEskclWGhuiLvoD55MyOdvdt0kCsi3BbHuf6p70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4357.apcprd06.prod.outlook.com (2603:1096:301:8a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:47:02 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:47:02 +0000
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
Subject: [PATCH V2] sched: Introduce util_est boost
Date:   Mon, 25 Apr 2022 04:46:51 -0700
Message-Id: <1650887211-94710-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8185ccc-9bfa-4bce-f720-08da26b15061
X-MS-TrafficTypeDiagnostic: PSAPR06MB4357:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4357007C02D56BB55535DC69BDF89@PSAPR06MB4357.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1APgrHVgB+QCfpUkv37jA/9qZP18uPHHesmpMuy8xcNm6OxMuVsAXCPN/IjcYma6RklmWBOfcywHmwpF+vG6y867E3oAVD9cf97Bj5hygWGdQXsver8SANt5SBIfgH0c1wH+ZQR9fKfAk+AON3tHLHwRqywpcnaD0YZyyLUE3AK1cBOb+6Wb86DO1NBPr9yc1jd7juLB9pZSeS2mqWGKz5gSPdyRqdxS0bQJTMYFTaOCFrhTrvMpqpjlJHKc56FSbXz4katrwwOKbXBZK6Qg1QFgQdRp8scJi7vOrBfFa6nXRgb877rOBaMupCbqqXLbkv7FilcQOJrlqgMeOY+QopSvZvMVmBOs4wPuYpG+nfr4+mn0aXSY6n2eP2n1x28wFVFu6qomjg+m6Nu7tmAr8CBkrfSV6mpj7jnJddKmpOc6TctusE2Vbz8LlSzV08CMW3VfuaI6nIR+e31bif02zg/Ohtd0Cfhv8D7qm+mahye2agXUsTXciB3ymrw3KELsNV92cWN+WyQChJr6Fi1SUqBdfApKxGVfdvtxn6Jz0VHAHvjPIBkLduIyi7G9LMfvnivROarabbtGZ//UKQ6DS0A/0p7tJJECvfUeLvaVQ/fCEVH/14KAfLLdOdrOHhxBU6/7aDVC7Ts3AG5RrSRcgTE5o+2nNMfHSMf4jUxHvkhWJqhPOtpBG2sD1SxJkbooWeFYe3oMqPY8Hr3bDApVer2FTxjwVYxzgfmMpWtmelM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(921005)(107886003)(52116002)(6506007)(6512007)(508600001)(86362001)(186003)(8936002)(8676002)(4326008)(36756003)(7416002)(2906002)(5660300002)(6666004)(38350700002)(38100700002)(66476007)(316002)(26005)(66556008)(66946007)(6486002)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cMIHx19Pd8uhVDAf1q+Ml8g4qxeKIVeVJ8MBK47vXwEgY6KJ7AHsRoecTNby?=
 =?us-ascii?Q?Q+nwGG+s7LdQYi2XPdMdk5U3QkyBsI6bI1V+pbTELB6gwPbAEeIYBW7kWFBS?=
 =?us-ascii?Q?3SmrPN6huW+uyPRe8DCIQ5BYFrcR1hOk/2Jyk0SX71VqKlO1hyD5aC3sU0gZ?=
 =?us-ascii?Q?jlJlbphB8ao0FeJcQbR5yfHjJ9nS5L/FeSU/9pGjoFiLLH1wNgqqocVsULr6?=
 =?us-ascii?Q?sQc3XMQOJI4iuQmgju5QLcMRi+aq/oEBEDqXRUYaAALVpkILwUjWRkuQb/t2?=
 =?us-ascii?Q?XFCKFfJQTjWhHE96/8FfvlKwNG2/fIUzhO+EIwl8Btu7MtJuFWR1rfbHIusj?=
 =?us-ascii?Q?tIvS40mnU8xZ7zWOP1VnVFM3u5qwT8B2hORNYu22v7IkNmmQsLYjx83qraLc?=
 =?us-ascii?Q?c1XHRz+ssUKps896cMq1yBPiNJGpfmgjBPLuU35gjqGE+3yGLVP4pwstnZsR?=
 =?us-ascii?Q?nYLyPjnz+L/rpfEXM14rOXE12vQL7df5kw4ro5gFFTuRVYgXv3XZIv0UR000?=
 =?us-ascii?Q?Ph+463GK5hAVgRYdC2+FHOQFDP2MBCx8z2DFZdicCRmYlGqpncXLJcS5WrvF?=
 =?us-ascii?Q?V95kC8T3vafQytusJL+UdwisNpTh6ogK4HcrTR4D8ggsa1ssBErPLLblr04I?=
 =?us-ascii?Q?UEySMAp672BvZCs4v9qEeYUMv71+nXZw9IiCE3ifsiysn2SU3hS0mGCHV52Y?=
 =?us-ascii?Q?HTHCeZcIaqee3tdh1GGjKlsd1GRZKzdCax7YWWRK14q6c6AFrkDVWN+Zq3sM?=
 =?us-ascii?Q?t93VVg8gDPs1R1AGtl9k6Juz2uCjnoGHK90nQfWIZg9M2PCMKfd1idCCvS+v?=
 =?us-ascii?Q?zkKESVzUCmn2m6WZMWDHyK9BBTNGKu3J2PfPpdqGF4ev6FOJiMjJTUkSRavJ?=
 =?us-ascii?Q?SWqXaQKzZum7boSk6VWtbsyF6ZOXhA4xtB/QDETlyI9IKv5aMN+RYBKZG9cE?=
 =?us-ascii?Q?kwapDGg//IqQZV9nXqtdi1hjrmMKvOnU1rzSWzaxnNy4Uupy1m0QfLirXqb7?=
 =?us-ascii?Q?4JZVg3jb7L7FPo/LynizSywXJTyJAZWzRrjWvlpiCD1xU6zT19i7NZ5Gg3/F?=
 =?us-ascii?Q?DPb4JlL77Brtyf9XnkAwSdYZOOXgifaBWlguYBYwErYc4r4VgMWGVqgbBufB?=
 =?us-ascii?Q?RVitUA7ocH+fyQMCSEcNm2ohqNz/AHL/tBGT9IrJSMiQRTqToZ3d2ANuvbbo?=
 =?us-ascii?Q?pgyEn891kq8VcLKv5T1v6XapuFjPGRBsevIasfVF6qGfWhs0ujreT60LH7q0?=
 =?us-ascii?Q?BJVdyXSQz/Wa24OxsiW9SLE/TZNZ5sPswFueJvbWw3QvCNk8qj7qNp1hL717?=
 =?us-ascii?Q?kC586K7hfKmSKatHHI6CnU8JMxztHjAlTikBasHIJ/uU2SdIfRgGimFl0iFI?=
 =?us-ascii?Q?QXN7B8C3DxqtbC5l6X2b7S40KLs1KNA6ulalVnH3qx1apkVLWx2y3HSjoIjI?=
 =?us-ascii?Q?snuy9qzPZ27xlW2emzsZ8MWdiUt+MBJRTc9zyYg8B29m2xTqxc5dCezYpngv?=
 =?us-ascii?Q?fRvFy9iaA01v964imyg36b6ZE0zfxYPQOt9UEXsJA8ttK5NoiKr/WDMN/tvb?=
 =?us-ascii?Q?qXarNigKD0BPo7BCOdT/ZnLcPbiGhpwrc44yONqtaoW3lwmBUovn7yvme2Ve?=
 =?us-ascii?Q?1FG+yEyHSsi6v4rLc8unqVFO8qv1o0UjkCwK/smstoRWu+u1JBnpZ+X37gY3?=
 =?us-ascii?Q?3+qYRZd4O+qP6pZ3YgJ/TYu8AoVotMaylcTn1ipWBWfvlrUqeodgcQyUxokt?=
 =?us-ascii?Q?br8eOvVKzg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8185ccc-9bfa-4bce-f720-08da26b15061
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:47:02.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSu53gZj9+nSPfayUndPkfuhwX9rofHEla+E6CR4nrnihUhMFZIxIDRepoN2DD/GucWZhF5t+V9Ncd0jR+/D5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4357
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
v2:
- modify the return value if UTIL_EST_BOOST is false
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
+		return max(util_avg, util_est);
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

