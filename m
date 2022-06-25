Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF555AB93
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiFYQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFYQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E452A13E26
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0E661524
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3DAC3411C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:26:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O3QXPAgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656174411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2l1JO0EvImXtJesW/U27TBwPd7olHN9f3zn4k5kPBrY=;
        b=O3QXPAgkbO0yfkZl7OTm1vmasZ/LvH4HI32b0Xn/soW9X5G8Qq6E0NIaerD0buUt1X+Q36
        OWOlKhlxfoinM2rXuHSiNj+VfiGLp/cCWOCFY5CUYZ/1n+6rui6FJApdHsaqqlK7Yzwl5X
        YUs3AbjoFB7vbq3MrEZCg1vBeJuGK9E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4eff193 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 25 Jun 2022 16:26:51 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id k6so3406394ilq.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:26:50 -0700 (PDT)
X-Gm-Message-State: AJIora9+3OyOAnaR27B2EKXiGqC2srEGFyweFKUUDqWq7nm7+QQmQWES
        +Q/9F0d1dkjFOHRboU8ag0d2Rqdt7hnTNKWKHF4=
X-Google-Smtp-Source: AGRyM1vzwHYNk61HqWUv2NhMVA0zVzPrHeJfQFhZdY+vOt6T6TlMtbxMdug+DfwaQPKgrDBbORUENg9Xn9MuVtxmjoo=
X-Received: by 2002:a05:6e02:20c6:b0:2d8:e62f:349f with SMTP id
 6-20020a056e0220c600b002d8e62f349fmr2590564ilq.160.1656174409792; Sat, 25 Jun
 2022 09:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220625153841.143928-1-Jason@zx2c4.com> <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
 <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com> <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu>
In-Reply-To: <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 25 Jun 2022 18:26:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
Message-ID: <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 6:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 25/06/2022 =C3=A0 18:19, Jason A. Donenfeld a =C3=A9crit :
> > On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 25/06/2022 =C3=A0 17:38, Jason A. Donenfeld a =C3=A9crit :
> >>> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
> >>> property or via UEFI, but m68k doesn't have either. Instead it has it=
s
> >>> own bootinfo protocol. So this commit adds support for receiving a RN=
G
> >>> seed from it, which will be used at the earliest possible time in boo=
t,
> >>> just like device tree.
> >>>
> >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >>> ---
> >>>    arch/m68k/include/uapi/asm/bootinfo-virt.h | 1 +
> >>>    arch/m68k/virt/config.c                    | 4 ++++
> >>>    2 files changed, 5 insertions(+)
> >>>
> >>> diff --git a/arch/m68k/include/uapi/asm/bootinfo-virt.h b/arch/m68k/i=
nclude/uapi/asm/bootinfo-virt.h
> >>> index e4db7e2213ab..7c3044acdf4a 100644
> >>> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> >>> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> >>> @@ -12,6 +12,7 @@
> >>>    #define BI_VIRT_GF_TTY_BASE 0x8003
> >>>    #define BI_VIRT_VIRTIO_BASE 0x8004
> >>>    #define BI_VIRT_CTRL_BASE   0x8005
> >>> +#define BI_VIRT_RNG_SEED     0x8006
> >>>
> >>>    #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
> >>>
> >>> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> >>> index 632ba200ad42..ad71af8273ec 100644
> >>> --- a/arch/m68k/virt/config.c
> >>> +++ b/arch/m68k/virt/config.c
> >>> @@ -2,6 +2,7 @@
> >>>
> >>>    #include <linux/reboot.h>
> >>>    #include <linux/serial_core.h>
> >>> +#include <linux/random.h>
> >>>    #include <clocksource/timer-goldfish.h>
> >>>
> >>>    #include <asm/bootinfo.h>
> >>> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_reco=
rd *record)
> >>>                data +=3D 4;
> >>>                virt_bi_data.virtio.irq =3D be32_to_cpup(data);
> >>>                break;
> >>> +     case BI_VIRT_RNG_SEED:
> >>> +             add_bootloader_randomness(data + 4, be32_to_cpup(data))=
;
> >>
> >> In fact, why don't you use the record->size to get the size of the buf=
fer?
> >>
> >> It seems useless to encode twice the length of the buffer, the second =
time on a 32bit while the
> >> length cannot exceed a 16bit value.
> >
> > Doesn't that make the length ambiguous because of required alignment?
>
> I agree, it's why I understand reviewing the QEMU part of your patch.
>
> > Would rather keep this general. As is, it's also much more like the
> > others and more uniform to keep it that way. You were able to review
> > it and see that it was right after glancing for a second. That seems
> > superior to any imaginary gains we'd get by overloading the record
> > size.
>
> And what about using a 16bit field rather than a 32bit field as the encod=
ed length cannot be greater
> than the record length?

I guess but that's different from all other length fields, and means
we can't expand past 65k if somebody wants to use this for something
more interesting later. Again I wonder what stinginess here gets us.
This is just a boot parameter... No need to go crazy optimizing it.

Jason
