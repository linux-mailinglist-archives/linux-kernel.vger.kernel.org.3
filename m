Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB85AA39F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiIAXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiIAXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:18:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04EA3D1B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:17:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j204so933366ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LLe4P0CDKZNu2y/iLQFOmqm2xVCa1+xC0+/2UAKABJs=;
        b=E800dH7PG7qGduh6oSah7WQAwmrsM+wQmDZjjqdBAR60RvrxBZHO23f04n2iXHj6B6
         JP4sBRMEb5m0iPCXbYazGmBCzu7qChwl/ipzAmIhLadRiKX3Y0zySsPNlYd0h+LcoxL8
         5FNxATVqNyLa1BoYf6Cxlq+XP5qZplVJPHSMPHn1kfsbAjFzQxAMb9VoJYRqdqVYgEwr
         U+TKjEqBLNEszFZU9PUc/x9OXZ/4B2ib6Q/EZSxGRaxVsTNJo0XeGgkfBjLjXtDUFglC
         Q2eTqe1FllFFqOAiwsRUf4TETNOa1mHZ6WH7dmCthCaB5IO6/fwVnji8K+vdyqp3MbuZ
         tFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LLe4P0CDKZNu2y/iLQFOmqm2xVCa1+xC0+/2UAKABJs=;
        b=1O5wEOrmQHvgjAB5S724WzhRUU7W9sNLuFubbBP/acKn+to1xZE2TXkVpBxtWrWLnp
         EG0GKwURFB/Lg0bVF5gfG5S8dg1yRnY/10L5/8HDOvrLHTNqvwy+FmZV8rsYIA4wx4Ua
         nunl8zArXU1t34pwgD4UseineVn3OCzAoc+azEGr/AW36gCqIs7h3b8dl0OpGwMeMK/a
         7TmJTwJj8WarM8B9N04lHYS57ab7JMX9h/O3vU4dvAZVfSCgzD2zRQEOB/jsHwn9aEug
         fLUZjFT35q7cd5Q6gMHUDzCTdwWQU2/74nR3yareT6PjSY7z8/PmyxCBTlZ4IBCcbI5a
         vb3A==
X-Gm-Message-State: ACgBeo1RS8zJ1P619XntaNZF4cpndHgvmetTS1U6DZAoxpaM6lAe5AL3
        qlXht9Duqva+uFDUpyPTHsDNKG4+xb3QR61dh75iFg==
X-Google-Smtp-Source: AA6agR6jFuUOVZTVV0+XfDd0He4Hrb9XV2PsfvVugkFPyYicaO90qEw/qesq5yP63n03v6KmDubjqCQiaNOXXMGy9zw=
X-Received: by 2002:a05:6902:705:b0:695:b3b9:41bc with SMTP id
 k5-20020a056902070500b00695b3b941bcmr21131741ybt.426.1662074264903; Thu, 01
 Sep 2022 16:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-24-surenb@google.com>
 <20220901202052.xfaeuhmosheml2gz@moria.home.lan>
In-Reply-To: <20220901202052.xfaeuhmosheml2gz@moria.home.lan>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 16:17:33 -0700
Message-ID: <CAJuCfpEJxxm17fFJ1YVkOTBJbP5ce9ey90q_mCk_pkyTdHkrUg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 23/28] x86/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>, bigeasy@linutronix.de,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
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

On Thu, Sep 1, 2022 at 1:21 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Sep 01, 2022 at 10:35:11AM -0700, Suren Baghdasaryan wrote:
> > Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
> > compiled on this architecture.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/x86/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index f9920f1341c8..ee19de020b27 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -27,6 +27,7 @@ config X86_64
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > +     select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_USE_CMPXCHG_LOCKREF
> >       select HAVE_ARCH_SOFT_DIRTY
> >       select MODULES_USE_ELF_RELA
>
> I think you could combine this with the previous path (and similarly on other
> architectures) - they logically go together.

Thanks for the feedback! I see no downside to that, so unless there
are objections I will combine them in the next version.
