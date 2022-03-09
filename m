Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCA4D2C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiCIJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:44:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA21405FF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:43:52 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2297OacC007454;
        Wed, 9 Mar 2022 09:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=0xrZJ3hhJSYU8H8btUMOcHQ4xjx05w8m9CFoUXpogLY=;
 b=nQMjy4vfMjxzr602x/gp2Xj9LRf1YrulMXunUGG2Db6cn8zQ+mjdm6sLJbGv7tDNo+9i
 W+N9fZLLSKxlW6zhNnGpVCZ2fHWZ4Qkx5ETP9tWhC9Pd8Rrrfx4sNtaiHr8lflUOx9TH
 Tb1VBczhP2AAmjKRFSvPc2XePPZUe68DB3zwpm4eBWaQbYJw4vKrlXHFjFjpf/mjGWMM
 e40N1ldCR6JB2C9CIZCF4av2eSOzpghnoQqL+HaLfDBWuHUTMAFKOZffiZGLsTl967RE
 ScDYWKKuK5VUjHpS6DY9VUxH+xYIAfXmtj/XX8s8p1XhZjzYiQfu/8Q/SlYWcKjUyeB6 iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3env4uucmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:43:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2298EipB013786;
        Wed, 9 Mar 2022 09:43:29 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3env4uucke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:43:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2299ggIq006418;
        Wed, 9 Mar 2022 09:43:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3ekyg8g9v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:43:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2299hOET45678916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 09:43:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88FB652051;
        Wed,  9 Mar 2022 09:43:24 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C41045204E;
        Wed,  9 Mar 2022 09:43:21 +0000 (GMT)
Date:   Wed, 9 Mar 2022 15:13:20 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220309094320.GL618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
 <20220308092944.GJ618915@linux.vnet.ibm.com>
 <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
 <20220309052554.GK618915@linux.vnet.ibm.com>
 <bb443650-868a-49b7-e41e-c2a788781df5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bb443650-868a-49b7-e41e-c2a788781df5@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F_d2i3xt3f8CgZD4OzpR37ErkqQWFq23
X-Proofpoint-ORIG-GUID: o46rAGquczgeokd1M-WmjiNeO2FftCiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-09 12:42:51]:

Hi Prateek,

> Hello Srikar,
> 
> On 3/9/2022 10:55 AM, Srikar Dronamraju wrote:
> > * K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-08 17:18:16]:
> > [..snip..]
> >> Yes. We've tested stream with 8 and 16 stream threads on a Zen3 system
> >> with 16 LLCs and in both cases, with unbound runs, we've seen each
> >> Stream thread get a separate LLC and we didn't observe any stacking.
> > If the problem is only happening with pinned case, then it means that in the
> > in unpinned case, the load balancer is able to do the load balancing
> > correctly and quickly but for some reason may not be able to do the same in
> > pinned case. Without the patch, even in the unpinned case, the initial CPU
> > range is more less the same number of LLCs as the pinned. However its able
> > to spread better.
> The problem this patch is trying to solve is that of the initial placement
> of task when they are pinned to a subset of cpu in a way that number of
> allowed cpus in a NUMA domain is less than the imb_numa_nr.
> 

I completely understand your problem. The only missing piece is why is this
initial placement *not a problem for the unpinned case*. If we are able to
articulate how the current code works well for the unpinned case, I would
be fine.

> Consider the same example of Stream running 8 threads with pinning as follows
> on the dual socket Zen3 system (0-63,128-191 in one socket, 64-127,192-255 in
> another socket) with 8 LLCs per socket:
> 
> numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 
> Number of cpus available in each socket for this task is 4. However, each
> socket consists of 8 LLCs. According to current scheduler, all the LLCs are
> available for task to use but in reality, it can only use 4. Hence, all
> the stream threads are put on same socket and they have to initially share
> LLCs and the same set of cpus. This is why we see stacking initially and
> this is what we are addressing.
> 
> We've observed that load balancer does kick in and is able to spread the tasks
> apart but this takes a while and quite a few migrations before a stable state
> is reached.
> 
> Following is the output of the tracepoint sched_migrate_task on 5.17-rc1
> tip sched/core for stream running 8 threads with the same pinning pattern:
> (Output has been slightly modified for readability)
> 
> 167.928338: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=32 dest_cpu=48 START - {8}{0}
> ... 9 migrations
> 168.595632: sched_migrate_task: comm=stream pid=5051 prio=120 orig_cpu=16 dest_cpu=64 * {7}{1}
> 168.595634: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=16 dest_cpu=64 * {6}{2}
> ... 3 migrations
> 168.625803: sched_migrate_task: comm=stream pid=5052 prio=120 orig_cpu=0 dest_cpu=64 * {5}{3}
> 168.626146: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=16 dest_cpu=0
> 168.650832: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=0 dest_cpu=48
> 168.651009: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=64 dest_cpu=32 * {6}{2}
> 168.677314: sched_migrate_task: comm=stream pid=5048 prio=120 orig_cpu=32 dest_cpu=80 * {5}{3}
> 168.677320: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=48 dest_cpu=64 * {4}{4}
> 168.735707: sched_migrate_task: comm=stream pid=5050 prio=120 orig_cpu=64 dest_cpu=96
> 168.775510: sched_migrate_task: comm=stream pid=5051 prio=120 orig_cpu=80 dest_cpu=0 * {5}{3}
> ... 39 migrations
> 170.232105: sched_migrate_task: comm=stream pid=5049 prio=120 orig_cpu=0 dest_cpu=64 END {4}{4}
> 
> As we can see, 63 migrations are arecorded during the runtime of the
> program that can be avoided by the correct initial placement.
> 
> As you highlight, there may be areas in the load balancer path that
> can be optimized too for such a case.
> > I believe the problem could be in can_migrate_task() checking for
> > !cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)
> >
> > i.e dst_cpu is doing a load balance on behalf of the entire LLC, however it
> > only will pull tasks that can be pulled into it.
> Please correct me if I'm wrong but don't we scan the entire sched group
> and check if there is a compatible cpu for pinned tasks in can_migrate_task()
> when !cpumask_test_cpu(env->dst_cpu, p->cpus_ptr) ?
> 

> If a compatible cpu is found in the group, it is stored in new_dst_cpu
> member of lb_env to be used later in the load balancing path if my
> understanding is correct.

Yes, this is the LBF_DST_PINNED logic, So I am wondering if that is kicking
in correctly because this is the only difference I see between pinned and
unpinned.

> --
> Thanks and Regards,
> Prateek

-- 
Thanks and Regards
Srikar Dronamraju
