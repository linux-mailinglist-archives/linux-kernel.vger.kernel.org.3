Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29853EB42
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiFFMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiFFMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:03:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB11107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:02:58 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256BhERK023679;
        Mon, 6 Jun 2022 11:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=mNYcqAomcjMCNIY2xfXiNNfzUAQNbC5cOWEkd1ExDVk=;
 b=YXYAhKcQ4jVaFI67o4NRkad7mOLg+MNVlzV5PRinlxzBsud85kWLqgoWjGxIhZ2lZ36f
 pK3u7rLh6WWaOQRsf2/5qhHMVVuYKCT67I4zBNw5hjpkbVQ3u+6uegxKYkP/E1U8zz0N
 ZCXXLhABbrtcMEp5k1zQ6J6Dnev6CpUNKfsme3eFRVWhQgRL0aVPHDpnqGeUGg43ow5c
 YQdogaqxUXsNUpMwzXAGVCcvPKJPuwVyUmeikDyrlnXwk7W8EuFiEl6sx0VS5cydrkup
 yNVK5WJ9sw14lxgjVwehrol7z0HpX5l6y5L7Yoaf2ZM9AgvgQaIEIiZrbdh3KZ4qa6Rd Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr8xuyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 11:54:37 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 256BCcUq002777;
        Mon, 6 Jun 2022 11:54:36 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr8xuyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 11:54:36 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256BouP2031189;
        Mon, 6 Jun 2022 11:54:35 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3gfy19rjq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 11:54:35 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256BsXcv39846144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 11:54:34 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD61B13605E;
        Mon,  6 Jun 2022 11:54:33 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 192F1136055;
        Mon,  6 Jun 2022 11:54:26 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.87.254])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 11:54:25 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
In-Reply-To: <a844c8c9-e1e1-2ccb-d58c-a5a608afabc0@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
 <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
 <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
 <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
 <a844c8c9-e1e1-2ccb-d58c-a5a608afabc0@linux.ibm.com>
Date:   Mon, 06 Jun 2022 17:24:22 +0530
Message-ID: <87fski80sx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e9XANbfbnTQRfKE9npO-q_j7P43zommZ
X-Proofpoint-GUID: b4wUX6oEnUwYPSCMhchLWvdg36x7s10q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_03,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 6/6/22 3:41 PM, Bharata B Rao wrote:
>> On 6/3/2022 2:34 PM, Aneesh Kumar K V wrote:
>>> On 6/2/22 12:06 PM, Bharata B Rao wrote:
>>>> On 6/1/2022 7:19 PM, Aneesh Kumar K V wrote:
>>>>> On 6/1/22 11:59 AM, Bharata B Rao wrote:
>>>>>> I was experimenting with this patchset and found this behaviour.
>>>>>> Here's what I did:
>>>>>>
>>>>>> Boot a KVM guest with vNVDIMM device which ends up with device_dax
>>>>>> driver by default.
>>>>>>
>>>>>> Use it as RAM by binding it to dax kmem driver. It now appears as
>>>>>> RAM with a new NUMA node that is put to memtier1 (the existing tier
>>>>>> where DRAM already exists)
>>>>>>
>>>>>
>>>>> That should have placed it in memtier2.
>>>>>
>>>>>> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
>>>>>> that expected to happen automatically when a node with dax kmem
>>>>>> device comes up?
>>>>>>
>>>>>
>>>>> This can happen if we have added the same NUMA node to memtier1 before dax kmem driver initialized the pmem memory. Can you check before the above node_set_memory_tier_rank() whether the specific NUMA node is already part of any memory tier?
>>>>
>>>> When we reach node_set_memory_tier_rank(), node1 (that has the pmem device)
>>>> is already part of memtier1 whose nodelist shows 0-1.
>>>>
>>>
>>> can you find out which code path added node1 to memtier1?
>> 
>>   node_set_memory_tier_rank+0x63/0x80
>>   migrate_on_reclaim_callback+0x40/0x4d
>>   blocking_notifier_call_chain+0x68/0x90
>>   memory_notify+0x1b/0x20
>>   online_pages+0x257/0x2f0
>>   memory_subsys_online+0x99/0x150
>>   device_online+0x65/0x90
>>   online_memory_block+0x1b/0x20
>>   walk_memory_blocks+0x85/0xc0
>>   ? generic_online_page+0x40/0x40
>>   add_memory_resource+0x1fa/0x2d0
>>   add_memory_driver_managed+0x80/0xc0
>>   dev_dax_kmem_probe+0x1af/0x250
>>   dax_bus_probe+0x6e/0xa0
>> 
>> After this the explicit call to node_set_memory_tier_rank(numa_node, MEMORY_RANK_PMEM)
>> from dev_dax_kmem_probe() finds that the memtier is already set.
>> 
>>> Do you have regular memory also appearing on node1?
>> 
>> No, regular memory is on Node0.
>> 
>
> Thanks for the stack trace. I was getting the kvm setup on my laptop to 
> test this. We should move node_set_mem_tier() early. You had automatic 
> online on memory hotplug
>
> 	/* online pages if requested */
> 	if (mhp_default_online_type != MMOP_OFFLINE)
> 		walk_memory_blocks(start, size, NULL, online_memory_block);
>
>
> which caused memory to be onlined before we could do node_set_mem_tier. 
> That is a bug on my side. Will send you a change after testing .
>
Can you try this change?

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 7a11c387fbbc..905609260dda 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -94,6 +94,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		goto err_reg_mgid;
 	data->mgid = rc;
 
+	/*
+	 * This get called before the node is brought online. That
+	 * is because depending on the value of mhp_default_online_type
+	 * the kernel will online the memory along with hotplug
+	 * operation. Add the new memory tier before we try to bring
+	 * memory blocks online. Otherwise new node will get added to
+	 * the default memory tier via hotplug callbacks.
+	 */
+#ifdef CONFIG_TIERED_MEMORY
+	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
+#endif
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
@@ -148,9 +159,6 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
-#ifdef CONFIG_TIERED_MEMORY
-	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
-#endif
 	return 0;
 
 err_request_mem:

