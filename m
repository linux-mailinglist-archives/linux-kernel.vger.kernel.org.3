Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DF50843B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377008AbiDTI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349589AbiDTI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:57:10 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2713B3E6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:54:24 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f16645872fso10795017b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLb6JbYsWBBApP0Mc9bUp5iLpj1TLGjQFNYgA4f58jY=;
        b=Z5uO5aHIflhbnOadvmxDtFLCizKRo1UqS7cTKCrhpc4fG4g6SUUUMFIKuoHkr+Num2
         n07blE0e5TZu46EsQ1SS0MUjLsKnU21sr2iJIV2WHWoDFF63kyvIch+not84gEOjExGr
         0IbUg8b/5jSjlcTPry4Ila/roGc69AVBSeE7Ukh7ph+ub9oBZCGntsoXfYSCzQifN+B2
         rqQbVyFMw08on2jkL5R7HavrzQMK8WFn9yzYOBleSYdCGypDe/5C6CeEROqEFF5pC5xe
         PyEjGcuor5dZd+V3sp8HqwDjp6OgM5kPSra2+hkFvBBMCcmJXjz2AOFGP9zYlkvjET4h
         ZbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLb6JbYsWBBApP0Mc9bUp5iLpj1TLGjQFNYgA4f58jY=;
        b=BUfLSPrtVJk2rnJXiq0nV4trzpWI09r1ntg+eviMiDoJU8qbPG75K5sHPMexQ9G/B2
         iYWPlASARk7aar5FklrP7P5kldpLfNTr7ncBFF5zb8m6kCGpIWQsgYDLBGkTEg1dln8i
         bDNw61tGbMGRyzzkykwAvYFWMeQESOc9WSfm8QwLwzgLZmVamPfxDva53pgYrGjJQY25
         o/Dnrc6gQaMhUatf4nVzJcKr+h6k64cqW5gBS25WCZHDiloU1f6wPdmBlq+m8RZ7aVD2
         ZSUonCXmjg/xUqVGeAjmQjGYllxSd2OAnKyreGfrDQvG2dqD6WhxyCXdymHsYzSfdpUk
         umzw==
X-Gm-Message-State: AOAM531gXxviuTbedBtUjhXjI9+oaYCMmipM+obhaNPbzvjLZChPb3pd
        lyZ+FHI6/l/CXXJDs/kBz3MMOj1aWtfuMO11pUEN6A==
X-Google-Smtp-Source: ABdhPJxqWslF3f2CGWOJcNab6oG/sR2XviNs/WLvatn0fSI5Dx9gYNvanGHc1PAgK+WrJakb5fgu0yUuCX9H2BE5UBQ=
X-Received: by 2002:a81:6dc7:0:b0:2f1:c5bf:8f64 with SMTP id
 i190-20020a816dc7000000b002f1c5bf8f64mr8609703ywc.120.1650444863090; Wed, 20
 Apr 2022 01:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
 <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
