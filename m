Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC47455C3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbiF1H6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343785AbiF1H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:57:37 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C415FCC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:57:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHgOVzx_1656403046;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VHgOVzx_1656403046)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 15:57:32 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] sched/core: Optimize load balance of core scheduling
Date:   Tue, 28 Jun 2022 15:57:22 +0800
Message-Id: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tasks with the same cookie are equal on SMT siblings, they can make
pairs when pick next task, and forceidle can be avoided.

In order to achieve this goal, we have to count how many tasks with this
cookie are in the runqueue. When counting we found a bug that task won't
enqueue into core tree when we update cookie of an uncookie'd task, so we
fix this bug first.

Cruz Zhao (3):
  sched/core: Fix the bug that task won't enqueue into core tree when
    update cookie
  sched/core: Introduce nr_running percpu for each cookie
  sched/core: Make tasks with the same cookie pairs on SMT siblings

 kernel/sched/core.c       |  7 +++++
 kernel/sched/core_sched.c | 18 ++++++------
 kernel/sched/fair.c       |  4 +--
 kernel/sched/sched.h      | 74 +++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 86 insertions(+), 17 deletions(-)

-- 
1.8.3.1

