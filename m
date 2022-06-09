Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62001544588
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiFIISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiFIISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:18:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148B24BC0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:18:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2596q3te029000;
        Thu, 9 Jun 2022 08:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RlEBM5GB4cQkJjwHL8MJAF5Il+Z4n+I6fx6IyJsVSFQ=;
 b=LxH/paiMhZ90TjxJO52RajierJA9XlbE/eMysyM0b8YbVNa85d8Delp7qk5yjG2aoheA
 w3mEUw7kuH/63oVCOetxMxoXe/XPtKAKTGDsF7ldmCAcnT7TT0NTmMW4mTmByiNOgWvN
 ivqsGznpUWiH7B01ungX+gqbJfNK8JIUj/sVdk3IDnNu1INW22sg9x7RyH1JpKY+EnO4
 0Ahfv5bj0RDiXH0zYT4HHo7QYPmxTbNUHUn0tjNBwp16VLf021zFHHUZl5WM2aayYaVI
 kBoK5bQN9JHeHBkdWSUS31T8JpbiMStTHHPrMoyhhHqRsJIX/qHAtmnXyvKsNQcLHofg 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkby9shqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 08:18:09 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2596qokt029650;
        Thu, 9 Jun 2022 08:18:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkby9shqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 08:18:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259860fv026103;
        Thu, 9 Jun 2022 08:18:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19ek53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 08:18:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2598I64D24772918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 08:18:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248EDAE045;
        Thu,  9 Jun 2022 08:18:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E6FAE04D;
        Thu,  9 Jun 2022 08:17:59 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 08:17:59 +0000 (GMT)
Message-ID: <a81d4b1e-ee03-d44e-899b-166b42b09bf4@linux.ibm.com>
Date:   Thu, 9 Jun 2022 13:47:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
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
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
 <2b4f053b-de25-986c-f764-5cc6a28f4953@linux.ibm.com>
 <CAHbLzkqg++ENAEPdd+UY8Q5X0CuvbHC+JFAvYi2KLaS+2=q3_A@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAHbLzkqg++ENAEPdd+UY8Q5X0CuvbHC+JFAvYi2KLaS+2=q3_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i4nusXWK5onzxVhdlimBAdhsyek0OmhH
X-Proofpoint-GUID: rCJ0qriMgfvzRBnhux-UTqsD8ZNH_Hdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_08,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=916
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090029
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 10:12 PM, Yang Shi wrote:
> On Tue, Jun 7, 2022 at 9:58 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:

....

>>    config TIERED_MEMORY
>>          bool "Support for explicit memory tiers"
>> -       def_bool n
>> -       depends on MIGRATION && NUMA
>> -       help
>> -         Support to split nodes into memory tiers explicitly and
>> -         to demote pages on reclaim to lower tiers. This option
>> -         also exposes sysfs interface to read nodes available in
>> -         specific tier and to move specific node among different
>> -         possible tiers.
>> +       def_bool MIGRATION && NUMA
> 
> CONFIG_NUMA should be good enough. Memory tiering doesn't have to mean
> demotion/promotion has to be supported IMHO.
> 
>>
>>    config HUGETLB_PAGE_SIZE_VARIABLE
>>          def_bool n
>>
>> ie, we just make it a Kconfig variable without exposing it to the user?
>>

We can do that but that would also mean in order to avoid building the 
demotion targets etc we will now have to have multiple #ifdef 
CONFIG_MIGRATION in mm/memory-tiers.c . It builds without those #ifdef 
So these are not really build errors, but rather we will be building all 
the demotion targets for no real use with them.

What usecase do you have to expose memory tiers on a system with 
CONFIG_MIGRATION disabled? CONFIG_MIGRATION gets enabled in almost all 
configs these days due to its dependency against COMPACTION and 
TRANSPARENT_HUGEPAGE.

Unless there is a real need, I am wondering if we can avoid sprinkling 
#ifdef CONFIG_MIGRATION in mm/memory-tiers.c

-aneesh
