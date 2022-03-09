Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14B4D285E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiCIF1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCIF1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:27:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D771E15F625
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:26:23 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2293cBom001932;
        Wed, 9 Mar 2022 05:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=SiQu9HjVXq2uion0tDryFU/0AiKq+VZdv0E+axsSO3A=;
 b=GXIH+V08EZLbJ4TMeHEbstYu4GfybgF8v5F2iVMcTmscfppOrOysCNyApQPvvV6Wt0VP
 KMupJlgrBq0+ClFdinjs0JtWPFbrnHLoZ1lw3dLvAgkcB6I6K++6b1j65rR1AwEVyYDu
 Xlw89ob2bVq37ODQLfqda+uN6rTMN4bFisxB0JDA3VOAIE7X6fsubQE4QcThK48k0EG6
 uSDoWlbvYgd6BgU4XXe2ge40L5HX3hDFGzopEMs8NwSDdm3sI2vFLv30on47T3zXsS6D
 Copa42IjgpnAuxCLDjIStlBXK+9gSvhtJi9eY6KZHH5P8cMUuGUbr03Oa6KwBobZLpn+ 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0sd11ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 05:26:03 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2295Q2XE018223;
        Wed, 9 Mar 2022 05:26:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0sd11a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 05:26:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2295MSwm006522;
        Wed, 9 Mar 2022 05:26:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg9157n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 05:26:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2295Pws436700490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 05:25:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EED1FA4051;
        Wed,  9 Mar 2022 05:25:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A05E1A4040;
        Wed,  9 Mar 2022 05:25:55 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  9 Mar 2022 05:25:55 +0000 (GMT)
Date:   Wed, 9 Mar 2022 10:55:54 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220309052554.GK618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
 <20220308092944.GJ618915@linux.vnet.ibm.com>
 <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7e5bdc95-a30a-58bc-fc67-98b03fe1fa22@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZLrajSdyIV3wIqmez2ASCjeHE-Oee7Ox
X-Proofpoint-GUID: HTt8Cipj-JfNeHAHFrZBuLTFxnohCRE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=848 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-08 17:18:16]:

> Hello Srikar,
> 
> On 3/8/2022 2:59 PM, Srikar Dronamraju wrote:
> > [..snip..]


> >> @@ -9200,10 +9201,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >>  			 * Otherwise, keep the task close to the wakeup source
> >>  			 * and improve locality if the number of running tasks
> >>  			 * would remain below threshold where an imbalance is
> >> -			 * allowed. If there is a real need of migration,
> >> -			 * periodic load balance will take care of it.
> >> +			 * allowed while accounting for the possibility the
> >> +			 * task is pinned to a subset of CPUs. If there is a
> >> +			 * real need of migration, periodic load balance will
> >> +			 * take care of it.
> >>  			 */
> >> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> >> +			imb = sd->imb_numa_nr;
> >> +			if (p->nr_cpus_allowed != num_online_cpus()) {

> > Again, repeating, is the problem only happening in the pinned case?
> Yes. We've tested stream with 8 and 16 stream threads on a Zen3 system
> with 16 LLCs and in both cases, with unbound runs, we've seen each
> Stream thread get a separate LLC and we didn't observe any stacking.

If the problem is only happening with pinned case, then it means that in the
in unpinned case, the load balancer is able to do the load balancing
correctly and quickly but for some reason may not be able to do the same in
pinned case. Without the patch, even in the unpinned case, the initial CPU
range is more less the same number of LLCs as the pinned. However its able
to spread better.

I believe the problem could be in can_migrate_task() checking for
!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)

i.e dst_cpu is doing a load balance on behalf of the entire LLC, however it
only will pull tasks that can be pulled into it.

> --
> Thanks and Regards,
> Prateek

-- 
Thanks and Regards
Srikar Dronamraju
