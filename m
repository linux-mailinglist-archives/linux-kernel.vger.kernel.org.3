Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66955522969
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiEKCGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiEKCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A94A140A3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652234811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kpY6g94huLC5hHTZWrmgDyWAvIH5vP9Gsdu3GUffJk=;
        b=bOqS1SbWlAxjZZ8f1Uqxk3phtHqf1tH7PLSTSbNl7LPwLJHYWTs77a2KWM7neEirOx6vtx
        LxYmvcm1CH+xjYDgK3dLSlkXHs785+dG7rgczsOqtWIuTfpfiEy2Ew6SNVpIF9bYSoO880
        qCEbaooKBuokw/KlM2CM+HpgI7mgX/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-IfjtG01JNa-ALjvb_fplvA-1; Tue, 10 May 2022 22:06:48 -0400
X-MC-Unique: IfjtG01JNa-ALjvb_fplvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E621C1C06912;
        Wed, 11 May 2022 02:06:47 +0000 (UTC)
Received: from [10.22.8.20] (unknown [10.22.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E837C40CF8E7;
        Wed, 11 May 2022 02:06:46 +0000 (UTC)
Message-ID: <e3d60afb-b761-ef91-f73d-5fadc32050d5@redhat.com>
Date:   Tue, 10 May 2022 22:06:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 21:58, ying.huang@intel.com wrote:
> On Tue, 2022-05-10 at 11:05 -0700, Linus Torvalds wrote:
>> [ Adding locking people in case they have any input ]
>>
>> On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
>> <ying.huang@intel.com> wrote:
>>>> Can you point me to the regression report? I would like to take a look,
>>>> thanks.
>>> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
>> +
>> Hmm.
>>
>> That explanation looks believable, except that our qspinlocks
>> shouldn't be spinning on the lock itself, but spinning on the mcs node
>> it inserts into the lock.
> The referenced regression report is very old (in Feb 2015 for 3.16-
> 3.17).  The ticket spinlock was still used at that time.  I believe that
> things become much better after we used qspinlock.  We can test that.

Thank for the info. Qspinlock was merged into mainline since 4.2. So 
ticket spinlock was used on all v3.* kernels. I was wondering why 
qspinlock would have produced such a large performance regression with 
just one lock spinning head waiter. So this is not such a big issue 
after all.

Cheers,
Longman

