Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C44F6885
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiDFRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbiDFRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:49:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DF3D6BB9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:57:14 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2eafabbc80aso30931687b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=84EMPqH9WpwtuHrcr1IQIWhJzRU+DO0KEyaC8T4lTek=;
        b=lHcL8UWD3WQP1Gm7jd2rSbEMiR2/Vf0fPUeKtqkPKPaqykfDGZkrPqboW+CAGw2uWu
         efXel6aI2NzanG6nEkly96kzPmhOgBt9TM/I+b5pwcczE0fbyd5WghrHNLmfNE+CqgPq
         B1W9aXJXDZTFEl/LGGyDFq/XlXqdzjRhwh0cnOhF2yrD+iyJODDlvYoMi9HSo/CtTvV/
         3aidL5hupzf66Iizvo6pCSROsZim89YmNKrEXJo5yQjO2GrvgqGuygSwvpTemvD1ATGq
         lj3HyS6+PwjHXezYP4xCwnO2IJ1fQbcBYsKrF5egihDKDVxX3F6nEjEJKaeuAxcLg3V3
         iORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84EMPqH9WpwtuHrcr1IQIWhJzRU+DO0KEyaC8T4lTek=;
        b=dD5qMOLJr8z8yOV0cHG3zo4k1daplewtWBP2xhZQCp5tADEwMIqahBdvb5N0QJqTaY
         nXxZhiJMaiSKmSlvWJ6OZMzrWVE1QBCAKHzR2/sexkOAUQYWl0pM6+chuRzc1S6wze0n
         huKq4YfHs+sSlJQKAvj+GcYhGgW0kf7V2oz827bYBiHQtRlUh5Tn4Ilw7a+8aJQL0+zb
         dmHg53P+DdnQo2I2EVFB5vEkHE3Spor2O7Tj+lu3asljab6dLsXQgLOlZD2no7X6Omqh
         qeiRMkjFfX2p5FNdxomBPSqiGsPhZYoHz1825spJllS4y5pRFafxFrfOV6CFGjqW5G1Z
         gbQA==
X-Gm-Message-State: AOAM531ATNZJtVWDRsOHFIw2aQRB7hIw9Y7NPIIKJIOLVR/ekw06Rt5B
        2OIKDjDB1k2D4x1IIQIxfqXw6hYMcWTUNyEpyAHtEDFEdiE=
X-Google-Smtp-Source: ABdhPJy0T3AtDRbkBDH0ndPnulO2UOZPKBwi1bmduQCeiINFsWEXhd3GqJV5iLZAbGLb8Tvkk6sePaT9b+9QlZL3PNw=
X-Received: by 2002:a81:1a03:0:b0:2eb:5222:5e40 with SMTP id
 a3-20020a811a03000000b002eb52225e40mr7528650ywa.231.1649260633426; Wed, 06
 Apr 2022 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 6 Apr 2022 23:57:02 +0800
Message-ID: <CAJhGHyAbggnqcKRoL90sO6i8vG2o04Po_s_S92a6xTNfWVWHVw@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] x86/entry: Clean up entry code
To:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Borislav

Could you please review it again? The patches can still be applied
perfectly with the newest tip/master 7bcafc1e843a ("Merge x86/cpu
into tip/master") and work well.  And the patches almost have
nothing changed since your last review except only squashing and
reordering.


Hello, tglx

I=E2=80=99d like to hear your views on the patches.  It is a part of the
patchset which converts ASM code to C code which I think is a nice
foil for your previous excellent x86/entry work.  It reduces the
ASM code without any functionality change and makes entry code more
readable and maintainable.  I came up with the idea when I was
reviewing your patches.


Thanks
Lai


On Fri, Mar 18, 2022 at 10:29 PM Lai Jiangshan <jiangshanlai@gmail.com> wro=
te:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> This patchset moves the stack-switch code to the place where
> error_entry() return, unravels error_entry() from XENpv and makes
> entry_INT80_compat use idtentry macro.
>
> This patchset is highly related to XENpv, because it does the extra
> cleanup to convert SWAPGS to swapgs after major cleanup is done.
>
> The patches are the 4th version to pick patches from the patchset
> https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com=
/
> which converts ASM code to C code.  These patches are prepared for that
> purpose.  But this patchset has it own value: it simplifies the stack
> switch, avoids leaving the old stack inside a function call, and
> separates XENpv code with native code without adding new code.
>
> Peter said in V3:
> >       So AFAICT these patches are indeed correct.
> >
> >       I'd love for some of the other x86 people to also look at this,
> >       but a tentative ACK on this.
>
> Other interactions in V3:
>         Peter raised several questions and I think I answered them and I
>         don't think the code need to be updated unless I missed some
>         points. (Except reordering the patches)
>
>         Josh asked to remove UNWIND_HINT_REGS in patch5, but I think
>         UNWIND_HINT_REGS is old code before this patchset and I don't
>         want to do a cleanup that is not relate to preparing converting
>         ASM code C code in this patchset.  He also asked to remove
>         ENCODE_FRAME_POINTER in xenpv case, and I think it just
>         complicates the code for just optimizing out a single assignment
>         to %rbp.  I would not always stick to these reasons of mine,
>         but I just keep the code unchanged since he hasn't emphasized it
>         again nor other people has requested it.
>
> Changed from V3:
>         Only reorder the int80 thing as the last patch to make patches
>         ordering more natural. (Both orders are correct)
>
> Changed from V2:
>         Make the patch of folding int80 thing as the first patch
>         Add more changelog in "Switch the stack after error_entry() retur=
ns"
>
> Changed from V1
>         Squash cleanup patches converting SWAPGS to swapgs into one patch
>
>         Use my official email address (Ant Group).  The work is backed
>         by my company and I was incorrectly misunderstood that
>         XXX@linux.alibaba.com is the only portal for opensource work
>         in the corporate group.
>
> [V3]: https://lore.kernel.org/lkml/20220315073949.7541-1-jiangshanlai@gma=
il.com/
> [V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gm=
ail.com/
> [V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gm=
ail.com/
>
> Lai Jiangshan (7):
>   x86/traps: Move pt_regs only in fixup_bad_iret()
>   x86/entry: Switch the stack after error_entry() returns
>   x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
>   x86/entry: Move cld to the start of idtentry
>   x86/entry: Don't call error_entry for XENPV
>   x86/entry: Convert SWAPGS to swapgs and remove the definition of
>     SWAPGS
>   x86/entry: Use idtentry macro for entry_INT80_compat
>
>  arch/x86/entry/entry_64.S        |  61 +++++++++++++-----
>  arch/x86/entry/entry_64_compat.S | 105 +------------------------------
>  arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
>  arch/x86/include/asm/irqflags.h  |   8 ---
>  arch/x86/include/asm/proto.h     |   4 --
>  arch/x86/include/asm/traps.h     |   2 +-
>  arch/x86/kernel/traps.c          |  17 ++---
>  7 files changed, 100 insertions(+), 144 deletions(-)
>
> --
> 2.19.1.6.gb485710b
>
