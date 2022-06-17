Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6E54F248
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380681AbiFQHzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380682AbiFQHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:55:43 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7EB674F6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:55:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VGeDMg5_1655452536;
Received: from 30.25.208.161(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VGeDMg5_1655452536)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 15:55:37 +0800
Message-ID: <5085437c-adc9-b6a3-dbd8-91dc0856cf19@linux.alibaba.com>
Date:   Fri, 17 Jun 2022 15:55:35 +0800
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
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206131548420.295113@gentwo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 9:50 PM, Christoph Lameter wrote:
> On Sat, 11 Jun 2022, Rongwei Wang wrote:
> 
>>> Ok so the idea is to take the lock only if kmem_cache_debug. That looks
>>> ok. But it still adds a number of new branches etc to the free loop.
>>>
>>> Some performance tests would be useful.
>> Hi Christoph
>>
>> Thanks for your time!
>> Do you have some advice in benchmarks that need me to test? And I find that
>> hackbench and lkp was used frequently in mm/slub.c commits[1,2]. But I have no
>> idea how to use these two benchmarks test to cover the above changes. Can you
>> give some examples? Thanks very much!
> 
> 
> Hi Rongwei,
> 
> Well run hackbench with an without the change.
> 
> There are also synthetic benchmarks available  at
> https://gentwo.org/christoph/slub/tests/
Christoph, I refer [1] to test some data below. The slub_test case is 
same to your provided. And here you the result of its test (the baseline 
is the data of upstream kernel, and fix is results of patched kernel).

my test environment: arm64 vm (32 cores and 128G memory)

And I have removed 'slub_debug=UFPZ' in cmdline before testing the 
following two groups of data.

[1]https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/

Single thread testing

1. Kmalloc: Repeatedly allocate then free test

                    before (baseline)        fix
                    kmalloc      kfree       kmalloc      kfree
10000 times 8      7 cycles     8 cycles    5 cycles     7 cycles
10000 times 16     4 cycles     8 cycles    3 cycles     6 cycles
10000 times 32     4 cycles     8 cycles    3 cycles     6 cycles
10000 times 64     3 cycles     8 cycles    3 cycles     6 cycles
10000 times 128    3 cycles     8 cycles    3 cycles     6 cycles
10000 times 256    12 cycles    8 cycles    11 cycles    7 cycles
10000 times 512    27 cycles    10 cycles   23 cycles    11 cycles
10000 times 1024   18 cycles    9 cycles    20 cycles    10 cycles
10000 times 2048   54 cycles    12 cycles   54 cycles    12 cycles
10000 times 4096   105 cycles   20 cycles   105 cycles   25 cycles
10000 times 8192   210 cycles   35 cycles   212 cycles   39 cycles
10000 times 16384  133 cycles   45 cycles   119 cycles   46 cycles


2. Kmalloc: alloc/free test

                                   before (base)   fix
10000 times kmalloc(8)/kfree      3 cycles        3 cycles
10000 times kmalloc(16)/kfree     3 cycles        3 cycles
10000 times kmalloc(32)/kfree     3 cycles        3 cycles
10000 times kmalloc(64)/kfree     3 cycles        3 cycles
10000 times kmalloc(128)/kfree    3 cycles        3 cycles
10000 times kmalloc(256)/kfree    3 cycles        3 cycles
10000 times kmalloc(512)/kfree    3 cycles        3 cycles
10000 times kmalloc(1024)/kfree   3 cycles        3 cycles
10000 times kmalloc(2048)/kfree   3 cycles        3 cycles
10000 times kmalloc(4096)/kfree   3 cycles        3 cycles
10000 times kmalloc(8192)/kfree   3 cycles        3 cycles
10000 times kmalloc(16384)/kfree  33 cycles       33 cycles


Concurrent allocs

                                 before (baseline)   fix
Kmalloc N*alloc N*free(8)       Average=17/18       Average=11/11
Kmalloc N*alloc N*free(16)      Average=15/49       Average=9/11
Kmalloc N*alloc N*free(32)      Average=15/40       Average=9/11
Kmalloc N*alloc N*free(64)      Average=15/44       Average=9/10
Kmalloc N*alloc N*free(128)     Average=15/42       Average=10/10
Kmalloc N*alloc N*free(256)     Average=128/28      Average=71/22
Kmalloc N*alloc N*free(512)     Average=206/34      Average=178/26
Kmalloc N*alloc N*free(1024)	Average=762/37      Average=369/27
Kmalloc N*alloc N*free(2048)	Average=327/58      Average=339/33
Kmalloc N*alloc N*free(4096)    Average=2255/128    Average=1813/64

                                 before (baseline)   fix
Kmalloc N*(alloc free)(8)       Average=3           Average=3
Kmalloc N*(alloc free)(16)      Average=3           Average=3
Kmalloc N*(alloc free)(32)      Average=3           Average=3
Kmalloc N*(alloc free)(64)      Average=3           Average=3
Kmalloc N*(alloc free)(128)     Average=3           Average=3
Kmalloc N*(alloc free)(256)     Average=3           Average=3
Kmalloc N*(alloc free)(512)     Average=3           Average=3
Kmalloc N*(alloc free)(1024)    Average=3           Average=3
Kmalloc N*(alloc free)(2048)    Average=3           Average=3
Kmalloc N*(alloc free)(4096)	Average=3           Average=3

According to the above data, It seems that no significant performance 
degradation in patched kernel. Plus, in concurrent allocs test, likes 
Kmalloc N*alloc N*free(1024), the data of 'fix' column is better than 
baseline (it looks less is better, if I am wrong, please let me know). 
And if you have other suggestions, I can try to test more data.

Thanks for your time!
-wrw
> 
> These measure the cycles that slab operations take. However, they are a
> bit old and I think Pekka may have a newer version of these
> patches.
> 
> Greetings,
> 	Christoph
