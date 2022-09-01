Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F055A9434
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiIAKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiIAKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:21:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25381090A0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:21:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-33dc31f25f9so331871977b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dq57C6wCfbAHbefKG8GYTmvvjyg3019DyyLHKt8zuMQ=;
        b=aimEc3ftsqVQXvwxk2Z52xTHES+wz28tfiscVQ0z7FBJ9dpEGOvABsWukvxWBNRo4e
         Q1Xj1HusZkX0PzlyaFjWF9UlXKMqWqIiSabeK1XHSuoEEYxzwMIx1HHD6PE+60lzQahP
         joa7YSF3kMMAg8b2LFENixzbJ1aaBidTxLRIKdfsG4YK669Nk+dR1xg9bbNQ8uG/WBnD
         ppomJK6w8Kp7ZzKGDzH1Vrin9NN37FuwfCe4tk2Vr6QXdcM9PRiSHeicck4mog0yVA87
         DiZG6i2OI684wxiVTO0vVEF9IkM1+mMQCqz/49OOSsOQj8zfAmpdSg3NSO5dlOnea3MN
         3ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dq57C6wCfbAHbefKG8GYTmvvjyg3019DyyLHKt8zuMQ=;
        b=rI9wTae2wL9OmZ/4/JKRC06xg3dBWjYH6gHycAHuUa5c7IASi4touRjVpvll8tjXKV
         m01dm8RmzqmEMjVT48oG3Qs/BzPyWeAvoFq5rAvWJ9N1x++tUHLiDBLEDBYWSfMsQJJh
         QDfCvFHKyFLgLM/D2e371Ai7uLsWAtJP8LfxM2yDnbcHJ3qiI8mF7DBprt09uRbetoab
         IlO7S7DEk1lBdO6a+X5QMhNg5CjVcLvcsZpXSVjcTc+Igj4nio5wikNESjXirFbsB36e
         VSBRr797mwO1Wn8UoqCx0va+vNOt5ucIlrd9IznWx/oiAh2sYnohstLAkFvmLReHF22C
         tJHA==
X-Gm-Message-State: ACgBeo0b+4Wf9FKGRu6y4iz+KB5Nvx//J6GqR4be8W3NpO1fuQoHA0nt
        KHRPJh7JOf1VYl16vwwWGbJdX76uByfxlJaFTGhr3g==
X-Google-Smtp-Source: AA6agR4Um8kqsGPdBIvP1swla9DgQaPBT3/UgvHQhsdZBmoYuNHGh9OLWio0Xv2J0qrgmFaURwUd/dglFe3GTtDGF+U=
X-Received: by 2002:a81:bb41:0:b0:328:fd1b:5713 with SMTP id
 a1-20020a81bb41000000b00328fd1b5713mr22919241ywl.238.1662027675106; Thu, 01
 Sep 2022 03:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220901044249.4624-1-osalvador@suse.de> <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com> <YxBvcDFSsLqn3i87@dhcp22.suse.cz>
 <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com> <YxCC7zoc3wX3ieMR@dhcp22.suse.cz>
In-Reply-To: <YxCC7zoc3wX3ieMR@dhcp22.suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 1 Sep 2022 12:20:38 +0200
Message-ID: <CANpmjNO0wzGBOcj1NH+O7AG2c31Q=-ZDwYZENmYmzUQcPZhQEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sept 2022 at 12:01, Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 01-09-22 11:18:19, Marco Elver wrote:
> > On Thu, 1 Sept 2022 at 10:38, Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 01-09-22 10:24:58, Marco Elver wrote:
> > > > On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> > > [...]
> > > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > > > index 5ca0d086ef4a..aeb59d3557e2 100644
> > > > > --- a/lib/stackdepot.c
> > > > > +++ b/lib/stackdepot.c
> > > > > @@ -63,6 +63,7 @@ struct stack_record {
> > > > >     u32 hash;                       /* Hash in the hastable */
> > > > >     u32 size;                       /* Number of frames in the stack */
> > > > >     union handle_parts handle;
> > > > > +   refcount_t count;               /* Number of the same repeated stacks */
> > > >
> > > > This will increase stack_record size for every user, even if they don't
> > > > care about the count.
> > >
> > > Couldn't this be used for garbage collection?
> >
> > Only if we can precisely figure out at which point a stack is no
> > longer going to be needed.
> >
> > But more realistically, stack depot was designed to be simple. Right
> > now it can allocate new stacks (from an internal pool), but giving the
> > memory back to that pool isn't supported. Doing garbage collection
> > would effectively be a redesign of stack depot.
>
> Fair argument.
>
> > And for the purpose
> > for which stack depot was designed (debugging tools), memory has never
> > been an issue (note that stack depot also has a fixed upper bound on
> > memory usage).
>
> Is the increased size really a blocker then? I see how it sucks to
> maintain a counter when it is not used by anything but page_owner but
> storing that counte externally would just add more complexity AFAICS
> (more allocations, more tracking etc.).

Right, I think keeping it simple is better.

> Maybe the counter can be conditional on the page_owner which would add
> some complexity as well (variable size structure) but at least the
> external allocation stuff could be avoided.

Not sure it's needed - I just checked the size of stack_record on a
x86-64 build, and it's 24 bytes. Because 'handle_parts' is 4 bytes,
and refcount_t is 4 bytes, and the alignment of 'entries' being 8
bytes, even with the refcount_t, stack_record is still 24 bytes. :-)

And for me that's good enough. Maybe mentioning this in the commit
message is worthwhile. Of course 32-bit builds still suffer a little,
but I think we can live with that.
