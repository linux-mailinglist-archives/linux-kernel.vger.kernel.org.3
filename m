Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B90481F73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhL3TLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbhL3TLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B99C061401
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:51 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id j6so19562005ila.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpkNpBZChdk2znmZ7eLMiI56h6rQ1/cUXgZFrI/xFps=;
        b=lxXkzKjFJ0nxku9/h24bDeYEyUL1VPgqqWQ7/ckW2iFrINszSwFHyqwxlrPgUwgtT7
         MJdXMTCJ3sCwTCNaGwe6vW7b68w9gzfzlATTFarip6xH97PrztP0I7IUvGht8Cux3pfq
         JU83QnneQXCDG0HPnuEiThMvobp9q/AX5xnOd7Y5PcXa0/mbuMPyf2R2/1OTnbOeI4Qe
         nyttVu47jl3KlWvIywKaFKe/R9qC4kTvFraNuYna0r5TMEVqmtX8rZdL9SOmokEr8NkH
         cvV+sSywY+AU07F2CXZpKyxFN0iLA53KvqQk4b5smzgUHI2n50npdfoFE9zmHnLNlQz1
         X85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpkNpBZChdk2znmZ7eLMiI56h6rQ1/cUXgZFrI/xFps=;
        b=3SrDg9z0bYlll56G3mOFvzwtgaWaYOyfMdynbbOOssiUi7Ge1FBGEYg6oA+8bSWRsO
         l0VmHwGTfS/+uXE7tRscSmTmfu6Y9NthypZ7A/Y0zcEs3K6PnpZitngD8ag8n50zWTt6
         W3b2EOe744MZqy0udanbtlpBdOOfTdoiwg0oddeJFTNOyiyvwrG1tH1DWK1ElYRTABhf
         wPr0nmA3mivA0k9cLSf2yr+1WfOmRkPpbJTKBdP9Qa/FYUMAq4AIS2kMYPAKeNUmChRP
         dOqooZ9UrhQeu9RAxonqtVglGxRy73ouBPuIH9QbAGdqkVfFjZnuf3JVRfykOq0dNKjH
         F5Uw==
X-Gm-Message-State: AOAM532xb5WhIkgNqdyS31iusdctTQuUkolQfhsesq/WNNVQiB6dl6vW
        yXDfTS1zICtbfrE8tQmn91Zcycnm4FjupSnWTcU=
X-Google-Smtp-Source: ABdhPJzTiHAyPgF/yyKSVpYwndlbUlWHPue339NuameRqVWwLoZmstPwWNoLL0x6VEFnkQOYMKxTA9aw0mLEIYD54xY=
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr15620663ilv.233.1640891511371;
 Thu, 30 Dec 2021 11:11:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <f7e26047d2fb7b963aebb894a23989cd830265bd.1640036051.git.andreyknvl@google.com>
 <CAG_fn=VUBm7Q74u=U29zn3Ba75PsQNsObqjcH_=14cosGU8bug@mail.gmail.com>
In-Reply-To: <CAG_fn=VUBm7Q74u=U29zn3Ba75PsQNsObqjcH_=14cosGU8bug@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:40 +0100
Message-ID: <CA+fCnZd-Z6ySi0dqkZjgEfD2sRDvDiHc5bgxDF=x_yB1+kOLJw@mail.gmail.com>
Subject: Re: [PATCH mm v4 35/39] kasan: add kasan.vmalloc command line flag
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 3:43 PM Alexander Potapenko <glider@google.com> wrote:
>
> >
> > +       switch (kasan_arg_vmalloc) {
> > +       case KASAN_ARG_VMALLOC_DEFAULT:
> > +               /* Default to enabling vmalloc tagging. */
> > +               fallthrough;
> > +       case KASAN_ARG_VMALLOC_ON:
> > +               static_branch_enable(&kasan_flag_vmalloc);
> > +               break;
> > +       case KASAN_ARG_VMALLOC_OFF:
> > +               /* Do nothing, kasan_flag_vmalloc keeps its default value. */
> > +               break;
> > +       }
>
> I think we should be setting the default when defining the static key
> (e.g. in this case it should be DEFINE_STATIC_KEY_TRUE), so that:
>  - the _DEFAULT case is always empty;
>  - the _ON case explicitly enables the static branch
>  - the _OFF case explicitly disables the branch
> This way we'll only need to change DEFINE_STATIC_KEY_TRUE to
> DEFINE_STATIC_KEY_FALSE if we want to change the default, but we don't
> have to mess up with the rest of the code.
> Right now the switch statement is confusing, because the _OFF case
> refers to some "default" value, whereas the _DEFAULT one actively
> changes the state.
>
> I see that this code is copied from kasan_flag_stacktrace
> implementation, and my comment also applies there (but I don't insist
> on fixing that one right now).

Will do in v5. Thanks!
