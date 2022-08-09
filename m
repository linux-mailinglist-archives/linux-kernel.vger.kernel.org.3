Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAA58E2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiHIWOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHIWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:13:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E794186D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:12:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k26so24609099ejx.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1VsFqqcFXS3n/9+2goZhST4QJC7Ug49yVOYAb2PF94c=;
        b=g2oKOWygAqs06kX5yZw9/NAo7v0Zm7bWI2z8kj3BN5Dj/ubZ2QDeilkkWtUk2RqnEi
         hCByUhB0cGj/zaxF286P463nEiuoqSY2NIrqaf4TqFohK7JVfsZncQBKsB+C8/dWd6Ut
         /p2j7+iJhaHzQ2HabVc05AxIr7TdReAYHEL/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1VsFqqcFXS3n/9+2goZhST4QJC7Ug49yVOYAb2PF94c=;
        b=r9Dn8k8+YfJ9B6N7es/86G9zSDIPfRY1uVeTkgh7QKFZzbIvKEY/LUkmSCTZ7heuG4
         RNAZNBkjx0a3CDps80WScxa4jhsWizEYqh47D1o2e1FXZSZWVf49GVxdcbuaZ8+VzIZY
         6ikcUYZl20qFPu+Lfr21pYc3Cx30gUfM5GUA1HfhH4hflF/xDvQ4FmFWiybl8z03fJ8r
         Wjvy/S6dsPOhITt+auvXsHdtPG9i1nhngdbxR4qC4P4N3Kaa/E4scaF8N9quUq8R8rwK
         pO1vn3M5Xzi0ffpzL3QGrCGl8fif09ml7m8Rzy5mkc9OEK1gplaqyA8yqWxZ/csfLCAe
         amTw==
X-Gm-Message-State: ACgBeo1ZgUlfhIXrGbRSqis88hWsEeJsPTyy64OzDpIxmmFEcNpv1VOS
        jgcWayPdP3pNF6PgCBz9a70SHYYZiDwUN4iHGPE=
X-Google-Smtp-Source: AA6agR49kQ/9mT6fOc3EnTMBQza3CnfVN2vZpHfpmf10lcp3w5kehCWvoRGRsVumYR9KpDwziy6Ksg==
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id gn15-20020a1709070d0f00b0073105c2a9a5mr13638747ejc.413.1660083165528;
        Tue, 09 Aug 2022 15:12:45 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090631d700b00722e8c47cc9sm1573901ejf.181.2022.08.09.15.12.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 15:12:45 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so119551wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:12:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr283826wms.8.1660082801459; Tue, 09 Aug
 2022 15:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <YuflGG60pHiXp2z/@casper.infradead.org> <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org> <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
 <Yu/RJtoJPhkWXIdP@casper.infradead.org> <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEgZuSdv8XHtkJg@casper.infradead.org> <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEuIg3669UeSwjD@casper.infradead.org> <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 15:06:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiivNAj+jdXUdo91PQgh__vtE3WCFgufV0yVu7mWAKQWg@mail.gmail.com>
Message-ID: <CAHk-=wiivNAj+jdXUdo91PQgh__vtE3WCFgufV0yVu7mWAKQWg@mail.gmail.com>
Subject: Re: [PATCH v6] add barriers to buffer_uptodate and set_buffer_uptodate
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 11:32 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Let's have a look at this piece of code in __bread_slow:
>         get_bh(bh);
>         bh->b_end_io = end_buffer_read_sync;
>         submit_bh(REQ_OP_READ, 0, bh);
>         wait_on_buffer(bh);
>         if (buffer_uptodate(bh))
>                 return bh;
> Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
> Consequently, if someone calls sb_bread and then reads the buffer data,
> the read of buffer data may be executed before wait_on_buffer(bh) on
> architectures with weak memory ordering and it may return invalid data.
>
> Fix this bug by adding a memory barrier to set_buffer_uptodate and an
> acquire barrier to buffer_uptodate (in a similar way as
> folio_test_uptodate and folio_mark_uptodate).

Ok, I've applied this to my tree.

I still feel that we should probably take a long look at having the
proper "acquire/release" uses everywhere for the buffer / page / folio
flags, but that wouldn't really work for backporting to stable, so I
think that's a "future fixes/cleanup" thing.

Thanks,
              Linus
