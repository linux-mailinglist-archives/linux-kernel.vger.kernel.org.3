Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962754911D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiAQWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiAQWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:39:58 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:39:58 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p1so33128357uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpZbjoW9GfJW4+8jBr4zAfs6RyDybUmQVG/QCo0k9S8=;
        b=AnBGBYjgUSE6Izs6p6fX4w1oP0IgTxG8n0ogqNbUG4Xizap3acTPptOE+RZzNk9Rba
         1CKWjFOVjqtdWelUD6XIYmMaiOb/UvIco1wR032bhDb8hwTlYQE+O2apFEO5pvoMUdRC
         truIwr7M+R9mmO8X/pvSM6KXu4wXDlOU2HFAihwNlwTuN4ytsrr4OZncLgE/xFnzdInv
         MM3q1nA1oqqFQerxLEbrxU39q4mf5PFbIwRUpG0Qv+1ZqAXgT/q8Fy/bRw1s3H8SlhXf
         ZVjW3fRyklPLFUlnVgrgmh0yWm8QnrCCzfQm0blG4IP96y/ujg9c5KGWELeshVV6bP89
         BS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpZbjoW9GfJW4+8jBr4zAfs6RyDybUmQVG/QCo0k9S8=;
        b=x+sGUgtnuwlTICjC6cCe89NJbCCOTuFVx0GF4NXhiPnu3uCSUfj2176IIxAxaerrlB
         Zp2PD+4yedoWe7owoHYB9mD+Zh4QFB/Fmk6peOeqvQPiRnaHbWWG/v0b6eu3GdHXTFbT
         /0LFfLtY4syEdCd/M3fHPQ3/nEMeqeAWb/+IpnYWF9ADgGFkFCLDxRDrC5zWOPxBXNMu
         D6aX/uwLhuaNAoH0oNgP6UgT76aQVLxDqZbQ1O+tLbM5wiWXfTSAPyMyDgmMLJ9z5WyI
         HriceD/T0E2CUQC9q9bOL6EkIO9yVrf81vW5JOzy/DHWpu2EPEI4b0sb54vpIYA1zG7r
         U/2w==
X-Gm-Message-State: AOAM533C1mrLJjwkgKpoqQiuGhk6Aiu8A3qSlM6n5uFcijwJUF8NslEQ
        VQ44bGpIUl30Aih+TEQ9xHGzP0HNH925L+72uvg=
X-Google-Smtp-Source: ABdhPJxeG/JXtaugQl/KAJWmvLA7pzV9IztBcg1JeYIgdXLEMyR9BlnDSH+0f0nQHXi0g8764zPCVxF5mLwtc8a46TA=
X-Received: by 2002:ab0:60d0:: with SMTP id g16mr8360518uam.121.1642459197378;
 Mon, 17 Jan 2022 14:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20220111143046.14680-1-pmladek@suse.com> <20220111143046.14680-2-pmladek@suse.com>
 <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk> <Yd7Fq6V1/Ynff6Qx@alley>
 <CAJfuBxzKZYBf_CGzHGjL_Jn2M=x_NH_j89kFX2UGxr8Sr4=fVw@mail.gmail.com> <Yd/kSVaFyn2/huaf@alley>
In-Reply-To: <Yd/kSVaFyn2/huaf@alley>
From:   jim.cromie@gmail.com
Date:   Mon, 17 Jan 2022 15:39:31 -0700
Message-ID: <CAJfuBxx2qhZgLX_XeAVe8jB-B1PF-j_v7=0k7UD=ShRwTxx9KQ@mail.gmail.com>
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 1:35 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2022-01-12 20:38:57, jim.cromie@gmail.com wrote:
> > On Wed, Jan 12, 2022 at 5:12 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > On Tue 2022-01-11 17:01:35, Rasmus Villemoes wrote:
> > > > On 11/01/2022 15.30, Petr Mladek wrote:
> >
> >
> > > > >  static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> > > > >  {
> > > > > -   pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > > > > +   /* Use raw _printk() to avoid cyclic dependency. */
> > > > > +   _printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > > > >     return 0;
> > > > >  }
> > > >
> > > > And for this one I think the solution is even simpler, as I can't find
> > > > any in-tree callers. Perhaps just nuke it entirely?
> > >
> > > Adding Jim into Cc whether he still has any plans to use this API.
> > >
> > > Best Regards,
> > > Petr
> >
> > This EXPORT can go.
>
> Does it mean that the entire function might be removed or just
> EXPORT_SYMBOL_GPL() macro, please?
>

the whole function and export can be dropped.
its a thin wrapper on static ddebug_exec_queries().

And apologies,  I thought Id sent this earlier.

> I am especially interested whether we could remove pr_warn()
> from the header file. It would help us the get rid of the
> cyclic header dependency an easy way.
>
> Best Regards,
> Petr
