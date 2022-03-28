Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904884E8E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiC1HEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiC1HEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:04:13 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA3E32982
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:02:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x20so24259819ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwxetPNc6Y1ndBg59v0qTwqCMW+RX+QXtDxwiYX/QcY=;
        b=oQjYl0VWVU8kxZqRgLrRJylBYKDAfu2P+MqJrikBOY4cYgVZRJuXh8PdhrRvsx5++q
         OC2NMTK7wrbpFIDA2F+JIYQIk2/Hfd7h3Szj8FAeuuu3AtvVdUvQ5LL5j5tRQBvAy/U5
         EW2xcOkTOTcPsgqfjVzFip9g7drZlmsjIVxbnww2gYiJTBfCoZurMqDp+qgYQJ2Rrtnx
         PKZfISDr69xp+ybvl1fNeBAbi89uVkLWdSx0lJlkPwe6CO7INN7AdobyGpxxaDe75Wio
         6+29D3AxsbKcHgwZPQf2GPiq4lJYoM7L5cC61ayZvFSac85w0odjhCONYIqGbjSS0EAK
         mRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwxetPNc6Y1ndBg59v0qTwqCMW+RX+QXtDxwiYX/QcY=;
        b=5ruHHX9DdAtXyP3ZLLAW97p4UM9Hr3+AVG7AHdfGT7PTZys4bbei4GpVgF0Q46m1cR
         5pYxVoVJfFMGiAnBFYnQ+CO6jaSPh5ytJb1vzGjLJucapnA04WNDGwMUWd6TFy6YlVxH
         NL91UTjIYXQf6gRC1WMxOCEefdrQ27/Mx/VDDgeIsYe2okaalvLMR9LASA4YjpWsYxMD
         phaGl3BXXRWCL3Yl4JCBSD4N+kQs4xZC/wQ+aK2d++L2vbI4/znbPuQOp0J6wIJorylM
         F2ThrQ/miqs6cNsVyIwzIqODxn8O6iZNSK9uVwPYbyl6iCpq3Wa0GwxgNMCAEp++k3Ue
         MhoA==
X-Gm-Message-State: AOAM533nE/bi3WCo0XfpObl6N+E6/14OR2J21cgjjzyUR5E+GbNov53z
        kqGvdzY4fx60aFQ0jCvbymQWpS0RZ4Lf/fEbLYZe8A==
X-Google-Smtp-Source: ABdhPJy73Qtx0ny5VqjuQuHNLFzET7+MEl9kPFj+10ogu4maeklF3JBd4rEFNfkBXoJI3+0sReG34wOW+F5JBMo6XnU=
X-Received: by 2002:a25:d08a:0:b0:633:eba2:e487 with SMTP id
 h132-20020a25d08a000000b00633eba2e487mr20846788ybg.609.1648450952327; Mon, 28
 Mar 2022 00:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com>
 <20220327051853.57647-2-songmuchun@bytedance.com> <CANpmjNPA71CyZefox1rb_f8HqEM_R70EgZCX8fHeeAnDyujO8w@mail.gmail.com>
 <CAMZfGtXt9xWnVv8hav+zWHYRmOqBGu3WPaasYwGxCb1-MDDwgQ@mail.gmail.com>
In-Reply-To: <CAMZfGtXt9xWnVv8hav+zWHYRmOqBGu3WPaasYwGxCb1-MDDwgQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Mar 2022 09:01:55 +0200
Message-ID: <CANpmjNMf9bwR9Oa-qrHZ5TBnR2pSRufgCuBjuNm0B428GB61Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, 28 Mar 2022 at 03:53, Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Mar 28, 2022 at 1:31 AM Marco Elver <elver@google.com> wrote:
> >
> > On Sun, 27 Mar 2022 at 07:19, Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > If the kfence object is allocated to be used for objects vector, then
> > > this slot of the pool eventually being occupied permanently since
> > > the vector is never freed.  The solutions could be 1) freeing vector
> > > when the kfence object is freed or 2) allocating all vectors statically.
> > > Since the memory consumption of object vectors is low, it is better to
> > > chose 2) to fix the issue and it is also can reduce overhead of vectors
> > > allocating in the future.
> > >
> > > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/kfence/core.c   | 3 +++
> > >  mm/kfence/kfence.h | 1 +
> > >  2 files changed, 4 insertions(+)
> >
> > Thanks for this -- mostly looks good. Minor comments below + also
> > please fix what the test robot reported.
>
> Will do.
>
> >
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > > index 13128fa13062..9976b3f0d097 100644
> > > --- a/mm/kfence/core.c
> > > +++ b/mm/kfence/core.c
> > > @@ -579,9 +579,11 @@ static bool __init kfence_init_pool(void)
> > >         }
> > >
> > >         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> > > +               struct slab *slab = virt_to_slab(addr);
> > >                 struct kfence_metadata *meta = &kfence_metadata[i];
> > >
> > >                 /* Initialize metadata. */
> > > +               slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
> >
> > Maybe just move it to kfence_guarded_alloc(), see "/* Set required
> > slab fields */", where similar initialization on slab is done.
>
> But slab->memcg_data is special since it is only needed to be
> initialized once.  I think it is better move it to the place where
> __SetPageSlab(&pages[i]) is.  What do you think?

That's fair.
