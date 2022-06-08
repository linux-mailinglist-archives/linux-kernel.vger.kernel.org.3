Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6A543FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiFHXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFHXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:34:25 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28DA100B0E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:34:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VFoWqdi_1654731252;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VFoWqdi_1654731252)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 07:34:19 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/2] sched: Queue task on wakelist in the same llc if the wakee cpu is idle
Date:   Thu,  9 Jun 2022 07:34:10 +0800
Message-Id: <20220608233412.327341-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakelist can help avoid cache bouncing and offload the overhead of waker
cpu. So far, using wakelist within the same llc only happens on
WF_ON_CPU, and this limitation could be removed to further improve
wakeup performance. The result of Unixbench Pipe-based Context Switching
can be improved up to ~10%.

The 1st patch introduces a more "correct" way to check whether the wakee
cpu is soon-to-be-idle.

The 2nd patch allows using wakelist in any case when the wakee cpu is
idle or soon-to-be-idle.

v4:
Add benchmark results about the 1st patch.
Modify some comments.

v3: https://lore.kernel.org/all/20220602040645.275555-1-dtcccc@linux.alibaba.com/
Add a patch to fix the check of nr_running.
After that, we can remove WF_ON_CPU to achieve the same purpose.
Thank Valentin and Mel.

v2: https://lore.kernel.org/all/20220527090544.527411-1-dtcccc@linux.alibaba.com/
Modify commit log to describe key point in detail.
Add more benchmark results on more archs.

v1: https://lore.kernel.org/all/20220513062427.2375743-1-dtcccc@linux.alibaba.com/

Tianchen Ding (2):
  sched: Fix the check of nr_running at queue wakelist
  sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is
    idle

 kernel/sched/core.c  | 30 ++++++++++++++++++------------
 kernel/sched/sched.h |  1 -
 2 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.27.0

