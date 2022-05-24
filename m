Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6D53303F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiEXSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiEXSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3866205;
        Tue, 24 May 2022 11:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8ECB61598;
        Tue, 24 May 2022 18:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E3CC34118;
        Tue, 24 May 2022 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653416031;
        bh=NLwWw13wDQis8mxaX7ejWZaJmJcrDSXKwOkmB9wEu1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rSdk+7WTA0VS0NHfyaStjII8w6DD+bJpI1mm1xWuF/TuqANkvVdRTaTRwxaEoABQw
         LLBBKRltNlLK1F3gt0TYUM9uYFPZ4khArccswUMRvYufTcFblzPCi+burDW9L3fJhK
         siWcCWc0OcAbtDlG5Gt1tpZKDQvn5R5yz2jNb0btB7niWISuZngBtKEktbAS1sewM2
         panF3qzhCHhG8dSKJf7TG2km4lnpdHAzB8eHIQXsWLWwyjYmKAEr/ZTO+aSqYDQoyA
         DaL8GN4ofsbJuKC71l8v3JpP/yosWos9qll8/Zmv1r1r0owouBzvSKDl3lnj+aLk4c
         lFMhqSMc5euYw==
Received: by mail-yb1-f176.google.com with SMTP id q184so3433591ybg.11;
        Tue, 24 May 2022 11:13:51 -0700 (PDT)
X-Gm-Message-State: AOAM533feHmoQLmOpoVFHTOiKidPqeQS5ybzrg9oIgVner0CrZmzzw8g
        rfOp0rLx7bfQO5q6aCaP2RABRZuZxYMFwqd3Ay4=
X-Google-Smtp-Source: ABdhPJwA4LkeB8g8FYU7aoFUFJXoNMzry/iIe9pPlGF5v622Qj+FvE4j7gAfkuv8N8q8LuBcbNxQNpK8U0AjKTZKB3s=
X-Received: by 2002:a05:6902:114c:b0:641:87a7:da90 with SMTP id
 p12-20020a056902114c00b0064187a7da90mr28961716ybu.561.1653416030213; Tue, 24
 May 2022 11:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220519191311.17119-1-logang@deltatee.com> <20220519191311.17119-13-logang@deltatee.com>
 <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de> <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
 <f270d92d-7c34-2f58-89c5-ccb7a8a37872@deltatee.com>
In-Reply-To: <f270d92d-7c34-2f58-89c5-ccb7a8a37872@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 24 May 2022 11:13:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW48iTJyNVip0jYeNFUaFT-XGt297h+ueHfEt=YTfWobsA@mail.gmail.com>
Message-ID: <CAPhsuW48iTJyNVip0jYeNFUaFT-XGt297h+ueHfEt=YTfWobsA@mail.gmail.com>
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log accesses
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Donald Buczek <buczek@molgen.mpg.de>,
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

On Tue, May 24, 2022 at 8:59 AM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
>
>
> On 2022-05-23 00:47, Song Liu wrote:
> >> A problem here is that `struct r5l_log` of `conf->log` is private to r=
aid5-cache.c and gcc below version 10 (wrongly) regards the `typeof(*p) *lo=
cal` declaration of __rcu_access_pointer as a dereference:
> >>
> >>    CC      drivers/md/raid5.o
> >>
> >> In file included from ./include/linux/rculist.h:11:0,
> >>
> >>                   from ./include/linux/dcache.h:8,
> >>
> >>                   from ./include/linux/fs.h:8,
> >>
> >>                   from ./include/linux/highmem.h:5,
> >>
> >>                   from ./include/linux/bvec.h:10,
> >>
> >>                   from ./include/linux/blk_types.h:10,
> >>
> >>                   from ./include/linux/blkdev.h:9,
> >>
> >>                   from drivers/md/raid5.c:38:
> >>
> >> drivers/md/raid5-log.h: In function =E2=80=98log_stripe=E2=80=99:
> >>
> >> ./include/linux/rcupdate.h:384:9: error: dereferencing pointer to inco=
mplete type =E2=80=98struct r5l_log=E2=80=99
> >>
> >>    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >>
> >>           ^
> >>
> >> ./include/linux/rcupdate.h:495:31: note: in expansion of macro =E2=80=
=98__rcu_access_pointer=E2=80=99
> >>
> >>   #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(=
rcu), __rcu)
> >>
> >>                                 ^~~~~~~~~~~~~~~~~~~~
> >>
> >> drivers/md/raid5-log.h:61:6: note: in expansion of macro =E2=80=98rcu_=
access_pointer=E2=80=99
> >>
> >>    if (rcu_access_pointer(conf->log)) {
> >>
> >>        ^~~~~~~~~~~~~~~~~~
> >>
> >> make[2]: *** [scripts/Makefile.build:288: drivers/md/raid5.o] Error 1
> >>
> >> make[1]: *** [scripts/Makefile.build:550: drivers/md] Error 2
> >>
> >> make: *** [Makefile:1834: drivers] Error 2
> >
> > This is annoying.. And there are a few other cases in raid5-log.h and
> > raid5.c.
> >
> > Maybe we should move the definition of r5l_log to raid5-log.h?
>
> That's the only solution I can think of, and what I'll likely do for v2.
> If anyone has a better solution I'm open to it.

Let's move the definition.

Thanks,
Song
