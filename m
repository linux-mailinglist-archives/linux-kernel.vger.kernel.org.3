Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308D4F76BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiDGHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiDGHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:05:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943723577E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:03:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2eb46d33db9so51234167b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PewzL0T7zp3uXi+3vnmrAWa37j+c658Ndu06ubgZsdY=;
        b=mBjShBy17sHWzFHSTl6RYyi7Qnb/1+klY+K5AjE43pHLuIF6zo9d64jk1NUNFGU9xz
         8ufrzLyGJTtvqdSy7fuC7qdoZHO/xFUhLt8Hox5EVniTokgkDwDZQY5EG/+omm13nF9k
         FP8FWDhgaceqOk8fIw2rdAZKkejLz9tBhSxDcHnRnsROVvry2I1AdRc76yUisliDtRMn
         DMKL5UQUmD7fd3RXAi8vFBCXPDe3mtxG+PLDjz6K4XzXpVD/qyFD3vU96pI37Gri3XYk
         VpjEhqh3oXtcRLDRsWGlTbEKvrirv6tgsjLZQs3IK8eFGECFrDiEG2PAJb7UhdK1Rg+B
         IZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PewzL0T7zp3uXi+3vnmrAWa37j+c658Ndu06ubgZsdY=;
        b=0KGMXbWkw9dVUrC0sByry3YZUCBOieLG/PeI9FFirwSrq5FLFXKd9aQ3WkTl/X98FR
         04ku23d+DqyhRFdjLOWqL17+k1A6AoB355gAS23WIKKp4VlJGaiTpXdvtb4tsdLejzHb
         xeb1/xv+fN/kvQvbMOwHm09Qbpu2euEmz3KnCIDXqTA+ko94d6TCWUPNSI51HenLxV5o
         /GiPmDV6OpVQK9gkgN8nbV0H7fbkff4JhNOBDXZCfhYOX/K6xQzAcb3S1aJ+aaWQ4jlh
         6sI5IHxytUIZ8J6/dJbSvCURatpIiy1r5l7h0Sg8SnoOIpwU6jg3jdWzy9yl//1WqSrK
         6pdQ==
X-Gm-Message-State: AOAM530JVfulS3/NLSMrWeXNIWcSxSnF4D7hlcq685ag8OBmXarVJ5lM
        wraYgSiEn2MZpqhVPpSxncLyWUJaair18jJ3K3w=
X-Google-Smtp-Source: ABdhPJw6Q/sZ0KkUbTBRfa00hknzCPVTMSuaQ0Add5x7Irpt2WzgGdyT1yYEd7FGXN+sPPfEEc7brJGxkqrHiaHeWeY=
X-Received: by 2002:a81:1a03:0:b0:2eb:5222:5e40 with SMTP id
 a3-20020a811a03000000b002eb52225e40mr10191705ywa.231.1649314999558; Thu, 07
 Apr 2022 00:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com> <Yk3jVrXoVpxuR0Mp@zn.tnic>
In-Reply-To: <Yk3jVrXoVpxuR0Mp@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 7 Apr 2022 15:03:08 +0800
Message-ID: <CAJhGHyBFbtyUs-nf0+gWm2a3hiS5BxZ3jk=sbGNw-4ShB8AtzQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 3:00 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Mar 18, 2022 at 10:30:10PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > fixup_bad_iret() and sync_regs() have similar arguments and do similar
> > work that copies full or partial pt_regs to a place and switches stack
> > after return.  They are quite the same, but fixup_bad_iret() not only
> > copies the pt_regs but also the return address of error_entry() while
>
> What return address of error_entry()? You lost me here.

"return address" is the return address of a function which is
error_entry() here.

https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html

Or error_entry_ret in struct bad_iret_stack which is being removed
in the change.


>
> So fixup_bad_iret() gets the stack ptr passed in by doing:
>
>         mov     %rsp, %rdi
>         call    fixup_bad_iret
>         mov     %rax, %rsp
>
>
> and error_regs()
>
>         movq    %rsp, %rdi                      /* arg0 = pt_regs pointer */
>         call    sync_regs
>         movq    %rax, %rsp                      /* switch stack */
>
> the same way.

They are not the same way.

sync_regs() is called before the return address of error_entry()
popped into %r12 while fixup_bad_iret() is called with the return
address of error_entry() still on the stack.  And the primitives of
fixup_bad_iret() and sync_regs() are different which also means
they are not the same way.

After this change, they become the same way.

IMO, sync_regs() is grace while fixup_bad_iret() is a bad C function
or is not a pure C function because it is handling the return address
of its parent function which is better done by the compiler or ASM
code.

>
> Confused.
>
> > It is prepared for later patch to do the stack switch after the
> > error_entry() which simplifies the code further.
>
> Looking at your next patch, is all this dance done just so that you can
> do
>
>         leaq    8(%rsp), %rdi
>
> in order to pass in pt_regs to both functions?
>
> And get rid of the saving/restoring %r12?
>
> Is that what the whole noise is about?

The point is to make fixup_bad_iret() a normal C function and
the same as sync_regs() in calling.

The next patch makes error_entry() as a bunch of ASM code compiled
from a C function and pave the road to really convert it to a C
function.

Getting rid of the saving/restoring the return address in %r12
is necessary since a C function can't save/restore the return
address.

Thanks
Lai

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

I'm sorry for using top-posting and "This patch".  I remember it.
