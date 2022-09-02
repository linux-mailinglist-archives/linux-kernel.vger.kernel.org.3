Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020A35AB56E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiIBPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbiIBPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E662E4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662132375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Vzb+A06gj3YEFaNRgNBITnr4gCLlyhqeDsNLnjqfFA=;
        b=b6maIGZMn0n6CUWpZg4CeCCDhYZmaBUOnTQOHrcGflP0Vp+Bpv8qACJWIlZ5UsZ86B2NzH
        sPaqA6dJgfqUxXo3+4t4jG3vZ91YQpCQLkKlV9LJlP2iusO2En9OpMyvUDnew/KJd+mO3j
        TO6P9V+A4RNViuuicu5iATnHto1moxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-xPxsJNiqNG2sNi7MIw2_cA-1; Fri, 02 Sep 2022 11:26:10 -0400
X-MC-Unique: xPxsJNiqNG2sNi7MIw2_cA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63F4A811E83;
        Fri,  2 Sep 2022 15:26:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 426DD141513C;
        Fri,  2 Sep 2022 15:26:08 +0000 (UTC)
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
Subject: [PATCH v7 0/5] sched: Persistent user requested affinity
Date:   Fri,  2 Sep 2022 11:25:51 -0400
Message-Id: <20220902152556.373658-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
 - Make changes recommended by Peter such as making scratch_mask
   allocation earlier and using percpu variable to pass information.

v6:
 - Drop the cpuset patch and make user_cpus_ptr masking applicable to
   all callers of set_cpus_allowed_ptr().
 - Make user_cpus_ptr and cpus_mask update in a single lock critical
   section to avoid race problems.

v5:
 - Update patch 3 to handle race with concurrent sched_setaffinity()
   by rechecking a previously cleared user_cpus_ptr afterward.

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

 kernel/sched/core.c  | 125 +++++++++++++++++++++++++------------------
 kernel/sched/sched.h |  10 ++++
 2 files changed, 83 insertions(+), 52 deletions(-)

-- 
2.31.1

