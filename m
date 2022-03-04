Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581C4CCBBD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiCDCZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiCDCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:25:47 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD21704FB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:24:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6AHJDk_1646360695;
Received: from 30.97.48.223(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6AHJDk_1646360695)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 10:24:56 +0800
Message-ID: <7c14bb40-1e7b-9819-1634-e9e9051726fa@linux.alibaba.com>
Date:   Fri, 4 Mar 2022 10:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/2] Alloc kfence_pool after system startup
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
 <CAG_fn=Wd5GMFojbvdZkysBQ5Auy5YYRdmZfjSVMq8gpDMRZ_3w@mail.gmail.com>
 <CANpmjNPBYgNMzQDKjNYFTkKnWwMe29gpXd2b9icFSnAwstW-jQ@mail.gmail.com>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <CANpmjNPBYgNMzQDKjNYFTkKnWwMe29gpXd2b9icFSnAwstW-jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/3 17:30, Marco Elver wrote:

Thanks for your replies.
I do see setting a large sample_interval means almost disabling KFENCE.
In fact, my point is to provide a more “flexible” way. Since some Ops 
may be glad to use something like on/off switch than 10000ms interval. :-)

> On Thu, 3 Mar 2022 at 10:05, Alexander Potapenko <glider@google.com> wrote:
> 
> I share Alex's concerns.
> 
>> On Thu, Mar 3, 2022 at 4:15 AM Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>>>
>>> KFENCE aims at production environments, but it does not allow enabling
>>> after system startup because kfence_pool only alloc pages from memblock.
>>> Consider the following production scene:
>>> At first, for performance considerations, production machines do not
>>> enable KFENCE.
>>
>> What are the performance considerations you have in mind? Are you running KFENCE with a very aggressive sampling rate?
> 
> Indeed, what is wrong with simply starting up KFENCE with a sample
> interval of 10000? However, I very much doubt that you'll notice any
> performance issues above 500ms.
> 
> Do let us know what performance issues you have seen. It may be
> related to an earlier version of KFENCE but has since been fixed (see
> log).
> 
>>> However, after running for a while, the kernel is suspected to have
>>> memory errors. (e.g., a sibling machine crashed.)
>>
>> I have doubts regarding this setup. It might be faster (although one can tune KFENCE to have nearly zero performance impact), but is harder to maintain.
>> It will also catch fewer errors than if you just had KFENCE on from the very beginning:
>>   - sibling machines may behave differently, and a certain bug may only occur once - in that case the secondary instances won't notice it, even with KFENCE;
>>   - KFENCE also catches non-lethal corruptions (e.g. OOB reads), which may stay under radar for a very long time.
>>
>>>
>>> So other production machines need to enable KFENCE, but it's hard for
>>> them to reboot.
>>>
>>> The 1st patch allows re-enabling KFENCE if the pool is already
>>> allocated from memblock.
> 
> Patch 1/2 might be ok by itself, but I still don't see the point
> because you should just leave KFENCE enabled. There should be no
> reason to have to turn it off. If anything, you can increase the
> sample interval to something very large if needed.

