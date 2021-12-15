Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1A475E05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbhLOQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245030AbhLOQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:58:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FFCC061574;
        Wed, 15 Dec 2021 08:58:20 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:58:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639587499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=smPYIKqk9vx2R7JuwsR7LjOUB8YAI/q4v9h2y/DZ+dQ=;
        b=3mRh9oyt9t7yDLEtym1pw7rOMTUyQdvSL83LB5JYK57d7GbR8FqFQzSHOxk9qRudoHfGlu
        L95YyORbvPCipx2Ue6ABoEnBCD6JIXpTZIg0LxEO23D80hK1XtRCCokBOGSEvgsCF38drw
        F3WTRl6q1R4jMk34nduhMDVB6dJTmTe8MlH50hd4NbmOsTAeZToIxINaPAnzYgvRhg+7Z6
        xYcRWSPxEulXMzITzqI6c9El1E26RhsK60Kk12zYEuvBxUwGo0rR9DNRHH/V81rqZKhd++
        9SbEPxwt03YNvFHwDzgDKrPYuC3X2zXlGo8fHoBk5BjEPJ2sft5lRa0zTygZ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639587499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=smPYIKqk9vx2R7JuwsR7LjOUB8YAI/q4v9h2y/DZ+dQ=;
        b=sf2fDIOTgb7o8/mjIa9L6up+IUuqMcYg5iAbRguYptRF93aMbrEcCXPRzZTE6luPaafvwr
        ufHLPjlcQEWHGNAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: Avoid sleeping function called from
 invalid context bug
Message-ID: <YboeqlSsoFRbjEv2@linutronix.de>
References: <20211213123737.9147-1-wander@redhat.com>
 <20211213123737.9147-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213123737.9147-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-13 09:37:36 [-0300], Wander Lairson Costa wrote:
> ---
>  block/blk-cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 663aabfeba18..0a532bb3003c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1911,7 +1911,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	struct blkg_iostat_set *bis;
>  	unsigned long flags;
>  
> -	cpu = get_cpu();
> +	cpu = get_cpu_light();
>  	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
>  	flags = u64_stats_update_begin_irqsave(&bis->sync);
>  
> @@ -1928,7 +1928,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
>  	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
>  		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> -	put_cpu();
> +	put_cpu_light();
>  }

Are you sure patch and backtrace match? There is also
u64_stats_update_begin_irqsave() which disables preemption on RT. So by
doing what you are suggesting, you only avoid disabling preemption in
cgroup_rstat_updated() which acquires a raw_spinlock_t.

Sebastian
