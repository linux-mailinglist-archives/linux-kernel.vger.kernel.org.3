Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BEA5A0A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiHYHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiHYHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:30:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8099B57
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfg0zph+Dv7TxWKbUBuo3q+auX78BWfTsFifNw6Kv/DQvLdzB5Pt/JZ2drn5S06nWhbSl6BJJYqjbW/jnCwHdOXtkemjSkD0vmyzdCQc5n64BGeJNCU3LUi29mHuG9HMVH7PXLDh9O49T4nSWIr1C8+qU9/6wvTWvnPS74VyrP8EcVy3Hfh5zLjSSDfpyA/zua53A7Gxpti1MjTeKYjg3Ipr+WPH+AV0WZlxwTK/xlh3qiQX06J5CcLrKJNBiRKoJj1mXCFkkcsRlOs8LssF9CnUI8Nxl/ibALLmC1xAiDORqY1hRUsaXmB3DtV9l3/HMlvEUA6HoWlto/A2Ihui6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlVi8VYa/fqAVdP/k9Evx1hKt+htwdCfnxyS8Mo08e0=;
 b=HP7SNoXm66EQeBKF+QYHKsd3jLWPLiU7x7jNhHRGuWiMJ1x8+az4pK7oIM5IyUry4/qrCj2DaV5NjPNAVEv5DmSyE7Zz8n2ULiA2ZKLOV7IHElrYIvqV9gQvF0Ygw1g1oDuTndNY55uyjkVVF1wN1U8dCys9OAfzHwiVmIyL/SggFEAae+YDtwIQ5tut3AymIKxYhUVV0bps1hQpy9JB1ZdnSgsT99KHVqIj9nk57xqC7QFM0wPtLvlzeR7yLpQ0/1FmMCPiqfMOnflwKMcRDRHTuysov3z5crReoG4PFzOpizv2ywY/GHrEwEIC8ZzShuXSFR3kq5AIbhgI3NWAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlVi8VYa/fqAVdP/k9Evx1hKt+htwdCfnxyS8Mo08e0=;
 b=k10mRPPRDlMhd5Ycy1XUXyhT6WN+GodBWgkziwpjGzah5t3ltE0XWd+/DSTmDgsmBq8iK/1qwyBD4EQDX9Rf34DDrT9GO4J47OaShAplSIdRUdbW3f8hyKlKSjqbcoVim9HX3YN+FRasK1hx1wSd0PTHXLZE+ZTqa3a51POceK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 07:30:18 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::54a6:6755:c7d4:4247%4]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 07:30:16 +0000
