Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C455B0E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiFZJkE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jun 2022 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiFZJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:40:00 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA61182E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 02:40:00 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id n10so1651775qkn.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 02:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q5mJwFzFEr8kIw19EwrMxHT8BpAf4UimcTMy2tL5P0E=;
        b=X5PUZBneUC1p056npgy8SpwcTfUyfNrpwfKTF0HMRo1w5jLyYYDCAAvh39yHhq6kQD
         uiYbrv286V9NhWULaV6Bc4mBmBLunV0+Omntnx5WMnEnNwI/k5TPiQwggJCerDLi6bZu
         UkwFQH5itFxXVAeXsOpGAgbeXhJPTS/lg6i0qNcMstdSZBdwcggD4GUvmc5+8kPiWNLE
         GYFiz6BQyJcEN8knFZ8Em804ZyzOnJAyY42GWz7/u+Uop96+lpwYARP38TxGhmdjQ2Dw
         Ezt2F9wbuaEjm3RwzEVX7l6QoY5YjGzQUabiVPZI0C0dHusdtVjUKe9cDYKNkN7CnykB
         sRog==
X-Gm-Message-State: AJIora/VK/DzqTc2wCJurRe+Q8OMHloJbt0AP9fdPYefwFZhgoNHmxRt
        G6OaU7LAZlLlUsm14F1WlhDk2nxDBreI4Q==
X-Google-Smtp-Source: AGRyM1tnUuklbmOicAatehUsImnDKV7YG7KxRmsnjwBK716fPYbS2KRBo7Q+QycUfzDTTtQy1FsTdA==
X-Received: by 2002:a05:620a:4805:b0:6a7:63f3:5dab with SMTP id eb5-20020a05620a480500b006a763f35dabmr4833945qkb.465.1656236399019;
        Sun, 26 Jun 2022 02:39:59 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b00317bcb6ad2csm4954036qty.17.2022.06.26.02.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 02:39:58 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id l11so11866086ybu.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 02:39:58 -0700 (PDT)
X-Received: by 2002:a25:3288:0:b0:66c:8a91:74bb with SMTP id
 y130-20020a253288000000b0066c8a9174bbmr6631769yby.89.1656236398270; Sun, 26
 Jun 2022 02:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220625153841.143928-1-Jason@zx2c4.com> <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
 <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
 <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu> <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
In-Reply-To: <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Jun 2022 11:39:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKpmN=Cp6zTe7=JO=5GoAhrfhoKT=pqszNR8iUkEv9Rw@mail.gmail.com>
Message-ID: <CAMuHMdVKpmN=Cp6zTe7=JO=5GoAhrfhoKT=pqszNR8iUkEv9Rw@mail.gmail.com>
Subject: Re: [PATCH] m68k: virt: pass RNG seed via bootinfo block
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for your patch!

On Sat, Jun 25, 2022 at 6:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Sat, Jun 25, 2022 at 6:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > Le 25/06/2022 à 18:19, Jason A. Donenfeld a écrit :
> > > On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > >> Le 25/06/2022 à 17:38, Jason A. Donenfeld a écrit :
> > >>> Other virt VMs can pass RNG seeds via the "rng-seed" device tree

FTR, "rng-seed" does not seem to be documented anywhere, not under
Documentation/devicetree/bindings/, and not in the Devicetree
Specification?

> > >>> property or via UEFI, but m68k doesn't have either. Instead it has its
> > >>> own bootinfo protocol. So this commit adds support for receiving a RNG
> > >>> seed from it, which will be used at the earliest possible time in boot,
> > >>> just like device tree.
> > >>>
> > >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >>> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > >>> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > >>> @@ -12,6 +12,7 @@
> > >>>    #define BI_VIRT_GF_TTY_BASE 0x8003
> > >>>    #define BI_VIRT_VIRTIO_BASE 0x8004
> > >>>    #define BI_VIRT_CTRL_BASE   0x8005
> > >>> +#define BI_VIRT_RNG_SEED     0x8006

Please add a comment documenting the record format.

Laurent: Would be nice if you could add this for the other BI_*, too.

> > >>>
> > >>>    #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
> > >>>
> > >>> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> > >>> index 632ba200ad42..ad71af8273ec 100644
> > >>> --- a/arch/m68k/virt/config.c
> > >>> +++ b/arch/m68k/virt/config.c
> > >>> @@ -2,6 +2,7 @@
> > >>>
> > >>>    #include <linux/reboot.h>
> > >>>    #include <linux/serial_core.h>
> > >>> +#include <linux/random.h>
> > >>>    #include <clocksource/timer-goldfish.h>
> > >>>
> > >>>    #include <asm/bootinfo.h>
> > >>> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
> > >>>                data += 4;
> > >>>                virt_bi_data.virtio.irq = be32_to_cpup(data);
> > >>>                break;
> > >>> +     case BI_VIRT_RNG_SEED:
> > >>> +             add_bootloader_randomness(data + 4, be32_to_cpup(data));
> > >>
> > >> In fact, why don't you use the record->size to get the size of the buffer?
> > >>
> > >> It seems useless to encode twice the length of the buffer, the second time on a 32bit while the
> > >> length cannot exceed a 16bit value.
> > >
> > > Doesn't that make the length ambiguous because of required alignment?
> >
> > I agree, it's why I understand reviewing the QEMU part of your patch.
> >
> > > Would rather keep this general. As is, it's also much more like the
> > > others and more uniform to keep it that way. You were able to review
> > > it and see that it was right after glancing for a second. That seems
> > > superior to any imaginary gains we'd get by overloading the record
> > > size.
> >
> > And what about using a 16bit field rather than a 32bit field as the encoded length cannot be greater
> > than the record length?
>
> I guess but that's different from all other length fields, and means
> we can't expand past 65k if somebody wants to use this for something
> more interesting later. Again I wonder what stinginess here gets us.
> This is just a boot parameter... No need to go crazy optimizing it.

You cannot extend this past (64 KiB - sizeof(struct bi_record))
anyway, as the total record size is limited to 64 KiB, regardless of
the additional buffer size you try to encode inside your own 32-bit
size field.

So either just store the data inside the record, rely on bi_record.size,
and live with random data that must be a number of even bytes (does
it really hurt to drop the last byte, or add a dummy byte?), or store
a pointer/size, like is done for e.g. BI_RAMDISK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
