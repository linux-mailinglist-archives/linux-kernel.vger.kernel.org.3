Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F3506FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352993AbiDSOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352994AbiDSOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:10:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88513393F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:07:49 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KjQcG1MX8zhXXP;
        Tue, 19 Apr 2022 22:07:42 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 22:07:47 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 22:07:46 +0800
Message-ID: <4734132d-bae3-d3ab-33b3-a4c3282ad5cd@huawei.com>
Date:   Tue, 19 Apr 2022 22:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peng Liu <liupeng256@huawei.com>
CC:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <dave@stgolabs.net>
References: <20220413032915.251254-2-liupeng256@huawei.com>
 <20220416103526.3287348-1-liupeng256@huawei.com>
 <20220418210352.1d1d90aeba477d598bd6f0be@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220418210352.1d1d90aeba477d598bd6f0be@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
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


On 2022/4/19 12:03, Andrew Morton wrote:
> On Sat, 16 Apr 2022 10:35:26 +0000 Peng Liu <liupeng256@huawei.com> wrote:
>
>> Certain systems are designed to have sparse/discontiguous nodes. In
>> this case, nr_online_nodes can not be used to walk through numa node.
>> Also, a valid node may be greater than nr_online_nodes.
>>
>> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
>> all the places that use nr_online_nodes, and repair them one by one.
> oops.
>
> What are the user-visible runtime effects of this flaw?

For example, there are four node=0,1,2,3, and nid = 1 is offline 
node，nr_online_nodes = 3

1) per-node alloc (hugepages=1:2) fails,

2) per-node alloc (hugepages=3:2) fails, but it could succeed.

I assume that there is no user-visible runtime effects.

> .
