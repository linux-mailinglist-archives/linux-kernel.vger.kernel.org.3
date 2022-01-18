Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A2491FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiARG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:59:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbiARG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:59:09 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I6QqKo016361;
        Tue, 18 Jan 2022 06:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ZW61ZogFc2/oM/7mk856sCKuQb0zmuNKnM2sq23SPNk=;
 b=ckW3HPrvFyWLEqJwN2doyPPXWaLht8WspWQLquokPzkpwUtcc5b6IhjGI819uWVaz2U/
 GSnM9DpWXBSDIKP0qp7cCpc6R23cPoUiQ/AD6xyYxqME/jn1Z4PjvIprgiFFyFlOrCH6
 0Wf/tSS0y3FI9FmdU+AKBYo/OYPigML82TILkyONXeghRF8xxkTHVmpf5gyVaajgs/Ln
 ep5pEtBXqzg4DF6BsYwRFSD48VStf6QZBBbWxOhdmXR+UG8iflOvMZy2Wu8rqqPQ3yIn
 duanOfO0vSoM2CGETCjvHH/eLoE8Bco77U8iwor7H3oF46hgfn4uwmf1UXDa8pOzbMoY qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnr9sgp44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 06:58:37 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20I6wamD024238;
        Tue, 18 Jan 2022 06:58:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dnr9sgp3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 06:58:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20I6rVV9025292;
        Tue, 18 Jan 2022 06:58:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3dknw9h9ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 06:58:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20I6wVvu36766070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 06:58:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43439A4040;
        Tue, 18 Jan 2022 06:58:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5FE7A4057;
        Tue, 18 Jan 2022 06:58:28 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 18 Jan 2022 06:58:28 +0000 (GMT)
Date:   Tue, 18 Jan 2022 12:28:28 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, riel@surriel.com
Subject: Re: [PATCH] sched/debug: Remove mpol_get/put and task_lock/unlock
 from sched_show_numa
Message-ID: <20220118065828.GA451532@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220118050515.2973-1-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220118050515.2973-1-bharata@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7e4Ei6Wz1q9uQyfUIsukzA0bO6VaXJ5R
X-Proofpoint-ORIG-GUID: URvAhtzC6Sn1TOYYpXHSsPGDIPAXTYH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bharata B Rao <bharata@amd.com> [2022-01-18 10:35:15]:

> The older format of /proc/pid/sched printed home node info which
> required the mempolicy and task lock around mpol_get(). However
> the format has changed since then and there is no need for
> sched_show_numa() any more to have mempolicy argument,
> asssociated mpol_get/put and task_lock/unlock. Remove them.
> 

> Fixes: 397f2378f1361 ("sched/numa: Fix numa balancing stats in /proc/pid/sched")
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Agree. Since pol is now being used, this whole hunk can be removed.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  kernel/sched/debug.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 7dcbaa31c5d9..50e05c8d0d61 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -931,25 +931,15 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
>  static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>  {
>  #ifdef CONFIG_NUMA_BALANCING
> -	struct mempolicy *pol;
> -
>  	if (p->mm)
>  		P(mm->numa_scan_seq);
> 
> -	task_lock(p);
> -	pol = p->mempolicy;
> -	if (pol && !(pol->flags & MPOL_F_MORON))
> -		pol = NULL;
> -	mpol_get(pol);
> -	task_unlock(p);
> -
>  	P(numa_pages_migrated);
>  	P(numa_preferred_nid);
>  	P(total_numa_faults);
>  	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
>  			task_node(p), task_numa_group_id(p));
>  	show_numa_stats(p, m);
> -	mpol_put(pol);
>  #endif
>  }
> 
> -- 
> 2.25.1
> 

-- 
Thanks and Regards
Srikar Dronamraju
