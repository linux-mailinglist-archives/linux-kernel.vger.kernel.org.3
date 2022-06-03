Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB153C736
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiFCJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFCJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:00:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A138188
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:00:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2538ZqP5024778;
        Fri, 3 Jun 2022 08:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KkC/e61vN+BG1vovzdU2z8GhhLcq4mtcI91ynJs1oX0=;
 b=ILuGkWuhiXM9/uGqGuR/ziOo4DFJrlVYrRKz/T+c6ZGKOXrlw97Tc+lNm2O3C6A5Z0Cg
 0EVrHYBp7HcgWufVDNRKxENOcgW2Wcr4UKZuxhzySLj4rhz4Hu47Eh8lggZPqunnTUNf
 gVhzju+/pKIZbEsTZZsZFnPuHqxwLu9anzwvbEWDmJu03f/3kVPadWp5W2bQlQHnESqP
 +DkjKIbo2BfArEHX6nspswxOIb9wQ8pYNU0p6LQ/nHlxWSTVWk/4b8YZEzBLLrskkp8v
 HMvFEriuifSjt14CoUW3Labub4QMslTSkzOxPBcVp3znbkngaUMTgM41hEDLBB11gkS+ 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfbnm3xfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:59:56 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2538xuLl008984;
        Fri, 3 Jun 2022 08:59:56 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfbnm3xew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:59:56 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2538plTF032658;
        Fri, 3 Jun 2022 08:59:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3gbcakp7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:59:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2538xp0a52166974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 08:59:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09B842042;
        Fri,  3 Jun 2022 08:59:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C2654203F;
        Fri,  3 Jun 2022 08:59:51 +0000 (GMT)
Received: from [9.145.173.148] (unknown [9.145.173.148])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 08:59:51 +0000 (GMT)
Message-ID: <666cedea-2dbc-254e-467b-c02a3a2d8795@linux.ibm.com>
Date:   Fri, 3 Jun 2022 10:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] Disabling NMI watchdog during LPM's memory transfer
Content-Language: en-US
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
References: <20220601155315.35109-1-ldufour@linux.ibm.com>
 <87a6av0wxk.fsf@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87a6av0wxk.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ikFcWkRnP4pOqHpU7tGUgANBv3tq1Mzs
X-Proofpoint-ORIG-GUID: pKvRbHwiYmeKDEEZ99YzuA_AjUfnDQoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_02,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030035
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022, 19:58:31, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> When a partition is transferred, once it arrives at the destination node,
>> the partition is active but much of its memory must be transferred from the
>> start node.
>>
>> It depends on the activity in the partition, but the more CPU the partition
>> has, the more memory to be transferred is likely to be. This causes latency
>> when accessing pages that need to be transferred, and often, for large
>> partitions, it triggers the NMI watchdog.
> 
> It also triggers warnings from other watchdogs and subsystems that
> have soft latency requirements  - softlockup, RCU, workqueue. The issue
> is more general than the NMI watchdog.

I agree, but, as you can read in the title, this series is focusing on the
NMI watchdog which may have some dangerous side effects.

>> The NMI watchdog causes the CPU stack to dump where it appears to be
>> stuck. In this case, it does not bring much information since it can happen
>> during any memory access of the kernel.
> 
> When the site of a watchdog backtrace shows a thread stuck on a routine
> memory access as opposed to something like a lock acquisition, that is
> actually useful information that shouldn't be discarded. It tells us the
> platform is failing to adequately virtualize partition memory. This
> isn't a benign situation and it's likely to unacceptably affect real
> workloads. The kernel is ideally situated to detect and warn about this.
> 

I agree, but the information provided are most of the time misleading,
pointing to various part in the kernel where the last page fault of a
series generated by the kernel happened. There is no real added value,
since this is well known that the memory transfer is introducing latency
that is detected by the kernel. Furthermore, soft lockups are still
triggered and report as well this latency without any side effect.

>> In addition, the NMI interrupt mechanism is not secure and can generate a
>> dump system in the event that the interruption is taken while
>> MSR[RI]=0.
> 
> This sounds like a general problem with that facility that isn't
> specific to partition migration? Maybe it should be disabled altogether
> until that can be fixed?

We already discuss that with Nick and it sounds that it is not so easy to
fix that. Furthermore, the NMI watchdog is considered as last option for
analyzing a potential dying system. So taking the risk of generating a
crash because of the NMI interrupt looks acceptable. But disabling it
totally because of that is not the right option.

In the LPM's case, the system is dependent on the LPM's latency, it is not
really dying or in a really bad shape, so that risk is too expansive.

Fixing the latency at the source is definitively the best option, and the
PHYP team is already investigating that. But, in the meantime, there is a
way to prevent the system to die because of that side effect by disabling
the NMI watchdog during the memory transfer.

> 
>> Given how often hard lockups are detected when transferring large
>> partitions, it seems best to disable the watchdog NMI until the memory
>> transfer from the start node is complete.
> 
> At this time, I'm far from convinced. Disabling the watchdog is going to
> make the underlying problems in the platform and/or network harder to
> understand.

I was also reluctant, and would like the NMI watchdog to remain active
during LPM. But there is currently no other way to work around the LPM's
latency, and its potential risk of system crash.

I've spent a lot of time analyzing many crashes happening during LPM and
all of them are now pointing to the NMI watchdog issue. Furthermore, on a
system with thousands of CPUs, I saw a system crash because a CPU was not
able to respond in time (1s) to the NMI interrupt and thus generate the panic.

In addition, we now know that a RTAS call, made right after the system is
running again on the arrival side, is taking ages and is most of the time
triggering the NMI watchdog.

There are  ongoing investigations to clarify where and how this latency is
happening. I'm not excluding any other issue in the Linux kernel, but right
now, this looks to be the best option to prevent system crash during LPM.

I'm hoping that the PHYP team will be able to improve that latency. At that
time, this commit can be reverted, but until then, I don't see how we can
do without that workaround.

Laurent.
