Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA3523DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiEKTs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiEKTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:48:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC16207915
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:48:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m23so3988652ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viN6sY+f+N6S/Prtk7UnuYOXqrply8ByGnamSFChEnk=;
        b=LqEw+RL5CYtKiuGwKItpr/vP15rmt1WIf8mKYuC78DH3jcI9PUi2AVINwFyLUIVAk1
         lKDJ6Ej4LU2UtrCjIAjplO0BZgnmMNwpiaWC0vxqFyPLryYhgVyms39EYjp2s11jdzd9
         g5aAClMb7Q5z3ObDP3+0PhYuW2rd98/gkBZ/h0q3XfNCje3MUS9C4Nw50sbngNzFfVon
         2Tc6E4kzU73Nm9j8FpqUQNTJ6TkzTAAWeFfNhEiMY98XWYhAINVbCG/gjU5SpybVt03I
         PeFXmrDcG5qm4gLyyBK4J7stH+L2qr6NnjHbP82lmlYXmOypntABiIbBtd2BIxRnMAOr
         HtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viN6sY+f+N6S/Prtk7UnuYOXqrply8ByGnamSFChEnk=;
        b=COC/Fuze49bTBhBX1oVOzG2nsBZ34dHuEMl81LVhBc6MiNHxerYnj/FXhqPzqmJ3zJ
         y2e8yjcV8ydLp85oHCCN/AxpKRv2IRxMUE++PTM7vd/KamSNd6dlJ2XTQdYKMNmebw9R
         YCN62yWRoAhG8UAcrB/zLZ2n2IwJy97d8YitxrQiPHfTPCxD3ce9J2/qzAX3XsHAYVkD
         Hr8R1oBkIODP66NgLcx/stIr0OiGiF04Fo3STADK0VCt210k6/Io4GeYG6FUnN84mGm9
         4s5+m2RUzii7ZMdNryk9hPW6feYn54Ngp7A+hiPm7RCjWMJAtMM7TWfndpZumLdms23P
         KIjw==
X-Gm-Message-State: AOAM532JFJbLAPAXwxqZzOxkbx9ZFnxXNpm2mwaPv4dLGneB5HnEHYEn
        wJXRoJm04fifsHr9kJPyx6HIQ+J8FSEFzdgLaXNnFw==
X-Google-Smtp-Source: ABdhPJxYEkh+IGZ8j3Rp59ahCR4uKEBHb3CjX7DDoNNpVo1R2zxZ/WC02y+NpOYgA4HkmUhGag0f/NUNZwgjrybgMrI=
X-Received: by 2002:a05:651c:1a09:b0:250:5bd1:6daf with SMTP id
 by9-20020a05651c1a0900b002505bd16dafmr17385580ljb.468.1652298525759; Wed, 11
 May 2022 12:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-1-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:48:34 -0700
Message-ID: <CAKwvOdkXy0nhS-S+dOAsSO+mpj2dCuZ4aUTe=upPV8epfTA7Aw@mail.gmail.com>
Subject: Re: [PATCH 0/8] s390: allow to build with llvm's integrated assembler
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> A couple of patches which in result make it finally possible to build the
> kernel for s390 with llvm's integrated assembler. Several configs build
> without errors or warnings, and the kernel also works as expected.
>
> Note that patch 6 ("s390/boot: workaround llvm IAS bug") reveals a
> miscompile. This looks like a bug in the instruction definitions of the mvc
> and clc instructions(?). I'd like to ask people to look into this, since
> this silently generated broken code.
>
> This patch series is based on linux-next, which contains two additional
> required s390 specific patches to make llvm's IAS work.

I did a quick test of just a defconfig via:
$ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j72 defconfig all
and this assembled then booted in qemu for me. Thanks for the work
that went into this!

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Sounds like Nathan is doing additional testing as well.

>
> Thanks,
> Heiko
>
> Heiko Carstens (8):
>   s390/alternatives: provide identical sized orginal/alternative sequences
>   s390/alternatives: remove padding generation code
>   s390/entry: shorten OUTSIDE macro
>   s390/entry: workaround llvm's IAS limitations
>   s390/purgatory: workaround llvm's IAS limitations
>   s390/boot: workaround llvm IAS bug
>   s390/boot: do not emit debug info for assembly with llvm's IAS
>   scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390
>
>  arch/s390/Makefile                      |  2 +
>  arch/s390/boot/head.S                   | 34 +++++----
>  arch/s390/include/asm/alternative-asm.h | 76 +++-----------------
>  arch/s390/include/asm/alternative.h     | 93 ++++++-------------------
>  arch/s390/include/asm/spinlock.h        |  2 +-
>  arch/s390/kernel/alternative.c          | 61 +---------------
>  arch/s390/kernel/entry.S                | 39 +++++++----
>  arch/s390/lib/spinlock.c                |  4 +-
>  arch/s390/purgatory/head.S              | 29 ++++++--
>  scripts/min-tool-version.sh             |  3 +-
>  10 files changed, 104 insertions(+), 239 deletions(-)
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
