Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8546853DFE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbiFFC7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348609AbiFFC73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:59:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523344F9FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:59:28 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGdTY1Mr1zjXSj;
        Mon,  6 Jun 2022 10:58:09 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 10:58:58 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 10:58:58 +0800
Message-ID: <c5297412-628c-4123-a636-613db48a56fd@huawei.com>
Date:   Mon, 6 Jun 2022 10:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 1/3] mm/shmem: check return value of
 shmem_init_inodecache
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <wangkefeng.wang@huawei.com>
References: <20220605035557.3957759-1-chenwandun@huawei.com>
 <20220605035557.3957759-2-chenwandun@huawei.com>
 <YpyYSFjTQQQ/p4bM@casper.infradead.org>
 <aaebf2a5-026b-54f8-3fad-8e9611732e5e@huawei.com>
 <Yp1hujqmnbUmVKSc@casper.infradead.org>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <Yp1hujqmnbUmVKSc@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/6 10:08, Matthew Wilcox 写道:
> On Mon, Jun 06, 2022 at 09:34:13AM +0800, Chen Wandun wrote:
>> On 2022/6/5 19:49, Matthew Wilcox wrote:
>>> On Sun, Jun 05, 2022 at 11:55:55AM +0800, Chen Wandun wrote:
>>>> It will result in null pointer access if shmem_init_inodecache fail,
>>>> so check return value of shmem_init_inodecache
>>> You ignored my suggestion from v1.  Here, let me write it out for you.
>> Hi Matthew,
>> I didn't ignore your suggestion,  some explanation is needed, sorry for
>> that.
>>
>> In V1, Kefeng point:
>> "kmem_cache_create return a pointer to the cache on success, NULL on
>> failure,
>> so error = -ENOMEM; is right :)"
>>
>> so, I look some similar code such as init_inodecache in kinds of file
>> system,  they all
>> return -ENOMEM on failure, so is it OK to return -ENOMEM on failure :)
>>
>> Besides,  kmem_cache_create return NULL on failure, maybe returning error
>> code
>> on failure is more proper, but it is another job.
> I literally wrote out what I think you should do instead.  Stop arguing.
>
>>> +static int shmem_init_inodecache(void)
>>>    {
>>>     	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
>>>     				sizeof(struct shmem_inode_info),
>>>     				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
>>> +	if (!shmem_inode_cachep)
>>> +		return -ENOMEM;
>>> +	return 0;
>>>    }
>>>
>>> ...
>>>
>>> +	error = shmem_init_inodecache();
>>> +	if (error)
>>> +		goto out2;
Oh, I misunderstood what you said, feel so sorry.
I will send a new version.

Thanks.
>>>
>>>
>>> .
> .

