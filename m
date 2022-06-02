Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2D53BF49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiFBUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiFBUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:06:49 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BA236;
        Thu,  2 Jun 2022 13:06:46 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id y144so2773781oia.7;
        Thu, 02 Jun 2022 13:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJx8EzZFfK8sPhpdoIX1JZPKfbXDh5xv5Av3MuXsAYI=;
        b=glBURCeIaI9wyQ9Lt0jShRRY8CpxrvuG3aAtd4KiFZions1LD0zHzhC6SlWLVJU1O9
         sSVknPkbp9D3genIFH8l8fg7w0srrIV+YOh03M3TiyijsSLA8lp5+L7l/LdFFvMJbxW4
         lxeqwRhRuWVE1eZDEqfOqrUGu+ElaSDcV5vlBJVxg7Q5ue3rggMPiAdZKDZ9lJQwqznk
         QsS3y7Y/JWl6GU7iHfmuckDIIMsjOdimKG7YYaAhgcTwiPayWpWYeptxWnaTMRDFu4T7
         pMKd0D5EJLhY8RkjX4kiFQKybroH03Mxs9j19b9YEbsOUQbYH7J982bcUpdaxE75Fr9u
         8ukA==
X-Gm-Message-State: AOAM531nhdWnMvGotuUCa2cHzZBfQ7S38b6jSB/5sEKNnEULs5+NIlhC
        16AwjTMFMkJCfuP8LMJGp2spNrzx+fRnRyq6Cyk=
X-Google-Smtp-Source: ABdhPJxjPC7wm9cBiImBF5sK+Q/d4b72Jf+ZiDnArJjtCpDt5SG1lNVnykldTXmmR91r2AudAqs9F24/vVEdIfOoT34=
X-Received: by 2002:a05:6808:1a01:b0:32b:1f24:9213 with SMTP id
 bk1-20020a0568081a0100b0032b1f249213mr3469092oib.92.1654200406066; Thu, 02
 Jun 2022 13:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-3-namhyung@kernel.org>
 <CAP-5=fWvS=1XrXnE_a+sif8ZKy2oc6pmo6RmZ6+fFrWoa1VM3A@mail.gmail.com>
In-Reply-To: <CAP-5=fWvS=1XrXnE_a+sif8ZKy2oc6pmo6RmZ6+fFrWoa1VM3A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Jun 2022 13:06:34 -0700
Message-ID: <CAM9d7chthpaF9A_uZCm3uRzLe7Ho4-kuJ6J4D1evJPdMgSV9Ng@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf lock: Add lock contention tracepoints record support
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
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

Hi Ian,

On Wed, Jun 1, 2022 at 11:21 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When LOCKDEP and LOCK_STAT events are not available, it falls back to
> > record the new lock contention tracepoints.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-lock.c | 70 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 23a33ac15e68..3e3320b8cede 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -495,6 +495,12 @@ struct trace_lock_handler {
> >
> >         int (*release_event)(struct evsel *evsel,
> >                              struct perf_sample *sample);
> > +
> > +       int (*contention_begin_event)(struct evsel *evsel,
> > +                                     struct perf_sample *sample);
> > +
> > +       int (*contention_end_event)(struct evsel *evsel,
> > +                                   struct perf_sample *sample);
>
> Would it make sense to add a comment here about LOCKDEP and LOCK_STAT?
> It could be confusing if the handler isn't called on different
> kernels.

Sure, I'll add some comments here.

Thanks,
Namhyung
