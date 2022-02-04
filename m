Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7C4A94A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352691AbiBDHeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:34:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232302AbiBDHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:34:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2143bvRP006656;
        Fri, 4 Feb 2022 07:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=UHDNs1wrqvVu14azFkNXA4EZ2VmaNN7Pxw8iym9ieoY=;
 b=ADhYGugVwtDTJ1NPtdV+GCHoNoVOk9XcHdBS9U262quqWvt1faWFELc892NJM3ht406v
 zvEdwxoCRiyU1JZtQwww37csFbCAo0XM9gn/JVeZCOrxnqYOdlr9vrE8Hko0dLgAaRcN
 0Xo88bYlb+Z/BjBlJl7gRVqgrudHCnjSonrYtEOW2aue/sjnbaUsARaasEpI2WZR3iWR
 y6mn5VjR5+IQXkSqDNUvJYTiUeGIQiChjJyMf3O0KA/SuNA+MejjcP49kVtTx/SO7+T4
 lsb2PJ8wYB38HvsupDTF+MBxsjLQO8c0vmtW5lizhBPPe0dnyLJfKKUKAU4fXsRVTDrb kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0fcsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:33:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2147ETk4001431;
        Fri, 4 Feb 2022 07:33:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx0fcr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:33:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2147RK8U015280;
        Fri, 4 Feb 2022 07:33:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e0r0u2712-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 07:33:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2147XMvU27263336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 07:33:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84BC0AE051;
        Fri,  4 Feb 2022 07:33:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389B9AE055;
        Fri,  4 Feb 2022 07:33:18 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  4 Feb 2022 07:33:18 +0000 (GMT)
Date:   Fri, 4 Feb 2022 13:03:17 +0530
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
Message-ID: <20220204073317.GG618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com>
 <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com>
 <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com>
 <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iiW6K_j8QyEpGA4PtSkUAgxuNgDr9QT5
X-Proofpoint-ORIG-GUID: NjYi9HlZBDXiu7voHv_wIXhgNWBjg2tA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:

> On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> >
> > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > <srikar@linux.vnet.ibm.com> wrote:
> > > >
> > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > >
> > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > <gautham.shenoy@amd.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > >
> > > I am sorry I didn't get your question. Currently the code works as below:
> > > if task A wakes up task B, and task A is in LLC0 and task B is in LLC1.
> > > we will scan the cluster of A before scanning the whole LLC0, in this case,
> > > cluster of A is the closest sibling, so it is the better choice than other CPUs
> > > which are in LLC0 but not in the cluster of A.
> >
> > Yes, this is right.
> >
> > > But we do scan all cpus of LLC0
> > > afterwards if we fail to find an idle CPU in the cluster.
> >
> > However my reading of the patch, before we can scan other clusters within
> > the LLC (aka LLC0), we have a check in scan cluster which says
> >
> >         /* Don't ping-pong tasks in and out cluster frequently */
> >         if (cpus_share_resources(target, prev_cpu))
> >            return target;
> >
> > My reading of this is, ignore other clusters (at this point, we know there
> > are no idle CPUs in this cluster. We don't know if there are idle cpus in
> > them or not) if the previous CPU and target CPU happen to be from the same
> > cluster. This effectively means we are given preference to cache over idle
> > CPU.
> 
> Note we only ignore other cluster while prev_cpu and target are in same
> cluster. if the condition is false, we are not ignoring other cpus. typically,
> if waker is the target, and wakee is the prev_cpu, that means if they are
> already in one cluster, we don't stupidly spread them in select_idle_cpu() path
> as benchmark shows we are losing. so, yes, we are giving preference to
> cache over CPU.

We already figured out that there are no idle CPUs in this cluster. So dont
we gain performance by picking a idle CPU/core in the neighbouring cluster.
If there are no idle CPU/core in the neighbouring cluster, then it does make
sense to fallback on the current cluster.

> 
> >
> > Or Am I still missing something?
> >
> > >
> > > After a while, if the cluster of A gets an idle CPU and pulls B into the
> > > cluster, we prefer not pushing B out of the cluster of A again though
> > > there might be an idle CPU outside. as benchmark shows getting an
> > > idle CPU out of the cluster of A doesn't bring performance improvement
> > > but performance decreases as B might be getting in and getting out
> > > the cluster of A very frequently, then cache coherence ping-pong.
> > >
> >
> > The counter argument can be that Task A and Task B are related and were
> > running on the same cluster. But Load balancer moved Task B to a different
> > cluster. Now this check may cause them to continue to run on two different
> > clusters, even though the underlying load balance issues may have changed.
> >
> > No?
> 
> LB is much slower than select_idle_cpu().  select_idle_cpu() can dynamically
> work afterwards. so it is always a dynamic balance and task migration.
> 
> >
> >
> > --
> > Thanks and Regards
> > Srikar Dronamraju
> 
> Thanks
> Barry

-- 
Thanks and Regards
Srikar Dronamraju
