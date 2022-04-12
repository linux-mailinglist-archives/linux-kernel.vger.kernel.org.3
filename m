Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924A54FE316
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356363AbiDLNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356343AbiDLNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE057B29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:52:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ec42eae76bso52109087b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njLwfv8x5JN57bKLpVncTJBpmJAluBvNUAao+ufJQVs=;
        b=IUcm7168yr61eaw7ivYWGEyT23AxhnCbYXke4iUGZgMbINLFHJLuAItPbIIPTGF1hu
         iQHMFqsZTIuHg1PyUwDsS6saljpW9ifCzLiLGy0z39XxrH9vu0jyLJsbdVPxsCphmzYv
         J4ss2fxbbCO017Bs+QOJuRDFC9XaaPVyCc7y69IuVwe4p+V77qA0SmCciDRIdsyrB7SD
         i3Ax2glCeFiLPlWZJg9L0ctgopKhOnD0RPLYR3O04FJa1nkHQCd+v0GcM/jn7F818ig0
         8CJCcFwfJkri1xlmaqs3UyN6LlyHA6Nlkq2dXJUy+Y0H+D8ZUG2CERUaaM2vX0JUdu6B
         IlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njLwfv8x5JN57bKLpVncTJBpmJAluBvNUAao+ufJQVs=;
        b=XS25Oy8/fDUlmFRFjJ3ykYFB0u9v4x1WALKYl+iYRzW6oJtG0mL9AxX/Ec9idivCyi
         2B4qOjH/LKjXb+iAYFH7MePzj5FKuI9LYMZSCgYL/r5GCXWTyJq81bHqJwf/VhQGWubG
         snX8gVA9/Yl/LH1rxNw6qGdm6j2DtoP0OS4G9k0GCcb8wXDK6IVDP04n0mFm0xPGGCSv
         vbzDPXCBt00qSBcKkPaKJgKyEJfu+Ua9jSyz51+iok71X/ME3x8IW1pEsLdDofb1KXXh
         IhKoTkaqfL6skzqQydLw5wAi/evaCl1m/xjMJIXVsGgw087EreRCZLsOfC23Y7x95VVi
         xojA==
X-Gm-Message-State: AOAM530HP+oXgSf3t8ADRgqdxluvmEM7M5MA2EtyrKeVhP9E95CujQ2v
        44SWpjx162LEIlcoaDGMpkr4zF1B+CmitkmJlPA=
X-Google-Smtp-Source: ABdhPJy+wpmkGn/cBMOXz+R9oOaKRn7/QkXMqoTKaja1dTLCZFpokixqxoGBDGuQKvM795owh+PENquBzq6Y6Il5PcY=
X-Received: by 2002:a0d:d850:0:b0:2ec:26bb:3468 with SMTP id
 a77-20020a0dd850000000b002ec26bb3468mr8956701ywe.369.1649771575793; Tue, 12
 Apr 2022 06:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220412121541.4595-1-jiangshanlai@gmail.com> <20220412121541.4595-4-jiangshanlai@gmail.com>
 <YlV+B8faRD2lDoO3@zn.tnic>
In-Reply-To: <YlV+B8faRD2lDoO3@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 12 Apr 2022 21:52:44 +0800
Message-ID: <CAJhGHyAsPZAeXUoOa5LJ5bxuMOWzg=cvYNYPVT9kpBM7Tsf3xA@mail.gmail.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 9:26 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 12, 2022 at 08:15:37PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > error_entry() doesn't handle the stack balanced.
>
> What does that mean?

For a normal function, e.g. a function complied from a C function,
the stack will return to its original place when the function
returns.  The size of memory pushed and popped are the same in
a function.

>
> > It includes
> > PUSH_AND_CLEAR_REGS which is commonly needed for all IDT entries and
> > can't pop the regs before it returns.
> >
> > Move PUSH_AND_CLEAR_REGS out of error_entry() and make error_entry()
> > works on the stack normally.
> >
> > After this, XENPV doesn't need error_entry() since PUSH_AND_CLEAR_REGS
> > is moved out and error_entry() can be converted to C code in future
> > since it doesn't fiddle the stack.
>
> This is not a justification for this size increase:
>
>    text    data     bss     dec     hex filename
> 16060616        128131358       36384888        180576862       ac3625e vmlinux.before
> 16065626        128131358       36380792        180577776       ac365f0 vmlinux.after
>
> ~5K text increase already with my tailored config.
>
> You can have a asm_error_entry(), written in asm, which does the regs
> pushing and which calls error_entry() - the latter being the C version.
> And no need for the size increase.

The mapped size for the text is always 2M when the kernel is booted
since it is 2M-aligned.  So I don't think the size is a concern.

The only concern is the footprint when different interrupts and
exceptions happen heavily at the same time.  In this case, different
copies of PUSH_AND_CLEAR_REGS in the text will be touched.

For example, a heavy page fault and IPI or timer at the same time.
I'm not sure if it is a real case.

I'm Okay with asm_error_entry().  And also we can use an ASM function
containing PUSH_AND_CLEAR_REGS only.

Thanks
Lai
