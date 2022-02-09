Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6514AFE12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiBIUPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:15:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBIUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:15:29 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E21E02F56E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:15:32 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f18so6318880lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENiQCyZgLi+Xzy2BZDhc0T4bCUDZ73wqPy+Y51XTFgY=;
        b=Kc6Vyrh1VRtumG7dfqq+ArcnJE1o4T7ZL17R78eWMTVl5JYinaTNaYoo2g4vOZfCCH
         hzMgXFEo5Zgjdq8lXMuzqal++CsCcOmioDbFNLkwKdWzw1uFD7LVaU00ZZEshemiJTw6
         R17L9VxahQ8hKu2uSjmw8AMvys4riDw6rMvV9u/ddsAXOGuosl+LWHPMrv+Zuaz3/W4g
         tzjNaelF/rQ+HrdVdkFXXcolzvlGqre99EZAWAPn+RRPFbxQ+pJUvFEmupOE62HCzCJM
         Q2hhAIuWBV0KVDslFVUzja0VSRHH37RKjXmv9jBqnWcwgiUM/FLm0L7j+hAYP4Lxo8ql
         JnlA==
X-Gm-Message-State: AOAM533yX1yNf7r1bLQpQ4mgZIYjiBJupHn9RelcVMA37UFy4DsMfxwS
        QcvuMDSiAxt0lVa4vomHE050rHTfen4YcZ4+1C4=
X-Google-Smtp-Source: ABdhPJwrP/ZMqK2e/v/nCesgsV4sXOzosLtK/wLTiajZH/ukAqKl3WEoJ9X+Km7/lWslc3oP8EyDpek3HPleG+abhX8=
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr2037103lfu.99.1644437730586;
 Wed, 09 Feb 2022 12:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220208184208.79303-12-namhyung@kernel.org>
 <20220209084041.GJ23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220209084041.GJ23216@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 12:15:19 -0800
Message-ID: <CAM9d7cgg9dUP0hqYfrDmXT7q2T9GiJt9uthKB7wEWNnKkMPisA@mail.gmail.com>
Subject: Re: [PATCH 11/12] locking/mutex: Revive fast functions for CONFIG_LOCK_TRACEPOINTS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Feb 9, 2022 at 12:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 08, 2022 at 10:42:07AM -0800, Namhyung Kim wrote:
> > I'm not entirely sure why it removed the fast versions when lockdep is
> > on.  It seems easy to add the required annotation when the fast
> > version is succeeded as far as the tracpoints are concerned.
>
> IIRC it was something like, lockdep depends on MUTEX_DEBUG and that in
> turn relied on not having the fast path enabled. MUTEX_DEBUG used to
> always take the wait_lock to ensure the debug state is consistent with
> the lock state.

I see.  Thanks for the explanation!

Namhyung
