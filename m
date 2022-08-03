Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1886D588919
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiHCJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiHCJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:09:29 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BA19002
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:09:28 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-32194238c77so165102937b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfepPGt63PhV/uLLZC6OjKAhHWfosw2a1cPbmZc1NF4=;
        b=qQJ0HEUz0Pbo9PZQz9N+b7AVup9WJLyZy0+Q5/QhWDYTyMj94g5UCI9Sl2+SKxnEC6
         q0Vz4F/ciqKXbjQ8uLh/bbAWYstkWGar/drjybpyqLweQqHPIPU2h6zEX4QxDiMoQh4G
         RQmOzwWKw5eCKXcOwQ4ZXVMsBnaePjpl70J8vPMAlcToMnkK79ueRdoDxnJ1c+DhPw0x
         XoOJqbdMHQrtXBWL755hMN2PByuXz4Vvz87BdFNYfGrr+xnNFrWQxWYgml8UxbxjQQRA
         bCJZOhU17atQn2NXO00pt+IiWBBmqQP/USNMop41XuP4j8r6uvFNvxORE7BUz0Tg8AB2
         30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfepPGt63PhV/uLLZC6OjKAhHWfosw2a1cPbmZc1NF4=;
        b=Tqv29gnQf98q2vORS/Jf9ccVyjcR0naM0oQhU7Nezo0THNQzuF8idIFjoCCG1ijDD9
         XCCOKNam9Y8QjjcrJc330TBkXSqs8IYevkIQ5DBxTBMjzH/ebuvUPX9KWNi/4dTUwq4g
         Nd80ewRBWhtEr0b/dgRDwfWNJtR+WLSPk1R81b1NrlR1RKwEJA535f71mQEg4NeMOG9h
         OkGktyhGJaID2liC4dnM/w4+1fMsJ8yiEmfEbni3k0asZ9HmNUUvRok1wWt33ixJjUbV
         uMxFq8gClpGeCHOCB2KtMYH/OkCFcUcLRTbQbzNJ+N+hsg4quXB0xmNn4vBxOXmf8mIF
         j+1Q==
X-Gm-Message-State: ACgBeo2ANrTkdERc2kk/jq5ecHOHea4Ox3pUMGypUOhQD1vxidj9QIXV
        2E1xY0qZKQYbLiRmLUbu9++QCvZeOu4yDQrTg0UjvA==
X-Google-Smtp-Source: AA6agR7P7msRUAWuDn0gmK0kuhQJ6PG98FKKnSeaZAG+GDjiiVe0eSa1tcMloSt7cyCKEdKpooMdekL9jDDzo0/g3sk=
X-Received: by 2002:a81:4892:0:b0:31f:9933:9cb with SMTP id
 v140-20020a814892000000b0031f993309cbmr23285753ywa.86.1659517767408; Wed, 03
 Aug 2022 02:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-18-glider@google.com>
 <CANpmjNNh0SP53s0kg_Lj2HUVnY_9k_grm==q4w6Bbq4hLmKtHA@mail.gmail.com> <CAG_fn=ViHiYCWj0jmm1R=gSX0880-rQ-CA3VaEjiLnGkDN1G4w@mail.gmail.com>
In-Reply-To: <CAG_fn=ViHiYCWj0jmm1R=gSX0880-rQ-CA3VaEjiLnGkDN1G4w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Aug 2022 11:08:51 +0200
Message-ID: <CANpmjNNSYgYHeA91QB8dU=_n73Ut3azY6EZT8cd6D-FcWZGw0w@mail.gmail.com>
Subject: Re: [PATCH v4 17/45] init: kmsan: call KMSAN initialization routines
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 at 22:08, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 4:05 PM Marco Elver <elver@google.com> wrote:
> >
>
> > > +/**
> > > + * kmsan_task_exit() - Notify KMSAN that a task has exited.
> > > + * @task: task about to finish.
> > > + */
> > > +void kmsan_task_exit(struct task_struct *task);
> >
> > Something went wrong with patch shuffling here I think,
> > kmsan_task_create + kmsan_task_exit decls are duplicated by this
> > patch.
> Right, I've messed it up. Will fix.
>
> > > +
> > > +struct page_pair {
> >
> > 'struct shadow_origin_pages' for a more descriptive name?
> How about "metadata_page_pair"?

Sure - this is local anyway, but page_pair was too generic.
