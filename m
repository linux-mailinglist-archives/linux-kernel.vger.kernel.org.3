Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBE5881AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiHBSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiHBSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:08:22 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4941260C;
        Tue,  2 Aug 2022 11:08:21 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-10ea30a098bso13213127fac.8;
        Tue, 02 Aug 2022 11:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=enCiIDwJr66RukPVLw8qRHRdobd4dCtAaNNZuJ7m8ZU=;
        b=oO91pIjv7SpHP73+NaxiH1cRoLU4oIXjchXZ7BQitug+KmcAae4p7o4c9k14YevGt6
         NSDAj8W4wr6YXANCw9BKYDjbNa2brhlvm/VG6OKkRCb0rEVi05MOExFJ2RY2/euzXSp9
         I8hyCBsTymXESbVbAzRgzM6ohN6OUygKWMolp26CcqkSfdGo7CPj0QOubzz5HV4aNyoD
         u+4thr10nm3hykMsA6M7FGjo3PbcDDsGK01BYLDTtHsRyhncay4ti2hDdXsO+goPRZg9
         LC7rOfnjsDckCFfedI/qEBBxWrci2DQ71hwJsrUaU64lbASfpnMyrLTGUeCd1tvxW51Z
         9SCA==
X-Gm-Message-State: ACgBeo3pz/k63ydnn4Kp1klhR0//kwlI81uNe25zzQeyJo3EGUx6Bha2
        Gq/mpifNIoXEXCvzNJX6n8GGZVgmX6OW34Ng/hs=
X-Google-Smtp-Source: AA6agR6IVTBQN1m2k+NH1e7KNrcm6vESCMT9T8oZe9foCAegooR21K5G6hCt0rsg3WHhyZkyTY+YbqYtoirQN/tZXb8=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr323327oab.92.1659463700366; Tue, 02 Aug
 2022 11:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220802073511.299459-1-namhyung@kernel.org> <20220802073511.299459-3-namhyung@kernel.org>
 <YulipRqJZ7oYVWD/@kernel.org>
In-Reply-To: <YulipRqJZ7oYVWD/@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Aug 2022 11:08:09 -0700
Message-ID: <CAM9d7chu8UFNGBk-1rEBY9+_Q+8dj_4CQ4VJ1BZzs+Dq3T=Shg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf lock: Print lost entries at the end
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 10:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 02, 2022 at 12:35:11AM -0700, Namhyung Kim escreveu:
> > Like the normal perf lock report output, it'd print bad stats at the end
> > if exists or -v option is passed.  Currently it uses BROKEN_CONTENDED
>  stat for the lost count (due to full stack maps).
>
> "Print the number of lost entries in verbose mode"?

Do you want me to change the commit description?

Note that it can print the numbers not in verbose mode.
It used to print unconditionally but I changed it to do
that only if there's a bad number.  The -v option can
help to keep the original behavior of printing it always.

Thanks,
Namhyung


>
> >   $ sudo perf lock con -a -b -m 128 sleep 5
> >   ...
> >   === output for debug===
> >
> >   bad: 43, total: 14903
> >   bad rate: 0.29 %
> >   histogram of events caused bad sequence
> >       acquire: 0
> >      acquired: 0
> >     contended: 43
> >       release: 0
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-lock.c                      | 8 +++++++-
> >  tools/perf/util/bpf_lock_contention.c          | 6 ++++--
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c | 9 +++++++--
> >  tools/perf/util/lock-contention.h              | 1 +
> >  4 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index e32fdcd497e0..8065f0268e55 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1471,8 +1471,11 @@ static void print_contention_result(void)
> >               pr_info("  %10s   %s\n\n", "type", "caller");
> >
> >       bad = total = 0;
> > +     if (use_bpf)
> > +             bad = bad_hist[BROKEN_CONTENDED];
> > +
> >       while ((st = pop_from_result())) {
> > -             total++;
> > +             total += use_bpf ? st->nr_contended : 1;
> >               if (st->broken)
> >                       bad++;
> >
> > @@ -1686,6 +1689,9 @@ static int __cmd_contention(int argc, const char **argv)
> >
> >               lock_contention_stop();
> >               lock_contention_read(&con);
> > +
> > +             /* abuse bad hist stats for lost entries */
> > +             bad_hist[BROKEN_CONTENDED] = con.lost;
> >       } else {
> >               err = perf_session__process_events(session);
> >               if (err)
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 26128e5bb659..65f51cc25236 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -16,7 +16,7 @@ static struct lock_contention_bpf *skel;
> >
> >  /* should be same as bpf_skel/lock_contention.bpf.c */
> >  struct lock_contention_key {
> > -     u32 stack_id;
> > +     s32 stack_id;
> >  };
> >
> >  struct lock_contention_data {
> > @@ -110,7 +110,7 @@ int lock_contention_stop(void)
> >  int lock_contention_read(struct lock_contention *con)
> >  {
> >       int fd, stack;
> > -     u32 prev_key, key;
> > +     s32 prev_key, key;
> >       struct lock_contention_data data;
> >       struct lock_stat *st;
> >       struct machine *machine = con->machine;
> > @@ -119,6 +119,8 @@ int lock_contention_read(struct lock_contention *con)
> >       fd = bpf_map__fd(skel->maps.lock_stat);
> >       stack = bpf_map__fd(skel->maps.stacks);
> >
> > +     con->lost = skel->bss->lost;
> > +
> >       prev_key = 0;
> >       while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
> >               struct map *kmap;
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 67d46533e518..9e8b94eb6320 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -12,7 +12,7 @@
> >  #define MAX_ENTRIES  10240
> >
> >  struct contention_key {
> > -     __u32 stack_id;
> > +     __s32 stack_id;
> >  };
> >
> >  struct contention_data {
> > @@ -27,7 +27,7 @@ struct tstamp_data {
> >       __u64 timestamp;
> >       __u64 lock;
> >       __u32 flags;
> > -     __u32 stack_id;
> > +     __s32 stack_id;
> >  };
> >
> >  /* callstack storage  */
> > @@ -73,6 +73,9 @@ int enabled;
> >  int has_cpu;
> >  int has_task;
> >
> > +/* error stat */
> > +unsigned long lost;
> > +
> >  static inline int can_record(void)
> >  {
> >       if (has_cpu) {
> > @@ -116,6 +119,8 @@ int contention_begin(u64 *ctx)
> >       pelem->flags = (__u32)ctx[1];
> >       pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP);
> >
> > +     if (pelem->stack_id < 0)
> > +             lost++;
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> > index b09fd6eb978a..d9fc5f076567 100644
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -113,6 +113,7 @@ struct lock_contention {
> >       struct machine *machine;
> >       struct hlist_head *result;
> >       unsigned long map_len;
> > +     unsigned long lost;
> >  };
> >
> >  #ifdef HAVE_BPF_SKEL
> > --
> > 2.37.1.455.g008518b4e5-goog
>
> --
>
> - Arnaldo
