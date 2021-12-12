Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE32A471C7A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhLLTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhLLTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:15:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B41C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:15:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r25so45210681edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIAse5+6UIu1HuzjRGxDkX+VOPGcXj2hq8cGY4h8w60=;
        b=M8uhNHDyCM/sAGnTd4rsevLnD27bIxhJBvKdjP0UkJUPmJNsMt41BLZdx4mUkFz6JO
         PNy6p5JEhFolk1dO+usefdRS73yO1+ZvB7pVG9fAhK3+w2RDwi9StrAK0EKjHcl8eyUU
         mSxbbR4Lyshxc6HjL044yeX5REWjFwbE3qNBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIAse5+6UIu1HuzjRGxDkX+VOPGcXj2hq8cGY4h8w60=;
        b=4+sqbP+QNOvMPOCFt2rsMBQhmqoCKp+W/pBVUqqXYb9rx/I2+3Z8fwtA/YeRer47GZ
         4a6Op6/x1/TYNvS4DlHE4VyoSOCCxsboKp22PYu6PRdhuYd/x2e9KT9sIQ0IlCV+1/X3
         ISClKUQWnqGDrkKz7B8g9vtWJK1MLoaQ+uflNe06Ra8TH7npQ62KXE4vC72+kYJMT6Hr
         XYONsPE57/xtRG4lJkrCHmL+9yM/MkQ6XhETypNd6A40/RCnF7Kk/2pVuTM4qDLwch6d
         9k0miglKuQz48zJm9ThqtX9xTR2GFRgq9Oe8dqde3/QlBbiO7skxD74ml+SaIu4SEdtK
         jLdA==
X-Gm-Message-State: AOAM5313PT0e1omYfgB7LRoCZXBVggDWIb5SU0IwdgyJJENwPArGyvGx
        h0QPY/u+BNHff2frDtSacRiRPUli0lyHXFNB
X-Google-Smtp-Source: ABdhPJwb6VhqOBQtSvDgXx+i7Tfr9uVIVFPkjqAURGTvp0hIzC+gknarvi+SzV/xDR/fl5XRmHDDfA==
X-Received: by 2002:a05:6402:169a:: with SMTP id a26mr58653467edv.292.1639336553935;
        Sun, 12 Dec 2021 11:15:53 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id p13sm5036372eds.38.2021.12.12.11.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 11:15:53 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so10291502wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:15:53 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr32254279wmd.155.1639336553322;
 Sun, 12 Dec 2021 11:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
 <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com> <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com>
In-Reply-To: <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Dec 2021 11:15:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
Message-ID: <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:06 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> According to the ELF specification, zero entry point value means
> there is no entry point.  Such ELF binary doesn't conform to the
> ELF specification.

Nobody cares about paper specifications.

All that matters is REALITY.

So let me quote my email again, since you clearly didn't actually read
it (read that "maybe it's not supposed to work" part):

> That's not my main worry - what if somebody has a code section with a
> zero vaddr and intentionally put the entry at the beginning?
>
> Maybe it's not supposed to work by some paper standatd, but afaik
> currently it _would_ work.

I'm not sure this can happen currently (maybe all tools effectively
make it so that the ELF headers etc are part of the loaded image).

But no, paper specifications have absolutely no meaning if they don't
match realty.

And the reality is that I don't think we've ever checked e_entry being
zero, which means that maybe people have used it.

So convince me that the above cannot happen. I'm perfectly willing to
be convinced, but "some random paper standard that we've never
followed" is not the thing to quote.

             Linus
