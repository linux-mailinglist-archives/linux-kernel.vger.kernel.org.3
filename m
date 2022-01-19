Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FED493F64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356548AbiASRwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356520AbiASRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:52:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E10C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:52:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c66so6666170wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9+QuY0zH4n6DhdsHh/bGzBmsewJnPu1xsyY0wQOFNs=;
        b=Qwr4sXWlG63KPE36dssUlXfgc2ML4gn5DUWXdNefR/tdwjFsg7Y695LkndA6iRGRSt
         kTeZ+YBr95b8stCVFdmxVu0sQIkSPxHL5hVqZQiZmevmu74D5ALilFJ9gWC3jDvJZkHn
         bKdmr6EcNdM8IwETGj1/+v8U1zr2Vg+LJodTULKoDO7CzU5jTaXlF/gtnGWMITm+RWQA
         LnR0F810BIuRQPGwa9kw7AZzJwyju0XCYfqlG8fzIBB2Ml/04RkaM6LyvW1puu4OyK9f
         qRDzmmQwlVDvs38rwANgJ+GwjWXD6zOn0cIVQDXc3XkrDVbIKY5yEJIaUy2tiUsfxaGq
         Ec4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9+QuY0zH4n6DhdsHh/bGzBmsewJnPu1xsyY0wQOFNs=;
        b=R5xlpGRm9B2fxQTQJBio4Qa0qZUFaq/jBF9Dx4isDv+b7XmO3cQV250wcPiVd3QfSE
         G7Gk8jyM7jxQhGObTsO6MKhDO/4SnXGXvleqYmGhOIKoBtqRvDz5xbFTa3JzUw0xwe3q
         i/XDP4vmSjXq9fnVaTLz3n8g77Kgc2VK9CiI13CtahCuR7jKRAwetjsyFE83MOmemK3M
         pLz6kH5JQE7THfGaGz3vfTNLQZ74eV9SXYZ89ZxzexaX8TJqfTwrssEISPeQPLRoWx28
         wcwJ1cFv5Lwqdl3CF3SYKlPHwXzgogkpQp5/eSsx5NkYtxX2scVyX6uvBfiOayR1XUFA
         JvpQ==
X-Gm-Message-State: AOAM532ewOdhoA35AUOOQR9kYjsiF7xsOz7HBDsLm4xSPfysoD3BP8XZ
        vRrHvW67XwTWHX4ePTIEIYOlygPl+B41iFKrw8si3g==
X-Google-Smtp-Source: ABdhPJyTgn6+uRrI+ipD2jsY1qIhZf35U/++/qi7b/L4vt6/9XULtwfeWGPSU219Ql2kbuVOWQA/5YECcad0sB1B9PI=
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr25831925wrs.82.1642614761924;
 Wed, 19 Jan 2022 09:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv> <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net> <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
 <YefTCk4to5YzO8AB@hirez.programming.kicks-ass.net>
In-Reply-To: <YefTCk4to5YzO8AB@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 19 Jan 2022 09:52:30 -0800
Message-ID: <CAPNVh5dccb59Dj5Aeo3AybS+EiHix+-U7wgm8AakPqL3zdTQtQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 1:00 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 18, 2022 at 10:19:21AM -0800, Peter Oskolkov wrote:
>
> > =========== signals and the general approach
> >
> > My version of the patchset has all of these things working. What it
> > does not have,
> > compared to the new approach we are discussing here, is runqueues per server
> > and proper signal handling (and potential integration with proxy execution).
> >
> > Runqueues per server, in the LAZY mode, are easy to emulate in my patchset:
> > nothing prevents the userspace to partition workers among servers, and have
> > servers that "own" their workers to be pointed at by idle_server_tid_ptr.
> >
> > The only thing that is missing is proper treating of signals. But my patchset
> > does ensure a single running worker per server, had pagefaults and preemptions
> > sorted out, etc. Basically, everything works except signals. This patchet
> > has issues with pagefaults,
>
> Already fixed pagefaults per:
>
>   YeGvovSckivQnKX8@hirez.programming.kicks-ass.net

Could you, please, post an updated RFC when you have a chance? Thanks!

>
> > worker timeouts
>
> I still have no clear answer as to what you actually want there.
>
> > , worker-to-worker context
> > switches (do workers move runqueues when they context switch?), etc.
>
> Not in kernel, if they need to be migrated, userspace needs to do that.
>
> > And my patchset now actually looks smaller and simpler, on the kernel side,
> > that what this patchset is shaping up to be.
> >
> > What if I fix signals in my patchset? I think the way you deal with signals
> > will work in my approach equally well; I'll also use umcg_kick() to preempt
> > workers instead of sending them a signal.
> >
> > What do you think?
>
> I still absolutely hate how long you do page pinning, it *will* wreck
> things like CMA which are somewhat latency critical for silly things
> like Android camera apps and who knows what else.
>
> You've also forgotten about this:
>
>   YcWutpu7BDeG+dQ2@hirez.programming.kicks-ass.net
>
> That's not optional given how you're using page-pinning. Also, I think
> we need at least one direct access to the page after getting the pin in
> order to make it work.
>
> That also very much limits it to Anon pages.

I can use the same mm/page pinning strategy as you do. But then our
patchsets will be quite similar, I guess, with the difference being
server wakeups with RUNNING workers vs "lazy" idle_server_tid_ptr. So
OK, let's continue with your approach. If you could post a new RFC
with the memory/paging fixes in it, I'll then add worker timeouts, as
I outlined in a separate email ~ 30min ago, and continue with my
integration/testing.
