Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92BA5317FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiEWShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiEWShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB5C132A1B;
        Mon, 23 May 2022 11:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4CFB81200;
        Mon, 23 May 2022 18:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A0C3411F;
        Mon, 23 May 2022 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653329741;
        bh=ogr4VAdQS3A7DDk0vo1e70sbPah4iSytiHNoT4xX2UI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QzOh9WbYbDO5tPJqGabgX1gZbWAPOnCpvIze6LeXOPoIqyxihEG3x67zLTOAxWtSd
         Gm01Gohdz0WEtjQkcrafyhSBwKODgM96cXE8HJ+KMgIuLLdJbadj9oabuO0AG22mA8
         jvDFOT9eJmgPlm1Db7ktaM9V2rxr7PHzgy1Ae0k2Il6W6rmp4oMvNcihWsFOpboCjn
         hagn7SEeNTwTiDVG6gPCXYe9DjaN9BlZm6LOd+gpq7qPBJe7CDgzECF8wcx7XOPxeP
         lX2GZNxpVwzKKT16ODDgFFGcEebCOJJPOSJ+Iz3FwoP85fS+CWCgfTdpj9Ymko2Lqr
         +7xz1BGdIVSGQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f83983782fso157464317b3.6;
        Mon, 23 May 2022 11:15:41 -0700 (PDT)
X-Gm-Message-State: AOAM5332aiS1jd/9uk+HERSHwQz0K+IBCjvdK88Z+u58k4aPE/aRaUUJ
        vGKTtngk2/Rm5fmk2TJFOX8vXK3vJ52SBTyfm7k=
X-Google-Smtp-Source: ABdhPJzAj+sfXKzSztm97CqjlzJ5TNkbJvqrGOriDDp+JyvNhuswblXzKSfgKAH9vzrs2C0MOEO+4oyWdDVifw2v7eo=
X-Received: by 2002:a81:5a87:0:b0:2ec:239:d1e with SMTP id o129-20020a815a87000000b002ec02390d1emr24470794ywb.211.1653329740302;
 Mon, 23 May 2022 11:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220519191311.17119-1-logang@deltatee.com> <20220519191311.17119-13-logang@deltatee.com>
 <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de> <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
In-Reply-To: <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 23 May 2022 11:15:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5DUT6gg4eP7ozAwWdEiqen1eZwWeYAM5Jo7yY0h+LGcQ@mail.gmail.com>
Message-ID: <CAPhsuW5DUT6gg4eP7ozAwWdEiqen1eZwWeYAM5Jo7yY0h+LGcQ@mail.gmail.com>
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

On Sun, May 22, 2022 at 11:47 PM Song Liu <song@kernel.org> wrote:
>
> On Sun, May 22, 2022 at 12:32 AM Donald Buczek <buczek@molgen.mpg.de> wro=
te:
> >
> > On 19.05.22 21:13, Logan Gunthorpe wrote:
> > > The mdadm test 21raid5cache randomly fails with NULL pointer accesses
> > > conf->log when run repeatedly. conf->log was sort of protected with
> > > a RCU, but most dereferences were not done with the correct functions=
.
> > >
> > > Add rcu_read_locks() and rcu_access_pointers() to the appropriate
> > > places.
> > >
> > > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> [...]
>
> > > diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
> > > index f26e6f4c7f9a..24b4dbd5b25c 100644
> > > --- a/drivers/md/raid5-log.h
> > > +++ b/drivers/md/raid5-log.h
> > > @@ -58,7 +58,7 @@ static inline int log_stripe(struct stripe_head *sh=
, struct stripe_head_state *s
> > >   {
> > >       struct r5conf *conf =3D sh->raid_conf;
> > >
> > > -     if (conf->log) {
> > > +     if (rcu_access_pointer(conf->log)) {
> >
> >
> > A problem here is that `struct r5l_log` of `conf->log` is private to ra=
id5-cache.c and gcc below version 10 (wrongly) regards the `typeof(*p) *loc=
al` declaration of __rcu_access_pointer as a dereference:
> >
> >    CC      drivers/md/raid5.o
> >
> > In file included from ./include/linux/rculist.h:11:0,
> >
> >                   from ./include/linux/dcache.h:8,
> >
> >                   from ./include/linux/fs.h:8,
> >
> >                   from ./include/linux/highmem.h:5,
> >
> >                   from ./include/linux/bvec.h:10,
> >
> >                   from ./include/linux/blk_types.h:10,
> >
> >                   from ./include/linux/blkdev.h:9,
> >
> >                   from drivers/md/raid5.c:38:
> >
> > drivers/md/raid5-log.h: In function =E2=80=98log_stripe=E2=80=99:
> >
> > ./include/linux/rcupdate.h:384:9: error: dereferencing pointer to incom=
plete type =E2=80=98struct r5l_log=E2=80=99
> >
> >    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >
> >           ^
> >
> > ./include/linux/rcupdate.h:495:31: note: in expansion of macro =E2=80=
=98__rcu_access_pointer=E2=80=99
> >
> >   #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(r=
cu), __rcu)
> >
> >                                 ^~~~~~~~~~~~~~~~~~~~
> >
> > drivers/md/raid5-log.h:61:6: note: in expansion of macro =E2=80=98rcu_a=
ccess_pointer=E2=80=99
> >
> >    if (rcu_access_pointer(conf->log)) {
> >
> >        ^~~~~~~~~~~~~~~~~~
> >
> > make[2]: *** [scripts/Makefile.build:288: drivers/md/raid5.o] Error 1
> >
> > make[1]: *** [scripts/Makefile.build:550: drivers/md] Error 2
> >
> > make: *** [Makefile:1834: drivers] Error 2
>
> This is annoying.. And there are a few other cases in raid5-log.h and
> raid5.c.
>
> Maybe we should move the definition of r5l_log to raid5-log.h?

Or we can use READ_ONCE(conf->log) for most cases.

Thought?
Song
