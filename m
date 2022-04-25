Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512D50E3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiDYO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiDYO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:57:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8BF36319
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:54:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PEl2e5021703;
        Mon, 25 Apr 2022 14:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jLpnZgj2KDnbV1EAo897LuWjxlkp1tf6fTyDAjwF04A=;
 b=bAk62XsGQut0n0qI9tx01dPywABUBCSt9xZRdMeEOy9ksxhFA7VMNjcalw21laUl8Cfb
 mN717hJw4rPSjGVTJMbTnR4mez50h+vlpiLunr6cTG0Q+4oDS9NaEmsOy0axKbgJUCBp
 y4J6GFIBxhYxZUMeLDdxlnfuEb3rUb4PL6edzFLqLaE6L0geK0E0OVk/gLSZhSUDldfp
 wMFsqtA0ql9mp6QiC6T2KZ/Xe4dHrrU6wv0oX+D7VF9XjLYUv3c3FgNSmdyePh2jNgCy
 LE7ZFm6i63gGQ/qHiInTrlC7KHPzseJuCgErwEfZDHIYlo/NuAiBj7zW/ruUBa75ivm+ jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnr448mxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:54:08 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PEq6Wd000819;
        Mon, 25 Apr 2022 14:54:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnr448mwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:54:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PEctt1009728;
        Mon, 25 Apr 2022 14:54:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3fm938t3v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:54:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PEs2rN23462250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 14:54:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31E4BAE04D;
        Mon, 25 Apr 2022 14:54:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 306AFAE045;
        Mon, 25 Apr 2022 14:53:58 +0000 (GMT)
Received: from [9.43.106.14] (unknown [9.43.106.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 14:53:57 +0000 (GMT)
Message-ID: <132150b3-73f8-ea94-2839-91b92e5d2991@linux.ibm.com>
Date:   Mon, 25 Apr 2022 20:23:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
 <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <20220425145735.000007ca@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220425145735.000007ca@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9kBEF8donZZtARCCL5DvrH3i5MoXPFCS
X-Proofpoint-ORIG-GUID: 7KSGHI4kL0ebDcvbx8cP1kp8E9barXtB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=891 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250063
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> On Mon, 25 Apr 2022 16:45:38 +0530
> Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>

....

>> $ numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13392 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1971 MB
>> node distances:
>> node   0   1
>>    0:  10  40
>>    1:  40  10
>>
>> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>>     for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> 
> I'm not convinced the distinction between DRAM and persistent memory is
> valid. There will definitely be systems with a large pool
> of remote DRAM (and potentially no NV memory) where the right choice
> is to demote to that DRAM pool.
> 
> Basing the decision on whether the memory is from kmem or
> normal DRAM doesn't provide sufficient information to make the decision.
> 
>>
>> $ cat /sys/bus/nd/devices/dax0.0/target_node
>> 2
>> $
>> # cd /sys/bus/dax/drivers/
>> :/sys/bus/dax/drivers# ls
>> device_dax  kmem
>> :/sys/bus/dax/drivers# cd device_dax/
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
>> :/sys/bus/dax/drivers/device_dax# numactl -H
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13380 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1961 MB
>> node 2 cpus:
>> node 2 size: 0 MB
>> node 2 free: 0 MB
>> node distances:
>> node   0   1   2
>>    0:  10  40  80
>>    1:  40  10  80
>>    2:  80  80  10
>>
>> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
>> patch series, 1 is demotion target for 0 and 2 is demotion target
>> for 1.
>>
>> With this patch series applied,
>> 1) No demotion target for either 0 or 1 before dax device is online
> 
> I'd argue that is wrong.  At this state you have a tiered memory system
> be it one with just DRAM.  Using it as such is correct behavior that
> we should not be preventing.  Sure some usecases wouldn't want that
> arrangement but some do want it.
> 

I missed this in my earlier reply. Are you suggesting that we would want 
Node 1 (DRAM only memory numa node) to act as demotion target for Node 
0?  Any reason why we would want to do that? That is clearly opposite of 
what we are trying to do here. IMHO node using Node1 as demotion target 
for Node0 is a better default?



-aneesh
