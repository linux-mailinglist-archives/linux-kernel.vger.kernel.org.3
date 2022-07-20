Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509757BC54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiGTRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiGTRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:09:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FC69F32
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmTOASxkmOc5Avox9RHcAucvi7dTDSVlAA9U0OpcA4g2B+TXpOx9Uw8IguwjteTIPja5GepApI3dq8tw9tBi+0OrUtIP1DDXYo+EgDIvsSg4Axlo5/u7PJ0veVbOsUgFPg3eUWqqDULHhytHsGyHT0BVnyhgyqPjRqqn7fB6EyW3eombUjSw21ZHOCudppcJ7MUbAq3cNMWCv8MP/h7VvogI52EtbxSSbEpRXq20iTOuuTmpKMQJYK26rEPdetCMmFayegWxtPqSLoSGHIBzXvlSj0f0NSoMRG2xnSPVQ/sCZdfDGFpMJJlgQQKs8tBSkUZFk6OGGUHWRHIPaF/43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uojJpxgP/LPLAZM9PnJmaLwJFQ7Lw26AqP0Ida0suPY=;
 b=EVWcwNanTT/J278GnuB0a9FheZe55lWDdM0YYNW47p0KtCkpJ9Z7m0WYwwnIm+b60ED1aXDnwzE+WCWsZeZTAvMZUJ1oA3b7KzmXxDQIVfAFEJU+MCPr2a0GeIA6vQQQsdatSW1z015n4sv0GDRtNuYuKKW1ivpBXINssZa3J8eAW1FnxW7El9jMEwFVnv/QxSGJTztWuTFc6YQmIIOzzEeEZ2DZ9kWV04hSaMXa52+OCDNK5NUmXoHZnQwQVaU8f+ExijbJ/Hucg6o9C0WWN9wWrehJSR4Miw7/P69F0TK5y0lHEN73BUV/BX3U+s8Cu59NO5JexghSQFaUNQdXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uojJpxgP/LPLAZM9PnJmaLwJFQ7Lw26AqP0Ida0suPY=;
 b=rrnD6hZvel0uUjd9e9YoXpYT1CV5YpWBjxDeuJIY7luOpZvDSrzLaWIkvzm2nAVOR+6Ji/5LbC+MxMytbVauNhQX9peclCqZRWc1040Rpt2k58aQhi41F1KuwiXG5eAHqf0xm/urS/FvBicHQLHBilAG3DkCdR4HXTDDey/cxY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BN6PR1201MB0033.namprd12.prod.outlook.com (2603:10b6:405:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Wed, 20 Jul
 2022 17:09:03 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 17:09:03 +0000
Date:   Wed, 20 Jul 2022 22:38:49 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Message-ID: <Ytg2oRUUpYmYYzCS@BLR-5CG11610CF.amd.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-8-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619120451.95251-8-wuyun.abel@bytedance.com>
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95739c3-7f5e-4013-6f35-08da6a728bb2
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0033:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuGD5XBUKuUa7B5GA58fs8tP2xjXRh71rTLIl+GJqMg4v36jwxkxvtgADhcmo/NULNh5y7vg9aK87EY8A/SFD6Ybv9vTmjoFBOduJ5pfvA0goZf4RkfvqhvKW5UKOVPi5mEc4OmZhL39cUdL9+Kdddxi8IuBoRszHj9KwHh0VcB2WuLxmYr2hAbnags4vWVb7Gb09OpzZpAaBj5QFSIAyunILvn++Mivo1ghvSTJHBw9T7s5dK8wgojQTLeutz5jvFKGky/1d43Ci3Jc4jvfJPOos6/hlvGbaflQgONIIEMhpMHzvuQhnx9WweJJ1fSGrRMF8CIZKWobOj1iIwG68oGYyPIH8y+biqrHxI0WWBinJpptKsvaqLXoedbG2C/A2pkmnFPOeDdK5999PW62rR1kfPU1b8bOuAabmZoBNFOP1ZP+Gk2Dr3SVDCTeuXZj8HICNs/XfP+/EFjQMWIMptGBZAGR5Nqr/hi+jU2YjINYXNPd7ssGG/nMo2dL9yeRjBflmNFOQpw1kI39aCAf7j/xo2/MKP3nZkJEEi9Kjsq+UL+AZvSDL3l4KtU156XqXINc9UuWDZfhe4QQWcbd1ZMx1OUz+BfdwO1R6Hnbnl9SyfEV8QxRFvaZbVASDItww1DENJ1PrKknU4uYsdUceWY2wYxog/3AdOxyKV6Unx0zsoElghVz5yoQeD912cgEyx1AJAKpyOR/vFKbYScvb43+PiQcZIet6XIDiGwxz1masziYlX4X+ke3x3nDv483
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(26005)(2906002)(6486002)(83380400001)(8936002)(6506007)(66476007)(6666004)(41300700001)(5660300002)(6512007)(86362001)(316002)(186003)(6916009)(54906003)(66556008)(8676002)(478600001)(38100700002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OurPk8IYU572dW1GSQbOjFGXJnv3xum6Biwv95Kj2rmlPnOtsnroMdlbr/g?=
 =?us-ascii?Q?lCCtGgToGOCZBSv/NU5RAWorCgrGHimp7JTugeHwY4ZjtkwLxhX8IlDQQ1I4?=
 =?us-ascii?Q?aRPcz7KtVfPczSmxqssz8efINXLB7sVSXltv56+zhgdopYn8bBpCLUMZlCIk?=
 =?us-ascii?Q?Z6NK0+aucCP1AJpwSQ/l5uH9tMCVqcY+b8oXC63cS9NdfAzLLVwqXj2OmURa?=
 =?us-ascii?Q?YKR8DiDp0EC1Tc59Hi+fP71Tsq0YZaZ09TKR914HlL9fgao4yHtguc9aVM1u?=
 =?us-ascii?Q?x35wNoyPWHuqQujhMDpWMj4J+fciWE+84YII8vNq5ktVSVnD+pKGYYoXbhRz?=
 =?us-ascii?Q?HC2+fu24Tlaaj1IX4kP6gRB8QUzyKk1bcaUjCyrgGovSD7uu0kejtdQ/JPo2?=
 =?us-ascii?Q?ZD/Q4FQTpTEn6ka/bXgoE7pkmzmZ4Jo5YCYAtvuo3vNFGCumd+5jaAICCYyd?=
 =?us-ascii?Q?NoMn0ZbhWA8G9AolWvhaLEdE4SWdLaAY/acKQgK3NPhWdnQh19HcAKl3nszn?=
 =?us-ascii?Q?H7uM8nh4vAHS9nS9rGzaYV0ng5opkaeNvy8GrV/a8AazKPmaFyfmNrSUdQqw?=
 =?us-ascii?Q?R8CIs6cuaZZdkLhGInvJspC+BU/0tOYN3p00FnbQwXCwU4oIHAGESToycBu+?=
 =?us-ascii?Q?7YS8+noK4bzbjuoKsQafOIKft6xDWp/WM5l/33Y5JGeVuCL6CqliEv+COlqr?=
 =?us-ascii?Q?PNyxP4SnXzKCbRuNp8utJIp55P8fpH5qKj2NQUpCJLn44xLkFX136PMlGmwT?=
 =?us-ascii?Q?Rw0Jif2ns7Kkh86K4zKclXt8FWkq4ySXpgrarERRIyOevR6HBG9BRrY6wO1t?=
 =?us-ascii?Q?tg/+/WF4DnRtE5dkk2a+GXnuNhLAEdOdUpP7rfzRs8isLEzqA1wLSTg+rGVe?=
 =?us-ascii?Q?zntUGKFjVc7SdoscdMwggrDmNrPJBZDZ0cRx/K8FVWlBEfnyG9Qk4ejm+5or?=
 =?us-ascii?Q?49nm/rP4KbXog/UF+x5Vvg0+VzI6wUaRNPBnqT8fb4VisvFEOAjAuPf6EthS?=
 =?us-ascii?Q?QRFAI8h9SyUlxxeZl02acytbEeD1G27LOdKDThyt4roK0f/BN1VYUD6He+4b?=
 =?us-ascii?Q?SOUuAbKO7UtJ+pp2seY2FQVMpakee7xn75pTjU+5r67HpRiOJZxKQtrO4DTQ?=
 =?us-ascii?Q?wgDxhDRa2/nbAccYWaEr2Zl2qni7G/ymyso/+Vr/czulv4etO7xqEzVpnxbo?=
 =?us-ascii?Q?rZe4GdwcDja4N9boAXT6AKUYNt/bsp2ePSImgcTfjkUPY3tvlXAhAfaxwARF?=
 =?us-ascii?Q?nxOrb+EnSN1Z53Qi1GfrtWGyAlQXnyhz33BJVDAiuIW3mzKnNTCxQ9s+vdOc?=
 =?us-ascii?Q?+Yx2AyEVjBQOAYLkZwZmv4NqdsCmWYoo2nd9AMF4bBPQRsg1fbZf9GDMxPxB?=
 =?us-ascii?Q?K0bGKH32Rn5drVPfGMO2495Eh8HNjd4CWfxkt9J1OEopM+/eEd1DiPV1iViu?=
 =?us-ascii?Q?cB+rCUG8CO3Sh0xXmf7FIEfBkjMUtNV4GVSgsKJU0i83dvjqgYnpRL0fIuu2?=
 =?us-ascii?Q?mrneZZI5v/BcUBUM3AE0hkkT3Epg+5sGXWNQIYRz/yv6MkXFwZwwuZM5A2lo?=
 =?us-ascii?Q?EUvBBYONsMtKWEGDuaPK+a3AgTVaJ8IkwRETsMYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95739c3-7f5e-4013-6f35-08da6a728bb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 17:09:03.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqfYWudZtm6+rLjidmp0V37nE1OkxGIJtrEs/TNfQAFmYOp9gAMfVv5HpxRyCZU3Vsim0N+8/h/ly3EsGnRtFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

On Sun, Jun 19, 2022 at 08:04:51PM +0800, Abel Wu wrote:
> Now when updating core state, there are two main problems that could
> pollute the SIS filter:
> 
>   - The updating is before task migration, so if dst_cpu is
>     selected to be propagated which might be fed with tasks
>     soon, the efforts we paid is no more than setting a busy
>     cpu into the SIS filter. While on the other hand it is
>     important that we update as early as possible to keep the
>     filter fresh, so it's not wise to delay the update to the
>     end of load balancing.
> 
>   - False negative propagation hurts performance since some
>     idle cpus could be out of reach. So in general we will
>     aggressively propagate idle cpus but allow false positive
>     continue to exist for a while, which may lead to filter
>     being fully polluted.

Ok, so the false positive case is being addressed in this patch.

> 
> Pains can be relieved by a force correction when false positive
> continuously detected.
> 
[..snip..]

> @@ -111,6 +117,7 @@ struct sched_group;
>  enum sd_state {
>  	sd_has_icores,
>  	sd_has_icpus,
> +	sd_may_idle,
>  	sd_is_busy
>  };
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d55fdcedf2c0..9713d183d35e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[...snip..]

> @@ -9321,7 +9327,7 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  {
>  	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>  	enum sd_state new = sds->sd_state;
> -	int this = env->dst_cpu;
> +	int icpu = sds->idle_cpu, this = env->dst_cpu;
>  
>  	/*
>  	 * Parallel updating can hardly contribute accuracy to
> @@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>  		return;
>  
> +	/*
> +	 * The dst_cpu is likely to be fed with tasks soon.
> +	 * If it is the only unoccupied cpu in this domain,
> +	 * we still handle it the same way as as_has_icpus
                                              ^^^^^^^^^^^^^
Nit:                                          sd_has_icpus

> +	 * but turn the SMT into the unstable state, rather
> +	 * than waiting to the end of load balancing since
> +	 * it's also important that update the filter as
> +	 * early as possible to keep it fresh.
> +	 */
> +	if (new == sd_is_busy) {
> +		if (idle_cpu(this) || sched_idle_cpu(this)) {
> +			new = sd_may_idle;
> +			icpu = this;
> +		}
> +	}
> +
>  	/*
>  	 * There is at least one unoccupied cpu available, so
>  	 * propagate it to the filter to avoid false negative
> @@ -9338,6 +9360,12 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  	 * idle cpus thus throughupt downgraded.
>  	 */
>  	if (new != sd_is_busy) {
> +		/*
> +		 * The sd_may_idle state is taken into
> +		 * consideration as well because from
> +		 * here we couldn't actually know task
> +		 * migrations would happen or not.
> +		 */
>  		if (!test_idle_cpus(this))
>  			set_idle_cpus(this, true);
>  	} else {
> @@ -9347,9 +9375,26 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>  		 */
>  		if (sd_smt_shared->state == sd_is_busy)
>  			goto out;
> +
> +		/*
> +		 * Allow false positive to exist for some time
> +		 * to make a tradeoff of accuracy of the filter
> +		 * for relieving cache traffic.
> +		 */

I can understand allowing the false positive to exist when there are
no other idle CPUs in this SMT domain other than this CPU, which is
handled by the case where new != sd_is_busy in the current
load-balance round and will be handled by the "else" clause in the
subsequent round if env->dst_cpu ends up becoming busy.


However, when we know that new == sd_is_busy and the previous state of
this SMT domain was sd_has_icpus, should we not immediately clear this
core's cpumask from the LLCs icpus mask? What is the need for the
intermediate sd_may_idle state transition between sd_has_icpus and
sd_is_busy in this case ?



> +		if (sd_smt_shared->state == sd_has_icpus) {
> +			new = sd_may_idle;
> +			goto update;
> +		}
> +
> +		/*
> +		 * If the false positive issue has already been
> +		 * there for a while, a correction of the filter
> +		 * is needed.
> +		 */
>  	}
>  
>  	sd_update_icpus(this, sds->idle_cpu);
                              ^^^^^^^^^^^^^^

I think you meant to use icpu here ?  sds->idle_cpu == -1 in the case
when new == sd_may_idle. Which will end up clearing this core's
cpumask from this LLC's icpus mask. This defeats the
"allow-false-positive" heuristic.




> +update:
>  	sd_smt_shared->state = new;
>  out:
>  	xchg(&sd_smt_shared->updating, 0);
> -- 
> 2.31.1
>

--
Thanks and Regards
gautham.
