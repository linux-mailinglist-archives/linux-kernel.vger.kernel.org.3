Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C74C17C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiBWPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiBWPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:54:20 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AFBBF977
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:53:52 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id d26so3717793vsh.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIx/w/JaW8zkDiSm75GIlzZSmQLMtN2o2T6d9jTYA74=;
        b=NE4nYcAbVbqEfB2/mnSwmPdmvyHVq6ReGFkiVoXygQjl0YPUissmhuU4oCJLMcryls
         x6pInTggW6pafKJ77mU3TN4ZiLpeL23Y4W42+UuRygN7Zl4CsNjPh1KhkunQ+TVw2ZPh
         WVv7e0rVKCP09Ghxob5jA+K6CHmc02KuZ6lbg36P3Y2Tvr+XIktJw7vgYXnbbI0MS0Nv
         oruuu2WkFr0TibWWNOFLiKJEUVSd3zkj+y3ayWg9ohaN8x5jk+M5HVQTz3vhhzzELmBy
         ZIotKlciFwVw6i/LxrRnmRm4fVnr4l6E4FOtZeBssEPJ9FW6zAlxTxSV86L7TNb5qm0I
         V8GA==
X-Gm-Message-State: AOAM530TE1UsBWfz99EI7oa61sp71iM8/Aii4dxruhuUz+MxDDroAcaS
        U4fSFDvk6DvS5SPkjD5mXAeYy/hLJVezmz0kNZU=
X-Google-Smtp-Source: ABdhPJy3Ie7oJJiHWZ6cMvIKFrF6U/4qjDWoKv17MzEv+zaCPSAhSW+HsBN2A2MmTtLGAUBGUKYjvUQjticqZId0p1w=
X-Received: by 2002:a67:ab4d:0:b0:31c:3539:9569 with SMTP id
 k13-20020a67ab4d000000b0031c35399569mr31237vsh.67.1645631631196; Wed, 23 Feb
 2022 07:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20220131182720.236065-1-kernel@esmil.dk> <mhng-8e6926b7-c690-4398-a70a-072b11d7e6fa@palmer-ri-x1c9>
In-Reply-To: <mhng-8e6926b7-c690-4398-a70a-072b11d7e6fa@palmer-ri-x1c9>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 23 Feb 2022 16:53:39 +0100
Message-ID: <CANBLGcxeO0uYutsAHP-TKRCjRqLqbUy-rvK1vcX02eDe0445Hg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Module relocation fixes and asm/insn.h header
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 23 Feb 2022 at 00:15, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Mon, 31 Jan 2022 10:27:13 PST (-0800), kernel@esmil.dk wrote:
> > Apologies! I messed up v1. Please consider this patch set only.
> >
> > The first patch removes a bunch of code from the asm/module.h which is
> > included in almost all drivers through linux/module.h. Next are two
> > patches to fix unaligned access when doing module relocations and do
> > proper range checks for auipc+jalr offsets.
> >
> > I'm a little less confident about the following patches, so consider
> > this more of an RFC for those. The idea is to consolidate the RISC-V
> > instruction generation and manipulation similar to arm64's asm/insn.h
> > header.
> >
> > /Emil
> >
> > Emil Renner Berthing (7):
> >   riscv: Remove unneeded definitions from asm/module.h
> >   riscv: Avoid unaligned access when relocating modules
> >   riscv: Fix auipc+jalr relocation range checks
> >   riscv: Add asm/insn.h header
> >   riscv: Use asm/insn.h for module relocations
> >   riscv: Use asm/insn.h to generate plt entries
> >   riscv: Use asm/insn.h for jump labels
> >
> >  arch/riscv/include/asm/insn.h       | 121 ++++++++++++++
> >  arch/riscv/include/asm/module.h     |  87 ----------
> >  arch/riscv/kernel/jump_label.c      |  12 +-
> >  arch/riscv/kernel/module-sections.c |  71 +++++++++
> >  arch/riscv/kernel/module.c          | 237 +++++++++++++---------------
> >  5 files changed, 306 insertions(+), 222 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/insn.h
>
> These generally look good to me, though there's a lot of bit-field
> twiddling so I'll take another look before merging it.  There's a
> handful of minor issues:
>
> * There's a fix in here, mixed into the cleanups.  It's generally best
>   to split those out.

There are two fixes. The 32bit range check on rv64 and unaligned 32bit
access. The code has been like that for years so I was unsure if they
were worth splitting out and adding early. Since you only mention one
I guess that's the range check. I'll send that separately.

> * There's another copy of the insn patterns in our BPF JIT, it'd be nice
>   to clean that up too.  That can be a follow-on, though.
> * It's 2022, but there's some 2020 copyrights.  If this really is old
>   stuff that's OK, I just wanted to check.

Nice catch, but the year is actually correct. These patches have been
well aged in my local repo. The reason is exactly that I never got
around to doing the BPF conversion, so now I decided to just send them
and see if it was worth finishing.

> I'm usually OK just re-ordering patches myself, but I figured I'd have
> to ask about the copyright dates anyway.  LMK if you want to send a v2
> with the fix pulled to the front, and what you want me to do about the
> copyright dates (if you're going to send a v2 then just fix them, but if
> you're not then just telling me is OK).

Thank you. I'll send the range check separately and a v2 converting
the "if (IS_ENABLED(CONFIG_32BIT))" to an #ifdef to avoid the warning
the kernel test robot found.
