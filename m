Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FC4DA888
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353257AbiCPCn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiCPCn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:43:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2073.outbound.protection.outlook.com [40.92.99.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0545E53E04
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0qpiHp0THyHthWyYVtP2weI0RuQ4fXDhfzL/JpETke9L3xODczdNTAXv6wHmix0Y/uzh3u4Hd5d2G8P8g+sk+HenbweUbaHos/jWmsQUQFXgmnkxeByHTRWo0EKfiz8Y68F9WBvOs7CuCJe4L1UbNj04givQxK1mi/Zo3/a3Li4pfqWthZsEjVjU936qH/DqHTRS3L0Pr1Z16sxo6XO6lbLH1VECQNwFTEcrMuIfOVjepFTnMtscuBP5tCUDy9HnIrgJR+uHEMWXXUVBLetxxNQkWNR+0DSFZWCS5bN5k3nZJ3XQ6tU1RfVle8BzNzdbTrQEJi20KJHPyofadWL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQuEt6+fCnYztAD0Pav54WK076gU64tGNteELvgHRsQ=;
 b=KwsrKOlwjXWEYK0g5Ndw+k6bNXdYm5ePUqZzpvX7QsjpDrKTjhHAMrWfLKXbabnOgfDWASOeZxdAcWR7sfYmtuuGk/Mr4fKSsYRv22vO9xcJ/YtHDfv0PbIqnwylo3WMVp3DpBzciBOCicEK0I98PZkIKV5B8+hNL7z7HY4Yn3Esjsf/lYMpFynpH1aRNaRSwDHZGbtV6+JryoeCtjlmdZMaIc6rB1GCunUv/bDLH0x4LBewLSUmrjIqmi2K7iUKgOqYxXNn1RplQD6Fn3UADvvd7mp2Q5fCNlZwwibca8NysCoNiC6EPxbcbRLK7jBDnJ7BV+yiY3+DvhCL+nxp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by OS3P286MB2524.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 16 Mar
 2022 02:42:08 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d%5]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 02:42:08 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v12 09/13] task isolation: add preempt notifier to sync per-CPU vmstat dirty info to thread info
