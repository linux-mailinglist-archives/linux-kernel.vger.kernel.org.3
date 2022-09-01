Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A75A920A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiIAIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiIAIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:25:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB417597
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:25:06 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2818JBeD015615;
        Thu, 1 Sep 2022 08:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=12GUrv4vvXe7jwapZkfA7+yEjOTGAKm7DPYsXi7d3KM=;
 b=BUcmxVda72Hp/7IDVzcU1Y+31hciCqJ7iS+C0YHqdxqsBeVe+HimHMhx8HasHPAZaa6k
 17cZvQIOTIPJLDB75Uj01gz33FBRvB7jFK1EFhNHIMzudGJ/zA7mce8O0EsVmkUJZSly
 vyElriHx1VCIzUXmKPgq+PwpWLAUAMdH7eHdKXD4GToLxFacg3sEIvraEFFGds+JjTDH
 OX/ec3fGDK8pYstqQGFRN0BLdSnBYBQds+arvTgYdn6BO2XhUmRm4WYwUsS4OVqSLw6y
 xVmmdwtg4fbtB/oZ/rPWrUYd6S5QKZ0JmhSBzWusCATG75f1RubpLrE1mCNdyJ/GJTxT 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jas4f85fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:24:40 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2818KJIT023073;
        Thu, 1 Sep 2022 08:24:39 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jas4f85es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:24:39 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2818O3vR020359;
        Thu, 1 Sep 2022 08:24:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3j8hkabh5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 08:24:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2818OYMM39387446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 08:24:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9BD4C046;
        Thu,  1 Sep 2022 08:24:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA074C040;
        Thu,  1 Sep 2022 08:24:29 +0000 (GMT)
Received: from [9.43.54.15] (unknown [9.43.54.15])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 08:24:28 +0000 (GMT)
Message-ID: <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
Date:   Thu, 1 Sep 2022 13:54:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fHTVUoM07mWdeuusB4DYRMmvY3608yis
X-Proofpoint-ORIG-GUID: EnqFTL9SonUP_POiu2Hq90rLbkEIPfO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_05,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 12:31 PM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>> related details can be found. All allocated memory tiers will be listed
>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>
>> The nodes which are part of a specific memory tier can be listed via
>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> 
> I think "memory_tier" is a better subsystem/bus name than
> memory_tiering.  Because we have a set of memory_tierN devices inside.
> "memory_tier" sounds more natural.  I know this is subjective, just my
> preference.
> 
>>
>> A directory hierarchy looks like
>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>> memory_tier4/
>> ├── nodes
>> ├── subsystem -> ../../../../bus/memory_tiering
>> └── uevent
>>
>> All toptier nodes are listed via
>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>
>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>> 0,2
>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>> 0,2
> 
> I don't think that it is a good idea to show toptier information in user
> space interface.  Because it is just a in kernel implementation
> details.  Now, we only promote pages from !toptier to toptier.  But
> there may be multiple memory tiers in toptier and !toptier, we may
> change the implementation in the future.  For example, we may promote
> pages from DRAM to HBM in the future.
> 


In the case you describe above and others, we will always have a list of
NUMA nodes from which memory promotion is not done.
/sys/devices/virtual/memory_tiering/toptier_nodes shows that list.



> Do we need a way to show the default memory tier in sysfs?  That is, the
> memory tier that the DRAM nodes belong to.
> 

I will hold adding that until we have support for modifying memory tier details from
userspace. That is when userspace would want to know about the default memory tier. 

For now, the user interface is a simpler hierarchy of memory tiers, it's associated
nodes and the list of nodes from which promotion is not done.

-aneesh

