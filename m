Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FD575F59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiGOK1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGOK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:27:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AC796A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:27:42 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FAEhP5012829;
        Fri, 15 Jul 2022 10:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ljcCPI6VBeoE/YKD7gvqKlwvNUZ2NIM3PcAHtM6cHgU=;
 b=B4hzHIHZdHeu82W7X+1Qdj0TBE6lCB5yf4q2ER6ijee34NqUMAxSBJAOD9xK/jeG9ZAC
 yPkCoIgrdvoGZCsC+9UTJkhMdw+9YqgRYyUhYDkIpMHsyLLlsFXd16U9okD+PwNTgnd7
 hy6m5rAVk3UZLeodiiQNMz3PHn8oeeYl3NvdTR1lOMGGZ1TVBx3DzRHClhnjpPTBqtjc
 YJbY0Ni/Oz4xvp8snk6qE8lshemaQa9/Ys4PD4N7SFuzT4QWYbZLW8EXOaqQ8SkeFy3T
 MwHZGi52EyvjyqeHEtbgd74b55cYBTYz3knfuq9YslZjDrSVRjq7BohRMdK5bztRE0rA vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb6aar8g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:27:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26FAMoDA009322;
        Fri, 15 Jul 2022 10:27:24 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb6aar8fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:27:24 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26FAL5PP012543;
        Fri, 15 Jul 2022 10:27:23 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3ha4qy4mjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:27:23 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26FARMY010945086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 10:27:22 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67A9328058;
        Fri, 15 Jul 2022 10:27:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F5F28059;
        Fri, 15 Jul 2022 10:27:16 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.84.38])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 10:27:16 +0000 (GMT)
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
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
In-Reply-To: <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
 <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
Date:   Fri, 15 Jul 2022 15:57:13 +0530
Message-ID: <87sfn2u0vy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wrTTQUtjZ00XsQSOjA13paOB-cp_vEwS
X-Proofpoint-ORIG-GUID: wpwQGMIZIpkMN9fqm-FTtX-U0qcpmWJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_03,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

....

> 
>> You dropped the original sysfs interface patches from the series, but
>> the kernel internal implementation is still for the original sysfs
>> interface.  For example, memory tier ID is for the original sysfs
>> interface, not for the new proposed sysfs interface.  So I suggest you
>> to implement with the new interface in mind.  What do you think about
>> the following design?
>> 
>
> Sorry I am not able to follow you here. This patchset completely drops
> exposing memory tiers to userspace via sysfs. Instead it allow
> creation of memory tiers with specific tierID from within the kernel/device driver.
> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
>
>
>> - Each NUMA node belongs to a memory type, and each memory type
>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>   a "distance".  For simplicity, we can start with static distances, for
>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>   node can be recorded in a global array,
>> 
>>     int node_distances[MAX_NUMNODES];
>> 
>>   or, just
>> 
>>     pgdat->distance
>> 
>
> I don't follow this. I guess you are trying to have a different design.
> Would it be much easier if you can write this in the form of a patch? 
>
>
>> - Each memory tier corresponds to a range of distance, for example,
>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>> 
>> - The core API of memory tier could be
>> 
>>     struct memory_tier *find_create_memory_tier(int distance);
>> 
>>   it will find the memory tier which covers "distance" in the memory
>>   tier list, or create a new memory tier if not found.
>> 
>
> I was expecting this to be internal to dax kmem. How dax kmem maps
> "abstract distance" to a memory tier. At this point this patchset is
> keeping all that for a future patchset. 
>

This shows how i was expecting "abstract distance" to be integrated.

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 82cae08976bc..1281aec63986 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1332,6 +1332,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	ndr_desc.mapping = &mapping;
 	ndr_desc.num_mappings = 1;
 	ndr_desc.nd_set = &p->nd_set;
+	ndr_desc.memtier_distance = PMEM_MEMTIER_DEFAULT_DISTANCE;
 
 	if (p->hcall_flush_required) {
 		set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae5f4acf2675..7b8cf1f15562 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2641,6 +2641,10 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
 	}
 
