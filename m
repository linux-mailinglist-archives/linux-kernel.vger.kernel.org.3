Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363224E9F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245509AbiC1TNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiC1TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:13:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379A66F8F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h7so26482523lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z0hyCXgiwng5/9t6+pFesUyv1jubPkOVcRWMPxjuqVk=;
        b=CYAJDipb2kfpHEC0ajYWVsuxHklphuLeT0OAwYQXQ5dbnDOPs6iszc4RweoqSMIy07
         chQ0e15UhHy3z3M8TlDW0c74g3t+miH/0tWmu53PP8HZ2nEbd2CpalJHxLG3HPEDYhEs
         KQtZm/A2FJK0JM3nKRt/PMDS2hMPW+DTmg7Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z0hyCXgiwng5/9t6+pFesUyv1jubPkOVcRWMPxjuqVk=;
        b=JYiYHPT+A4X1otXm80H11D98jqauNXwHf001nv/SLf7LKpfKgbq3AvJj9ezK2qr/8s
         TOF2APUdtwZbNwh+89bVhCaxmTqYFnTGxA4fi3ikpVltzSnJJA1XNlrKUtVllTZkUuuV
         2HdD9mG+88LM8aKJagfydJdz4kl8TDgqwsbKB/XSvxHUPjM0wwwcUdcu9/miHOP+97j8
         p+mGGMQDuLkGuduA5Vdh7CgD9B+CT/NEfkhFoK2jtwI1FhkSrBz54P1ZKNWPkGIFqTkO
         Bs/AQ/vAFRmRitYuVS40JtdcoY/w2O8Lj7eVJtJ1oaYi2zfI2nfROgY8zzHr9HAXNlMu
         dV5w==
X-Gm-Message-State: AOAM530qkKahqXJAfUzGkomDqItBfO+zuJmU3tvbO2RHDsWS4EXXocea
        DCU+JaznHCEY+/sMG3+G+16i+8xzSQ/8gK8YzUA=
X-Google-Smtp-Source: ABdhPJzJwZn2cXFW3RjcERPa4LHjh+K/iKeD5Iu9Gn4UY6yJhyPGT6IVi9oZE7AwPcuNmfbWBVlHuA==
X-Received: by 2002:a05:6512:ac3:b0:44a:a5a3:1136 with SMTP id n3-20020a0565120ac300b0044aa5a31136mr2938166lfu.657.1648494727708;
        Mon, 28 Mar 2022 12:12:07 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g7-20020a2eb5c7000000b002497a261f02sm1815269ljn.41.2022.03.28.12.12.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 12:12:06 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 5so26469139lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:06 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr21124202lfv.52.1648494725528; Mon, 28
 Mar 2022 12:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
In-Reply-To: <CACRpkdZ_Jr3OzfoOpSSsAJMy1Oe_=zD861jouDzCVD-BQ6yZMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 12:11:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzqAB6kfHUcX2uhfPnNiWJRq=UmeA1TbgGi3XA+57j3w@mail.gmail.com>
Message-ID: <CAHk-=whzqAB6kfHUcX2uhfPnNiWJRq=UmeA1TbgGi3XA+57j3w@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v5.18
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 6:08 AM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> tags/pinctrl-v5.18-1

Hmm.

This clashes badly with the fact that we in the meantime have enabled
-Warray-bounds, and I got

  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function =E2=80=98npcmgpio_=
irq_handler=E2=80=99:
  ./include/linux/find.h:40:23: error: array subscript =E2=80=98long unsign=
ed
int[0]=E2=80=99 is partly outside array bounds of =E2=80=98u32[1]=E2=80=99 =
{aka =E2=80=98unsigned
int[1]=E2=80=99} [-Werror=3Darray-bounds]
     40 |                 val =3D *addr & GENMASK(size - 1, offset);
        |                       ^~~~~
  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:219:13: note: while
referencing =E2=80=98sts=E2=80=99
    219 |         u32 sts, en, bit;
        |             ^~~

as a result.

Was this not in linux-next?

Or was the array bounds checking not there?

Anyway, that cast to "const void *"

     for_each_set_bit(bit, (const void *)&sts,

in that driver is completely wrong.

The bit operations are defined in arrays of 'unsigned long', and you
can't just cast the issue away, because the end result is not the same
on a big-endian machine.

I fixed it up in the merge, but what really confuses me (apart from
the apparent lack of testing in linux-next) is that I don't actually
see what made this happen now, and not before. Maybe that's why it
didn't show up in linux-next: it's some odd gcc heisenbug.

Because there seems to be no actual changes to that driver that would
explain why I get the warning now, but not before the pull.

There *was* a change from

-       dev_dbg(bank->gc.parent, "...
+       dev_dbg(chip->parent_device, }...

in that function, but nothing else I notice.

VERY funky.

Kees, any idea?

                   Linus
