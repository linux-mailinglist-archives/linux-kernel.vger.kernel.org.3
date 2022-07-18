Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E434D577D24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGRIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiGRIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:07:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B8DEC2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:07:02 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I7tqfe013066;
        Mon, 18 Jul 2022 08:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=09xF766YwgUvi96cmnyhPw/evjmUYM2mdO5XzIouSCQ=;
 b=TGdgrSNYs1twp6raLv7p994FyIh2tprbYOmsvlJau0gtnJB2IEI0k45ePPdj1t94Oc8A
 PhA7Y6yE0snzQDd3AWcBKHDbZ+ZQO5+9By7JM0rDjfiogy3v0qZQVCEDHqzok2zibboe
 8YGPDLnyUI6jSeHR4z2noU+8+adjflg8piHzjZdWMu9eGmoduYl6KcNZZswUJAtkirPw
 XxLlmDSCtWlxYzC8nUXqqL4xt0BOme04lJIFPClHjp0dmVezojNJ5EbOICM6+Tt2ZuYq
 dTnsYQ2vgQiy3X3UQuaRJRx9tPmNVepCvpmuipyYWHRvfY6QS5MUymxEU1ib0aGrltET fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd3jh8crx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 08:06:36 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26I7uxOG019882;
        Mon, 18 Jul 2022 08:06:25 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd3jh8baw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 08:06:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26I7pDag021216;
        Mon, 18 Jul 2022 08:01:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8sqje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 08:01:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26I810mx12583186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 08:01:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7379A405F;
        Mon, 18 Jul 2022 08:01:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D24A4062;
        Mon, 18 Jul 2022 08:00:56 +0000 (GMT)
Received: from [9.43.44.250] (unknown [9.43.44.250])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 08:00:56 +0000 (GMT)
Message-ID: <cf68344f-9d6c-66c0-b8d5-e95ae3c01eb6@linux.ibm.com>
Date:   Mon, 18 Jul 2022 13:30:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
 <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
 <87tu7e3o2h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87tu7e3o2h.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ayJnE_wkyPBDpwhqlOnlaT5ohTmaiShS
X-Proofpoint-ORIG-GUID: U0ntLuAeQrxejJZjiPPozSYwCnnc_8Fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_04,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 12:27 PM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 7/15/22 1:23 PM, Huang, Ying wrote:
> 
> [snip]
> 
>>>
>>> You dropped the original sysfs interface patches from the series, but
>>> the kernel internal implementation is still for the original sysfs
>>> interface.  For example, memory tier ID is for the original sysfs
>>> interface, not for the new proposed sysfs interface.  So I suggest you
>>> to implement with the new interface in mind.  What do you think about
>>> the following design?
>>>
>>
>> Sorry I am not able to follow you here. This patchset completely drops
>> exposing memory tiers to userspace via sysfs. Instead it allow
>> creation of memory tiers with specific tierID from within the kernel/device driver.
>> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
>>
>>
>>> - Each NUMA node belongs to a memory type, and each memory type
>>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>>   a "distance".  For simplicity, we can start with static distances, for
>>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>>   node can be recorded in a global array,
>>>
>>>     int node_distances[MAX_NUMNODES];
>>>
>>>   or, just
>>>
>>>     pgdat->distance
>>>
>>
>> I don't follow this. I guess you are trying to have a different design.
>> Would it be much easier if you can write this in the form of a patch? 
> 
> Written some pseudo code as follow to show my basic idea.
> 
> #define MEMORY_TIER_ADISTANCE_DRAM	150
> #define MEMORY_TIER_ADISTANCE_PMEM	250
> 
> struct memory_tier {
> 	/* abstract distance range covered by the memory tier */
> 	int adistance_start;
> 	int adistance_len;
> 	struct list_head list;
> 	nodemask_t nodemask;
> };
> 
> /* RCU list of memory tiers */
> static LIST_HEAD(memory_tiers);
> 
> /* abstract distance of each NUMA node */
> int node_adistances[MAX_NUMNODES];
> 
> struct memory_tier *find_create_memory_tier(int adistance)
> {
> 	struct memory_tier *tier;
> 
> 	list_for_each_entry(tier, &memory_tiers, list) {
> 		if (adistance >= tier->adistance_start &&
> 		    adistance < tier->adistance_start + tier->adistance_len)
> 			return tier;
> 	}
> 	/* allocate a new memory tier and return */
> }
> 
> void memory_tier_add_node(int nid)
> {
> 	int adistance;
> 	struct memory_tier *tier;
> 
> 	adistance = node_adistances[nid] || MEMORY_TIER_ADISTANCE_DRAM;
> 	tier = find_create_memory_tier(adistance);
> 	node_set(nid, &tier->nodemask);
> 	/* setup demotion data structure, etc */
> }
> 
> static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> 						 unsigned long action, void *_arg)
> {
> 	struct memory_notify *arg = _arg;
> 	int nid;
> 
> 	nid = arg->status_change_nid;
> 	if (nid < 0)
> 		return notifier_from_errno(0);
> 
> 	switch (action) {
> 	case MEM_ONLINE:
> 		memory_tier_add_node(nid);
> 		break;
> 	}
> 
> 	return notifier_from_errno(0);
> }
> 
> /* kmem.c */
> static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> {
> 	node_adistances[dev_dax->target_node] = MEMORY_TIER_ADISTANCE_PMEM;
> 	/* add_memory_driver_managed() */
> }
> 
> [snip]
> 
> Best Regards,
> Huang, Ying


