Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624B655B2F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiFZQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiFZQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:48:37 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06241B1CF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:48:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VHObQK7_1656262106;
Received: from 30.30.86.254(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VHObQK7_1656262106)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 00:48:28 +0800
Message-ID: <20a62094-8ec4-f9b9-c7ac-20c0dfc2d283@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 00:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de>
 <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
 <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206131548420.295113@gentwo.de>
 <5085437c-adc9-b6a3-dbd8-91dc0856cf19@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206171617560.638056@gentwo.de>
 <1b434d4c-2a19-9ac1-b2b9-b767b642ec0c@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206201354030.265427@gentwo.de>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206201354030.265427@gentwo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/22 7:57 PM, Christoph Lameter wrote:
> On Sat, 18 Jun 2022, Rongwei Wang wrote:
> 
>>> Well the cycle reduction is strange. Tests are not done in the same
>>> environment? Maybe good to not use NUMA or bind to the same cpu
>> It's the same environment. I can sure. And there are four nodes (32G per-node
>> and 8 cores per-node) in my test environment. whether I need to test in one
>> node? If right, I can try.
> 
> Ok in a NUMA environment the memory allocation is randomized on bootup.
> You may get different numbers after you reboot the system. Try to switch
> NUMA off. Use s a single node to get consistent numbers.
Sorry for late reply.

At first, let me share my test environment: arm64 VM (32 cores and 128G 
memory), and I only configure one node for this VM.
Plus, I had use 'numactl -N 0 -m 0 qemu-kvm ...' to start this VM. It 
mainly to avoid data jitter.

And I can sure my physical machine where this VM is located has same 
configuration when I tested prototype kernel and patched kernel. If 
above test environment has any problems, please let me know.

The following is the latest data:

Single thread testing
1. Kmalloc: Repeatedly allocate then free test
                   before                fix
                   kmalloc    kfree      kmalloc     kfree
10000 times 8     4 cycles   5 cycles	4 cycles    5 cycles
10000 times 16    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 32    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 64    3 cycles   5 cycles	3 cycles    5 cycles
10000 times 128   3 cycles   5 cycles	3 cycles    5 cycles
10000 times 256   14 cycles  9 cycles	6 cycles    8 cycles
10000 times 512   9 cycles   8 cycles	9 cycles    10 cycles
10000 times 1024  48 cycles  10 cycles	6 cycles    10 cycles
10000 times 2048  31 cycles  12 cycles	35 cycles   13 cycles
10000 times 4096  96 cycles  17 cycles	96 cycles   18 cycles
10000 times 8192  188 cycles 27 cycles	190 cycles  27 cycles
10000 times 16384 117 cycles 38 cycles  115 cycles  38 cycles
				
2. Kmalloc: alloc/free test
                                   before        fix
10000 times kmalloc(8)/kfree      3 cycles      3 cycles
10000 times kmalloc(16)/kfree     3 cycles      3 cycles
10000 times kmalloc(32)/kfree     3 cycles      3 cycles
10000 times kmalloc(64)/kfree     3 cycles      3 cycles
10000 times kmalloc(128)/kfree    3 cycles      3 cycles
10000 times kmalloc(256)/kfree    3 cycles      3 cycles
10000 times kmalloc(512)/kfree    3 cycles      3 cycles
10000 times kmalloc(1024)/kfree   3 cycles      3 cycles
10000 times kmalloc(2048)/kfree   3 cycles      3 cycles
10000 times kmalloc(4096)/kfree   3 cycles      3 cycles
10000 times kmalloc(8192)/kfree   3 cycles      3 cycles
10000 times kmalloc(16384)/kfree  33 cycles     33 cycles

Concurrent allocs
                                 before            fix
Kmalloc N*alloc N*free(8)       Average=13/14     Average=14/15
Kmalloc N*alloc N*free(16)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(32)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(64)      Average=13/15     Average=13/15
Kmalloc N*alloc N*free(128)     Average=13/15     Average=13/15
Kmalloc N*alloc N*free(256)     Average=137/29    Average=134/39
Kmalloc N*alloc N*free(512)     Average=61/29     Average=64/28
Kmalloc N*alloc N*free(1024)    Average=465/50    Average=656/55
Kmalloc N*alloc N*free(2048)    Average=503/97    Average=422/97
Kmalloc N*alloc N*free(4096)    Average=1592/206  Average=1624/207
		
Kmalloc N*(alloc free)(8)       Average=3         Average=3
Kmalloc N*(alloc free)(16)      Average=3         Average=3
Kmalloc N*(alloc free)(32)      Average=3         Average=3
Kmalloc N*(alloc free)(64)      Average=3         Average=3
Kmalloc N*(alloc free)(128)     Average=3         Average=3
Kmalloc N*(alloc free)(256)     Average=3         Average=3
Kmalloc N*(alloc free)(512)     Average=3         Average=3
Kmalloc N*(alloc free)(1024)    Average=3         Average=3
Kmalloc N*(alloc free)(2048)    Average=3         Average=3
Kmalloc N*(alloc free)(4096)    Average=3         Average=3

Can the above data indicate that this modification (only works when 
kmem_cache_debug(s) is true) does not introduce significant performance 
impact?

Thanks for your time.
> 
> It maybe useful to figure out what memory structure causes the increase in
> latency in a NUMA environment. If you can figure that out and properly
> allocate the memory structure that causes the increases in latency then
> you may be able to increase the performance of the allocator.
