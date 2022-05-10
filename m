Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576CB522457
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiEJStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349156AbiEJSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E6F1488BF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652208426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDaf3WbpWZER89SWe3+3un2eTu5W4KfGxQhX3Ozl0ck=;
        b=gj4lhj9EmMcwSE3d9fgxqAbxJTiQGQoYK0znMA7AEc7ojB0iGLj9wlmP513nBOmBkhmoWF
        rnNz6DWXM/dLv6777YLd7ZYkGKz1LiN7JTB6rhhk4ATnTNXNrYaKZtCmKIl8RsvC6R6rTP
        fTlkfXXqfBHcjm8LJZ9Kj3/3aLHEyG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-Rr2WiEDLMQCstKY51qfaRw-1; Tue, 10 May 2022 14:47:03 -0400
X-MC-Unique: Rr2WiEDLMQCstKY51qfaRw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9AF8811E7A;
        Tue, 10 May 2022 18:47:02 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33974401E74;
        Tue, 10 May 2022 18:47:02 +0000 (UTC)
Message-ID: <56474c28-e62a-36b1-257b-9e5ffb11b0e2@redhat.com>
Date:   Tue, 10 May 2022 14:47:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 14:05, Linus Torvalds wrote:
> [ Adding locking people in case they have any input ]
>
> On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
>>> Can you point me to the regression report? I would like to take a look,
>>> thanks.
>> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> Hmm.
>
> That explanation looks believable, except that our qspinlocks
> shouldn't be spinning on the lock itself, but spinning on the mcs node
> it inserts into the lock.
>
> Or so I believed before I looked closer at the code again (it's been years).
>
> It turns out we spin on the lock itself if we're the "head waiter". So
> somebody is always spinning.
>
> That's a bit unfortunate for this workload, I guess.
>
> I think from a pure lock standpoint, it's the right thing to do (no
> unnecessary bouncing, with the lock releaser doing just one write, and
> the head waiter spinning on it is doing the right thing).
>
> But I think this is an example of where you end up having that
> spinning on the lock possibly then being a disturbance on the other
> fields around the lock.
>
> I wonder if Waiman / PeterZ / Will have any comments on that. Maybe
> that "spin on the lock itself" is just fundamentally the only correct
> thing, but since my initial reaction was "no, we're spinning on the
> mcs node", maybe that would be _possible_?
>
> We do have a lot of those spinlocks embedded in other data structures
> cases. And if "somebody else is waiting for the lock" contends badly
> with "the lock holder is doing a lot of writes close to the lock",
> then that's not great.

Qspinlock still has one head waiter spinning on the lock. This is much 
better than the original ticket spinlock where there will be n waiters 
spinning on the lock. That is the cost of a cheap unlock. There is no 
way to eliminate all lock spinning unless we use MCS lock directly which 
will require a change in locking API as well as more expensive unlock.

Cheers,
Longman

