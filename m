Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB05B2151
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIHOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiIHOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E2237F3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662648889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+tgxvDkYie/bfExXzV4wIj4MOkmrhM2J0GGX58tqYM=;
        b=DxgeW6DTKpwjMzdwTg55uaFExCRFibq9Yx1GdOZgnWtpy8gDkhOnsZU4/n3HWrx08C01Tf
        fNMOwGLTE1Nr60PC04IAThhUPA2U6uN7rEFghxMjzT+CjDZP99VuSoFLCWSog16L13x0QT
        kYSnhK4HIvR8hay9ek6N8qMaPdySXS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-UGKLkeGaPH6q0mhdL9VGjQ-1; Thu, 08 Sep 2022 10:54:44 -0400
X-MC-Unique: UGKLkeGaPH6q0mhdL9VGjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16C4785A58D;
        Thu,  8 Sep 2022 14:54:44 +0000 (UTC)
Received: from [10.22.9.66] (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B11222026D07;
        Thu,  8 Sep 2022 14:54:42 +0000 (UTC)
Message-ID: <0735a6bf-7d92-5564-ae57-d6c05d0a7a4c@redhat.com>
Date:   Thu, 8 Sep 2022 10:54:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 4/5] sched: Handle set_cpus_allowed_ptr() &
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
References: <20220902152556.373658-1-longman@redhat.com>
 <20220902152556.373658-5-longman@redhat.com>
 <YxnXsnDEKKWeAYDY@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YxnXsnDEKKWeAYDY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/22 07:53, Peter Zijlstra wrote:
> On Fri, Sep 02, 2022 at 11:25:55AM -0400, Waiman Long wrote:
>> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
>> or between multiple sched_setaffinity() calls from different
>> CPUs. To resolve these race conditions, we need to update both
>> user_cpus_ptr and cpus_mask in a single lock critical section instead
>> of separated ones. This requires moving the user_cpus_ptr update to
>> set_cpus_allowed_common().
>>
>> The SCA_USER flag will be used to signify that a user_cpus_ptr update
>> will have to be done. The new user_cpus_ptr will be put into the
>> a percpu variable pending_user_mask at the beginning of the lock
>> crtical section. The pending user mask will then be taken up in
>> set_cpus_allowed_common().
>>
>> Ideally, user_cpus_ptr should only be updated if the sched_setaffinity()
>> is successful. However, this patch will update user_cpus_ptr when the
>> first call to __set_cpus_allowed_ptr() is successful. However, if there
>> is racing between sched_setaffinity() and cpuset update, the subsequent
>> calls to __set_cpus_allowed_ptr() may fail but the user_cpus_ptr will
>> still be updated in this corner case. A warning will be printed in this
>> corner case.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> OK, so obviously this is terrible :/
>
> What's wrong with something like so ?

Thanks for the suggestion. I have no problem adding an affinity_context 
structure to pass around the functions. Will incorporate your suggestion 
in the next version of the patch.

Thanks,
Longman


