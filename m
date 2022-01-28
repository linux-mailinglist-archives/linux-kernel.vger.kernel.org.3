Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC649F313
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiA1FeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:34:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23058 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbiA1FeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:34:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S5VQjn007540;
        Fri, 28 Jan 2022 05:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=wFe6d2PH2NyAqIKhw6tUKH2b8SfV3IK5UessK84bzSw=;
 b=KfjoomctpQDCRsyOuCi1A6evKbabP5bTFPzTDK5MvpePTVcY4GauDZSRvXWoCj9abkP+
 3H0Sm1HAVUWGG2ZV5iKlFY9ObKwEbq9WV7nknr8hN/HekVVmFxG3XqsT632bxIdZ0JB/
 TEGNmhIpkr/cf9rdlkhDQocme0bkWx+3OdZXVtFdZ/hGOLOhg+A1ocgZAEtio8MPa4vm
 qn4lZEh/k+zS2p9tLRY5agj9AkhyyWhGQjQLuT9D5fmg3S32g4thxA6nlUdH9lRZRboi
 LFdnf9GsoyUq4Fq+tAwb1/ZUoSCwZVwjYq/dCr81rChBnQryrDC0eF96ly+IlupJmZvf Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv83ej1fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:33:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S5XT9o013418;
        Fri, 28 Jan 2022 05:33:48 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv83ej1f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:33:48 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S5SfKw015999;
        Fri, 28 Jan 2022 05:33:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96k3vv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:33:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S5XidI45875566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 05:33:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2540C4C040;
        Fri, 28 Jan 2022 05:33:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 602E64C044;
        Fri, 28 Jan 2022 05:33:42 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jan 2022 05:33:42 +0000 (GMT)
Date:   Fri, 28 Jan 2022 11:03:41 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 2/2] NUMA balancing: avoid to migrate task to
 CPU-less node
Message-ID: <20220128053341.GB618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220128023842.1946583-1-ying.huang@intel.com>
 <20220128023842.1946583-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220128023842.1946583-2-ying.huang@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I4_bnXfTBNXSF5QJpZmiFIyF7mBYWf6c
X-Proofpoint-ORIG-GUID: pN3Nkq8_n1wJb_XgdCmnj2Rr1A4x7hVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=839 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:42]:

> In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
> nodes.  But if the number of the hint page faults on a PMEM node is
> the max for a task, The current NUMA balancing policy may try to place
> the task on the PMEM node instead of DRAM node.  This is unreasonable,
> because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
> nodes are ignored when searching the migration target node for a task
> in this patch.
> 
> To test the patch, we run a workload that accesses more memory in PMEM
> node than memory in DRAM node.  Without the patch, the PMEM node will
> be chosen as preferred node in task_numa_placement().  While the DRAM
> node will be chosen instead with the patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 54e1aad1c5d7..e462ac5c1e48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2393,6 +2393,10 @@ static void task_numa_placement(struct task_struct *p)
>  			}
>  		}
> 
> +		/* Cannot migrate task to CPU-less node */
> +		if (!node_state(nid, N_CPU))
> +			continue;
> +

Lets take the example that you quoted 2 socket machine with 1 DRAM node and
1 PMEM node per socket.  Now lets say the task is placed on a CPU in node 1
but most of its memory faults are coming from node 2, which is the PMEM node
attached to node 0. Now without the hunk, there is a chance that the task
got moved to node 0. However with the change, are we inhibiting such a move?

>  		if (!ng) {
>  			if (faults > max_faults) {
>  				max_faults = faults;
> -- 
> 2.30.2
> 

-- 
Thanks and Regards
Srikar Dronamraju