Implementing that I ended up with the below. The difference is adistance_len is not a memory tier property
instead it is a kernel parameter like memory_tier_chunk_size which can be tuned to create more memory tiers.
How about this? Not yet tested.

struct memory_tier {
	struct list_head list;
	int id;
	int perf_level;
	nodemask_t nodelist;
};

static LIST_HEAD(memory_tiers);
static DEFINE_MUTEX(memory_tier_lock);
static unsigned int default_memtier_perf_level = DEFAULT_MEMORY_TYPE_PERF;
core_param(default_memory_tier_perf_level, default_memtier_perf_level, uint, 0644);
static unsigned int memtier_perf_chunk_size = 150;
core_param(memory_tier_perf_chunk, memtier_perf_chunk_size, uint, 0644);

/*
 * performance levels are grouped into memtiers each of chunk size
 * memtier_perf_chunk
 */
static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
{
	bool found_slot = false;
	struct list_head *ent;
	struct memory_tier *memtier, *new_memtier;
	static int next_memtier_id = 0;
	/*
	 * zero is special in that it indicates uninitialized
	 * perf level by respective driver. Pick default memory
	 * tier perf level for that.
	 */
	if (!perf_level)
		perf_level = default_memtier_perf_level;

	lockdep_assert_held_once(&memory_tier_lock);

	list_for_each(ent, &memory_tiers) {
		memtier = list_entry(ent, struct memory_tier, list);
		if (perf_level >= memtier->perf_level &&
		    perf_level < memtier->perf_level + memtier_perf_chunk_size)
			return memtier;
		else if (perf_level < memtier->perf_level) {
			found_slot = true;
			break;
		}
	}

	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
	if (!new_memtier)
		return ERR_PTR(-ENOMEM);

	new_memtier->id = next_memtier_id++;
	new_memtier->perf_level = ALIGN_DOWN(perf_level, memtier_perf_chunk_size);
	if (found_slot)
		list_add_tail(&new_memtier->list, ent);
	else
		list_add_tail(&new_memtier->list, &memory_tiers);
	return new_memtier;
}

static int __init memory_tier_init(void)
{
	int node;
	struct memory_tier *memtier;

	/*
	 * Since this is early during  boot, we could avoid
	 * holding memtory_tier_lock. But keep it simple by
	 * holding locks. So we can add lock held debug checks
	 * in other functions.
	 */
	mutex_lock(&memory_tier_lock);
	memtier = find_create_memory_tier(default_memtier_perf_level);
	if (IS_ERR(memtier))
		panic("%s() failed to register memory tier: %ld\n",
		      __func__, PTR_ERR(memtier));

	/* CPU only nodes are not part of memory tiers. */
	memtier->nodelist = node_states[N_MEMORY];

	/*
	 * nodes that are already online and that doesn't
	 * have perf level assigned is assigned a default perf
	 * level.
	 */
	for_each_node_state(node, N_MEMORY) {
		struct node *node_property = node_devices[node];

		if (!node_property->perf_level)
			node_property->perf_level = default_memtier_perf_level;
	}
	mutex_unlock(&memory_tier_lock);
	return 0;
}
subsys_initcall(memory_tier_init);

