Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDBB5801A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiGYPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiGYPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:21:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306563F6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:19:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gn24so10772286pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gz5IYbu/V8gTHV8wRajJ2q5s1eqEvmhjScF5/lbrkRQ=;
        b=aa78HgKSRXFDKYsvuVY50gHiac5PdbSuZKR2TwuCtJAB1ut+1p8x+tSGykM/vDtxo5
         hrbU/JjrD3QHSDp7PP5yKQnIObk9iicsm2skKNmWh3U+olOTeFXJlW2crCXss2w4Nq6l
         D96/KtTQ94vdYJt4wUYpf8h6xzJIxkpQsYHdyFPR8wjmNR1aMtllTXdNNUyWtFjuQIU7
         25sFjd6/wUi1ZTO8RRSC6Lt8SKNk68yT+is31sQJO/kHTuAaT29TaE3cqVpq9wqIdiwx
         T4Sa+uO5qJ903HzfV34AERmtU0ZA9sDSx4zLdCLE4zOLNmzcz5YRD/CGRQ2+ewP5JqTy
         9Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gz5IYbu/V8gTHV8wRajJ2q5s1eqEvmhjScF5/lbrkRQ=;
        b=a8oMTUD73ccwamD6Tdae7wgANs25yTmRHTgO07U4me2btV8oYgttauInHlhjy3Lgk5
         3Hdk57kdhsh4XCz8qzWCuLAozEXbeSWxmy588B5Ij4xSUvBsJ16J2XAx2bC3zNPf3s0D
         v3JSJm2c7bj6HS+kKlJxDNl/PrWGAv79LpX+LA6ZSleCvWKoJ9rzc2o0/fYHXVRcn7TE
         AcLw7bELbbSgI+FNiC+58nokeFdLBBVxmPGhE9l8dYIarSy3OT0gvi+CLN+h7Be3Jjxq
         BBdRF7G669PZvBTy5tYGKpaGgMPLzxCxCJORuWaulGm+6vZruzIJRJVYMLYtmE8Fi1AW
         9LRw==
X-Gm-Message-State: AJIora9T7OLFBjvSc9oi2t0GABUEH0eAbvPujwvCCGsdyZ5nWcxQGehf
        3fJgqXV/IpBRUN4X2sxhU0sjr4uPa1i5cxRl4X/Jt/xmu2E=
X-Google-Smtp-Source: AGRyM1tMGhV56DImWcW1DE8jfDOQwY7KRGMHwIU59Qmc1aeUlD1OtKxVQVdOdjkpfgcf90uVBstg9e9emFGQxySsaUU=
X-Received: by 2002:a17:902:d501:b0:16d:8fc5:36dc with SMTP id
 b1-20020a170902d50100b0016d8fc536dcmr1274412plg.160.1658762349899; Mon, 25
 Jul 2022 08:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <xhsmhedy9fsg5.mognet@vschneid.remote.csb> <20220725104356.GA2950296@lothringen>
 <xhsmh5yjlfd97.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh5yjlfd97.mognet@vschneid.remote.csb>
From:   Arjan van de Ven <arjanvandeven@gmail.com>
Date:   Mon, 25 Jul 2022 08:18:57 -0700
Message-ID: <CADyApD2dBHYW7xx9K-4Pjek+1g+9mUD9Q2KYd1fzE741VKgV7A@mail.gmail.com>
Subject: Re: [Question] timers: trigger_dyntick_cpu() vs TIMER_DEFERRABLE
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>,
        George Spelvin <linux@sciencehorizons.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Len Brown <lenb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, that makes sense, thank you for highlighting the difference. The
> comment *does* say "come out of *idle*", not *tickless*...
>
> > Now that's the theory. In practice the deferrable timers are ignored by
> > both nohz-idle and nohz-full when it comes to compute the next nohz delta.
> > This is a mistake that is there since the introduction of nohz-full but I've
> > always been scared to break some user setup while fixing it. Anyway things
> > should look like this (untested):
> >
>
> IIUC that's making get_next_timer_interrupt() poke the deferrable base if the
> CPU isn't tickless idle (IOW if it is tickless "busy" or ticking
> idle). That makes sense from what you've written above, but I get your
> apprehension (though AIUI "only" pinned deferrable timers should be
> problematic, as the others should be migrated away).
>
>


taking a small step back; the idea behind deferrable timers is
(mostly) that these are timers that do ongoing "maintenance" of sorts,
be it counter updates or cleanup or whatever...
and that if the CPU is idle, no things happen that would require such
maintenance... so it's not worth waking the CPU out of idle for it...
and the nature of the timer is such
that delays are benign; sure the counters get sync'd maybe a bit later
but it does not impact correctness.

But once "real code" is executing (we can debate if an occasional
network interrupt counts as such but that's a detail) work is done
that would cause the maintenance to be meaningful again,
and then we do fire these timers "as usual", but ideally grouped with
other timers. So frankly that doesn't mean "right the exact
millisecond", after all the nature of deferrable already means that
exact timing is not implied, but within reason if something else
happens anyway/
