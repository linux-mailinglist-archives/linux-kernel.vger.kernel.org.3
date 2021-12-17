Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6047951A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhLQTy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:54:57 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:30016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229887AbhLQTy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrpoP8nCRLVGyAYcATdtRpeCBX2hodsLtugtX4AVT9RgxPXLmfV+MUS5QnNsM37MIwbR59PUDnkWlqh+TgOCHKKRLaBKKagZ3hZosPVw1/dYcbxEbj/nD/GcEnKaCCiQd1kPELAIdDVrdYWFhKO6VpCMQH+d9MpP28kVO0Ujq5jNzf2WZmFzOaBrr6uVBbJKd4f23fEn2WKHdQDeC00OkvQjYv8urUdPjm2+N+QxR9OGgAkt8YRngdgYZ0/BeTZMvORIM1FrYN6FQb1d/N6cWexM9cL8Nc7N3tDjNl2sV+GGCLHgh0HB30f4q5KjHl76rH7M5+QHP7TM0Qt54IieVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEeN5GeVN2FjKsirI7MjWnNgLwiyT7uI/7AdnUy/2UY=;
 b=ivArZEwVOMpi9FmR5nkigkKA/b4Kns6sIr9Cbbdvbh31V2T79KcrBC3SRdo2jVt92TTclr9IgeQxAIRWSt+5nNDD8HUBcHG8hEx+HC/LU5BYONCCpOynTAsBDOQOqkrF+Ec35eRcxaXcdQojrEBTBhKc4zOtFp6PfAA21DHn750jed1UrsDX5fqXFzpR61s2xdSiBZqeTas3pZqjgfuur6HGlNfHsAF2Jb4k8ip//WMuituClRDwzpaIwIV+aP3QYn7N/NynUg+MgAvzramN5YhoYPpfp81Zn+ei+C9snODbL7kUHLLEFVKPf+DKEGFxHjBAAhUwGuAoysO+BUPLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEeN5GeVN2FjKsirI7MjWnNgLwiyT7uI/7AdnUy/2UY=;
 b=VHV4uXul3B0vF1WB0K56KbvyGuwmIYTnQUzTiwWZ7XmldhFslX/rrFyZ79xnlzFmY9Sv8M0MTIb8+IpEqY3agT277Og4axal+5zVTJOk5509Ebz9uyXW83829V/zrXIyJe3w4RD2P6GCLYshXPd9aE0Fa//gTxqkMcTXXcs3538=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 19:54:53 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%6]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 19:54:53 +0000
