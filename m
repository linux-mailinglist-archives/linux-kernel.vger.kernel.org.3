Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3481584C83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiG2HZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiG2HY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:24:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D117D783
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:24:58 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T7BlZd010632;
        Fri, 29 Jul 2022 07:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=aQUH8yXw5a0UzXZ9f/Q9Y4GT7vvRL0B1syGLYI6jQfU=;
 b=pHXmbSuAxobnovzNzEzO3oyelos/x/3dP3fD1Id7/ZtUFFmtgHhHGZ7JsRxXcSmPiveX
 66O/EAqSMdeWRPLqXHdaGZkct55A+e1/O5+edFvbyYxD3AAsT8A59qEGsF26y/Oqoeny
 LLcwtOEBfRO+D0/YvqVFH3Xnm/6tMk3+VCFPS/PzQbAzOdXe3/W5G9FnHka33emtQ4iI
 ctlSMau/habVHJyppsFVjGklwLhOK/VFSWW7aGNRU07LfHCeN4cU5vUf/3xK03DFA6D1
 aCR1qcBy+DZFIPhRvBMvR6/03MtcLd296TcsNgGfQgSSs+3ewAfnuoY7FdD7VVmRMzrY oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaxrrc45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:24:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T7H94k003368;
        Fri, 29 Jul 2022 07:24:47 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaxrrc3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:24:47 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T7Jp7K001625;
        Fri, 29 Jul 2022 07:24:46 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3hg97956qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:24:46 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T7OjsH36700418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 07:24:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7E27805C;
        Fri, 29 Jul 2022 07:24:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 340827805E;
        Fri, 29 Jul 2022 07:24:39 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.86.244])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 07:24:38 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH v11 1/8] mm/demotion: Add support for explicit memory tiers
In-Reply-To: <871qu4mo5a.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
 <871qu4mo5a.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Fri, 29 Jul 2022 12:54:36 +0530
Message-ID: <874jz0s7nv.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iiamhCuVrxw7GzooEdNlkk-c22qPeiw3
X-Proofpoint-ORIG-GUID: yhiX8T0S1i1p0qHGIYFx4hf5bp1OXMrZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> In the current kernel, memory tiers are defined implicitly via a demotion path
>> relationship between NUMA nodes, which is created during the kernel
>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>> current implementation puts all nodes with CPU into the highest tier, and builds
>> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
>> based on the distances between nodes.
>>
>> This current memory tier kernel implementation needs to be improved for several
>> important use cases,
>>
>> The current tier initialization code always initializes each memory-only NUMA
>> node into a lower tier. But a memory-only NUMA node may have a high performance
>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>> should be put into a higher tier.
>>
>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>> the next lower tier.
>>
>> With current kernel higher tier node can only be demoted to nodes with shortest
>> distance on the next lower tier as defined by the demotion path, not any other
>> node from any lower tier. This strict, demotion order does not work in all use
>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>> node in the same demotion tier as a fallback when the preferred demotion node is
>> out of space), This demotion order is also inconsistent with the page allocation
>> fallback order when all the nodes in a higher tier are out of space: The page
>> allocation can fall back to any node from any lower tier, whereas the demotion
>> order doesn't allow that.
>>
>> This patch series address the above by defining memory tiers explicitly.
>>
>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>> a specific type. The memory type of a device is represented by its abstract
>> distance. A memory tier corresponds to a range of abstract distance. This allows
>> for classifying memory devices with a specific performance range into a memory
>> tier.
>>
>> This patch configures the range/chunk size to be 128. The default DRAM
>> abstract distance is 512. We can have 4 memory tiers below the default DRAM
>> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
>> Slower memory devices like persistent memory will have abstract distance below
>> the default DRAM level and hence will be placed in these 4 lower tiers.
>
> For abstract distance, the lower value means higher performance, higher
> value means lower performance.  So the abstract distance of PMEM should
> be smaller than that of DRAM.

I noticed that after sending v11 and did send v12 fixing that already
which can be found 

https://lore.kernel.org/linux-mm/20220729061349.968148-1-aneesh.kumar@linux.ibm.com

>
>> A kernel parameter is provided to override the default memory tier.
>
> Forget to delete?

yes. Also fixed in v12.

-aneesh
