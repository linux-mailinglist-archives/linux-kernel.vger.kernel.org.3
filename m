Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A69596F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiHQNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiHQND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:03:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050C32049;
        Wed, 17 Aug 2022 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8tSVbs/LntHCfdjrxtk7ceXw6TPtMo4nIYUkIIRtVa4=; b=TUYGDjo5Eb2C+vokB8lSzbnHTV
        FxOXCuCCTso8IKA26Dds1MHiVap25aWsBqDfMrSAfdetz5F38Njwrq7LSinw80hTP1RQ8VwP8qy0v
        7nRsJ9iJd9DpyBqYujIGvKYSJahc/HW6bsUkkcTOydv1t4XrhRac50TnUR6TepqFHAZfx1WHAPaz2
        9T/QLjxx2nykjKy9HbBQ8OibboBOKmwBLlH4IsSqotH1UU7wt5BZ0CstHJkqDCeYkuT+Ac1jQq+vt
        MlxLdvXedqGnarZIbn+D2o5PGLGOEVupFFTe7erGNcfxZ4C6okDm8ETszLbb9v3vt4+VyxJftLprh
        59bIzbvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOIht-003I0R-UD; Wed, 17 Aug 2022 13:03:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84568980256; Wed, 17 Aug 2022 15:03:37 +0200 (CEST)
Date:   Wed, 17 Aug 2022 15:03:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/14] perf/hw_breakpoint: Reduce contention with
 large number of tasks
Message-ID: <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
References: <20220704150514.48816-1-elver@google.com>
 <20220704150514.48816-12-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704150514.48816-12-elver@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:05:11PM +0200, Marco Elver wrote:
> +static bool bp_constraints_is_locked(struct perf_event *bp)
> +{
> +	struct mutex *tsk_mtx = get_task_bps_mutex(bp);
> +
> +	return percpu_is_write_locked(&bp_cpuinfo_sem) ||
> +	       (tsk_mtx ? mutex_is_locked(tsk_mtx) :
> +			  percpu_is_read_locked(&bp_cpuinfo_sem));
> +}

> @@ -426,18 +521,28 @@ static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
>   */
>  int dbg_reserve_bp_slot(struct perf_event *bp)
>  {
> -	if (mutex_is_locked(&nr_bp_mutex))
> +	int ret;
> +
> +	if (bp_constraints_is_locked(bp))
>  		return -1;
>  
> -	return __reserve_bp_slot(bp, bp->attr.bp_type);
> +	/* Locks aren't held; disable lockdep assert checking. */
> +	lockdep_off();
> +	ret = __reserve_bp_slot(bp, bp->attr.bp_type);
> +	lockdep_on();
> +
> +	return ret;
>  }
>  
>  int dbg_release_bp_slot(struct perf_event *bp)
>  {
> -	if (mutex_is_locked(&nr_bp_mutex))
> +	if (bp_constraints_is_locked(bp))
>  		return -1;
>  
> +	/* Locks aren't held; disable lockdep assert checking. */
> +	lockdep_off();
>  	__release_bp_slot(bp, bp->attr.bp_type);
> +	lockdep_on();
>  
>  	return 0;
>  }

Urggghhhh... this is horrible crap. That is, the current code is that
and this makes it worse :/

