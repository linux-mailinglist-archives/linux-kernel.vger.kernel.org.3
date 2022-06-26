Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9D55B157
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiFZKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiFZKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:50:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448D13E36
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7C7FB80D87
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB56AC34114;
        Sun, 26 Jun 2022 10:50:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HyudfkAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656240649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEW0xx3G3bznhUDvdAWREy0uMnoRzWx1KuZdwLD9EJg=;
        b=HyudfkAboDZSCYig3siayhTZJnqgwYYY939ZaPd181UTruYyg+I578/3XSw2kcph+OtSYr
        xEvg50R6kwmqN+61dLfyMUppuNB0dvhbJIQ11iabnYufxqIu/R5HbQMtqHIyAS9RMnSoxj
        xRl0n06wzTl+aycvp4ddGJDc9q8r0pU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a80d376 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 26 Jun 2022 10:50:49 +0000 (UTC)
Date:   Sun, 26 Jun 2022 12:50:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: virt: pass RNG seed via bootinfo block
Message-ID: <Yrg6BzpKIJBTAVmO@zx2c4.com>
References: <20220625153841.143928-1-Jason@zx2c4.com>
 <512bdf97-5468-e2d2-75bd-24107aaf8a34@vivier.eu>
 <CAHmME9qKkL8r7QSwq+2DA54mpMHzqpnq=pi5f0DhKOcB-qezoQ@mail.gmail.com>
 <fa4f2fba-ad77-e5a9-a78a-680ed5137157@vivier.eu>
 <CAHmME9oGOduYbw_-=0QeKzW6Lj07S6tevssvUpyWLgutuxE+UA@mail.gmail.com>
 <CAMuHMdVKpmN=Cp6zTe7=JO=5GoAhrfhoKT=pqszNR8iUkEv9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVKpmN=Cp6zTe7=JO=5GoAhrfhoKT=pqszNR8iUkEv9Rw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Sun, Jun 26, 2022 at 11:39:46AM +0200, Geert Uytterhoeven wrote:
> Hi Jason,
> 
> Thanks for your patch!
> 
> On Sat, Jun 25, 2022 at 6:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > On Sat, Jun 25, 2022 at 6:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > > Le 25/06/2022 à 18:19, Jason A. Donenfeld a écrit :
> > > > On Sat, Jun 25, 2022 at 6:08 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > > >> Le 25/06/2022 à 17:38, Jason A. Donenfeld a écrit :
> > > >>> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
> 
> FTR, "rng-seed" does not seem to be documented anywhere, not under
> Documentation/devicetree/bindings/, and not in the Devicetree
> Specification?

Good point. It's quite old, this field, so odd it was missed. I'll send
in a separate patch for that.

> 
> > > >>> property or via UEFI, but m68k doesn't have either. Instead it has its
> > > >>> own bootinfo protocol. So this commit adds support for receiving a RNG
> > > >>> seed from it, which will be used at the earliest possible time in boot,
> > > >>> just like device tree.
> > > >>>
> > > >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > >>> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > > >>> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> > > >>> @@ -12,6 +12,7 @@
> > > >>>    #define BI_VIRT_GF_TTY_BASE 0x8003
> > > >>>    #define BI_VIRT_VIRTIO_BASE 0x8004
> > > >>>    #define BI_VIRT_CTRL_BASE   0x8005
> > > >>> +#define BI_VIRT_RNG_SEED     0x8006
> 
> Please add a comment documenting the record format.

Ack.

> 
> Laurent: Would be nice if you could add this for the other BI_*, too.
> 
> > > >>>
> > > >>>    #define VIRT_BOOTI_VERSION  MK_BI_VERSION(2, 0)
> > > >>>
> > > >>> diff --git a/arch/m68k/virt/config.c b/arch/m68k/virt/config.c
> > > >>> index 632ba200ad42..ad71af8273ec 100644
> > > >>> --- a/arch/m68k/virt/config.c
> > > >>> +++ b/arch/m68k/virt/config.c
> > > >>> @@ -2,6 +2,7 @@
> > > >>>
> > > >>>    #include <linux/reboot.h>
> > > >>>    #include <linux/serial_core.h>
> > > >>> +#include <linux/random.h>
> > > >>>    #include <clocksource/timer-goldfish.h>
> > > >>>
> > > >>>    #include <asm/bootinfo.h>
> > > >>> @@ -92,6 +93,9 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
> > > >>>                data += 4;
> > > >>>                virt_bi_data.virtio.irq = be32_to_cpup(data);
> > > >>>                break;
> > > >>> +     case BI_VIRT_RNG_SEED:
> > > >>> +             add_bootloader_randomness(data + 4, be32_to_cpup(data));
> > > >>
> > > >> In fact, why don't you use the record->size to get the size of the buffer?
> > > >>
> > > >> It seems useless to encode twice the length of the buffer, the second time on a 32bit while the
> > > >> length cannot exceed a 16bit value.
> > > >
> > > > Doesn't that make the length ambiguous because of required alignment?
> > >
> > > I agree, it's why I understand reviewing the QEMU part of your patch.
> > >
> > > > Would rather keep this general. As is, it's also much more like the
> > > > others and more uniform to keep it that way. You were able to review
> > > > it and see that it was right after glancing for a second. That seems
> > > > superior to any imaginary gains we'd get by overloading the record
> > > > size.
> > >
> > > And what about using a 16bit field rather than a 32bit field as the encoded length cannot be greater
> > > than the record length?
> >
> > I guess but that's different from all other length fields, and means
> > we can't expand past 65k if somebody wants to use this for something
> > more interesting later. Again I wonder what stinginess here gets us.
> > This is just a boot parameter... No need to go crazy optimizing it.
> 
> You cannot extend this past (64 KiB - sizeof(struct bi_record))
> anyway, as the total record size is limited to 64 KiB, regardless of
> the additional buffer size you try to encode inside your own 32-bit
> size field.
> 
> So either just store the data inside the record, rely on bi_record.size,
> and live with random data that must be a number of even bytes (does
> it really hurt to drop the last byte, or add a dummy byte?), or store
> a pointer/size, like is done for e.g. BI_RAMDISK.

I modeled this on BOOTINFOSTR, which benefits from null termination.
I'll just reduce the length field to 2 bytes. I really don't want to
play padding games here, and anyway the length field needs to be
separate for reasons that will become apparent in v2 (zeroing for
kexec).

Jason

