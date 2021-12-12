Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27812471CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhLLTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLLTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:33:23 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E9C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:33:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so28362184edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pljls+26iqXs8586OeHQW1pbrGyYEa1Rh9wwbuHdgrs=;
        b=E5i9G4gN+surlpqIyILHSsMEUvb+guvBn/ai49HLSV3WgAUOa58O8daZh0yeq/XF5N
         33umFap1Af1L8VyMoYgqJImL3RwQfmCy6OgGmxPAB3Sr0Hw6Ef8OSH1uEzz1rHCWBXiY
         0uqUaFStR7fYrJL69xYGWf/DRk+zyGqVJlgyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pljls+26iqXs8586OeHQW1pbrGyYEa1Rh9wwbuHdgrs=;
        b=qFBsbYGli4l6D6nA8CULz7wdAWxQbqwmKLnQS0ySQjIgHNdXOD3t+ZObN5eQkG7zA5
         DI+Fy/Zmgsr4Io7Nlgl/L/VQZ/jHlJR8s1eYO6TNKxiGLxqSWTi6Lzo824lMm84ETN9M
         MLV0ABODf9YgV8eScCV+fJM47n/hT/O6vt0YWWi1QOuVi+aD2NXaSPsry1q5ZljZmd2s
         xN8tyxLfVIVHTBejZ0NMzsKtZCV1z6Ah8HafPOVtMRC22JYm2auR/c4l4k6L0MxVVzxl
         P1Hl7k4lGJiFumdfnFXxvrGRgruWnXB1wWkHrAiSrtjmr/3kXAByaXCP9kKjs3gEUYnx
         OyEg==
X-Gm-Message-State: AOAM5321uqFutKGD3wY+uwRg0IurrqdaTEqJOb2cDeoyxteHkxnkywbx
        9M+EudaxtX/niPPRJ2yK2UkjiKIVeGfmNHC7
X-Google-Smtp-Source: ABdhPJylH5a2k8AqDkvSXMYGWK2KLD5i6Bs0fNQQ+/u7Z/DHsNIZ+st5KdQIcCiXVSFCt3/mxvBdmg==
X-Received: by 2002:a50:ee96:: with SMTP id f22mr57564605edr.77.1639337601648;
        Sun, 12 Dec 2021 11:33:21 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id g15sm4802144ejt.10.2021.12.12.11.33.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 11:33:21 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a18so23753320wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:33:21 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr25727225wra.281.1639337600994;
 Sun, 12 Dec 2021 11:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
 <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
 <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com> <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
In-Reply-To: <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Dec 2021 11:33:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrqh1bVQk2j+wMHtukUCRxMBH=Tz3bbRm25=RM67GMRQ@mail.gmail.com>
Message-ID: <CAHk-=whrqh1bVQk2j+wMHtukUCRxMBH=Tz3bbRm25=RM67GMRQ@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm not sure this can happen currently (maybe all tools effectively
> make it so that the ELF headers etc are part of the loaded image).

Side note: if that ends up being the case (ie e_entry always
effectively relative to the head of the image), then I think a better
fix would be to make that explicit, something like

        if (elf_ex->e_entry < header_sizes)
                goto out;

but the logic on exactly how things get loaded is so messy that I'm
not sure just what the situation is.

We've had things like old tool chains generate messy binaries before,
to the point where we've had to revert much more important changes (ie
the whole mess with MAP_FIXED_NOREPLACE and overlapping sections).

                 Linus
