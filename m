Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B6575C46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiGOHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGOHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:23:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B020B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:23:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F6vAKY023715;
        Fri, 15 Jul 2022 07:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=EndeTF06wmem2QLG6bojP7IsO1nI09syR9jj12B0A5U=;
 b=Wz2boJsQucWKuZfV/VPgUwf/qQKNsL1OQMr0Rptqgyt8SZOCsvNS3/1kRBAJpFequzW0
 YLjXDMrpZUIt0YblXOZ/3EXCLBWQqr8uhTH8I3NTwukSBPY4zYhMLlWasHSa25jBetH8
 8WefLofdh82ugoVnUKuF6UnKWQn8DTDFD88jcH50YYljyD8iB+EBPQI9GLTS/M+3QcPl
 5lc0HrDO5bIG1kyzqGD/sRAa8a7kVb/OfwvjlAv0sl+7JGLgZNjbVziR7Kfuw0IOclJ8
 1g4c1Z3x4bNsD+YiOZr6NA0p6dhwwTnTjufDEipINoOvn6Zw/+b/pyEccVU+bOZxqozM 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb3dy0mau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:23:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26F7IIW6003541;
        Fri, 15 Jul 2022 07:23:15 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb3dy0ma4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:23:15 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F7KqIK032184;
        Fri, 15 Jul 2022 07:23:12 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3ha4qy3jdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:23:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F7NBOG10486518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 07:23:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB42CB205F;
        Fri, 15 Jul 2022 07:23:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86F34B2065;
        Fri, 15 Jul 2022 07:23:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.84.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 07:23:06 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 4/8] mm/demotion: Add hotplug callbacks to handle new
 numa node onlined
In-Reply-To: <87h73iapg1.fsf@nvdebian.thelocal>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-5-aneesh.kumar@linux.ibm.com>
 <87h73iapg1.fsf@nvdebian.thelocal>
Date:   Fri, 15 Jul 2022 12:53:03 +0530
Message-ID: <87wnceu9ew.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zlHsUCc6K8PTm39FtjLnSI2oSP-VcbjT
X-Proofpoint-GUID: um8W-UlTrr9Q3FarESX_p5gkjFkpK-8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> If the new NUMA node onlined doesn't have a memory tier assigned,
>> the kernel adds the NUMA node to default memory tier.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  mm/memory-tiers.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 79347d4ab05e..5706ad647136 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/lockdep.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/memory.h>
>>  #include <linux/memory-tiers.h>
>>
>>  struct memory_tier {
>> @@ -130,8 +131,73 @@ int node_create_and_set_memory_tier(int node, int tier)
>>  }
>>  EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
>>
>> +static int __node_set_memory_tier(int node, int tier)
>> +{
>> +	int ret = 0;
>> +	struct memory_tier *memtier;
>> +
>> +	memtier = __get_memory_tier_from_id(tier);
>> +	if (!memtier) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	node_set(node, memtier->nodelist);
>> +out:
>> +	return ret;
>> +}
>> +
>> +static int node_set_memory_tier(int node, int tier)
>
> Minor comment, but I don't like the name of this function as it doesn't
> always set the node to the given tier.
>
> Something like this would make it clearer the tier value is only used if
> the node isn't already assigned to a tier:
>
> static int init_node_memory_tier(int node, int default_tier)
>

Will rename to init_node_memory_tier()

-aneesh
