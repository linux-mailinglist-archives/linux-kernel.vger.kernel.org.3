Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5234CADA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbiCBSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiCBSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:35:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76C0FCA0E3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:34:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E3D3139F;
        Wed,  2 Mar 2022 10:34:46 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A4383F73D;
        Wed,  2 Mar 2022 10:34:43 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] sched/deadline, (rt): Sched class cleanups
Date:   Wed,  2 Mar 2022 19:34:27 +0100
Message-Id: <20220302183433.333029-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to improve the Deadline sched class behaviour for
asymmetric CPU capacity systems I came across some possible
cleanups for DL (and RT).

Overview:

[PATCH 1/6] - Remove `struct dl_bandwidth def_dl_bandwidth`.

[PATCH 2/6] - Move functions into DL sched class which don't have to
              be exported.

[PATCH 3/6] - Merge two DL admission control functions which provide
              very similar functionality.

[PATCH 4/6] - Use DL rb_entry() macros and cached rbtree wrapper
              `rb_first_cached()` consistently.

[PATCH 5/6] - Remove unused !CONFIG_SMP function definitions in DL/RT.

[PATCH 6/6] - Remove redundant function parameter in DL/RT.

Dietmar Eggemann (6):
  sched/deadline: Remove unused def_dl_bandwidth
  sched/deadline: Move bandwidth mgmt and reclaim functions into sched
    class source file
  sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()
  sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached()
    consistently
  sched/deadline,rt: Remove unused functions for !CONFIG_SMP
  sched/deadline,rt: Remove unused parameter from
    pick_next_[rt|dl]_entity()

 kernel/sched/core.c     |  14 ++--
 kernel/sched/deadline.c | 141 ++++++++++++++++++++--------------------
 kernel/sched/rt.c       |  16 +----
 kernel/sched/sched.h    |  53 +--------------
 4 files changed, 84 insertions(+), 140 deletions(-)

-- 
2.25.1

