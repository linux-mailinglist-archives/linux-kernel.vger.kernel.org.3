Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85053B6F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiFBKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiFBKWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:22:23 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0F2ADF49
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:22:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-30fdbe7467cso11267277b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUd3SPNTBG11Pw4ONwPRjvgnGE2d3p2dtoAJcfU9H9o=;
        b=nlFi7M3tVp4pU0E+EsVFl71MIOQgnjG/VIgFEYoBqd5wL5HW85p7qwOMrc7kSxxMSD
         tKziZmGmQZNze4UEDfqNLwkQAl6+Vpn9cR0R2CPRBmg9OHKSUDbyaKag6NVI/sOg5XRL
         FmQqV6ZOW1JLooFruZDqNqFZSeLVlcO2KGhyt6h5Iy+sjbY0rEd8cYIK6RaOYM+W5PYJ
         xmv3UMY/zCWm2gO5ZjXB9ZkuvOCOQJPcZLW8Ya75ElBU9OsmLO5NfeZcoNcXWrtbfIX/
         hWi6KD2Yf2SivFGS8G2PIKWuEVRjUaoA+VuPStNaEEShkULE92qVBimRO2q7wdRHgcge
         LHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUd3SPNTBG11Pw4ONwPRjvgnGE2d3p2dtoAJcfU9H9o=;
        b=MQu4nsCBrNN0mwUR0PM1ZNFFaa9GKI/z3elQbIPcTasIjFZqWhXabLoWSb5WAZA67Z
         0OtYtxtOyLYqefdnCNdT3bWkLRUKJnyNNwyh1YT0mj4vaXEAnWVsNSmm44XiPZ52ddM8
         Td037jAfOI7TIhr6WMyW8sjMEVWhO7zHGPKEGAwbx9eWEv0SMxnTTjn+LA7v8CVWre4p
         NZHhfrvYwpxwfAZcXnhBL5uBaLBbH84HsNxcXRMfKSP8e/5l4I9UfP17iHun9fy2Zml/
         8NoqNwD6wYqAyoB76tMr9xPyBqILClXb6IneAwLfc+VlrG5gLirN2LuxykobP81xFV14
         uxzg==
X-Gm-Message-State: AOAM531vnIxSVO6cg4OO8k8IscMTs2B76tg7cyMuLBOg3H/h1VsR79Zb
        QIaIKDUSx5s+F8Wch5NBqBYsoGycXDPmPrr0Hw0=
X-Google-Smtp-Source: ABdhPJx1PIEvF6A2hj9tWw5qrvzoGZMFb4SzV9gd+N6cpS04kOWoA7HW5LFF2wYgEEM58ydCeW4zASwefd1r7SFbZcc=
X-Received: by 2002:a0d:f502:0:b0:2ff:3e75:b4ea with SMTP id
 e2-20020a0df502000000b002ff3e75b4eamr4499151ywf.171.1654165341322; Thu, 02
 Jun 2022 03:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220531150823.1004101-1-patrick.wang.shcn@gmail.com>
 <YpZCWbfNE32EzCnz@arm.com> <99faf6b0-30bf-f87c-2620-1eafb4eac1ac@gmail.com> <YpeQNkk31d7JL9g6@arm.com>
In-Reply-To: <YpeQNkk31d7JL9g6@arm.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Thu, 2 Jun 2022 18:22:10 +0800
Message-ID: <CAGcnep_brHvOBv=cM6y4zdefc=kdJyRxG2W8_yaYeBOt0vtQ8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: kmemleak: check boundary of objects allocated with
 physical address when scan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Yee Lee <yee.lee@mediatek.com>
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

On Thu, Jun 2, 2022 at 12:13 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jun 01, 2022 at 06:24:34PM +0800, Patrick Wang wrote:
> > On 2022/6/1 00:29, Catalin Marinas wrote:
> > > On Tue, May 31, 2022 at 11:08:23PM +0800, Patrick Wang wrote:
> > > > + if (kmemleak_enabled && (unsigned long)__va(phys) >= PAGE_OFFSET &&
> > > > +     !IS_ERR(__va(phys)))
> > > > +         /* create object with OBJECT_PHYS flag */
> > > > +         create_object((unsigned long)__va(phys), size, min_count,
> > > > +                       gfp, true);
> > >
> > > Do we still need to check for __va(phys) >= PAGE_OFFSET? Also I don't
> > > think IS_ERR(__va(phys)) makes sense, we can't store an error in a
> > > physical address. The kmemleak_alloc_phys() function is only called on
> > > successful allocation, so shouldn't bother with error codes.
> >
> > In this commit:
> > 972fa3a7c17c(mm: kmemleak: alloc gray object for reserved
> > region with direct map)
> >
> > The kmemleak_alloc_phys() function is called directly by passing
> > physical address from devicetree. So I'm concerned that could
> > __va() => __pa() convert always get the phys back? I thought
> > check for __va(phys) might help, but it probably dosen't work
> > and using IS_ERR is indeed inappropriate.
> >
> > We might have to store phys in object and convert it via __va()
> > for normal use like:
> >
> > #define object_pointer(obj)   \
> >       (obj->flags & OBJECT_PHYS ? (unsigned long)__va((void *)obj->pointer)   \
> >                               : obj->pointer)
>
> In the commit you mentioned, the kmemleak callback is skipped if the
> memory is marked no-map.
>
> But you have a point with the va->pa conversion. On 32-bit
> architectures, the __va() is no longer valid if the pfn is above
> max_low_pfn. So whatever we add to the rbtree may be entirely bogus,
> and we can't guarantee that the va->pa conversion back is correct.
>
> Storing the phys address in object->pointer only solves the conversion
> but it doesn't solve the rbtree problem (VA and PA values may overlap,
> we can't just store the physical address either). And we use the rbtree
> for searching objects on freeing as well.
>
> Given that all the kmemleak_alloc_phys() calls always pass min_count=0
> (we should probably get rid of the extra arguments), we don't expect
> them to leak, so there's no point in adding them to the rbtree. We can
> instead add a new object_phys_tree_root to store these objects by the
> physical address for when we need to search (kmemleak_free_part_phys()).
> This would probably look simpler than recording the callbacks and
> replaying them.
>
> Wherever we use object_tree_root we should check for OBJECT_PHYS and use
> object_phys_tree_root instead. There aren't many places.

Considering the usage of objects with OBJECT_PHYS, storing
the phys address and giving their own rbtree should solve the
phys problem. I will post a v2 ASAP.

Thanks,
Patrick
