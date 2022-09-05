Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD05AC8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiIEChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiIEChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:37:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C02BB06
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMprO0k1U7+IXbn9FHGaQHrWWM5N54jBIhEBrJW4rWfswn7m8ofKhC6/apzXTZ8AR6Pas3eYw5vDtyzJLAO+RPvd5k5ofbnV27Hu5zw+ZsADBaIIFgcO30GMea5d1l5srStQpWodrjilWlGcgJYm5/nXeKqOS/Yy+wuKjzH8Tqdu7UEeL/j4did6bQ7sy6qxp3d+xEN+T8jG0DnHAt2Gt2bEczh+ag3owr//nj6O/WZaWi8U/oSSk8UoWUsFXNH5nnEytsEfASmpBXrSkQki2nJ+bSK2MRZ0wW1WAs48NMJR0qVRVSJItK510l6h6+skBFCV5m8vCgAjgdSVw+yP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT1tp6VPRLVDapqpPtkp9MhG176F3ja4jKrA0Rl9Ke4=;
 b=lV1Ri0v54ak/Kdm8SlMONiIJViDyKxdHzxzLKOn8PX1mDOoVSrDzSIvBup5KrufFGywifqUigiMPb7oeaGOGGpgIMQ3CUVkeFUylVpqHreudjkHRAYM64wpyKSNLLRcgXm/aQQenHtJ2QWzEuQ8PW6wT7KaKzNauhAubo9OZz6bwawid1SBTM4d8EDhU3CqKPsz3Dv3gM/YGmnN25FW43qAQgBqTklWICQsWFL91M9RgL1sLgNHb1IOtcEtVOxWotnzdssU+VqYC6dTHOFnBoBdhjnmJiZnbpm+owKyQcezJpt+6nsyEIYsL5/zxM0EnNIkkrTVS2dakdLl9nIa3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT1tp6VPRLVDapqpPtkp9MhG176F3ja4jKrA0Rl9Ke4=;
 b=G508bluYg+7VKGvVFETOUgoqHYWarlvFsaMy7zvbaQgep8wj34/1vkM5Boo3/xRCboFB6mfzIp7fC+oDP7wxdD4+mYHQedmmtcygZ07vHwilJRLZlgEi1iIlbJ4n3xehd2zCrltjolB3C81OPSYYar80Tl0cPSrwUDJ3JLP/RgeNDkQufW+wBuLlMca9l/G7oY0Nse90RMSyMWy3RAaxE+xMGQ58UScOJ1ogVR6lZDxN76zcFeVf9yWQkRhxecBAfRkP2iKdwPwf8H6IcSjlzF4sv7ZQ1jFy46oo8Sf2lRkR+WyV/1do2wrKHpIZtomkLVrW+h1TLa3G9JMEq8lrzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by SG2PR06MB5155.apcprd06.prod.outlook.com (2603:1096:4:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 02:37:28 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::5c66:2101:a7ac:8df0]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::5c66:2101:a7ac:8df0%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 02:37:28 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     zhaojunkui2008@126.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] kernel/sched: fix KMSAN uninit-value error