+	/*
+	 * We may want to look at SLIT/HMAT to fine tune this
+	 */
+	ndr_desc->memtier_distance  =  PMEM_MEMTIER_DEFAULT_DISTANCE;
 	/*
 	 * Persistence domain bits are hierarchical, if
 	 * ACPI_NFIT_CAPABILITY_CACHE_FLUSH is set then
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..708a40cf29c0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -570,8 +570,9 @@ static void dax_region_unregister(void *region)
 }
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct range *range, int target_node, unsigned int align,
-		unsigned long flags)
+				    struct range *range, int target_node,
+				    int memtier_distance, unsigned int align,
+				    unsigned long flags)
 {
 	struct dax_region *dax_region;
 
@@ -599,6 +600,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 	dax_region->align = align;
 	dax_region->dev = parent;
 	dax_region->target_node = target_node;
+	dax_region->memtier_distance = memtier_distance;
 	ida_init(&dax_region->ida);
 	dax_region->res = (struct resource) {
 		.start = range->start,
@@ -1370,6 +1372,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	dev_dax->memtier_distance = dax_region->memtier_distance;
 	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index fbb940293d6d..3de4292392dd 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,8 +13,9 @@ void dax_region_put(struct dax_region *dax_region);
 
 #define IORESOURCE_DAX_STATIC (1UL << 0)
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
-		struct range *range, int target_node, unsigned int align,
-		unsigned long flags);
+				    struct range *range, int target_node,
+				    int memtier_distance, unsigned int align,
+				    unsigned long flags);
 
 struct dev_dax_data {
 	struct dax_region *dax_region;
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 1c974b7caae6..5db382c78d0e 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -31,6 +31,7 @@ void dax_bus_exit(void);
 struct dax_region {
 	int id;
 	int target_node;
+	int memtier_distance;
 	struct kref kref;
 	struct device *dev;
 	unsigned int align;
@@ -64,6 +65,7 @@ struct dev_dax {
 	struct dax_device *dax_dev;
 	unsigned int align;
 	int target_node;
+	int memtier_distance;
 	int id;
 	struct ida ida;
 	struct device dev;
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1bf040dbc834..b9f80971c07b 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -26,7 +26,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	range.start = res->start;
 	range.end = res->end;
 	dax_region = alloc_dax_region(dev, pdev->id, &range, mri->target_node,
-			PMD_SIZE, 0);
+				      mri->memtier_distance, PMD_SIZE, 0);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 0c03889286ac..32878bd96f09 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -45,13 +45,18 @@ struct dax_kmem_data {
 static unsigned int dax_kmem_memtier = MEMORY_TIER_PMEM;
 module_param(dax_kmem_memtier, uint, 0644);
 
+int find_memtier_from_distance(struct dev_dax *dev_dax)
+{
+	return dax_kmem_memtier + dev_dax->memtier_distance;
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long total_len = 0;
 	struct dax_kmem_data *data;
 	int i, rc, mapped = 0;
-	int numa_node;
+	int numa_node, mem_tier;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -150,7 +155,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	}
 
 	dev_set_drvdata(dev, data);
-	node_create_and_set_memory_tier(numa_node, dax_kmem_memtier);
+	mem_tier = find_memtier_from_distance(dev_dax);
+	node_create_and_set_memory_tier(numa_node, mem_tier);
 	return 0;
 
 err_request_mem:
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index f050ea78bb83..1b51fc0490de 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -54,8 +54,10 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	range = pgmap.range;
 	range.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &range,
-			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			IORESOURCE_DAX_STATIC);
+				      nd_region->target_node,
+				      nd_region->memtier_distance,
+				      le32_to_cpu(pfn_sb->align),
+				      IORESOURCE_DAX_STATIC);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ec5219680092..cf7a379a2220 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -416,6 +416,7 @@ struct nd_region {
 	u64 ndr_size;
 	u64 ndr_start;
 	int id, num_lanes, ro, numa_node, target_node;
+	int memtier_distance;
 	void *provider_data;
 	struct kernfs_node *bb_state;
 	struct badblocks bb;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index d976260eca7a..f2067de8d660 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1019,6 +1019,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	nd_region->ro = ro;
 	nd_region->numa_node = ndr_desc->numa_node;
 	nd_region->target_node = ndr_desc->target_node;
+	nd_region->memtier_distance = ndr_desc->memtier_distance;
 	ida_init(&nd_region->ns_ida);
 	ida_init(&nd_region->btt_ida);
 	ida_init(&nd_region->pfn_ida);
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 0d61e07b6827..bf20e018074f 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -121,6 +121,7 @@ struct nd_region_desc {
 	int num_lanes;
 	int numa_node;
 	int target_node;
+	int memtier_distance;
 	unsigned long flags;
 	struct device_node *of_node;
 	int (*flush)(struct nd_region *nd_region, struct bio *bio);
@@ -224,6 +225,8 @@ struct nvdimm_fw_ops {
 	int (*arm)(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arg);
 };
 
+#define PMEM_MEMTIER_DEFAULT_DISTANCE  10
+
 void badrange_init(struct badrange *badrange);
 int badrange_add(struct badrange *badrange, u64 addr, u64 length);
 void badrange_forget(struct badrange *badrange, phys_addr_t start,
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c04c4fd2e209..5850e2bbbfed 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -6,6 +6,7 @@
 
 struct memregion_info {
 	int target_node;
+	int memtier_distance;
 };
 
 #ifdef CONFIG_MEMREGION
