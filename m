Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87A54A71A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354629AbiFNCzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbiFNCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:55:32 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D8D3B3C9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:38:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VGLIXr6_1655174282;
Received: from 30.240.98.139(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VGLIXr6_1655174282)
          by smtp.aliyun-inc.com;
          Tue, 14 Jun 2022 10:38:03 +0800
Message-ID: <b2a56713-a3e9-ea39-1fa1-663e9c6cdf2c@linux.alibaba.com>
Date:   Tue, 14 Jun 2022 10:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>, penberg@kernel.org
Cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
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
OK
> 
> There are also synthetic benchmarks available  at
> https://gentwo.org/christoph/slub/tests/
That's great, thanks very much!
> 
> These measure the cycles that slab operations take. However, they are a
> bit old and I think Pekka may have a newer version of these
> patches.
> 
> Greetings,
> 	Christoph
