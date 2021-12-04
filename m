Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560EC468658
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355388AbhLDQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355365AbhLDQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:56:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D41C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:53:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so24439893edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLxsYVhxp8kc6YMducknuw0Thmrn67yEeEH0fvOg79Q=;
        b=dYml2e6b1/2yUxtumtq1wCDHEHpViPjaXkLJZuvbCYNcd1mB2oZRtxhd/NOrrQZwPa
         su9obZKSQkCReBQgmeeMTf7GYYITRAdrqL/GuxniUdEMiSf6t1nyn5cCaJWBPVEwQZZ8
         vp+fr2vrhw8rMb7JcSt4KhVasin4xVoWXxXFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLxsYVhxp8kc6YMducknuw0Thmrn67yEeEH0fvOg79Q=;
        b=LsLHl4djOH/M0PHGevt50ORNwyxn6GcbA1sI+Yd9Cait/Os3QWbatw8EcvIQG3R+ej
         rjQLywH8vIHYZ2ckSsuWOEOu2cAnsWlxTPalj1HUWNtFebCAoLbyYWN4uFEaIdEk+XGo
         1UT4EU1tqvy4ug/szsQHoEaCvYxjA1/YC652+f8pNvDjLbxzMn4g/MF4aJh3myovWA2f
         Zjg6UU3JGdsu2Q7/EHB9SV/1f4PsQ9ntoU0xqtXC9zgsewsOT7hwxHIoz5n54jGuLyOt
         P0actD9m853mBzFHIKTTnpYveJLM9Y9GEeEGs7DqGr4Aykua9vFSSzjLCyi2JkoHhvgW
         kVCw==
X-Gm-Message-State: AOAM531M/1HH0ee9ijaAvKChH00rkXoTq9/cpTEIxOu5pjKO1zHhn1RJ
        6K1kPmAnJmdOJzc3Ol/LDbKCfK3N5SJ6zsEk
X-Google-Smtp-Source: ABdhPJykgkkC/JaOiWRZhJkORP1rCPpK4FXOtzIl0DgcTs1DhT8VUSCf5yXqsWJtusnhSKXRms7k6A==
X-Received: by 2002:a17:907:1626:: with SMTP id hb38mr32906928ejc.481.1638636784447;
        Sat, 04 Dec 2021 08:53:04 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id lk22sm3994443ejb.83.2021.12.04.08.53.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 08:53:03 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id c4so12647620wrd.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 08:53:01 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr31156174wre.140.1638636781618;
 Sat, 04 Dec 2021 08:53:01 -0800 (PST)
MIME-Version: 1.0
References: <YatpectAYsWnmPy2@eldamar.lan>
In-Reply-To: <YatpectAYsWnmPy2@eldamar.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 08:52:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
Message-ID: <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to gcc
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 5:13 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Andreas suggested to replace the
>
> KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>
> with
>
> KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))

Ugh. I think the external build environment is a bit broken, but
whatever. The above is ugly but I guess it works.

Another alternative would be to make the Kconfig strings simply not
have '"' as part of them.

When you do

    a = "hello"
    print $a

in any normal language, you generally wouldn't expect it to print the
quotes, it should just print the bare word.

But that's what the Kconfig string language basically does in this
case. And I guess several users expect and take advantage of that ;(

Masahiro? Comments?

             Linus
