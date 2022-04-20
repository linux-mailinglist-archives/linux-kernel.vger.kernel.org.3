Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1B5080F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357278AbiDTGUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiDTGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:20:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6F393E0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:17:37 -0700 (PDT)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kjr4S6KlRzFpXF;
        Wed, 20 Apr 2022 14:15:04 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:17:35 +0800
Received: from [10.174.179.19] (10.174.179.19) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:17:34 +0800
Message-ID: <ecd49289-383d-7a6a-d3be-168bdebc9ebc@huawei.com>
Date:   Wed, 20 Apr 2022 14:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <dave@stgolabs.net>
References: <20220413032915.251254-2-liupeng256@huawei.com>
 <20220416103526.3287348-1-liupeng256@huawei.com>
 <20220418210352.1d1d90aeba477d598bd6f0be@linux-foundation.org>
 <4734132d-bae3-d3ab-33b3-a4c3282ad5cd@huawei.com>
From:   "liupeng (DM)" <liupeng256@huawei.com>
In-Reply-To: <4734132d-bae3-d3ab-33b3-a4c3282ad5cd@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.19]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/19 22:07, Kefeng Wang wrote:
>
> On 2022/4/19 12:03, Andrew Morton wrote:
>> On Sat, 16 Apr 2022 10:35:26 +0000 Peng Liu <liupeng256@huawei.com> 
>> wrote:
>>
>>> Certain systems are designed to have sparse/discontiguous nodes. In
>>> this case, nr_online_nodes can not be used to walk through numa node.
>>> Also, a valid node may be greater than nr_online_nodes.
>>>
>>> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
>>> all the places that use nr_online_nodes, and repair them one by one.
>> oops.
>>
>> What are the user-visible runtime effects of this flaw?
>
> For example, there are four node=0,1,2,3, and nid = 1 is offline 
> node，nr_online_nodes = 3
>
> 1) per-node alloc (hugepages=1:2) fails,
>
> 2) per-node alloc (hugepages=3:2) fails, but it could succeed.
>
> I assume that there is no user-visible runtime effects.
>
Thanks, you are right.

I have constructed node =0, 1, 3, 4, and requested huge pages as:

hugepagesz=1G hugepages=0:1,4:1 hugepagesz=2M hugepages=0:1024,4:1024

Without this patch:

  HugeTLB: Invalid hugepages parameter 4:1
  HugeTLB: Invalid hugepages parameter 4:1024
  HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
  HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages

With this patch:

   HugeTLB registered 1.00 GiB page size, pre-allocated 2 pages
   HugeTLB registered 2.00 MiB page size, pre-allocated 2048 pages

>> .
> .
