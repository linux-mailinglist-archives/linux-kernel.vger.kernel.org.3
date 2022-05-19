Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2892F52CEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiESJHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiESJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:07:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEE49FB7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:07:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4E371F86A;
        Thu, 19 May 2022 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652951269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUZE2H0YAWPRLxiTQ7g7vKXSFtWUS5bX4Cm7xqZ04ME=;
        b=0nGp/Y+eBN3bRPL1s4w0iWDUBWGhOUX8YGE19Q+1z+vhyPPck7mXJGOw7FwwSJgO50nm62
        /ffm5wxldj4wETJK1EtiK/8rXUdO9Rma/1phjwdbtKk3dvpNa3Z2oIl8rwNFembTtgt3Im
        E8CAHf1NiJRp+vgq1qhBHjAn9gQseEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652951269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUZE2H0YAWPRLxiTQ7g7vKXSFtWUS5bX4Cm7xqZ04ME=;
        b=fv+w6HjV2M3wOg3LsEyV9CHo2gV7WkHYI/ZTmwIrz/VZfsvenoYoF5JTPUs8t4maEA4tFZ
        sB3VzjEJ+pfwSbCg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05B152C142;
        Thu, 19 May 2022 09:07:48 +0000 (UTC)
Date:   Thu, 19 May 2022 10:07:46 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [peterz-queue:sched/core 6/8] kernel/sched/fair.c:9199:30:
 error: implicit declaration of function 'adjust_numa_imbalance'
Message-ID: <20220519090746.GT20579@suse.de>
References: <202205190911.n5iX1ftB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202205190911.n5iX1ftB-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:55:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   45ff65aa1bfd4826331c9c4daafdca21ef8f79f8
> commit: c81394419b54c2df2644a34892a6d6434fd922b3 [6/8] sched/numa: Apply imbalance limitations consistently
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190911.n5iX1ftB-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c81394419b54c2df2644a34892a6d6434fd922b3
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue sched/core
>         git checkout c81394419b54c2df2644a34892a6d6434fd922b3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 

Oops, the converged function just needs to move outside of
CONFIG_NUMA_BALANCING as it's not related to automatic NUMA balancing.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f619d9f70c8da..9b26afefc769b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1043,6 +1043,31 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long
+adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
+{
+	/*
+	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
+	 * threshold. Above this threshold, individual tasks may be contending
+	 * for both memory bandwidth and any shared HT resources.  This is an
+	 * approximation as the number of running tasks may not be related to
+	 * the number of busy CPUs due to sched_setaffinity.
+	 */
+	if (dst_running > imb_numa_nr)
+		return imbalance;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the destination is lightly loaded.
+	 */
+	if (imbalance <= NUMA_IMBALANCE_MIN)
+		return 0;
+
+	return imbalance;
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
@@ -1537,31 +1562,6 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 
-#define NUMA_IMBALANCE_MIN 2
-
-static inline long
-adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
-{
-	/*
-	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
-	 * threshold. Above this threshold, individual tasks may be contending
-	 * for both memory bandwidth and any shared HT resources.  This is an
-	 * approximation as the number of running tasks may not be related to
-	 * the number of busy CPUs due to sched_setaffinity.
-	 */
-	if (dst_running > imb_numa_nr)
-		return imbalance;
-
-	/*
-	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the destination is lightly loaded.
-	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
-		return 0;
-
-	return imbalance;
-}
-
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
 			 struct numa_stats *ns)
