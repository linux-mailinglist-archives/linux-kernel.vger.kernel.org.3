Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D05A5C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiH3GrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH3GrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:47:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EEC97B18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:47:09 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U6kNxX013956;
        Tue, 30 Aug 2022 06:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tN9zGNOebMvMl6JeNx6XPM7T2n4l8EXu5fSoiRVbri4=;
 b=kRXDe9fo/cJxv57QU5J0h3i2HkWqAbUKx1T0CKmNIrNVXQVk1D/F/QcSAVfObciFP46h
 dAd3SCJ20QHcstgZ9grnADFsKBsZhhO0XLW1NH+yoqZ4EDIijJzjK2fwPeaWRA15HQ82
 0TPp5vxyyd785kmGv5FKG+VeLKv32a1pdiu1PmPaQZlGB4ZTA1Ns0HCgNbjTvOJIXcn0
 maAngYHc6Mey60okILTpxbWn0Ctv790UoaO8gW2YsxdBjCO6BHsRBoeeT8Qdzgek3tpe
 8eRK3le2HoZi9yclpq8Y4wf7TNDrCbD1utyb8RVNRXyXdK5/n5IMJLnPRSaovVK+jxgd 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9djy80b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 06:46:46 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27U6kjWP015256;
        Tue, 30 Aug 2022 06:46:45 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9djy80ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 06:46:45 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U6Zxx9020919;
        Tue, 30 Aug 2022 06:46:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8tdg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 06:46:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U6kfmS32964886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 06:46:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65DC1A40B8;
        Tue, 30 Aug 2022 06:46:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AC0EA40A9;
        Tue, 30 Aug 2022 06:46:36 +0000 (GMT)
