Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6223542AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiFHJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiFHJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E4101915
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:25:09 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25888rON020142;
        Wed, 8 Jun 2022 08:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=n8YORMICtcoEXTgTlEMkLLrxOJq2wW8tJfHevJnl+N8=;
 b=GDeKjKqoZhFWfT7mL5+blzBjwS5YYR/PJkUTQI7Ojn0bqEwz6YE4ZjjXZfNyv8rUKCCf
 k0nJKIwGT12MJNTdKP78ZyqOYsIyJFNuq37plndq6vdLweENV94CO8Hot07jMD2ajgH8
 PXtmUbv/LNWPymo83ePbGVsisBFhC40JKz0ccp1DSX+soM497a16GH5Arau9avVEx4+g
 aTkizcib1++5WsKzOV9dg2IG4A/Gy+RyOpjGIzaQ5wmIhsIxe3l3Ycneh0FGgr3ye23n
 qPCl9Pox5Hb2i/okXz/MT1F32rOgIUE0zxWDuCshzWsWRxBOfABobvXXjHi4VIg6RrV2 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr0mra70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:24:50 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2588DT6L007042;
        Wed, 8 Jun 2022 08:24:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr0mra68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:24:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2588JwuB025071;
        Wed, 8 Jun 2022 08:24:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19cv8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:24:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588OSsL22741320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:24:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12A895204E;
        Wed,  8 Jun 2022 08:24:45 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 78D5152050;
        Wed,  8 Jun 2022 08:24:39 +0000 (GMT)
Message-ID: <b4ea5d02-40d9-9928-1094-9befed7ae4ff@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:54:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
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
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
 <604403db000ced33f997688ce82eaa43ed6c8bbe.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <604403db000ced33f997688ce82eaa43ed6c8bbe.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nmOCLq0ZUk4nnP_msbBOQTEgj7rag_i0
X-Proofpoint-ORIG-GUID: 7vBFHH2_ZDmACl9Qr52T_s72RjWl9TLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:46 PM, Ying Huang wrote:
> On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> 
> [snip]
> 
>>
>> +static int __init memory_tier_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
>> +	if (ret)
>> +		panic("%s() failed to register subsystem: %d\n", __func__, ret);
> 
> I don't think we should go panic for failing to register subsys and
> device for memory tiers.  Just pr_err() should be enough.
> 

So you are suggesting we continue to work with memory tiers with no 
userspace interface?

>> +
>> +	/*
>> +	 * Register only default memory tier to hide all empty
>> +	 * memory tier from sysfs.
>> +	 */
>> +	ret = register_memory_tier(DEFAULT_MEMORY_TIER);
>> +	if (ret)
>> +		panic("%s() failed to register memory tier: %d\n", __func__, ret);
>> +
>> +	/*
>> +	 * CPU only nodes are not part of memoty tiers.
>> +	 */
>> +	memory_tiers[DEFAULT_MEMORY_TIER]->nodelist = node_states[N_MEMORY];
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(memory_tier_init);
>> +
>> +#endif	/* CONFIG_TIERED_MEMORY */
> 
> 

