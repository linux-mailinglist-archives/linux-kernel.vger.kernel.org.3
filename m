Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86C5995E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbiHSHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:12:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51BE1AB4;
        Fri, 19 Aug 2022 00:12:32 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J6rv7h030342;
        Fri, 19 Aug 2022 07:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=qkArMwvJEDHjotQY1z91NYPO0CEavHev7JtVEd/NKaY=;
 b=cCdea6SpOJKe/dRw6AWxQAnVYj/LE3id6prA5wZ2JeGLduSMaK58ZxLEvFxGz8ItRq4M
 6omto2USR2KeE/5gIj5SYPXHs6fIeCRKsdAdbm6KZlaynhLH09dzPP1gLXU5LwJiIySH
 0mTgmV56VZZz4GCSA7Ru6qFCEJzeBSnY+iVNDdhtWCwkn6gDJUkoA97HldR5GP3xnZKh
 HRSgCbzKRUh0b4OG6cQ3yKa7K/eznvDXOALAG/AkxZ+eSAGj6UElNCu24ptdm52vKEUy
 ad9l1Il0Gges3FmmBR2Zwq7Y0bsqdhWIac+roD9U7ZSdW4CRMp1aU5drSHLvODx9+YoS Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j25nh0h61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:12:13 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27J6vH7s018497;
        Fri, 19 Aug 2022 07:12:12 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j25nh0h57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:12:12 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27J75aXZ009804;
        Fri, 19 Aug 2022 07:12:11 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3hx3kam77a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:12:11 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27J7CAuG16122460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 07:12:10 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68B84C6059;
        Fri, 19 Aug 2022 07:12:10 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D1DC605A;
        Fri, 19 Aug 2022 07:12:09 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Aug 2022 07:12:09 +0000 (GMT)
MIME-Version: 1.0
Date:   Fri, 19 Aug 2022 09:12:09 +0200
From:   Tobias Huschle <huschle@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/isolation: Infrastructure to support rcu nocb
 cpumask changes
In-Reply-To: <20220525221055.1152307-4-frederic@kernel.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-4-frederic@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <254ba7249c2e5a0f5d771ae5d6544937@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Me7pZEM141KUS0HyFAby8RAzFBKaPD6U
X-Proofpoint-GUID: zc7nAK31ZZvOVJsyP5wZrC0nfpA5Ovf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208190025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-26 00:10, Frederic Weisbecker wrote:
> Provide a minimal infrastructure to change the housekeeping cpumasks.
> For now only RCU NOCB cpumask is handled.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/sched/isolation.h | 13 +++++++++++
>  kernel/sched/isolation.c        | 38 +++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h 
> b/include/linux/sched/isolation.h
> index 8c15abd67aed..c6d0e3f83a20 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -25,6 +25,8 @@ extern const struct cpumask
> *housekeeping_cpumask(enum hk_type type);
>  extern bool housekeeping_enabled(enum hk_type type);
>  extern void housekeeping_affine(struct task_struct *t, enum hk_type 
> type);
>  extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
> +extern int housekeeping_cpumask_set(struct cpumask *cpumask, enum
> hk_type type);
> +extern int housekeeping_cpumask_clear(struct cpumask *cpumask, enum
> hk_type type);
>  extern void __init housekeeping_init(void);
> 
>  #else
> @@ -46,6 +48,17 @@ static inline bool housekeeping_enabled(enum hk_type 
> type)
> 
>  static inline void housekeeping_affine(struct task_struct *t,
>  				       enum hk_type type) { }
> +
> +static inline int housekeeping_cpumask_set(struct cpumask *cpumask,
> enum hk_type type)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int housekeeping_cpumask_clear(struct cpumask *cpumask,
> enum hk_type type)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void housekeeping_init(void) { }
>  #endif /* CONFIG_CPU_ISOLATION */
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..ab4aba795c01 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -79,6 +79,44 @@ bool housekeeping_test_cpu(int cpu, enum hk_type 
> type)
>  }
>  EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
> 
> +static int housekeeping_cpumask_update(struct cpumask *cpumask,
> +				       enum hk_type type, bool on)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case HK_TYPE_RCU:
> +		err = rcu_nocb_cpumask_update(cpumask, on);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	if (err >= 0) {
> +		if (on) {
> +			cpumask_or(housekeeping.cpumasks[type],
> +				   housekeeping.cpumasks[type],
> +				   cpumask);
> +		} else {
> +			cpumask_andnot(housekeeping.cpumasks[type],
> +				       housekeeping.cpumasks[type],
> +				       cpumask);
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +int housekeeping_cpumask_set(struct cpumask *cpumask, enum hk_type 
> type)
> +{
> +	return housekeeping_cpumask_update(cpumask, type, true);
> +}
> +
> +int housekeeping_cpumask_clear(struct cpumask *cpumask, enum hk_type 
> type)
> +{
> +	return housekeeping_cpumask_update(cpumask, type, false);
> +}
> +
>  void __init housekeeping_init(void)
>  {
>  	enum hk_type type;

Just stumbled upon this patch.

I would be interested to have a way to fully isolate CPUs during 
runtime.
I tried some things similar to the patch above and the results looked
promising (removing certain CPUs from the housekeeping cpumasks during 
runtime).
Offlining them might be too expensive and also go a bit too far, as I 
might want to
be able to reactivate these CPUs quickly.

What kind of problems would you expect when making the housekeeping 
masks editable?
Not just rcu_nocb, but all of them.

--
Tobias
