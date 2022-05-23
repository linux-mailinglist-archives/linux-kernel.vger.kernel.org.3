Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC07530A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiEWH3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiEWH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:28:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC4E12D1F;
        Mon, 23 May 2022 00:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E362B80EF2;
        Mon, 23 May 2022 06:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CADC3411C;
        Mon, 23 May 2022 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653288473;
        bh=jhjfFqnEMxEjSu1Cq7Zj95I16yZf6Dx6j3YB8xQ8+Co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0ADDADR1Z+32PmnBb6Mk1tV+32z0qNZm0wWqcHU83WTjjEN6ab/skKaos4zNHsay
         M4c7xv5tIjBjw1QkiLo3Y1qUy19R3mTV+Hy30Qp45444KFpD51xd4tK//U7B9a0TLx
         goJBkFzDLY+efp1mcqie14abZ9Zn68FqHMb7nTCVlN3icqDMWUrkOoSgs8w2o0avJW
         oJmravJ7p9WjQarMHyg7NFmodbxPAmBA3816sIbtJg9MJi9MvLegr/jx4O9C5Jp8td
         3syeL7v8/wUCGrqUXDPDBcJ5GBcgKOA7/M5cJn0Q6ijSJrTQkbwZAQNmWEU6hVI2Rk
         k4whVShMcWJgQ==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2fee9fe48c2so137286847b3.3;
        Sun, 22 May 2022 23:47:53 -0700 (PDT)
X-Gm-Message-State: AOAM532TTUgq1ZXk7SwmC3wTgyGrSwC0KzMUYvkNcdCdA29Mj74D9sFx
        xDiaYXy2l83qE6O6vjTkxRhyb6ao/N/xE7HE4AE=
X-Google-Smtp-Source: ABdhPJx+Z9UCe1Is3tLZ85Z0H/Ij71nJfozYcpsX1D1AT9IGbP4aNw9zRZgn1CeknwllG+Y5YglbFDynD2+gfbQYwDU=
X-Received: by 2002:a0d:f007:0:b0:2f4:ce96:514b with SMTP id
 z7-20020a0df007000000b002f4ce96514bmr21967836ywe.148.1653288472058; Sun, 22
 May 2022 23:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220519191311.17119-1-logang@deltatee.com> <20220519191311.17119-13-logang@deltatee.com>
 <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de>
In-Reply-To: <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de>
From:   Song Liu <song@kernel.org>
Date:   Sun, 22 May 2022 23:47:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
Message-ID: <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log accesses
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 12:32 AM Donald Buczek <buczek@molgen.mpg.de> wrote=
:
>
> On 19.05.22 21:13, Logan Gunthorpe wrote:
> > The mdadm test 21raid5cache randomly fails with NULL pointer accesses
> > conf->log when run repeatedly. conf->log was sort of protected with
> > a RCU, but most dereferences were not done with the correct functions.
> >
> > Add rcu_read_locks() and rcu_access_pointers() to the appropriate
> > places.
> >
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

[...]

> > diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
> > index f26e6f4c7f9a..24b4dbd5b25c 100644
> > --- a/drivers/md/raid5-log.h
> > +++ b/drivers/md/raid5-log.h
> > @@ -58,7 +58,7 @@ static inline int log_stripe(struct stripe_head *sh, =
struct stripe_head_state *s
> >   {
> >       struct r5conf *conf =3D sh->raid_conf;
> >
> > -     if (conf->log) {
> > +     if (rcu_access_pointer(conf->log)) {
>
>
> A problem here is that `struct r5l_log` of `conf->log` is private to raid=
5-cache.c and gcc below version 10 (wrongly) regards the `typeof(*p) *local=
` declaration of __rcu_access_pointer as a dereference:
>
>    CC      drivers/md/raid5.o
>
> In file included from ./include/linux/rculist.h:11:0,
>
>                   from ./include/linux/dcache.h:8,
>
>                   from ./include/linux/fs.h:8,
>
>                   from ./include/linux/highmem.h:5,
>
>                   from ./include/linux/bvec.h:10,
>
>                   from ./include/linux/blk_types.h:10,
>
>                   from ./include/linux/blkdev.h:9,
>
>                   from drivers/md/raid5.c:38:
>
> drivers/md/raid5-log.h: In function =E2=80=98log_stripe=E2=80=99:
>
> ./include/linux/rcupdate.h:384:9: error: dereferencing pointer to incompl=
ete type =E2=80=98struct r5l_log=E2=80=99
>
>    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
>
>           ^
>
> ./include/linux/rcupdate.h:495:31: note: in expansion of macro =E2=80=98_=
_rcu_access_pointer=E2=80=99
>
>   #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu=
), __rcu)
>
>                                 ^~~~~~~~~~~~~~~~~~~~
>
> drivers/md/raid5-log.h:61:6: note: in expansion of macro =E2=80=98rcu_acc=
ess_pointer=E2=80=99
>
>    if (rcu_access_pointer(conf->log)) {
>
>        ^~~~~~~~~~~~~~~~~~
>
> make[2]: *** [scripts/Makefile.build:288: drivers/md/raid5.o] Error 1
>
> make[1]: *** [scripts/Makefile.build:550: drivers/md] Error 2
>
> make: *** [Makefile:1834: drivers] Error 2

This is annoying.. And there are a few other cases in raid5-log.h and
raid5.c.

Maybe we should move the definition of r5l_log to raid5-log.h?

Thanks,
Song


>
>
> See https://godbolt.org/z/TPP8MdKbc to test compiler versions with this c=
onstruct.
>
> Best
>
>    Donald
>
>
> >               if (!test_bit(STRIPE_R5C_CACHING, &sh->state)) {
> >                       /* writing out phase */
> >                       if (s->waiting_extra_page)
> > @@ -79,7 +79,7 @@ static inline void log_stripe_write_finished(struct s=
tripe_head *sh)
> >   {
> >       struct r5conf *conf =3D sh->raid_conf;
> >
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               r5l_stripe_write_finished(sh);
> >       else if (raid5_has_ppl(conf))
> >               ppl_stripe_write_finished(sh);
> > @@ -87,7 +87,7 @@ static inline void log_stripe_write_finished(struct s=
tripe_head *sh)
> >
> >   static inline void log_write_stripe_run(struct r5conf *conf)
> >   {
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               r5l_write_stripe_run(conf);
> >       else if (raid5_has_ppl(conf))
> >               ppl_write_stripe_run(conf);
> > @@ -95,7 +95,7 @@ static inline void log_write_stripe_run(struct r5conf=
 *conf)
> >
> >   static inline void log_flush_stripe_to_raid(struct r5conf *conf)
> >   {
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               r5l_flush_stripe_to_raid(conf);
> >       else if (raid5_has_ppl(conf))
> >               ppl_write_stripe_run(conf);
> > @@ -105,7 +105,7 @@ static inline int log_handle_flush_request(struct r=
5conf *conf, struct bio *bio)
> >   {
> >       int ret =3D -ENODEV;
> >
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               ret =3D r5l_handle_flush_request(conf, bio);
> >       else if (raid5_has_ppl(conf))
> >               ret =3D ppl_handle_flush_request(bio);
> > @@ -115,7 +115,7 @@ static inline int log_handle_flush_request(struct r=
5conf *conf, struct bio *bio)
> >
> >   static inline void log_quiesce(struct r5conf *conf, int quiesce)
> >   {
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               r5l_quiesce(conf, quiesce);
> >       else if (raid5_has_ppl(conf))
> >               ppl_quiesce(conf, quiesce);
> > @@ -123,7 +123,7 @@ static inline void log_quiesce(struct r5conf *conf,=
 int quiesce)
> >
> >   static inline void log_exit(struct r5conf *conf)
> >   {
> > -     if (conf->log)
> > +     if (rcu_access_pointer(conf->log))
> >               r5l_exit_log(conf);
> >       else if (raid5_has_ppl(conf))
> >               ppl_exit_log(conf);
> > diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c

[...]
