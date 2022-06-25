Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723D55AB8E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiFYQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiFYQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67C13E03
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8AA6152F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7339AC341C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:20:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bUX6Xlfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656174008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZhFippxmz1dvC7jgL/gj9iy6JyEimwp5f4boGKlnkuU=;
        b=bUX6XlfiQwXZmDt2pV373ltUZJoletKqMSAD+LxsdFMxyzT5D8I6IYMCVmjLUF5yQKuLeE
        fx1M1vl52PHqD9TJ1gP/KkMrDsnNEtdJu9bwtPW5AvWxuZ03A4k1brTctGc7cXHo8vpEdA
        fcujdzxJ0cF8iqWykpdJibhR0v8YM4A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 60490be4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 25 Jun 2022 16:20:08 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id p69so5627053iod.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:20:07 -0700 (PDT)
X-Gm-Message-State: AJIora/TM0t5PKYiLjDMUmyT/6VE4uUZrK702He2Q/OJAhOnUonveqKl
        6TZxaOLuEE4w2EzEnLi5CWUkLYQiQ1fLHDc8tnI=
X-Google-Smtp-Source: AGRyM1syW2dzETTf7x+6F5yZSKJFC+Gm5huk0v+PevUgy0v5FFAfcdf5ulvF9lEcuJWXYpfmI9c4rUNuPwwBE7Q1/BE=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr2392482iow.172.1656174006947; Sat, 25
 Jun 2022 09:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220625153841.143928-1-Jason@zx2c4.com> <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
In-Reply-To: <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 25 Jun 2022 18:19:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
Message-ID: <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: virt: pass RNG seed via bootinfo block
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 25/06/2022 =C3=A0 17:38, Jason A. Donenfeld a =C3=A9crit :
> > Other virt VMs can pass RNG seeds via the "rng-seed" device tree
> > property or via UEFI, but m68k doesn't have either. Instead it has its
> > own bootinfo protocol. So this commit adds support for receiving a RNG
> > seed from it, which will be used at the earliest possible time in boot,
> > just like device tree.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >   arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
> >   arch/m68k/virt/config.c                    | 4 ++++
> >   2 files changed, 5 insertions(+)
> >
> > diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/inc=
lude/uapi/asm/bootinfo-virt.h
> > index e4db7e2213ab..7c3044acdf4a 100644
> > --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > @@ -12,6 +12,7 @@
> >   #define BI_VIRT_GF_TTY_BASE 0x8003
> >   #define BI_VIRT_VIRTIO_BASE 0x8004
> >   #define BI_VIRT_CTRL_BASE   0x8005
> > +#define BI_VIRT_RNG_SEED     0x8006
> >
> >   #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
> >
> > diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> > index 632ba200ad42..ad71af8273ec 100644
> > --- a/arch/m68k/virt/config.c
> > +++ b/arch/m68k/virt/config.c
> > @@ -2,6 +2,7 @@
> >
> >   #include <linux/reboot.h>
> >   #include <linux/serial_core.h>
> > +#include <linux/random.h>
> >   #include <clocksource/timer-goldfish.h>
> >
> >   #include <asm/bootinfo.h>
> > @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record=
 *record)
> >               data +=3D 4;
> >               virt_bi_data.virtio.irq =3D be32_to_cpup(data);
> >               break;
> > +     case BI_VIRT_RNG_SEED:
> > +             add_bootloader_randomness(data + 4, be32_to_cpup(data));
>
> In fact, why don't you use the record->size to get the size of the buffer=
?
>
> It seems useless to encode twice the length of the buffer, the second tim=
e on a 32bit while the
> length cannot exceed a 16bit value.

Doesn't that make the length ambiguous because of required alignment?
Would rather keep this general. As is, it's also much more like the
others and more uniform to keep it that way. You were able to review
it and see that it was right after glancing for a second. That seems
superior to any imaginary gains we'd get by overloading the record
size.

Jason
