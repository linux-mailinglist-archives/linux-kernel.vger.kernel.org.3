Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E104D0463
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiCGQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiCGQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:45:29 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2D793BB;
        Mon,  7 Mar 2022 08:44:34 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id z66so12383641qke.10;
        Mon, 07 Mar 2022 08:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYMXxw5Dgc/2Porp8CGHtfTzswoYzip+SRwsyM3sZuE=;
        b=DsdPHZ7x5yoak8k3v78MksTTVePfBVJStA5+mH7Th312PQW9iH1PdvYMP4fqfbE0lq
         jtlLfl8vs5w7jwc4Z5SqY2PbeML53xDcYyPnAnWMCWiNBsQcIb4akeqHiKoavY+N/0lw
         QNr/UbVHUScV93xxlmjLKqi+boXgBX1D8YIB7C+kD9o9KkJhF7hdijP0dhsVKCreaXtN
         rvD9YHoFflmKVG0vznLkWE8hYN4f6PJZG+3qrRc91RqEiUjs0auOYec8m6hnVnO5r+qu
         2anZr06FMQeXgk+81RIKmHDqTMxdd32xr443m3NkbV/C7HFsUV2xO1xj59RcD9CXXPbn
         lgig==
X-Gm-Message-State: AOAM532v2H+yeYdjKL5BsxfkOfdINhAc8fnlWYIwMnX1fIotiJ+OUFOg
        g5RfAyJP82/3qeQfkQc81dMQmmFlKAetiw==
X-Google-Smtp-Source: ABdhPJzAImexnNKFM16Gpe9M9fer3veNQ1r0ZlnTVi/gO6axHaH7Fm+/UZ++61Zu5FbjGTb1r/UVLw==
X-Received: by 2002:a37:f518:0:b0:663:a53:8a5b with SMTP id l24-20020a37f518000000b006630a538a5bmr7423397qkk.546.1646671472542;
        Mon, 07 Mar 2022 08:44:32 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85892000000b002de3a8bf768sm9339247qta.52.2022.03.07.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:44:32 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dc348dab52so137273847b3.6;
        Mon, 07 Mar 2022 08:44:31 -0800 (PST)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr9141838ywf.62.1646671471556; Mon, 07
 Mar 2022 08:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com> <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
In-Reply-To: <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Mar 2022 17:44:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
Message-ID: <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Wolfram,

CC Sergey, Prabhakar, Andrew,

On Tue, Sep 28, 2021 at 12:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On Wed, 22 Sep 2021 11:10:06 +0200, Wolfram Sang wrote:
> > This patch fixes 2 problems:
> > [1] The output warning logs and data loss when performing
> > mount/umount then remount the device with jffs2 format.
> > [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
> >
> > This is the sample warning logs when performing mount/umount then
> > remount the device with jffs2 format:
> > jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
> > Read 0x00034e00, calculated 0xadb272a7
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
>       commit: fff53a551db50f5edecaa0b29a64056ab8d2bbca

While trying to enable support for RPC on Salvator-X(S)[*], I
discovered HyperFLASH detection is broken:

    rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

Reverting all commits to the RPC driver since Sergey's original
commit 5de15b610f785f0e ("mtd: hyperbus: add Renesas RPC-IF driver")
fixed probing:

    rpc-if-hyperflash: Found 1 x16 devices at 0x0 in 16-bit bank.
Manufacturer ID 0x000001 Chip ID 0x007000
    Amd/Fujitsu Extended Query Table at 0x0040
      Amd/Fujitsu Extended Query version 1.5.
    rpc-if-hyperflash: CFI contains unrecognised boot bank location
(0). Assuming bottom.
    number of CFI chips: 1
    10 fixed-partitions partitions found on MTD device rpc-if-hyperflash
    Creating 10 MTD partitions on "rpc-if-hyperflash":
    0x000000000000-0x000000040000 : "bootparam"
    [...]

However, there's still something wrong, as all HyperFLASH contents read
back as zeros, while the FLASH contains the full boot loader stack.
Bisecting the reverts pointed to this patch, and just reverting this
patch (small whitespace conflict) fixes probing, too. Still, all zeros.

Summary: needs more investigation ;-)

Wolfram: which platform did you use for QSPI testing, so I don't
break that again?

[*] Firmware compiled with RCAR_RPC_HYPERFLASH_LOCKED=0 of course.
    Without that (e.g. old H3 R-Car ES1.0), it crashes with an
    Asynchronous SError Interrupt during driver initialization.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
