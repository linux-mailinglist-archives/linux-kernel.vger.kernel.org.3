Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B0584518
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiG1RmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiG1RmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2EF1743EC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659030126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osQ+/ROGDL1CS+JW7FUiX/rfJGzXDL7QFiEzVel9WBs=;
        b=KK7JfAQPscIaYoYM1hAX5N+HC2q5N0xKUsO8KFR2vBJcUHF2KFDlYZWoJodhnrvfYNJ301
        k8Ysc1ij9+Efp1Htrl3O/56FeswYxhtifPL/I4svBDUgQDOhdJfZEjal+/H429hvdc7Byr
        a8Oo1a5AjIQ61eGWkD9DxZac4dB2+9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-kbElYJGYP7e0wjYiY39SOA-1; Thu, 28 Jul 2022 13:42:03 -0400
X-MC-Unique: kbElYJGYP7e0wjYiY39SOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBCFE101A586;
        Thu, 28 Jul 2022 17:42:02 +0000 (UTC)
Received: from [10.22.9.86] (unknown [10.22.9.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82D371121315;
        Thu, 28 Jul 2022 17:42:01 +0000 (UTC)
Message-ID: <d00a8b5b-86c6-2d57-36a5-894ca70f2472@redhat.com>
Date:   Thu, 28 Jul 2022 13:42:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728144420.GA27407@blackbody.suse.cz>
 <a58852b4-313a-9271-f31d-f79a91ec188b@redhat.com>
 <xhsmhbkt9dvwm.mognet@vschneid.remote.csb>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <xhsmhbkt9dvwm.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 12:50, Valentin Schneider wrote:
> On 28/07/22 10:59, Waiman Long wrote:
>> On 7/28/22 10:44, Michal Koutný wrote:
>>> This should apply only to tasks that were extracted out of the root
>>> cgroup, no? (OK, those are all processes practically.)
>> The reset is done on all cgroups in a particular subtree. In the case of
>> cgroup root, it is all the processes in the system.
> I've been briefly playing with this, tasks in the cgroup root don't seem
> affected on my end (QEMU + buildroot + latest tip/sched/core):
>
>    $ mount -t cgroup2 none /sys/fs/cgroup
>    $ /root/loop.sh &
>    $ PID=$!
>    $ taskset -pc 2-3 $PID
>    pid 177's current affinity list: 0-3
>    pid 177's new affinity list: 2,3
>    $ echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>    $ taskset -pc $PID
>    pid 177's current affinity list: 2,3
>
> However tasks extracted out as mentioned by Michal definitely are:
>
>    $ mount -t cgroup2 none /sys/fs/cgroup
>    $ /root/loop.sh &
>    $ PID=$!
>    $ taskset -pc 2-3 $PID
>    pid 172's current affinity list: 0-3
>    pid 172's new affinity list: 2,3
>    $ mkdir /sys/fs/cgroup/foobar
>    $ echo $PID > /sys/fs/cgroup/foobar/cgroup.procs
>    $ taskset -pc $PID
>    pid 172's current affinity list: 2,3
>    $ echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>    $ taskset -pc $PID
>    pid 172's current affinity list: 0-3
>
> IIUC this is just what happens anytime a task gets migrated to a new
> cpuset. Initially loop.sh remains attached to the root cpuset, and the echo
> +cpuset migrates it to the /foobar one.
>
> Does that match what you're seeing?
>
Yes. echo "+cpuset" to subtree_control means tasks in the child cgroups 
will move to new cpusets. Those new cpusets will have the same cpu lists 
as the parent unless the cpuset.cpus files are explicitly written to. 
This patch will ensure that tasks that have explicitly set their cpu 
affinity won't be affected by this change.

Cheers,
Longman

