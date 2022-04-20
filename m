Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D85508FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381571AbiDTSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381564AbiDTSrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:47:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19C12AB3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:45:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so3980834pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5MPjhgHen7BuKxTDiZuP1jfbg11vB+Z7i5fz+eWvs4=;
        b=OwWBzNLEwTRij9iKP4J+DiTJJNKXZ5gjHzi5SIOfmc/lMuIsmfTp19Bh+2mVDiDMTL
         8wfyQKWKF57fPJcgyhQEuQGqF0JDygHQBlsuLIQ2NxriiTf+5w6eOWhfGOMhkONX7T7L
         tchZvLWXC4wL44JN+W/4p2JnRnhW8xoCPm93k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5MPjhgHen7BuKxTDiZuP1jfbg11vB+Z7i5fz+eWvs4=;
        b=0u8+GhXp9JsMvo4Ca+BI+EGYsZAVyP4l4iKGeqgGIZtcF0EEt+6530MFJtQAdh2Hh8
         2fzWGKdBGGzah3Ymhp7LPKLnnu0Y9HQ3QdOdq0hkloAbJkrgfD76J00ElCrWCCyKxRBd
         vtg6b3aoujBQsg+dFQx5F8AKxJBFjOySP4dZpRU29gMzOmHTXffh/GvTYEz0zkFIv7Q9
         OsC5fUd+9zXpQLDkE3AFQi+SZcDi9z9LlUUYPsawXKMEBKb0yeCfEJykQ0x+w8xp+cK1
         h8ZYcYkHNMVaPCs/DMFGprx3VjaadJQWm0b6A1AHIgyCrDvuMoloWENzmB1oEdJbpJo5
         GBzg==
X-Gm-Message-State: AOAM531EtDRWbzt9WFEqOE7YkDX7p1s0OMJN8AgHwtBTtmYhIaSsxuHa
        N905/guboDuENioCidb554DXeg==
X-Google-Smtp-Source: ABdhPJxz5ow63QVYcQ7ZVnYOAiFkIr3Qiu5ibe3P+MFZpYZdBE70/w5FUyDOhyclm/L3LfmrOk4vKA==
X-Received: by 2002:a17:90b:3cf:b0:1d0:cdd4:9d0a with SMTP id go15-20020a17090b03cf00b001d0cdd49d0amr5903012pjb.187.1650480306320;
        Wed, 20 Apr 2022 11:45:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm20045925pfm.158.2022.04.20.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:45:05 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:45:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        trivial@kernel.org, Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <202204201117.F44DCF9@keescook>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
 <20220417155205.GI2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417155205.GI2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 05:52:05PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 14, 2022 at 01:30:50PM -0700, Andrew Morton wrote:
> > On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > +/* The + 1 below places the pointers within the range of their array */
> > > >  #define for_class_range(class, _from, _to) \
> > > > -	for (class = (_from); class != (_to); class--)
> > > > +	for (class = (_from); class + 1 != (_to) + 1; class--)
> > > 
> > > Urgh, so now we get less readable code, just because GCC is being
> > > stupid?
> > > 
> > > What's wrong with negative array indexes? memory is memory, stuff works.
> > 
> > What's more, C is C.  Glorified assembly language in which people do odd
> > stuff.
> > 
> > But this is presumably a released gcc version and we need to do
> > something.  And presumably, we need to do a backportable something, so
> > people can compile older kernels with gcc-12.
> > 
> > Is it possible to suppress just this warning with a gcc option?  And if
> > so, are we confident that this warning will never be useful in other
> > places in the kernel?
> > 
> > If no||no then we'll need to add workarounds such as these?
> 
> -Wno-array-bounds

Please no; we just spent two years fixing all the old non-flexible array
definitions and so many other things fixed for this to be enable because
it finds actual flaws (but we turned it off when it was introduced
because of how much sloppy old code we had).

> Is the obvious fix-all cure. The thing is, I want to hear if this new
> warning has any actual use or is just crack induced madness like many of
> the warnings we turn off.

Yes, it finds real flaws. And also yes, it is rather opinionated about
some "tricks" that have worked in C, but frankly, most of those tricks
end up being weird/accidentally-correct and aren't great for long-term
readability or robustness. Though I'm not speaking specifically to this
proposed patch; I haven't looked closely at it yet.

I quickly went back through commits; here's a handful I found:

20314bacd2f9 ("staging: r8188eu: Fix PPPoE tag insertion on little endian systems")
dcf500065fab ("net: bnxt_ptp: fix compilation error")
5f7dc7d48c94 ("octeontx2-af: fix array bound error")
c7d58971dbea ("ALSA: mixart: Reduce size of mixart_timer_notify")
b3f1dd52c991 ("ARM: vexpress/spc: Avoid negative array index when !SMP")
a2151490cc6c ("drm/dp: Fix OOB read when handling Post Cursor2 register")
d4da1f27396f ("drm/dp: Fix off-by-one in register cache size")
47307c31d90a ("crypto: octeontx2 - Avoid stack variable overflow")
a6501e4b380f ("eeprom: at25: Restore missing allocation")
33ce7f2f95ca ("drm/imx: imx-ldb: fix out of bounds array access warning")
f051ae4f6c73 ("Input: cyapa_gen6 - fix out-of-bounds stack access")
f3217d6f2f7a ("firmware: xilinx: fix out-of-bounds access")
8a03447dd311 ("rtw88: fix subscript above array bounds compiler warning")
ad82a928eb58 ("s390/perf: fix gcc 8 array-bounds warning")
6038aa532a22 ("nvme: target: fix buffer overflow")
50a0d71a5d20 ("cros_ec: fix nul-termination for firmware build info")
43d15c201313 ("staging: rtl8822be: Keep array subscript no lower than zero")

The important part is that with this enabled now, we won't get _new_
problems introduced. Making the C code clear enough that the compiler
can understand the intent, though, can be a little annoying, but makes
things much easier to automatically check. Getting our code-base arranged
so the toolchain can actually do the analysis is well worth it.

-- 
Kees Cook
