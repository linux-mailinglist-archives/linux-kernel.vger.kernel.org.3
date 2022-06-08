Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AED542439
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiFHGAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350798AbiFHF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:59:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5626D20A5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:46:07 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2583Q2OC004968;
        Wed, 8 Jun 2022 04:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rJ6WQDvo/ghYzvKy2CXcM9QlclDOXoOl2dxAYdwMlz8=;
 b=KTQFE8GSa5W244tRx2pd/l8ZqUsfbtlXIUW4C8GQYFcrJYNayDLlxcWSgKSBxZkvt89G
 ktsBL0OaqoEKzw8VzFncKTpLZ6mu2ztjioEiBLMkGwOzUTDAOCt4Y5KnsaUdSClR68MY
 oDKuedJPQWLUzK7qg8y0NOD6IRIavRONrxGaBWM01pjqXK8+ibj0gaxXDvokOhvxuRS1
 3z97L1n8zk0KFobRGiZdPp1M9huSDMdx8TxVw6WInEuSsCYvTSfs+w2azkMuFxJ+Q+rH
 xZUQLf4ZvqjdzfAl1I2uEheYK+pTBYUz/tVeGlKpNgOiR2X9QGSMtzE2mqw5VL2pvsW5 YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjkv116mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:41:42 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2584QnsJ032205;
        Wed, 8 Jun 2022 04:41:42 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjkv116kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:41:41 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2584JurH006904;
        Wed, 8 Jun 2022 04:41:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3gfy19bkny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:41:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2584fbm946924056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 04:41:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E1C85204E;
        Wed,  8 Jun 2022 04:41:37 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E1DF252050;
        Wed,  8 Jun 2022 04:41:30 +0000 (GMT)
Message-ID: <21b95ac3-4b3c-3455-93c6-8257fcbff527@linux.ibm.com>
Date:   Wed, 8 Jun 2022 10:11:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ying Huang <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
 <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
 <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
 <20220530135043.00001e88@Huawei.com>
 <d99836a86fea8a975ba207d1c874ee062836004d.camel@linux.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <d99836a86fea8a975ba207d1c874ee062836004d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_hnSuXru5-wSsQvbeDNUH7gYzDTmtde
X-Proofpoint-ORIG-GUID: SYNUJXIZhqU9pu86pYCOxFy7_gM2EE7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_01,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On 6/8/22 12:55 AM, Tim Chen wrote:
> On Mon, 2022-05-30 at 13:50 +0100, Jonathan Cameron wrote:
>>
>>> When discussed offline, Tim Chen pointed out that with the proposed
>>> interface, it's unconvenient to know the position of a given memory tier
>>> in all memory tiers.  We must sort "rank" of all memory tiers to know
>>> that.  "possible" file can be used for that.  Although "possible" file
>>> can be generated with a shell script, it's more convenient to show it
>>> directly.
>>>
>>> Another way to address the issue is to add memtierN/pos for each memory
>>> tier as suggested by Tim.  It's readonly and will show position of
>>> "memtierN" in all memory tiers.  It's even better to show the relative
>>> postion to the default memory tier (DRAM with CPU). That is, the
>>> position of DRAM memory tier is 0.
>>>
>>> Unlike memory tier device ID or rank, the position is relative and
>>> dynamic.
>>
>> Hi,
>>
>> I'm unconvinced.  This is better done with a shell script than
>> by adding ABI we'll have to live with for ever..
>>
>> I'm no good at shell scripting but this does the job
>> grep "" tier*/rank | sort -n -k 2 -t :
>>
>> tier2/rank:50
>> tier0/rank:100
>> tier1/rank:200
>> tier3/rank:240
>>
>> I'm sure someone more knowledgeable will do it in a simpler fashion still.
>>
>>
> 
> You can argue that
> 
> $ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
> f
> $ cat /sys/devices/system/cpu/cpu1/topology/core_siblings_list
> 0-3
> 
> provide exactly the same information and we should get rid of
> core_siblings_list.  I think core_siblings_list exists to make
> it easier for a human, so he/she doesn't have to parse the mask,
> or write a script to find out the ids of CPUs who are siblings.
> 
> I think in the same spirit, having an interface to allow a
> human to quickly see the hierachical relationship of tiers
> relative to each other is helpful.
> 

We can add that later if we find applications requiring this. I kind of 
have the feeling that we are adding too much based on possible ways 
memory tiers could be used in the future. For now we can look at doing 
bare minimum to address the current constraints and drive more user 
visible changes later based on application requirements.

-aneesh

