Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D804C3225
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiBXQrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBXQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:47:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF243EB9F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:47:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4676E212B8;
        Thu, 24 Feb 2022 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645721235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1H0CadfhtyYyF6LVEd3emETLP+Vbb/T1mlZGHXxU+Y=;
        b=IeBZekcFMaF4ptlQ0qbFqdGsVWOLtH3pwa9EXgyNdAfTlXzH8ldLLF/3T2fFmzXt8MtMWR
        9uC+IrysVuU5a1YhoprN01PtUZP3hLcN3F6US18kinfRfbzVNhd9f3EG5j4SxIlTv8tF/R
        jUSaggGG8OdRfp099ZaEROxRYaNjxfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645721235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1H0CadfhtyYyF6LVEd3emETLP+Vbb/T1mlZGHXxU+Y=;
        b=pl+Qlnta+XDdyxNK2WpKXyorvxLr2GfUGEUsKmeEu3LZF6hPIpNSz3AedBhqPlvBgVyjU8
        xHLUHDyKhFyRltBQ==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A1F6A3B8A;
        Thu, 24 Feb 2022 16:47:13 +0000 (UTC)
Date:   Thu, 24 Feb 2022 16:47:11 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Message-ID: <20220224164711.GA4363@suse.de>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
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

On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
> Current load balancing is mainly based on cpu capacity
> and task util, which makes sense in the POV of overall
> throughput. While there still might be some improvement
> can be done by reducing number of overloaded cfs rqs if
> sched-idle or idle rq exists.
> 
> An CFS runqueue is considered overloaded when there are
> more than one pullable non-idle tasks on it (since sched-
> idle cpus are treated as idle cpus). And idle tasks are
> counted towards rq->cfs.idle_h_nr_running, that is either
> assigned SCHED_IDLE policy or placed under idle cgroups.
> 

It's not clear how your tests evaluated the balancing of SCHED_IDLE tasks
versus the existing idle balancing and isolated that impact. I suspect
the tests may primarily measured the effect of the SIS filter.

> So in short, the goal of the sched-idle balancing is to
> let the *non-idle tasks* make full use of cpu resources.
> To achieve that, we mainly do two things:
> 
>   - pull non-idle tasks for sched-idle or idle rqs
>     from the overloaded ones, and
> 
>   - prevent pulling the last non-idle task in an rq
> 
> The mask of overloaded cpus is updated in periodic tick
> and the idle path at the LLC domain basis. This cpumask
> will also be used in SIS as a filter, improving idle cpu
> searching.
> 

As the overloaded mask may be updated on each idle, it could be a
significant source of cache misses between CPUs sharing the domain for
workloads that rapidly idle so there should be data on whether cache misses
are increased heavily. It also potentially delays the CPU reaching idle
but it may not be by much.

The filter may be out of date. It takes up to one tick to detect
overloaded and the filter to have a positive impact. As a CPU is not
guaranteed to enter idle if there is at least one CPU-bound task, it may
also be up to 1 tick before the mask is cleared. I'm not sure this is a
serious problem though as SIS would not pick the CPU with the CPU-bound
task anyway.

At minimum, the filter should be split out and considered first as it
is the most likely reason why a performance difference was measured. It
has some oddities like why nr_overloaded is really a boolean and as
it's under rq lock, it's not clear why it's atomic. The changelog
would ideally contain some comment on the impact to cache misses
if any and some sort of proof that SIS search depth is reduced which
https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
may be some help.

At that point, compare the idle task balancing on top to isolate how
much it improves things if any and identify why existing balancing is
insufficient. Split out the can_migrate_task change beforehand in case it
is the main source of difference as opposed to the new balancing mechanism.

-- 
Mel Gorman
SUSE Labs