Date:   Sat, 18 Dec 2021 01:24:36 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <Ybzq/A+HS/GxGYha@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210093307.31701-3-mgorman@techsingularity.net>
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b57e52c-cafc-455b-599c-08d9c1971724
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB291875382A138105371CE8FF96789@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDLI13KyV+2v0ysBDUBiRf7BslhfIgo/CQO/3kOUGuKv/MN/bNjJh0MixSo7FgYFC0RjqgfEsPzR+0Iuf/WytSIM0L+mjy6r2UDA21GURDnqN6UQt16e1V1U5IqdYC3BnGsua509XEWxa25PDvbqEydDZhX6Y8lF2wxEz5gW51x8Oa/6wuDtVXK3nxnthipW4juQupHvvoWo5qauNth/m+KMWOp4icNmevFKD50MqcbaxOMhO+Xyp/AqwOTXLTpdk7lzz+Y+WabGrtdOfD7ShP1Py7P93Yn0zorVMWjYXqwhzEh38esvdQotjyuuvGeocywnrA66/8x4eE5EWBNfFd2+6+2FCOXSDNL8+2b7IvnN/GKy+yxcCpk9mZmC7MbJGhsIPf6tBAFbq26s9XoR5kaasdPy+PwTgjnOSqc3VKA4jmiEsjLrQbAvXKBXrXFFXJFaPM7RAX2y186YYQZsdWN/Vzrq3N1ANcdfsHVJ9LpdjwfecoACmMjuY945UgGnuxnXo6CgKutzpk+u8dh7ybp04c8VhGeMCdcnH8QDj+3zwpbnLlx8pOdlIIHKS433R3XW5un8ey+XgliJjBSOHz9uGQkkvASpK87+HF/0d2DG1RHsS+xhFC4xm17V0fq29w/STWchsctaYNdD2xMANQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(186003)(508600001)(6506007)(2906002)(54906003)(26005)(5660300002)(6512007)(6486002)(6916009)(8936002)(8676002)(38100700002)(86362001)(66946007)(66476007)(7416002)(4326008)(6666004)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Km35pzcTbVBzJG7wqe9PIp40vwNF5SPMgNl0MIcoBh46H7j6zlAHncSxkOPP?=
 =?us-ascii?Q?jiHeY3tOIIKgJ0I8P2SPiXYElz5T4qBAIJ+QfaDweYXsdUD/IluDPoXnT1tS?=
 =?us-ascii?Q?uf/xD6jKLL+TPsFqr8Q3s5qX+tl6GT1c2Hd5HfrBjKKSaODqN861kW8aYfgX?=
 =?us-ascii?Q?a7x1I9EjK2jdeXIh/rHlX+9aTjKWuJQMZh/uphZIysA6B0QCfG6sWZT7bKgN?=
 =?us-ascii?Q?yuDJRb1xbNXuxwE0HtdqRloDLNO8BSewbWCJpwgRArHxHuCxpNSeMEKNbbLY?=
 =?us-ascii?Q?Z4Iw8SkvojnsWsxbu67x3rPc+/mmo83gX2QNMuHGc4ZQNn4dUiOVkFR4H510?=
 =?us-ascii?Q?whIiUWhMEtUh9eRs136L7Ic8kdBYXCtwElNPa00599kCbPHM9Xe9ip/KZDoy?=
 =?us-ascii?Q?iNQdmnHaIUgiVd1msQtLexe3Potp3NqfEA0qSpjJl5ceC188i9y6Yi658+At?=
 =?us-ascii?Q?299eHUaXPjNhFzW5PApXkBYiRdicnQyFAQsponooLnroTKGmo0eVV0hBLKHk?=
 =?us-ascii?Q?EeONWsygl1k4VCzbaD+4xsKo3WGXZ0TsQNaSZYRR24nBkdCOwT7FMNApU/T6?=
 =?us-ascii?Q?QyUyF87pQft7OH2D7+C03hGcRDqd1M4dtsKx1cSHsG4o1gXOhWlk09xhq0ZM?=
 =?us-ascii?Q?Kl4D8uNtZGeNMRRK8Zb4MxYNtgHoeXJiZdc+ZpNK5f+L/3PNdU1ueJTKfm6T?=
 =?us-ascii?Q?wKZ/dAzvJaEQy9f/yiDkiIeIrxVU0VdFuPIHTs08NVrM9SK31IaO2yDWoSA+?=
 =?us-ascii?Q?dsotM5bcCvzuVHYvjyesjLZ1OzKkzuhAWTCmBDbBM/V7VLq0WZ7oUeVRIojG?=
 =?us-ascii?Q?qpPVFdEMi3L0JzS5YTv0vgGyiH8dvk0sF1bKnew9aArMrH+hHFWrjOvXZEtH?=
 =?us-ascii?Q?XjKUpuEwPmNxF0If5rXzFZI9RplIamB89ocC7j+FRXhXH0lULCzpwMjDN9+2?=
 =?us-ascii?Q?buURZ0Rf/gNHtQWsqNIxX01EUX3cCtrQfFB2GK54kZwvHo4WnbQAhIKdMIEh?=
 =?us-ascii?Q?DOJ71DWMzt3IuwTc8QnH9qVD0TcGe3VoFZcoGW35nEIlXkwqw/D90UH1WlQc?=
 =?us-ascii?Q?Q9Gld6C/QyB/02urgMfPIugQih7ZfUY6dqY2M8m1T/4w5gbJq4V/1X3O72MY?=
 =?us-ascii?Q?JLBm0uplhrNcFy4CaiAn0MkWrWKku/GX1bjHsgY2XyAoImOweOBW0KBZbbdL?=
 =?us-ascii?Q?Pbu9wQIRfRWr5gaEZ4iLUKZqKDh6hipFoPUq4FiB6pkfjVi3owaGcvMWuOfu?=
 =?us-ascii?Q?uPdrJTR0i6WD9uFDpW0aXsnHLihkwamUcxuVPI7fb7/K1FGeveWR4yvpb2Z3?=
 =?us-ascii?Q?rJWfwrbeFSQbpeVafR3fSWBH0HLXDAWHhmCuWGx0fHVa0EFxt4//u9IdrwWH?=
 =?us-ascii?Q?ppF3P/vnWwMKqmqddNNdXmrzNI79QkrwM28MV3raiiLhF3BFgqTYNdBJ7pc+?=
 =?us-ascii?Q?+WYttX+bud2bAQig9y8sKxrugM0E0TMCywD7k1XUiqilrpLZuCHQJHJSvN/T?=
 =?us-ascii?Q?3yjAxFMBgQkNMollYYItffeMW0EBKUAf8nSnmee05zIxqcQ2U7/8enOQk5ol?=
 =?us-ascii?Q?NRAJ2roHCwH0SE9oIqBdrByLLtF6QbgE1Z/XH+Yj3+SEQS1ZlXzNuBjCRQOL?=
 =?us-ascii?Q?rfR74MWx2D/nVz2wbDmRn0I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b57e52c-cafc-455b-599c-08d9c1971724
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 19:54:52.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6zGXCiNlnpnq5WHzsRKNW6nVLH0evw5auVqfQq50hxf/FISp4VudfWLRWrfWw+z4qVnuvTzoVNZaFq0SGfxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:33:07AM +0000, Mel Gorman wrote:
[..snip..]

