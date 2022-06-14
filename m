Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D202554AB62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiFNICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiFNICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:02:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B0F12D0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:02:12 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E7sB8u027890;
        Tue, 14 Jun 2022 08:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K5LXAIPupWynTXwdULpTGfT4z39fRZOp7Y3uQ9syZ54=;
 b=e1DkJqJoA7SnpAmwJzVq+Y6urAk3uFgL4VBYar693doQxFJNiXrAtbH7rLhJPNcrJ44E
 I9sA19mxZCPrn1nhjyfSUlgnVqf2Jt+pJ/mcnVn50v95JVi2PblhDHkx6deYipAtBL/7
 rI0C/gpXqSG9Lmyzjw034BnlJH99fcfy/LXnhB4M8Q0nPdcmujHP3KrA/qVp62SIHrg6
 MBTeOzWqSFvnoDXh1/KFW0UlfXuIgte2loMj82X8FKjds3Meu/CqpkCBAojlrZPoh5Eh
 VeyXkmay0DBYFjV0cEUYlEUTUoD2JMb3WZYgid454/KGZncFTkD+c1lprMUlzHiMpvSF HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbqr4xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:01:48 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25E7vjsG013013;
        Tue, 14 Jun 2022 08:01:47 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbqr4wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:01:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25E7oteM001927;
        Tue, 14 Jun 2022 08:01:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3gmjp93ya2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:01:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25E81hhn18153818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 08:01:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 649004C04E;
        Tue, 14 Jun 2022 08:01:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCF134C040;
        Tue, 14 Jun 2022 08:01:38 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 08:01:38 +0000 (GMT)
Message-ID: <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
Date:   Tue, 14 Jun 2022 13:31:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org>
 <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
 <Yqdc4DE8gYJ3zesO@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Yqdc4DE8gYJ3zesO@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _XOubV-mgcH6Tw28fey5-n4b2_A0mJ7G
X-Proofpoint-ORIG-GUID: MPKwk0R5BrplEnQ0I1I1qmg4z9anJeOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206140028
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 9:20 PM, Johannes Weiner wrote:
> On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:
>> On 6/13/22 7:35 PM, Johannes Weiner wrote:
>>> On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
>>>> I'm not sure completely read only is flexible enough (though mostly RO is fine)
>>>> as we keep sketching out cases where any attempt to do things automatically
>>>> does the wrong thing and where we need to add an extra tier to get
>>>> everything to work.  Short of having a lot of tiers I'm not sure how
>>>> we could have the default work well.  Maybe a lot of "tiers" is fine
>>>> though perhaps we need to rename them if going this way and then they
>>>> don't really work as current concept of tier.
>>>>
>>>> Imagine a system with subtle difference between different memories such
>>>> as 10% latency increase for same bandwidth.  To get an advantage from
>>>> demoting to such a tier will require really stable usage and long
>>>> run times. Whilst you could design a demotion scheme that takes that
>>>> into account, I think we are a long way from that today.
>>>
>>> Good point: there can be a clear hardware difference, but it's a
>>> policy choice whether the MM should treat them as one or two tiers.
>>>
>>> What do you think of a per-driver/per-device (overridable) distance
>>> number, combined with a configurable distance cutoff for what
>>> constitutes separate tiers. E.g. cutoff=20 means two devices with
>>> distances of 10 and 20 respectively would be in the same tier, devices
>>> with 10 and 100 would be in separate ones. The kernel then generates
>>> and populates the tiers based on distances and grouping cutoff, and
>>> populates the memtier directory tree and nodemasks in sysfs.
>>>
>>
>> Right now core/generic code doesn't get involved in building tiers. It just
>> defines three tiers where drivers could place the respective devices they
>> manage. The above suggestion would imply we are moving quite a lot of policy
>> decision logic into the generic code?.
> 
> No. The driver still chooses its own number, just from a wider
> range. The only policy in generic code is the distance cutoff for
> which devices are grouped into tiers together.
> 
>> At some point, we will have to depend on more attributes other than
>> distance(may be HMAT?) and each driver should have the flexibility to place
>> the device it is managing in a specific tier? By then we may decide to
>> support more than 3 static tiers which the core kernel currently does.
> 
> If we start with a larger possible range of "distance" values right
> away, we can still let the drivers ballpark into 3 tiers for now (100,
> 200, 300). But it will be easier to take additional metrics into
> account later and fine tune accordingly (120, 260, 90 etc.) without
> having to update all the other drivers as well.
> 
>> If the kernel still can't make the right decision, userspace could rearrange
>> them in any order using rank values. Without something like rank, if
>> userspace needs to fix things up,  it gets hard with device
>> hotplugging. ie, the userspace policy could be that any new PMEM tier device
>> that is hotplugged, park it with a very low-rank value and hence lowest in
>> demotion order by default. (echo 10 >
>> /sys/devices/system/memtier/memtier2/rank) . After that userspace could
>> selectively move the new devices to the correct memory tier?
> 
> I had touched on this in the other email.
> 
> This doesn't work if two drivers that should have separate policies
> collide into the same tier - which is very likely with just 3 tiers.
> So it seems to me the main usecase for having a rank tunable falls
> apart rather quickly until tiers are spaced out more widely. And it
> does so at the cost of an, IMO, tricky to understand interface.
> 

