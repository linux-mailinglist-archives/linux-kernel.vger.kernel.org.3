Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83EE56D6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiGKHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiGKHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:35:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D41BE8B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zxI5Ju1zn3Hrr6mLV73xoE3t9N0u61rDH0mqVeKgZCY=; b=ZF8aIfKr9b2YLBkkHLIxZkEniy
        suzNpZbhoOai42F1cMIVtEA8WxLfW9HP78e6XUwls3/sgevvyRY/591wcSwAUVuKMI+te/Rt4SFyE
        Bj6Zc9QLG5L9iicV5Qjos6lZ9IRCcv83fkBPZlZ2JgLrA8Rq+Oseg4AMEOpgVFwtSeM12+9lFeDe7
        OmxNNv0JQ2yWpwNaO5r0ApnYywRhNkkQrS6d+FsvF9BsO9GjgQPedCcRs0xFHKJVHHgaVrX5R8/pR
        z2aHgNzMxiJ4jy6QD/E46VNNman1B10mkLvgQPQaGy9g1EUh76R9kCQCs6r9bSmrqPEmdsK/AdaFJ
        wOtRTHNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAnwf-005lQL-OH; Mon, 11 Jul 2022 07:35:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81821300110;
        Mon, 11 Jul 2022 09:35:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C9832015BE8D; Mon, 11 Jul 2022 09:35:03 +0200 (CEST)
Date:   Mon, 11 Jul 2022 09:35:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] sched/fair: remove redundant cpu_cgrp_subsys->fork()
Message-ID: <YsvSpyrJxNv7jsQz@hirez.programming.kicks-ass.net>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
 <20220709151353.32883-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709151353.32883-4-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 11:13:48PM +0800, Chengming Zhou wrote:
> We use cpu_cgrp_subsys->fork() to set task group for the new fair task
> in cgroup_post_fork().
> 
> Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
> has already set task group for the new fair task in sched_cgroup_fork(),
> so cpu_cgrp_subsys->fork() can be removed.
> 
>   cgroup_can_fork()	--> pin parent's sched_task_group
>   sched_cgroup_fork()
>     __set_task_cpu	--> set task group
>   cgroup_post_fork()
>     ss->fork() := cpu_cgroup_fork()	--> set again
> 
> After this patch's change, task_change_group_fair() only need to
> care about task cgroup migration, make the code much simplier.

This:

> This patch also move the task se depth setting to set_task_rq(), which
> will set correct depth for the new task se in sched_cgroup_fork().
> 
> The se depth setting in attach_entity_cfs_rq() is removed since
> set_task_rq() is a better place to do this when task moves across
> CPUs/groups.

really should have been it's own patch. And this actually scares me. Did
you test with priority inheritance bumping the task to FIFO while things
change?

This has nothing to do with fork().
