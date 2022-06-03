Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124BC53C367
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiFCDfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFCDfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:35:39 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153E36E25
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:35:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VFDf1ro_1654227332;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VFDf1ro_1654227332)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jun 2022 11:35:33 +0800
Message-ID: <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com>
Date:   Fri, 3 Jun 2022 11:35:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:101.0)
 Gecko/20100101 Thunderbird/101.0
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>,
        David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
 <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
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

Hi, Christoph, David, Muchun and Hyeonggon

Thanks for your time.

Recently, I am also find other ways to solve this. That case was 
provided by Muchun is useful (Thanks Muchun!). Indeed, it seems that use 
n->list_lock here is unwise. Actually, I'm not sure if you recognize the 
existence of such race? If all agrees this race, then the next question 
may be: do we want to solve this problem? or as David said, it would be 
better to deprecate validate attribute directly. I have no idea about 
it, hope to rely on your experience.

In fact, I mainly want to collect your views on whether or how to fix 
this bug here. Thanks!

Thanks again for your time:).
-wrw

On 6/2/22 11:14 PM, Christoph Lameter wrote:
> On Mon, 30 May 2022, David Rientjes wrote:
> 
>>> Unconditionally taking n->list_lock will degrade performance.
>>
>> This is a good point, it would be useful to gather some benchmarks for
>> workloads that are known to thrash some caches and would hit this path
>> such as netperf TCP_RR.
> 
> Its obvious that adding new spinlocks to some of the hottest functions in
> the kernel will degrade performance. This goes against the basic design of
> these functions to be as efficient as possible.
