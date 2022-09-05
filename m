Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311405ADA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiIEUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiIEUe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:34:58 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7A32EEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:34:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d1so7061920qvs.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LWWc9wTEKH9JOgE9QE9gnp320f8DJyBjkMZd1oJSX5c=;
        b=aUO5ZddJfxJ10nryf9XdZbQw1y2YSk+UHvlVfXgDO+BVJJSkhZpGJqMZ4fPB0/HqMU
         wSkCUn+/8z9Ud466Avg/II4gvMT/9nMnMyYgyvdaj0q20NtCoBrbhqZaoyp+CRyUwT5a
         Xun1cBn5kG6XI3oGSS507HAQaMaANellkpaeWOBxTrCCjeDpQPb2Sc8l/H1q3QakQ1WV
         3wR1Yqr4cC0dVIeocb8v8ZVq+fF3F4YyH+PxsUgjZdv1dcD/Si3Mm4H4GfVSAoCW0Wm/
         sKhxG9PpHmx2I9ALNQcrQC0TlY6tPs0u4zgDriCfI7tU8q50lJz7I6lUYdm4l5eAW3OC
         qKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LWWc9wTEKH9JOgE9QE9gnp320f8DJyBjkMZd1oJSX5c=;
        b=3KIdUe7z1uUeE9qKJlDAC9r8f1eFizB3VNgmUbmSszv+HkQDI1IxSiSPpsBXebiEpl
         nR3kIEJjAYErrMCLNTouOE38io4wGO1yejiyql/zu7mxvLQ7gQGOeYxnuW+lEaa7wmrS
         lOFIvwN1jhzBbudht2k97P9k/O/Ymp4eXelLtiFDEAesFoQ8ZBBGHfCWlmwT2TRXcwDM
         +SZla93s0HD+VC+c/4/LabggRIa/tTkOg7TdVRhki6SWfAow1/SWS97O1nJYHGgq4U1E
         P2YFWc0/QzF2DJEjYtgxFclpylsxkCnxKods9k+oNPgBtsrJZV8YS71OId94eBTm+1CH
         oWyA==
X-Gm-Message-State: ACgBeo23lbGI9QZUU5iApcb+6eRSFObsnOWoH0b+kdIRGTbd2rZwQGPV
        btRE5CsIYKB9UKjooBcaUAeCvMSSPMfuDZ9IFZg=
X-Google-Smtp-Source: AA6agR7OVjCdl5OSG5AINDybw+DNSQ5AiNnH9hQXLrz7NsLRRi1FvBfW3eJLPGV3ZUy3hPHY3ir0bx/BOKeVmgmSQJE=
X-Received: by 2002:ad4:5741:0:b0:4aa:4772:8835 with SMTP id
 q1-20020ad45741000000b004aa47728835mr2393789qvx.56.1662410089701; Mon, 05 Sep
 2022 13:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <4db564768f1cb900b9687849a062156b470eb902.1658189199.git.andreyknvl@google.com>
 <YurV+SDkF2dQCQLn@elver.google.com>
In-Reply-To: <YurV+SDkF2dQCQLn@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Sep 2022 22:34:38 +0200
Message-ID: <CA+fCnZeXEi1=fpNxUKLhwWJ=yeTFWLteKzDnLfwKFFC-uDbcHw@mail.gmail.com>
Subject: Re: [PATCH mm v2 32/33] kasan: dynamically allocate stack ring entries
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 10:09 PM Marco Elver <elver@google.com> wrote:
>
> > -#define KASAN_STACK_RING_SIZE (32 << 10)
> > +#define KASAN_STACK_RING_SIZE_DEFAULT (32 << 10)
> >
>
> This could be moved to tags.c, as there are no other users elsewhere.

Will fix in v3.

> > +/* kasan.stack_ring_size=32768 */
>
> What does that comment say? Is it "kasan.stack_ring_size=<entries>"?

Yes, will clarify in v3.

> Is it already in the documentation?

Will add in v3.

> > +     if (kasan_stack_collection_enabled()) {
> > +             if (!stack_ring.size)
> > +                     stack_ring.size = KASAN_STACK_RING_SIZE_DEFAULT;
> > +             stack_ring.entries = memblock_alloc(
> > +                                     sizeof(stack_ring.entries[0]) *
> > +                                             stack_ring.size,
> > +                                     SMP_CACHE_BYTES);
>
> memblock_alloc() can fail. Because unlikely, stack collection should
> probably just be disabled.
>
> (minor: excessive line breaks makes the above unreadable.)

Will fix both in v3.

Thanks!
