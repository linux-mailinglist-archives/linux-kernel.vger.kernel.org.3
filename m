Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C8958656D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiHAGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHAGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:55:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CB18E18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:55:30 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2716GSuR026514;
        Mon, 1 Aug 2022 06:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5lB1ezmMHWY9mUEduax8LA8Wsmh5JZbmItaixuoFlW8=;
 b=SKuIu9SFBca73XptERrgE1ceOX9zfoS+wKViQ2+yhwoR7yKHPIM1dNaQjzuyKdIbW6lv
 rJ4do8vj7RkI5PaOfrZA0L9sYKHlTcuEvSydATXxmi3gESO2U658Iag7tgrCuG/pdEOU
 fKpoNSz4KhUPcLbzFRHtv14q+xNpcO2UsGxb802c2b88yJbtcwU74Xmcz/G5VY4HkOgl
 +2UT74REUQTpB0p64no5uVgHaDbsQf6UTXjyzEO6lzB5HGuqOfg32sQeVAD3X2vjAPDg
 76AMA7NggcaJGS2JOoJpasLNyvVT7iw61v/YlvQk/PpicSploT0GQ+lBFj7ioAv6kdOi yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp6vgw2ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 06:55:15 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2716dfUf019153;
        Mon, 1 Aug 2022 06:55:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp6vgw2bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 06:55:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2716puYH028433;
        Mon, 1 Aug 2022 06:55:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hmv98htru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 06:55:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2716tOJG32768364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 06:55:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D139AE045;
        Mon,  1 Aug 2022 06:55:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D1EAE051;
        Mon,  1 Aug 2022 06:55:06 +0000 (GMT)
Received: from [9.43.22.209] (unknown [9.43.22.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 06:55:05 +0000 (GMT)
Message-ID: <1aba0c44-b096-8c75-8086-62d3cffc08b3@linux.ibm.com>
Date:   Mon, 1 Aug 2022 12:25:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
Content-Language: en-US
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
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
 <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87bkt8s7w9.fsf@linux.ibm.com>
 <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
 <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
 <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SvZniomhhLx0an3BIJRSHFFQV8FDUJ5E
X-Proofpoint-GUID: lU17vtRQGH5hmm26dL7Gx5Mcmz_Pcp-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_02,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 12:07 PM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 8/1/22 10:40 AM, Huang, Ying wrote:
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

....

>>>>
>>>> With the module unload, it is kind of force removing the usage of the specific memtype.
>>>> Considering module unload will remove the usage of specific memtype from other parts
>>>> of the kernel and we already do all the required reset in memory hot unplug, do we
>>>> need to do the clear_node_memory_type above? 
>>>
>>> Per my understanding, we need to call clear_node_memory_type() in
>>> dev_dax_kmem_remove().  After that, we have nothing to do in
>>> dax_kmem_exit().
>>>
>>
>> Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 
> 
> Can we use node_memory_types[] to indicate whether a node is managed by
> a driver?
> 
> Regardless being succeeded or failed, dev_dax_kmem_remove() will set
> node_memory_types[] = NULL.  But until node is offlined, we will still
> keep the node in the memory_dev_type (dax_pmem_type).
> 
> And we will prevent dax/kmem from unloading via try_module_get() and add
> "struct module *" to struct memory_dev_type.
> 

Current dax/kmem driver is not holding any module reference and allows the module to be unloaded
anytime. Even if the memory onlined by the driver fails to be unplugged. Addition of memory_dev_type
as suggested by you will be different than that. Page demotion can continue to work without the
support of dax_pmem_type as long as we keep the older demotion order. Any new demotion order
rebuild will remove the the memory node which was not hotunplugged  from the demotion order. Isn't that
a much simpler implementation? 

-aneesh

