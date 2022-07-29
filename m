Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835A584C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiG2HUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiG2HUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:20:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32137E0DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:20:17 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T7BXlS009982;
        Fri, 29 Jul 2022 07:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=NrWjN/Xq//d2ZM9QJZOiGo4sFi8kotva+MQNHaio7A8=;
 b=lf1Fw72qlVqHg+EvWGNpCgpK7w3FJPVddFKFZiUi1p1m5qcrkihZzbLp7kCZpcLROcDD
 bY27f/q1fL+1TB+3nNvt35YHw4g0qcODJwdRay8hk2U27UaPNTL7FDVyObM256QNANaR
 psUnh3snRpW42Xd7fypcaGwRp9WiaVLWn4rtwry3ewL3nwTSzOZ/91FSxUHkktnyR3Hl
 QZYJ+eYZdUS/hkdacup+zAWnvT3JpbYaCc5i8fEEd06LTQ68zBdPfodEIkcEzDFSTmZw
 GUjOGvKHY1SyPGZRYqfutiHpKJBtKx2tcpPcC1NpvU97Ls05QKGmb17fce76ZrT77uqQ 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaxrr7y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:19:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T7ESSh020606;
        Fri, 29 Jul 2022 07:19:44 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaxrr7x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:19:44 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T6oXBh029296;
        Fri, 29 Jul 2022 07:19:43 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b485c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:19:43 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T7JgK644630522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 07:19:42 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4318E136051;
        Fri, 29 Jul 2022 07:19:42 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3CF413604F;
        Fri, 29 Jul 2022 07:19:36 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.86.244])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 07:19:36 +0000 (GMT)
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
In-Reply-To: <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
 <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Fri, 29 Jul 2022 12:49:34 +0530
Message-ID: <87bkt8s7w9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Qwy2IPak0LT6V47TGKWVZPy8D2R8gU2
X-Proofpoint-ORIG-GUID: Zi1xrvIwEb8AMboe8qUqc5RCETNTPcbb
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
>> By default, all nodes are assigned to the default memory tier which
>> is the memory tier designated for nodes with DRAM
>>
>> Set dax kmem device node's tier to slower memory tier by assigning
>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>> appears below the default memory tier in demotion order.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  drivers/dax/kmem.c           |  9 +++++++++
>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index a37622060fff..6b0d5de9a3e9 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/mm.h>
>>  #include <linux/mman.h>
>> +#include <linux/memory-tiers.h>
>>  #include "dax-private.h"
>>  #include "bus.h"
>>  
>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>  	struct resource *res[];
>>  };
>>  
>> +static struct memory_dev_type default_pmem_type  = {
>
> Why is this named as default_pmem_type?  We will not change the memory
> type of a node usually.
>

Any other suggestion? pmem_dev_type? 


>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>> +	.nodes  = NODE_MASK_NONE,
>> +};
>> +
>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  {
>>  	struct device *dev = &dev_dax->dev;
>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  		return -EINVAL;
>>  	}
>>  
>> +	init_node_memory_type(numa_node, &default_pmem_type);
>> +
>
> The memory hot-add below may fail.  So the error handling needs to be
> added.
>
> And, it appears that the memory type and memory tier of a node may be
> fully initialized here before NUMA hot-adding started.  So I suggest to
> set node_memory_types[] here only.  And set memory_dev_type->nodes in
> node hot-add callback.  I think there is the proper place to complete
> the initialization.
>
> And, in theory dax/kmem.c can be unloaded.  So we need to clear
> node_memory_types[] for nodes somewhere.
>

I guess by module exit we can be sure that all the memory managed
by dax/kmem is hotplugged out. How about something like below?

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 6b0d5de9a3e9..eb4e158012a9 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -248,6 +248,7 @@ static void __exit dax_kmem_exit(void)
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
+	unregister_memory_type(&default_pmem_type);
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index fc6b7a14da51..8355baf5b8b4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -31,6 +31,7 @@ struct memory_dev_type {
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
+void unregister_memory_type(struct memory_dev_type *memtype);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -57,6 +58,10 @@ static inline bool node_is_toptier(int node)
 #define numa_demotion_enabled	false
 static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
 {
+}
+
+static inline void unregister_memory_type(struct memory_dev_type *memtype)
+{
 
 }
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 064e0f932795..4d29ebd4c4f3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -500,6 +500,28 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type)
 	mutex_unlock(&memory_tier_lock);
 }
 
+void unregister_memory_type(struct memory_dev_type *memtype)
+{
+	int node;
+	struct memory_tier *memtier = memtype->memtier;
+
+	mutex_lock(&memory_tier_lock);
+	for(node = 0; node < MAX_NUMNODES; node++) {
+		if (node_memory_types[node] == memtype) {
+			if (!nodes_empty(memtype->nodes))
+				WARN_ON(1);
+			node_memory_types[node] = NULL;
+		}
+	}
+
+	list_del(&memtype->tier_sibiling);
+	memtype->memtier = NULL;
+	if (list_empty(&memtier->memory_types))
+		destroy_memory_tier(memtier);
+
+	mutex_unlock(&memory_tier_lock);
+}
+
 void update_node_adistance(int node, struct memory_dev_type *memtype)
 {
 	pg_data_t *pgdat;
