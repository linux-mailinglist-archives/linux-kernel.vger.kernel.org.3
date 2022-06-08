Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8C54281D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiFHHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiFHGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:04:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FB364848
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:59:27 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2584PxSU013355;
        Wed, 8 Jun 2022 04:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+1/08y4B9ao5+Ix448dysboe8f8SwSI3kQ6htTX0kqM=;
 b=k8rQt/jmDu/5WTG+KVvZPcZrap9gtpl+0RM3RCr73WWDJa0lq8KtOrU4VavMoo0o9lTN
 SBO45I3fgyvNkCO4e6+2c51wFxTRT/Bsg6UnZrrkihcKSFKvs3rmFOC1VFPvOjPLlm+7
 aCBkr/3uYZHnSmbD3Lpk+NcMqniQbCSwKAC4L6SsC1WpaBRzCuE7o03uZo+Ye7r2E5c/
 T5K0wLNuxD5mcmXQXjCdge4jqQkdtTQMZnVLPxSHO1NuCl5g9DNg37ygX13zsU6bBwp9
 d+SXOAtC/Lr25y4/I//IYe4ZMFS2EM+Qs1dyrJ/2wNkK1OHhRBMLIlcTZtXOxkgQDHk/ Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjmr40ewq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:55:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2584aFY5018505;
        Wed, 8 Jun 2022 04:55:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjmr40ewa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:55:21 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2584osHU019119;
        Wed, 8 Jun 2022 04:55:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3gfy18uksk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:55:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2584tHvN21889298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 04:55:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8CC252050;
        Wed,  8 Jun 2022 04:55:16 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6DF755204E;
        Wed,  8 Jun 2022 04:55:10 +0000 (GMT)
Message-ID: <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
Date:   Wed, 8 Jun 2022 10:25:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
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
 <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
 <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8U9B6P44JQMCSa2PS4QtUggjW3bkbMc7
X-Proofpoint-GUID: 8J-WRUL6g3hUIhJM96brqIBSRlCTtmH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_01,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080019
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 1:45 AM, Tim Chen wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>
>>   
>> +static struct memory_tier *__node_get_memory_tier(int node)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
> 
> We could need to map node to mem_tier quite often, if we need
> to account memory usage at tier level.  It will be more efficient
> to have a pointer from node (pgdat) to memtier rather
> than doing a search through the list.
> 
> 

That is something I was actively trying to avoid. Currently all struct 
memory_tier references are with memory_tier_lock mutex held. That 
simplify the locking and reference counting.

As of now we are able to implement all the required interfaces without 
pgdat having pointers to struct memory_tier. We can update pgdat with 
memtier details when we are implementing changes requiring those. We 
could keep additional memtier->dev reference to make sure memory tiers 
are not destroyed while other part of the kernel is referencing the 
same. But IMHO such changes should wait till we have users for the same.


>> +		if (node_isset(node, memtier->nodelist))
>> +			return memtier;
>> +	}
>> +	return NULL;
>> +}
>> +
>>
> 
> Tim
>

-aneesh

