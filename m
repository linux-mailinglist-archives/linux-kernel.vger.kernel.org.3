Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11B53E20C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiFFGat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiFFGaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:30:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D1A527D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 23:30:08 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2564enOw024079;
        Mon, 6 Jun 2022 06:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=wilDn92u/pHLE6Lo+IivuDo1RTw2GPRc5E3AuBaMeow=;
 b=hgwQWpUYnjJenIXvGSmFcbYX3lqW6T7+XCvW1sBXasLdqeOw+4VMTpFA1g/iwD2tHX+Q
 dD/CFh4pZwbxXfA+qqBi1djIX07sU2d5xb+sJOj/lNhzhFWz44H2qcc80OEMPfFzwak0
 eMs67nejKO4p392XV5/VhxBOO6OX8F2qWb47tdfriXNe94FTmsAgbUyqBvHSCgIznHJS
 M6BQ/IG8RSeYuis1mnUhAvuB29WGldZwewiTjufOn+VF6iD0kctfZZZ8N9sD5DBMScdi
 aPDPzxUH6nkBaSiCq4Af5UuR6fw7KW9GLIp8q2ONDSb9wlUwiIn1LoSxtUDQlMZO3GuK fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr8sthy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 06:27:50 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25667psf023668;
        Mon, 6 Jun 2022 06:27:50 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr8sthq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 06:27:50 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25666TDq010058;
        Mon, 6 Jun 2022 06:27:48 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3gfy19pnq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 06:27:48 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2566RmVv25362706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 06:27:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10A7F124053;
        Mon,  6 Jun 2022 06:27:48 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6221124052;
        Mon,  6 Jun 2022 06:27:40 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.87.254])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 06:27:40 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Ying Huang <ying.huang@intel.com>
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
In-Reply-To: <eb6d7346-32a9-4fb2-61c2-a413c9f94f1c@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
 <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
 <aeced91ea9d9396e9842f5c0264391aabd291726.camel@intel.com>
 <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
 <143e40bcf46097d14514504518fdc1870fd8d4a1.camel@intel.com>
 <eb6d7346-32a9-4fb2-61c2-a413c9f94f1c@linux.ibm.com>