Received: from [9.43.77.247] (unknown [9.43.77.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 06:46:36 +0000 (GMT)
Message-ID: <22cb7a8a-84fe-04c7-41ea-50eff8184dc1@linux.ibm.com>
Date:   Tue, 30 Aug 2022 12:16:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
To:     Wei Xu <weixugc@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
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
        Bharata B Rao <bharata@amd.com>
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
 <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h_UBPd74o7epoocWk6IkZjdewp5phx_p
X-Proofpoint-ORIG-GUID: ME6HgcEymkvlGqr1CmKkgFqNLslDJGBI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 12:01 PM, Wei Xu wrote:
> On Sun, Aug 28, 2022 at 11:08 PM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>> related details can be found. All allocated memory tiers will be listed
>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>
>> The nodes which are part of a specific memory tier can be listed via
>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>
>> The abstract distance range value of a specific memory tier can be listed via
>> /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>>
>> A directory hierarchy looks like
>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>> memory_tier4/
>> ├── abstract_distance
>> ├── nodes
>> ├── subsystem -> ../../../../bus/memory_tiering
>> └── uevent
>>
>> All toptier nodes are listed via
>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>
>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>> 0,2
>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>> 0,2
>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distance
>> 512 - 639
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  41 +++++
>>  mm/memory-tiers.c                             | 155 +++++++++++++++---
>>  2 files changed, 174 insertions(+), 22 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>> new file mode 100644
>> index 000000000000..6955f69a4423
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>> @@ -0,0 +1,41 @@
>> +What:          /sys/devices/virtual/memory_tiering/
>> +Date:          August 2022
>> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:   A collection of all the memory tiers allocated.
>> +
>> +               Individual memory tier details are contained in subdirectories
>> +               named by the abstract distance of the memory tier.
>> +
>> +               /sys/devices/virtual/memory_tiering/memory_tierN/
>> +
>> +
>> +What:          /sys/devices/virtual/memory_tiering/memory_tierN/
>> +               /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>> +Date:          August 2022
>> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:   Directory with details of a specific memory tier
>> +
>> +               This is the directory containing information about a particular
>> +               memory tier, memtierN, where N is derived based on abstract distance.
>> +
>> +               A smaller value of N implies a higher (faster) memory tier in the
>> +               hierarchy.
> 
> Given that abstract_distance is provided, it would be more flexible if
> we don't commit to the interface where N in memtierN also indicates
> the memory tier ordering.


IIUC this is one of the request that Johannes had ie, to be able to understand the
memory tier hierarchy based on memtier name. 

>> +
>> +               abstract_distance: The abstract distance range this specific memory
>> +               tier maps to.
> 
> I still think the name of "abstract distance" is kind of confusing
> because it is not clear what is the other object that this distance
> value is relative to.  Do we have to expose this value at this point
> if N in memtierN can already indicate the memory tier ordering?
> 

I do agree that abstract distance is confusing. But IIUC we agreed that it is much better
than other names suggested and is closer to already understood "numa distance" term.

https://lore.kernel.org/linux-mm/YuLF%2FGG8x5lQvg%2Ff@cmpxchg.org/


>> +               nodes: NUMA nodes that are part of this memory tier.
>> +
>> +
>> +What:          /sys/devices/virtual/memory_tiering/toptier_nodes
>> +Date:          August 2022
>> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:   Toptier node mask
>> +
>> +               A toptier is defined as the memory tier from which memory promotion
>> +               is not done by the kernel.
>> +
>> +               toptier_nodes: NUMA nodes that are part of all the memory tiers
>> +               above a topier tier.
> 
> Nit: topier -> toptier
> 
> toptier_nodes should be the union of NUMA nodes that are part of each
> toptier, not above a toptier, right?
> 

I will update the wording. Yes. it is the union of NUMA nodes that are 
part of each toptier. 

>> +
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index c4bd6d052a33..d4648d4e4d54 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -19,6 +19,7 @@ struct memory_tier {
>>          * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
>>          */
>>         int adistance_start;
>> +       struct device dev;
>>         /* All the nodes that are part of all the lower memory tiers. */
>>         nodemask_t lower_tier_mask;
>>  };
>> @@ -36,6 +37,13 @@ static DEFINE_MUTEX(memory_tier_lock);
>>  static LIST_HEAD(memory_tiers);
>>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>>  static struct memory_dev_type *default_dram_type;
>> +
>> +#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
>> +static struct bus_type memory_tier_subsys = {
>> +       .name = "memory_tiering",
>> +       .dev_name = "memory_tier",
>> +};
>> +
>>  #ifdef CONFIG_MIGRATION
>>  static int top_tier_adistance;
>>  /*
>> @@ -98,8 +106,73 @@ static int top_tier_adistance;
>>  static struct demotion_nodes *node_demotion __read_mostly;
>>  #endif /* CONFIG_MIGRATION */
>>
>> +static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
>> +{
>> +       nodemask_t nodes = NODE_MASK_NONE;
>> +       struct memory_dev_type *memtype;
>> +
>> +       list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
>> +               nodes_or(nodes, nodes, memtype->nodes);
>> +
>> +       return nodes;
>> +}
>> +
>> +static void memory_tier_device_release(struct device *dev)
>> +{
>> +       struct memory_tier *tier = to_memory_tier(dev);
>> +       /*
>> +        * synchronize_rcu in clear_node_memory_tier makes sure
>> +        * we don't have rcu access to this memory tier.
>> +        */
>> +       kfree(tier);
>> +}
>> +
>> +static ssize_t nodes_show(struct device *dev,
>> +                         struct device_attribute *attr, char *buf)
>> +{
>> +       int ret;
>> +       nodemask_t nmask;
>> +
>> +       mutex_lock(&memory_tier_lock);
>> +       nmask = get_memtier_nodemask(to_memory_tier(dev));
>> +       ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
>> +       mutex_unlock(&memory_tier_lock);
>> +       return ret;
>> +}
>> +static DEVICE_ATTR_RO(nodes);
>> +
>> +static ssize_t abstract_distance_show(struct device *dev,
>> +                                     struct device_attribute *attr, char *buf)
>> +{
>> +       int ret;
>> +       struct memory_tier *memtier = to_memory_tier(dev);
>> +
>> +       mutex_lock(&memory_tier_lock);
>> +       ret = sysfs_emit(buf, "%d - %d\n", memtier->adistance_start,
>> +                        memtier->adistance_start + MEMTIER_CHUNK_SIZE - 1);
>> +       mutex_unlock(&memory_tier_lock);
>> +       return ret;
>> +}
>> +static DEVICE_ATTR_RO(abstract_distance);
>> +
>> +static struct attribute *memtier_dev_attrs[] = {
>> +       &dev_attr_nodes.attr,
>> +       &dev_attr_abstract_distance.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute_group memtier_dev_group = {
>> +       .attrs = memtier_dev_attrs,
>> +};
>> +
>> +static const struct attribute_group *memtier_dev_groups[] = {
>> +       &memtier_dev_group,
>> +       NULL
>> +};
>> +
>>  static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
>>  {
>> +       int ret;
>>         bool found_slot = false;
>>         struct memory_tier *memtier, *new_memtier;
>>         int adistance = memtype->adistance;
>> @@ -123,15 +196,14 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>
>>         list_for_each_entry(memtier, &memory_tiers, list) {
>>                 if (adistance == memtier->adistance_start) {
>> -                       list_add(&memtype->tier_sibiling, &memtier->memory_types);
>> -                       return memtier;
>> +                       goto link_memtype;
>>                 } else if (adistance < memtier->adistance_start) {
>>                         found_slot = true;
>>                         break;
>>                 }
>>         }
>>
>> -       new_memtier = kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
>> +       new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>>         if (!new_memtier)
>>                 return ERR_PTR(-ENOMEM);
>>
>> @@ -142,8 +214,23 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>                 list_add_tail(&new_memtier->list, &memtier->list);
>>         else
>>                 list_add_tail(&new_memtier->list, &memory_tiers);
>> -       list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
>> -       return new_memtier;
>> +
>> +       new_memtier->dev.id = adistance >> MEMTIER_CHUNK_BITS;
>> +       new_memtier->dev.bus = &memory_tier_subsys;
>> +       new_memtier->dev.release = memory_tier_device_release;
>> +       new_memtier->dev.groups = memtier_dev_groups;
>> +
>> +       ret = device_register(&new_memtier->dev);
>> +       if (ret) {
>> +               list_del(&memtier->list);
>> +               put_device(&memtier->dev);
>> +               return ERR_PTR(ret);
>> +       }
>> +       memtier = new_memtier;
>> +
>> +link_memtype:
>> +       list_add(&memtype->tier_sibiling, &memtier->memory_types);
>> +       return memtier;
>>  }
>>
>>  static struct memory_tier *__node_get_memory_tier(int node)
>> @@ -275,17 +362,6 @@ static void disable_all_demotion_targets(void)
>>         synchronize_rcu();
>>  }
>>
>> -static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
>> -{
>> -       nodemask_t nodes = NODE_MASK_NONE;
>> -       struct memory_dev_type *memtype;
>> -
>> -       list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
>> -               nodes_or(nodes, nodes, memtype->nodes);
>> -
>> -       return nodes;
>> -}
>> -
>>  /*
>>   * Find an automatic demotion target for all memory
>>   * nodes. Failing here is OK.  It might just indicate
>> @@ -432,11 +508,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>>  static void destroy_memory_tier(struct memory_tier *memtier)
>>  {
>>         list_del(&memtier->list);
>> -       /*
>> -        * synchronize_rcu in clear_node_memory_tier makes sure
>> -        * we don't have rcu access to this memory tier.
>> -        */
>> -       kfree(memtier);
>> +       device_unregister(&memtier->dev);
>>  }
>>
>>  static bool clear_node_memory_tier(int node)
>> @@ -563,11 +635,50 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>>         return notifier_from_errno(0);
>>  }
>>
>> +static ssize_t toptier_nodes_show(struct device *dev,
>> +                                    struct device_attribute *attr, char *buf)
>> +{
>> +       int ret;
>> +       nodemask_t nmask, top_tier_mask = NODE_MASK_NONE;
>> +       struct memory_tier *memtier = to_memory_tier(dev);
>> +
>> +       mutex_lock(&memory_tier_lock);
>> +       list_for_each_entry(memtier, &memory_tiers, list) {
>> +               if (memtier->adistance_start >= top_tier_adistance)
> 
> It is kind of confusing that a tier with top_tier_adistance is not
> considered as a toptier.  Can we redefine top_tier_adistance to be the
> inclusive upper bound of toptiers?
> 

Agreed. I will fix that up by doing 

top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE - 1;
			

>> +                       break;
>> +               nmask = get_memtier_nodemask(memtier);
>> +               nodes_or(top_tier_mask, top_tier_mask, nmask);
>> +       }
>> +
>> +       ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&top_tier_mask));
>> +       mutex_unlock(&memory_tier_lock);
>> +       return ret;
>> +}
>> +static DEVICE_ATTR_RO(toptier_nodes);
>> +
>> +static struct attribute *memtier_subsys_attrs[] = {
>> +       &dev_attr_toptier_nodes.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute_group memtier_subsys_group = {
>> +       .attrs = memtier_subsys_attrs,
>> +};
>> +
>> +static const struct attribute_group *memtier_subsys_groups[] = {
>> +       &memtier_subsys_group,
>> +       NULL
>> +};
>> +
>>  static int __init memory_tier_init(void)
>>  {
>> -       int node;
>> +       int ret, node;
>>         struct memory_tier *memtier;
>>
>> +       ret = subsys_virtual_register(&memory_tier_subsys, memtier_subsys_groups);
>> +       if (ret)
>> +               panic("%s() failed to register memory tier subsystem\n", __func__);
>> +
>>  #ifdef CONFIG_MIGRATION
>>         node_demotion = kcalloc(nr_node_ids, sizeof(struct demotion_nodes),
>>                                 GFP_KERNEL);
>> --
>> 2.37.2
>>

