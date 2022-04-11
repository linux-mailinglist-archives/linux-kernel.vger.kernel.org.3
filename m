Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4884FBB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbiDKLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiDKLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:51:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAC45AE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:49:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i20so5805637ybj.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kz6JFZV+OqOrLvnEfFNgvxdu+lJ8LAGFGwxHSTTjosQ=;
        b=poChApG5tNbb8yKwQsRsewnMA4Vumdq2UjSN1TH+X6s3li/QsDXiYoFRnjwHA4P0LI
         bSiaU/GvyAlBzygpyxhKN8vjrV5JJRnSK+v0XX2pc/MZI6ehKfxa9wW2Cd3wQxvhONcR
         wXgWbtnfyM6x/u2gOaPb9VBT5wIeBHRS1+CHnKhh1I2PgNEZNV88onItcVn1j+Q40YnK
         Zigvgnix7gj/g3Dj1AnUnaXcGxdhotXmZIJ+mkqR0J98GfDz046eqVMLHg9Fq5LswkDI
         wBVOyQvbCt4PriXa21dClRigawtunbSJN+KO0QJJeouSvwSm4vHaRMYpA4Pm9Fu/9S9e
         7IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kz6JFZV+OqOrLvnEfFNgvxdu+lJ8LAGFGwxHSTTjosQ=;
        b=OiTTgHdfH6AilIqfavCAVmBQKA1OVm3iIXb8xJauSRMRpeEOVhZj+YA9NEwJPJKBPM
         I0lcTbv0cGZzCKL6hU50EGd5HHZ4p5/7Bfx04QKooQG38VeG895flMkIi0EvtKv5zW4A
         TLuQ6oMYaO35pbmUlTjS3oNG0HovXt+nPmlCkBZVgmn3WtHNr/BpapFesfDImbZqPR2+
         5g2a1X952Y4wQneJxzXVEV6xKgNVUulIW94z26dnSPyr8TI1tRX/XVFsYx7zQovlf1kc
         6kqSzSJ1Xko8crdKrNeixSd91Tsjm2rNnLFdZvOXSaViZXbf6pbb4fAbwJ/rzbxe8HCh
         0syw==
X-Gm-Message-State: AOAM530TuqlhCz8wTsRxKR8IduAHILAe4RgxVrI1pV0iS65f+yBEWHkR
        GwATfZ3siCyB1bKm7zZgpTtiOk2BYONDMgNnYEs=
X-Google-Smtp-Source: ABdhPJwTTiEK8dP1cUDgCKJVj625cCs0wdn7lb1onxDdKbpLzwWOyhDlbklPpXQE9oeNuiMyXkg7kzEXf5QLZfO9hio=
X-Received: by 2002:a25:6f82:0:b0:63e:4e0c:90c4 with SMTP id
 k124-20020a256f82000000b0063e4e0c90c4mr16070671ybc.375.1649677739308; Mon, 11
 Apr 2022 04:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-3-jiangshanlai@gmail.com> <YlP2cH/MjxMXuX1W@zn.tnic>
In-Reply-To: <YlP2cH/MjxMXuX1W@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 11 Apr 2022 19:48:48 +0800
Message-ID: <CAJhGHyB+VJb7L4x4mn06h_daTMac=oehhT=J=caO-96ahJqS3g@mail.gmail.com>
Subject: Re: [PATCH V4 2/7] x86/entry: Switch the stack after error_entry() returns
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

On Mon, Apr 11, 2022 at 5:35 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 18, 2022 at 10:30:11PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

>
> > Switching to the stack after error_entry() makes the code simpler and
> > intuitive.
> >
> > The behavior/logic is unchanged:
> >   1) (opt) feed fixup_bad_iret() with the pt_regs pushed by ASM code
>
> opt?

I meant it as optional.

I will rewrite it as

1) feed fixup_bad_iret() with the pt_regs pushed by the ASM code if it
is a fault
caused by bad IRET.

>
> >   2) (opt) fixup_bad_iret() moves the partial pt_regs up
> >   3) feed sync_regs() with the pt_regs pushed by ASM code or returned
> >      by fixup_bad_iret()
> >   4) sync_regs() copies the whole pt_regs to kernel stack if needed
> >   5) after error_entry() and switching %rsp, it is in kernel stack with
> >      the pt_regs


>
> > After this change, error_entry() will not do fancy things with the stack
> > except when in the prolog which will be fixed in the next patch ("move
> > PUSH_AND_CLEAR_REGS out of error_entry").  This patch and the next patch
>
> "This patch" is tautology, as already said.
>
> There's no "next patch" in git.
>
> > can't be swapped because the next patch relies on this patch's stopping
> > fiddling with the return-address of error_entry(), otherwise the objtool
> > would complain.
>
> If that is the case, then those two should me merged into one!

This patch moves the epilog (switching stack) of error_entry() out of
error_entry().  The next patch moves the prolog (pushing pt_regs) out
of error_entry().  They can be separated patches.

I don't think anything wrong if the order of these two patches
is swapped.  Peter Z asked info about the ordering of other patches
and I tried moving the next patch up and saw the complaint from
the objtool.

I wanted to explain the ordering of the patches.  This explanation
should be put in the cover letter instead of in the commit message.

Thanks
Lai
