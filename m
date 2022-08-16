Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102B959624A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiHPSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiHPSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E88672E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660674025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zt00RDNEV7RZzMeybSvzEigJSmadOEJNQKxj71oBngw=;
        b=B0DMetWA2x1N3S+GTgQ2qTYCPgqvKswxI5SDhiHmtcoFDCybFmE5TfOsOcC6GfMZxmZR4/
        RmW5nlypKImSTGpf8Ngm7pso3xibPNzoGiLHvtF9IBzh6JICi/0SCr8Kt5R4EiAeL/LNX6
        yVZFQToC9LUYoTJ5d93SBIsvhpJWSaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-OP6_wUY5PAidR_CImGISrg-1; Tue, 16 Aug 2022 14:20:23 -0400
X-MC-Unique: OP6_wUY5PAidR_CImGISrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4037A180F6DF;
        Tue, 16 Aug 2022 18:20:23 +0000 (UTC)
Received: from [10.22.10.201] (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71EDC40D2827;
        Tue, 16 Aug 2022 18:20:22 +0000 (UTC)
Message-ID: <ea5267dd-a6b7-83c1-1fdd-9567b55b7e74@redhat.com>
Date:   Tue, 16 Aug 2022 14:20:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/3] cgroup/cpuset: Keep user set cpus affinity
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220816151119.29534-1-longman@redhat.com>
 <20220816151119.29534-4-longman@redhat.com>
 <YvvR2Sa6LxZLwXsJ@slm.duckdns.org>
 <349849aa-937d-8b08-a836-7c5c70168139@redhat.com>
 <YvvZc7KgZT/bRoKl@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvvZc7KgZT/bRoKl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 13:52, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 16, 2022 at 01:38:17PM -0400, Waiman Long wrote:
>> Yes, a race like this is possible. To completely eliminate the race may
>> require taking task_rq_lock() and then calling
>> __set_cpus_allowed_ptr_locked() which is internal to kernel/sched/core.c.
>>
>> Alternatively, we can check user_cpus_ptr again after the scond
>> set_cpus_allowed_ptr() and retry it with the other path if set. That will
>> probably address your concern. Please let me know if you are OK with that.
> I think this would look better if structured the other way around - make the
> scheduler side call out to cpuset to query the current restrictions and
> apply it atomically.

The sched_setaffinity() function does call cpuset_cpus_allowed() to 
apply the cpuset constraint. However, making set_cpus_allowed_ptr() call 
cpuset function is a major change. It will disturb the current locking 
sequences and may cause circular locking dependency problem. We 
certainly need more time to figure out if that is feasible.

In the mean time, I would prefer to do a retry if user_cpus_ptr status 
changes for now. We can then do a follow up patch to make this 
structural change if there is a consensus of doing so.

Cheers,
Longman