Considering the kernel has a static map for these tiers, how can two drivers
end up using the same tier? If a new driver is going to manage a memory
device that is of different characteristics than the one managed by dax/kmem,
we will end up adding 

#define MEMORY_TIER_NEW_DEVICE 4

The new driver will never use MEMORY_TIER_PMEM

What can happen is two devices that are managed by DAX/kmem that
should be in two memory tiers get assigned the same memory tier
because the dax/kmem driver added both the device to the same memory tier.

In the future we would avoid that by using more device properties like HMAT
to create additional memory tiers with different rank values. ie, we would
do in the dax/kmem create_tier_from_rank() .


> In the other email I had suggested the ability to override not just
> the per-device distance, but also the driver default for new devices
> to handle the hotplug situation.
> 

I understand that the driver override will be done via module parameters.
How will we implement device override? For example in case of dax/kmem driver
the device override will be per dax device? What interface will we use to set the override? 

IIUC in the above proposal the dax/kmem will do

node_create_and_set_memory_tier(numa_node, get_device_tier_index(dev_dax));

get_device_tier_index(struct dev_dax *dev)
{
    return dax_kmem_tier_index; // module parameter
}

Are you suggesting to add a dev_dax property to override the tier defaults? 

> This should be less policy than before. Driver default and per-device
> distances (both overridable) combined with one tunable to set the
> range of distances that get grouped into tiers.
> 

Can you elaborate more on how distance value will be used? The device/device NUMA node can have
different distance value from other NUMA nodes. How do we group them?
for ex: earlier discussion did outline three different topologies. Can you
ellaborate how we would end up grouping them using distance?

For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
so how will we classify node 2?


Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.

		  20
  Node 0 (DRAM)  ----  Node 1 (DRAM)
       |        \   /       |
       | 30    40 X 40      | 30
       |        /   \       |
  Node 2 (PMEM)  ----  Node 3 (PMEM)
		  40

node distances:
node   0    1    2    3
   0  10   20   30   40
   1  20   10   40   30
   2  30   40   10   40
   3  40   30   40   10

Node 0 & 1 are DRAM nodes.
Node 2 is a PMEM node and closer to node 0.

		  20
  Node 0 (DRAM)  ----  Node 1 (DRAM)
       |            /
       | 30       / 40
       |        /
  Node 2 (PMEM)

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   40
   2  30   40   10


Node 0 is a DRAM node with CPU.
Node 1 is a GPU node.
Node 2 is a PMEM node.
Node 3 is a large, slow DRAM node without CPU.

		    100
     Node 0 (DRAM)  ----  Node 1 (GPU)
    /     |               /    |
   /40    |30        120 /     | 110
  |       |             /      |
  |  Node 2 (PMEM) ----       /
  |        \                 /
   \     80 \               /
    ------- Node 3 (Slow DRAM)

node distances:
node    0    1    2    3
   0   10  100   30   40
   1  100   10  120  110
   2   30  120   10   80
   3   40  110   80   10

> With these parameters alone, you can generate an ordered list of tiers
> and their devices. The tier numbers make sense, and no rank is needed.
> 
> Do you still need the ability to move nodes by writing nodemasks? I
> don't think so. Assuming you would never want to have an actually
> slower device in a higher tier than a faster device, the only time
> you'd want to move a device is when the device's distance value is
> wrong. So you override that (until you update to a fixed kernel).