Date:   Thu, 25 Aug 2022 13:00:03 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Libo Chen <libo.chen@oracle.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Message-ID: <Ywck+3E0DyNdUJRE@BLR-5CG11610CF.amd.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810223313.386614-1-libo.chen@oracle.com>
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae578ffc-c960-476c-94e0-08da866ba7c7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKmpzcTf9MyixWEnpd8kvn/k/reulcb+okUklFGjOf9i1ItJdDlBg6zaV6nO7sGDNpgP3ek4zyigD6zuOO1xEyhwGy6BAZqi56avNPWcbI9RSsGE09IPgWj9b4l8lNZeakgJpKwJcT96YvIUPMfpe2WogkTI619lgvzmutNZ1a2DndmnUgkaHnI3qKAhNw/5uEgCGilNMu+yEueVxAr9P6+dSyJrSjtoYvA9bXq2cYkv1Iw8pTcZIQHw7Etp3dbrr0JLdE7DoASHhkN4exCXgCAwiQ+G+sxnobnbIkPUghIiy1JhuYy8Gen/meXOLWXaB5NOrTN0rS+lQSUNszChmvn1oxYbs2hZENJX6fUsPJtWWmWBjU7BhhxTJvxa950LZTh1KVkWDglKU7Gc2Qddu8ECZtkGPtBdj7DRzzeD1M+gIE6oxPU8W9/Sf6z0/ib2wEja0vAakItDOTqG5v9PJ1JXWfAfq18/NIxgd4MR3E8Z3oGdtHt/gGYl+FdBUfpyhKBTaAVuS8EYzSOy1BQf2ptlBFeeSR0adv+3mjhGxfovyEczeoXdU+jD/Ee44nhSHhOjmHs9p82qxkTkmOgiY+muE674FUjfkNHdZlmVHVerl4imBUG+7WMdIczSfm5iQs1hAnboRg+c4PLIhh5q/D8FmBYgsu7YvEjvcdrgY8hlQoc0piZQkDb3ZL0sPsZBgOZ0k0CF9EGcY/N4RapL95dKnUV78/OR+fn1qYopqusFrqr9TTXMpo26Z2mDCA7K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(316002)(4326008)(8676002)(66946007)(66556008)(66476007)(86362001)(186003)(6916009)(38100700002)(41300700001)(6666004)(6506007)(26005)(6512007)(6486002)(478600001)(2906002)(5660300002)(8936002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eq9CAw3JXfalbfp2zf5BAxduB4+fjjkT66kqAKWjlh280+XzNhGF1slN+FNK?=
 =?us-ascii?Q?uoyhMJqJnY0WfCh+fq7g/shlSdsob+ILxZIApmSk5owmHNZBYZFSsUJB9n7x?=
 =?us-ascii?Q?GJWKcLBgFhgv+vVBxnWr7KcoqTecRyRu6vwD9EQ+sqpCCU4FWbQxttGm0M9h?=
 =?us-ascii?Q?N6JfLtlDENbeaaQbnBrae7UP6I2IAN+EULr6UZQXxU6yn6lNrQb6MO9Necsz?=
 =?us-ascii?Q?cy3b6ZXcjdU6RmXTK35FphPGK+OCMt5z4dy15DHjN0TYGSowTU9qSb04pzas?=
 =?us-ascii?Q?MPMAm7wzt81z0xA5CzMWqwuNXH5w3GH48qSAMboCD/GZQZSRv+rRCvBM7Bdx?=
 =?us-ascii?Q?orZn/pNQrfdClmQRxkf6cH8uYv4PUqO/j/b2bpO4H5L63f/BkHAJFYSsuLca?=
 =?us-ascii?Q?eoY/WI30hQXlln6IIoq6azl6gwOhC1N3ZjtqjkHAGLjjzvglGSHiZMNsGJRQ?=
 =?us-ascii?Q?oyKCAWLHqMapVEsL+k6vkXSIr+ZopvvPn00nIMnqFjnXCwqJzb1GiTsUMuPq?=
 =?us-ascii?Q?P4DOfnI61QUyW/VPIL9vm+DdfDwgXBoGv3rql+/vr6KvEZPTFsdkVFdAjZSY?=
 =?us-ascii?Q?0Q3hxk2aSFl73yUMp190FmhD2pOvF9P5XZlrhh8wGXu8Eq/piJNlDQwwHS75?=
 =?us-ascii?Q?lRsCXYtkcrRMqygAu0/TztG9qcMHHUe6RyXYjce2UhINkrTC+yliMJQJBC0d?=
 =?us-ascii?Q?1Q9SCw/GbsT6oHorVPfHrbLu0K15b5I80nkYZMO92qjPhySk0nQZbqGdSDIr?=
 =?us-ascii?Q?c9Z6OHGWM2ubeyYurhNfSaoijLGhGB3fCcOBEsalPZJ+M0jQyWv3xclRL8KR?=
 =?us-ascii?Q?CF1T3woYKV4PPyXV2QXIBjhTrTduyl1HeE40aqUoX7YZN/CKn802P9WIzNvt?=
 =?us-ascii?Q?zHU8Lc+VsmELpyDobUBEEUhbiMzQr9iieILFhtULEDUkF/MbMBaAubHVcJ8j?=
 =?us-ascii?Q?8U51jV6tHYb/7BKMzL/vU0Z6TlKYjeJsmJT+RHFn73NYGwtOKrR6/PCgeUHu?=
 =?us-ascii?Q?5N0sl+G95bdcge0yPEG3q+YUB3Hkl0Vj7mM/i4klctjTM8x9rEgkcoE7ka8o?=
 =?us-ascii?Q?DPUuw9e3Mtgms+Meq5SO6TVYD3lPwJPCPi2aMUKXTVL3AxuyP35+h/9HqE5N?=
 =?us-ascii?Q?Xyd0dykc1HEtp3PxQvhFnOzhc456xn1AwaAfAmLMpLzhIdi4E5EYVJRdkScr?=
 =?us-ascii?Q?Juv8QEhS5wRZA6Td07FgYwsjaBK0WIou1EGrcyaMPy3t0XKyHqf+E7nvnBbP?=
 =?us-ascii?Q?zdda2KEsm2LLFUUM+psngyOmSsO+5UUfAHmiw7vCFK7Cnw5VTrl2CwVMqDee?=
 =?us-ascii?Q?9Je0C8Ra6NgzQ1XT91UztQNrUC2Cu97pFUqVYIhcursRWDJImaK5xlSMX2M5?=
 =?us-ascii?Q?YxhB8tY+bvYUTUUS/lp8kS6ZiTypucNny4suIZDxcuBlGwqpwb7UYObuGt5Q?=
 =?us-ascii?Q?T01IlfbtckIq3c/jxd9WsHT+qSMHH4NuWUZVI7FOwrtT3Xmdd4FVfont2uKd?=
 =?us-ascii?Q?KDA2Sm27Xpc9xEfjT1+9mXZyYKk2weflOp2GsSPnr9+UiVKpspBxh905Sa2e?=
 =?us-ascii?Q?nA4XYAmHdMUrunrEygcgdbjOCy4dQa5dZoHd1eiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae578ffc-c960-476c-94e0-08da866ba7c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 07:30:16.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/Ikk+ZAZTm3PE6T/WXLJTEmYrkmCj1GWHsNNtZpNkrrz4sWFsE7AMJPyEcsHti0W9BvNZ9zpYgLgg2vKG7f0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
> There are scenarios where non-affine wakeups are incorrectly counted as
> affine wakeups by schedstats.
> 
> When wake_affine_idle() returns prev_cpu which doesn't equal to
> nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
> in wake_affine() and be counted as if target == this_cpu in schedstats.
> 
> Replace target == nr_cpumask_bits with target != this_cpu to make sure
> affine wakeups are accurately tallied.
> 
> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da388657d5ac..b179da4f8105 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>  
>  	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
> -	if (target == nr_cpumask_bits)
> +	if (target != this_cpu)
>  		return prev_cpu;


This seems to be the right thing to do. However,..

if this_cpu and prev_cpu were in the same LLC and we pick prev_cpu,
technically is it still not an affine wakeup?


>  
>  	schedstat_inc(sd->ttwu_move_affine);
> -- 
> 2.31.1
>

--
Thanks and Regards
gautham.
