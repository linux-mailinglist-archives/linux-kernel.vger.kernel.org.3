Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D46584B96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiG2GSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiG2GSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:18:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3554D12AE5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:18:02 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T61jeZ001082;
        Fri, 29 Jul 2022 06:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Xtxiki/EPMi4MAjwNLuKgeSTBr+MppvzMGFAOZ67pUw=;
 b=hz1z2Ph09Aifx53FCC9wrCuiOLcAaaLUY5D28nko6JesxduB9s2GS35D227Vz4nPTih2
 UX5kp13FdHwCqlaBYsAIcwk7fHav1AVTulS0CTu8JavBZyxHtKFqDrzq5k+9UbWDT+BP
 lMgIAwNN5tJCpiLW/HmIbOhggVFgCP/XcOrUjPndU3grnlKX85kWvWFTdb9JcZHAO6ax
 e9hnpPxNen9rhXNjdkV0efiTXNNvjcZzXAB4XNL5jiVFUeuMxQyCtg6g5rmNFdf9jsXS
 x6++iNHA1MnPioLtGurxlQZjbSsH6gdrpItSz63FzEZs7UyaxI/6v4zyRTAXdtCY2Thb vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm9x1rg0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:17:47 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T62vnF009581;
        Fri, 29 Jul 2022 06:17:47 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm9x1rfyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:17:47 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T65uTo013507;
        Fri, 29 Jul 2022 06:17:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3hg9794u5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:17:46 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6Hj4K42336750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:17:45 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A7FE136059;
        Fri, 29 Jul 2022 06:17:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D30913605E;
        Fri, 29 Jul 2022 06:17:40 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.86.244])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:17:40 +0000 (GMT)
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
Subject: Re: [PATCH v11 0/8] mm/demotion: Memory tiers and demotion
In-Reply-To: <87a68smqov.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <87a68smqov.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Fri, 29 Jul 2022 11:47:38 +0530
Message-ID: <87edy4sarh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ev1QFyMJhyf9eAV1KQSx-1o3DvFlAxe9
X-Proofpoint-GUID: oRmxRDiqmTdaBijarp5k21uis49r95UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290023
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
>> The current kernel has the basic memory tiering support: Inactive pages on a
>> higher tier NUMA node can be migrated (demoted) to a lower tier NUMA node to
>> make room for new allocations on the higher tier NUMA node. Frequently accessed
>> pages on a lower tier NUMA node can be migrated (promoted) to a higher tier NUMA
>> node to improve the performance.
>>
>> In the current kernel, memory tiers are defined implicitly via a demotion path
>> relationship between NUMA nodes, which is created during the kernel
>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>> current implementation puts all nodes with CPU into the top tier, and builds the
>> tier hierarchy tier-by-tier by establishing the per-node demotion targets based
>> on the distances between nodes.
>>
>> This current memory tier kernel interface needs to be improved for several
>> important use cases:
>>
>> * The current tier initialization code always initializes each memory-only NUMA
>>   node into a lower tier. But a memory-only NUMA node may have a high
>>   performance memory device (e.g. a DRAM device attached via CXL.mem or a
>>   DRAM-backed memory-only node on a virtual machine) and should be put into a
>>   higher tier.
>>
>> * The current tier hierarchy always puts CPU nodes into the top tier. But on a
>>   system with HBM (e.g. GPU memory) devices, these memory-only HBM NUMA nodes
>>   should be in the top tier, and DRAM nodes with CPUs are better to be placed
>>   into the next lower tier.
>>
>> * Also because the current tier hierarchy always puts CPU nodes into the top
>>   tier, when a CPU is hot-added (or hot-removed) and triggers a memory node from
>>   CPU-less into a CPU node (or vice versa), the memory tier hierarchy gets
>>   changed, even though no memory node is added or removed. This can make the
>>   tier hierarchy unstable and make it difficult to support tier-based memory
>>   accounting.
>>
>> * A higher tier node can only be demoted to selected nodes on the next lower
>>   tier as defined by the demotion path, not any other node from any lower tier.
>>   This strict, hard-coded demotion order does not work in all use cases (e.g.
>>   some use cases may want to allow cross-socket demotion to another node in the
>>   same demotion tier as a fallback when the preferred demotion node is out of
>>   space), and has resulted in the feature request for an interface to override
>>   the system-wide, per-node demotion order from the userspace. This demotion
>>   order is also inconsistent with the page allocation fallback order when all
>>   the nodes in a higher tier are out of space: The page allocation can fall back
>>   to any node from any lower tier, whereas the demotion order doesn't allow
>>   that.
>>
>> This patch series make the creation of memory tiers explicit under
>> the control of device driver.
>>
>> Memory Tier Initialization
>> ==========================
>>
>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>> a specific type. The memory type of a device is represented by its abstract 
>> distance. A memory tier corresponds to a range of abstract distance. This allows
>> for classifying memory devices with a specific performance range into a memory
>> tier.
>>
>> By default, all memory nodes are assigned to the default tier with
>> abstract distance 512.
>>
>> A device driver can move its memory nodes from the default tier. For example,
>> PMEM can move its memory nodes below the default tier, whereas GPU can move its
>> memory nodes above the default tier.
>>
>> The kernel initialization code makes the decision on which exact tier a memory
>> node should be assigned to based on the requests from the device drivers as well
>> as the memory device hardware information provided by the firmware.
>>
>> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>
> Some patch description of [0/8] is same as that of [1/8] originally.  It
> appears that you revised [1/8], but forget to revise [0/8] too.  Please
> do that.

I just sent v12 making sure smaller value of abstract distance imply
faster(higher) memory tier. I missed in that in v11. 

-aneesh
