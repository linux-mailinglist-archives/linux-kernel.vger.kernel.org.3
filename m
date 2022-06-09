Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D7544C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiFIMcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiFIMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:32:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522118353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:32:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h23so37753660lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfBdadjjVbuYsWcHjyT2JNkeKnRXZofpQUc3M0v3lw8=;
        b=ZuexHRJpNkArhkzlyVFzZzfvSGVG0EYbj1SnK7hExFfijK7WjsRYWBLE0IAgfsl2Zi
         MEyYD78r42eLMgaGkHPJR1S3gTnNwQnEllIN+QBILQnNTymZq4f19Yu/6jG5M503bWVv
         sTnn/1fbYfOfY6pb0CbXuakmf+f9jM1TKXottjCpAfvvenicMckun+zADDhluMOtEFEr
         Fltda09pvIbbAqK5WXQ/PojELjI4dNLYnujpwmEs+PosBQICQSiY48ZEGW61ag+09nDR
         naerd/Vk9Iwjla68zxr0uqMt7jTerwywgXFZ3UjNXRbXyEQGZgLfPS9674SbORQU4h6m
         PWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfBdadjjVbuYsWcHjyT2JNkeKnRXZofpQUc3M0v3lw8=;
        b=Il26Rr0jriFE7IGnTdmZvmvlbRQXwNRkAYyT2LOu/oGOgYvkWQ4iz+FQR1i2mq0aFw
         5C7VQ0eq/m0TjJds5ATYAYEOgVS3ZMs9/u7Rj/DKYLxjb7hTl1sRMxINQHyzjHSt7ynq
         IzFs/i8uPp8iWWxPFqw0/ZDcBDIthQnqToU1VDQLDFPqrwnfiLOHsTKPQ82ip5Cj+wMY
         Nz5hq9nWCcbuhkvfFRuSDCS8MRL26XkRAtMr26sGEiCjdxaQOwUo95iuvzJdbwf6a9ia
         p9oWuEhCjM9KXU20e47b3ofJx2qFpetKpw2MerxnRHEGif+1VrC1/NTUscmf0oI2xsIt
         dKEw==
X-Gm-Message-State: AOAM532bnxEMcPtNhtmW5efJaNS2iPFaNPTnxv0b1Up5yqLRVyfrR5cl
        +23Ji83RZwQ9HmZb1fY5rKO8/wSwxA6SZTV1T4/LSA==
X-Google-Smtp-Source: ABdhPJzLWjIsu++QNIx3qDCOGVcwgjQAzeuOsueKw0KOpXNjxn2Gz9hA0HmKib9smkmGcaOLoJgCB0QQYNMhpqx7BYk=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr24638097lfb.376.1654777931483; Thu, 09
 Jun 2022 05:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de> <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de> <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de> <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de> <YqHgdECTYFNJgdGc@zx2c4.com>
 <CACT4Y+ajfVUkqAjAin73ftqAz=HmLX=p=S=HRV1qe-8_y36J+A@mail.gmail.com> <YqHnH+Yc4TCOXa9X@zx2c4.com>
In-Reply-To: <YqHnH+Yc4TCOXa9X@zx2c4.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:32:00 +0200
Message-ID: <CACT4Y+Zf8=DgaAYfFWL==vbYF13omtMUGaP=LzKEbsuVzrTe9w@mail.gmail.com>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for per-console locking
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        bigeasy@linutronix.de
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

On Thu, 9 Jun 2022 at 14:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Dmitry,
>
> On Thu, Jun 09, 2022 at 02:18:19PM +0200, Dmitry Vyukov wrote:
> > > AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
> > > where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
> > > But nobody who wants an RT kernel will be using KFENCE. So this seems
> > > like a non-issue? Maybe just add a `depends on !KFENCE` to
> > > PROVE_RAW_LOCK_NESTING?
> >
> > Don't know if there are other good solutions (of similar simplicity).
>
> Fortunately, I found one that solves things without needing to
> compromise on anything:
> https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com/

Cool! Thanks!

> > Btw, should this new CONFIG_PROVE_RAW_LOCK_NESTING be generally
> > enabled on testing systems? We don't have it enabled on syzbot.
>
> Last time I spoke with RT people about this, the goal was eventually to
> *always* enable it when lock proving is enabled, but there are too many
> bugs and cases now to do that, so it's an opt-in. I might be
> misremembering, though, so CC'ing Sebastian in case he wants to chime
> in.

OK, we will wait then.
Little point in doubling the number of reports for known issues.
