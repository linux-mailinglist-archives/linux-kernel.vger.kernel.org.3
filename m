Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82FA4C1D65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbiBWUzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiBWUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:55:35 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DAC4E3B1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:55:06 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e2so23089396ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si7AL42ZuEkVrfiwamYcHieHO/8AUiwawUmyYL9iblE=;
        b=B1SDugO2vfy60lWlBgpH1fmDo//8I/Kk5ECqxfCvk6Dd78O1zwDRkUy6yEngCcSm2Y
         QLuJReCp7lCrHgKRQ7/EBEjJvHXtPOGHquG0zKFDYQt2fOO7fMJ2yGliuKb848Sj9VLX
         FUrC/AymzuR/j1+hK2zjmg53bV4WzqYFgTET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si7AL42ZuEkVrfiwamYcHieHO/8AUiwawUmyYL9iblE=;
        b=D+inCzN7R/m6uGkSr4KKUfF2QardeB9h9KMKvBAJEjfiJA1R+ujL04P8VYpsryW+OQ
         n0toBkJXUIYj/BpP5RWgPVwXFTZcHhRW8KaAMV3T8MER8VzgyVjc5zIC2KtHbYtH9uCT
         qpvuhPqXfvYPYzAqXCBDO/gOs8GGsWqN/23TvPsiq6rnpRfkFdP+k1Y4T4fHiyoX6eWA
         uV8etBdcJp6edPZh6XxIhrfifLZo91JcnF2lSYM6JMY7+mow9bn8H9uWmHSEiCLrqgLD
         dAgBdEdJnz5dz8S2+HKwfJrgYNMi/j0tUiqEcHKdmH6Igi8tbhlgqINFJ3DGwI/MvUqS
         eVmA==
X-Gm-Message-State: AOAM530ymWVgg4rIHfpNwd5bnSRU4I38nJZWvd6m63tSF8N+wBKk6WMR
        N89mz6IvKK90QFSqn1V3xu+0oE/8aYKBMVmulN4=
X-Google-Smtp-Source: ABdhPJz1s6lwEeZK017dSdQH6aEiGnPlzWMi6+PrTdKDijVnjMT41Y2oINtteJxLuR655pFa+rPImQ==
X-Received: by 2002:a2e:aa18:0:b0:244:bb00:db39 with SMTP id bf24-20020a2eaa18000000b00244bb00db39mr809404ljb.341.1645649704959;
        Wed, 23 Feb 2022 12:55:04 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m7sm90650ljb.87.2022.02.23.12.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:55:02 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id y24so437477lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:55:02 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr933476lfu.27.1645649701759; Wed, 23 Feb
 2022 12:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com> <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
In-Reply-To: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:54:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
Message-ID: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 12:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, the C standard being the bunch of incompetents they are,
> they in the process apparently made left-shifts undefined (rather than
> implementation-defined). Christ, they keep on making the same mistakes
> over and over. What was the definition of insanity again?

Hey, some more googling on my part seems to say that somebody saw the
light, and it's likely getting fixed in newer C standard version.

So it was just a mistake, not actual malice. Maybe we can hope that
the tide is turning against the "undefined" crowd that used to rule
the roost in the C standards bodies. Maybe the fundamental security
issues with undefined behavior finally convinced people how bad it
was?

            Linus
