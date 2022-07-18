Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12514578DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiGRWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiGRWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:41:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2403931228
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o26so9954409qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhwistRYtSEw+FOLxYsmvUgg2SfWUhko3Y0iHqBJPu4=;
        b=aZjpVE4EcfZyMPDvoC7PBa41wvK2SMv/ubMIQQmy/TcdmvAB5sTm44ZV/uFzXt0wKb
         dY1VwMVxuQMp9OYczxgQEk9hE51YGmr3jeXIZY234G94ZXXg8PMXFU/zJqaUpcjH7ejA
         LYVWL2CCeav7caDWP+9DFE7whPhYbTJSoCcTnByMx5lxj9MtM03ixpQAZLwBsUxIBkjg
         QUN0frpfAARrFIv2TnEePpjDVy58E7mdMzD8yaY1OTNOoFTfzUxrtQBhVR0D9BaBb9kB
         IrWLlZBGkxIPpfI98VafP5REK0GHAtwXrp03Ht7SCMiv8t682jChRH2ZOETYgUaTzYUc
         Ov3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhwistRYtSEw+FOLxYsmvUgg2SfWUhko3Y0iHqBJPu4=;
        b=bzWaP4R8bYqGPzTY11jZ2iGl8pfM/Nn5+FvSUEAptHpt0gE4FwvINLjgPzjHEqEcx3
         b3fZxvGLA9yQ5f28kIbg/OJBWeKhUthk+y722TpQcdEzW5pzBpPZiNbxTkv9EzOaOk/Z
         DzsLg8j8/asNBheKur0HlseJ/zwABF0j8VfnuOlvyhYgxSypJ3mjDAhY592vQh/L0dRy
         fRs4LDN5Qh7HbsTj1YYCHx+Hn53lWq7AlBDZQHBMqTFA/PG7ZirJPfZQg1BKXi9wMb+W
         uq6Y3k20lzSStT5/BlS2HzG8j+hwq8a5AjTHQqhgB1SiN0MqRINgGVt2Of0okTmp6xp4
         1n/w==
X-Gm-Message-State: AJIora+ZS/ePUejPPJboAN9A5uOj0OIOpIw56NftDFdL7zW0Ue+4beF8
        y87gS32mxvXTIuOtiO/319FX/WWxWPHkO5GyNok=
X-Google-Smtp-Source: AGRyM1uScp5BBbw1h7lKeNpe/eePFGZhqBK9tTMDKuzsgR/3BD2ukP36SV2w1XPGK7UaVV0BfA7m9PBA3Pmv5jHpmqw=
X-Received: by 2002:a05:620a:2556:b0:6a7:9f07:602 with SMTP id
 s22-20020a05620a255600b006a79f070602mr18213055qko.207.1658184099146; Mon, 18
 Jul 2022 15:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <9363b16202fb04a3223de714e70b7a6b72c4367e.1655150842.git.andreyknvl@google.com>
 <YrBDzKTZMnWztGIQ@elver.google.com>
In-Reply-To: <YrBDzKTZMnWztGIQ@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 19 Jul 2022 00:41:28 +0200
Message-ID: <CA+fCnZe7b0iNPePpYXswDsjZykphK8vgaYDeeOJCuKbePPDVVw@mail.gmail.com>
Subject: Re: [PATCH 19/32] kasan: pass tagged pointers to kasan_save_alloc/free_info
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:54 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, Jun 13, 2022 at 10:14PM +0200, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Pass tagged pointers to kasan_save_alloc/free_info().
> >
> > This is a preparatory patch to simplify other changes in the series.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/common.c  | 4 ++--
> >  mm/kasan/generic.c | 3 +--
> >  mm/kasan/kasan.h   | 2 +-
> >  mm/kasan/tags.c    | 3 +--
> >  4 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index f937b6c9e86a..519fd0b3040b 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -227,7 +227,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> >               return false;
> >
> >       if (kasan_stack_collection_enabled())
> > -             kasan_save_free_info(cache, object, tag);
> > +             kasan_save_free_info(cache, tagged_object);
> >
>
> Variable 'tag' becomes unused in this function after this patch.

Will fix in v2, thanks!
