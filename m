Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABC5A1DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiHZBCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHZBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A6C8766
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661475718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=55IY0tBVreEhc/qQznZNgTXxop1WyqSOt3dgHwJZSK0=;
        b=KbiQumyNFFyyH9QY07UyljxIqFe//unmRlOZMpG8iqoyVctfBRpfF0WTLqfR6fidmahzwn
        HqhvKHbzaj3ZqioSQUTZ6cVNGpIKL7sP89nBXLfdEyqGwzNX7Q43ohT6NNBWgM0pSq9dlX
        4E+G1UduzJzOTjmkjjhXEPVO17A5rLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-deFiVVE-PCSIPJpmauqJ1A-1; Thu, 25 Aug 2022 21:01:54 -0400
X-MC-Unique: deFiVVE-PCSIPJpmauqJ1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A90A101A54E;
        Fri, 26 Aug 2022 01:01:53 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45B372026D4C;
        Fri, 26 Aug 2022 01:01:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/5] sched: Persistent user requested affinity
Date:   Thu, 25 Aug 2022 21:01:14 -0400
Message-Id: <20220826010119.1265764-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
 - Drop the cpuset patch and make user_cpus_ptr masking applicable to
   all callers of set_cpus_allowed_ptr().
 - Make user_cpus_ptr and cpus_mask update in a single lock critical
   section to avoid race problems.

v5:
 - Update patch 3 to handle race with concurrent sched_setaffinity()
   by rechecking a previously cleared user_cpus_ptr afterward.

v4:
 - Update patch 1 to make sched_setaffinity() the only function to
   update user_cpus_ptr to make the logic simpler and
   easier to understand. restrict_cpus_allowed_ptr() and
   relax_compatible_cpus_allowed_ptr() will just use it if present.

The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity")
which uses it narrowly to allow keeping cpus affinity intact with
asymmetric cpu setup.

This patchset extends user_cpus_ptr to store user requested cpus affinity
via the sched_setaffinity() API. With that information available, it will
enable cpuset and other callers of set_cpus_allowed_ptr() like hotplug
to keep cpus afinity as close to what the user wants as possible within
the cpu list constraint of the current cpuset. Otherwise some change
to the cpuset hierarchy or a hotplug event may reset the cpumask of
the tasks in the affected cpusets to the default cpuset value even if
those tasks have cpus affinity explicitly set by the users before.

It also means that once sched_setaffinity() is called, user_cpus_ptr
will remain allocated until the task exits.

Waiman Long (5):
  sched: Add __releases annotations to affine_move_task()
  sched: Use user_cpus_ptr for saving user provided cpumask in
    sched_setaffinity()
  sched: Enforce user requested affinity
  sched: Handle set_cpus_allowed_ptr() & sched_setaffinity() race
  sched: Fix sched_setaffinity() and fork/clone() race

 kernel/sched/core.c  | 174 +++++++++++++++++++++++++++----------------
 kernel/sched/sched.h |  11 ++-
 2 files changed, 121 insertions(+), 64 deletions(-)

-- 
2.31.1

