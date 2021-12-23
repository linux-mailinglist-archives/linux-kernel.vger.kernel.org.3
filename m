Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32D47E495
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbhLWOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:40:14 -0500
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:7287
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232183AbhLWOkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:40:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZSoIMnKidb3ibjXtAyy+3v7sauDncr77OHRSORJbZX1c6HNTyZyHZKrr43E9NNBnAKRQQmzMvEclvin0sui5KU3TXKwyDfzAZB9Qi9osd9UroSPMeUbQnh9TiSDEMHE/ADzBryzYihnQi7cdhjTj1gaYXrsH3wgmIpaBirXVQw3GcWuEGeTdtnhpXXI80XWqHm9lLvIyo4wG6W9DJ0pG5s4FebdT2sYqPTCMQ9GusHqKqOOjR4tKQ972z17kN/e88IVYpoKmX1zeeQ1TYmrviis5Ns5Pk0YXUtyf1I2+TwPs0jnPoZQSteQiH5EMikPQnrvf6iTjxFvlGxo/g2e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV8IK+oXs7rHdBbkAe8Yr/piV3dxzGMe9FEIA8u26LI=;
 b=fgNAZu0z/gWoXTQWu6h71Dn9mBkMQbNteRuuthqzl9rj9P2Ocz7WbDeZdeoX/Yb4TED5NrfYfXVrcCJ6uf3WtptE7FAlhgdWcAY7qDZeWS7hL/oFXO1HM+1SAXP1zjbDf+uuLkZJzLXq47gG2+Ibffbxopc3hh8hYSxt7WRqHVGsDq9+mUqLQoixIuGC3A5igGlw6CkMT62iwlIVCQIgxJqsXIPaKX+OlLg2NVJpUUBb+69AhPk+weqfnwDtzf3K0MUwFfPmkQ7w8nJ97Z4i2HlqVwjFcztLHJV5NMOtl72OspQ2JxN2FxiZJVFljnJqIJVzAHHkD67JYATBkuSaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV8IK+oXs7rHdBbkAe8Yr/piV3dxzGMe9FEIA8u26LI=;
 b=uAFTcHt1o0QUXSo3aG9e7IwXbhHh9BqVUgNK2CxqjBa4KOnfbzGlwZHD4o2KHug01bJ9750Xun2jXVL86CMVOJDhFvutSaVafz1n4fp4+KbznTl7j5UdGPCYnGPHETX/p1LVVQwrhMfl+rWFcaW1oDSclKo7++IDcRw4/5S/8+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 14:40:08 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 14:40:08 +0000
