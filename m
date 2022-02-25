Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A804C4FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiBYUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:36:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15351EE9DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:36:10 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PKJ0BD017463;
        Fri, 25 Feb 2022 20:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uVzX/eVA1NelZfBS+BCYGv1ZHJU38dHvAGP6eJ3nWEs=;
 b=N20hb+tjwwYWojpTzqFjWZmEi6KHKlTYMNiJlFyzvQ2uJJVWoFUOFHElkUA/X8ClUpI/
 QLSnKeZbjkMO44dOxEfsvuol1/DqmmumHfm35SUad+VFVbhl+qTP40tK5a4EXj842bJe
 PSR6PTuauO4NhbEiGFdYnLYOUFYC6jYARWgDcZtVwJF1aSDJc4LyLFuia3xvdEiuJMHy
 2ALTCqGoMJSnJ+akJkyt5LJ7nAvgXWd0JbenCrUrGBSfkpE9iXBa9ORdoPL7ohI7UpMp
 j1GfARlrWSbvnDL2Du0UrKWp3ewwCD5eUYAD5rIwQitkZYk1+qFyNjimxxn4LJgW/PuS EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef61hra54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 20:35:58 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PKLU7S029033;
        Fri, 25 Feb 2022 20:35:57 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef61hra4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 20:35:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PKCefT027148;
        Fri, 25 Feb 2022 20:35:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3ear6a0883-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 20:35:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PKP8ub48890308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 20:25:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEDFC4203F;
        Fri, 25 Feb 2022 20:35:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA4EB42041;
        Fri, 25 Feb 2022 20:35:47 +0000 (GMT)
Received: from [9.43.40.69] (unknown [9.43.40.69])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 20:35:47 +0000 (GMT)
Message-ID: <6afdded7-ae70-2412-4f15-f7951164049a@linux.vnet.ibm.com>
Date:   Sat, 26 Feb 2022 02:05:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-2-ying.huang@intel.com>
 <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
 <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
 <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
 <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
In-Reply-To: <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rQxVtaJvGYAmCTp2bNdB7lFAXR9yQ60a
X-Proofpoint-GUID: f0xropnJ3hh22I6olJopur4iGQCCvUti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_10,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202250112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

On 25/02/22 08:02, Huang, Ying wrote:
>
> We have run into a memory hotplug regression before.  Let's check
> whether the problem is similar.  Can you try the below debug patch?
>
> Best Regards,
> Huang, Ying
>
> ----------------------------8<------------------------------------------
>  From 500c0b53436b7a697ed5d77241abbc0d5d3cfc07 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Wed, 29 Sep 2021 10:57:19 +0800
> Subject: [PATCH] mm/migrate: Debug CPU hotplug regression
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>   mm/migrate.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..c4805f15e616 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3261,15 +3261,17 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>    * The ordering is also currently dependent on which nodes have
>    * CPUs.  That means we need CPU on/offline notification too.
>    */
> -static int migration_online_cpu(unsigned int cpu)
> +static int migration_cpu_hotplug(unsigned int cpu)
>   {
> -	set_migration_target_nodes();
> -	return 0;
> -}
> +	static int nr_cpu_node_saved;
> +	int nr_cpu_node;
> +
> +	nr_cpu_node = num_node_state(N_CPU);
> +	if (nr_cpu_node != nr_cpu_node_saved) {
> +		set_migration_target_nodes();
> +		nr_cpu_node_saved = nr_cpu_node;
> +	}
>
> -static int migration_offline_cpu(unsigned int cpu)
> -{
> -	set_migration_target_nodes();
>   	return 0;
>   }
>
> @@ -3283,7 +3285,7 @@ static int __init migrate_on_reclaim_init(void)
>   	WARN_ON(!node_demotion);
>
>   	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
> -					NULL, migration_offline_cpu);
> +					NULL, migration_cpu_hotplug);
>   	/*
>   	 * In the unlikely case that this fails, the automatic
>   	 * migration targets may become suboptimal for nodes
> @@ -3292,7 +3294,7 @@ static int __init migrate_on_reclaim_init(void)
>   	 */
>   	WARN_ON(ret < 0);
>   	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> -				migration_online_cpu, NULL);
> +				migration_cpu_hotplug, NULL);
>   	WARN_ON(ret < 0);
>
>   	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
This works. Applied this on 5.15 kernel and don't see any regression
compared to 5.14 kernel.
So, Have you posted this patch yet? Or any plans on inclusion of any
similar patch?


