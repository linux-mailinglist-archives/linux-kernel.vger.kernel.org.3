Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB653463B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiEYWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiEYWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530FE0DE;
        Wed, 25 May 2022 15:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1BF861A6A;
        Wed, 25 May 2022 22:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5123DC385B8;
        Wed, 25 May 2022 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653516662;
        bh=8/oAklBNbfDZaQphmdXoJ98F8nopGS+/8AEvEDWMLbk=;
        h=From:To:Cc:Subject:Date:From;
        b=MJWvB/ODlUHciOIPMxKAovxcKbwhU8h35M/Dhz+772gBaJXSS8VB36kvrkjU8goKX
         AOtL7h44GEu6Se0Zvgev6RZyhxgulOcobYDG7A40iiYD8edSAJHMSUOJbYh5aIhHf/
         jFQT/MJgvH9uTl07Pb9F+IltQnejvJ8jXKw6FnxyOpjWLZwsRtrzKpJKP91SdjLpwW
         Iizk5od9qo8K1MZC9Rt8GLTozhHYVzMIfJZeE81eLieKkv3ftko1raAomyyBN69pE+
         MoWFH4Nn8D4bhoOs/9NxddLBqvDgU5KD6roykx5Cc/Z3eydTbAl1OnSjy5X1ezg5+h
         MoenN2aOuY/vA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: [PATCH 0/4] rcu/cpuset: Control RCU_NOCB offloading through cpusets
Date:   Thu, 26 May 2022 00:10:51 +0200
Message-Id: <20220525221055.1152307-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infrastructure in RCU and housekeeping code are finally ready
for this. Now it's time to introduce CPU isolation feature files
to cpusets. Here is the first one.

RCU NOCB is an RCU feature that offloads RCU callbacks lifecycle
handling and execution out of the enqueuer's CPU softirq to specific
kthreads instead (rcuo and rcuog). This pulls some kernel noise out of
CPUs that may run critical code. This is usually associated with
nohz_full.

The CPUs list to be set in RCU NOCB mode is defined on boot time
through the "rcu_nocbs=" kernel parameter and can't be changed afterward.
This patchset aims at allowing for changing this on runtime through cpuset.

I may have missed a few things in the last patch, such as partition type
changes to/from error mode, I'm not sure... Anyway it's an RFC and it
doesn't yet provide documentation in this early posting.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	cpuset/nocb

HEAD: ad895c0b6a5e3c41d46f184900d193e70bfc90d3

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
      rcu/nocb: Prepare to change nocb cpumask from CPU-hotplug protected cpuset caller
      sched/isolation: Infrastructure to support rcu nocb cpumask changes
      cpuset: Support RCU-NOCB toggle on v2 root partitions


 include/linux/rcupdate.h        |   9 ++--
 include/linux/sched/isolation.h |  13 +++++
 kernel/cgroup/cpuset.c          |  95 +++++++++++++++++++++++++++++++++--
 kernel/rcu/rcutorture.c         |   6 ++-
 kernel/rcu/tree_nocb.h          | 106 +++++++++++++++++++++++++++-------------
 kernel/sched/isolation.c        |  38 ++++++++++++++
 6 files changed, 223 insertions(+), 44 deletions(-)
