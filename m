Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC65A92F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiIAJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiIAJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:18:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBD11EB43
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:18:56 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3378303138bso330615577b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ofyTx4HKrXBAG7we5X7Qai/eK2K43C5jxgUz5nh/Yro=;
        b=DNWL+HfERAfAtjtdicaVsZrEdzV4N3Vw5nQ7XoQB5JVkpg5p8Lsx+iFTSKvtyCFj5u
         BAfxBIvqMTTrW79mMYA44nyO0vqrbHf0Mc0d6NIllyaZ+83qZ0DGOTlWDkqrmDfiFUBg
         Uarv4p7UHZor3SU51nWN/bvVjMMHzk7sZhJB6O0Y6OqzyJhhnhBEpTygZ6N+7k/hbIST
         vZ2QhDDBCROSeFX8TMsw8gkqJpObIOjwYdFIC5Hx0mayX6/hIUz5nT4hj1yABlepUqM4
         1PjoU84RkgqZApPhBtpAkTXjpToOqeRjtEv9GgqlCBJXqeaEu4nsMq3SJXKWs4bw2g9v
         EQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ofyTx4HKrXBAG7we5X7Qai/eK2K43C5jxgUz5nh/Yro=;
        b=JoGgnMUWSjyFTgqljphc/jVSa7ZW9IoYF25ZoPLk/gkbgnYzCGFQyD8/1RDffef3nx
         utqof6gUckCW50xN1RfaPVIQBivlPjD0iWIySGFHK7J59ljnYOkzTW3I3Vcs27ipJMhW
         376HxrxyPml3+90Bx8vnIKGJ34w5EYJRZ5Z4s9wy2B6XF3k/OGXLmWPZLbGfnI+pmkjK
         y8GEtL3XL5Yv8mX7IrudioN4ftV1bhRIGEYRQBCn1A219K8RPhHCrmP3yDe/oejSrX+R
         AJwh60mfnXPcX+bT/120Gcg7lDO4KLZuJH0FKlbqUznzRRNJxFPAYEtjvk7qlsMdaGx+
         N+hA==
X-Gm-Message-State: ACgBeo1vtP9rKoSz/kd9D1Ir4/OXyWB9YSUCodjYsQEGj57inEGZQaej
        x90akL9A1FNx9xlWmTKb8TBr7MXVTbWgqCPJtu0VFMgw0Kxmzw==
X-Google-Smtp-Source: AA6agR4YzkMcE//RozLPe3AlZMR1RsPsbQRd1aguh7fbGIubS9uQzS9d0L0VXutUFfemJr0JfjfopiWBTfT/BVDRmY8=
X-Received: by 2002:a0d:ea49:0:b0:33d:bce7:25c2 with SMTP id
 t70-20020a0dea49000000b0033dbce725c2mr21912903ywe.267.1662023935298; Thu, 01
 Sep 2022 02:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220901044249.4624-1-osalvador@suse.de> <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com> <YxBvcDFSsLqn3i87@dhcp22.suse.cz>
In-Reply-To: <YxBvcDFSsLqn3i87@dhcp22.suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 1 Sep 2022 11:18:19 +0200
Message-ID: <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com>
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

On Thu, 1 Sept 2022 at 10:38, Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 01-09-22 10:24:58, Marco Elver wrote:
> > On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> [...]
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index 5ca0d086ef4a..aeb59d3557e2 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -63,6 +63,7 @@ struct stack_record {
> > >     u32 hash;                       /* Hash in the hastable */
> > >     u32 size;                       /* Number of frames in the stack */
> > >     union handle_parts handle;
> > > +   refcount_t count;               /* Number of the same repeated stacks */
> >
> > This will increase stack_record size for every user, even if they don't
> > care about the count.
>
> Couldn't this be used for garbage collection?

Only if we can precisely figure out at which point a stack is no
longer going to be needed.

But more realistically, stack depot was designed to be simple. Right
now it can allocate new stacks (from an internal pool), but giving the
memory back to that pool isn't supported. Doing garbage collection
would effectively be a redesign of stack depot. And for the purpose
for which stack depot was designed (debugging tools), memory has never
been an issue (note that stack depot also has a fixed upper bound on
memory usage).

We had talked (in the context of KASAN) about bounded stack storage,
but the preferred solution is usually a cache-based design which
allows evictions (in the simplest case a ring buffer), because
figuring out (and relying on) where precisely a stack will
definitively no longer be required in bug reports is complex and does
not guarantee the required bound on memory usage. Andrey has done the
work on this for tag-based KASAN modes:
https://lore.kernel.org/all/cover.1658189199.git.andreyknvl@google.com/
