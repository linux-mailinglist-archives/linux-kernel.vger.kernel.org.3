Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184034D66E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbiCKQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiCKQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:56:49 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A2E1B68;
        Fri, 11 Mar 2022 08:55:45 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id 11so7755647qtt.9;
        Fri, 11 Mar 2022 08:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O04Tgt92cZNLvP3O4lxF6PDwJJc7vj4viTMsv34RNKk=;
        b=LM02D/hd9Fd42cKbhPd9qo8JsnRYGr9TgjzNlby5hS4akWw6ib74a2F0uPv25kymaw
         OgdWQAsJ4UJ9JV+/lLSzehZhayzuRKD8JyGZl42SSkoEN6Mkz+42qONoTQk1psvnqKE+
         zoRsdc76MAHt+MvJ2mB7jQAVliJTqCc9WRUHxA2yZ7J/81D/Xcp+L4J6XRk424sG2+83
         +5guugXPzxHsQhetF5JeknFtXKotTpP7Ywau5eCyGFLzNVAtoiQ4k7gfuYPuR67qMoOb
         4LgDKKur6Xpynoncnn6jwE801FSdpn+566ZF5SmSyOLs6J2DYfi0WEw5GDAtnz2OGGs3
         xClA==
X-Gm-Message-State: AOAM533qDS+L+n12b9SK1usPUbv7NqXifmcYh4gtTSL3XYA0y5/K53Fv
        La7GXBzjCyO9oit7wdZnJqDumJAiW8xbpA==
X-Google-Smtp-Source: ABdhPJycoxv6tjf51BFgs5FOR0zlp7buh4K/8ohlf0YtHSsNdGjz8x1tWyhzEAvbqeWKIwQEwT1ZBg==
X-Received: by 2002:a05:622a:1011:b0:2dd:5b59:66ed with SMTP id d17-20020a05622a101100b002dd5b5966edmr8896422qte.550.1647017744707;
        Fri, 11 Mar 2022 08:55:44 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id c35-20020a05620a26a300b0067d4eed36desm2814847qkp.130.2022.03.11.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 08:55:44 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id w16so18101885ybi.12;
        Fri, 11 Mar 2022 08:55:44 -0800 (PST)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr8674653ybn.6.1647017743779; Fri, 11 Mar
 2022 08:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com> <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
In-Reply-To: <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Mar 2022 17:55:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-uhw5u1joz9JK7kPh_E1zFzccVqo_GZFcs_EKkiq1cQ@mail.gmail.com>
Message-ID: <CAMuHMdV-uhw5u1joz9JK7kPh_E1zFzccVqo_GZFcs_EKkiq1cQ@mail.gmail.com>
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

On Mon, Mar 7, 2022 at 5:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Sep 28, 2021 at 12:36 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> > On Wed, 22 Sep 2021 11:10:06 +0200, Wolfram Sang wrote:
> > > This patch fixes 2 problems:
> > > [1] The output warning logs and data loss when performing
> > > mount/umount then remount the device with jffs2 format.
> > > [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
> > >
> > > This is the sample warning logs when performing mount/umount then
> > > remount the device with jffs2 format:
> > > jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
> > > Read 0x00034e00, calculated 0xadb272a7
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
> >       commit: fff53a551db50f5edecaa0b29a64056ab8d2bbca
>
> While trying to enable support for RPC on Salvator-X(S)[*], I
> discovered HyperFLASH detection is broken:
>
>     rpc-if-hyperflash rpc-if-hyperflash: probing of hyperbus device failed

I've sent an RFC fix, see
https://lore.kernel.org/all/27107f2d578b198078df841ee2e4d7b71b183898.1647017136.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
