Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D2F4D12FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbiCHJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbiCHJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:02:46 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FCC3914F;
        Tue,  8 Mar 2022 01:01:50 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id r127so3254640qke.13;
        Tue, 08 Mar 2022 01:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0A3fiI6SF5FkbWt8i2s+Fk+OXU1UOQjwNrha0L6c9s=;
        b=c/ovzKt+T8ns6swRibqXcCl7nCDL1fq3Jd6+PazKY10o8Y0cTuSETuD8flOloIRL36
         YQ148lbHU+LUV7ksREOVF0/feHykb+mESh//Xt8z9dQOHzNbJAoxn2rqC0jRaYNPDBDc
         b5ZTkLLpcuJB3TgCqPdWZeY1/REzye/dZhvJU4BRAACdoKdxSzOIvLALm9juG4uTj6Nl
         IErpRlljmKK3b2B7LdyDzdGOC2kTNIDbU1Sd7ILyOy1yMPZ7foeDx1G3Ex5yfBaWA7/9
         qpUpUjF0b1YP8xw/ogWHI6MuFzzfKXKm/IOX700ozI4J27WLHt5m/ogDmbrkb9ONbqtB
         mrsQ==
X-Gm-Message-State: AOAM531HgdLxbhTowQYNbo9sdVN6aZ3YvbWXuf3iBJutSlaycoglxS35
        wEvr6PlwfDRndbvSyYroJ8A5cCsOrllEFA==
X-Google-Smtp-Source: ABdhPJxk+Uyi25qvPlYvu1p4PomyOf9VNNgEc1JsPXCUH71SY4dDPeLAUOc1dWQlbZCkMTdvlwUdsw==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr217701qkb.142.1646730109522;
        Tue, 08 Mar 2022 01:01:49 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm1596499qke.122.2022.03.08.01.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:01:49 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d6d0cb5da4so193403507b3.10;
        Tue, 08 Mar 2022 01:01:48 -0800 (PST)
X-Received: by 2002:a81:5247:0:b0:2dc:2171:d42 with SMTP id
 g68-20020a815247000000b002dc21710d42mr11891435ywb.438.1646730108371; Tue, 08
 Mar 2022 01:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com>
 <YicSCZfl4wLUzvEJ@shikoro> <CAMuHMdUTgooY6SRfp4LB3tSa=-GtS0EH=BD5zo5orLTKp0hjBg@mail.gmail.com>
 <YicX67PsQO0+bMTZ@shikoro>
In-Reply-To: <YicX67PsQO0+bMTZ@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 10:01:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6h8s0AaonKGNwmqriMikC5tUXjrtoXURqqN4w+ZM5eg@mail.gmail.com>
Message-ID: <CAMuHMdX6h8s0AaonKGNwmqriMikC5tUXjrtoXURqqN4w+ZM5eg@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Wolfram,

On Tue, Mar 8, 2022 at 9:46 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > This is not QSPI, but HF.
>
> Ah, okay.
>
> > Building a new firmware for R-Car H3 ES1.0 with HF unlocked will be
> > complicated, as it is not supported by upstream TF-A.
>
> You mean QSPI here?

No, HF. Salvator-X(S) boots from HF.

> > Note that HF also fails to probe on R-Car M3-W and M3-N ES1.0.
>
> Do you have this patch form Andrew in your tree:
>
> [PATCH] memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash

Sure I have it. It's in v5.16 ;-)

> Even if so, I don't think that reverting patches is the solution. As you

Sure, a plain revert is definitely not the right solution.

> could see from Andrew's patch, HyperFlash was also broken before and it
> just may need more fixes for Gen3 perhaps? IIRC my patches didn't break
> Andrew's tests but maybe we should ask him again. Maybe Andrew has also
> some more ideas, I only did QSPI.

My understanding from reading the threads is that Andrew's patch and
yours arrived in parallel, and are believed to fix two different and
non-intersecting things (QSPI vs. HF).  I also found no explicit mention
that Andrew tried your patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
