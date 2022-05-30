Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF048537831
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiE3Jhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiE3JhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:37:15 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53776291;
        Mon, 30 May 2022 02:37:13 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f7so771100ilr.5;
        Mon, 30 May 2022 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ueNItYj2IC9D3zs28drSgPYCsB+eIJFzInbZyJE4LMU=;
        b=OX9h2LakIzHNEFy+NFyqg+Uw0oZwl5s13uAynIQOTJ376V6NocwwMgBQ5CEsGAbUD1
         O6PylJkNGxOSZYQXlQ94OL8GwJM+Lhga4G2bmnTRPE71c3Z9P5DKnMeyfpxnQoc8lC86
         IPeqLNdhvjBKMTqZKdhthnMCkhvAhqYa4Z78IjpN1r+/S7WI/FG91lxFxwkv996UF9Qx
         RQMaMGZj4wE4X8Mzp7ReTrDBuBXobgEIuKe1BN5NPqYK9o6YglHvAvyTK87ASrrQqKB4
         QNZyM8T0It2Ahf48FVDirSSocW72gvQvU343+oO1+Ch4szWbBEkyI2CBB2ryECc2ndW+
         cdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ueNItYj2IC9D3zs28drSgPYCsB+eIJFzInbZyJE4LMU=;
        b=nvlWDJ7UmFwOdLhk4q3kIPog5JylSMqadASw4N5rHpfQ02NXnJYljkf/f1z8w+eSHE
         luiNnkcy4GoYtr5K/EJgapIPmlDXOnAXRrNDMzmU5LGKRCKcydT28NifHUpqtAyVksJx
         ejnWdetBRYivCExuYR9HDk3pGJqUs0CTJvutXEkjY7n85lucdrpg3S/V4SCCRCcs6bbJ
         6ALsjVr7PhPAozfiUF9tI9AtxFtnccaVvJUB4CoRw/+5Sst2zxOdxrpsM6SqmhxKhmpf
         3W2wV6n0IBpYnNmec5OSSXaHdR59NpM0lcIQInrm/dSxmRJBPsVgoM4BJKi21TymITYq
         GCnQ==
X-Gm-Message-State: AOAM530tM/HHZwblfuaAsWIWxwgsGHI6Mzx49VYwceLjR/bqeO84rQni
        uQ8A3ezfsMzO/MmFB2CS7BVw56Ox0DEBDLenSfaJyolgimg=
X-Google-Smtp-Source: ABdhPJz2WGgpxh+JlCa9OHnmgdkBjviT93sy7Wzrg9qe5Wk5cd+NTvPp9Ppr0eScOYm6Tnp0vLs9kbTLflAXfG+PeJE=
X-Received: by 2002:a92:6811:0:b0:2cd:994d:7406 with SMTP id
 d17-20020a926811000000b002cd994d7406mr26590470ilc.245.1653903433181; Mon, 30
 May 2022 02:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-4-masahiroy@kernel.org> <CA+icZUWkOrWYSY3ixxfF=vsuq1xw3mU+p3NMqBpY0OpM02916g@mail.gmail.com>
 <CAK7LNATwgT-FQ99Ex6MOc+rYEe7tc8ffoF-5e12jfbeaEM1vhw@mail.gmail.com>
In-Reply-To: <CAK7LNATwgT-FQ99Ex6MOc+rYEe7tc8ffoF-5e12jfbeaEM1vhw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 30 May 2022 11:36:37 +0200
Message-ID: <CA+icZUX+KE6yrVJ5a2CHRvL7_kpK-zXbvJurtAjzgYmsDtSkCw@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: factor out the common objtool arguments
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 7:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
...
> > >  # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
> > >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
> > >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
> > >
> >
> > ^^ What is with this block?
> > If this belongs together with objtool - shall this be moved, too?
>
> No.
> These are unneeded for vmlinux.o
>

OK.

> > >  #link vmlinux.o
> >
> > ^^ While you are at it, change the comment to "# Link of vmlinux.o".
>
>
> In my plan, this code will be gone sooner or later.
>
> It would be a noise.
>

Hope you have fruitful plans :-).
-sed@-
