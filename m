Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD853685C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351367AbiE0VIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiE0VIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F62A26E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:References;
        bh=Z+4+95ohfAKCNl77j5bYLAiF3pRGTU9rwn1dtnYMDaU=; b=AcW+1q2V6NnC/XP6ZplzUSyc2L
        cQ22b1/HTqS9sxS2W9pS3Pi88cUJu9PYkr5NYp/NaLh4SICowv3nqibARuYClvGwLxWgvKkHSdQdR
        K71663Tqw5hRC01Ik8gIvxJPVw3ncltm8igWvjU+XqXCtev+OzOe5q5WYAUT9CaGdz+d6UqHE2mhY
        ko4zImYI9AO6zZpFb9l/uTN2gFvO1tTLI1N7kdEBv7DQ6wx0po7zvG9pnrVM5nBNIey2dPqAa+Rpm
        eYkmUrX4nr8jTtFhPbkxUiVXnHBpvFoyvIzW/ygHg3G2328DvtsMKiuUJgdeUA1tk/HiLQIX6TCl8
        LUJpHLWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuhBV-000yGC-8c; Fri, 27 May 2022 21:07:49 +0000
Date:   Fri, 27 May 2022 14:07:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Baisong Zhong <zhongbaisong@huawei.com>,
        kbuild-all@lists.01.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: fix compilation on i386 for umax_rt_runtime
Message-ID: <YpE9pSVwqzrj+Rso@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205280150.1w6rdhr4-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i386 you can end up with this compilation warning:

kernel/sched/rt.c:9:18: warning: 'max_rt_runtime' defined but not used [-Wunused-const-variable=]

This can happen when SYSCTL or RT_GROUP_SCHED is disabled.
Fix this.

Reported-by: kernel test robot <lkp@intel.com>
Cc: Baisong Zhong <zhongbaisong@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@bgt140507bm04>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..eb2a167be098 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,8 +5,10 @@
  */
 
 int sched_rr_timeslice = RR_TIMESLICE;
+#if defined(CONFIG_SYSCTL) || defined(CONFIG_RT_GROUP_SCHED)
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
+#endif
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
-- 
2.35.1

