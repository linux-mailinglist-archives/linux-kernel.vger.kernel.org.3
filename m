Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE757FFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiGYNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiGYNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:30:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F8D11D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:30:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v2so2290917ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqgRYaQ+5Ei5P1sHb0JfmZ6zpThHEKr7E+RUOHeaoYM=;
        b=jy6Ofg3IZ4r4qf3yeNRhJBzx3l0jYTUvPpUQxq9PzqtaRD5mYFBt27ndkR5BopQFDq
         PJKLlVqdlkVPeCmFpp7LFGlCrHLts4jS8J9KyCpYTEscdTQaFpSBg75OaFNOEWEKsCG1
         ekNRnLJP3HClMuPZiFlGhJCRs9Mo5mcYiCHj9W99lrh2JkzOHiVq//SorMjsnVNegZvU
         ed2eMd6CYWmY7q3zoeGDpG32aanOs7hpRCAVlH4AJ+rj0r3EWVc7flluL0scu+cVjh2o
         CHzt3i1f214fyDZgk+n7lwVjQugC8qOhB7UFJvxpyS+gHUgxj/SzyFD6hvxok626BOEq
         VZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqgRYaQ+5Ei5P1sHb0JfmZ6zpThHEKr7E+RUOHeaoYM=;
        b=V2oLXVKxvToSxd0SKlmKDlHmxCe6Vismn+Cxg8O3wfDxnIDZb/xRYDtsPa96SYja8r
         zTyVHIXN778HoIFB4+3atLrbh0afYHQi8FY4OfDzM2XLWsAAjLMZp8oLp7sfHRxQhouh
         bTJQA/CilQmH/fEJkxZLbJ75zIx6R6V2zGPSPom0b3DelJTJ0XrCAUNZfvWficVTW5j5
         vhnRtoNzonl74pjFrbnO6+rK1YG+BaWeBnYFYJYMimBuGDWkmxsvqlbW+HKZHArAaAAk
         h21qH4EGMYGWoJwIzNF0kvBod2s+2qy7FLSaNDNrbZljYdUbILhgL8kCWoiUszOUWsEN
         nzjQ==
X-Gm-Message-State: AJIora8tadEWzu7Pteuc6S89Rdl+S2VTy1i2Nf4619ZiiApy1LjN70uF
        8+Vtxud/VOhLbiLS485OGU+HGU8ILK3rYobuIJx0Xg==
X-Google-Smtp-Source: AGRyM1svsFvJjM44MlpBpazZSBO0gFEQ3hiwRw4WeKR9Juffr2OOgH3srO5bGTVALtUNMqlqZMnZxnFr1Wuh6SmpRU8=
X-Received: by 2002:a05:6e02:5a6:b0:2dd:164c:15a2 with SMTP id
 k6-20020a056e0205a600b002dd164c15a2mr4895579ils.105.1658755852411; Mon, 25
 Jul 2022 06:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-2-huangjie.albert@bytedance.com> <Yt6GPsWcG9iWHBUg@zx2c4.com>
In-Reply-To: <Yt6GPsWcG9iWHBUg@zx2c4.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 21:30:41 +0800
Message-ID: <CABKxMyNj7Oo3X47APa8Ro-CCK3=XFogorJ2maTCstgsrrC28kg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/4] kexec: reuse crash kernel reserved
 memory for normal kexec
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 20:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Albert,
>
> On Mon, Jul 25, 2022 at 04:38:53PM +0800, Albert Huang wrote:
> > The kexec userspace tool also needs to add parameter options(-r) that
> > support the use of reserved memory (see another patch for kexec)
> >
> > [...]
> >
> > -     if (kexec_on_panic) {
> > +     if (kexec_on_panic && kexec_on_reserved) {
>
> Two small questions related to this:
>
> - Why does kexec-tools need an option, or more specifically, why does
>   userspace need to communicate about this at all? Can't the kernel just
>   automatically use the available reserved memory in the case that's not
>   already being used by the panic handler kernel? I'm curious about
>   whether there are caveats that would make this occasionally
>   undesirable, hence suggesting an option.

Because the crash kernel will also use this part of the memory,
so do not use this mechanism unless explicitly specified. So I tend to
add an option

>
> - I don't totally understand how this works, so I might be a bit off
>   here, but is there any chance that this could be made to co-exist with
>   kexec_on_panic? Can a larger region just be reserved, specifically for
>   this, rather than piggy backing on the panic handler region?
>
> > +static struct page *kimage_alloc_reserverd_control_pages(struct kimage=
 *image,
> > +     case KEXEC_TYPE_RESERVED_MEM:
> > +             pages =3D kimage_alloc_reserverd_control_pages(image, ord=
er);
>
> Nit:
>   reserverd -> reserved

thanks for that, I will correct it

>
> Jason
