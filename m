Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83BA543263
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiFHOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbiFHOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:20:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61673BF80
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:20:44 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258DrhDx003565;
        Wed, 8 Jun 2022 14:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wlpmhk8Sy94uyD2Oe92OGuqVGOTTtGLcVj9ZLjDI6hM=;
 b=gEkG9r7NyG3t6AqJ/hfQcYfZKnnLB+bjoNaKzbcwCQO2C8AfvfT+3tlOfctfoOxyAgWb
 v7pil6QQWK3krENrQfLzO3GY68Ll9eTSN8JHsdI3/2TC9Uyi3FQlanT2I+idrqfUjqHl
 alYLFtbiana8o6Si+2iwhVwhDuCOlL1izwkJWUC8UiboLUZGNOcUCoiIbg9F3NNPwz8e
 SeoQceB1cQPcSpMWKrOscJqzgB8Amt/K+CgnIemvVTkRTavRWIl4ouGs2ysX8lJX4PMd
 ZCHQt1j44jezBlL6WQcnGrSQk8orRYMX7FgqnSEbFfcR8dl+Rv29vwiH+yrind4YTQVs xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjw298kms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:20:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 258Du5Pj022410;
        Wed, 8 Jun 2022 14:20:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjw298km1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:20:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258EHitp007459;
        Wed, 8 Jun 2022 14:20:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gfxnhwepe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:20:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258EKHul48824722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 14:20:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D0A052054;
        Wed,  8 Jun 2022 14:20:17 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 93CEB52050;
        Wed,  8 Jun 2022 14:20:12 +0000 (GMT)
Message-ID: <8516237f-c1a0-aefa-274a-9f8794ae0ccd@linux.ibm.com>
Date:   Wed, 8 Jun 2022 19:50:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 0/9] mm/demotion: Memory tiers and demotion
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
 <YqCq0cUCnQmS6SV4@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YqCq0cUCnQmS6SV4@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rEgwQMchZymyHtUVMDMzm0rKQtrcub_E
X-Proofpoint-ORIG-GUID: xiWBMacox6yjAtuobay-DjL9M-QgzKmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_04,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=778 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 7:27 PM, Johannes Weiner wrote:
> Hi Aneesh,
> 
> On Fri, Jun 03, 2022 at 07:12:28PM +0530, Aneesh Kumar K.V wrote:
>> * The current tier initialization code always initializes
>>    each memory-only NUMA node into a lower tier.  But a memory-only
>>    NUMA node may have a high performance memory device (e.g. a DRAM
>>    device attached via CXL.mem or a DRAM-backed memory-only node on
>>    a virtual machine) and should be put into a higher tier.
> 
> I have to disagree with this premise. The CXL.mem bus has different
> latency and bandwidth characteristics. It's also conceivable that
> cheaper and slower DRAM is connected to the CXL bus (think recycling
> DDR4 DIMMS after switching to DDR5). DRAM != DRAM.
> 
> Our experiments with production workloads show regressions between
> 15-30% in serviced requests when you don't distinguish toptier DRAM
> from lower tier DRAM. While it's fixable with manual tuning, your
> patches would bring reintroduce this regression it seems.
> 
> Making tiers explicit is a good idea, but can we keep the current
> default that CPU-less nodes are of a lower tier than ones with CPU?
> I'm having a hard time imagining where this wouldn't be true... Or why
> it shouldn't be those esoteric cases that need the manual tuning.

This was mostly driven by virtual machine configs where we can find 
memory only NUMA nodes depending on the resource availability in the 
hypervisor.

Will these CXL devices be initialized by a driver? For example, if they 
are going to be initialized via dax kmem, we already consider them lower 
memory tier as with this patch series.

-aneesh
