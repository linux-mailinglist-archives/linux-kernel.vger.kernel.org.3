Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5853C707
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbiFCIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiFCIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:41:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE736E0D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:41:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2536t036028175;
        Fri, 3 Jun 2022 08:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sa8kRbjthzzK9WfXNfBIPgKgAssAmJdhEU6a/RgzQBo=;
 b=oNsBW2mwWvUBcLrTsiKT1HxnSRiweE90lZCkmG3l762oemVtMcXMHvEA4PUBaO7SMNJ2
 vqbmiHKJrltB9q7AFLkFh3IBmnESei9yxO5q1pIu3V55oXkNj02wJB78MunvQFOaFaqq
 lB/AUeEMTM/mqJUzJqXalNOoyvBoptZJ4k5WjY656RfAZHl0nV0qtFXcqpg23GQnwWce
 RoYdvYFeC5QJ/Qagk9XMb1BJxXCZw+rSbbbp8ciaTk7KOZc6jQqY555DQjbShaueyFHz
 wLh5NFsNoYkfP2kxFLxJm+w/yuos6RbcRn9cL3j+9K2ojr+M89VXxvATAsRRJEWcs8kr hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfdephswn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:41:00 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2538exIX027109;
        Fri, 3 Jun 2022 08:40:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfdephsw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:40:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2538aV2G018023;
        Fri, 3 Jun 2022 08:40:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3gf2afghpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 08:40:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2538ensE23331254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 08:40:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 155EE4C044;
        Fri,  3 Jun 2022 08:40:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D094C040;
        Fri,  3 Jun 2022 08:40:49 +0000 (GMT)
Received: from [9.43.93.173] (unknown [9.43.93.173])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 08:40:48 +0000 (GMT)
Message-ID: <fbebbd2b-2ddb-bee6-5e12-67e3e18648ee@linux.ibm.com>
Date:   Fri, 3 Jun 2022 14:10:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
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
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
 <20220527151531.00002a0c@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220527151531.00002a0c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7mA6V2_BsxSjLJRcCal5aKmMLZtySSaS
X-Proofpoint-GUID: LgQUlLnFE9f9KowMQ8s7GqkTq0pKeKFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_02,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206030035
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 7:45 PM, Jonathan Cameron wrote:
> On Fri, 27 May 2022 17:55:23 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>
>> Add support to read/write the memory tierindex for a NUMA node.
>>
>> /sys/devices/system/node/nodeN/memtier
>>
>> where N = node id
>>
>> When read, It list the memory tier that the node belongs to.
>>
>> When written, the kernel moves the node into the specified
>> memory tier, the tier assignment of all other nodes are not
>> affected.
>>
>> If the memory tier does not exist, writing to the above file
>> create the tier and assign the NUMA node to that tier.
> creates
> 
> There was some discussion in v2 of Wei Xu's RFC that what matter
> for creation is the rank, not the tier number.
> 
> My suggestion is move to an explicit creation file such as
> memtier/create_tier_from_rank
> to which writing the rank gives results in a new tier
> with the next device ID and requested rank.

I think the below workflow is much simpler.

:/sys/devices/system# cat memtier/memtier1/nodelist
1-3
:/sys/devices/system# cat node/node1/memtier
1
:/sys/devices/system# ls memtier/memtier*
nodelist  power  rank  subsystem  uevent
/sys/devices/system# ls memtier/
default_rank  max_tier  memtier1  power  uevent
:/sys/devices/system# echo 2 > node/node1/memtier
:/sys/devices/system#

:/sys/devices/system# ls memtier/
default_rank  max_tier  memtier1  memtier2  power  uevent
:/sys/devices/system# cat memtier/memtier1/nodelist
2-3
:/sys/devices/system# cat memtier/memtier2/nodelist
1
:/sys/devices/system#

ie, to create a tier we just write the tier id/tier index to 
node/nodeN/memtier file. That will create a new memory tier if needed 
and add the node to that specific memory tier. Since for now we are 
having 1:1 mapping between tier index to rank value, we can derive the 
rank value from the memory tier index.

For dynamic memory tier support, we can assign a rank value such that 
new memory tiers are always created such that it comes last in the 
demotion order.

-aneesh




