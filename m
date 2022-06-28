Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB255C72A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiF1ErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbiF1ErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:47:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14564D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:47:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id cw10so23269470ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKRmGyRbmPbpYMHg1O4vbVKpORj0jUhyWGskFyhwzGY=;
        b=Rb2JUfmWT4hO+HV0M84lp0uCxvI4n/eYH6RMPut4GOhNr9jqOc41Mxxe6srHwjzK03
         Or6+3nNApcPf8DQny1+/LWn8sQkG4VfazSNA2uZvyq/R++q5sotXuNUjTrWhg7c2QnJg
         THO79QsngMWu2Z5xvkDv1mkro6RquN/UjEgcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKRmGyRbmPbpYMHg1O4vbVKpORj0jUhyWGskFyhwzGY=;
        b=0pt/pvJEUb4iTGhl5ODiSksqksg+Jzz1lF7KKxdidN7G+FOa1O6/SWD1azVWboJoxk
         VOsISQxiZnX8H1U64UCb1Vudne308hi1CPEj82HQ/6g+aFnKGaeGbOW/sppgmH0Sv3XZ
         RxoqiEtRQJYEVfM+sYa3ZpiDJN3gkp6kdafFTk5UwkoMWLlVFgFwLlR3k2w+TDqh1/eR
         3Kmo1BcWpf5GswHYkBk4MY4hsSaw1GlDShaQtKoVFKO8Uq94ZaDrXS6XwZ1qxVdXrQBP
         T9AJ/e1RKOrsm9+dxzLmi7gNEuhghGWWVjIxPv5LL0arKs0GEt2vNJq8gY0XwirkaoGY
         D+yw==
X-Gm-Message-State: AJIora8RJllmxcrtK6BbEkRojjYyLfUdSuYQsb3NHrmp+0EukMF0PyT4
        JXcW2IEAxrF7BdkrBlirYIsXMAINvHxfFLh0avk=
X-Google-Smtp-Source: AGRyM1u1arsQ2VUXGVywsZcIqGJQ4MvDp/bqBoVA+oQdFtbL+DVb7a2Abjre/cs4Eyl+BF7O0Jb4EQ==
X-Received: by 2002:a17:907:1693:b0:726:4322:c330 with SMTP id hc19-20020a170907169300b007264322c330mr15213877ejc.9.1656391623722;
        Mon, 27 Jun 2022 21:47:03 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906381300b00721d8e5bf0bsm5896048ejc.6.2022.06.27.21.47.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 21:47:03 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so455006wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:47:02 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr23684632wmn.68.1656391622410; Mon, 27
 Jun 2022 21:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220628032439.3314451-1-kent.overstreet@gmail.com>
In-Reply-To: <20220628032439.3314451-1-kent.overstreet@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 21:46:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com>
Message-ID: <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com>
Subject: Re: [PATCH v5whatever, now with typechecking] vsprintf: %pf(%p)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>
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

On Mon, Jun 27, 2022 at 8:24 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> Linus, here's an updated version of the patch implementing %pf(%p) that
> implements your typechecking macro and cookie idea we discussed

This still has a fundamental problem: you insist on that double '%p' form. Why?

That makes no sense when to a user, there is only *one* value.

A user will ever see two values, because you should probably never use
"CALL_PP()" (which is a horrible name anyway) directly.

You'd presumably either use a per-type "print_dentry()" kind of
function, or it would all be hidden by a macro that does _Generic() to
match up the right pretty-printing function based on the type of the
pointer.

IOW, your "CALL_PP()" macro is something disgusting that normally
should never be visible to any user. The real use might be something
like

   printk("%pf\n", pretty_print(dentry));

where all the magic is hidden behind that "pretty_print()" macro.

End result: that "%pf{%p}" format you have tried before is entirely broken.

And that's what I tried to tell you earlier. There should be only one
pointer, and there should be just a "%pf". Having two '%p' things is
just wrong. It makes no sense to the actual use-case that a user would
ever see.

And there is only one pointer argument in the ARGV array too, because
the way you'd actually then implement pretty_print() would most
naturally be something like this:

    #include <stdio.h>

    #define __PP_MAGIC (0xdeadbeef)
    struct pretty_print_struct {
        unsigned long magic;
        void *fn;
        void *p;
    };

    // type warning *and* link-time failure
    extern int not_a_pointer;

    extern int pretty_print_int(int *);
    extern int pretty_print_long_long(long long *);

    #define __PP_FN(ptr) _Generic(*(ptr),               \
        int:            pretty_print_int,       \
        long long:      pretty_print_long_long, \
        default:        not_a_pointer )

    #define __PP_CHECK(fn,ptr)  \
        __PP_MAGIC+(__typeof__ ((fn)(ptr)))0, fn, ptr

   #define pretty_fn(fn,ptr) &(struct pretty_print_struct) \
       { __PP_CHECK(__PP_FN(ptr), ptr) }

    #define pretty_print(ptr) pretty_fn(__PP_FN(ptr), ptr)

    void test_me(int val)
    {
        printf("%pf\n", pretty_print(&val));
    }

Note how at no point does something like the above want two '%p'
entries in the printf string, and in the concept of that line that the
programmer actually uses:

        printf("%pf\n", pretty_print(&val));

there is only ONE value as far as the user is concerned.. Ergo: there
should be only one '%p'. And the compiler only sees one pointer too,
because we hide all the metadata as a pointer to that metadata
structure.

And obviously, the above is silly: the above example is doing
ridiculous types like 'int' and 'long long' that don't need this. For
the kernel, we'd do things like dentry pointers etc.

And maybe not all users would use that "_Generic" thing to pick a
printout function based on type, and you could just have special-case
things, and sure, you can then use

        printf("%pf\n", pretty_fn(mny_dentry_print, file->f_dentry));

and it would do the obvious thing, but it would still be just one
pointer as far as "printf" would be concerned.

(I did test all of the above except for the 'dentry' case in a
compiler to see that I got the syntax right, but then I ended up
editing it later in the MUA, so I might have screwed something up
after testing)

             Linus
