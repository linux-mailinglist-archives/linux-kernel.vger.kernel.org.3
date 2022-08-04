Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BBA5899F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiHDJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiHDJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:30:39 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1753DF39
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:30:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VLMBxaE_1659605434;
Received: from 30.240.99.20(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VLMBxaE_1659605434)
          by smtp.aliyun-inc.com;
          Thu, 04 Aug 2022 17:30:35 +0800
Message-ID: <a0e46572-5b37-7bb3-20f0-740a6480e50e@linux.alibaba.com>
Date:   Thu, 4 Aug 2022 17:30:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [RFC PATCH V4 1/1] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
To:     David Hildenbrand <david@redhat.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220801121727.76186-1-xhao@linux.alibaba.com>
 <20220801121727.76186-2-xhao@linux.alibaba.com>
 <0c1f9e76-9b1d-7069-bb09-c18e4f19f0c4@redhat.com>
 <bc0d16a6-e340-e261-82a0-e17bd236c2d9@linux.alibaba.com>
 <eaaab6c4-1719-5e21-ebf7-a0c17487314c@redhat.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <eaaab6c4-1719-5e21-ebf7-a0c17487314c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/4 下午4:12, David Hildenbrand 写道:
> On 04.08.22 10:04, haoxin wrote:
>> 在 2022/8/1 下午9:28, David Hildenbrand 写道:
>>> On 01.08.22 14:17, Xin Hao wrote:
>>>> In many data center servers, the shared memory architectures is
>>>> Non-Uniform Memory Access (NUMA), remote numa node data access
>>>> often brings a high latency problem, but what we are easy to ignore
>>>> is that the page table remote numa access, It can also leads to a
>>>> performance degradation.
>>> Let me try rewriting:
>>>
>>> "
>>> Many data center servers employ Non-Uniform Memory Access (NUMA)
>>> architectures. Remote numa memory access results in high latency. While
>>> memory placement is one issue, sub-optimal page table placement can also
>>> result in surprise performance degradation.
>>> "
>> Thanks,  it reads more clearly.
>>
>>>> So there add a new interface in /proc, This will help developers to
>>>> get more info about performance issues if they are caused by cross-NUMA.
>>> Why do we only care about "last level page table", why not about the others?
>>>
>>> IMHO, we could emit something like "0, 1, 3, 0" instead for a given user
>>> space address, showing the NUMA node the page table belongs to from
>>> highest to lowest page table level.
>> I have planned to implement the PTE page table in this version first,
>> and then support other page tables in the next patch later.
> If there are plans, let's do it all at once, to get a good and single
> interface to expose that information.
Ok, thanks for your suggestion, I will implement it in the next version.

>
