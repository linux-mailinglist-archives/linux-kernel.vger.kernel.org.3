Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE91550202
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383869AbiFRCeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:34:00 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476423C4BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:33:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VGhbwTR_1655519632;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VGhbwTR_1655519632)
          by smtp.aliyun-inc.com;
          Sat, 18 Jun 2022 10:33:54 +0800
Message-ID: <1b434d4c-2a19-9ac1-b2b9-b767b642ec0c@linux.alibaba.com>
Date:   Sat, 18 Jun 2022 10:33:51 +0800
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
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206171617560.638056@gentwo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 10:19 PM, Christoph Lameter wrote:
> On Fri, 17 Jun 2022, Rongwei Wang wrote:
> 
>> Christoph, I refer [1] to test some data below. The slub_test case is same to
>> your provided. And here you the result of its test (the baseline is the data
>> of upstream kernel, and fix is results of patched kernel).
> 
> Ah good.
>> Single thread testing
>>
>> 1. Kmalloc: Repeatedly allocate then free test
>>
>>                     before (baseline)        fix
>>                     kmalloc      kfree       kmalloc      kfree
>> 10000 times 8      7 cycles     8 cycles    5 cycles     7 cycles
>> 10000 times 16     4 cycles     8 cycles    3 cycles     6 cycles
>> 10000 times 32     4 cycles     8 cycles    3 cycles     6 cycles
> 
> Well the cycle reduction is strange. Tests are not done in the same
> environment? Maybe good to not use NUMA or bind to the same cpu
It's the same environment. I can sure. And there are four nodes (32G 
per-node and 8 cores per-node) in my test environment. whether I need to 
test in one node? If right, I can try.
> 
>> 10000 times 64     3 cycles     8 cycles    3 cycles     6 cycles
>> 10000 times 128    3 cycles     8 cycles    3 cycles     6 cycles
>> 10000 times 256    12 cycles    8 cycles    11 cycles    7 cycles
>> 10000 times 512    27 cycles    10 cycles   23 cycles    11 cycles
>> 10000 times 1024   18 cycles    9 cycles    20 cycles    10 cycles
>> 10000 times 2048   54 cycles    12 cycles   54 cycles    12 cycles
>> 10000 times 4096   105 cycles   20 cycles   105 cycles   25 cycles
>> 10000 times 8192   210 cycles   35 cycles   212 cycles   39 cycles
>> 10000 times 16384  133 cycles   45 cycles   119 cycles   46 cycles
> 
> 
> Seems to be different environments.
> 
>> According to the above data, It seems that no significant performance
>> degradation in patched kernel. Plus, in concurrent allocs test, likes Kmalloc
>> N*alloc N*free(1024), the data of 'fix' column is better than baseline (it
>> looks less is better, if I am wrong, please let me know). And if you have
>> other suggestions, I can try to test more data.
> 
> Well can you explain the cycle reduction?
Maybe because of four nodes in my system or only 8 cores (very small) in 
each node? Thanks, you remind me that I need to increase core number of 
each node or change node number to compere the results.

Thanks!


