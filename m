Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664E54326D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiFHOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiFHOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:22:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B903C72B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:22:42 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258ECQRd005784;
        Wed, 8 Jun 2022 14:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=32A0PquIsSMT4IZIz7tmARklAQ06v5vFDlZCc4G8JVE=;
 b=ZElpbhbs4AzKVF7P9nclAQ+mY8bGUFQFpvbw1njKcoQVp9tW7QTVVF4d4jLVwxX/6bs3
 EORfLp42xAzt3aoPaaEC0haF0AZpjxr1gHbkImu+s4D91K2rVrSANIwj3RuB9VXxK/cG
 b8ax+qgjQMX6bwe+97wPCEkxU8pXTyFYkqCMmf2TerkgC+sxtBCP2TOMsSi8mlRh7bEd
 VYHsywgVfLBQ0++uTt+wLFMUd29oIXQiU0Yaq5uzFjVYSnXSAhRK9dXWIse0vCjF9exV
 Yzap9RgmJewfgTjegHxWzNv/CSFdzGC+tus4JoVQuh8BthaXp0mtH5COfSN8+4BrPNNm Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjsmbwg6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:22:05 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 258DnVRb015685;
        Wed, 8 Jun 2022 14:22:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjsmbwg5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:22:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258EKAJ9004551;
        Wed, 8 Jun 2022 14:22:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19ddnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:22:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258EM06720709642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 14:22:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B24B5204F;
        Wed,  8 Jun 2022 14:22:00 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 844B55204E;
        Wed,  8 Jun 2022 14:21:55 +0000 (GMT)
Message-ID: <929eae05-3ce1-6dce-1715-bb57591135e7@linux.ibm.com>
Date:   Wed, 8 Jun 2022 19:51:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
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
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YqCuE87gCcrnAiXG@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bG-BoeYhyCqPVP_d0iuGbK2vhUyNcJOV
X-Proofpoint-GUID: Jwm4FaLrcAnHg4qWD188fOHo6uonoBnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_04,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
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

On 6/8/22 7:41 PM, Johannes Weiner wrote:
> Hi Aneesh,
> 
> On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_MEMORY_TIERS_H
>> +#define _LINUX_MEMORY_TIERS_H
>> +
>> +#ifdef CONFIG_TIERED_MEMORY
>> +
>> +#define MEMORY_TIER_HBM_GPU	0
>> +#define MEMORY_TIER_DRAM	1
>> +#define MEMORY_TIER_PMEM	2
>> +
>> +#define MEMORY_RANK_HBM_GPU	300
>> +#define MEMORY_RANK_DRAM	200
>> +#define MEMORY_RANK_PMEM	100
>> +
>> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
>> +#define MAX_MEMORY_TIERS  3
> 
> I understand the names are somewhat arbitrary, and the tier ID space
> can be expanded down the line by bumping MAX_MEMORY_TIERS.
> 
> But starting out with a packed ID space can get quite awkward for
> users when new tiers - especially intermediate tiers - show up in
> existing configurations. I mentioned in the other email that DRAM !=
> DRAM, so new tiers seem inevitable already.
> 
> It could make sense to start with a bigger address space and spread
> out the list of kernel default tiers a bit within it:
> 
> MEMORY_TIER_GPU		0
> MEMORY_TIER_DRAM	10
> MEMORY_TIER_PMEM	20
> 

the tier index or tier id or the tier dev id don't have any special 
meaning. What is used to find the demotion order is memory tier rank and 
they are really spread out, (300, 200, 100).

-aneesh