Date:   Thu, 23 Dec 2021 20:09:46 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_cluster API
Message-ID: <YcSKMsCysRtHz1aC@BLR-5CG11610CF.amd.com>
References: <20211215041149.73171-1-yangyicong@hisilicon.com>
 <20211215041149.73171-2-yangyicong@hisilicon.com>
 <YcL80lUZi4f9zqjB@BLR-5CG11610CF.amd.com>
 <CAGsJ_4y_G74f1KEze__i_1qFOF30DMWaD=R3ww8rvvRMHvPELA@mail.gmail.com>
 <CAKfTPtDmwAFBYXdkiSdEdQx=H5t_hK9w5tRvSexBAMdVVD3ydQ@mail.gmail.com>
 <CAKfTPtBKLDyNPXg7uLbQ3jUnEwppfC+E29=oJ1tWzzqHsNpApw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBKLDyNPXg7uLbQ3jUnEwppfC+E29=oJ1tWzzqHsNpApw@mail.gmail.com>
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ec6e70-ac10-4dad-4494-08d9c6221d81
X-MS-TrafficTypeDiagnostic: BY5PR12MB3777:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3777CE988EFF98C1E7D3ED74967E9@BY5PR12MB3777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmt8wiome2j3gsEphZ5DSz5TBlqVQD4MPBui717ioFlFNKGthisBiB+6+Y6EdGoBcKU8joCFfA3pUMy601c0wRIzOaHyi4FzCZs0keVg3Lpu+jzl3n0IasZj+RUHjMesXX5jNtVwDYYCbsqkFisGd1IHAXOCnhsEdvETPH/uylY5lm4P3QZT6qYEAROM5b6OslyKSCNJrh0wL8l04ieJa8O78bPXYP3UeaARQtkIy1j4p+3kfXfCUWmbFJmSxjxVkievDi2BSMJPSlgsQAaC7Iynj5gHQNhGZIG+o9M2h8RFj1jnlnJmNAbtzdqzxhTlu56bVj6sO/rOc4mMrzmt3BbEpjFBRxAaMo5vgLJZzNxfY+JUAi3L3AWFRvOUzfkn9BiOjPNKEbNWhAv6n3U79KpmiADw8OpgOkwqSCC2Kr52fS/XFnf4c/UK5PsyyuQrr54v+wEQ75p5T4ykvff0h7cCyLh8Zuq4obq1g+uC2QueKfOO2t6DQFsjtnEhESXIdIa/JUDPFAGU6dmlTfEetOPjCMGW/oHbUbFfTuCHp6kWiP2hdQIZNtF3m7qQaS6ffMWbzAdlrKItkMnYub6lUhhxDObC0k+91j+HNmIC2/cqRRFcXeng5yIZ1phFCbPX9GdQIvUamUu4jipmrqCnjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6486002)(2906002)(316002)(6916009)(5660300002)(83380400001)(38100700002)(6666004)(4326008)(8676002)(86362001)(66946007)(66476007)(66556008)(26005)(7416002)(54906003)(186003)(508600001)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4/ncqMC4KRok+p3JGcdbML2s7BwtW+aPWPlpf7JYwuTPTcCC7LmRmnYBu/a?=
 =?us-ascii?Q?mNIx7FN5uhJIkcvTMJ1stln5FLRppUXYFur9xha/n6ziqIRTx0i4CovmPTFf?=
 =?us-ascii?Q?oG/G60U6BnoWNS8osM/SAfZMmzsqywV3qqzjIAMYB2sosUwcRg4/0TqEuBr5?=
 =?us-ascii?Q?A5/iacpKmFf3Al5WX/1WtVcjJyqMxxDZhTPsviJyeTLEZ5pM1nIlmhkd3PbL?=
 =?us-ascii?Q?eViE8gBVDzBod6uLMag44DqiEw0ABQG2s8BUtYuJ/VquASrmwyGDp0iQT/sQ?=
 =?us-ascii?Q?fsbilnyT0bUKihT1awhxvtR8zOzJ8g0wJwyPOWSqT7IA9h/qxwlL3YvlSO36?=
 =?us-ascii?Q?tqOYRvHQFLNpwMxBygzyvNZkRy5vvHWR0mcnPJaBAIgQjUZSkRpUC+mkwjYh?=
 =?us-ascii?Q?x+eLnSTy4i3e8ivMDFsAW29yHyy2CdmmUYA3Tqd5sV2MsmHyspC46yISSR2i?=
 =?us-ascii?Q?N4WXfr4Aa6HPUbUI3RdEev1UW6Zc7ipU0q7DkF5IDFzrOzNPob7JCtW4TG3U?=
 =?us-ascii?Q?4k5MvxzoQN+5qGzcDASOBrmUba6iW6mlq3iVIgcGewvS7njNm7jX3eNTeaYl?=
 =?us-ascii?Q?CUy1IvCSq/cZyO5zPuiJgfPiGKUyTbl7GJcwgV++C5CVdGPIGnROjlLg4Jmt?=
 =?us-ascii?Q?F1OrNkhDPtyNNDxuNyzpRNlFoRr8Fq049AvqlZv32qqtg9CFBwqfX0RYfo1r?=
 =?us-ascii?Q?4cJZj/3PwQAC01I/6bF5qyWJ3YK15xHTSC63rZgrS+finRxV7dNbKQapxrSE?=
 =?us-ascii?Q?nJaxJyNKRCO1PO5Z5CDJQ36WF2sW87EGUoOhaRQX6TyJ5K66yO93uNOCzKPr?=
 =?us-ascii?Q?tq6CdagyDC3/nZvpSJeL/6d6KrwErS+01Wql7icH5nwEwJ3pupcaHbr0s8ue?=
 =?us-ascii?Q?b7ptaLNg2bo500jKh+MGpV3+QeXTw6gC/RhsTRrHn4CgBhqCN9/4TjgxJd/r?=
 =?us-ascii?Q?Abr7Fhb1PSKELiuDG/EuD+yokQlf6F47y14znaNcNbJ8UAXOBmQvEFizoPwc?=
 =?us-ascii?Q?YSdDPIJQ1qMvSOh2bb163NK9DyYJZwq92yYU1XMJdnIFZ8RuAdZX1R2GYXPQ?=
 =?us-ascii?Q?5d3B103KSSvn20GmpMivLnGkgqIfYK7VAkhq+wfA4vt8FMN2rhnVhoFx4QBl?=
 =?us-ascii?Q?sd5TLCZ7PtfMNTcau3K3qqpmD8ktkK3+4M9u4rdK8Vl/czZELgdg0Tep6Crz?=
 =?us-ascii?Q?j7e7uCzQ5MXjXWkOJfWLKkJe9n8P6CMuGs1og9be5ObK1KhxCw9oKx+qEvZo?=
 =?us-ascii?Q?RVbnBgJzCsrfa3kY1k0uVROEY/l8w9KgmYCihmSphRILa44NMV+BI2BtzdHR?=
 =?us-ascii?Q?SxYCZMmiFUYI6kq44Bt3FYbwQxACH2uxJO7LLdcW06Pc2fklSryj/hFGc1D2?=
 =?us-ascii?Q?RhGKPtArCwcJiN9bXNrnAi0EFMJn1xn5jy9amYjA22rC0YmGdUvpsfaEe9NN?=
 =?us-ascii?Q?tSTdSzbh1TNpm1K0pK9otPiOYkmiqFJ475Ms3UxPHGiNqe51KLIOCYbd5XRv?=
 =?us-ascii?Q?RRbwbDlKoprZla+kZBqa45/um1db2x/fR/Hizd/mGIGmSeFjfsWeKuksDCWc?=
 =?us-ascii?Q?rSwFdmetd+XKaLDE6RVFo+/rKUPgB8hisX1EfTlm/k54idKnJ0uBUNvN56JL?=
 =?us-ascii?Q?W0e7ofJRyRRydfnQ/ySdC/Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec6e70-ac10-4dad-4494-08d9c6221d81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 14:40:08.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SDPQrzE0iTBzQ8/MsASUQjnOyjWp0FWwbfJ8n1v0G7Ux369oP3UY3lao5pjj2PFXJEqu/ClgxbGircGBFmVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent, Barry,

