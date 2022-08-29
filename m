Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01CE5A454A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiH2IjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiH2IjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:39:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9D58536;
        Mon, 29 Aug 2022 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=enW5V6g2WX8qHIsfLn2eVhcqKoAKV5YXSn+3ybsOepY=; b=VnpBQLFtOs+d1Mk1xzNicv6GHH
        1XXYkxcTGTMvu4i/PhfHDfa4gYaMWhytusRDeWmzGqwH510EOxaBr9SH448WYvQeRHaFYUSKtNJjy
        k82tW1bgPcjCvPNQhrVMwsm6qzYkRJnJuuZ7JgFtkrrZbLzIcC0WC9okARak/SdAL6EBp0JxqWdZd
        FyaEeAUG5zUTjLP1/+OrqfBF3TYy1hI109Xw3Fs0y6tFejWbLo/tSBVPLyS+9Okz/sMFHDJlEas3g
        XjEhoohLZjsY0lWJnze9mBVJ3ZVpoBzdY8gz45bY79ukjf/c9sT17BGlINSzwu8OOt6c+7aSYeKFv
        bc3iYkKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSaI2-007RqX-4b; Mon, 29 Aug 2022 08:38:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 529D3300137;
        Mon, 29 Aug 2022 10:38:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F059202547D2; Mon, 29 Aug 2022 10:38:35 +0200 (CEST)
Date:   Mon, 29 Aug 2022 10:38:34 +0200
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
Message-ID: <Ywx7CmbG+f+wg04z@hirez.programming.kicks-ass.net>
References: <20220704150514.48816-1-elver@google.com>
 <20220704150514.48816-12-elver@google.com>
 <YvznKYgRKjDRSMkT@worktop.programming.kicks-ass.net>
 <CANpmjNN1vv9oDpm1_c99tQKgWVVtXza++u1xcBVeb5mhx5eUHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN1vv9oDpm1_c99tQKgWVVtXza++u1xcBVeb5mhx5eUHw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:14:54PM +0200, Marco Elver wrote:
> On Wed, 17 Aug 2022 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 04, 2022 at 05:05:11PM +0200, Marco Elver wrote:
> > > +static bool bp_constraints_is_locked(struct perf_event *bp)
> > > +{
> > > +     struct mutex *tsk_mtx = get_task_bps_mutex(bp);
> > > +
> > > +     return percpu_is_write_locked(&bp_cpuinfo_sem) ||
> > > +            (tsk_mtx ? mutex_is_locked(tsk_mtx) :
> > > +                       percpu_is_read_locked(&bp_cpuinfo_sem));
> > > +}
> >
> > > @@ -426,18 +521,28 @@ static int modify_bp_slot(struct perf_event *bp, u64 old_type, u64 new_type)
> > >   */
> > >  int dbg_reserve_bp_slot(struct perf_event *bp)
> > >  {
> > > -     if (mutex_is_locked(&nr_bp_mutex))
> > > +     int ret;
> > > +
> > > +     if (bp_constraints_is_locked(bp))
> > >               return -1;
> > >
> > > -     return __reserve_bp_slot(bp, bp->attr.bp_type);
> > > +     /* Locks aren't held; disable lockdep assert checking. */
> > > +     lockdep_off();
> > > +     ret = __reserve_bp_slot(bp, bp->attr.bp_type);
> > > +     lockdep_on();
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  int dbg_release_bp_slot(struct perf_event *bp)
> > >  {
> > > -     if (mutex_is_locked(&nr_bp_mutex))
> > > +     if (bp_constraints_is_locked(bp))
> > >               return -1;
> > >
> > > +     /* Locks aren't held; disable lockdep assert checking. */
> > > +     lockdep_off();
> > >       __release_bp_slot(bp, bp->attr.bp_type);
> > > +     lockdep_on();
> > >
> > >       return 0;
> > >  }
> >
> > Urggghhhh... this is horrible crap. That is, the current code is that
> > and this makes it worse :/
> 
> Heh, yes and when I looked at it I really wanted to see if it can
> change. But from what I can tell, when the kernel debugger is being
> attached, the kernel does stop everything it does and we need the
> horrible thing above to not deadlock. And these dbg_ functions are not
> normally used, so I decided to leave it as-is. Suggestions?

What context is this ran in? NMI should already have lockdep disabled.
