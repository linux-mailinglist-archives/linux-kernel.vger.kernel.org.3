Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624FA544C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbiFIMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245523AbiFIMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:36:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6392317D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:36:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b8so14337313edj.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k534WYxTyqTlyHj7z7jLQha4qD6Bajp/eHQMyN5NOoA=;
        b=MgXeV2dVHyvEW7LeJK/ajtzstgF8A5WVQUJ8cPJnZ2u4eJ+0stlTeRIhmaT1cTPWnc
         iZ2z4zTTHYKo6r4VCpwfTJ1iyy3qVV9HTXJtpMigBRNLYl9rT/v03TuylqqWwa6WCdfN
         XX48OFchMwDtv0VxjeQ3xKkZwnpMhhd+gDEcAmVnPjeMkQcS2TBvOL451TYSnb5D+McB
         zdTFX78PQLNnAFHJXb1R50Cn1O6GB1Lg9R/FzUEv223GbW1iOlw9K5i8QNE+MU7qcmhv
         AVGopRE7PNT1M7ymx3f3xVyWH19aBSdn60DInvLsl7uie6MarsqH8qE2n6iteadwwYkI
         qF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k534WYxTyqTlyHj7z7jLQha4qD6Bajp/eHQMyN5NOoA=;
        b=cj+Sh0A9D4M5Q8Sb/MjE34bf7ZtRfDJYKDVbPUEtbBxlDj6PAuc+6zSnjXk89LXvET
         gjxlKxnQLnm1YXwvg23OSPryAKJiG9oboLyAJdk5VxFtx9wVVhh43C/e5NcmpTDckCR3
         XHV6ThI77pbMjVUDTog97CMjtYHKglekYpC99aiLQQKbroED0IeBGWHvQo0aS7nDsWOv
         sNW+D2toBY6vjLj5lmcjfnzBmwueSjFXHbXd6Lmwx9tDb7JvN81tAfFQdD2sCWOZOmSs
         ZTSL5ux+21jyoupWJMymHOKjEmeJwGVl0yLTZeBcGQxamLAUUeaQ33n6rNcsFwzBjT1L
         iwBQ==
X-Gm-Message-State: AOAM531/0eRP58/td//PXdkiPDGLEBiqVhwNluL4RO4i5hRYjOEBohyG
        RrgeenemHfdKg6dm5HAYjuLPekhH23TQbw4w0R0=
X-Google-Smtp-Source: ABdhPJzsviw3XcPKRI4vJ4d/dcGwcAAqvFVqEieN/lnYFS2vpDL7wAY96siZ2e9FlBbq2ALsYxWNBiUa8PAYssEiZkc=
X-Received: by 2002:a05:6402:2554:b0:42d:ee79:559d with SMTP id
 l20-20020a056402255400b0042dee79559dmr44846992edb.175.1654778192904; Thu, 09
 Jun 2022 05:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220607093449.3100-1-urezki@gmail.com> <20220607093449.3100-4-urezki@gmail.com>
 <YqAVS7rYAmOmlLYH@MiWiFi-R3L-srv>
In-Reply-To: <YqAVS7rYAmOmlLYH@MiWiFi-R3L-srv>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 9 Jun 2022 14:36:22 +0200
Message-ID: <CA+KHdyWDSUgFQnCPr_i=NwoDNFiqP2Q6Z6pik3djK=TQ=hoSZQ@mail.gmail.com>
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

>
> On 06/07/22 at 11:34am, Uladzislau Rezki (Sony) wrote:
> > A vmap_area can travel between different places. For example
> > attached/detached to/from different rb-trees. In order to
> > prevent fancy bugs, initialize a VA's list node after it is
> > removed from the list, so it pairs with VA's rb_node which
> > is also initialized.
> >
> > There is no functional change as a result of this patch.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 745e89eb6ca1..82771e555273 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -978,7 +978,7 @@ __unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
> >       else
> >               rb_erase(&va->rb_node, root);
> >
> > -     list_del(&va->list);
> > +     list_del_init(&va->list);
>
> Don't object this change, while list_del poison members, which is also
> not bad?
>
It is not bad for sure. The main aim was to be align with what the
RB_CLEAR_NODE() does, i.e. initialize VA when it is detached
and be safe with list manipulation when it is detached. For example
whether it is empty or not: list_empty(), etc.

-- 
Uladzislau Rezki
