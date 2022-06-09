Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36787544E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiFINxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiFINxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:53:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CA1F703D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:53:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x5so26213084edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMMFb3q8dQKJuiEfkSLQTJlf/XhrzWNCwTcjPXBqwk8=;
        b=IItgPjqhpx0+83mRLTgiGBYEQIi+BKGDe8oSQ+ezGoEQ8ASfW5c3KBNlItx7qhZIt/
         d7POxEPq0nH13evlIx+T2QQCYuccW9BbltNkKptOFiXBQ1MTG8sL5Ix2Rs12AyGUc1OZ
         20M3CdkHFWwMDGUs8F6abivuMs7hsD+zcSorF0RWaVAWmgVfLqlhEuRqsuTFeoFawdSR
         Hn0ZZqDHgai+cR5LgBEHl4GYVmF9tkOe/ZPULlTxeY3K9VZwesffe2BMg2A4BMJdPHA8
         UXcZ2+Gt+fneWiehw5DVfm4jIF2D5zNSYGHjJT2OX1kKfBtHQnu63HFo7XZMITzQcKIM
         egGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMMFb3q8dQKJuiEfkSLQTJlf/XhrzWNCwTcjPXBqwk8=;
        b=fgOY/SWFK9jPJ2Yr/i6sYAeUULA9MYIxBeaBv9nxgEtz7HyK4z11KfbwEFxJsTyiFh
         xOehkXoVE8ZPJ+LyhUzADwE7O4NlH3oJ1FPKhPYoadSpR7ww7vds3ydxJ3U+QX1viYWI
         IS+PCHeoWM1IrAm8l8wiYlGRiLUMgjEWjBMWdg43GusHHaJZmURBOkprODZ+H3WtY8Hi
         f78CuvmZzPjkTHqe842QOW5DZ+K2j9XTFeTFly2zIaDeKWYjIze87ywEbeVLvbp6/u5G
         BCyFwdvMcLDTbXoiRYZn8WVfXc7UyTJsSt4p+QysXesPsTnjnADA/Cf860qc2H6S6aZK
         kA0g==
X-Gm-Message-State: AOAM532ufpzQ57C26jmSXvKCXLx2sy7iaq8QQPMO0L4FenrndgUmjJfw
        Pt6G4OeLD93b2yG9s1EmyfF+gkFA0Xm/FwsuUSA=
X-Google-Smtp-Source: ABdhPJzv2A4wp+xAKyjpuf4pqm0yuKPhCeXw+EKHLTCqRKXsbJIqAK9prUci7/okkqHMgmjZPWX7C2b87OF269RhAIQ=
X-Received: by 2002:a05:6402:2554:b0:42d:ee79:559d with SMTP id
 l20-20020a056402255400b0042dee79559dmr45259225edb.175.1654782818596; Thu, 09
 Jun 2022 06:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093449.3100-1-urezki@gmail.com> <20220607093449.3100-4-urezki@gmail.com>
 <YqAVS7rYAmOmlLYH@MiWiFi-R3L-srv> <CA+KHdyWDSUgFQnCPr_i=NwoDNFiqP2Q6Z6pik3djK=TQ=hoSZQ@mail.gmail.com>
 <YqH19tutOqChQpwM@MiWiFi-R3L-srv>
In-Reply-To: <YqH19tutOqChQpwM@MiWiFi-R3L-srv>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 9 Jun 2022 15:53:26 +0200
Message-ID: <CA+KHdyVGMcFhdiTwUNeFqjJCoFtXhL1T815uMD5isCTNqMSOoA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/vmalloc: Initialize VA's list node after unlink
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 3:30 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 06/09/22 at 02:36pm, Uladzislau Rezki wrote:
> > >
> > > On 06/07/22 at 11:34am, Uladzislau Rezki (Sony) wrote:
> > > > A vmap_area can travel between different places. For example
> > > > attached/detached to/from different rb-trees. In order to
> > > > prevent fancy bugs, initialize a VA's list node after it is
> > > > removed from the list, so it pairs with VA's rb_node which
> > > > is also initialized.
> > > >
> > > > There is no functional change as a result of this patch.
> > > >
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 745e89eb6ca1..82771e555273 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -978,7 +978,7 @@ __unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
> > > >       else
> > > >               rb_erase(&va->rb_node, root);
> > > >
> > > > -     list_del(&va->list);
> > > > +     list_del_init(&va->list);
> > >
> > > Don't object this change, while list_del poison members, which is also
> > > not bad?
> > >
> > It is not bad for sure. The main aim was to be align with what the
> > RB_CLEAR_NODE() does, i.e. initialize VA when it is detached
> > and be safe with list manipulation when it is detached. For example
> > whether it is empty or not: list_empty(), etc.
>
> Agree. list_del() can't make list_empty() work, and RB_CLEAR_NODE() has
> done the clearing already.
>
> Then this change looks reasonable to me, thanks.
>
> Reviewed-by: Baoquan He <bhe@redhat.com>
>
Thanks!

-- 
Uladzislau Rezki
