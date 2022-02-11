Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CC4B267E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiBKMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:52:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiBKMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:52:32 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F07B49;
        Fri, 11 Feb 2022 04:52:31 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id l14so4866419vko.12;
        Fri, 11 Feb 2022 04:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3yMDJ4AXnEfuVrUfk2PsPl0dHnN7EmeDB26b3zVqHM=;
        b=vybAruLz4Wi3DoQ9eK8XZGFfIdApwZMDa7tD+/ELOXpN1NhwSBEwBd4J/ez6uWiD3x
         NefjvmJjpc7vvcekmtQtQGLyfpQNZ0CzYJfz3cqj1j8MoUfmPm5dca81ZsGCLiIObjzS
         1DFn/mFCB0SKADFeQAn7aEl/i/BWiIsEHz+gFgSfqUiobeJdSVGsMh67t6O4rR+7eAvz
         gMAAM8ZZYPwI47o0oj3RtgNx49GQeAgtCnUhbWoY69HSuo0jwJUX3Ponc/N25ATHEca+
         Yn5chKlA2M5pPugz1Of+99F/JhMuLs0F1OABngKHhhY3k0zQCaQ+CMj5reInLnSMSrrX
         rNng==
X-Gm-Message-State: AOAM531Q+tbZ4M/u1pH5grSfrS9OSDK9+4EJ9jDf9LivSPyw6eLTcJz7
        2zokc5SIDJhg7x+0vEcxUooYCLykT20/Jg==
X-Google-Smtp-Source: ABdhPJxtPek9Ni2xvdqaahx4TS6LnNI/5fz0HZFAX4wP3sZdzjDGvfhrxydhzfazV4Gf59hGjMwuGA==
X-Received: by 2002:a1f:2681:: with SMTP id m123mr396142vkm.19.1644583950258;
        Fri, 11 Feb 2022 04:52:30 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id b190sm1643697vsc.5.2022.02.11.04.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:52:29 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id u134so5308786vsu.8;
        Fri, 11 Feb 2022 04:52:29 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr415124vst.68.1644583948840;
 Fri, 11 Feb 2022 04:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20220210214018.55739-1-atishp@rivosinc.com> <20220210214018.55739-6-atishp@rivosinc.com>
 <877da2xu32.fsf@igel.home>
In-Reply-To: <877da2xu32.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Feb 2022 13:52:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4P82B96ZbANyF6cWo9CnrW9hg5up6pCb0PZ99=sPZ_A@mail.gmail.com>
Message-ID: <CAMuHMdX4P82B96ZbANyF6cWo9CnrW9hg5up6pCb0PZ99=sPZ_A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] RISC-V: Do no continue isa string parsing without
 correct XLEN
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
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

Hi Andreas,

On Thu, Feb 10, 2022 at 11:00 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Feb 10 2022, Atish Patra wrote:
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 469b9739faf7..cca579bae8a0 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
> >       for_each_of_cpu_node(node) {
> >               unsigned long this_hwcap = 0;
> >               uint64_t this_isa = 0;
> > +             char *temp;
> >
> >               if (riscv_of_processor_hartid(node) < 0)
> >                       continue;
> > @@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
> >                       continue;
> >               }
> >
> > +             temp = (char *)isa;
>
> There should be no need for this cast.

Indeed, but only if "temp" is changed to "const char *".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
