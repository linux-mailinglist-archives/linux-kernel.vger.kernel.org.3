Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37BB542A59
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiFHJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiFHJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:02:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D7192255
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:21:40 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2587v7Vo032682;
        Wed, 8 Jun 2022 08:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HAGXtjks6l4gF3zYj7cmx3dDf3ojt6VzK3Ty+AmWHxg=;
 b=AuuGtYGjexnLmcRfefbsZiaw009F9Bg0mm2KbWDV/6+yuwMvbvZcH0fcS7Dbq/1O/AeG
 8EBpza7eghnfFeFd9irYo2RTf1Tm++pRqce5Ag4g+e2145jILv7iBF1flWXxK9zkF4kS
 ntPMl0pv72yDqWqIKrElWc154tKiE3XRUtTZxsoRby53tUvfRQD//fAu4Xjx54lrHlpW
 kILm4pkBaRU4y4L7UK8ioOCnu7uCXVQsBTd+kVcbweOPMaohHhruX50IUlTMUg9fqxcy
 Ax9P2nXGRRpX3fVqcM7+mPhPq61n++7he/FvaIsdX15h1GyKIssQyVPmVNfgf+04BPzy dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjqu3rh36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:19:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2588JKla014489;
        Wed, 8 Jun 2022 08:19:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjqu3rh2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:19:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258865Me005863;
        Wed, 8 Jun 2022 08:19:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19cuvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:19:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588J6RE22282738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:19:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0247E5204F;
        Wed,  8 Jun 2022 08:19:23 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6BB745204E;
        Wed,  8 Jun 2022 08:19:17 +0000 (GMT)
Message-ID: <0e3485e2-5a51-4666-618e-0969b067b43a@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:49:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 4/9] mm/demotion: Build demotion targets based on
 explicit memory tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-5-aneesh.kumar@linux.ibm.com>
 <07224a62dab704001b34d4e4afaf6cd4b477f9ec.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <07224a62dab704001b34d4e4afaf6cd4b477f9ec.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W4dUJQrjw8Hefv35-cyF75Ki6kiajp9V
X-Proofpoint-ORIG-GUID: aNpPXLZU70RSn3y_pRQYhNoG113RVk5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:20 PM, Ying Huang wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>> This patch switch the demotion target building logic to use memory tiers
>> instead of NUMA distance. All N_MEMORY NUMA nodes will be placed in the
>> default tier 1 and additional memory tiers will be added by drivers like
>> dax kmem.
>>
>> This patch builds the demotion target for a NUMA node by looking at all
>> memory tiers below the tier to which the NUMA node belongs. The closest node
>> in the immediately following memory tier is used as a demotion target.
>>
>> Since we are now only building demotion target for N_MEMORY NUMA nodes
>> the CPU hotplug calls are removed in this patch.
>>
>> The rank approach allows us to keep memory tier device IDs stable even if there
>> is a need to change the tier ordering among different memory tiers. e.g. DRAM
>> nodes with CPUs will always be on memtier1, no matter how many tiers are higher
>> or lower than these nodes. A new memory tier can be inserted into the tier
>> hierarchy for a new set of nodes without affecting the node assignment of any
>> existing memtier, provided that there is enough gap in the rank values for the
>> new memtier.
>>
>> The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
>> Its value relative to other memtiers decides the level of this memtier in the tier
>> hierarchy.
>>
>> For now, This patch supports hardcoded rank values which are 300, 200, & 100 for
>> memory tiers 0,1 & 2 respectively.
>>
>> Below is the sysfs interface to read the rank values of memory tier,
>> /sys/devices/system/memtier/memtierN/rank
>>
>> This interface is read only for now. Write support can be added when there is
>> a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
>> requirement among them.
>>
>> Suggested-by: Wei Xu <weixugc@google.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   include/linux/memory-tiers.h |   5 +
>>   include/linux/migrate.h      |  13 --
>>   mm/memory-tiers.c            | 269 ++++++++++++++++++++++++
>>   mm/migrate.c                 | 394 -----------------------------------
>>   mm/vmstat.c                  |   4 -
>>   5 files changed, 274 insertions(+), 411 deletions(-)
> 
> It appears that you moved some code from migrate.c to memory-tiers.c and
> change them.  If so, please separate the change.  That is, one patch
> only move the code, the other change the code.  This will make it easier
> to find out what is changed.

That was how it was done in earlier version. That is we did change 
establish_migration within the same file. The changes we are doing here 
was so different that it was mentioned that it gets very hard to review
in a context diff. Hence this patch where we killed the old code and did 
the new code in memory-tiers.c. I could still move the code to 
memory-tiers.c and do the changes on top of that. Infact I do have a 
patch that does similar code movement in the series. But the diff was 
not useful for an easy review.

-aneesh
