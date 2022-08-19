Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7111D599E98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349780AbiHSPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349679AbiHSPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:33:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB682F015
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:33:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164F7ED1;
        Fri, 19 Aug 2022 08:33:52 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EA9F3F66F;
        Fri, 19 Aug 2022 08:33:46 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     qperret@google.com, Pierre Gondois <pierre.gondois@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 0/2] sched/fair: feec()/scale_rt_capacity() improvements
Date:   Fri, 19 Aug 2022 17:33:18 +0200
Message-Id: <20220819153320.291720-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set aims to improve:
 - find_energy_efficient_cpu() by removing max_spare_cap_cpu from
   the candidate CPUs if prev_cpu is already the CPU with the
   maximum spared capacity.
 - scale_rt_capacity() by using irq scaling on RT and DL rq signals
   and removing irq signal from the available remaining capacity.

Pierre Gondois (2):
  sched/fair: Check if prev_cpu has highest spare cap in feec()
  sched/fair: Use IRQ scaling for all sched classes

 kernel/sched/fair.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

-- 
2.25.1

