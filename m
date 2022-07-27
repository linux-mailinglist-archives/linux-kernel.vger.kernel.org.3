Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F54581EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiG0EgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbiG0EgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:36:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BC24099
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:36:16 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4MkGL017782;
        Wed, 27 Jul 2022 04:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=pfnCm8czmgjFT7Ozg90Hrv5PKhLYQ+mhAb5RDtTMtGE=;
 b=hZPUVSdho0yKdrLxUIfATou+k5FiYSC6+M4dIfqCXmR5qd0vHWAGsPQcscyK6NcDswDO
 bQlJD7EGfrDIK3S/hlB9aP01cmmvgMIWz/tUAKrIXavjk+jHcimYHe/AKecReYmNrEqt
 v/9aTYYMi7bvvnMtjHgwY6EqA3DrQUtJEJe16sxwDkt94kIBpEKnAsCACBGyjFR1yjnQ
 TMHbZfTEQqDXAdpN3U4l2v6NeMYulKrcaWr7Ia9ILTSXtv2QUXuin+Ow06Nurm9PPBF+
 n/RVHr8Plfn/cLCsvkKFFZZnLjXMkidmqdJRQN/Wi/4IZUVzcfPbLEiCP8M4aAFzWyU4 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjx9mg8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:36:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R4TMFI038767;
        Wed, 27 Jul 2022 04:36:00 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjx9mg8t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:36:00 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R4K2v1017697;
        Wed, 27 Jul 2022 04:35:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3hg97rxx47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:35:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R4ZwlR52232678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 04:35:58 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5E72805C;
        Wed, 27 Jul 2022 04:35:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25C128059;
        Wed, 27 Jul 2022 04:35:52 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.5.110])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 04:35:52 +0000 (GMT)
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
Date:   Wed, 27 Jul 2022 10:05:50 +0530
Message-ID: <87k07zrx3t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FSP-gXLhloEOnrIdQ8IOjDm20A_55tH9
X-Proofpoint-GUID: l-Ulsb6qn-cnIMzAopsk5iIOf7c1KK7s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270014
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
>>> 

....

>>> + */
>>>> +int next_demotion_node(int node)
>>>> +{
>>>> +	struct demotion_nodes *nd;
>>>> +	int target;
>>>> +
>>>> +	if (!node_demotion)
>>>> +		return NUMA_NO_NODE;
>>>> +
>>>> +	nd = &node_demotion[node];
>>>> +
>>>> +	/*
>>>> +	 * node_demotion[] is updated without excluding this
>>>> +	 * function from running.
>>>> +	 *
>>>> +	 * Make sure to use RCU over entire code blocks if
>>>> +	 * node_demotion[] reads need to be consistent.
>>>> +	 */
>>>> +	rcu_read_lock();
>>>> +	/*
>>>> +	 * If there are multiple target nodes, just select one
>>>> +	 * target node randomly.
>>>> +	 *
>>>> +	 * In addition, we can also use round-robin to select
>>>> +	 * target node, but we should introduce another variable
>>>> +	 * for node_demotion[] to record last selected target node,
>>>> +	 * that may cause cache ping-pong due to the changing of
>>>> +	 * last target node. Or introducing per-cpu data to avoid
>>>> +	 * caching issue, which seems more complicated. So selecting
>>>> +	 * target node randomly seems better until now.
>>>> +	 */
>>>> +	target = node_random(&nd->preferred);
>>> 
>>> In one of the most common cases, nodes_weight(&nd->preferred) == 1.
>>> Where, get_random_int() in node_random() just wastes CPU cycles and
>>> random entropy.  So the original struct demotion_nodes implementation
>>> appears better.
>>> 
>>>   struct demotion_nodes {
>>>          unsigned short nr;
>>>          short nodes[DEMOTION_TARGET_NODES];
>>>   };
>>> 
>>
>>
>> Is that measurable difference? using nodemask_t makes it much easier with respect to
>> implementation. IMHO if we observe the usage of node_random() to have performance impact
>> with nodes_weight() == 1 we should fix node_random() to handle that? If you strongly
>> feel we should fix this, i can opencode node_random to special case node_weight() == 1?
>
> If there's no much difference, why not just use the existing code?
> IMHO, it's your responsibility to prove your new implementation is
> better via numbers, for example, reduced code lines, with better or same
> performance.
>
> Another policy is just to use the existing code in the first version.
> Then change it based on measurement.

One of the reason I switched to nodemask_t is to make code simpler.
demotion target is essentially a node mask. 

>
> In general, I care more about the most common cases, that is, 0 or 1
> demotion target.

How about I switch to the below opencoded version. That should take care
of the above concern. 

>
>> -	target = node_random(&nd->preferred);
>> +	node_weight = nodes_weight(nd->preferred);
>> +	switch (node_weight) {
>> +	case 0:
>> +		target = NUMA_NO_NODE;
>> +		break;
>> +	case 1:
>> +		target = first_node(nd->preferred);
>> +		break;
>> +	default:
>> +		target = bitmap_ord_to_pos(nd->preferred.bits,
>> +					   get_random_int() % node_weight, MAX_NUMNODES);
>> +		break;
>> +	}
>>  
>>