On Wed, Dec 22, 2021 at 02:33:37PM +0100, Vincent Guittot wrote:
> On Wed, 22 Dec 2021 at 14:14, Vincent Guittot
[..snip..]

> > > > > @@ -669,6 +671,12 @@ static void update_top_cache_domain(int cpu)
> > > > >       per_cpu(sd_llc_id, cpu) = id;
> > > > >       rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> > > > >
> > > > > +     sd = lowest_flag_domain(cpu, SD_CLUSTER);
> > > > > +     if (sd)
> > > > > +             id = cpumask_first(sched_domain_span(sd));
> > > > > +     rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
> > > > > +     per_cpu(sd_cluster_id, cpu) = id;
> > > > > +
> >
> > This deserves a large comment to highlight that the new code above is
> > not self contained and  relies on the fact that it is done just after
> > looking for LLC and sd and that id and sd must not be changed in
> > between inorder to ensures that per_cpu(sd_cluster_id, cpu) equals
> > per_cpu(sd_llc_id, cpu) if there is no domain with SD_CLUSTER.
> >
> > and per_cpu(sd_cluster_id, cpu) might not be cluster but llc
> 
> Maybe you should not name this sd_cluster_id at all but
> per_cpu(sd_share_id, cpu) = id;
> 
> Then you have a function named
> 
> +bool cpus_share_resources(int this_cpu, int that_cpu)
> +{
> +     if (this_cpu == that_cpu)
> +             return true;
> +
> +     return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
> +}
> +
> which returns true when cpu shares resources which can be LLC or cluster

+1. This would make it more readable than overloading the meaning of cluster itself.

--
Thanks and Regards
gautham.