In-Reply-To: <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Apr 2022 14:24:11 +0530
Message-ID: <CA+G9fYtv8D2eR4dME6Ecx4sPpBcBtKerdZxcxsqfaCJdKVa3VQ@mail.gmail.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        max.krummenacher@toradex.com, Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 13:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 19 Apr 2022 at 12:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> > x15 device.
> >
> > kernel crash log from x15:
> > -----------------
> > [    6.866516] 8<--- cut here ---
> > [    6.869598] Unable to handle kernel paging request at virtual
> > address f000e62c
> > [    6.876861] [f000e62c] *pgd=82935811, *pte=00000000, *ppte=00000000
> > [    6.883209] Internal error: Oops: 807 [#3] SMP ARM
> > [    6.888000] Modules linked in:
> > [    6.891082] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D W
> >   5.18.0-rc3-next-20220419 #1
> > [    6.899993] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [    6.906127] PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> > [    6.911041] LR is at handle_mm_fault+0x60c/0xed0
> > [    6.915679] pc : [<c031f26c>]    lr : [<c04cfeb8>]    psr: 40000013
> > [    6.921966] sp : f000dde8  ip : f000de44  fp : a0000013
> > [    6.927215] r10: 00000000  r9 : 00000000  r8 : c1e95194
> > [    6.932464] r7 : c3c95000  r6 : befffff1  r5 : 00000081  r4 : c29d8000
> > [    6.939025] r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : f000de2c
> > [    6.945587] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [    6.952758] Control: 10c5387d  Table: 8020406a  DAC: 00000051
> > [    6.958526] Register r0 information: 2-page vmalloc region starting
> > at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> > [    6.969299] Register r1 information: non-paged memory
> > [    6.974365] Register r2 information: NULL pointer
> > [    6.979095] Register r3 information: NULL pointer
> > [    6.983825] Register r4 information: slab task_struct start
> > c29d8000 pointer offset 0
> > [    6.991729] Register r5 information: non-paged memory
> > [    6.996795] Register r6 information: non-paged memory
> > [    7.001861] Register r7 information: slab vm_area_struct start
> > c3c95000 pointer offset 0
> > [    7.010009] Register r8 information: non-slab/vmalloc memory
> > [    7.015716] Register r9 information: NULL pointer
> > [    7.020446] Register r10 information: NULL pointer
> > [    7.025238] Register r11 information: non-paged memory
> > [    7.030426] Register r12 information: 2-page vmalloc region
> > starting at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> > [    7.041259] Process swapper/0 (pid: 1, stack limit = 0xfaff0077)
> > [    7.047302] Stack: (0xf000dde8 to 0xf000e000)
> > [    7.051696] dde0:                   c29d8000 00000cc0 c20a1108
> > c2065fa0 c1e09f50 b6db6db7
> > [    7.059906] de00: c195bf0c 17c0f572 c29d8000 c3c95000 00000cc0
> > 000befff befff000 befffff1
> > [    7.068115] de20: 00000081 c3c3afb8 c3c3afb8 00000000 00000000
> > 00000000 00000000 00000000
> > [    7.076324] de40: 00000000 17c0f572 befff000 c3c95000 00002017
> > befffff1 00002017 00002fb8
> > [    7.084564] de60: c2d04000 00000081 c29d8000 c04c6790 c20d01d4
> > 00000000 00000001 c20ce440
> > [    7.092773] de80: c1e10bcc fffff000 00000000 c2a45680 eeb33cc0
> > c29d8000 00000000 c2d04000
> > [    7.100982] dea0: befffff1 f000df18 00000000 00002017 c20661a0
> > c04c77e8 f000df18 00000000
> > [    7.109222] dec0: 00000000 c1d95c40 00000002 c20661e0 00000000
> > 00000001 00000000 c04c7ad0
> > [    7.117431] dee0: 00000011 c2d02a00 00000001 befffff1 c29d8000
> > 00000000 00000011 c2a30010
> > [    7.125640] df00: c29d8000 c0524c24 f000df18 00000000 00000000
> > 2cd9e000 c1d95c40 17c0f572
> > [    7.133850] df20: 00000000 c2d02a00 0000000b 00000ffc 00000000
> > befffff1 00000000 c0524f74
> > [    7.142089] df40: c1e0e394 c2d02a00 c209a71c 38e38e39 c29d8000
> > bee00008 c2d02a00 c2a30000
> > [    7.150299] df60: c1e0e394 c1e0e420 00000000 00000000 00000000
> > c05266bc c209a000 c1944c60
> > [    7.158508] df80: 00000000 00000000 00000000 c129d2b4 c209a000
> > c1e0e394 00000000 c12b5600
> > [    7.166748] dfa0: 00000000 c12b5518 00000000 c0300168 00000000
> > 00000000 00000000 00000000
> > [    7.174957] dfc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [    7.183166] dfe0: 00000000 00000000 00000000 00000000 00000013
> > 00000000 00000000 00000000
> > [    7.191406] Code: 13110001 12211b02 13110b02 03a03000 (e5a03800)
>
> This decodes to
>
>    0: 13110001 tstne r1, #1
>    4: 12211b02 eorne r1, r1, #2048 ; 0x800
>    8: 13110b02 tstne r1, #2048 ; 0x800
>    c: 03a03000 moveq r3, #0
>   10:* e5a03800 str r3, [r0, #2048]! ; 0x800 <-- trapping instruction
>
> and R0 points into the stack. So we are updating a PTE that is located
> on the stack rather than in a page table somewhere, which seems very
> odd. However, this could be a latent bug that got uncovered by the
> VMAP stacks changes.
>
> Unfortunately, the vmlinux.xz file I downloaded from the link below
> seems to be different from the one that produced the crash, given that
> the LR address of c04cfeb8 does not seem to correspond with
> handle_mm_fault+0x60c/0xed0.
> Can you please double check the artifacts?

You can find the vmlinux.xz for the trace log I have pasted.

vmlinux.xz : https://builds.tuxbuild.com/280TS8MuM6sYWk5aUtrvWIw0RQ7/vmlinux.xz
artifact-location: https://builds.tuxbuild.com/280TS8MuM6sYWk5aUtrvWIw0RQ7

- Naresh
