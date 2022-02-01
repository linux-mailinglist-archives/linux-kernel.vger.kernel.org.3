Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268CE4A571A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiBAGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:00:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbiBAGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:00:35 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21131W8X026998;
        Tue, 1 Feb 2022 05:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=PfWUM0BudvC81uDbHwxTnnZVr0fNZVVI7VdKqD4BRfE=;
 b=coXmY++iX4+Q5toi0fduXuVwpf18bmc0C1bNK3ZneqMPCc2y1TRzN568LqTjYkJLUTwP
 UBxq3YSJm76byko+mAgxcsJdfdj+1SJHWZQFUEogxh12zlj3xhEc5qWD4+H7AfAVRE7f
 wk0SCCX8fSnHyLgm8/tTZKVd3GXHxbjbM1S7+jHZE5AS4dH7PSG+nxQzD9fJF4v4ewNQ
 DNXgAbCU36pNgmOPnSZT3R/+kCiLrOng1hI4Sh3KZ1hqggw/cjMrJ6141uHaOTmFVG/1
 CejrhrBGduvVsf9G6zVG8eT1fwSgq89KF80qSUMukHE6Pu78H4AZRjq8JAMiadJqM1RG 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkjtdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 05:59:12 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2115lR60008755;
        Tue, 1 Feb 2022 05:59:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxvkjtdc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 05:59:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2115wgSv029582;
        Tue, 1 Feb 2022 05:59:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3dvw79h1d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 05:59:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2115nJqS49611108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 05:49:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD9A34C044;
        Tue,  1 Feb 2022 05:59:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12CDA4C040;
        Tue,  1 Feb 2022 05:59:06 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  1 Feb 2022 05:59:05 +0000 (GMT)
Date:   Tue, 1 Feb 2022 11:29:04 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 2/2] NUMA balancing: avoid to migrate task to
 CPU-less node
Message-ID: <20220201055904.GD618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220128023842.1946583-1-ying.huang@intel.com>
 <20220128023842.1946583-2-ying.huang@intel.com>
 <20220128053341.GB618915@linux.vnet.ibm.com>
 <877dakti0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <877dakti0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v0cnSmcYxlSrcYTk9rHbtJVP4V1TErlv
X-Proofpoint-ORIG-GUID: qjniIMwVW5IKqw9eLIXE2ErgGGRQCk6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_01,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202010029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Huang, Ying <ying.huang@intel.com> [2022-01-28 15:51:36]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> > * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:42]:
> >
> This sounds reasonable.  How about the following solution?  If a
> CPU-less node is selected as migration target, we select a nearest node
> with CPU instead?  That is, something like the below patch.
> 
> Best Regards,
> Huang, Ying
> 
> ------------------------------8<---------------------------------
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb..52d926d8cbdb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2401,6 +2401,23 @@ static void task_numa_placement(struct task_struct *p)
>  		}
>  	}
> 
> +	/* Cannot migrate task to CPU-less node */
> +	if (!node_state(max_nid, N_CPU)) {
> +		int near_nid = max_nid;
> +		int distance, near_distance = INT_MAX;
> +
> +		for_each_online_node(nid) {
> +			if (!node_state(nid, N_CPU))
> +				continue;
> +			distance = node_distance(max_nid, nid);
> +			if (distance < near_distance) {
> +				near_nid = nid;
> +				near_distance = distance;
> +			}
> +		}
> +		max_nid = near_nid;
> +	}
> +


This looks good. but should we move this into preferred_group_nid()?
i.e should we care for !ng case, since those would mean only private faults.

>  	if (ng) {
>  		numa_group_count_active_nodes(ng);
>  		spin_unlock_irq(group_lock);

-- 
Thanks and Regards
Srikar Dronamraju
