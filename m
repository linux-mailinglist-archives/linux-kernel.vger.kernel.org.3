Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BA5885FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiHCDS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHCDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:18:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8723342A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:18:46 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2733Fwdp025452;
        Wed, 3 Aug 2022 03:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=QjcNgPogLbvM2Fn56mi7nrWF2hFA8ulaHD5phxyXE14=;
 b=XXYfIaDWrvvzZGwES7qwXT+30jL8724kbMfZRlIotNORsl71MTVvLarZEOcDUWa2NWEF
 7YQ7ragwVzGxxZFEXvLmekRrPd9X7R/94NnkjyyD1RDpucS/lPGm8nef0+vcpslqoGed
 1IDZquAiUWlUlUWWxRu2+NLeA+VN5UAS/0bVz6KN+vbN34Eakfuq+VKvO7+5zO7iUdBs
 XoqV4NvCgag76Rrp4umHPbaaXiHnZ/rqOWO/BLT+NJuQnQhZVnWicCQWH9qk7+Fhe4sc
 3eIXH4YEQn1wsY0DG3MigvpdhPPnmpGIpxziMW+hQ8Tkli7QfjUQjyUUlOrd3H0XoOpQ eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqgy280xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 03:18:29 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2733ISQK029903;
        Wed, 3 Aug 2022 03:18:29 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqgy280xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 03:18:28 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27336C0r001985;
        Wed, 3 Aug 2022 03:18:28 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 3hmv99ds4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 03:18:28 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2733IRi941156984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Aug 2022 03:18:27 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FC1FC6057;
        Wed,  3 Aug 2022 03:18:27 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC11C6055;
        Wed,  3 Aug 2022 03:18:21 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.62.91])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  3 Aug 2022 03:18:21 +0000 (GMT)
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
Subject: Re: [PATCH v10 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
In-Reply-To: <87h733uyc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
 <871qu8wc6c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9f14814c-cb08-8032-caff-edcd0594ad41@linux.ibm.com>
 <87h733uyc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Wed, 03 Aug 2022 08:48:19 +0530
Message-ID: <878ro6rp50.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 99ovNddF_lANY-HwnyZu8JMSOUYxsvHV
X-Proofpoint-ORIG-GUID: Yqul1cIHAeXJaD41LjHv8Jn9K-doIERY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>
>> On 7/26/22 1:14 PM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

....

>>> +
>>>>  static void init_node_memory_tier(int node)
>>>>  {
>>>>  	int perf_level;
>>>> @@ -84,11 +285,19 @@ static void init_node_memory_tier(int node)
>>>>  	mutex_lock(&memory_tier_lock);
>>>>  
>>>>  	memtier = __node_get_memory_tier(node);
>>>> +	/*
>>>> +	 * if node is already part of the tier proceed with the
>>>> +	 * current tier value, because we might want to establish
>>>> +	 * new migration paths now. The node might be added to a tier
>>>> +	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
>>>> +	 * will have skipped this node.
>>>> +	 */
>>>>  	if (!memtier) {
>>>>  		perf_level = node_devices[node]->perf_level;
>>>>  		memtier = find_create_memory_tier(perf_level);
>>>>  		node_set(node, memtier->nodelist);
>>>>  	}
>>>> +	establish_migration_targets();
>>> 
>>> Why combines memory tiers establishing with demotion targets building?
>>> I think that it's better to separate them.   For example, if we move a
>>> set of NUMA node from one memory tier to another memory tier, we only
>>> need to run establish_migration_targets() once after moving all nodes.
>>> 
>>
>> Yes agree. I am not sure I followed your comment here. 
>>
>> Demotion target rebuilding is a separate helper. Any update to memory tiers needs rebuilding
>> of demotion targets. Also any change in node mask of memory tier needs
>> demotion target rebuild. Can you clarify the code change you are suggesting here?
>
> I think we should call establish_migration_targets() in
> migrate_on_reclaim_callback() directly.  As the example I mentioned
> above, sometimes, we don't need to call establish_migration_targets()
> for each node changing.
>

We need to hold memory_tier_lock while updating node's memory tier and
rebuilding demotion targets. All of that is done in the same function
here. An update node memory tier that allow for updating multiple node's
memory tier together would do what you mentioned above under
memory_tier_lock ie, update all the nodes memory tier and then call
establish_migration_targets() once.

-aneesh