Date:   Sun,  4 Sep 2022 19:37:14 -0700
Message-Id: <20220905023715.1920088-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7dac1d-4c7c-4f84-5e53-08da8ee792d2
X-MS-TrafficTypeDiagnostic: SG2PR06MB5155:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG2I5wL3HQaMgOQcwV97YCvNSik6Gzal/19jreBuYM86Uu+Mr01QkCEwgh78MOB5uj1NjJFWqARhdnMdITQuQi8KVqUcVBAPgJCEyMcRmDCIiZeC4FF8fN6JPO/CAkvqhGfwIhoAYsw6hC8r665Z8awtcSJ1n6zbWAki1msDusm/Sl0PdEcGiZNnPDJUiNPOr5tV64DPllX/2GilY0F1jch89/FjCuq0pBCl6UaRIsUw2m2bIatKKsQdSthSI7d05D925BR07pP9BHfLDMd7Cf0OJ0qPri1qOyUe86xHSlnTs/m8ETVCBJa/ZjqPyVCIAqQ8mQrtndA+wTvP46llzc0mD1Ae134tOs70FpgWqqwLvzwn2sM0qbYO4JngL/AYa+eDaxALA3iJDqZGifRtPFIBYOFb/EeyMVkjKewde/HTB3MAye3yAXNvKRON9Z6VaZ6MjOpCyvBA66QVIv10GKK0fkUtAcB3n01f4KDHfO69c/vSF8LYT9pCL44rtHlDOkcVK32ojdzsNJcwbRXVOvdqsJoyoBTdkfEemqVG1m1+FMECG7FSydaQAunkSMdbpsg9WXZa1GNYR4T3Ou5u+H3vj/PAuwOKglKjRfka14mtx76Wt4NNaG3p5CWWbylZivvIF7JnfuoKcNgdrw5a5FboPcoHmH+1WIt8lAMec41ixR9hhT43P9gY9mvx3WMr1XaORKyf6nXj6UZCtQdflID7Tw9umDKHMQT3HMOhRAJWx3y0/xZPPZTVNUJU0eE1yjJ4z8HTURU1DF/Zuu5ebI7UIxx9Z5GTVitsqZtTuiyTfyim3uep58r4xDvny0ynO00iZHW+ktrvoUJGbg708rGqC70n9L04P7MbJGHmGrUj+oLJ+DIyqejWZWoSlSr1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39850400004)(366004)(396003)(346002)(8676002)(66556008)(66476007)(66946007)(4326008)(83380400001)(36756003)(7416002)(110136005)(8936002)(2906002)(5660300002)(316002)(6486002)(478600001)(966005)(41300700001)(26005)(6512007)(52116002)(6506007)(1076003)(2616005)(6666004)(186003)(921005)(86362001)(38100700002)(107886003)(38350700002)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSiuBfUwPtJ79lVnNmnkgK/7tELx2xaI7y097tW29RLk+1hy2jGDs+bLhcWA?=
 =?us-ascii?Q?9EH2NHP4inUZe7/r61G/P07bLsgihVHRH+oBYgOBgcgjtFftLY2GzwsWv/qN?=
 =?us-ascii?Q?PtxcG1S+qIJ6TCt96ql74k59Pemh0H0K3EX2K2rcLILHNhyV29rnBzL+9m13?=
 =?us-ascii?Q?asWk5ORZAYRlx1Z0ddvwxdP9E8MSWrnbguQ7WgffQQ1xVhk0ZTpfGP8NROJk?=
 =?us-ascii?Q?5pCuiEEH7XeM5huf+CGb/yoZ+9PFkwhu8NCXzm8NbzXSPEgo942FdIkLLXt0?=
 =?us-ascii?Q?oZ66M+Ye6436olhILHMJ4KqFqIoN1xT2Z4MOvW1vMxqFn44pX04+zT1+0jLN?=
 =?us-ascii?Q?a1GH+Z5ekFvRpqsXDv03UfsKV1w8Dzd7CFiIumTL0Bl3K5e9ZH5No52mgEI/?=
 =?us-ascii?Q?cfwhwFrZTBIgJqDibD2YX5xcb/qHQQ2HaTiaVkuF1EVSi7BbzAOuzk/9dGq6?=
 =?us-ascii?Q?Z+4cAhgYty8BQl+X8NFEZMidw0C7iI8A1EFIdyTWGHD7Vr1qcw34+tWBgOtb?=
 =?us-ascii?Q?O1nfL/9XgnDBYrSvzDl/cWlkesNOdpam+dUqEHK/A6fzzY6rUE4vknUQ2k1M?=
 =?us-ascii?Q?2AfrmnmhESLF0c5BDdIHiAizz8sEfF5lcrqoljFOgmDMXkQ6G9lU1vgV8ct8?=
 =?us-ascii?Q?y/OGhYlP5gux9c/AYAeJNqUE9y2JO/LIXqwkMAOSDM+995ozyTObfI+ocuYY?=
 =?us-ascii?Q?xtFbdgVntQ8v7pIwx8SkVudQFTAXxzilA9c6yZKPMSjQzpimA373zcLAhVxa?=
 =?us-ascii?Q?UEO5Il6hChKWs4TmT9DRqgrPsirIxlaP9BvZ+Rg7pVVwtZrRLVEhO4dPOTA1?=
 =?us-ascii?Q?5foHC0u2RlSX14NPTdYN3sMCndsvnxPKk+1LNZTZ7PHfudbN6ngTNKiI/LYV?=
 =?us-ascii?Q?QrzBeoip/q+Duh7NMCxP+VRCR7A1g1KSV6vET5iwzOoU7xXLxJL7p+zyLIji?=
 =?us-ascii?Q?ZbwQOiWPFgEt4IhrfNv0fBGqyul7gytMEDS+Ni4hVqYOfMJDnlvi/byfKsVr?=
 =?us-ascii?Q?epaUcDI/MbFY/PFwA87Bz6DcsUDXZhG5FzrO5BGs6qWc1ZxrsCaOBDQ1dFXf?=
 =?us-ascii?Q?uwxb7vWFbWkLZFkN9Z33+BPRM38aG7MZDo3tyym0+Mlc+I5lRdaUTllLQUnH?=
 =?us-ascii?Q?0aBNlR5w5WTp3KtrnGl2lgIpcEb5K4T6PPGrx/tVgsc2Tm8OWqRMEW5S8+sR?=
 =?us-ascii?Q?n7z7oVnsR1x/xQW4TGcqeEleDsqUdYCQHSSq+1dK8u+OfBT7JhYs1x8PuVL2?=
 =?us-ascii?Q?Tp/M/DsqgQdUyBfyEjL0DjKiHgSpxMLiUaVOBDSWqUD/LOFPmczmSGa3P5zv?=
 =?us-ascii?Q?NWqo9ah8jphNwfPShTlu5NTdRTwY4c2n/0xZGMpiS69ZkMU87WCmc7XkyDu7?=
 =?us-ascii?Q?9Lk6RJ5rwwpDtzu4cePYevPQNBQTQ7fnDYKnybuUn+iRvLZTMGBet7h8d1m1?=
 =?us-ascii?Q?68ZwVThM/JPVX6ugODbdeDLm/O9gi54WCW+3zuNe6++TyYYATJQrXahkbql9?=
 =?us-ascii?Q?868LyFBG8gXduEZVhaU9SNdIQz7axmOLROUWbe+OOa94YufK+10ugIRUwSxW?=
 =?us-ascii?Q?7MD5bJ1lyvntHanimXf/t9utkUcJE9Q7Es7/XNur?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7dac1d-4c7c-4f84-5e53-08da8ee792d2
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 02:37:28.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTwplbsYzZc7AFs/AKf+xYSiMEYxZbpwEGIOKdPNDYnc2+pjzIRduPAHBXv9/fhq8XCLYL+yhOEcJ3gDhmgB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to fix syzbot error:
=====================================================
BUG: KMSAN: uninit-value in update_triggers kernel/sched/psi.c:525 [inline]
BUG: KMSAN: uninit-value in psi_poll_work kernel/sched/psi.c:626 [inline]
BUG: KMSAN: uninit-value in psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648
 update_triggers kernel/sched/psi.c:525 [inline]
 psi_poll_work kernel/sched/psi.c:626 [inline]
 psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
 psi_poll_work kernel/sched/psi.c:604 [inline]
 psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
 psi_poll_work kernel/sched/psi.c:604 [inline]
 psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was stored to memory at:
 collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
 psi_poll_work kernel/sched/psi.c:604 [inline]
 psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3258 [inline]
 slab_alloc mm/slub.c:3266 [inline]
 kmem_cache_alloc_trace+0x696/0xdf0 mm/slub.c:3297
 kmalloc include/linux/slab.h:600 [inline]
 psi_cgroup_alloc+0x83/0x250 kernel/sched/psi.c:960
 cgroup_create kernel/cgroup/cgroup.c:5430 [inline]
 cgroup_mkdir+0x10a3/0x3080 kernel/cgroup/cgroup.c:5550
 kernfs_iop_mkdir+0x2ba/0x520 fs/kernfs/dir.c:1185
 vfs_mkdir+0x62a/0x870 fs/namei.c:4013
 do_mkdirat+0x466/0x7b0 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0xc4/0x120 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

syzbot link:
https://syzkaller.appspot.com/bug?id=d04c5407207d11e46007775517b97764174bc45d

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ecb4b4ff4ce0..46f048121520 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -195,6 +195,9 @@ static void group_init(struct psi_group *group)
 	init_waitqueue_head(&group->poll_wait);
 	timer_setup(&group->poll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->poll_task, NULL);
+	memset(group->avg_total, 0, sizeof(group->avg_total));
+	memset(group->total, 0, sizeof(group->total));
+	memset(group->avg, 0, sizeof(group->avg));
 }
 
 void __init psi_init(void)
-- 
2.33.1

