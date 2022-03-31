Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C664ED59B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiCaIaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiCaI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:29:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE381C4040
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:28:06 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V5Kc4Z020599;
        Thu, 31 Mar 2022 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=GGGJaE00gOrjgZdabfyYCJtDb6BGSQgQEH3k88tIlRo=;
 b=Qeh2JP6NyRdcaqHDZK3uo488MlysllwIVoN0I8cQnmO/yQMESXH0GFuakgVfXVVehDyD
 RF2YoOGnsfqA6/PjsJyh0emvU5Z/oAQYi1Ee9wxDZPWzh0RfjABqM7/gFz7IBXhqLwa7
 jm+IxredLRZd7TwYMwUDs7LztXp/YnQUvcxoCv/zWJfKi2zQSfMsVi0ZTrODVuLzLi/r
 XUxUWzDTLkBvEgt8dOLhq8TYn2tESuZ6+QxsPiHmVFHVjMSLAZ5fCjKgkpHAxGH2VIGT
 iI9hPxXjk+oGhWFGnnQRANqMlCjcYnS3auJwl1mPaiVWBef32IGGO4FC7HHuHvuk6KeK 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f562rke7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 08:27:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22V7vugE029229;
        Thu, 31 Mar 2022 08:27:59 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f562rke6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 08:27:59 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22V8KIwg027941;
        Thu, 31 Mar 2022 08:27:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3f1tfa335c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 08:27:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22V8Rvi833489386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 08:27:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 697D2112064;
        Thu, 31 Mar 2022 08:27:57 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53E5611206B;
        Thu, 31 Mar 2022 08:27:54 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.54.171])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Mar 2022 08:27:54 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, Fan Du <fan.du@intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
In-Reply-To: <87h77ebn6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87lewrxsv1.fsf@linux.ibm.com>
 <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87ilruy5zt.fsf@linux.ibm.com>
 <87h77ebn6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Thu, 31 Mar 2022 13:57:51 +0530
Message-ID: <87fsmyy1a0.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A5R0MY7PzIBAFlNfYwZfb7priRXUNdV1
X-Proofpoint-ORIG-GUID: kf_gPHTzIg8Y555QBZhbCe4l2QCmKu4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_03,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> Hi, Jagdish,
>>>>>
>>>>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>>>>
>>>>
>>>> ...
>>>>
>>>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>>>> only nodes, and node 4 is slowest memory only node,
>>>>>>
>>>>>> available: 5 nodes (0-4)
>>>>>> node 0 cpus: 0 1
>>>>>> node 0 size: n MB
>>>>>> node 0 free: n MB
>>>>>> node 1 cpus: 2 3
>>>>>> node 1 size: n MB
>>>>>> node 1 free: n MB
>>>>>> node 2 cpus:
>>>>>> node 2 size: n MB
>>>>>> node 2 free: n MB
>>>>>> node 3 cpus:
>>>>>> node 3 size: n MB
>>>>>> node 3 free: n MB
>>>>>> node 4 cpus:
>>>>>> node 4 size: n MB
>>>>>> node 4 free: n MB
>>>>>> node distances:
>>>>>> node   0   1   2   3   4
>>>>>>   0:  10  20  40  40  80
>>>>>>   1:  20  10  40  40  80
>>>>>>   2:  40  40  10  40  80
>>>>>>   3:  40  40  40  10  80
>>>>>>   4:  80  80  80  80  10
>>>>>>
>>>>>> The existing implementation gives below demotion targets,
>>>>>>
>>>>>> node    demotion_target
>>>>>>  0              3, 2
>>>>>>  1              4
>>>>>>  2              X
>>>>>>  3              X
>>>>>>  4		X
>>>>>>
>>>>>> With this patch applied, below are the demotion targets,
>>>>>>
>>>>>> node    demotion_target
>>>>>>  0              3, 2
>>>>>>  1              3, 2
>>>>>>  2              3
>>>>>>  3              4
>>>>>>  4		X
>>>>>
>>>>> For such machine, I think the perfect demotion order is,
>>>>>
>>>>> node    demotion_target
>>>>>  0              2, 3
>>>>>  1              2, 3
>>>>>  2              4
>>>>>  3              4
>>>>>  4              X
>>>>
>>>> I guess the "equally slow nodes" is a confusing definition here. Now if the
>>>> system consists of 2 1GB equally slow memory and the firmware doesn't want to
>>>> differentiate between them, firmware can present a single NUMA node
>>>> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
>>>> that there is some difference between these two memory devices. This is
>>>> also captured by the fact that the distance between 2 and 3 is 40 and not 10.
>>>
>>> Do you have more information about this?
>>
>> Not sure I follow the question there. I was checking shouldn't firmware
>> do a single NUMA node if two memory devices are of the same type? How will
>> optane present such a config? Both the DIMMs will have the same
>> proximity domain value and hence dax kmem will add them to the same NUMA
>> node?
>
> Sorry for confusing.  I just wanted to check whether you have more
> information about the machine configuration above.  The machines in my
> hand have no complex NUMA topology as in the patch description.


