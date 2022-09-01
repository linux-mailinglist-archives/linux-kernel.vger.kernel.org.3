Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA305A92A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiIAJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiIAJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88B77571
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:01:30 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2818oSGd007656;
        Thu, 1 Sep 2022 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zuFrY9PbH6DI0qXYtE5kXVNqcrfdFquupbF8OFqj1Ds=;
 b=U0nxIRkgDSoWt3mmLfROeoeMWpTGS2sMEfQSe0wGZ/L5XCOZ8UcaviEOkX436pSCgOBf
 nK4yZKeBXhROqAcwvy93Q3Tyqt+1CgLoUkK1S9p+nW3Xy2Z6I/k97TuNMqTjVtNV7Zh9
 OSpbVcI29rnDyne3IFthasqL+hUquHtwTrlplpceSO5r05w3+0opuIHTi4Hlj3+eXlmD
 Y7m7PfulfYfdrzMngzWi7MUMGYpxCAq9VzQL4emQTR/LXZR0VwUNoT4jJ876hlljJMcs
 +NNI5Sm6yuhMyMk/JkuWMECDuFbIap4ISe2S+HVltSNqqvh9QcvwPv3XjV7c/cn2ogpc gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jask18a52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:01:09 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2818pCso013578;
        Thu, 1 Sep 2022 09:01:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jask189uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:01:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2818q0kH003829;
        Thu, 1 Sep 2022 09:00:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw96fnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:00:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2818vWGc38470042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 08:57:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 882DC4C059;
        Thu,  1 Sep 2022 09:00:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5B514C04A;
        Thu,  1 Sep 2022 09:00:46 +0000 (GMT)
Received: from [9.43.54.15] (unknown [9.43.54.15])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 09:00:46 +0000 (GMT)
Message-ID: <c39c6ed2-4766-71d2-d459-6bb39f09943a@linux.ibm.com>
Date:   Thu, 1 Sep 2022 14:30:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220901083023.42319-1-songmuchun@bytedance.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220901083023.42319-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KGevbamHqVRcBguNAm3gCn1t4HORL7b7
X-Proofpoint-GUID: _QRkGQR8gQA2pYu0ciVDtmKLtkdIG5Zv
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 2:00 PM, Muchun Song wrote:
> The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
> the complexity of code as pointed by David in thread [1].  The handling of memory-less
> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
> From its commit message, we cannot find any necessity of handling this case. So, we can
> simply register/unregister sysfs entries in register_node/unregister_node to simlify the
> code.

Isn't that hotplug callback added because in hugetlb_register_all_nodes() we register
sysfs nodes only for N_MEMORY nodes? 


> 
> https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redhat.com/ [1]
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  drivers/base/node.c  |  7 +++++--
>  include/linux/node.h |  5 +++++
>  mm/hugetlb.c         | 37 ++++++++++---------------------------
>  3 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ed391cb09999..cf115d5a9b8a 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -608,10 +608,12 @@ static int register_node(struct node *node, int num)
>  	node->dev.groups = node_dev_groups;
>  	error = device_register(&node->dev);
>  
> -	if (error)
> +	if (error) {
>  		put_device(&node->dev);
> -	else
> +	} else {
> +		hugetlb_register_node(node);
>  		compaction_register_node(node);
> +	}
>  


I guess this will handle register of sysfs hugetlb files for new NUMA nodes
after hugetlb_initialized = true;

But what about N_CPU that can get memory added later. Do we need to update
hugetlb_register_all_nodes() to handle N_ONLINE? 


>  	return error;
>  }
> @@ -625,6 +627,7 @@ static int register_node(struct node *node, int num)
>   */
>  void unregister_node(struct node *node)
>  {
> +	hugetlb_unregister_node(node);
>  	compaction_unregister_node(node);
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 427a5975cf40..f5d41498c2bf 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -138,6 +138,11 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>  extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>  						   unsigned int cpu_nid,
>  						   unsigned access);
> +
> +#ifdef CONFIG_HUGETLBFS
> +void hugetlb_register_node(struct node *node);
> +void hugetlb_unregister_node(struct node *node);
> +#endif
>  #else
>  static inline void node_dev_init(void)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..722e862bb6be 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3898,6 +3898,7 @@ static void __init hugetlb_sysfs_init(void)
>  }
>  
>  #ifdef CONFIG_NUMA
> +static bool hugetlb_initialized __ro_after_init;
>  
>  /*
>   * node_hstate/s - associate per node hstate attributes, via their kobjects,
> @@ -3953,7 +3954,7 @@ static struct hstate *kobj_to_node_hstate(struct kobject *kobj, int *nidp)
>   * Unregister hstate attributes from a single node device.
>   * No-op if no hstate attributes attached.
>   */
> -static void hugetlb_unregister_node(struct node *node)
> +void hugetlb_unregister_node(struct node *node)
>  {
>  	struct hstate *h;
>  	struct node_hstate *nhs = &node_hstates[node->dev.id];
> @@ -3983,19 +3984,22 @@ static void hugetlb_unregister_node(struct node *node)
>   * Register hstate attributes for a single node device.
>   * No-op if attributes already registered.
>   */
> -static int hugetlb_register_node(struct node *node)
> +void hugetlb_register_node(struct node *node)
>  {
>  	struct hstate *h;
>  	struct node_hstate *nhs = &node_hstates[node->dev.id];
>  	int err;
>  
> +	if (!hugetlb_initialized)
> +		return;
> +
>  	if (nhs->hugepages_kobj)
> -		return 0;		/* already allocated */
> +		return;		/* already allocated */
>  
>  	nhs->hugepages_kobj = kobject_create_and_add("hugepages",
>  							&node->dev.kobj);
>  	if (!nhs->hugepages_kobj)
> -		return -ENOMEM;
> +		return;
>  
>  	for_each_hstate(h) {
>  		err = hugetlb_sysfs_add_hstate(h, nhs->hugepages_kobj,
> @@ -4005,28 +4009,9 @@ static int hugetlb_register_node(struct node *node)
>  			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>  				h->name, node->dev.id);
>  			hugetlb_unregister_node(node);
> -			return -ENOMEM;
> +			break;
>  		}
>  	}
> -	return 0;
> -}
> -
> -static int __meminit hugetlb_memory_callback(struct notifier_block *self,
> -					     unsigned long action, void *arg)
> -{
> -	int ret = 0;
> -	struct memory_notify *mnb = arg;
> -	int nid = mnb->status_change_nid;
> -
> -	if (nid == NUMA_NO_NODE)
> -		return NOTIFY_DONE;
> -
> -	if (action == MEM_GOING_ONLINE)
> -		ret = hugetlb_register_node(node_devices[nid]);
> -	else if (action == MEM_CANCEL_ONLINE || action == MEM_OFFLINE)
> -		hugetlb_unregister_node(node_devices[nid]);
> -
> -	return notifier_from_errno(ret);
>  }
>  
>  /*
> @@ -4038,11 +4023,9 @@ static void __init hugetlb_register_all_nodes(void)
>  {
>  	int nid;
>  
> -	get_online_mems();
> -	hotplug_memory_notifier(hugetlb_memory_callback, 0);
> +	hugetlb_initialized = true;
>  	for_each_node_state(nid, N_MEMORY)


Should this be for_each_online_node() ?

>  		hugetlb_register_node(node_devices[nid]);
> -	put_online_mems();
>  }
>  #else	/* !CONFIG_NUMA */
>  

