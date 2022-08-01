Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B7D5865CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiHAHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiHAHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:41:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFE24099
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:41:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2717H559029989;
        Mon, 1 Aug 2022 07:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yX5Pnye0O7o1dWmXupEFySXp8jXNuAPoAQg1IR9tAQ8=;
 b=gMsoBGq+XgsW6kwXE2AzFQ+Gphm6fz2Of1PL8e7c5yafbY3BRYbHNFWvDwf6KlxEJO3F
 sDxZmoRGeueoNGA1viiAYQAGXUiBSH4j4fnuyVnhHyiBOrSsHRyONXSZJP8xy7UKomJE
 An8FJM5X6ZdwvlIqihjkDFtn4UZiQq3uJ9+12IgaW54Q84aFSJ+fxCy19RWiNajQT+CN
 b+7+2IWrjlxBBgci/IV0jkpXP5hslCD8YJ293bsVM5/7m4M/DETR9/q3B13ZyIJZgaJ7
 GJpF7xi+fcsp2qx+YeWrF8kBUlolSu5xpCmKDpa5nGgZgm2eAh5Fmog+cLhCtlU4l/KO 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hpaaa8mkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:41:21 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2717HWXL031140;
        Mon, 1 Aug 2022 07:41:20 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hpaaa8mk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:41:20 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2717KmsA028008;
        Mon, 1 Aug 2022 07:41:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3hmv991djj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 07:41:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2717fG0W28836120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 07:41:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16978AE056;
        Mon,  1 Aug 2022 07:41:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B9FCAE051;
        Mon,  1 Aug 2022 07:41:12 +0000 (GMT)
Received: from [9.43.22.209] (unknown [9.43.22.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 07:41:12 +0000 (GMT)
Message-ID: <394c0599-2dc0-0303-cd86-bdd2d265d1ee@linux.ibm.com>
Date:   Mon, 1 Aug 2022 13:11:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
 <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87bkt8s7w9.fsf@linux.ibm.com>
 <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
 <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
 <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1aba0c44-b096-8c75-8086-62d3cffc08b3@linux.ibm.com>
 <87h72wjv27.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87h72wjv27.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Whi7tmauSRizxjtukXq9QV0f6H9KuOGv
X-Proofpoint-ORIG-GUID: ktlv1TPa_52GfiUMM5fpAEVsZdY9PDG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_03,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 12:43 PM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 8/1/22 12:07 PM, Huang, Ying wrote:
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> On 8/1/22 10:40 AM, Huang, Ying wrote:
>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>
>>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>>
>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>> ....
>>
>>>>>>
>>>>>> With the module unload, it is kind of force removing the usage of the specific memtype.
>>>>>> Considering module unload will remove the usage of specific memtype from other parts
>>>>>> of the kernel and we already do all the required reset in memory hot unplug, do we
>>>>>> need to do the clear_node_memory_type above? 
>>>>>
>>>>> Per my understanding, we need to call clear_node_memory_type() in
>>>>> dev_dax_kmem_remove().  After that, we have nothing to do in
>>>>> dax_kmem_exit().
>>>>>
>>>>
>>>> Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 
>>>
>>> Can we use node_memory_types[] to indicate whether a node is managed by
>>> a driver?
>>>
>>> Regardless being succeeded or failed, dev_dax_kmem_remove() will set
>>> node_memory_types[] = NULL.  But until node is offlined, we will still
>>> keep the node in the memory_dev_type (dax_pmem_type).
>>>
>>> And we will prevent dax/kmem from unloading via try_module_get() and add
>>> "struct module *" to struct memory_dev_type.
>>>
>>
>> Current dax/kmem driver is not holding any module reference and allows the module to be unloaded
>> anytime. Even if the memory onlined by the driver fails to be unplugged. Addition of memory_dev_type
>> as suggested by you will be different than that. Page demotion can continue to work without the
>> support of dax_pmem_type as long as we keep the older demotion order. Any new demotion order
>> rebuild will remove the the memory node which was not hotunplugged  from the demotion order. Isn't that
>> a much simpler implementation? 
> 
> Per my understanding, unbinding/binding the dax/kmem driver means
> changing the memory type of a memory device.  For example, unbinding
> dax/kmem driver may mean changing the memory type from dax_pmem_type to
> default_memory_type (or default_dram_type).  That appears strange.  But
> if we force the NUMA node to be offlined for unbinding, we can avoid to
> change the memory type to default_memory_type.
> 

If we are able to unplug all the memory, we do remove the node from N_MEMORY.
If we fail to unplug the memory, we have two options. 

1) Keep the same demotion order
2) Rebuild the demotion order which results in memory NUMA node not participating
   in demotion. 

I agree with you that we should not switch to default memory type. 

The below code demonstrate how it can be done. If we want to keep
the same demotion order, we can remove establish_demotion_target() from
the below code. 

void clear_node_memory_type(int node, struct memory_dev_type *memtype)
{
	struct memory_tier *memtier;
	pg_data_t *pgdat = NODE_DATA(node);

	mutex_lock(&memory_tier_lock);
	/*
	 * Even if we fail to unplug memory, clear the association of
	 * this node to this specific memory type.
	 */
	if (node_isset(node, memtype->nodes) && node_memory_types[node] == memtype) {

		memtier = __node_get_memory_tier(node);
		if (memtier) {
			rcu_assign_pointer(pgdat->memtier, NULL);
			synchronize_rcu();
		}
		node_clear(node, memtype->nodes);
		if (nodes_empty(memtype->nodes)) {
			list_del(&memtype->tier_sibiling);
			memtype->memtier = NULL;
			if (memtier && list_empty(&memtier->memory_types))
				destroy_memory_tier(memtier);

		}
		establish_demotion_targets();
	}
	node_memory_types[node] = NULL;
	mutex_unlock(&memory_tier_lock);
}


If we agree that we want to keep the current behavior (that is to allow kmem driver unload
even on memory unplug failure) we can go with the above change. If we are suggesting we
should prevent a driver unload, then IMHO it should be independent of memory_dev_type
(or this patch series). We should make sure we take a module reference on successful
memory online and drop it only on successful offline. 


-aneesh


