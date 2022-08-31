Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18805A87BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiHaUxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E692ED00A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661979205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c8FOInGh6aB8LJuBuSIBpg3qtxrp4M3Tjl6gBmcttD4=;
        b=OfrJlBYbU3bTWJCdt7qdHv4bbFs95qUoJ5G4oza2dwEhb2WTFm9A8BX/aGp2J/zRM4LfM9
        sEIn1tIGW5nSkR1sSEww2Ukm6ysIM/vD0dTRWDULGZNh23O74VW5vTiXxrcSaPmTbXc7PP
        vK+bLN85PqqSqfM6VetemEFGW7cSB88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-9qR3P8ZKNvSYPVVNIly3Zw-1; Wed, 31 Aug 2022 16:53:22 -0400
X-MC-Unique: 9qR3P8ZKNvSYPVVNIly3Zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74143101A56C;
        Wed, 31 Aug 2022 20:53:21 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C744F2026D4C;
        Wed, 31 Aug 2022 20:53:20 +0000 (UTC)
Message-ID: <8dc0fac7-5451-022f-b3e9-11656c93c34d@redhat.com>
Date:   Wed, 31 Aug 2022 16:53:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 4/5] sched: Handle set_cpus_allowed_ptr() &
 sched_setaffinity() race
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-5-longman@redhat.com>
 <Yw8pOVhOV9XVe9nq@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yw8pOVhOV9XVe9nq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/22 05:26, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 09:01:18PM -0400, Waiman Long wrote:
>> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
>> or between multiple sched_setaffinity() calls from different CPUs. To
>> resolve these race conditions, we need to update both user_cpus_ptr
>> and cpus_mask in a single lock critical section instead of separated
>> ones. This requires moving the user_cpus_ptr update to
>> affine_move_task() before doing task_rq_unlock().
>>
>> A new argument puser_mask is added to affine_move_task(),
>> __set_cpus_allowed_ptr_locked() and __set_cpus_allowed_ptr() to do that.
>>
>> Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
>> is successful. However, this patch will update user_cpus_ptr when the
>> first call to __set_cpus_allowed_ptr() is successful. However, if there
>> is racing between sched_setaffinity() and cpuset update, the subsequent
>> calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
>> still be updated in this corner case.
> Urgh, this is a bit weird, to have a fix for a patch in the same series.

This is just to make each patch simpler and easier to read.

Cheers,
Longman

