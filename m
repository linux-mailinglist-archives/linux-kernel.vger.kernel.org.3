Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E24D1242
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiCHIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbiCHIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:31:14 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D53F88A;
        Tue,  8 Mar 2022 00:30:18 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id bm39so14252954qkb.0;
        Tue, 08 Mar 2022 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dHuw8rcBQo8eimNFyCyzKNs2ir0oOakCUjJ/z8E/Csw=;
        b=1bh7vXh/sgBPE29dk1rsgZCZ2J6OcefvUB8nj2cU9pEosSap/6RhX6BuA5pROhDMUx
         2kJ5WOXd5BVlxu2QpDf8SkY18M0xlIgnT5h/XSktGMfd6ckOmCW33/xSNs/uDw43qu2w
         G+EhQ5eqnu8YuH0oR/yRoESyJqPnYj7Z+DvfNPjt2O0pksszX7becVbaIkE0ZjotpKvR
         yYjw9+N80FL4Cgt8L4vLk4SpvF/SkMc4kISPjyAmxwPpAcAI5hO/YTdedeA69Ax9RYlD
         DnBC0HXBXKbFF3nRXG+8gjBxumZ3vCyRvLEPFxteSdgYMRJKE9fF6bZ/y4anggpIPAX7
         UxUA==
X-Gm-Message-State: AOAM5337Gpoe8TO+sOuz37LxbTdixJKnSqx4Qdoyg2bVyjAXyNrq6y4i
        IVbDPHr/wkv1IUWVnzzVj7TDYQfW36T7Kg==
X-Google-Smtp-Source: ABdhPJzHQpigLxGNWNelrn8HyYzFXR1cCJNZSQ7Smgm93R+NtSzGDOqG8S4hxq+IBephv+EtrnAFLQ==
X-Received: by 2002:a05:620a:d87:b0:67b:3105:4f7f with SMTP id q7-20020a05620a0d8700b0067b31054f7fmr5231622qkl.230.1646728216805;
        Tue, 08 Mar 2022 00:30:16 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g9-20020ac85d49000000b002dff273cce5sm10339753qtx.72.2022.03.08.00.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:30:15 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id u10so16418158ybd.9;
        Tue, 08 Mar 2022 00:30:09 -0800 (PST)
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr11274013ybp.506.1646728209389; Tue, 08
 Mar 2022 00:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
 <163282533892.34438.1878675609177525004.b4-ty@canonical.com>
 <CAMuHMdUqQLo7=NFaNEukqniTJbx-mSZv7eQNB9eCT=L28y3u=A@mail.gmail.com> <YicSCZfl4wLUzvEJ@shikoro>
In-Reply-To: <YicSCZfl4wLUzvEJ@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 09:29:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTgooY6SRfp4LB3tSa=-GtS0EH=BD5zo5orLTKp0hjBg@mail.gmail.com>
Message-ID: <CAMuHMdUTgooY6SRfp4LB3tSa=-GtS0EH=BD5zo5orLTKp0hjBg@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Wolfram,

On Tue, Mar 8, 2022 at 9:21 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Wolfram: which platform did you use for QSPI testing, so I don't
> > break that again?
>
> I did my refactoring using an Eagle board and once this worked, I
> enabled QSPI on Falcon. All remotely. Condor was another candidate but
> it was broken in the lab at that time.

OK, thanks!

> >     Without that (e.g. old H3 R-Car ES1.0), it crashes with an
>
> Frankly, I wouldn't trust ES1.0 as a reliable source for QSPI. Could you
> start with the newest Gen3 board you have and then go to previous ones?

This is not QSPI, but HF.

Building a new firmware for R-Car H3 ES1.0 with HF unlocked will be
complicated, as it is not supported by upstream TF-A.

Note that HF also fails to probe on R-Car M3-W and M3-N ES1.0.
Haven't tried it on R-Car E3 yet.  All those have a (not so new) TF-A,
but built with RCAR_RPC_HYPERFLASH_LOCKED=0.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
