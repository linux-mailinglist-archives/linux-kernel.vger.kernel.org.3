Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623C65AD5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiIEPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiIEPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7D7676
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B67F61325
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C0C433B5;
        Mon,  5 Sep 2022 15:13:50 +0000 (UTC)
Date:   Mon, 5 Sep 2022 11:14:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, zhaojunkui2008@126.com
Subject: Re: [PATCH] kernel/sched: fix KMSAN uninit-value error
Message-ID: <20220905111427.57d3262b@gandalf.local.home>
In-Reply-To: <20220905023715.1920088-1-bernard@vivo.com>
References: <20220905023715.1920088-1-bernard@vivo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Sep 2022 19:37:14 -0700
Bernard Zhao <bernard@vivo.com> wrote:

> syzbot link:
> https://syzkaller.appspot.com/bug?id=d04c5407207d11e46007775517b97764174bc45d
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  kernel/sched/psi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ecb4b4ff4ce0..46f048121520 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -195,6 +195,9 @@ static void group_init(struct psi_group *group)
>  	init_waitqueue_head(&group->poll_wait);
>  	timer_setup(&group->poll_timer, poll_timer_fn, 0);
>  	rcu_assign_pointer(group->poll_task, NULL);
> +	memset(group->avg_total, 0, sizeof(group->avg_total));
> +	memset(group->total, 0, sizeof(group->total));
> +	memset(group->avg, 0, sizeof(group->avg));
>  }

group_init() is only called in two places. One for a static variable which
will already have all the non-set fields initialized to zero. The other can
have kmalloc() converted to kzalloc() and not worry about zeroing any of
the fields in initialization.

-- Steve

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ec66b40bdd40..00d62681ea6a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -957,7 +957,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
+	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
 	if (!cgroup->psi)
 		return -ENOMEM;
 