Date:   Wed, 16 Mar 2022 10:41:25 +0800
Message-ID: <TYCP286MB19137ABD644EDFBD20EBC40AA1119@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315153314.130167792@fedora.localdomain>
References: <20220315153314.130167792@fedora.localdomain>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [SE0leQsCWxoTgEmMri10JUTltTeKHnIs]
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220316024125.6820-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae41a335-ac9d-4cb8-21a7-08da06f69071
X-MS-TrafficTypeDiagnostic: OS3P286MB2524:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3FqWHWeBz0hnG0uZvpcPdVnc0GMQz1Ce9lxb6SZt+U9miK+3bTwk8Gwf32o287luw7QhsO5kIw8KSXcFSaKZ/jxpl+MvEUvIdqG/3fd9T/Oj0A0My0Ivba5xpzICG11SJBa6WcD8zjLhFUdjPmML9NY+ksUxMcag1edR2NSdLFOuwAsay3XBIzsiRybUNABICNII6mhpSYSKf/ywPhWx/X9N4nYkBwZk2PSCP8rNTmcK1DsyNXqkLtxpJ47ktvweMVf2hjUgOiy6zs0JdEWNDhShsNHgtaPbynQEeWy7WmVswA2xP33+b8GNnHArvJd/Dh1O4YgTa5W+kg/xR83az5x01WFbzoeWsJsaNiVxwba3bXfMDu1kwPamGfU6SxNAPYLi5ZDIy7JHIvTzuEoFsCChJDnrB3vvS3VUpW/baujDjnwSIb41Y4CUGv7UmQaUJ/CdLPWJj+az5eekJJV9HDAA3ZViXttuFjskbjmr2jFf7uZrGeP5xybI89oYkvwWGADEUhHHbdOcxeAk1v8bQ3frq+GUChVdMh0BUplPc3wrtCVKKcLsVgyFKa3tlQtmi479eAPj5upnpNNLLoKetzDjrdJ49Ixg49V0fOXGkXyAkUHeMWXBHHwQYNQThWO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7IbHHF/0YJA8zMeoHadJJlTQwXIR0W0gWRb3iSkT5kEqvwqV7XjkC7B67vB?=
 =?us-ascii?Q?a7h0uZOymhtLi75LGziYlXWsO6I37dOG8G7qOVKZf9wRvUS7lKjfnnvD1nni?=
 =?us-ascii?Q?uTu3rCUyOCGVxO6zM3sBhVOuH7e6Slmgmd/p/17jYZeqZ3pSfOask2/UGdvc?=
 =?us-ascii?Q?TPVyIfP5rpi6R4ry5LlUyBDRfEV+RN1Tte9c8Pa3SNm2GTs9kzRPWChyoPfB?=
 =?us-ascii?Q?GTWgKuIgv0huuUkeuP/6pizFUg13puWLGwckjncD29FqLFzpDXdFdpUZSfgj?=
 =?us-ascii?Q?aQlZH448xPQ4/3lLyZVjPi2QeH7NcRqu5RqfhmiPOzDCOIdqZVz8ysfFA5Mh?=
 =?us-ascii?Q?AyZi2nichwjCImUcnqh6cFES0PpzDwTOz5blPBzlQCLrrAtkb/XEJiwEVVkD?=
 =?us-ascii?Q?Tp8WGtvF5E+oVjWhIceCckFMli5dNXwRz8snUYheHWKJPJIxKJXYvAympRsf?=
 =?us-ascii?Q?HDPpQWYCZt0FLCKSDJ5/pmrWkAWECnWOP+dg5zOGUqkPTNcIRoljZwK1VXpL?=
 =?us-ascii?Q?rdT8zlO6kjtCMPxoKh/UA5d+Oa4Yvna1WKWK6LOFO1gBXInckYazpDMc+oEW?=
 =?us-ascii?Q?uOgwW64eCYtNsJGZb/T07qdc52Sno2lki5ryfgcW8Z9LOMOpgrOvINJ4yFix?=
 =?us-ascii?Q?McM5DB01k6tzcr+IU1GHWBhUscExIMQM+NB4X1E2HwqbrjrQT6C6aZvsdp4P?=
 =?us-ascii?Q?KGT11ngnKr124qOV1g+uNc80t3QJllSdjY3YgkDlUf2hBqSPRE6oQ2Fnz9uw?=
 =?us-ascii?Q?YXjxDbRs9DPU3/8AeL0XBtmHltChQGr11e47GAFIXCL63vEGSLdxDH6DNebz?=
 =?us-ascii?Q?KA7ImtU7PWjC/l9nv2L0O0eGFHOANv50IN91B2Ea9gVu6V3R5YldxN11FuqO?=
 =?us-ascii?Q?ITBlTCs6MXQMMED1K3yt4s7m1XyNKg9RwAIRUA692e0wfSbcVt/S/fljPnEW?=
 =?us-ascii?Q?a8DmRQmy7jUi8AypfrlSHTwkzk1f4PTyTWVRxmFbgi8NziVarlZsQiHEN2BC?=
 =?us-ascii?Q?5IO1u9sMRVFYiXqn28djacpdzBwDKXDo43lQtzniQ9UqJU4L2z9Pf6PCDrIx?=
 =?us-ascii?Q?q1JQGXbYSSBpc2QTHWDpIibZajFjcttOQfXeoksVMc5Pmkk1YuMuIyBiciOH?=
 =?us-ascii?Q?C/l2qiGp29V4T0UrnYKU8WYPNlIeg09cBg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae41a335-ac9d-4cb8-21a7-08da06f69071
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 02:42:08.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2524
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2022, at 11:31 PM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> If a thread has task isolation activated, is preempted by thread B,
> which marks vmstat information dirty, and is preempted back in,
> one might return to userspace with vmstat dirty information on the
> CPU in question.
> 
> To address this problem, add a preempt notifier that transfers vmstat dirty
> information to TIF_TASK_ISOL thread flag.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v12:
>  - switch from raw_cpu_read to __this_cpu_read (Frederic)
> 
> ---
>  include/linux/task_isolation.h |    2 ++
>  include/linux/vmstat.h         |    6 ++++++
>  kernel/task_isolation.c        |   23 +++++++++++++++++++++++
>  mm/vmstat.c                    |    7 +++++++
>  4 files changed, 38 insertions(+)
> 
> Index: linux-2.6/kernel/task_isolation.c
> ===================================================================
> --- linux-2.6.orig/kernel/task_isolation.c
> +++ linux-2.6/kernel/task_isolation.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/mm.h>
>  #include <linux/vmstat.h>
> +#include <linux/preempt.h>
>  #include <linux/task_isolation.h>
> 
>  void __task_isol_exit(struct task_struct *tsk)
> @@ -30,6 +31,9 @@ void __task_isol_exit(struct task_struct
>  		return;
> 
>  	static_key_slow_dec(&vmstat_sync_enabled);
> +
> +	preempt_notifier_unregister(&i->preempt_notifier);
> +	preempt_notifier_dec();
>  }
> 
>  void __task_isol_free(struct task_struct *tsk)
> @@ -40,6 +44,21 @@ void __task_isol_free(struct task_struct
>  	tsk->task_isol_info = NULL;
>  }
> 
> +static void task_isol_sched_in(struct preempt_notifier *pn, int cpu)
> +{
> +	vmstat_dirty_to_thread_flag();
> +}
> +
> +static void task_isol_sched_out(struct preempt_notifier *pn,
> +				struct task_struct *next)
> +{
> +}
> +
> +static __read_mostly struct preempt_ops task_isol_preempt_ops = {
> +	.sched_in	= task_isol_sched_in,
> +	.sched_out	= task_isol_sched_out,
> +};
> +
>  static struct task_isol_info *task_isol_alloc_context(void)
>  {
>  	struct task_isol_info *info;
> @@ -48,6 +67,10 @@ static struct task_isol_info *task_isol_
>  	if (unlikely(!info))
>  		return ERR_PTR(-ENOMEM);
> 
> +	preempt_notifier_inc();
> +	preempt_notifier_init(&info->preempt_notifier, &task_isol_preempt_ops);
> +	preempt_notifier_register(&info->preempt_notifier);
> +
>  	preempt_disable();
>  	init_sync_vmstat();
>  	preempt_enable();
> Index: linux-2.6/include/linux/task_isolation.h
> ===================================================================
> --- linux-2.6.orig/include/linux/task_isolation.h
> +++ linux-2.6/include/linux/task_isolation.h
> @@ -17,6 +17,8 @@ struct task_isol_info {
>  	u64 oneshot_mask;
> 
>  	u8 inherit_mask;
> +
> +	struct preempt_notifier preempt_notifier;

Since preempt_notifier is visible only when CONFIG_KVM is enabled,
I think we can add KVM to the dependencies of CONFIG_TASK_ISOLATION.

Or we could encounter missing definition error while building without
CONFIG_KVM.

Thanks,
Oscar
