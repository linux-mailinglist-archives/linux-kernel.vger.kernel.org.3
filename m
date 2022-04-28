Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F4512817
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiD1AhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiD1AhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:37:02 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FEB3A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:33:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f7ca2ce255so36599287b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5+Q3gZXu4r7Lxjtdm3RzufMbmVamyBepWBPKpfe+54=;
        b=CAquL0TWsAOOmvdVLr7HEzH9E/8rboJvEiCp8Bd9nF6uBpoxb8pP8HS4WDYgOeLXCu
         vkH82kOPK1ppj/eaHBxr3ZtkVX6ypwCm/hAzwQjaVa3AkEKt1JYF3RWCmrIYBXZNh+mO
         QHmgSS7rbYqRoJ6ythHGT26UJ5mMnU4qx9JJXOdcIot0xe3I+eq1qrv+POUboSChgu59
         ekZX+4uCPCvK22epzNBGJlHEvJGgw0tWpYwwdDv4Nkdk2wFe4EYXz4WYx9skEjIZUoE/
         /Ye3x+EWdd1WUF/NORxKa/jaoZ51ZT1iHF0h+t5fRs2cZuO7OpXiVTzShP2mPh7RzFwS
         VPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5+Q3gZXu4r7Lxjtdm3RzufMbmVamyBepWBPKpfe+54=;
        b=7IgkkPEFgcvPHH5WbV3kXfeJoca+XeUfbCRNQOdcrUeaXD3mRBtM105oRKYu+W5O9b
         wqXOePD/bHbZqBLMqzwsSzXJohxGqn+c+iTKV54EBFQljSLna5J/ljX1BD8A/+QxeRrV
         2tkR7O7OsM12JOn2UDhncrrHE0ydpw+5b878jEFbG2JZ3hjV6LA1NvZk5LI7oH7hPbhk
         EL/a7wllI2/+PP6VueaamfdKRAVc61SKaqOKdlwDod0B6ADRaRZ1E+1clJSnV+BSZDP6
         XlRoSaAkWQMq9KCyfxwQwH1c00rOvx6Pjfp6bGkEetX6M3nTaYIPbS8qVVPvPw3WKQNc
         VPZA==
X-Gm-Message-State: AOAM532T/CjyfyRrWls4Bt/5vPEe4k2rymlTVzR+I4zScZSQ/LxfwIqK
        /WxGYWiRxD/tPENQQHD2X8K78pT5u1BTWt+O8UI=
X-Google-Smtp-Source: ABdhPJxPXxxC4+4rZh63L/7Mh5lOnzqW8LZWDRCxQK130jTohTUm1LQ4yg6lQHBNp+QMA3QarlD/vUm0+FqGKpVp93E=
X-Received: by 2002:a81:c1:0:b0:2f7:d6ae:d0bf with SMTP id 184-20020a8100c1000000b002f7d6aed0bfmr21478231ywa.369.1651106029391;
 Wed, 27 Apr 2022 17:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
 <20220421141055.316239-4-jiangshanlai@gmail.com> <YmmBHABKMk7Ctx46@zn.tnic>
In-Reply-To: <YmmBHABKMk7Ctx46@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 Apr 2022 08:33:36 +0800
Message-ID: <CAJhGHyANWhu-HX20_4XhgACE8tUd8SFa5BTH-ynJscNQ7QxBRw@mail.gmail.com>
Subject: Re: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:45 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 21, 2022 at 10:10:50PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > The macro idtentry calls error_entry() unconditionally even on XENPV.
> > But the code XENPV needs in error_entry() is PUSH_AND_CLEAR_REGS only.
> > And error_entry() also calls sync_regs() which has to deal with the
> > case of XENPV via an extra branch so that it doesn't copy the pt_regs.
>
> What extra branch?
>
> Do you mean the
>
>         if (regs != eregs)
>
> test in sync_regs()?

Hello, Borislav

Yes.

>
> I'm confused. Are you, per chance, aiming to optimize XENPV here or
> what's up?


The branch in sync_regs() can be optimized out for the non-XENPV case
since XENPV doesn't call sync_regs() after patch5 which makes XENPV
not call error_entry().

The aim of this patch and most of the patchset is to make
error_entry() be able to be converted to C.  And XENPV cases can
also be optimized in the patchset although it is not the major main.

>
> > And PUSH_AND_CLEAR_REGS in error_entry() makes the stack not return to
> > its original place when the function returns, which means it is not
> > possible to convert it to a C function.
> >
> > Move PUSH_AND_CLEAR_REGS out of error_entry(), add a function to wrap
> > PUSH_AND_CLEAR_REGS and call it before error_entry().
> >
> > The new function call adds two instructions (CALL and RET) for every
> > interrupt or exception.
>
> Not only - it pushes all the regs in PUSH_AND_CLEAR_REGS too. I don't
> understand why that matters here? It was done in error_entry anyway.
>

Compared to the original code, adding the new function call adds two
instructions (CALL and RET) for every interrupt or exception.

PUSH_AND_CLEAR_REGS is not extra instructions added here.

Since this patch adds extra overhead (CALL and RET), the changelog
has to explain why it is worth it not just for converting ASM to C.

The explanation in the changelog is that it can be offsetted by later
reduced overhead.

Thanks
Lai

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