> @@ -9186,12 +9191,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  				return idlest;
>  #endif
>  			/*
> -			 * Otherwise, keep the task on this node to stay close
> -			 * its wakeup source and improve locality. If there is
> -			 * a real need of migration, periodic load balance will
> -			 * take care of it.
> +			 * Otherwise, keep the task on this node to stay local
> +			 * to its wakeup source if the number of running tasks
> +			 * are below the allowed imbalance. If there is a real
> +			 * need of migration, periodic load balance will take
> +			 * care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +			if (local_sgs.sum_nr_running <= sd->imb_numa_nr)
>  				return NULL;

Considering the fact that we want to check whether or not the
imb_numa_nr threshold is going to be crossed if we let the new task
stay local, this should be

      	      	    	if (local_sgs.sum_nr_running + 1 <= sd->imb_numa_nr)
			   	return NULL;



Without this change, on a Zen3 configured with Nodes Per Socket
(NPS)=4, the lower NUMA domain with sd->imb_numa_nr = 2, has 4 groups
(each group corresponds to a NODE sched-domain), when we run stream
with 8 threads, we see 3 of them being initially placed in the local
group and the remaining 5 distributed across the other 4 groups. None
of these 3 tasks will never get migrated to any of the other 3 groups,
because those others have at least one task.

Eg:

PID 157811 : timestamp 108921.267293 : first placed in NODE 1
PID 157812 : timestamp 108921.269877 : first placed in NODE 1
PID 157813 : timestamp 108921.269921 : first placed in NODE 1
PID 157814 : timestamp 108921.270007 : first placed in NODE 2
PID 157815 : timestamp 108921.270065 : first placed in NODE 3
PID 157816 : timestamp 108921.270118 : first placed in NODE 0
PID 157817 : timestamp 108921.270168 : first placed in NODE 2
PID 157818 : timestamp 108921.270216 : first placed in NODE 3

With the fix mentioned above, we see the 8 threads uniformly
distributed across the 4 groups.

PID 7500 : timestamp 436.156429 : first placed in     NODE   1
PID 7501 : timestamp 436.159058 : first placed in     NODE   1
PID 7502 : timestamp 436.159106 : first placed in     NODE   2
PID 7503 : timestamp 436.159173 : first placed in     NODE   3
PID 7504 : timestamp 436.159219 : first placed in     NODE   0
PID 7505 : timestamp 436.159263 : first placed in     NODE   2
PID 7506 : timestamp 436.159305 : first placed in     NODE   3
PID 7507 : timestamp 436.159348 : first placed in     NODE   0


--
Thanks and Regards
gautham.
