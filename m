Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86F2578DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiGRWlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiGRWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:41:20 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FA2D1D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l14so7518207qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hV04gJeXIMaTZ1Jk1N+nIbNrqJFTcRn2y0JfEOihkw8=;
        b=IROMFuz2/wOa2pL4mKbRGtySWdHOHRt4GrNKKn7Bza52koex4HrozURD5wdH+F41eV
         sR1WHq/Pul3QucGfIc5ruREk7iz0G5aYq9Ud/i5KDg0WpZLVvKV76ej/SmlXqsmG14cW
         WU9VyBC5wMDUiqu/U7QOigzKsG0LDYMQHYsjJosW96Br9K81jsoXhubNWcclf5LGzLNi
         /usskXzsOp03JBmav0nT+tn9iYe3tgZ0LsDeWyBjb+RWuxtGFfrwD0uVmtzenKsRws3N
         USWWtZNslYoqp2iYySx8oLR3I+tzS9lZL1a0m5nNXKwUM/P7Hz6tcJ9nz/gS9LXfKXgj
         kVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hV04gJeXIMaTZ1Jk1N+nIbNrqJFTcRn2y0JfEOihkw8=;
        b=mZpsYWTr0OPHX6ciif145Eliu/nRqYAxLKCO2K1E3c/E6gHCgsOEy02L7zBQWxdjzN
         wXkb1UBm5cenHycxnnvnwL/U4uyt0FXtLEL3R3T4bvISayvErlby2PDSpLRvHfbi2B4l
         z27nnpSvNDT6sEaNkCqyBgA4D2jyQWdmNTKyQAXtvfi4AAUuXHCJ5yDcuMeorc5bGYvZ
         reYEk12zwzxd2CTiXjdPe3Uc+WHBJcWDABmuD1wut672qKdUan+NsgQAv4v+AWKqXDCn
         oxI0hFJS3xob8sZ7JA40E6lUwggHex+DFd3UejKuQL1xM9kNfcekjeT7zUv6FnT3NwDA
         LvFg==
X-Gm-Message-State: AJIora8IK5r9XWugE1xaamqMz0V6Z3nzxHflTQ9EkTDAHbaR9FuQNYme
        mbuEfQJA8fxiX/6ID4BqKgQd3u/chTgRUTX5wtc=
X-Google-Smtp-Source: AGRyM1vWIRiBCEPaEu8ccu39ek+Op1bAr/9W70rRJyLmqPHafkxRKLHee0UwfKZbMu3aGVJ9euW8FrT3myOm2u/eQgw=
X-Received: by 2002:ac8:7fc1:0:b0:31e:c575:a56c with SMTP id
 b1-20020ac87fc1000000b0031ec575a56cmr22857594qtk.11.1658184078807; Mon, 18
 Jul 2022 15:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <YqxKQpjJMwUCpbTt@elver.google.com>
In-Reply-To: <YqxKQpjJMwUCpbTt@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 19 Jul 2022 00:41:08 +0200
Message-ID: <CA+fCnZdsn1yRR9Ekzg9vpWjUw7F2E16RSo4B0cXbAb7PYo0SiA@mail.gmail.com>
Subject: Re: [PATCH 00/32] kasan: switch tag-based modes to stack ring from
 per-object metadata
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

On Fri, Jun 17, 2022 at 11:32 AM Marco Elver <elver@google.com> wrote:
>
> > The disadvantage:
> >
> > - If the affected object was allocated/freed long before the bug happened
> >   and the stack trace events were purged from the stack ring, the report
> >   will have no stack traces.
>
> Do you have statistics on how how likely this is? Maybe through
> identifying what the average lifetime of an entry in the stack ring is?
>
> How bad is this for very long lived objects (e.g. pagecache)?

I ran a test on Pixel 6: the stack ring of size (32 << 10) gets fully
rewritten every ~2.7 seconds during boot. Any buggy object that is
allocated/freed and then accessed with a bigger time span will not
have stack traces.

This can be dealt with by increasing the stack ring size, but this
comes down to how much memory one is willing to allocate for the stack
ring. If we decide to use sampling (saving stack traces only for every
Nth object), that will affect this too.

But any object that is allocated once during boot will be purged out
of the stack ring sooner or later. One could argue that such objects
are usually allocated at a single know place, so have a stack trace
won't considerably improve the report.

I would say that we need to deploy some solution, study the reports,
and adjust the implementation based on that.

> > Discussion
> > ==========
> >
> > The current implementation of the stack ring uses a single ring buffer for
> > the whole kernel. This might lead to contention due to atomic accesses to
> > the ring buffer index on multicore systems.
> >
> > It is unclear to me whether the performance impact from this contention
> > is significant compared to the slowdown introduced by collecting stack
> > traces.
>
> I agree, but once stack trace collection becomes faster (per your future
> plans below), this might need to be revisited.

Ack.

Thanks!
