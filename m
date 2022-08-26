Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D735A1F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiHZDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbiHZDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5472180B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:01:23 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q2ftOb000695;
        Fri, 26 Aug 2022 03:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ha84NsaofU5jXtSN8WHO/h21JRpkyCJq+3izR57Rk+I=;
 b=BM72/wGfUvPKXxoVjuB4OQOQ7D3E0Dn04fkYmln38ryJpdVGua7z8uozgbfCQ8VUcSg4
 sgy/SdJ6RVa785veX+28ZBEqQNeVJE8mAPuL5SXDyLqgsWVeP/V7qX0FRXVeTO9s5qbT
 c2yv/I8UaJTyeE+MetshYFKPMswp45sxviY/vtNUi5dxNSQBlSzfw4luQjdrt72ql5h6
 S13Zn0xFNdmYFPy06ekFYYjW/j74BsbMiMhOejOAPE3U/JtECtz66vRmnx5RV2nNqXmQ
 7Xf4D0ue7gx6freBbIIASpZHflr2SddKbku8ty5DJMWCPTDLCnCwwBaFWTlpyIWOpp1s 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6nm90ay6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 03:00:50 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27Q2h2Tu006198;
        Fri, 26 Aug 2022 03:00:50 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6nm90awp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 03:00:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27Q2pc9a015522;
        Fri, 26 Aug 2022 03:00:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j2q89d7q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 03:00:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27Q30iWO42074406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 03:00:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19591A448D;
        Fri, 26 Aug 2022 02:37:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D472AA4485;
        Fri, 26 Aug 2022 02:37:29 +0000 (GMT)
Received: from [9.43.10.139] (unknown [9.43.10.139])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Aug 2022 02:37:29 +0000 (GMT)
Message-ID: <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
Date:   Fri, 26 Aug 2022 08:07:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
 <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CJPu0aTh8hLLhQC6Si79jBc74EPx1Tu4
X-Proofpoint-GUID: bJEE9BbGZAcSibcNdwLnDwEoSKKD5Rev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 7:20 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> This patch adds /sys/devices/virtual/memtier/ where all memory tier related
>> details can be found. All allocated memory types will be listed there as
>> /sys/devices/virtual/memtier/memtypeN/
> 
> Another choice is to make memory types and memory tiers system devices.
> That is,
> 
> /sys/devices/system/memory_type/memory_typeN
> /sys/devices/system/memory_tier/memory_tierN
> 

subsys_system_register() documentation says 

 * Do not use this interface for anything new, it exists for compatibility
 * with bad ideas only. New subsystems should use plain subsystems; and
 * add the subsystem-wide attributes should be added to the subsystem
 * directory itself and not some create fake root-device placed in
 * /sys/devices/system/<name>.
 
memtier being a virtual device, I was under the impression that /sys/devices/virtual
is the recommended place. 

> That looks more natural to me.  Because we already have "node" and
> "memory" devices there.  Why don't you put memory types and memory tiers
> there?
> 
> And, I think we shouldn't put "memory_type" in the "memory_tier"
> directory.  "memory_type" isn't a part of "memory_tier".
> 

I was looking consolidating both memory tier and memory type into the same sysfs subsystem.
Your recommendation imply we create two subsystem memory_tier and memtype. I was
trying to avoid that. May be a generic term like "memory_tiering" can help to
consolidate all tiering related details there? 


>> The nodes which are part of a specific memory type can be listed via
>> /sys/devices/system/memtier/memtypeN/nodes.
> 
> How about create links to /sys/devices/system/node/nodeN in
> "memory_type".  But I'm OK to have "nodes" file too.
> 
>> The adistance value of a specific memory type can be listed via
>> /sys/devices/system/memtier/memtypeN/adistance.
>>
>> A directory listing looks like:
>> :/sys/devices/virtual/memtier# tree memtype1
>> memtype1
>> ├── adistance
> 
> Why not just use "abstract_distance"?  This is user space interface,
> it's better to be intuitive.
> 
>> ├── nodes
>> ├── subsystem -> ../../../../bus/memtier
>> └── uevent
>>
>> Since we will be using struct device to expose details via sysfs, drop struct
>> kref and use struct device for refcounting the memtype.
>>
> 
> Best Regards,
> Huang, Ying