Even with simple topologies like below

available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 4046 MB
node 0 free: 3478 MB
node 1 cpus: 2 3
node 1 size: 4090 MB
node 1 free: 3430 MB
node 2 cpus:
node 2 size: 4074 MB
node 2 free: 4037 MB
node distances:
node   0   1   2 
  0:  10  20  40 
  1:  20  10  40 
  2:  40  40  10 

With current code we get demotion targets assigned as below

[    0.337307] Demotion nodes for Node 0: 2
[    0.337351] Demotion nodes for Node 1: 
[    0.337380] Demotion nodes for Node 2: 

I guess we should fix that to be below?

[    0.344554] Demotion nodes for Node 0: 2
[    0.344605] Demotion nodes for Node 1: 2
[    0.344638] Demotion nodes for Node 2: 


Most of the tests we are doing are using Qemu to simulate this. We
started looking at this to avoid using demotion completely when slow
memory is not present. ie, we should have a different way to identify
demotion targets other than node_states[N_MEMORY]. Virtualized platforms
can have configs with memory only NUMA nodes with DRAM and we don't
want to consider those as demotion targets. 

While we are at it can you let us know how topology will look on a
system with two optane DIMMs? Do both appear with the same
target_node? 

>
>> If you are suggesting that firmware doesn't do that, then I agree with you
>> that a demotion target like the below is good. 
>>
>>  node    demotion_target
>>   0              2, 3
>>   1              2, 3
>>   2              4
>>   3              4
>>   4              X
>>
>> We can also achieve that with a smiple change as below.
>
> Glad to see the demotion order can be implemented in a simple way.
>
> My concern is that is it necessary to do this?  If there are real
> machines with the NUMA topology, then I think it's good to add the
> support.  But if not, why do we make the code complex unnecessarily?
>
> I don't have these kind of machines, do you have and will have?
>


Based on the above, we still need to get the simpler fix merged right?


>> @@ -3120,7 +3120,7 @@ static void __set_migration_target_nodes(void)
>>  {
>>  	nodemask_t next_pass	= NODE_MASK_NONE;
>>  	nodemask_t this_pass	= NODE_MASK_NONE;
>> -	nodemask_t used_targets = NODE_MASK_NONE;
>> +	nodemask_t this_pass_used_targets = NODE_MASK_NONE;
>>  	int node, best_distance;
>>  
>>  	/*
>> @@ -3141,17 +3141,20 @@ static void __set_migration_target_nodes(void)
>>  	/*
>>  	 * To avoid cycles in the migration "graph", ensure
>>  	 * that migration sources are not future targets by
>> -	 * setting them in 'used_targets'.  Do this only
>> +	 * setting them in 'this_pass_used_targets'.  Do this only
>>  	 * once per pass so that multiple source nodes can
>>  	 * share a target node.
>>  	 *
>> -	 * 'used_targets' will become unavailable in future
>> +	 * 'this_pass_used_targets' will become unavailable in future
>>  	 * passes.  This limits some opportunities for
>>  	 * multiple source nodes to share a destination.
>>  	 */
>> -	nodes_or(used_targets, used_targets, this_pass);
>> +	nodes_or(this_pass_used_targets, this_pass_used_targets, this_pass);
>>  
>>  	for_each_node_mask(node, this_pass) {
>> +
>> +		nodemask_t used_targets = this_pass_used_targets;
>> +
>>  		best_distance = -1;
>>  
>>  		/*
>
> Best Regards,
> Huang, Ying
