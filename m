Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242F4C1D56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiBWUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiBWUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:50:31 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF534DF62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:50:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p14so54892473ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToP7+u5TAIA1n+un4iO9944/Fjm/9qjoDI5PHB1SdbA=;
        b=K1sL+JK8G+5oEKb2E8fAwrSR5os84QIowAVzA3JAWOyiezYS97zbR3Od2bvOKCG/Ya
         kHJfrEiaMRcfMYUW2C/o5y0GvbP0W+EtqpZMZu8JEGyXGRnTf4DiKlI5Ivwjvx0CXlKh
         ANHqMVyaiR6CAY08j4pgEDEV47Qvbzqi34tlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToP7+u5TAIA1n+un4iO9944/Fjm/9qjoDI5PHB1SdbA=;
        b=nQupqDkl+FlREn5k+XupMSRhhjWkdXYpOTeoFFhYAtZYjGyl3I0IqgKn2exfd53FCU
         slDe9LE0yipaGAWA7t88v2OV3qJWkInuKor2iUKBryzyPTdWZ3ZUi8mxrmugs62DIIGE
         LEX+vDQr80kyXeg6wv+PfglF3jdGnbzMi2MPtSMyWxDbvZbfuJwQoX3MLxf0Lg76OQFv
         U0ZUrQh17VwLP+tki1VC8jTh7QwXCx+qbZXnqpQAjtPKREiIGBoh7beRWMxcBz7WgYP5
         OwsjtMo8KUmv9CjtTqqWMiJT+hAJ8fQlSwy/fh/O9WxW8Q83f85TX3gZ79Uj001WpZK4
         t9eA==
X-Gm-Message-State: AOAM533o3AfNLw5bXwfzTwD1BbkouNY3ASPgDeXbrD6E08/6apFoPp8H
        8ovXLnI6qv9xfjRYtko5YKLtk1Tov79FgDJbp7I=
X-Google-Smtp-Source: ABdhPJyv4hc+m2BMF40+wgZSzYWWmJmbWJ5wIigyKSwtoxnsvxjnKA4Aqp4R4JMothJSLlcsfqdF5A==
X-Received: by 2002:a17:906:b248:b0:6ce:556:52bd with SMTP id ce8-20020a170906b24800b006ce055652bdmr1093698ejb.479.1645649400816;
        Wed, 23 Feb 2022 12:50:00 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id 27sm309169eji.66.2022.02.23.12.50.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:50:00 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id o4so4815521wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:50:00 -0800 (PST)
X-Received: by 2002:a2e:bc17:0:b0:246:32b7:464 with SMTP id
 b23-20020a2ebc17000000b0024632b70464mr792954ljf.506.1645649006967; Wed, 23
 Feb 2022 12:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com> <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:43:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
Message-ID: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Wed, Feb 23, 2022 at 12:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I looked at the gcc documentation for this flag, and it tells me that
> it's default-enabled for std=c99 or higher. Turning it on for --std=gnu89
> shows the same warning, so at least it doesn't sound like the actual
> behavior changed, only the warning output. clang does not warn
> for this code at all, regardless of the --std= flag.

Ok, so we should be able to basically convert '--std=gnu89' into
'--std=gnu11 -Wno-shift-negative-value' with no expected change of
behavior.

Of course, maybe we need to make -Wno-shift-negative-value be
conditional on the compiler supporting it in the first place?

I really would love to finally move forward on this, considering that
it's been brewing for many many years.

I think the loop iterators are the biggest user-visible thing, but
there might be others.

And some googling seems to show that the reason for
-Wshift-negative-value is that with C99 the semantics changed for
targets that weren't two's complement. We *really* don't care.

Of course, the C standard being the bunch of incompetents they are,
they in the process apparently made left-shifts undefined (rather than
implementation-defined). Christ, they keep on making the same mistakes
over and over. What was the definition of insanity again?

                  Linus
