Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE16516C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383791AbiEBIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEBIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:40:42 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E8183B1;
        Mon,  2 May 2022 01:37:14 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id hh4so10627427qtb.10;
        Mon, 02 May 2022 01:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA3q1va6ACK5WS1PVApJ5VQckcthRFC9fvnVR7KWAE0=;
        b=ao7sq9VoII0UYicctOjzoIFuAjhmMqvpt/wHxJ/bJ0ee7YwOvliAkW4vPGdtKMFcl8
         7zWWuH7IQLRm9dlGGQPBpsCcnoOYBdYHLUzqZvu68pv62tjhSKsDinH9RoeuLZB63I/2
         U6ikDUBnMVrJv1uO3c/PdVsfrs1Q/8a5tKAWKqm2mlbg5sgknxDbF+bWasD45QjNnMPf
         OBB7Us4bz4mSO1OESAZT716RVGLRHrEbhxIQQgNd96Z23i/qKRD5pV0ON7Vg6hNr4vaD
         34VKSYfdxT1Vh8KVPItWHUOTDpoKaFNg2FzfeLr7nbeEm9aboynoqdvad0JT+/SWOhTI
         xCKg==
X-Gm-Message-State: AOAM533H2J8Gwo5EJyC7IenHCTEHbrhk52Yd5dekIiJ3ncmXN9QoTegm
        I+//TFeazjNVi9aNLijGI7QDIoLtJqZQgQ==
X-Google-Smtp-Source: ABdhPJwjr12fmg6KmS6VzBDsXAj6tQfCfQO03ojR1W8mk3lETKuIHMbbPeJMt7IGIrF98Ldf88IxdA==
X-Received: by 2002:ac8:5b87:0:b0:2f3:abf2:2e19 with SMTP id a7-20020ac85b87000000b002f3abf22e19mr826qta.644.1651480632762;
        Mon, 02 May 2022 01:37:12 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id m25-20020ae9e719000000b0069fc13ce208sm3767477qka.57.2022.05.02.01.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 01:37:12 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7c424c66cso140673737b3.1;
        Mon, 02 May 2022 01:37:12 -0700 (PDT)
X-Received: by 2002:a05:690c:84:b0:2f1:9caa:e4f7 with SMTP id
 be4-20020a05690c008400b002f19caae4f7mr10932652ywb.384.1651480631989; Mon, 02
 May 2022 01:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru> <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
In-Reply-To: <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 10:37:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
Message-ID: <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, Apr 30, 2022 at 3:52 PM Rob Landley <rob@landley.net> wrote:
> On 4/29/22 09:24, John Paul Adrian Glaubitz wrote:
> > On 4/27/22 20:46, Sergey Shtylyov wrote:
> >> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> >> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> >> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> >> at 0 -- modify that code to start the IRQ #s from 16 instead.
> >>
> >> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> >> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...

> As I told him in IRC, the problem is still that sh4 never gives me a shell
> prompt with this patch applied. I just reconfirmed it against current git:
>
> Freeing unused kernel image (initmem) memory: 124K
> This architecture does not have kernel memory protection.
> Run /init as init process
> mountpoint: dev/pts: No such file or directory
> 8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
>
> It makes it partway through the init script, but it hangs with qemu-system-sh4
> stuck in a CPU-eating loop before finishing. Without the patch, I get a shell
> prompt.

I regularly test on qemu rts7751r2d, but couldn't produce your
issue.  Until I tried "ifconfig eth0 up", which causes a lock-up.
Interestingly, the 8139 irq was 112 with and without Sergey's patch,
so there must be an irq remapping missing.

I also test regularly on landisk, where 8139 Ethernet works fine.
Turns out landisk uses arch/sh/drivers/pci/fixups-landisk.c to fixup
the irq...

arch/sh/include/mach-common/mach/r2d.h has:
#define R2D_FPGA_IRQ_BASE       100
Subtracting 16 here does not help.

With this (gmail-whitespace-damaged) patch:

--- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
@@ -31,9 +31,9 @@ static char lboxre2_irq_tab[] = {
 int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
        if (mach_is_lboxre2())
-               return lboxre2_irq_tab[slot];
+               return lboxre2_irq_tab[slot] - 16;
        else
-               return rts7751r2d_irq_tab[slot];
+               return rts7751r2d_irq_tab[slot] - 16;
 }

 int pci_fixup_pcic(struct pci_channel *chan)

it no longer crashes, but ifconfig still fails:

/ # ifconfig eth0 up
ifconfig: ioctl 0x8914 failed: Invalid argument

Note that there are more implementations of pcibios_map_platform_irq()
that do not use evt2irq(), and thus are probably broken by this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