Date:   Mon, 06 Jun 2022 11:57:38 +0530
Message-ID: <87ilpe8fxh.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XX70NQBnsifqhW_VYf-BfYN7kGHSki-o
X-Proofpoint-GUID: _5QVbLIUPh5JRNWRHu_1NBFKH4tXXp62
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_01,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 6/6/22 11:03 AM, Ying Huang wrote:
>> On Mon, 2022-06-06 at 09:26 +0530, Aneesh Kumar K V wrote:
>>> On 6/6/22 8:19 AM, Ying Huang wrote:
>>>> On Thu, 2022-06-02 at 14:07 +0800, Ying Huang wrote:
>>>>> On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
>>>>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>>>
>>>>>> In the current kernel, memory tiers are defined implicitly via a
>>>>>> demotion path relationship between NUMA nodes, which is created
>>>>>> during the kernel initialization and updated when a NUMA node is
>>>>>> hot-added or hot-removed.  The current implementation puts all
>>>>>> nodes with CPU into the top tier, and builds the tier hierarchy
>>>>>> tier-by-tier by establishing the per-node demotion targets based
>>>>>> on the distances between nodes.
>>>>>>
>>>>>> This current memory tier kernel interface needs to be improved for
>>>>>> several important use cases,
>>>>>>
>>>>>> The current tier initialization code always initializes
>>>>>> each memory-only NUMA node into a lower tier.  But a memory-only
>>>>>> NUMA node may have a high performance memory device (e.g. a DRAM
>>>>>> device attached via CXL.mem or a DRAM-backed memory-only node on
>>>>>> a virtual machine) and should be put into a higher tier.
>>>>>>
>>>>>> The current tier hierarchy always puts CPU nodes into the top
>>>>>> tier. But on a system with HBM or GPU devices, the
>>>>>> memory-only NUMA nodes mapping these devices should be in the
>>>>>> top tier, and DRAM nodes with CPUs are better to be placed into the
>>>>>> next lower tier.
>>>>>>
>>>>>> With current kernel higher tier node can only be demoted to selected nodes on the
>>>>>> next lower tier as defined by the demotion path, not any other
>>>>>> node from any lower tier.  This strict, hard-coded demotion order
>>>>>> does not work in all use cases (e.g. some use cases may want to
>>>>>> allow cross-socket demotion to another node in the same demotion
>>>>>> tier as a fallback when the preferred demotion node is out of
>>>>>> space), This demotion order is also inconsistent with the page
>>>>>> allocation fallback order when all the nodes in a higher tier are
>>>>>> out of space: The page allocation can fall back to any node from
>>>>>> any lower tier, whereas the demotion order doesn't allow that.
>>>>>>
>>>>>> The current kernel also don't provide any interfaces for the
>>>>>> userspace to learn about the memory tier hierarchy in order to
>>>>>> optimize its memory allocations.
>>>>>>
>>>>>> This patch series address the above by defining memory tiers explicitly.
>>>>>>
>>>>>> This patch adds below sysfs interface which is read-only and
>>>>>> can be used to read nodes available in specific tier.
>>>>>>
>>>>>> /sys/devices/system/memtier/memtierN/nodelist
>>>>>>
>>>>>> Tier 0 is the highest tier, while tier MAX_MEMORY_TIERS - 1 is the
>>>>>> lowest tier. The absolute value of a tier id number has no specific
>>>>>> meaning. what matters is the relative order of the tier id numbers.
>>>>>>
>>>>>> All the tiered memory code is guarded by CONFIG_TIERED_MEMORY.
>>>>>> Default number of memory tiers are MAX_MEMORY_TIERS(3). All the
>>>>>> nodes are by default assigned to DEFAULT_MEMORY_TIER(1).
>>>>>>
>>>>>> Default memory tier can be read from,
>>>>>> /sys/devices/system/memtier/default_tier
>>>>>>
>>>>>> Max memory tier can be read from,
>>>>>> /sys/devices/system/memtier/max_tiers
>>>>>>
>>>>>> This patch implements the RFC spec sent by Wei Xu <weixugc@google.com> at [1].
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-mm/CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com/
>>>>>>
>>>>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>
>>>>> IMHO, we should change the kernel internal implementation firstly, then
>>>>> implement the kerne/user space interface.  That is, make memory tier
>>>>> explicit inside kernel, then expose it to user space.
>>>>
>>>> Why ignore this comment for v5?  If you don't agree, please respond me.
>>>>
>>>
>>> I am not sure what benefit such a rearrange would bring in? Right now I
>>> am writing the series from the point of view of introducing all the
>>> plumbing and them switching the existing demotion logic to use the new
>>> infrastructure. Redoing the code to hide all the userspace sysfs till we
>>> switch the demotion logic to use the new infrastructure doesn't really
>>> bring any additional clarity to patch review and would require me to
>>> redo the series with a lot of conflicts across the patches in the patchset.
>> 
>> IMHO, we shouldn't introduce regression even in the middle of a
>> patchset.  Each step should only rely on previous patches in the series
>> to work correctly.  In your current way of organization, after patch
>> [1/7], on a system with 2 memory tiers, the user space interface will
>> output wrong information (only 1 memory tier).  So I think the correct
>> way is to make it right inside the kenrel firstly, then expose the right
>> information to user space.
>>
>
> The patchset doesn't add additional tier until "mm/demotion/dax/kmem: 
> Set node's memory tier to MEMORY_TIER_PMEM". ie, there is no additional 
> tiers done till all the demotion logic is in place. So even if the 
> system got dax/kmem, the support for adding dax/kmem as a memory tier 
> comes later in the patch series.

Let me clarify this a bit more. This patchset doesn't change the
existing kernel behavior till "mm/demotion: Build demotion targets
based on explicit memory tiers". So there is no regression till then.
It adds a parallel framework (memory tiers to the existing demotion
logic).

I can move the patch "mm/demotion/dax/kmem: Set node's memory tier to
MEMORY_TIER_PMEM" before switching the demotion logic so that on systems
with two memory tiers (DRAM and pmem) the demotion continues to work
as expected after patch 3 ("mm/demotion: Build demotion targets based on
explicit memory tiers"). With that, there will not be any regression in
between the patch series.

-aneesh
