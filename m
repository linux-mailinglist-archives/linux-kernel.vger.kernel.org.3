Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201849F42E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiA1HO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:14:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50456 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbiA1HO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:14:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S46DEL038220;
        Fri, 28 Jan 2022 07:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=OCcByMJ7JRwI3Zhq3AaB9P9tpF9uLjL1wO7PO/3K0h4=;
 b=FSOYwqzhGK4etDa0ZyjSP1vWkyENL6ZmQ9BRreY0qgM6YQevh3cgXLwiYXXx65XWEKQ/
 9KcsjN20LxN//C3tTPN8dxb3hrVOvsBUWxzvr2EiK/aCSvUI1wmdnEFlVQ3XA5Zb7oOk
 y7XTRz8ifus7Fcgx7EQjWKyaSCcTF0IXOKzc0039YhfjyPajnQzuhYTeySMP5uCix8Sd
 +FdWSFHOqc+CNbEzGdsUkAAEmwZRqeMseZkoEumBioPEvO0h8x4lI1zuyrWTrEN/kzqa
 Lpam+WyYhSRZEfquO9R3wiPyh9+GguHa4q/suRV4HGTSbVJfpwiIu7086IUh8gKBt8XA cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wf51a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 07:13:48 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S7BRF6005914;
        Fri, 28 Jan 2022 07:13:48 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wf50u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 07:13:48 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S797VC008788;
        Fri, 28 Jan 2022 07:13:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3dr9ja4a53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 07:13:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S7Dh1b34144596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:13:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E41A4C04A;
        Fri, 28 Jan 2022 07:13:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1234C040;
        Fri, 28 Jan 2022 07:13:38 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jan 2022 07:13:38 +0000 (GMT)
Date:   Fri, 28 Jan 2022 12:43:37 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <20220128071337.GC618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com>
 <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MihSKkaR4n9UlESlqiqQw5T2gT1h12LE
X-Proofpoint-GUID: 3XBkUE1canLGIGQVs5aoEcwUKJ0n_XSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:

> On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> <gautham.shenoy@amd.com> wrote:
> >
> > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > > From: Barry Song <song.bao.hua@hisilicon.com>
> > >
> > > For platforms having clusters like Kunpeng920, CPUs within the same
> > > cluster have lower latency when synchronizing and accessing shared
> > > resources like cache. Thus, this patch tries to find an idle cpu
> > > within the cluster of the target CPU before scanning the whole LLC
> > > to gain lower latency.
> > >
> > > Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this
> > > patch doesn't consider SMT for this moment.
> > >
> > > Testing has been done on Kunpeng920 by pinning tasks to one numa
> > > and two numa. On Kunpeng920, Each numa has 8 clusters and each
> > > cluster has 4 CPUs.
> > >
> > > With this patch, We noticed enhancement on tbench within one
> > > numa or cross two numa.
> > >
> > > On numa 0:
> > >                             5.17-rc1                patched
> > > Hmean     1        324.73 (   0.00%)      378.01 *  16.41%*
> > > Hmean     2        645.36 (   0.00%)      754.63 *  16.93%*
> > > Hmean     4       1302.09 (   0.00%)     1507.54 *  15.78%*
> > > Hmean     8       2612.03 (   0.00%)     2982.57 *  14.19%*
> > > Hmean     16      5307.12 (   0.00%)     5886.66 *  10.92%*
> > > Hmean     32      9354.22 (   0.00%)     9908.13 *   5.92%*
> > > Hmean     64      7240.35 (   0.00%)     7278.78 *   0.53%*
> > > Hmean     128     6186.40 (   0.00%)     6187.85 (   0.02%)
> > >
> > > On numa 0-1:
> > >                             5.17-rc1                patched
> > > Hmean     1        320.01 (   0.00%)      378.44 *  18.26%*
> > > Hmean     2        643.85 (   0.00%)      752.52 *  16.88%*
> > > Hmean     4       1287.36 (   0.00%)     1505.62 *  16.95%*
> > > Hmean     8       2564.60 (   0.00%)     2955.29 *  15.23%*
> > > Hmean     16      5195.69 (   0.00%)     5814.74 *  11.91%*
> > > Hmean     32      9769.16 (   0.00%)    10872.63 *  11.30%*
> > > Hmean     64     15952.50 (   0.00%)    17281.98 *   8.33%*
> > > Hmean     128    13113.77 (   0.00%)    13895.20 *   5.96%*
> > > Hmean     256    10997.59 (   0.00%)    11244.69 *   2.25%*
> > > Hmean     512    14623.60 (   0.00%)    15526.25 *   6.17%*
> > >
> > > This will also help to improve the MySQL. With MySQL server
> > > running on numa 0 and client running on numa 1, both QPS and
> > > latency is imporved on read-write case:
> > >                         5.17-rc1        patched
> > > QPS-16threads        143333.2633    145077.4033(+1.22%)
> > > QPS-24threads        195085.9367    202719.6133(+3.91%)
> > > QPS-32threads        241165.6867      249020.74(+3.26%)
> > > QPS-64threads        244586.8433    253387.7567(+3.60%)
> > > avg-lat-16threads           2.23           2.19(+1.19%)
> > > avg-lat-24threads           2.46           2.36(+3.79%)
> > > avg-lat-36threads           2.66           2.57(+3.26%)
> > > avg-lat-64threads           5.23           5.05(+3.44%)
> > >
> > > Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > ---
> > >  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 42 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 5146163bfabb..2f84a933aedd 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6262,12 +6262,46 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> > >
> > >  #endif /* CONFIG_SCHED_SMT */
> > >
> > > +#ifdef CONFIG_SCHED_CLUSTER
> > > +/*
> > > + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> > > + */
> > > +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> > > +{
> > > +     struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > > +     struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> > > +     int cpu, idle_cpu;
> > > +
> > > +     /* TODO: Support SMT case while a machine with both cluster and SMT born */
> > > +     if (!sched_smt_active() && sd) {
> > > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > > +                     idle_cpu = __select_idle_cpu(cpu, p);
> > > +                     if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > > +                             return idle_cpu;
> > > +             }
> > > +
> > > +             /* Don't ping-pong tasks in and out cluster frequently */
> > > +             if (cpus_share_resources(target, prev_cpu))
> > > +                     return target;
> >
> > We reach here when there aren't any idle CPUs within the
> > cluster. However there might be idle CPUs in the MC domain. Is a busy
> > @target preferable to a potentially idle CPU within the larger domain
> > ?
> 
> Hi Gautham,
> 

Hi Barry,


> My benchmark showed some performance regression while load was medium or above
> if we grabbed idle cpu in and out the cluster. it turned out the
> regression disappeared if
> we blocked the ping-pong. so the logic here is that if we have scanned
> and found an
> idle cpu within the cluster before, we don't let the task jumping back
> and forth frequently
> as cache synchronization is higher cost. but the code still allows
> scanning out of the cluster
> if we haven't packed waker and wakee together yet.
> 

Like what Gautham said, should we choose the same cluster if we find that
there are no idle-cpus in the LLC? This way we avoid ping-pong if there are
no idle-cpus but we still pick an idle-cpu to a busy cpu?

> it might not be a universal win in all kinds of workload. we saw
> tbench, mysql benefit from
> the whole change. but pgbench seems not always. so we are still on the
> way to make possible
> further tuning here.
> 

> >
> >
> > --
> > Thanks and Regards
> > gautham.
> 
> Thanks
> Barry

-- 
Thanks and Regards
Srikar Dronamraju
