Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8525A15F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiHYPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbiHYPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:40:03 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53D413E2B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:40:01 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-33da3a391d8so138530037b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fEQ1d/PiEHzLrmSBXGQT2W8YpNnPcaA3hRqhgrIy1b8=;
        b=F6xZURA7pUQy2v+UOwJV2SRBjGEut5CjaZ/xUi6FcIumRsvYr32tRVL6VK+/rlWoHx
         UKx7ihhTtIGPsJeDPQVAQEqpER/3I2NT7tZlDZC4342uPPCsBBM1YcMyvgFJt6lwqFlg
         XN1YHVnBy2JZYsszV+IWYwr61w2KwdeOfaIX6yxyLJ1JC7QX1BLYGCe4hxspikhXhs72
         LlOib55bwcEUaEKQmiCFgRQGvJCMgcZvugoncnNXcdNedyHR/+G7DB7ZUsduO3p+lKEL
         GVa8yILjJVx66GDhOZPVLdOghZ5Desu4mTb7XjFYxcPVXMxvEn3d9VGqQtRRWIFhkS+C
         5nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fEQ1d/PiEHzLrmSBXGQT2W8YpNnPcaA3hRqhgrIy1b8=;
        b=MRq7HrY+YReWT1sQ1qEPGekGRP5R6eJG+lH7o2Ew5Oq1jSRkKWkszbftpcteTakhng
         WT1D2Q576zG5nD6aX6V24BwSnmx0E3PI2DyTPYPV1GhU0QHmRU+u5ZABeJXzV3acFk4l
         /5SiE5BY35xbYi3GrR92NoW1zI5JbFn9osMp73/E3uozLqG/NEK211YhzjM+Aq8GtLvA
         5I3t56CpfZ5dnfiAd3CAIo7hEnJnGnrzziabsedrFjXODjF5ln08fwFR2+QVA/a+zbYG
         f+Up7nlWwyri1pGa7L0C29/fSHgY2A2IWNOcMT08FAkQ7AM7QtAYpjai2ReTqj5WSBq6
         OWTw==
X-Gm-Message-State: ACgBeo1TzY2JJP4+8hgcNnrODLaY6XfXzmAyGdu5a3xgPrhRwFHCbrsa
        uMIrX+QZ+iXqGsg9V1m+axejl1D/bkzRlpclJkcPlg==
X-Google-Smtp-Source: AA6agR55v+DLet0yiWWCE94xVChePy5VsoHxFJfjQTURDicCdiaaIP6NeIPTzH3NruHqxBu+qCXcRybcS1En38eDdqc=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr3870021ybl.376.1661442001024; Thu, 25
 Aug 2022 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org>
In-Reply-To: <YsNIjwTw41y0Ij0n@casper.infradead.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 25 Aug 2022 17:39:24 +0200
Message-ID: <CAG_fn=VbvbYVPfdKXrYRTq7HwmvXPQUeUDWZjwe8x8W=ttq6KA@mail.gmail.com>
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
To:     Matthew Wilcox <willy@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
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
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 10:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 01, 2022 at 04:23:09PM +0200, Alexander Potapenko wrote:
> > Functions implementing the a_ops->write_end() interface accept the
> > `void *fsdata` parameter that is supposed to be initialized by the
> > corresponding a_ops->write_begin() (which accepts `void **fsdata`).
> >
> > However not all a_ops->write_begin() implementations initialize `fsdata`
> > unconditionally, so it may get passed uninitialized to a_ops->write_end(),
> > resulting in undefined behavior.
>
> ... wait, passing an uninitialised variable to a function *which doesn't
> actually use it* is now UB?  What genius came up with that rule?  What
> purpose does it serve?
>

Hi Matthew,

There is a discussion at [1], with Segher pointing out a reason for
this rule [2] and Linus requesting that we should be warning about the
cases where uninitialized variables are passed by value.

Right now there are only a handful cases in the kernel where such
passing is performed (we just need one more patch in addition to this
one for KMSAN to boot cleanly). So we are in a good position to start
enforcing this rule, unless there's a reason not to.

I am not sure standard compliance alone is a convincing argument, but
from KMSAN standpoint, performing parameter check at callsites
noticeably eases handling of values passed between instrumented and
non-instrumented code. This lets us avoid some low-level hacks around
instrumentation_begin()/instrumentation_end() (some context available
at [4]).

Let me know what you think,
Alex

[1] - https://lore.kernel.org/lkml/CAFKCwrjBjHMquj-adTf0_1QLYq3Et=gJ0rq6HS-qrAEmVA7Ujw@mail.gmail.com/T/
[2] - https://lore.kernel.org/lkml/20220615164655.GC25951@gate.crashing.org/
[3] - https://lore.kernel.org/lkml/CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com/
[4] https://lore.kernel.org/lkml/20220426164315.625149-29-glider@google.com/
