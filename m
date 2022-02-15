Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324A4B7668
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbiBOTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:06:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiBOTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:06:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D92DA95
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:06:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w3so231308edu.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8fT1jITxEXv0d74qphSlqMJEk9MBPu5sIjQr+d/9sY=;
        b=nbMe6xa5ccdyHBW084IyHQVw+vIend9kQk4jZiIUpqWbg4Z1GFOZL3XOsH2DuNGfyZ
         nTtqDUK1j+p/Mj0NRyMkw5T1iYrVqxBIZw6Rmecw6Ek+pVeqv/TAwxTWDtwGhBhcBo7B
         SN5z6ZjXUABt1Y62HuKgrztqJ6z5+ye4SseRS5hCVBIzC11yv7e8LDoOwUaDjxZ6qjoI
         h34UsJO+pTd3L6Umr57Fhod5h8PNC9I6nWEaxd7hdDW7ALaRwH5qrdvoXg9SYyzOx94M
         6aeYp9paBfAXKO3udrUsO901FIFyoeurnJ540+y8devQcIsf8w/qCo1FgwSWRXWf5WN6
         E5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8fT1jITxEXv0d74qphSlqMJEk9MBPu5sIjQr+d/9sY=;
        b=MCjcqyA6YFy5MoB2ZuaAU3j1MveZs1HMEJtCf8jLPoI18E2XH6idtRyT2mrG0+Gzc3
         vbQWvhfW6gqeuhqSB1uAtmjKhJFdNuR0vN5Y31UFqCWeLVg8L5Gr51RuRVff3dhhRr2J
         P17L5scKj6btiUZMaMt08UINZaahGmPcG0cs5nv7eEDR4VsjeBc8MTEXNRL3iOOOtLgo
         +k0DGtUNAgw/d9av2/VAYH+LJhjqiLONU0gk3q5j2bMbmjQ6xajAvJ4ZbOJd7vyyycgt
         IIooz4ssxb4ncqz3EvyklA1RNfHiol8sGpx0W1aifYDH4bD2KiZZ91tyt4PrC+XdIL7A
         oIwQ==
X-Gm-Message-State: AOAM5330LrF7pI03UaZU3FuRQWjHnPdaMgSzb9Jd5xaLxwxDGwruAVFe
        1vxT4eIaWe6lkh93ZbAgjN8Ma4KTAYpSE0XoBPoBcA==
X-Google-Smtp-Source: ABdhPJwKWz49YOsJeeLn8Vu0A0KsVGCRfI6v+wh6/MKMWtUHy7PFRmz++HfRpep96WwWklWpix4D1JxPINlJTY+aI6A=
X-Received: by 2002:a05:6402:1601:: with SMTP id f1mr365734edv.165.1644951996023;
 Tue, 15 Feb 2022 11:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20220215090211.911366-1-atishp@rivosinc.com> <YgvNSeUekqEVS1yE@xhacker>
In-Reply-To: <YgvNSeUekqEVS1yE@xhacker>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Tue, 15 Feb 2022 11:06:24 -0800
Message-ID: <CAHBxVyF65jC_wvxcD6bueqpCY8-Kbahu1yxsSoBmO1s15dGkSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Provide a fraemework for RISC-V ISA extensions
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 8:04 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 01:02:05AM -0800, Atish Patra wrote:
> > This series implements a generic framework to parse multi-letter ISA
> > extensions. This series is based on Tsukasa's v3 isa extension improvement
> > series[1]. I have fixed few bugs and improved comments from that series
> > (PATCH1-3). I have not used PATCH 4 from that series as we are not using
> > ISA extension versioning as of now. We can add that later if required.
> >
> > PATCH 4 allows the probing of multi-letter extensions via a macro.
> > It continues to use the common isa extensions between all the harts.
> > Thus hetergenous hart systems will only see the common ISA extensions.
> >
> > PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
> > via /proc/cpuinfo.
> >
> > Here is the example output of /proc/cpuinfo:
> > (with debug patches in Qemu and Linux kernel)
> >
> > / # cat /proc/cpuinfo
> > processor     : 0
> > hart          : 0
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > processor     : 1
> > hart          : 1
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > processor     : 2
> > hart          : 2
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > processor     : 3
> > hart          : 3
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > Anybody adding support for any new multi-letter extensions should add an
> > entry to the riscv_isa_ext_id and the isa extension array.
> > E.g. The patch[2] adds the support for various ISA extensions.
>
> Hi Atish,
>
> Thanks for this series. I'm thinking cpu features VS ISA extenstions.
> I'm converting the sv48 to static key:
> https://lore.kernel.org/linux-riscv/20220125165036.987-1-jszhang@kernel.org/
>
> Previously, I thought the SV48 as a cpu feature, and there will be
> more and more cpu features, so I implemented an unified static key
> mechanism for CPU features. But after reading this series, I think
> I may need to rebase(even reimplement) the above patch to your series.
> But I'm a bit confused by CPU features VS ISA extenstions now:
>
> 1. Is cpu feature  == ISA extension?
>
> 2. Is SV48 considered as ISA extension?
> If yes, now SV48 or not is determined during runtime, but current ISA
> extensions seem parsed from DT. So how to support those ISA extensions
> which can be determined during runtime?
>
> Could you please share your thought?
>

Here are my two cents:

I think the cpu feature is a superset of the ISA extension.
cpu feature != ISA extension.

While all ISA extensions are cpu features, all CPU features may not be
an ISA extension.
e.g. sv48 is not a ISA extension but F/D are (used to set the
cpu_hwcap_fpu static key)

Moreover, not all cpu feature/ISA extension requires a static key.
e.g SSTC extension will require a static key because the check has to
happen in the hot path.
However, sscofpmf extension don't need a static key as the check
happens only one time during boot.

We should keep these two separate but a common static framework would
be very useful.

Here is the flow that I have in my mind.
1. All ISA extensions will be parsed through riscv,isa DT property
2. Any supported/enabled extension will be set in riscv_isa bitmap
3. Any extension requiring a static key will invoke the cpus_set_cap.

cpus_set_cap will be invoked from a different code path that uses a
static key for a specific ISA
extension or a CPU feature.

The only problem I see here is that we have to set a bit in both
cpu_hwcaps & riscv_isa bitmap.
We also have to define the value of that bit for any extension
requiring a static key twice as well.

I think that should be okay. But I would like to hear what everybody
else thinks as well.

> Thanks
