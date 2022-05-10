Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E55226BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiEJWPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiEJWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:14:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F41289BCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:14:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d19so460381lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOgaTsnX6kepYSuoDyzZHRKBXThHWTHTtRY7fC7kcaM=;
        b=s1y/ht2yi/2zxNHXLvPXx7iQ0XuULH38UHyRhwN6QVL9z87v/qpo3S2OWCRXlI98b5
         TL6M3YqOKxRQ4GYP2ZfDKKw6IOd/bL0nxeiIJSsz9dCUdKsc9rlVmg5aRHXuKmcrDAef
         GD3aABaMl+pOPlGnj7qLPxZD6t1zdpHZ8dHtRgR+ae7z30avXe4IPOA+a8Gga5Unzzl6
         q9JbX+0vFJ6ruK0M013yV3bn31tMuSHC3JXezBi11lmkq8SA+vQmoNGIaKLJ0eMR0Fg9
         VeFoFxxVbmmcJP7rE91hYyoXY+PFjY6Bcn9rODtWN7pzSn7cvh1I2k5t2Ye1HNL6ZSDR
         +ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOgaTsnX6kepYSuoDyzZHRKBXThHWTHTtRY7fC7kcaM=;
        b=OicwzYsvNtZV1x0lLcd776cU4yN22jEkYE6mGMV6TwY65HuhKXV5fYvR13iUo/e9KU
         9rPHbEWBlrtSDmPPQDf3eKJ7I6p1gTszX0SpHHWXxUOzBW0yxtCVv5ux5zNyhXrKd7fx
         GzC6nNWBYMqSYE4vX6H+QHWC5/sbI2bqWhL57fcizKBzGHhS2u5cb/gti+MZkCTwTDf+
         AG117GIZppCFE1lXS1TApSDSlQnkq9PX0RBZmQM6HopoZwvLGBGxoAfqOkSDudU9jQj6
         cEake6gwX5WqukDgLVkgxQWgLObq4aT5ISlW4sp8nQWbT5Ve7JwlhaZBBjPwtXlcMKRp
         PnwQ==
X-Gm-Message-State: AOAM531leKiN0GkWKLZ7huet6QlTJxUjiAwQ4mQZzd1oYdULMb36PVry
        fdWVvkvFkjuF+irGUHBDdXytxh4GFTZ6D8EScr2hExX5PKvLQA==
X-Google-Smtp-Source: ABdhPJxpoMjT+YF2n2eAaW5Yd1bxoaZoOWOwRnJE6lNtIt3rJlDv1tzFoHDV25WVVMfbNYRinG4W6EDDNrQGJ/t4uIk=
X-Received: by 2002:a05:6512:48f:b0:472:3c47:94a0 with SMTP id
 v15-20020a056512048f00b004723c4794a0mr17686928lfq.579.1652220895068; Tue, 10
 May 2022 15:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 May 2022 15:14:43 -0700
Message-ID: <CAKwvOdnShyGvW9cuDuqQS+uvY7DHSmh8-55R1Bx_dxej8YQRHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 7:26 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> The compilers provides some builtin expression equivalent to the
> ffs(), __ffs() and ffz() function of the kernel. The kernel uses
> optimized assembly which produces better code than the builtin
> functions. However, such assembly code can not be optimized when used
> on constant expression.
>
> This series relies on __builtin_constant_p to select the optimal solution:
>
>   * use kernel assembly for non constant expressions
>
>   * use compiler's __builtin function for constant expressions.
>
> I also think that the fls() and fls64() can be optimized in a similar
> way, using __builtin_ctz() and __builtin_ctzll() but it is a bit less
> trivial so I want to focus on this series first. If it get accepted, I
> will then work on those two additionnal function.
>
>
> ** Statistics **
>
> On a allyesconfig, before applying this series, I get:
>
> | $ objdump -d vmlinux.o | grep bsf | wc -l
> | 1081
>
> After applying this series:
>
> | $ objdump -d vmlinux.o | grep bsf | wc -l
> | 792
>
> So, roughly 26.7% of the call to either ffs() or __ffs() were using
> constant expression and can be optimized (I did not produce the
> figures for ffz()).

These stats are interesting; consider putting them on patch 1/2 commit
message though (in addition to the cover letter). (Sending thoughts on
1/2 next).

>
> (tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

Here's the same measure of x86_64 allyesconfig (./scripts/config -d
CONFIG_HINIC) at 9be9ed2612b5aedb52a2c240edb1630b6b743cb6 with ToT
LLVM (~clang-15):

Before:
$ objdump -d vmlinux.o | grep bsf | wc -l
1454

After:
$ objdump -d vmlinux.o | grep bsf | wc -l
1070

-26.4% :)


>
>
> Vincent Mailhol (2):
>   x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
>     expressions
>   x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
>     expressions
>
>  arch/x86/include/asm/bitops.h | 65 +++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
>
> --
> 2.35.1
>


--
Thanks,
~Nick Desaulniers
