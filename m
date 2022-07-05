Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40F56622E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiGEETI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiGEETH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:19:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569B117B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:19:06 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2652pWP2027076;
        Tue, 5 Jul 2022 04:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EmUn+p3U8+//9srg7/zjIpTHTjdV/s90He+iwVewAAw=;
 b=R60tvOEeTkOlPmBe4o782e4IfmjhOa9L46BSGVUq6ioFcBA/vm8bYTgi3fLzqQoUc8ig
 bR3V3CnHnjVlizphFXOiGJxRxzpdwF3zR9Oskds1E8F4yqmQbVa02gjihXOqsiKOft9P
 P/wwwuyJQ8EesFVm3LQkreFYdn+01IW7Y030jYCTZSaUH2fBRRI9GG8SEJxcNd9DBuNv
 xLAwlZYkAcb/Hy3KXpHuqCdSz7NszA554z/421t6ewwVYUcKGRE0DRlY+10dOlZZ+YEH
 fDDjux0tv6uEFfeVstKn/stNhG5hPpjuqNDePH2xjy9PLoBdZ6gLZLjd9MeeYQmSDuhf gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4cvs1g8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 04:18:14 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2654EuNV028738;
        Tue, 5 Jul 2022 04:18:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4cvs1g86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 04:18:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26546L7p032058;
        Tue, 5 Jul 2022 04:18:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h2d9jbf6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 04:18:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2654I9BV22872558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jul 2022 04:18:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92CC4C04A;
        Tue,  5 Jul 2022 04:18:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F1AE4C040;
        Tue,  5 Jul 2022 04:18:01 +0000 (GMT)
Received: from [9.43.26.15] (unknown [9.43.26.15])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jul 2022 04:18:00 +0000 (GMT)
Message-ID: <ee0539e9-e123-e871-dae5-30d09e010c76@linux.ibm.com>
Date:   Tue, 5 Jul 2022 09:47:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
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
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
 <YsMAeU2fwEoysohr@casper.infradead.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YsMAeU2fwEoysohr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wD9sbBOGKadqCB1xSyR-UMBH-fBkln82
X-Proofpoint-ORIG-GUID: qDUH9gg9wlXRr5Px6x6cRX9OoNlpNJ68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_02,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207050017
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 8:30 PM, Matthew Wilcox wrote:
> On Mon, Jul 04, 2022 at 12:36:00PM +0530, Aneesh Kumar K.V wrote:
>> * The current tier initialization code always initializes
>>   each memory-only NUMA node into a lower tier.  But a memory-only
>>   NUMA node may have a high performance memory device (e.g. a DRAM
>>   device attached via CXL.mem or a DRAM-backed memory-only node on
>>   a virtual machine) and should be put into a higher tier.
>>
>> * The current tier hierarchy always puts CPU nodes into the top
>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>>   with CPUs are better to be placed into the next lower tier.
> 
> These things that you identify as problems seem perfectly sensible to me.
> Memory which is attached to this CPU has the lowest latency and should
> be preferred over more remote memory, no matter its bandwidth.

Allocation will prefer local memory over remote memory. Memory tiers are used during
demotion and currently, the kernel demotes cold pages from DRAM memory to these
special device memories because they appear as memory-only NUMA nodes. In many cases
(ex: GPU) what is desired is the demotion of cold pages from GPU memory to DRAM or
even slow memory.

This patchset builds a framework to enable such demotion criteria.

-aneesh
